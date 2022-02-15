Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB7BC433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 02:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8206C60D79;
	Tue, 15 Feb 2022 02:27:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id siu7UWM4P5FM; Tue, 15 Feb 2022 02:27:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9A15060B77;
	Tue, 15 Feb 2022 02:27:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F3CFC002D;
	Tue, 15 Feb 2022 02:27:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DE6DC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 02:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDF3682702
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 02:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KOFkGIG05GEZ for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 02:27:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF843826D5
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 02:27:40 +0000 (UTC)
X-UUID: 7c965cb11cb840179b068fbfb5380b89-20220215
X-UUID: 7c965cb11cb840179b068fbfb5380b89-20220215
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 143493579; Tue, 15 Feb 2022 10:27:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 10:27:34 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 10:27:33 +0800
Message-ID: <2a39dc9465761a16587bfe82189f581c1d52da6a.camel@mediatek.com>
Subject: Re: [PATCH 20/23] ASoC: codecs: wcd938x: Make use of the helper
 component_compare/release_of
To: Mark Brown <broonie@kernel.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Date: Tue, 15 Feb 2022 10:27:33 +0800
In-Reply-To: <67b2e6e8-e4fe-06ca-3d12-9bba83743989@collabora.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
 <20220214060819.7334-21-yong.wu@mediatek.com>
 <YgpNqLQzpx4J6d8K@sirena.org.uk>
 <67b2e6e8-e4fe-06ca-3d12-9bba83743989@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 David Airlie <airlied@linux.ie>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Takashi Iwai <tiwai@suse.com>, James Wang <james.qian.wang@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, Stephen
 Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 2022-02-14 at 13:43 +0100, AngeloGioacchino Del Regno wrote:
> Il 14/02/22 13:40, Mark Brown ha scritto:
> > On Mon, Feb 14, 2022 at 02:08:16PM +0800, Yong Wu wrote:
> > > Use the common compare/release helpers from component.
> > 
> > What's the story with dependencies here?  I've just got this one
> > patch
> > with no cover letter...

Sorry for this. I will add in cover letter next time.
Maybe in next week. Just to see if there is any other comment.

Thanks.

> 
> Hello Mark,
> I agree, the cover letter should be sent to everyone; Yong, please
> add the
> proper Ccs to it next time.
> 
> Anyway, context:
> 
https://patchwork.kernel.org/project/linux-mediatek/cover/20220214060819.7334-1-yong.wu@mediatek.com/

Thanks very much:)

> 
> Cheers,
> Angelo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
