Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB47C4332F
	for <iommu@archiver.kernel.org>; Tue, 11 Jan 2022 10:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 291904086E;
	Tue, 11 Jan 2022 10:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id avnUA0OdjA_n; Tue, 11 Jan 2022 10:58:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BC3E14064B;
	Tue, 11 Jan 2022 10:58:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98889C002F;
	Tue, 11 Jan 2022 10:58:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25C52C001E
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 10:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1ACD360A77
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 10:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IBOTRp8Ootqo for <iommu@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 10:57:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F95C60D5B
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 10:57:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 753EF1F43A25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641898676;
 bh=uOOf2pUBjW2YNPi7A5gOPx8tj+5C9CcAKgPwKosMJPU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ah4whR4PxAPnSeKMaH8D0mIl+AmgJh8yjDIjTCTNd+eYX7zDpXLVhtZWjsdM/qQwi
 3uMfvbbagIzngjXVSy94LJ3N5bwkmXYmdqSqPKpawAPSx7TekssUGqpfx2VKURdw/L
 GciDTpeUZQSy2iI6FO0hSXnu4N/ifwznfBEh/i7ZjXRD39DrHcrjilNnJtU+ZUbAcs
 xmpe9iIVIU6yYCLuOAZt2m1kU25w45Iooh3OTmUI1cSZrwRUZK/vnT3yW+UiKKh6yS
 7tkprjeTlRfaeL+3glwdJpq3Zc1ekIFjxdDdS1DXm5fmOCqEdIqUwC0Qlgqi4kSvjH
 QVYVIxT+hXNpA==
Subject: Re: [PATCH v9 01/15] dt-binding: mediatek: Get rid of mediatek, larb
 for multimedia HW
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <20211112105509.12010-2-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <1020e4cf-99d4-0912-eca7-620e44a6d3f0@collabora.com>
Date: Tue, 11 Jan 2022 11:57:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112105509.12010-2-yong.wu@mediatek.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Evan Green <evgreen@chromium.org>, Eizan Miyamoto <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>, mingyuan.ma@mediatek.com,
 linux-media@vger.kernel.org, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, libo.kang@mediatek.com, yi.kuo@mediatek.com,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 anan.sun@mediatek.com, acourbot@chromium.org, srv_heupstream@mediatek.com,
 yf.wang@mediatek.com, iommu@lists.linux-foundation.org,
 Philipp Zabel <p.zabel@pengutronix.de>, Robin Murphy <robin.murphy@arm.com>
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

Il 12/11/21 11:54, Yong Wu ha scritto:
> After adding device_link between the consumer with the smi-larbs,
> if the consumer call its owner pm_runtime_get(_sync), the
> pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. Thus, the consumer don't need this property.
> 
> And IOMMU also know which larb this consumer connects with from
> iommu id in the "iommus=" property.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
