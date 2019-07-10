Return-Path: <SRS0=bDbm=VH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C035C74A2B
	for <iommu@archiver.kernel.org>; Wed, 10 Jul 2019 14:46:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A1920651
	for <iommu@archiver.kernel.org>; Wed, 10 Jul 2019 14:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBR7Me1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A1920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EE7AC4589;
	Wed, 10 Jul 2019 14:46:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E8D404572
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 14:36:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7F08C893
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 14:36:57 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1998D20651;
	Wed, 10 Jul 2019 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562769417;
	bh=JpLBi/wvSqPSVyE7XiTBNxyTryULw8xtjJ4a7enA2+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBR7Me1MIN0v9K0+Jn0Agboor87D+JAELf7o39AuQiGedDSI9g6Hb3ynHzfYMpP57
	r6gKH89Gk5AevaNGtflTPMQvg26XFy4vcVl7Ctahl8iLClpyT/LXiS4XccwGZ3nojX
	wsVgfmjZewYJnpQsbQzxPL59Mn3/jUtRue0cowJ4=
Date: Wed, 10 Jul 2019 15:36:50 +0100
From: Will Deacon <will@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v8 07/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
	Mode
Message-ID: <20190710143649.w5dplhzdpi3bxp7e@willie-the-truck>
References: <1561774167-24141-1-git-send-email-yong.wu@mediatek.com>
	<1561774167-24141-8-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1561774167-24141-8-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	yingjoe.chen@mediatek.com, anan.sun@mediatek.com,
	Robin Murphy <robin.murphy@arm.com>, Matthias Kaehlcke <mka@chromium.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Sat, Jun 29, 2019 at 10:09:13AM +0800, Yong Wu wrote:
> MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> 
> In the mt2712 and mt8173, it's called "4GB mode", the physical address
> is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> bit32 is always enabled. thus, in the M4U, we always enable the bit9
> for all PTEs which means to enable bit32 of physical address.
> 
> but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
> which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
> PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
> 32bits.

What happens if bit4 is set in the pte for mt2712 or mt8173? Perhaps the
io-pgtable backend should be allowing oas > 32 when
IO_PGTABLE_QUIRK_ARM_MTK_4GB is set, and then enforcing that itself.

> In order to unify code, in the "4GB mode", we add the bit32 for the
> physical address manually in our driver.
> 
> Correspondingly, Adding bit32 and bit33 for the PA in the iova_to_phys
> has to been moved into v7s.
> 
> Regarding whether the pagetable address could be over 4GB, the mt8183
> support it while the previous mt8173 don't. thus keep it as is.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
> Comparing with the previous one:
> 1). Add a new patch "iommu/mediatek: Fix iova_to_phys PA start for 4GB
> mode" before this one. Thus rebase it.
> A little difference: in the 4gb mode, we add bit32 for PA. and the PA got
> from iova_to_phys always have bit32 here, thus we should adjust it to locate
> the valid pa.
> 2). Add this code suggested from Evan.
>  if (!data->plat_data->has_4gb_mode)
> 	       data->enable_4GB = false;
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 31 ++++++++++++++++++++++++-------
>  drivers/iommu/mtk_iommu.c          | 29 ++++++++++++++++++-----------
>  drivers/iommu/mtk_iommu.h          |  1 +
>  3 files changed, 43 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 94c38db..4077822 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -123,7 +123,9 @@
>  #define ARM_V7S_TEX_MASK		0x7
>  #define ARM_V7S_ATTR_TEX(val)		(((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
>  
> -#define ARM_V7S_ATTR_MTK_4GB		BIT(9) /* MTK extend it for 4GB mode */
> +/* MediaTek extend the two bits below for over 4GB mode */
> +#define ARM_V7S_ATTR_MTK_PA_BIT32	BIT(9)
> +#define ARM_V7S_ATTR_MTK_PA_BIT33	BIT(4)
>  
>  /* *well, except for TEX on level 2 large pages, of course :( */
>  #define ARM_V7S_CONT_PAGE_TEX_SHIFT	6
> @@ -190,13 +192,22 @@ static dma_addr_t __arm_v7s_dma_addr(void *pages)
>  static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
>  				    struct io_pgtable_cfg *cfg)
>  {
> -	return paddr & ARM_V7S_LVL_MASK(lvl);
> +	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> +
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> +		if (paddr & BIT_ULL(32))
> +			pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
> +		if (paddr & BIT_ULL(33))
> +			pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> +	}
> +	return pte;
>  }
>  
>  static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
>  				  struct io_pgtable_cfg *cfg)
>  {
>  	arm_v7s_iopte mask;
> +	phys_addr_t paddr;
>  
>  	if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
>  		mask = ARM_V7S_TABLE_MASK;
> @@ -205,7 +216,14 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
>  	else
>  		mask = ARM_V7S_LVL_MASK(lvl);
>  
> -	return pte & mask;
> +	paddr = pte & mask;
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> +			paddr |= BIT_ULL(32);
> +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> +			paddr |= BIT_ULL(33);
> +	}
> +	return paddr;

I think this relies on CONFIG_PHYS_ADDR_T_64BIT, which isn't always set on
32-bit ARM.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
