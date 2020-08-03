Return-Path: <SRS0=Y3fO=BO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A70C433E0
	for <iommu@archiver.kernel.org>; Tue,  4 Aug 2020 05:33:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B39C2067D
	for <iommu@archiver.kernel.org>; Tue,  4 Aug 2020 05:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lkSv8ELG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B39C2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8EF4420424;
	Tue,  4 Aug 2020 05:33:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6rqanOgQ6z7X; Tue,  4 Aug 2020 05:33:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 489AE20357;
	Tue,  4 Aug 2020 05:33:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27BADC0050;
	Tue,  4 Aug 2020 05:33:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A77FC004C
 for <iommu@lists.linux-foundation.org>; Tue,  4 Aug 2020 05:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BA83F20403
 for <iommu@lists.linux-foundation.org>; Tue,  4 Aug 2020 05:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0aoZ1bC4Wnf8 for <iommu@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 05:33:49 +0000 (UTC)
X-Greylist: delayed 00:05:29 by SQLgrey-1.7.6
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by silver.osuosl.org (Postfix) with ESMTPS id D157520357
 for <iommu@lists.linux-foundation.org>; Tue,  4 Aug 2020 05:33:48 +0000 (UTC)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20200804052816epoutp021a16c39694dc7dd1aa774e3ca87da2b3~n_XpGzST_0425204252epoutp02_
 for <iommu@lists.linux-foundation.org>; Tue,  4 Aug 2020 05:28:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20200804052816epoutp021a16c39694dc7dd1aa774e3ca87da2b3~n_XpGzST_0425204252epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1596518896;
 bh=OrQQsGEG3xgSpGLy9gO7ncefwAQQzvzqrPZ0LNv04A0=;
 h=From:To:Cc:Subject:Date:References:From;
 b=lkSv8ELG/hr3KH9zJXlegjBOzb/Kbh1mmkMvB1heFLj2S6JwJl+MGwSaQ1AP0kzQT
 vMLjE2BI8MIJb3kVZjQ21O2B1Qx0uDFSTxxf1eFteIEdBOyJH4xQ8FD3C52GzJS8WV
 vmp6saRG53KQHX37dQH0MIk/Ei/5F+DzefBozlEc=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20200804052815epcas5p2282174eabe1cb0d863d02657d12277c7~n_XogZszU2984529845epcas5p29;
 Tue,  4 Aug 2020 05:28:15 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 16.15.09475.FE1F82F5; Tue,  4 Aug 2020 14:28:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20200803140026epcas5p4f9898295d70c373bc3f52680f0b11586~nxtie5X6n3225132251epcas5p4d;
 Mon,  3 Aug 2020 14:00:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200803140026epsmtrp1bb7e7455de6b998bdb95b868ad52ae5e~nxtieK_iQ1517315173epsmtrp13;
 Mon,  3 Aug 2020 14:00:26 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-a7-5f28f1ef98a5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 19.7A.08382.A78182F5; Mon,  3 Aug 2020 23:00:26 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
 [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200803140025epsmtip2ce2a6a3b1cb92f526382815ab9fe1d1c~nxthAsUSW2099020990epsmtip2a;
 Mon,  3 Aug 2020 14:00:24 +0000 (GMT)
From: Ajay Kumar <ajaykumar.rs@samsung.com>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 mark.rutland@arm.com, will@kernel.org
Subject: [RFC PATCH] dma-iommu: allow devices to set IOVA range dynamically
Date: Mon,  3 Aug 2020 19:06:20 +0530
Message-Id: <20200803133620.13840-1-ajaykumar.rs@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7bCmlu77jxrxBt/26FsceH+QxWLBfmuL
 ztkb2C02Pb7GanF51xw2i6XXLzJZfDsWY9G69wi7xcEPT1gtWu6YOnB5PDk4j8ljzbw1jB6X
 +3qZPDat6mTz2Lyk3mPyjeWMHn1bVjF6fN4kF8ARxWWTkpqTWZZapG+XwJXx7eZJtoJO84re
 +UeYGhg36HYxcnBICJhIvHsAZHJxCAnsZpT4/PwnYxcjJ5DzCciZYghhf2OU2HwmBcQGqV97
 ZAMbRMNeRon7vy8xQTgtTBJbt7azgFSxCWhLbJt+E8wWEVjOKLH8tRTINmaBLIlNDSogYWEB
 b4k/P08xg9gsAqoS7/4tYwOxeQVsJZ7df8UCsUxeYvWGA8wg8yUELrFLXJr8iRki4SLx6e9C
 VghbWOLV8S3sELaUxMv+NnaIhn5Giaf3/0B1r2aUePDwAlS3vcSBK3NYIC7SlFi/Sx8iLCsx
 9dQ6JhCbWYBPovf3EyaIOK/EjnkgNii41CS2rvCDCMtInDl4BarEQ+LUxYcskNCKlXjycj37
 BEbZWQgLFjAyrmKUTC0ozk1PLTYtMM5LLdcrTswtLs1L10vOz93ECE4UWt47GB89+KB3iJGJ
 g/EQowQHs5II78fP6vFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZV+nIkTEkhPLEnNTk0tSC2C
 yTJxcEo1MM1582BzTFzvvUVP514Prkic8dzli1yt7vlEwQkLXSbMrNBevnqOrhnztJbgSJ6s
 IwsntH1S/tDl7GAWJ2Z5i8ExYMH5UwbfJ7IcM1n+W0xf48lGefFNfpd+RxdOCJqmVVx++NvE
 XR0H1Q8zSlhEsO733GljPSvqXPUB35NXrtTGsFZde5bHt2j9txWceasC/09/57T3h/e+7HM1
 u07K/5qzwn4qa197QvyGMxuDve7qp0bECc8JcbXrUwsuvHMnPkGlLOizsvW8G48nFFyzcZdK
 mNjQYS69iHujQsecusIti+v4FhgsO7jabPdPzQ/u/S7x3n/ZwhvcXu7qEP4XxLTw1e2VJvzt
 Tt/T9+vVH1ZiKc5INNRiLipOBAACfUCVgwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsWy7bCSvG6VhEa8QcsyOYsD7w+yWCzYb23R
 OXsDu8Wmx9dYLS7vmsNmsfT6RSaLb8diLFr3HmG3OPjhCatFyx1TBy6PJwfnMXmsmbeG0eNy
 Xy+Tx6ZVnWwem5fUe0y+sZzRo2/LKkaPz5vkAjiiuGxSUnMyy1KL9O0SuDK+3TzJVtBpXtE7
 /whTA+MG3S5GTg4JAROJtUc2sHUxcnEICexmlHh88DMLREJG4vmOp1C2sMTKf8/ZIYqamCQ2
 PZ/DDpJgE9CW2Db9JgtIQkRgLaPEwpeL2EASzAJ5EmuvrgazhQW8Jf78PMUMYrMIqEq8+7cM
 LM4rYCvx7P4rqA3yEqs3HGCewMizgJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZG
 cPBpae5g3L7qg94hRiYOxkOMEhzMSiK8Hz+rxwvxpiRWVqUW5ccXleakFh9ilOZgURLnvVG4
 ME5IID2xJDU7NbUgtQgmy8TBKdXAJKVh1KA85/fy/0fN3m6aOlfxiCA/i2F69oGydxez3HbP
 01N94/nqtvMFbx0XE9P1AY4+R10D2kUcJ/B8FTn0d2fK8e3W/T0fv9axR7yX7TEzMVv9pTv6
 u/z8+7fqKg7EHT3aejrweUK+hE7EuRtmnxIMfimYvJCNkGXaMFnp/rdHNQ5ml+ImynCcYFZv
 n529OmHSX7M3X6cI3tFw5pn/eY3T4Xmz5/2T6dytq75/S9kel50b1S/FBdXdMcrN5uq89V6f
 89u1xSFNwoJbLe7OXLPHYfGvG+bBHbXrl+3msfCSTk/I2lHdeWVu7Q3N3S7XwzewTjj302iG
 /IyNjmW+RrJzQkuUV70QFVh55pmlvBJLcUaioRZzUXEiAMT1ZiCtAgAA
X-CMS-MailID: 20200803140026epcas5p4f9898295d70c373bc3f52680f0b11586
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200803140026epcas5p4f9898295d70c373bc3f52680f0b11586
References: <CGME20200803140026epcas5p4f9898295d70c373bc3f52680f0b11586@epcas5p4.samsung.com>
Cc: robin.murphy@arm.com, nleeder@codeaurora.org,
 Ajay Kumar <ajaykumar.rs@samsung.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Currently, there is no other option to change the lower limit of
IOVA for any device than calling iova_init_domain(), but the
said function will re-init whole domain and also doesn't track
the previously allocated IOVA before re-initing the domain.

There are cases where the device might not support continuous
range of addresses, and can also have dependency among buffers
allocated for firmware, image manipulation, etc and all of the
address requests pass through IOMMU. In such cases, we can allocate
buffers stage by stage by setting address limit, and also keep
track the of same.

Bit of background can be found here:
IOVA allocation dependency between firmware buffer and remaining buffers
https://www.spinics.net/lists/iommu/msg43586.html

This patch allows devices to limit the IOVA space they want
during allocation at any given point of time. We shall allow
the same only if the device owns the corresponding iommu_domain,
that is the device is the only master attached to the domain.

The lower limit of IOVA space is marked by start_pfn, and the upper
limit is marked by dma_mask and this patch honors the same.
Since changing dma_mask can extend the addressable region beyond
current cached node, we do a reset of current cached nodes as well.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 drivers/iommu/dma-iommu.c | 73 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c     | 16 +++++++++
 include/linux/iommu.h     |  6 ++++
 include/linux/iova.h      |  6 ++++
 4 files changed, 101 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4959f5df21bd..2fe3f57ab648 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -167,6 +167,79 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
+/**
+ * iommu_set_iova_range - Limit the IOVA region for a specific device
+ * @dev: Device to set IOVA range for
+ * @base: Base address or the lower limit of the IOVA range
+ * @size: Size of address range from lower limit to upper limit
+ *
+ * Allow a master device to dynamically control the range of IOVA addresses
+ * which are allocated iff the master device is the only device attached to
+ * the corresponding iommu_domain.
+ * This function doesn't harm IOVA addresses outside of current range,
+ * which were allocated prior to calling this function.
+ */
+int iommu_set_iova_range(struct device *dev, dma_addr_t base, u64 size)
+{
+	struct iommu_domain *domain;
+	struct iommu_dma_cookie *cookie;
+	struct iova_domain *iovad;
+	unsigned long shift, base_pfn;
+	u64 new_dma_mask;
+
+	/*
+	 * Check if the IOMMU master device is the sole entry in the group
+	 * If the group has more than one master device using the same IOMMU
+	 * we shouldn't be allowing that device to change the IOVA limit
+	 */
+	if (iommu_group_device_count_from_dev(dev) != 1)
+		return -EINVAL;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain)
+		return -ENODEV;
+
+	if (domain->type != IOMMU_DOMAIN_DMA)
+		return -EINVAL;
+
+	cookie = domain->iova_cookie;
+	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
+		return -ENODEV;
+
+	iovad = &cookie->iovad;
+
+	shift = iova_shift(iovad);
+	base_pfn = base >> shift;
+
+	base_pfn = max_t(unsigned long, 1, base_pfn);
+
+	/* base cannot be outside aperture */
+	if (domain->geometry.force_aperture) {
+		if (base > domain->geometry.aperture_end ||
+		    base + size <= domain->geometry.aperture_start) {
+			pr_warn("specified DMA range outside IOMMU capability\n");
+			return -EFAULT;
+		}
+		/* ...then finally give it a kicking to make sure it fits */
+		base_pfn = max_t(unsigned long, base_pfn,
+				domain->geometry.aperture_start >> shift);
+	}
+	/* Set page aligned lower limit of IOVA range to start_pfn */
+	iovad->start_pfn = base_pfn;
+
+	/* Set upper limit of IOVA range to dma_mask */
+	new_dma_mask = (u64)base + size;
+	dma_set_mask_and_coherent(dev, new_dma_mask);
+
+	/* Reset cached nodes to start IOVA search from the anchor node */
+	iovad->cached_node = &iovad->anchor.node;
+	iovad->cached32_node = &iovad->anchor.node;
+	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
+
+	return 0;
+}
+EXPORT_SYMBOL(iommu_set_iova_range);
+
 static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 		phys_addr_t start, phys_addr_t end)
 {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 609bd25bf154..30b2d4e5487d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -919,6 +919,22 @@ static int iommu_group_device_count(struct iommu_group *group)
 	return ret;
 }
 
+int iommu_group_device_count_from_dev(struct device *dev)
+{
+	struct iommu_group *group;
+	int group_device_count;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return 0;
+
+	group_device_count = iommu_group_device_count(group);
+	iommu_group_put(group);
+
+	return group_device_count;
+}
+EXPORT_SYMBOL_GPL(iommu_group_device_count_from_dev);
+
 /**
  * iommu_group_for_each_dev - iterate over each device in the group
  * @group: the group
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fee209efb756..4dbd4dab91c0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -477,6 +477,7 @@ extern int iommu_group_set_name(struct iommu_group *group, const char *name);
 extern int iommu_group_add_device(struct iommu_group *group,
 				  struct device *dev);
 extern void iommu_group_remove_device(struct device *dev);
+extern int iommu_group_device_count_from_dev(struct device *dev);
 extern int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 				    int (*fn)(struct device *, void *));
 extern struct iommu_group *iommu_group_get(struct device *dev);
@@ -828,6 +829,11 @@ static inline void iommu_group_remove_device(struct device *dev)
 {
 }
 
+static int iommu_group_device_count_from_dev(struct device *dev)
+{
+	return 0;
+}
+
 static inline int iommu_group_for_each_dev(struct iommu_group *group,
 					   void *data,
 					   int (*fn)(struct device *, void *))
diff --git a/include/linux/iova.h b/include/linux/iova.h
index a0637abffee8..1e7d7b23ff66 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -163,6 +163,7 @@ void put_iova_domain(struct iova_domain *iovad);
 struct iova *split_and_remove_iova(struct iova_domain *iovad,
 	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
 void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
+int iommu_set_iova_range(struct device *dev, dma_addr_t base, u64 size);
 #else
 static inline int iova_cache_get(void)
 {
@@ -270,6 +271,11 @@ static inline void free_cpu_cached_iovas(unsigned int cpu,
 					 struct iova_domain *iovad)
 {
 }
+
+static int iommu_set_iova_range(struct device *dev, dma_addr_t base, u64 size)
+{
+	return 0;
+}
 #endif
 
 #endif
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
