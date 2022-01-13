Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00F4C433EF
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 10:11:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3DEBE4019E;
	Thu, 13 Jan 2022 10:11:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oRqNf9gcwDPD; Thu, 13 Jan 2022 10:11:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 137844000B;
	Thu, 13 Jan 2022 10:11:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D97F1C002F;
	Thu, 13 Jan 2022 10:11:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87D2FC001E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 10:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CCF14019E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 10:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O1VFT4DQ3BW1 for <iommu@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 10:11:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 445C1400FC
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 10:11:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id E4E661F4585E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1642068704;
 bh=D/XYC6ZGl5zYQW2bPb5HgmDBOTYg/Taj7564Kp6Xo1w=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=mE4sw4YvYqPtPCeGgdYDQbOGYr1D0sRwnP4JUyOyjhZj86DL2KdqFn53kzdPhLzVf
 Bw1VvaPOhimlqvAni2KTggbrrVF2tMVgZUYZ8GT3HumFLMHl/swIw8OEmuB63xYT9D
 ry4EVMAhrR1d8HMl2egIRfzRMjosarxVeMM5DKaB83CPATfsl/FDKcekgbGiXopEIL
 MnHuCbLxWgj6rZKBy6qsMzCkq0MxYh4lCNn7zCBOc/+l8UBmSPACrlbKg9pzt44nrH
 jFeTmjYUIPMAWJwQeXwYslmZrcg0H+P/WZvI2jlUHmT8gdPkXem6ziG4wdUDcl9DH5
 E8ZqIX9/NoQSw==
Subject: Re: [PATCH v9 12/15] media: mtk-vcodec: enc: Remove
 mtk_vcodec_release_enc_pm
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <20211112105509.12010-13-yong.wu@mediatek.com>
 <68c3a573-8453-38e9-93b2-2067bedcd06f@collabora.com>
Message-ID: <4bd9e849-96dd-6f1c-2841-979459366ee5@collabora.com>
Date: Thu, 13 Jan 2022 11:11:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <68c3a573-8453-38e9-93b2-2067bedcd06f@collabora.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Irui Wang <irui.wang@mediatek.com>, Evan Green <evgreen@chromium.org>,
 Eizan Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 mingyuan.ma@mediatek.com, linux-media@vger.kernel.org,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 libo.kang@mediatek.com, yi.kuo@mediatek.com,
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

Il 11/01/22 11:57, AngeloGioacchino Del Regno ha scritto:
> Il 12/11/21 11:55, Yong Wu ha scritto:
>> After this patchset, mtk_vcodec_release_enc_pm has only one line.
>> then remove that function, use pm_runtime_disable instead.
>>
>> meanwhile, mtk_vcodec_init_enc_pm only operate for the clocks,
>> rename it from the _pm to _clk.
>>
>> No functional change.
>>
>> CC: Tiffany Lin <tiffany.lin@mediatek.com>
>> CC: Irui Wang <irui.wang@mediatek.com>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

Hello Yong,
the mtk-vcodec patches were merged in Yunfei's vcodec patch series and Hans has
scheduled that for v5.18.

Can you please send a v10 and drop patches 10/15, 11/15, 12/15 (all of the
media: mtk-vcodec: *) from this series?

For the records, I think that after sending v10 this series is ready to be merged,
as it was well reviewed and also tested on many MTK platforms.

Thank you,
- Angelo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
