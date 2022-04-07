Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32182C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 13:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEBFB61208;
	Thu,  7 Apr 2022 13:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NtgW7bYhJgB4; Thu,  7 Apr 2022 13:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C3A5260F16;
	Thu,  7 Apr 2022 13:41:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96229C002C;
	Thu,  7 Apr 2022 13:41:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93273C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73DAA83FA9
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:41:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hfi4sjl-RWU9 for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 13:41:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD4E583FA4
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=74PS8gP8R7QSv7wDPjxMrGmI/chpbWr92QAHIh9FKHQ=; b=IkEHrck5evsyXCvHJjhJFDqRe7
 MKO4XbmW1buUih3ZFgYRb+doKN2RDmupP3AtpfjaSAvRxJBSJ6Kq5eILoGdRBkllRwMckLuLlTdw1
 IejvFTj3E4nxW3OrdBOkSAj7dDTJMbj9aPKzR+J9hcwy1kczQeCsXFCXLDJ8jscKrXFJ1HqFeJTyG
 XK3GnMYtx24bwuLTwd474UEXgIeZcMP9cviBdDt5xGgUM+eh4B3AMyFgtYbUCPvUx2/DH+3Y1jWgq
 BPfSAVO0NuwqPxVNWiE1pr7sqv9/ieP+7IvvDpUuCMxG2ovM4PPzGnh/2LVFcu5P9p9e4s5804xqt
 gHJwozxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ncSNp-00CCNM-SL; Thu, 07 Apr 2022 13:41:09 +0000
Date: Thu, 7 Apr 2022 06:41:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Enable swiotlb in all cases
Message-ID: <Yk7p9fhIhvaHw9dF@infradead.org>
References: <20220404204723.9767-1-mario.limonciello@amd.com>
 <20220404204723.9767-2-mario.limonciello@amd.com>
 <f7039f1f-81ef-2fab-4ade-728316b54942@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f7039f1f-81ef-2fab-4ade-728316b54942@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Hegde Vasant <Vasant.Hegde@amd.com>,
 open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>, Will Deacon <will@kernel.org>
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

On Thu, Apr 07, 2022 at 02:31:44PM +0100, Robin Murphy wrote:
> FWIW it's also broken for another niche case where
> iommu_default_passthrough() == false at init, but the user later changes a
> 32-bit device's default domain type to passthrough via sysfs, such that it
> starts needing regular dma-direct bouncing.

Yeah.

We also have yet another issue:  swiotlb is not allocate if there is
no memory outside the 4GB physical address space.  I think I can fix
that easily after my swiotlb init series goes in, before that it
would be a bit of a mess spread over all the architectures.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
