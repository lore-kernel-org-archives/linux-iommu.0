Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A384CC43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:07:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA7920675
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA7920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5782A27F2;
	Fri, 26 Apr 2019 15:07:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EE08A27E6
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:04:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8113382A
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:04:53 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id BF769227A81; Fri, 26 Apr 2019 17:04:34 +0200 (CEST)
Date: Fri, 26 Apr 2019 17:04:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
Message-ID: <20190426150433.GA19930@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
	<20190421011719.14909-3-baolu.lu@linux.intel.com>
	<20190422164555.GA31181@lst.de>
	<0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com>
	<20190423061232.GB12762@lst.de>
	<dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
	<20190424144532.GA21480@lst.de>
	<a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: kevin.tian@intel.com, mika.westerberg@linux.intel.com, ashok.raj@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	pengfei.xu@intel.com, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190426150433.5BXDFO83_KoVuwcM0fGuUr86kBCNsweVvrXFjG8RKmY@z>

On Thu, Apr 25, 2019 at 10:07:19AM +0800, Lu Baolu wrote:
> This is not VT-d specific. It's just how generic IOMMU works.
>
> Normally, IOMMU works in paging mode. So if a driver issues DMA with
> IOVA  0xAAAA0123, IOMMU can remap it with a physical address 0xBBBB0123.
> But we should never expect IOMMU to remap 0xAAAA0123 with physical
> address of 0xBBBB0000. That's the reason why I said that IOMMU will not
> work there.

Well, with the iommu it doesn't happen.  With swiotlb it obviosuly
can happen, so drivers are fine with it.  Why would that suddenly
become an issue when swiotlb is called from the iommu code?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
