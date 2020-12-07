Return-Path: <SRS0=GTcZ=FL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4ADC433FE
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 10:25:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20E92311A
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 10:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20E92311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AEC328619E;
	Mon,  7 Dec 2020 10:25:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9biRRNec3Ad6; Mon,  7 Dec 2020 10:25:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 309148614E;
	Mon,  7 Dec 2020 10:25:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17B73C0FA7;
	Mon,  7 Dec 2020 10:25:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6919DC013B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 10:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5D8E786E01
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 10:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kuQRgL9tpLpw for <iommu@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 10:25:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D8F6586E00
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 10:25:03 +0000 (UTC)
Date: Mon, 7 Dec 2020 10:24:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607336703;
 bh=D4jvLiuo5MBwNTSdal71W3VOvzvsyAS1r5K6BlDOzNU=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cy4Whju3D3VrIcAcqnFEQuLw3LvJoXbI4U4WtTfD47xpDQx2xYnP3hkF8/mIWL/sA
 YFZ+iaFHLh3pPvHkebEHDl+19UwZPL3UdCY1ofbUv1jqxV82sTg4sqwArY5IPTVSQj
 lnE6ntCsmo7KEz2WvbKkOn4nAPEZXdUQk9oFz8m33uQ23C09LcTvU3lsCBfP0BM29X
 kSj8wmY73QVOHVJuR2t2exNhVEL3sSPa289ORAx7hb4CuJex5SFKjY08S1xJVPfVCH
 mgzoLMcwigRd0mA8vMs67wnu5wCeT5IJmf2r6/QK3OOKMoP3DhFDi2n3YDBuRzzGrm
 4L3LjjjFHgytA==
From: Will Deacon <will@kernel.org>
To: Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: [PATCH] iommu/io-pgtalbe-arm: Remove "iopte_type(pte, l)" extra
 parameter "l"
Message-ID: <20201207102458.GB3825@willie-the-truck>
References: <20201207081404.1699-1-jiangkunkun@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201207081404.1699-1-jiangkunkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Keqian Zhu <zhukeqian1@huawei.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 wanghaibin.wang@huawei.com, Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
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

On Mon, Dec 07, 2020 at 04:14:04PM +0800, Kunkun Jiang wrote:
> Knowing from the code, the macro "iopte_type(pte, l)" doesn't use the
> parameter "l" (level). So we'd better to remove it.
> 
> Fixes: e1d3c0fd701df(iommu: add ARM LPAE page table allocator)
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index a7a9bc08dcd1..925ae2b713d6 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -130,7 +130,7 @@
>  /* IOPTE accessors */
>  #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
>  
> -#define iopte_type(pte,l)					\
> +#define iopte_type(pte)					\
>  	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)

Shouldn't we update all the users of the macro too?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
