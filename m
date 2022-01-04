Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70E1C433EF
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 15:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EAFD828AF;
	Tue,  4 Jan 2022 15:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I1Lv_J5xE9b4; Tue,  4 Jan 2022 15:55:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A1254826C1;
	Tue,  4 Jan 2022 15:55:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CB0BC002F;
	Tue,  4 Jan 2022 15:55:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05525C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3FFE41512
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KVtHSdYQyLFJ for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 15:55:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8BA941522
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 79D5F1F43598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641311705;
 bh=pq/JTgM1Y8Z1Sk0vY1Nt0JrvfIMu8/2rCeHaoTIWlBo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=MW1aTru7IdhJQrd08iFNoIToZjPwU4YtogjfexL6Gp9MvQuPq+bgq5ZLbEzzzvlfM
 pclJo3CD5sSN20fBdRYdh8Z/P/hGnih6TWpNHPBzSLxc9foTNGAtUDX7gOkv3adbiK
 vJ9VelGnB7Iz732SQCgYsKN32enh4z5VxPqK8pdEEB2l1twYGg8K24opYSaEmSM4Nf
 c8Q7mSOQooGnrl65Edzt3QLxCeNKsJ1d58WNswPkFPmkikF3AfiHtSTV0isPsWUWPq
 zKTV4CBR3pxCHK54z8axAvPm8WqESnKMqEf5u0BL/ieNbAixyRgYR91lcrd4SEaWp5
 0ZPKe3PzSisLw==
Subject: Re: [PATCH v3 17/33] iommu/mediatek: Contain MM IOMMU flow with the
 MM TYPE
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-18-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <9e65ac5b-1b8b-03e6-c7f1-7104e96e06d2@collabora.com>
Date: Tue, 4 Jan 2022 16:55:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-18-yong.wu@mediatek.com>
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
> Prepare for supporting INFRA_IOMMU, and APU_IOMMU later.
> 
> For Infra IOMMU/APU IOMMU, it doesn't have the "larb""port". thus, Use
> the MM flag contain the MM_IOMMU special flow, Also, it moves a big
> chunk code about parsing the mediatek,larbs into a function, this is
> only needed for MM IOMMU. and all the current SoC are MM_IOMMU.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
