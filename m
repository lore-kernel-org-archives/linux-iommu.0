Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E94C433DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 15:20:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCF420715
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 15:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urR+1hUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCF420715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 13F4988A54;
	Mon,  6 Jul 2020 15:20:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BwkGEP0oxPfo; Mon,  6 Jul 2020 15:20:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8054F872F8;
	Mon,  6 Jul 2020 15:20:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4981BC0893;
	Mon,  6 Jul 2020 15:20:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F375C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 15:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5B756888F2
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 15:20:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w7FIoBL7GZ+Q for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 15:20:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 25F5F872F8
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 15:20:08 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id g75so39835046wme.5
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wWqFCWab5V+PgCc43vygNWCupQwOkfTJ/Ga2rPKOnQY=;
 b=urR+1hUOUq6ElH5pG/gi/B4VoIJN5CyC1DDNfGpXl4l3cO8+JlCr23DIZ8RVmkDt1W
 zrZPY/RW1ICxxzk9zwOebj8TCeMlXpVm7cr4/pTCXQUGvVnNa2e7QTjU2dBCjiMpuxvJ
 pWoacpA3WRuQIETyV4qBNPfTbumR9l31NMs4mDzqcemqhDXB7HByjUvcS8ZKTyPk0nTG
 uUlBhkLsRIfnsH45EvFaaf4OX8o6YR3ysraov3FBjB9RSw7FtZe+ANkJp0qTl6gEmtkk
 o6+tpI7Txj9IQ9OC5AHfesN+q9aeP+gC4eOwW4YwyDxiY++dw48DjYv6yU3qR9EKLe0c
 SGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=wWqFCWab5V+PgCc43vygNWCupQwOkfTJ/Ga2rPKOnQY=;
 b=ZK9tVQJ0Aq1KDDd9yPK4NzY6YTDP/BWMsfD2eGH9B7drmKUxn4qMlqulPtUm1uP2id
 MCXk4FcRb8MWRTYSQdaBEW96Yf6QrpbKGHADAxYOD6pHW34WQfZTpxKXar5QFDI+76YC
 1jT+L1y4rVoIZitC+HGN+2YTQDU7BCqTYu6zT/jGKPydecBrHYzwWLLaa6QqGRCPq9Ev
 IgzW820JA5JkECAecyp3vba0FmWneKUx7g6povbH4o6bS1FjBV9Glb0LPh57mKNv7gsp
 1fV3m4OXgBEa2dPz3fc3xtBswL8i3hibFF5gzlok9KlluruJwtzzZCIAlOe78/COjeeM
 z7qw==
X-Gm-Message-State: AOAM533beNNljz0Bh1oPqQXGAP4Y5wdXpSbZvX+2XQ3Q5RzzGrWTcYYO
 2uDVmCYDcPkdSZVrECLNdS8=
X-Google-Smtp-Source: ABdhPJz+P4pDt8LzP1vsKXAHFJVo/Gr58eHipMqAHZp2Q8uhOp8Bn3Fv37B3TrJ2uaDb8uqiK4TpbA==
X-Received: by 2002:a1c:9cd4:: with SMTP id f203mr4125212wme.155.1594048806424; 
 Mon, 06 Jul 2020 08:20:06 -0700 (PDT)
Received: from ziggy.stardust (81.172.57.81.dyn.user.ono.com. [81.172.57.81])
 by smtp.gmail.com with ESMTPSA id
 26sm23775565wmj.25.2020.07.06.08.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 08:20:05 -0700 (PDT)
Subject: Re: [PATCH v6 06/10] iommu/mediatek: Add sub_comm id in translation
 fault
To: Chao Hao <chao.hao@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
 <20200703044127.27438-7-chao.hao@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9f05e20f-fec5-de3a-d069-d7835873380a@gmail.com>
Date: Mon, 6 Jul 2020 17:20:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200703044127.27438-7-chao.hao@mediatek.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, TH Yang <th.yang@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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



On 03/07/2020 06:41, Chao Hao wrote:
> The max larb number that a iommu HW support is 8(larb0~larb7 in the below
> diagram).
> If the larb's number is over 8, we use a sub_common for merging
> several larbs into one larb. At this case, we will extend larb_id:
> bit[11:9] means common-id;
> bit[8:7] means subcommon-id;
> From these two variables, we could get the real larb number when
> translation fault happen.
> The diagram is as below:
> 		 EMI
> 		  |
> 		IOMMU
> 		  |
>            -----------------
> 	   |               |
> 	common1   	common0
> 	   |		   |
> 	   -----------------
> 		  |
>              smi common
> 		  |
>   ------------------------------------
>   |       |       |       |     |    |
>  3'd0    3'd1    3'd2    3'd3  ...  3'd7   <-common_id(max is 8)
>   |       |       |       |     |    |
> Larb0   Larb1     |     Larb3  ... Larb7
> 		  |
> 	    smi sub common
> 		  |
>      --------------------------
>      |        |       |       |
>     2'd0     2'd1    2'd2    2'd3   <-sub_common_id(max is 4)
>      |        |       |       |
>    Larb8    Larb9   Larb10  Larb11
> 
> In this patch we extend larb_remap[] to larb_remap[8][4] for this.
> larb_remap[x][y]: x means common-id above, y means subcommon_id above.
> 
> We can also distinguish if the M4U HW has sub_common by HAS_SUB_COMM
> macro.
> 
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/iommu/mtk_iommu.c | 21 ++++++++++++++-------
>  drivers/iommu/mtk_iommu.h |  5 ++++-
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 533b8f76f592..0d96dcd8612b 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -91,6 +91,8 @@
>  #define REG_MMU1_INVLD_PA			0x148
>  #define REG_MMU0_INT_ID				0x150
>  #define REG_MMU1_INT_ID				0x154
> +#define F_MMU_INT_ID_COMM_ID(a)			(((a) >> 9) & 0x7)
> +#define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
>  #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
>  #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
>  
> @@ -109,6 +111,7 @@
>  #define HAS_VLD_PA_RNG			BIT(2)
>  #define RESET_AXI			BIT(3)
>  #define OUT_ORDER_WR_EN			BIT(4)
> +#define HAS_SUB_COMM			BIT(5)
>  
>  #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
>  		((((pdata)->flags) & (_x)) == (_x))
> @@ -239,7 +242,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>  	struct mtk_iommu_data *data = dev_id;
>  	struct mtk_iommu_domain *dom = data->m4u_dom;
>  	u32 int_state, regval, fault_iova, fault_pa;
> -	unsigned int fault_larb, fault_port;
> +	unsigned int fault_larb, fault_port, sub_comm = 0;
>  	bool layer, write;
>  
>  	/* Read error info from registers */
> @@ -255,10 +258,14 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>  	}
>  	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
>  	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
> -	fault_larb = F_MMU_INT_ID_LARB_ID(regval);
>  	fault_port = F_MMU_INT_ID_PORT_ID(regval);
> -
> -	fault_larb = data->plat_data->larbid_remap[fault_larb];
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM)) {
> +		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
> +		sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
> +	} else {
> +		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
> +	}
> +	fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
>  
>  	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
>  			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
> @@ -785,21 +792,21 @@ static const struct mtk_iommu_plat_data mt2712_data = {
>  	.m4u_plat     = M4U_MT2712,
>  	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG,
>  	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> -	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
> +	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
>  };
>  
>  static const struct mtk_iommu_plat_data mt8173_data = {
>  	.m4u_plat     = M4U_MT8173,
>  	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI,
>  	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> -	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
> +	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
>  };
>  
>  static const struct mtk_iommu_plat_data mt8183_data = {
>  	.m4u_plat     = M4U_MT8183,
>  	.flags        = RESET_AXI,
>  	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> -	.larbid_remap = {0, 4, 5, 6, 7, 2, 3, 1},
> +	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
>  };
>  
>  static const struct of_device_id mtk_iommu_of_ids[] = {
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index cf53f5e80d22..46d0d47b22e1 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -17,6 +17,9 @@
>  #include <linux/spinlock.h>
>  #include <soc/mediatek/smi.h>
>  
> +#define MTK_LARB_COM_MAX	8
> +#define MTK_LARB_SUBCOM_MAX	4
> +
>  struct mtk_iommu_suspend_reg {
>  	union {
>  		u32			standard_axi_mode;/* v1 */
> @@ -41,7 +44,7 @@ struct mtk_iommu_plat_data {
>  	enum mtk_iommu_plat m4u_plat;
>  	u32                 flags;
>  	u32                 inv_sel_reg;
> -	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
> +	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
>  };
>  
>  struct mtk_iommu_domain;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
