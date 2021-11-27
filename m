Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CAAC433EF
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 02:47:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA109409B2;
	Sat, 27 Nov 2021 02:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oxYDYv_8oA1M; Sat, 27 Nov 2021 02:47:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4ADCE409AE;
	Sat, 27 Nov 2021 02:47:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 203FCC0012;
	Sat, 27 Nov 2021 02:47:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83907C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 02:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AFAF409B0
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 02:46:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yWtTc42EVgps for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 02:46:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7123C409AE
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 02:46:51 +0000 (UTC)
X-UUID: 424fd6bf6977401d9759dd1f4bd3dce0-20211127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Xwnnc0yRrgLNUO+A6mfKrlsVJTbuBikrg6HCN5kbh9s=; 
 b=iL1hYK/BhAnlDgiIzvxlvV+71SQQZX5rbpFfOcCt6YAA3hR33ZYtF56/IjCI8vMAHfSho9F7612Hh2MY0yDJvQLNUjXUcfImDmC9mfDWCBlKEZelsgJQQ9mGO3fyEuoeUiC8DvP+KSYfi7EAjXKfstFF8Yab8FQZdvb41B0ThUs=;
X-UUID: 424fd6bf6977401d9759dd1f4bd3dce0-20211127
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2108519851; Sat, 27 Nov 2021 10:46:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Sat, 27 Nov 2021 10:46:45 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 27 Nov 2021 10:46:44 +0800
Message-ID: <6abef78f6447c626b737fd35688f421c29871f43.camel@mediatek.com>
Subject: Re: [PATCH 1/2] iommu/mediatek: Always tlb_flush_all when each PM
 resume
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Date: Sat, 27 Nov 2021 10:46:44 +0800
In-Reply-To: <20211122104400.4160-2-dafna.hirschfeld@collabora.com>
References: <20211122104400.4160-1-dafna.hirschfeld@collabora.com>
 <20211122104400.4160-2-dafna.hirschfeld@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: open list <linux-kernel@vger.kernel.org>, sebastian.reichel@collabora.com,
 iommu@lists.linux-foundation.org, "moderated
 list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 Will Deacon <will@kernel.org>, "moderated
 list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
 linux-media@vger.kernel.org
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

Hi Dafna,

Sorry for reply late.

On Mon, 2021-11-22 at 12:43 +0200, Dafna Hirschfeld wrote:
> From: Yong Wu <yong.wu@mediatek.com>
> 
> Prepare for 2 HWs that sharing pgtable in different power-domains.
> 
> When there are 2 M4U HWs, it may has problem in the flush_range in
> which
> we get the pm_status via the m4u dev, BUT that function don't reflect
> the
> real power-domain status of the HW since there may be other HW also
> use
> that power-domain.
> 
> The function dma_alloc_attrs help allocate the iommu buffer which
> need the corresponding power domain since tlb flush is needed when
> preparing iova. BUT this function only is for allocating buffer,
> we have no good reason to request the user always call pm_runtime_get
> before calling dma_alloc_xxx. Therefore, we add a tlb_flush_all
> in the pm_runtime_resume to make sure the tlb always is clean.
> 
> Another solution is always call pm_runtime_get in the
> tlb_flush_range.
> This will trigger pm runtime resume/backup so often when the iommu
> power is not active at some time(means user don't call pm_runtime_get
> before calling dma_alloc_xxx), This may cause the performance drop.
> thus we don't use this.
> 
> In other case, the iommu's power should always be active via device
> link with smi.
> 
> The previous SoC don't have PM except mt8192. the mt8192 IOMMU is
> display's
> power-domain which nearly always is enabled. thus no need fix tags
> here.
> Prepare for mt8195.

In this patchset, this message should be not proper. I think you could
add the comment why this patch is needed in mt8173.

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> [imporvie inline doc]
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  drivers/iommu/mtk_iommu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 25b834104790..28dc4b95b6d9 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -964,6 +964,13 @@ static int __maybe_unused
> mtk_iommu_runtime_resume(struct device *dev)
>  		return ret;
>  	}
>  
> +	/*
> +	 * Users may allocate dma buffer before they call
> pm_runtime_get,
> +	 * in which case it will lack the necessary tlb flush.
> +	 * Thus, make sure to update the tlb after each PM resume.
> +	 */
> +	mtk_iommu_tlb_flush_all(data);

This should not work. since current the *_tlb_flush_all call
pm_runtime_get_if_in_use which will always return 0 when it called from
this runtime_cb in my test. thus, It won't do the tlb_flush_all
actually.

I guess this also depend on these two patches of mt8195 v3.
[PATCH v3 09/33] iommu/mediatek: Remove for_each_m4u in tlb_sync_all
[PATCH v3 10/33] iommu/mediatek: Add tlb_lock in tlb_flush_all

like in [10/33], I added a mtk_iommu_tlb_do_flush_all which don't have
the pm operation.

This looks has a dependence. Let me know if I can help this.

> +
>  	/*
>  	 * Uppon first resume, only enable the clk and return, since
> the values of the
>  	 * registers are not yet set.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
