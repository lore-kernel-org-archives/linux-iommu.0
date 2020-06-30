Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE245C433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 11:00:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC152067D
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 11:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L21DghCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC152067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9DF62885B6;
	Tue, 30 Jun 2020 11:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XsDLaomPvR3A; Tue, 30 Jun 2020 11:00:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 27B56885F0;
	Tue, 30 Jun 2020 11:00:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 121CBC088F;
	Tue, 30 Jun 2020 11:00:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D06EC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 11:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 48A4387A68
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 11:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DJrV7wdArEoO for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 11:00:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 82A8F87A50
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 11:00:53 +0000 (UTC)
X-UUID: d155703b879a48469e70dd2ed73a9869-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=bwKT46w9uGcCWgvZnA7Tt6P0SET70mbkJOxHElU0i8s=; 
 b=L21DghCHrWldFdaBSXQEGQ15toyjeowj4Fz6tLIXxfOZVWi/ZgOWk3dUAzLmwXcQNIq7cxVGoNhVou11ecJSdwYt8il9snVbilXxT2Y3Bzui3VjK5g1pnnCZ9DKO+oNbtulUvN9Wf54WzvgaHY7bmCGMp6z9BxgSL3TaE92dGlY=;
X-UUID: d155703b879a48469e70dd2ed73a9869-20200630
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1915969159; Tue, 30 Jun 2020 18:55:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 30 Jun 2020 18:55:34 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 18:55:35 +0800
Message-ID: <1593514516.24171.25.camel@mhfsdcap03>
Subject: Re: [PATCH v5 06/10] iommu/mediatek: Add sub_comm id in translation
 fault
From: Yong Wu <yong.wu@mediatek.com>
To: Chao Hao <chao.hao@mediatek.com>
Date: Tue, 30 Jun 2020 18:55:16 +0800
In-Reply-To: <20200629071310.1557-7-chao.hao@mediatek.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
 <20200629071310.1557-7-chao.hao@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D7FCA91426CFD155D58B85D54AA5A21697363337348731C64131373A298F8F732000:8
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, 2020-06-29 at 15:13 +0800, Chao Hao wrote:
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
> ---
>  drivers/iommu/mtk_iommu.c  | 20 +++++++++++++-------
>  drivers/iommu/mtk_iommu.h  |  3 ++-
>  include/soc/mediatek/smi.h |  2 ++
>  3 files changed, 17 insertions(+), 8 deletions(-)

[snip]

> @@ -48,7 +49,7 @@ struct mtk_iommu_plat_data {
>  	enum mtk_iommu_plat m4u_plat;
>  	u32                 flags;
>  	u32                 inv_sel_reg;
> -	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
> +	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
>  };
>  
>  struct mtk_iommu_domain;
> diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
> index 5a34b87d89e3..fa65a55468e2 100644
> --- a/include/soc/mediatek/smi.h
> +++ b/include/soc/mediatek/smi.h
> @@ -12,6 +12,8 @@
>  #ifdef CONFIG_MTK_SMI
>  
>  #define MTK_LARB_NR_MAX		16
> +#define MTK_LARB_COM_MAX	8
> +#define MTK_LARB_SUBCOM_MAX	4

Both are only used in mtk_iommu.h, and I don't think smi has plan to use
them. thus we could move them into mtk_iommu.h

>  
>  #define MTK_SMI_MMU_EN(port)	BIT(port)
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
