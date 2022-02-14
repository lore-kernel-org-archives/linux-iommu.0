Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73606C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 06:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F00E40106;
	Mon, 14 Feb 2022 06:11:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qXIssi9rIDQN; Mon, 14 Feb 2022 06:11:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BD4C84012A;
	Mon, 14 Feb 2022 06:11:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95CF1C0011;
	Mon, 14 Feb 2022 06:11:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F4FDC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 06:11:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5FEF560B9C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 06:11:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 62P2xlEtgybv for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:11:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99991605A0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 06:11:09 +0000 (UTC)
X-UUID: 79f8bf93bdf34329bdac0499ae51a473-20220214
X-UUID: 79f8bf93bdf34329bdac0499ae51a473-20220214
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 43978453; Mon, 14 Feb 2022 14:11:07 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Mon, 14 Feb 2022 14:11:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 14 Feb 2022 14:11:05 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 14:11:03 +0800
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Airlie
 <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH 13/23] drm/rockchip: Make use of the helper
 component_compare_dev
Date: Mon, 14 Feb 2022 14:08:09 +0800
Message-ID: <20220214060819.7334-14-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220214060819.7334-1-yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: =?UTF-8?q?Heiko=20St=C2=A8=C2=B9bner?= <heiko@sntech.de>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-rockchip@lists.infradead.org, Sandy
 Huang <hjc@rock-chips.com>, James Wang <james.qian.wang@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 srv_heupstream@mediatek.com, Stephen
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

VXNlIHRoZSBjb21tb24gY29tcGFyZSBoZWxwZXIgZnJvbSBjb21wb25lbnQuCgpDYzogU2FuZHkg
SHVhbmcgPGhqY0Byb2NrLWNoaXBzLmNvbT4KQ2M6ICJIZWlrbyBTdMKowrlibmVyIiA8aGVpa29A
c250ZWNoLmRlPgpDYzogbGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwpTaWduZWQt
b2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX2Rydi5jIHwgNyArLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9yb2Nr
Y2hpcC9yb2NrY2hpcF9kcm1fZHJ2LmMKaW5kZXggYmVjMjA3ZGU0NTQ0Li4zYzJmMmQ2ZWNjMzYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fZHJ2LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV9kcnYuYwpAQCAtMjkw
LDExICsyOTAsNiBAQCBpbnQgcm9ja2NoaXBfZHJtX2VuZHBvaW50X2lzX3N1YmRyaXZlcihzdHJ1
Y3QgZGV2aWNlX25vZGUgKmVwKQogCXJldHVybiBmYWxzZTsKIH0KIAotc3RhdGljIGludCBjb21w
YXJlX2RldihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpCi17Ci0JcmV0dXJuIGRldiA9
PSAoc3RydWN0IGRldmljZSAqKWRhdGE7Ci19Ci0KIHN0YXRpYyB2b2lkIHJvY2tjaGlwX2RybV9t
YXRjaF9yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQogewogCXN0cnVjdCBkZXZpY2VfbGluayAq
bGluazsKQEAgLTMyMSw3ICszMTYsNyBAQCBzdGF0aWMgc3RydWN0IGNvbXBvbmVudF9tYXRjaCAq
cm9ja2NoaXBfZHJtX21hdGNoX2FkZChzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJCQkJYnJlYWs7CiAK
IAkJCWRldmljZV9saW5rX2FkZChkZXYsIGQsIERMX0ZMQUdfU1RBVEVMRVNTKTsKLQkJCWNvbXBv
bmVudF9tYXRjaF9hZGQoZGV2LCAmbWF0Y2gsIGNvbXBhcmVfZGV2LCBkKTsKKwkJCWNvbXBvbmVu
dF9tYXRjaF9hZGQoZGV2LCAmbWF0Y2gsIGNvbXBvbmVudF9jb21wYXJlX2RldiwgZCk7CiAJCX0g
d2hpbGUgKHRydWUpOwogCX0KIAotLSAKMi4xOC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
