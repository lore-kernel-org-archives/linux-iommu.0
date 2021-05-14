Return-Path: <SRS0=wlUX=KJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2558AC433ED
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 16:15:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A3661454
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 16:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A3661454
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6154841840;
	Fri, 14 May 2021 16:15:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vR9SwruY6fd4; Fri, 14 May 2021 16:15:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29E1C41843;
	Fri, 14 May 2021 16:15:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02A37C000E;
	Fri, 14 May 2021 16:15:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CAA9C0001
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 16:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05FDF83C66
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 16:15:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ETdqlJB218MQ for <iommu@lists.linux-foundation.org>;
 Fri, 14 May 2021 16:15:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 82F2C843DD
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 16:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=8mPdRqweUyDLPmZFuViN51lMyyF6RcsMDP/27vYhzgo=; b=U+OPhYGBE7d5nwlGLwZsALzoro
 3tgyDKF/0JnvDnEhiVty+7KLtudPXGsgdLrXK8kYa1UhRxLVYx5DTHvguR2b2SxqVbUGMOinTz5RG
 MaiKBrvV+aFk8n5JKHIpqq0/+O13MOf6raVLj/ytmq6kFn5OoOGeKnMdZV7srdp5EypPDRzRNnvDt
 Xcx+TrldLjB0CdBFWcHNA4i8QC6d1CT/44a9DZFyyrmkyCerhqDEyUgv2VGtTRFpKTv3RSlewLnZy
 ZjgSDqhOMfyPwZfy59y4RAtucHTLNIX3hzhpPDgPTeL+UzDpvLPANK7ryKC925sZWizH3oNMMS0fQ
 rpj+1uKw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lhaTO-00065v-3k; Fri, 14 May 2021 10:15:35 -0600
To: Christoph Hellwig <hch@lst.de>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-7-logang@deltatee.com> <20210514134900.GA4715@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e1407362-26fe-09db-0964-acfbb45c032c@deltatee.com>
Date: Fri, 14 May 2021 10:15:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514134900.GA4715@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 06/22] PCI/P2PDMA: Attempt to set map_type if it has
 not been set
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021-05-14 7:49 a.m., Christoph Hellwig wrote:
> On Thu, May 13, 2021 at 04:31:47PM -0600, Logan Gunthorpe wrote:
>> Attempt to find the mapping type for P2PDMA pages on the first
>> DMA map attempt if it has not been done ahead of time.
>>
>> Previously, the mapping type was expected to be calculated ahead of
>> time, but if pages are to come from userspace then there's no
>> way to ensure the path was checked ahead of time.
>>
>> With this change it's no longer invalid to call pci_p2pdma_map_sg()
>> before the mapping type is calculated so drop the WARN_ON when that
>> is the case.
> 
> Why?

Before this change, the if the mapping type wasn't already calculated
pci_p2pdma_map_sg() would just fail. This was fine for NVMe-of as it
always called pci_p2pdma_distance() ahead of time which calculated the
mapping type, stored it in the xarray and did not proceed if the two
devices could not talk to each other.

This patch makes it so if the mapping type is not already calculated at
dma map time, it does the calculation. This means the dma map operation
can fail if the two devices aren't able to talk to each other.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
