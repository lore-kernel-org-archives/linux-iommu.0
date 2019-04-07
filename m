Return-Path: <SRS0=ZMNw=SJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D1AC10F0E
	for <iommu@archiver.kernel.org>; Sun,  7 Apr 2019 06:59:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B59C20896
	for <iommu@archiver.kernel.org>; Sun,  7 Apr 2019 06:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B59C20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D5CB2ACD;
	Sun,  7 Apr 2019 06:59:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 220B9481
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Apr 2019 06:59:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A914263D
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Apr 2019 06:59:36 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id B7D2A67329; Sun,  7 Apr 2019 08:59:23 +0200 (CEST)
Date: Sun, 7 Apr 2019 08:59:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/21] arm64/iommu: improve mmap bounds checking
Message-ID: <20190407065923.GA9086@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-3-hch@lst.de>
	<3629087c-a8cb-d66e-840b-cfee125bdf4c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3629087c-a8cb-d66e-840b-cfee125bdf4c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org
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
Message-ID: <20190407065923.WyTsS05gsHST-8xpTQ6M1DBMSOjOsWTPWSoOnXD8zHY@z>

On Fri, Apr 05, 2019 at 06:30:52PM +0100, Robin Murphy wrote:
> On 27/03/2019 08:04, Christoph Hellwig wrote:
>> The nr_pages checks should be done for all mmap requests, not just those
>> using remap_pfn_range.
>
> Hmm, the logic in iommu_dma_mmap() inherently returns an error for the "off 
> >= nr_pages" case already. It's also supposed to be robust against the 
> "vma_pages(vma) > nr_pages - off" condition, although by making the partial 
> mapping and treating it as a success, rather than doing nothing and 
> returning an error. What's the exact motivation here?

Have one error check at the front of the function that is identical
to the mmap checks in the other dma_map_ops instances so that:

 a) we get the same error behavior for partial requests everywhere
 b) we can lift these checks into common code in the next round.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
