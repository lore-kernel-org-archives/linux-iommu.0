Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1AEC433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 14:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6182041925;
	Wed, 11 May 2022 14:53:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4NbC2v5Gxj-5; Wed, 11 May 2022 14:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 119CA41916;
	Wed, 11 May 2022 14:53:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D78E5C0039;
	Wed, 11 May 2022 14:53:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1237C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 14:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF6FD4191C
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 14:53:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I0yHmjdDL5Nr for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:53:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B552741916
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 14:53:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id D3AD41F4305D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652280824;
 bh=hiCszEOEiRWDy9PmZfFtMkSpl4zM/nh6AVy0EHkIDYQ=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=asNGWawcKO386eoV6Ik3dXldZywT8oDuTlXksokpIIRR4gEyOav/D+tb4Juwr+k4y
 Qx+rYNtLFhqMtdSQGxu2vUOcTonxYINTbtNnjoBS/yQLEEI13gfvNtYIZuqr7YSCYN
 CxG5n9KstAMaivz0dLSG8XxRt7c2mm+yeMKgVOj8ugrKBs7QwuqDQCBCfamauVy14W
 R47VUmrSRn6eleE+bFO5EP2wWBxNxVcpnGnyq8MTs34Wd3SAlUU5VdMv9+im2UjnkH
 QnJWN+7n9mcg3M0eAeLcLIEl42peP7r99nhPHNgkgjWeHpMQzZV1nT7DlDooTn005z
 55mJoc85Lt5sw==
Message-ID: <26273bf5-c4a4-da9d-d722-da3880a27ce4@collabora.com>
Date: Wed, 11 May 2022 16:53:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 3/4] iommu/mediatek: Validate number of phandles
 associated with "mediatek,larbs"
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20220511064920.18455-1-yong.wu@mediatek.com>
 <20220511064920.18455-4-yong.wu@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220511064920.18455-4-yong.wu@mediatek.com>
Cc: anan.sun@mediatek.com, chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 yf.wang@mediatek.com, libo.kang@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Dan Carpenter <dan.carpenter@oracle.com>, Guenter Roeck <groeck@chromium.org>,
 mingyuan.ma@mediatek.com, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 11/05/22 08:49, Yong Wu ha scritto:
> From: Guenter Roeck <groeck@chromium.org>
> 
> Fix the smatch warnings:
> drivers/iommu/mtk_iommu.c:878 mtk_iommu_mm_dts_parse() error: uninitialized
> symbol 'larbnode'.
> 
> If someone abuse the dtsi node(Don't follow the definition of dt-binding),
> for example "mediatek,larbs" is provided as boolean property, the code may
> crash. To fix this problem and improve the code safety, add some checking
> for the invalid input from dtsi, e.g. checking the larb_nr/larbid valid
> range, and avoid "mediatek,larb-id" property conflicts in the smi-larb
> nodes.
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
