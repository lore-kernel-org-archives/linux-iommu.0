Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A615C43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 05:18:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCD42075E
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 05:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCD42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1171B1DED;
	Mon, 29 Apr 2019 05:18:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9E2CB1DE7
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 05:16:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 24E05608
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 05:16:38 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 Apr 2019 22:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; d="scan'208";a="295363562"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga004.jf.intel.com with ESMTP; 28 Apr 2019 22:16:34 -0700
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
To: Christoph Hellwig <hch@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
	<20190421011719.14909-3-baolu.lu@linux.intel.com>
	<20190422164555.GA31181@lst.de>
	<0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com>
	<20190423061232.GB12762@lst.de>
	<dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
	<20190424144532.GA21480@lst.de>
	<a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com>
	<20190426150433.GA19930@lst.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <93b3d627-782d-cae0-2175-77a5a8b3fe6e@linux.intel.com>
Date: Mon, 29 Apr 2019 13:10:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426150433.GA19930@lst.de>
Content-Language: en-US
Cc: kevin.tian@intel.com, mika.westerberg@linux.intel.com, ashok.raj@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	pengfei.xu@intel.com, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429051017._D5YTuRjhzfKEKNHcUVys6qIec9p8q3kTxDEEntel2w@z>

Hi Christoph,

On 4/26/19 11:04 PM, Christoph Hellwig wrote:
> On Thu, Apr 25, 2019 at 10:07:19AM +0800, Lu Baolu wrote:
>> This is not VT-d specific. It's just how generic IOMMU works.
>>
>> Normally, IOMMU works in paging mode. So if a driver issues DMA with
>> IOVA  0xAAAA0123, IOMMU can remap it with a physical address 0xBBBB0123.
>> But we should never expect IOMMU to remap 0xAAAA0123 with physical
>> address of 0xBBBB0000. That's the reason why I said that IOMMU will not
>> work there.
> 
> Well, with the iommu it doesn't happen.  With swiotlb it obviosuly
> can happen, so drivers are fine with it.  Why would that suddenly
> become an issue when swiotlb is called from the iommu code?
> 

I would say IOMMU is DMA remapping, not DMA engine. :-)

Best regards,
Lu Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
