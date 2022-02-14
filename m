Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7476C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 06:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 839984019E;
	Mon, 14 Feb 2022 06:12:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PdvJVyQFWvH1; Mon, 14 Feb 2022 06:12:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B266D40139;
	Mon, 14 Feb 2022 06:12:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99101C0011;
	Mon, 14 Feb 2022 06:12:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2031C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 06:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E56B60B9C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 06:12:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jt-NmiPoLcNn for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:12:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1519605A0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 06:12:28 +0000 (UTC)
X-UUID: 9a7bd2dcf0dd41049c8f537e789aee7f-20220214
X-UUID: 9a7bd2dcf0dd41049c8f537e789aee7f-20220214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1806270151; Mon, 14 Feb 2022 14:12:24 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 14 Feb 2022 14:12:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 14 Feb 2022 14:12:22 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 14:12:20 +0800
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Airlie
 <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH 23/23] ALSA: hda/realtek: Make use of the helper
 component_compare_dev_name
Date: Mon, 14 Feb 2022 14:08:19 +0800
Message-ID: <20220214060819.7334-24-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220214060819.7334-1-yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: alsa-devel@alsa-project.org, Lucas Tanure <tanureal@opensource.cirrus.com>,
 Jeremy Szu <jeremy.szu@canonical.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Werner Sembach <wse@tuxedocomputers.com>, linux-kernel@vger.kernel.org,
 Cameron Berkenpas <cam@neo-zeon.de>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Takashi Iwai <tiwai@suse.com>, Hui
 Wang <hui.wang@canonical.com>, James Wang <james.qian.wang@arm.com>,
 Sami Loone <sami@loone.fi>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Kailang
 Yang <kailang@realtek.com>, srv_heupstream@mediatek.com, Stephen
 Boyd <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

Use the common compare helper from component.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Jeremy Szu <jeremy.szu@canonical.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>
Cc: Hui Wang <hui.wang@canonical.com>
Cc: Cameron Berkenpas <cam@neo-zeon.de>
Cc: Kailang Yang <kailang@realtek.com>
Cc: Lucas Tanure <tanureal@opensource.cirrus.com>
Cc: Sami Loone <sami@loone.fi>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 sound/pci/hda/patch_realtek.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 668274e52674..9da004d99cdb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6530,11 +6530,6 @@ static void alc287_fixup_legion_15imhg05_speakers(struct hda_codec *codec,
 	}
 }
 
-static int comp_match_dev_name(struct device *dev, void *data)
-{
-	return strcmp(dev_name(dev), data) == 0;
-}
-
 static int find_comp_by_dev_name(struct alc_spec *spec, const char *name)
 {
 	int i;
@@ -6595,7 +6590,7 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 					      "%s-%s:00-cs35l41-hda.%d", bus, hid, i);
 			if (!name)
 				return;
-			component_match_add(dev, &spec->match, comp_match_dev_name, name);
+			component_match_add(dev, &spec->match, component_compare_dev_name, name);
 		}
 		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
 		if (ret)
@@ -6644,9 +6639,9 @@ static void alc287_fixup_legion_16achg6_speakers(struct hda_codec *cdc, const st
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
-		component_match_add(dev, &spec->match, comp_match_dev_name,
+		component_match_add(dev, &spec->match, component_compare_dev_name,
 				    "i2c-CLSA0100:00-cs35l41-hda.0");
-		component_match_add(dev, &spec->match, comp_match_dev_name,
+		component_match_add(dev, &spec->match, component_compare_dev_name,
 				    "i2c-CLSA0100:00-cs35l41-hda.1");
 		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
 		if (ret)
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
