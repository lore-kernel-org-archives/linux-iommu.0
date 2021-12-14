Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E467C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 07:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A17280AF3;
	Tue, 14 Dec 2021 07:31:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OK_fxMdLz-GY; Tue, 14 Dec 2021 07:31:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0161E80AE9;
	Tue, 14 Dec 2021 07:31:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9984C001E;
	Tue, 14 Dec 2021 07:31:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97BC1C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 07:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 717C3400D3
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 07:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F12SCjsk6-2x for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 07:31:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CA97402FF
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 07:31:31 +0000 (UTC)
X-UUID: 8e9e79793438425e84271514836eac12-20211214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=R+nhhrrFvU6d39143ONNN4FTrr1zECW086ooZ3Zhwow=; 
 b=A7UlTyAoFZZku6bzYofOVBm2hZA7ZKJXeL5ZGSRVeGZAAnGu4E3PhC2hru0QO16ch5B7FFoizmO/vzVInSfZLUn44hzg6p1yWv01fWSXdFPmQ83iE63bmlwD6HafRU+kVOvtUEImF5CXDSDH7eL7n0WZmAhI7gvhZx7lkl5+Ags=;
X-UUID: 8e9e79793438425e84271514836eac12-20211214
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 104181841; Tue, 14 Dec 2021 15:31:25 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Dec 2021 15:31:24 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Dec 2021 15:31:23 +0800
Message-ID: <ebf58066a131f92c68e83a1ef56b88f435fa0d08.camel@mediatek.com>
Subject: Re: [SPAM][PATCH] iommu/mediatek: Validate number of phandles
 associated with "mediatek,larbs"
From: Yong Wu <yong.wu@mediatek.com>
To: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 14 Dec 2021 15:31:25 +0800
In-Reply-To: <20211210205704.1664928-1-linux@roeck-us.net>
References: <20211210205704.1664928-1-linux@roeck-us.net>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Dan Carpenter <dan.carpenter@oracle.com>, Matthias
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

On Fri, 2021-12-10 at 12:57 -0800, Guenter Roeck wrote:
> Since commit baf94e6ebff9 ("iommu/mediatek: Add device link for smi-
> common
> and m4u"), the driver assumes that at least one phandle associated
> with
> "mediatek,larbs" exists. If that is not the case, for example if
> reason
> "mediatek,larbs" is provided as boolean property, the code will use
> an
> uninitialized pointer and may crash. To fix the problem, ensure that
> the
> number of phandles associated with "mediatek,larbs" is at least 1 and
> bail out immediately if that is not the case.

From the dt-binding, "mediatek,larbs" always is a phandle-array. I 
assumed the dts should conform to the dt-binding before. Then the
problem is that if we should cover the case that someone abuses/attacks
the dts. Could you help add more comment in the commit message?
something like: this is for avoid abuse the dt-binding.

> 
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: Tomasz Figa <tfiga@chromium.org>
> Fixes: baf94e6ebff9 ("iommu/mediatek: Add device link for smi-common
> and m4u")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/iommu/mtk_iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 25b834104790..0bbe32d0a2a6 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -828,6 +828,8 @@ static int mtk_iommu_probe(struct platform_device
> *pdev)
>  					     "mediatek,larbs", NULL);
>  	if (larb_nr < 0)
>  		return larb_nr;
> +	if (larb_nr == 0)
> +		return -EINVAL;

Just assigning the larbnode to NULL may be simpler. In this case, it
won't enter the loop below, and return 0 in the
of_parse_phandle(larbnode, "mediatek,smi", 0).

-       struct device_node      *larbnode, *smicomm_node;
+       struct device_node      *larbnode = NULL, *smicomm_node;

>  
>  	for (i = 0; i < larb_nr; i++) {
>  		u32 id;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
