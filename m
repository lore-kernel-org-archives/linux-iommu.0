Return-Path: <SRS0=bugC=HJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02900C433E0
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 01:45:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625B764E8D
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 01:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625B764E8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 234D6204DA;
	Sun,  7 Feb 2021 01:45:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gfqVU7iOqB+u; Sun,  7 Feb 2021 01:45:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B83F3204A1;
	Sun,  7 Feb 2021 01:45:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FD69C0174;
	Sun,  7 Feb 2021 01:45:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FBF4C013A
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 01:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 435DA85CD8
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 01:45:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YI1Hvcj60iWu for <iommu@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 01:45:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8BDAC85BCF
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 01:45:42 +0000 (UTC)
X-UUID: 827f1e2f1488468593be5b168193d73c-20210207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=UOcodyhE36vNMhq5b0qi4z7RJDMmPhWYZvVA5+EV+68=; 
 b=I1A0/qzk9afNaXia6AWsmFc5zD8zmrMHswca9erF1+Sj5WtfKR/9iqusGc7NFkajs2Krl+ghGOMG5JyYzXG04md0fMR2yKfqxzp2uS2MdsZYHdoFVEFPdbfMMIst9RlOzPT+tFrFN76+HGMqo248uGyQrAlXyzpcx4wA4KGzdTc=;
X-UUID: 827f1e2f1488468593be5b168193d73c-20210207
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 591288906; Sun, 07 Feb 2021 09:45:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 7 Feb 2021 09:45:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Feb 2021 09:45:19 +0800
Message-ID: <1612662319.2524.16.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu/mediatek: Fix error code in probe()
From: Yong Wu <yong.wu@mediatek.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sun, 7 Feb 2021 09:45:19 +0800
In-Reply-To: <YB0+GU5akSdu29Vu@mwanda>
References: <YB0+GU5akSdu29Vu@mwanda>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A90FA4188E79EC868A03301EA33900D9514BD2F174ABA508AF7335354372B47E2000:8
X-MTK: N
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
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

On Fri, 2021-02-05 at 15:46 +0300, Dan Carpenter wrote:
> This error path is supposed to return -EINVAL.  It used to return
> directly but we added some clean up and accidentally removed the
> error code.  Also I fixed a typo in the error message.
> 
> Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Yong Wu <yong.wu@mediatek.com>

> ---
>  drivers/iommu/mtk_iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 0ad14a7604b1..5f78ac0dc30e 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -886,7 +886,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  	link = device_link_add(data->smicomm_dev, dev,
>  			DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
>  	if (!link) {
> -		dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
> +		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
> +		ret = -EINVAL;
>  		goto out_runtime_disable;
>  	}
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
