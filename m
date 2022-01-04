Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8F7C433F5
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 15:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE339827B5;
	Tue,  4 Jan 2022 15:55:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kqbeaejFoD7B; Tue,  4 Jan 2022 15:55:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BD71C8278F;
	Tue,  4 Jan 2022 15:55:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A8F2C002F;
	Tue,  4 Jan 2022 15:55:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19990C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED6A960D5A
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qgyP5fhdBKzB for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 15:55:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CDC760C01
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 102FA1F43596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641311732;
 bh=icBLMUonunjpmX9rW+0plsHzwxROBGPHnt6LCs9+8RU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=iCJ8g6eszCN0ha04hpDyyq5hPraa4vVwFaNybDlyDirnfaF8oDX22VJOSeyewzwNb
 Z5tfkuvhj4sC9EQSkF/OGPgTXw+fRe29stg7mI1llaWiWRULsDeedvXmSmnfGBRMC6
 yS6TObQmaaHdzmsXygwwZwpvvO04OZ1FchwKvxWg8BDNcPefKa++sSOZ4OLHVXXinQ
 aBCt4wGKp7YTC7oYhbCBshowoPpwQTKWCaHx86xsv9fxFHuDSCHdmCGoQ2kPdO0rTt
 qb6mR7D+ojF04T9qubdr57hwBuPwWtog95+nxEeK5H/FMkFTp4FSvf7VPWfTucpNZZ
 ircJfvbEUYMRw==
Subject: Re: [PATCH v3 19/33] iommu/mediatek: Add list_del in mtk_iommu_remove
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-20-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <301a89d6-13ca-25db-facd-1860bc77f02b@collabora.com>
Date: Tue, 4 Jan 2022 16:55:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-20-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, yen-chang.chen@mediatek.com,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
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

Il 23/09/21 13:58, Yong Wu ha scritto:
> Lack the list_del in the mtk_iommu_remove, and remove
> bus_set_iommu(*, NULL) since there may be several iommu HWs.
> we can not bus_set_iommu null when one iommu driver unbind.
> This issue is not so important, No need fix tags.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

I would still add a Fixes tag on this commit, as that would schedule it for
backporting - and that's rather important, solidifying older releases.

Please add the required tag, after which...


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
