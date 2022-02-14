Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736E4C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 12:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E12860EBF;
	Mon, 14 Feb 2022 12:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eVisLZ3UjRdV; Mon, 14 Feb 2022 12:43:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0BC23605A7;
	Mon, 14 Feb 2022 12:43:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDC45C0011;
	Mon, 14 Feb 2022 12:43:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 194EEC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3F3F80C64
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ROd3tsWq2TW3 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 12:43:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9F7880C63
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:43:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 5197F1F4384F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1644842626;
 bh=IvY7iJXZuxVISQOzxTkzNan7PoRvkvKAMjY1GwjciqA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QXQIDpL+wlcUJSteZlDsqVfHd73wuzzjWwwDOoEFCt2econPievKZC/1oAO4p4kkI
 Rw0W4lQ4fe47IkCH0j3J7XacuvmspOj0yZSG9NV+mDcZObophnvnWKosO5kKLfQwm3
 SWAdkas796uUKoJn8PJauQoPFyK5U8w5KJ3m+CU2UpSPLH405q5Ic07RMybfGVeKGx
 Zu/Wuog64S0en+WH1eYPiERDOEAEa/CdYr+Mo1tNNKxMzpwGwSrX70H/haQC71JmtV
 s4VHzu3D1EW9XrQAYjzaDOn4GDiDAq5z6BzvHwQs/m4bKByE40tK8IXG8QvPNiSZj1
 qorX5LpeI+OsA==
Message-ID: <67b2e6e8-e4fe-06ca-3d12-9bba83743989@collabora.com>
Date: Mon, 14 Feb 2022 13:43:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 20/23] ASoC: codecs: wcd938x: Make use of the helper
 component_compare/release_of
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Yong Wu <yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
 <20220214060819.7334-21-yong.wu@mediatek.com>
 <YgpNqLQzpx4J6d8K@sirena.org.uk>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YgpNqLQzpx4J6d8K@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 David Airlie <airlied@linux.ie>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Takashi Iwai <tiwai@suse.com>, James Wang <james.qian.wang@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

Il 14/02/22 13:40, Mark Brown ha scritto:
> On Mon, Feb 14, 2022 at 02:08:16PM +0800, Yong Wu wrote:
>> Use the common compare/release helpers from component.
> 
> What's the story with dependencies here?  I've just got this one patch
> with no cover letter...

Hello Mark,
I agree, the cover letter should be sent to everyone; Yong, please add the
proper Ccs to it next time.

Anyway, context:
https://patchwork.kernel.org/project/linux-mediatek/cover/20220214060819.7334-1-yong.wu@mediatek.com/

Cheers,
Angelo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
