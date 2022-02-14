Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF30C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 06:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 73FAD4019E;
	Mon, 14 Feb 2022 06:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n8Nm89I5u0Xw; Mon, 14 Feb 2022 06:09:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E82D540106;
	Mon, 14 Feb 2022 06:09:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1D19C0011;
	Mon, 14 Feb 2022 06:09:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7551C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 06:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B611C60C09
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 06:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fCbScIZ0aMqH for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:09:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8359A60C1B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 06:09:13 +0000 (UTC)
X-UUID: a3ec6c2d8e3f4609a6f077380016b41c-20220214
X-UUID: a3ec6c2d8e3f4609a6f077380016b41c-20220214
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1045061193; Mon, 14 Feb 2022 14:09:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 14 Feb 2022 14:09:03 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 14:09:01 +0800
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Airlie
 <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH 01/23] component: Add common helper for compare/release
 functions
Date: Mon, 14 Feb 2022 14:07:57 +0800
Message-ID: <20220214060819.7334-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220214060819.7334-1-yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 James Wang <james.qian.wang@arm.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The component requires the compare/release functions, there are so many
copies in current kernel. Just define four common helpers for them.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
I have run "make htmldocs". Due to my poor english, If the grammer is
wrong or need more comments, please help to correct or supplement.
Thanks.
---
 drivers/base/component.c  | 58 +++++++++++++++++++++++++++++++++++++++
 include/linux/component.h |  6 ++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 2d25a6416587..3d72d2820d7d 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
 
@@ -287,6 +288,63 @@ static void take_down_master(struct master *master)
 	}
 }
 
+/**
+ * component_compare_of - A common component compare function for of_node
+ * @dev: component device
+ * @data: @compare_data from component_match_add_release()
+ *
+ * A common compare function when compare_data is device of_node. e.g.
+ * component_match_add_release(masterdev, &match, component_release_of,
+ * component_compare_of, component_dev_of_node)
+ */
+int component_compare_of(struct device *dev, void *data)
+{
+	return device_match_of_node(dev, data);
+}
+EXPORT_SYMBOL_GPL(component_compare_of);
+
+/**
+ * component_release_of - A common component release function for of_node
+ * @dev: component device
+ * @data: @compare_data from component_match_add_release()
+ *
+ * About the example, Please see component_compare_of().
+ */
+void component_release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+EXPORT_SYMBOL_GPL(component_release_of);
+
+/**
+ * component_compare_dev - A common component compare function for dev
+ * @dev: component device
+ * @data: @compare_data from component_match_add_release()
+ *
+ * A common compare function when compare_data is struce device. e.g.
+ * component_match_add(masterdev, &match, component_compare_dev, component_dev)
+ */
+int component_compare_dev(struct device *dev, void *data)
+{
+	return dev == data;
+}
+EXPORT_SYMBOL_GPL(component_compare_dev);
+
+/**
+ * component_compare_dev_name - A common component compare function for device name
+ * @dev: component device
+ * @data: @compare_data from component_match_add_release()
+ *
+ * A common compare function when compare_data is device name string. e.g.
+ * component_match_add(masterdev, &match, component_compare_dev_name,
+ * "component_dev_name")
+ */
+int component_compare_dev_name(struct device *dev, void *data)
+{
+	return device_match_name(dev, data);
+}
+EXPORT_SYMBOL_GPL(component_compare_dev_name);
+
 static void devm_component_match_release(struct device *parent, void *res)
 {
 	struct component_match *match = res;
diff --git a/include/linux/component.h b/include/linux/component.h
index 16de18f473d7..6bc1c6e7f76d 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -82,6 +82,12 @@ struct component_master_ops {
 	void (*unbind)(struct device *master);
 };
 
+/* A set helper functions for component compare/release */
+int component_compare_of(struct device *dev, void *data);
+void component_release_of(struct device *dev, void *data);
+int component_compare_dev(struct device *dev, void *data);
+int component_compare_dev_name(struct device *dev, void *data);
+
 void component_master_del(struct device *,
 	const struct component_master_ops *);
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
