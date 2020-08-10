Return-Path: <SRS0=jbNj=BV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F46C433E0
	for <iommu@archiver.kernel.org>; Tue, 11 Aug 2020 01:07:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DEB20734
	for <iommu@archiver.kernel.org>; Tue, 11 Aug 2020 01:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Qps5w1De"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DEB20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9674B87A15;
	Tue, 11 Aug 2020 01:07:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YjocpC8hSFyU; Tue, 11 Aug 2020 01:07:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6186D87939;
	Tue, 11 Aug 2020 01:07:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C65AC0864;
	Tue, 11 Aug 2020 01:07:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E5E4C004D
 for <iommu@lists.linux-foundation.org>; Tue, 11 Aug 2020 01:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5D6FC87828
 for <iommu@lists.linux-foundation.org>; Tue, 11 Aug 2020 01:07:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jMvqaJmjbrsX for <iommu@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 01:07:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3666C8781D
 for <iommu@lists.linux-foundation.org>; Tue, 11 Aug 2020 01:07:41 +0000 (UTC)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20200811010739epoutp029daf7da61651e2a8978c7e9a94cf4be0~qEVF3aFMS1010210102epoutp02j
 for <iommu@lists.linux-foundation.org>; Tue, 11 Aug 2020 01:07:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20200811010739epoutp029daf7da61651e2a8978c7e9a94cf4be0~qEVF3aFMS1010210102epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1597108059;
 bh=HK7exrckXuwI44GyKCPbt6+IlYp69szQXmXoQEGnu+U=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Qps5w1DeB/kF4y9VYhwX+q82XlJ5J8jIb408jvS8DQgxuPMvg34uwx535v0NhlteQ
 6H2kxawj40maQFGuHnNVWJ3Xx06Qa1nfyrw9ZtRlfdU8K6s8WVMuYWaXB4rIkVt0kg
 jHdIZeLj0Ewrn20GQKgErU4X+Jqn1DRAKRQjgE60=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20200811010738epcas5p26955aaf89f96c7c76b4d8f675e2bb51c~qEVFGESHi3147831478epcas5p2j;
 Tue, 11 Aug 2020 01:07:38 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 66.5D.09475.A5FE13F5; Tue, 11 Aug 2020 10:07:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20200810182328epcas5p2d5ffb5a5850a641fe7d31aa945c6c835~p_0M0x5bb1213612136epcas5p2I;
 Mon, 10 Aug 2020 18:23:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200810182328epsmtrp1d33f7fbd0d8ecb0018934e3d3e014ee4~p_0M0AGVO2458324583epsmtrp1k;
 Mon, 10 Aug 2020 18:23:28 +0000 (GMT)
X-AuditID: b6c32a4b-389ff70000002503-fb-5f31ef5a1d11
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 D8.D5.08303.0A0913F5; Tue, 11 Aug 2020 03:23:28 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
 [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200810182327epsmtip2c09b6332831a28d233e3cb477a8f1dc4~p_0LKUtVH0583205832epsmtip2c;
 Mon, 10 Aug 2020 18:23:27 +0000 (GMT)
From: Ajay Kumar <ajaykumar.rs@samsung.com>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 mark.rutland@arm.com, will@kernel.org
Subject: [RFC V2 PATCH] dma-iommu: allow devices to set IOVA range dynamically
Date: Mon, 10 Aug 2020 23:28:12 +0530
Message-Id: <20200810175812.29100-1-ajaykumar.rs@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7bCmpm7Ue8N4g0Of5S0OvD/IYnF6wiIm
 iwX7rS06Z29gt9j0+BqrxeVdc9gsll6/yGTx7ViMReveI+wWBz88YbVouWPqwO3x5OA8Jo81
 89Ywelzu62Xy2LxCy2PTqk42j81L6j0m31jO6NG3ZRWjx+dNcgGcUVw2Kak5mWWpRfp2CVwZ
 zb/3shZctao4er6dtYFxv0EXIyeHhICJxPWO7+wgtpDAbkaJD71pXYxcQPYnRonTl++zQjif
 GSVOfjzKBNMxd986JojELkaJzh/L2CCcFiaJRYt/s4FUsQloS2ybfpMFxBYRWM4osfy1FIjN
 LFArMWX9MbC4sECAxIvubqAVHBwsAqoSdy6BncErYCvxq+ciC8QyeYnVGw4wQ9gv2SV6z0PF
 XSTmrH/IBmELS7w6voUdwpaSeNnfxg5yj4RAP6PE0/t/mCGc1YwSDx5egJpkL3HgyhwWkMXM
 ApoS63fpQ4RlJaaeWscEcSefRO/vJ1Af80rsmAdicwDZahJbV/hBhGUkzhy8AlXiIXFl83RG
 SDDGSpw81806gVF2FsKCBYyMqxglUwuKc9NTi00LjPNSy/WKE3OLS/PS9ZLzczcxgpOHlvcO
 xkcPPugdYmTiYDzEKMHBrCTCa3dXP16INyWxsiq1KD++qDQntfgQozQHi5I4r9KPM3FCAumJ
 JanZqakFqUUwWSYOTqkGJrMl/HGHClTNHUz0wqo3rnh1aT9zslnU5VCR0sNbmrgdl805v/OB
 0M3g8M4VIu9+tzwUvfM32jO3anak93Tdvbun/VgRer8quKrz76mXWbbuL02t/U0ZfvI1OwpY
 +/z5pS1gn8C28PT7I0231vP6zH2u7X3VYtrLVQ5ezbfORN+sY2u7KNxziPnVQ87u72pbl0Q3
 fIuLdrtUndNgZ7E4e/1NRofMiys+29rFuwRfWPf2W+Dp/XO7H36I45DZXvP27iW+Tcq666dy
 +F2rLpxxYY/5600xeg4v86S5Y9/yP5yz/X+qmfWBLPljFU1biy6tspFYdjpl7oro5ZqB0lo5
 Gaerkz8FMLQ2qN5UCdu1SImlOCPRUIu5qDgRACf1nyiNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSvO6CCYbxBnPmmFgceH+QxeL0hEVM
 Fgv2W1t0zt7AbrHp8TVWi8u75rBZLL1+kcni27EYi9a9R9gtDn54wmrRcsfUgdvjycF5TB5r
 5q1h9Ljc18vksXmFlsemVZ1sHpuX1HtMvrGc0aNvyypGj8+b5AI4o7hsUlJzMstSi/TtErgy
 mn/vZS24alVx9Hw7awPjfoMuRk4OCQETibn71jF1MXJxCAnsYJSYtG8KO0RCRuL5jqcsELaw
 xMp/z9khipqYJE73drKBJNgEtCW2Tb/JApIQEVjLKLHw5SI2EIdZoJlRYuerS6wgVcICfhKr
 G74CJTg4WARUJe5cAtvAK2Ar8avnItQGeYnVGw4wT2DkWcDIsIpRMrWgODc9t9iwwCgvtVyv
 ODG3uDQvXS85P3cTIzgctbR2MO5Z9UHvECMTB+MhRgkOZiURXru7+vFCvCmJlVWpRfnxRaU5
 qcWHGKU5WJTEeb/OWhgnJJCeWJKanZpakFoEk2Xi4JRqYJo5Z1vwFq2O4hku7D+exGysWHus
 YmtrxBvuxSc1Xir7SllvfN8pfSxn/jGWAw/UitVvFLGaa/2v0oivq7aacu/9/bgfKl/8u6Ua
 hH8FuLTE8Mqfsqx1NtPe9ubQsziZR6V8C+avfR1/MfzLj/88tk9PbDjzufAJV1GpbzxLbYv0
 8jid1S8+p811E9Jy+rX74cG1DB//Fjy5dIfjzKEJX9eVTngYYLJmwwNeyZdFJ7sfxobbMNyU
 0dn8quCmVqlERPGJfI0/d6/vmmfFvuXixM3Hoz/t6fp6om2z4aY7KlWHHdnDCs0MC7bbr5gh
 G3Lji+Cl2vM/9SP35Ww+0us45WL5zba05obzNz9++7lwtU2CEktxRqKhFnNRcSIAIiH+PbYC
 AAA=
X-CMS-MailID: 20200810182328epcas5p2d5ffb5a5850a641fe7d31aa945c6c835
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200810182328epcas5p2d5ffb5a5850a641fe7d31aa945c6c835
References: <CGME20200810182328epcas5p2d5ffb5a5850a641fe7d31aa945c6c835@epcas5p2.samsung.com>
Cc: hch@infradead.org, robin.murphy@arm.com, nleeder@codeaurora.org,
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

User drivers can make call sequence like below:
============================================================
When they want to limit IOVA for allocated buffers in range
0x0 to 0x1000000:
iommu_set_iova_range(dev, 0x0, 0x1000000 - 1);

When they want to limit IOVA for allocated buffers in range
0x1000000 to 0xC0000000:
iommu_set_iova_range(dev, 0x1000000, 0xC0000000 - 0x1000000);
=============================================================

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
+EXPORT_SYMBOL_GPL(iommu_set_iova_range);
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
