Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104C7C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 01:11:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5EB64F5D
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 01:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5EB64F5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D90C9862AC;
	Thu,  4 Feb 2021 01:11:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S2fu9kXLU8ar; Thu,  4 Feb 2021 01:11:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4CD6486283;
	Thu,  4 Feb 2021 01:11:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A9CEC0174;
	Thu,  4 Feb 2021 01:11:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83390C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 761E0862AC
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:11:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5XpZV5sIAwRM for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 01:11:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3F88886283
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 01:11:31 +0000 (UTC)
X-UUID: 5d784d263b7043e084225b404753ac45-20210204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Mn/ebbC9LsmEJbQuuUcinkZOL/S9ftYROo8U9Oj+0Po=; 
 b=tHb7ekMh+g+dP+Jk60pyz+yKaHk3fCc56qBeBQK9Da1JyPSbOzrjhqg3Ti7O/7tSdxnOEMgN5T1p6/JKGJikRsLYaEEc/Zw010MdHidryOcfdXdyroDscCemy3gPxzd0MKx2wrFinRxCtvbW1ZY8LNagR46skC519oC4OS2keUw=;
X-UUID: 5d784d263b7043e084225b404753ac45-20210204
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1030138190; Thu, 04 Feb 2021 09:11:20 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 4 Feb 2021 09:11:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Feb 2021 09:11:09 +0800
Message-ID: <1612401069.2524.14.camel@mhfsdcap03>
Subject: Re: [PATCH][next] iommu/mediatek: Fix unsigned domid comparison
 with less than zero
From: Yong Wu <yong.wu@mediatek.com>
To: Colin King <colin.king@canonical.com>
Date: Thu, 4 Feb 2021 09:11:09 +0800
In-Reply-To: <20210203135936.23016-1-colin.king@canonical.com>
References: <20210203135936.23016-1-colin.king@canonical.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9BDBFE8346E958A37D1A2EE99CA3980372E31BF52999FC51717954E6E3C6FFB92000:8
X-MTK: N
Cc: Anan sun <anan.sun@mediatek.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chao
 Hao <chao.hao@mediatek.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
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

On Wed, 2021-02-03 at 13:59 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the check for domid < 0 is always false because domid
> is unsigned.  Fix this by making it signed.
> 
> Addresses-CoverityL ("Unsigned comparison against 0")
> Fixes: ab1d5281a62b ("iommu/mediatek: Add iova reserved function")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for the fix.

Reviewed-by: Yong Wu <yong.wu@mediatek.com>

> ---
>  drivers/iommu/mtk_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 0ad14a7604b1..823d719945b2 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -640,7 +640,7 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
>  				       struct list_head *head)
>  {
>  	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
> -	unsigned int domid = mtk_iommu_get_domain_id(dev, data->plat_data), i;
> +	int domid = mtk_iommu_get_domain_id(dev, data->plat_data), i;
>  	const struct mtk_iommu_iova_region *resv, *curdom;
>  	struct iommu_resv_region *region;
>  	int prot = IOMMU_WRITE | IOMMU_READ;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
