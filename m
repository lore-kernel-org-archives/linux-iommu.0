Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FFAC433E3
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 09:01:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62F12087D
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 09:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f798jvHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62F12087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 70DAB204CF;
	Fri, 21 Aug 2020 09:01:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id If7208lU81tv; Fri, 21 Aug 2020 09:01:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C50D1203E4;
	Fri, 21 Aug 2020 09:01:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE26CC07FF;
	Fri, 21 Aug 2020 09:01:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02043C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 09:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E37FA86D08
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 09:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id og6qgZc9kSWS for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 09:01:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0FBCA86D02
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 09:01:22 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7DF6C20578;
 Fri, 21 Aug 2020 09:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598000481;
 bh=PGxw16Sb15h4INR8rVD1HKJzCXHduThJtSaBTgYEwQc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f798jvHppuLjWlvS5plc4g84ly/Jkcfa4C7HL9B7ytEenJk95uzyKx44D5wL25KH0
 9W9yuKvfjYApvHGKh9Vjwqn+0d/ea93GtAdK8xnzlLdVQdGpI+tNFC4besQOJtfaFE
 TEYT+mr5RWQw3VXjZXrYoE6sm2dLC+MlCIiPSdxk=
Date: Fri, 21 Aug 2020 10:01:16 +0100
From: Will Deacon <will@kernel.org>
To: Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v6 2/2] arm64: mm: reserve per-numa CMA to localize
 coherent dma buffers
Message-ID: <20200821090116.GB20255@willie-the-truck>
References: <20200821022615.28596-1-song.bao.hua@hisilicon.com>
 <20200821022615.28596-3-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200821022615.28596-3-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mike Rapoport <rppt@linux.ibm.com>, Steve Capper <steve.capper@arm.com>,
 catalin.marinas@arm.com, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, ganapatrao.kulkarni@cavium.com,
 Andrew Morton <akpm@linux-foundation.org>, huangdaode@huawei.com,
 robin.murphy@arm.com, hch@lst.de, linux-arm-kernel@lists.infradead.org
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

On Fri, Aug 21, 2020 at 02:26:15PM +1200, Barry Song wrote:
> Right now, smmu is using dma_alloc_coherent() to get memory to save queues
> and tables. Typically, on ARM64 server, there is a default CMA located at
> node0, which could be far away from node2, node3 etc.
> with this patch, smmu will get memory from local numa node to save command
> queues and page tables. that means dma_unmap latency will be shrunk much.
> Meanwhile, when iommu.passthrough is on, device drivers which call dma_
> alloc_coherent() will also get local memory and avoid the travel between
> numa nodes.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  -v6: rebase on top of 5.9-rc1
> 
>  arch/arm64/mm/init.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 481d22c32a2e..f1c75957ff3c 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -429,6 +429,8 @@ void __init bootmem_init(void)
>  	arm64_hugetlb_cma_reserve();
>  #endif
>  
> +	dma_pernuma_cma_reserve();

I think will have to do for now, but I still wish that more of this was
driven from the core code so that we don't have to worry about
initialisation order and whether things are early/late enough on a per-arch
basis.

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
