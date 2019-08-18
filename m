Return-Path: <SRS0=WGHm=WO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57646C3A59B
	for <iommu@archiver.kernel.org>; Sun, 18 Aug 2019 03:08:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F52C2089C
	for <iommu@archiver.kernel.org>; Sun, 18 Aug 2019 03:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F52C2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C2C88B59;
	Sun, 18 Aug 2019 03:08:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EF47BACC
	for <iommu@lists.linux-foundation.org>;
	Sun, 18 Aug 2019 03:08:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7AEAEE5
	for <iommu@lists.linux-foundation.org>;
	Sun, 18 Aug 2019 03:08:40 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Aug 2019 20:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,399,1559545200"; d="scan'208";a="171787363"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga008.jf.intel.com with ESMTP; 17 Aug 2019 20:08:34 -0700
Subject: Re: [PATCH v6 5/8] iommu: Add bounce page APIs
To: Christoph Hellwig <hch@lst.de>
References: <20190730045229.3826-1-baolu.lu@linux.intel.com>
	<20190730045229.3826-6-baolu.lu@linux.intel.com>
	<20190814083842.GB22669@8bytes.org>
	<445624e7-eb57-8089-8eb3-8687a65b1258@linux.intel.com>
	<20190815154845.GA18327@8bytes.org>
	<ec1dc4e2-626c-9c12-f17c-b51420fc2e81@linux.intel.com>
	<20190816044613.GC4093@lst.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1eea1895-5063-ff33-1dd3-50371d03b3c8@linux.intel.com>
Date: Sun, 18 Aug 2019 11:07:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816044613.GC4093@lst.de>
Content-Language: en-US
Cc: alan.cox@intel.com, Stefano Stabellini <sstabellini@kernel.org>,
	ashok.raj@intel.com, Jonathan Corbet <corbet@lwn.net>,
	pengfei.xu@intel.com, Ingo Molnar <mingo@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com, Alan Cox <alan@linux.intel.com>,
	Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mika Westerberg <mika.westerberg@intel.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	jacob.jun.pan@intel.com, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On 8/16/19 12:46 PM, Christoph Hellwig wrote:
> On Fri, Aug 16, 2019 at 10:45:13AM +0800, Lu Baolu wrote:
>> Okay. I understand that adding these APIs in iommu.c is not a good idea.
>> And, I also don't think merging the bounce buffer implementation into
>> iommu_map() is feasible since iommu_map() is not DMA API centric.
>>
>> The bounce buffer implementation will eventually be part of DMA APIs
>> defined in dma-iommu.c, but currently those APIs are not ready for x86
>> use yet. So I will put them in iommu/vt-d driver for this time being and
>> will move them to dma-iommu.c later.
> 
> I think they are more or less ready actually, we just need more people
> reviewing the conversions.  Tom just reposted the AMD one which will need
> a few more reviews, and he has an older patchset for intel-iommu as well
> that could use a some more eyes.
> 

Good progress and thanks for the update. I prefer that we merge this
patch series first since it addresses the real thunderbolt
vulnerability.

Best regards,
Lu Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
