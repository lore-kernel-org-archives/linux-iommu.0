Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B43C433DF
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 07:51:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467A82067C
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 07:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gVTsDwN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467A82067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0F75B20380;
	Tue, 18 Aug 2020 07:51:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6QT1ufSmznK5; Tue, 18 Aug 2020 07:50:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DFC3020365;
	Tue, 18 Aug 2020 07:50:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C90D3C07FF;
	Tue, 18 Aug 2020 07:50:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33BF5C0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 07:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 21BB087524
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 07:50:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0cPvZnv3b4Ke for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 07:50:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ECAD88737E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 07:50:55 +0000 (UTC)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20200818075053epoutp01835a46308a803e2112890278d5d0fe25~sTWKGKlWi1563515635epoutp01u
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 07:50:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20200818075053epoutp01835a46308a803e2112890278d5d0fe25~sTWKGKlWi1563515635epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1597737053;
 bh=reRIwhiJO75p0FtjqI282A2lfxt7RtX0AcKI2mqvwtA=;
 h=From:To:Cc:Subject:Date:References:From;
 b=gVTsDwN3X7E+ytqhiLbOrf0uFe6cbYQV9QufI+xBlhm5hl69Em6Jtlw4wcvfUxpz5
 4uInry1xK/PEJvgtCaWI/pu8fEMJGqEtQ/XSOKp8pCBun1yC37rE0bp2Qs7vrOjxIj
 nJ/ytD00fcbq3SWt1TufAZIbVRgUB8ucD/PN7FnI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20200818075052epcas2p231cfcb5286cafe1e59d86c15b16058ca~sTWJj_Usr3073630736epcas2p2K;
 Tue, 18 Aug 2020 07:50:52 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.181]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4BW34W4f6ZzMqYkk; Tue, 18 Aug
 2020 07:50:51 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 C5.9D.27013.B588B3F5; Tue, 18 Aug 2020 16:50:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98~sTWHnDs5M3062830628epcas2p1r;
 Tue, 18 Aug 2020 07:50:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200818075050epsmtrp1eec76f890344da64cc22ef3f4c6ac8c4~sTWHkZGom2959829598epsmtrp1L;
 Tue, 18 Aug 2020 07:50:50 +0000 (GMT)
X-AuditID: b6c32a48-2acd6a8000006985-9d-5f3b885b7e0d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 87.09.08303.A588B3F5; Tue, 18 Aug 2020 16:50:50 +0900 (KST)
Received: from KEI.dsn.sec.samsung.com (unknown [12.36.155.227]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200818075050epsmtip1032ad1a46b74017b4fce00a5453f0c6c~sTWHVcUUm2207622076epsmtip1H;
 Tue, 18 Aug 2020 07:50:50 +0000 (GMT)
From: Cho KyongHo <pullip.cho@samsung.com>
To: joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org
Subject: [PATCH 1/2] dma-mapping: introduce relaxed version of dma sync
Date: Tue, 18 Aug 2020 16:43:10 +0900
Message-Id: <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmmW50h3W8wf/VLBbvl/UwWvztvMBq
 sWC/tcXmOcUWnbM3sFtsenyN1eLyrjlsFmuP3GW3+Nd7kNHi4IcnrBYtd0wduD2eHJzH5LFm
 3hpGj02rOtk8Ni+p95h8YzmjR9+WVYwenzfJBbBH5dhkpCampBYppOYl56dk5qXbKnkHxzvH
 m5oZGOoaWlqYKynkJeam2iq5+AToumXmAB2opFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
 Si1IySkwNCzQK07MLS7NS9dLzs+1MjQwMDIFqkzIyZi24BFzwTyfiuNTTrM3MG526GLk5JAQ
 MJF4evAWaxcjF4eQwA5Gic6dN9khnE+MEm9ezmeEcD4zSiz9socZpuXd+7UsEIldjBITb16H
 avnKKLF9dycrSBWbgJbE6rnHGUFsEQFbiZ/fJzKDFDELfGOU2PXjLhNIQljAXeLBx3VgRSwC
 qhL7z7xjAbF5BdwkLmx+xASxTk7i5rlOsGYJgVvsEo1bnrBBJFwk+k//Y4SwhSVeHd/CDmFL
 Sbzsb2OHaJjOKPFu/iGohs2MEt92C0LYxhKznrUDNXMAnaQpsX6XPogpIaAsceQW2A3MAnwS
 HYf/skOEeSU62oQgGlUkdk69xgKzqW/vDRaIEg+JvxPBSoQEYiUuHX3LOIFRdhbC+AWMjKsY
 xVILinPTU4uNCkyQY2kTIzjVaXnsYJz99oPeIUYmDsZDjBIczEoivEknzOOFeFMSK6tSi/Lj
 i0pzUosPMZoCg2sis5Rocj4w2eaVxBuaGpmZGViaWpiaGVkoifO+s7oQJySQnliSmp2aWpBa
 BNPHxMEp1cDUMHkdj1bdzIMvxFLNN0V4XxQ5yDy3h+NzwJUy3hwrrcbz7V/SZguo7bn26MBH
 rqCzNe+zJ09n/Mc7vWv2xeoPHu2ZczaeuaRk//GUSWuqkVumcrjfJzGRE6+KN/fErLsouP4d
 b9A5901TA28f3HDifMviqddt5l+L6p3CemlBSvFs06knivT6jj+fela3k1Hp3DvOkhvGW/xf
 tIsZpuvwvgtK7ip42zMjoMjYqeiDepKIkfXDm5YrWSKm7julVmiovqKK4eHMpYwZyzc+3bh8
 ivaKacfvGa4/ue7qjd0LAu54rdb25bzMvuRxVw6vZJj6ZY+Vq2d+3n7HY8Kz44++3OP9Ksf5
 57vNW6lswReFXEosxRmJhlrMRcWJAPj7+Hv+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsWy7bCSnG5Uh3W8QcNUJYv3y3oYLf52XmC1
 WLDf2mLznGKLztkb2C02Pb7GanF51xw2i7VH7rJb/Os9yGhx8MMTVouWO6YO3B5PDs5j8lgz
 bw2jx6ZVnWwem5fUe0y+sZzRo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDKmLXjEXDDPp+L4
 lNPsDYybHboYOTkkBEwk3r1fy9LFyMUhJLCDUWJW5zFWiISUxLzutUwQtrDE/ZYjrBBFnxkl
 eva8ACtiE9CSWD33OGMXIweHiICjRMN7E5AaZoF/jBJHr3Qzg9QIC7hLPPi4jhHEZhFQldh/
 5h0LiM0r4CZxYfMjqAVyEjfPdTJPYORZwMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/
 dxMjOPS0tHYw7ln1Qe8QIxMH4yFGCQ5mJRHepBPm8UK8KYmVValF+fFFpTmpxYcYpTlYlMR5
 v85aGCckkJ5YkpqdmlqQWgSTZeLglGpgWvpsn6DN45c/Yi5JKAXdPrm/kfHhnehfr7cHX+Ez
 mRry0WNSlAdr5PrqxRZrkvkiGNdbcB3YlF2c82zqmpAbJ3axz9ky5z63W9yVVWfaNTf9tN71
 Pur+erNJIpWbnocyzXzGfVIrZepl122f9503nvnl6E37E1+/LFikf6tOsjT60wenU0Kei2b7
 3+ua5MAWdPq6sKizwYEfU0wmiFztOWZ26Y649Y4yB17+oHkekneq5h4s1Nn8P7etiq10Vmih
 q83b7w5FDY9nmVYuFn/tc7PsS6qV3+ozD+p+R+sV9KVt9+D2r16w16VTqHpjeUavw5G11+9O
 e3vcLvXrutJ3se3vZDmUbLafvFt97d+6Gz+UWIozEg21mIuKEwFE4oStrAIAAA==
X-CMS-MailID: 20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98
References: <CGME20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98@epcas2p1.samsung.com>
Cc: janghyuck.kim@samsung.com, linux-kernel@vger.kernel.org,
 hyesoo.yu@samsung.com, iommu@lists.linux-foundation.org,
 Cho KyongHo <pullip.cho@samsung.com>, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

Cache maintenance operations in the most of CPU architectures needs
memory barrier after the cache maintenance for the DMAs to view the
region of the memory correctly. The problem is that memory barrier is
very expensive and dma_[un]map_sg() and dma_sync_sg_for_{device|cpu}()
involves the memory barrier per every single cache sg entry. In some
CPU micro-architecture, a single memory barrier consumes more time than
cache clean on 4KiB. It becomes more serious if the number of CPU cores
are larger.
This patch introduces arch_sync_dma_for_device_relaxed() and
arch_sync_dma_for_cpu_relaxed() which do not involve memory barrier.
So the users called those functions require explicitly calling
arch_sync_barrier_for_device() and arch_sync_barrier_for_cpu(),
respectively to confirm the view of memory is consistent between the
CPUs and DMAs.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/dma-iommu.c       |  6 +++--
 include/linux/dma-direct.h      | 29 +++++++++++++++++-----
 include/linux/dma-noncoherent.h | 54 +++++++++++++++++++++++++++++++++++++++++
 kernel/dma/Kconfig              |  8 ++++++
 kernel/dma/direct.c             | 25 +++++++++++++++----
 5 files changed, 109 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5141d49..4f9c9cb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -705,7 +705,8 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 		return;
 
 	for_each_sg(sgl, sg, nelems, i)
-		arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
+		arch_sync_dma_for_cpu_relaxed(sg_phys(sg), sg->length, dir);
+	arch_sync_barrier_for_cpu(dir);
 }
 
 static void iommu_dma_sync_sg_for_device(struct device *dev,
@@ -719,7 +720,8 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 		return;
 
 	for_each_sg(sgl, sg, nelems, i)
-		arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
+		arch_sync_dma_for_device_relaxed(sg_phys(sg), sg->length, dir);
+	arch_sync_barrier_for_device(dir);
 }
 
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 6e87225..f5b1fee 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -152,7 +152,7 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
 }
 
-static inline dma_addr_t dma_direct_map_page(struct device *dev,
+static inline dma_addr_t __dma_direct_map_page(struct device *dev,
 		struct page *page, unsigned long offset, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
@@ -172,20 +172,37 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 		return DMA_MAPPING_ERROR;
 	}
 
-	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arch_sync_dma_for_device(phys, size, dir);
 	return dma_addr;
 }
 
-static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
+static inline dma_addr_t dma_direct_map_page(struct device *dev,
+		struct page *page, unsigned long offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	dma_addr_t dma_addr = __dma_direct_map_page(dev, page, offset, size, dir, attrs);
+
+	if (dma_addr != DMA_MAPPING_ERROR && !dev_is_dma_coherent(dev) &&
+	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(page_to_phys(page) + offset, size, dir);
+
+	return dma_addr;
+}
+
+static inline void __dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	phys_addr_t phys = dma_to_phys(dev, addr);
 
+	if (unlikely(is_swiotlb_buffer(phys)))
+		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
+}
+
+static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
 
-	if (unlikely(is_swiotlb_buffer(phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
+	__dma_direct_unmap_page(dev, addr, size, dir, attrs);
 }
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index ca09a4e..0a31e6c 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -73,23 +73,77 @@ static inline void arch_dma_cache_sync(struct device *dev, void *vaddr,
 #endif /* CONFIG_DMA_NONCOHERENT_CACHE_SYNC */
 
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE_RELAXED
+void arch_sync_dma_for_device_relaxed(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
+
+static inline void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
+{
+	arch_sync_dma_for_device_relaxed(paddr, size, dir);
+	arch_sync_barrier_for_device(dir);
+}
+#else
+#define arch_sync_dma_for_device_relaxed arch_sync_dma_for_device
+
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir);
+
+static inline void arch_sync_barrier_for_device(enum dma_data_direction dir)
+{
+}
+#endif /* ARCH_HAS_SYNC_DMA_FOR_DEVICE_RELAXED */
 #else
+static inline void arch_sync_dma_for_device_relaxed(phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
+{
+}
+
 static inline void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
 }
+
+static inline void arch_sync_barrier_for_device(enum dma_data_direction dir)
+{
+}
 #endif /* ARCH_HAS_SYNC_DMA_FOR_DEVICE */
 
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_RELAXED
+void arch_sync_dma_for_cpu_relaxed(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
+
+static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
+{
+	arch_sync_dma_for_cpu_relaxed(paddr, size, dir);
+	arch_sync_barrier_for_cpu(dir);
+}
+#else
+#define arch_sync_dma_for_cpu_relaxed arch_sync_dma_for_cpu
+
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir);
+
+static inline void arch_sync_barrier_for_cpu(enum dma_data_direction dir)
+{
+}
+#endif /* ARCH_HAS_SYNC_DMA_FOR_CPU_RELAXED */
 #else
+static inline void arch_sync_dma_for_cpu_relaxed(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
+{
+}
+
 static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
 }
+
+static inline void arch_sync_barrier_for_cpu(enum dma_data_direction dir)
+{
+}
 #endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
 
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 847a9d1..d6fe727f1 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -59,6 +59,14 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
 	bool
 	select NEED_DMA_MAP_STATE
 
+config ARCH_HAS_SYNC_DMA_FOR_DEVICE_RELAXED
+	bool
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+
+config ARCH_HAS_SYNC_DMA_FOR_CPU_RELAXED
+	bool
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+
 config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 	bool
 
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index db6ef07a..52e5fd1 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -321,9 +321,12 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 					dir, SYNC_FOR_DEVICE);
 
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_device(paddr, sg->length,
+			arch_sync_dma_for_device_relaxed(paddr, sg->length,
 					dir);
 	}
+
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_barrier_for_device(dir);
 }
 #endif
 
@@ -340,15 +343,17 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_cpu(paddr, sg->length, dir);
+			arch_sync_dma_for_cpu_relaxed(paddr, sg->length, dir);
 
 		if (unlikely(is_swiotlb_buffer(paddr)))
 			swiotlb_tbl_sync_single(dev, paddr, sg->length, dir,
 					SYNC_FOR_CPU);
 	}
 
-	if (!dev_is_dma_coherent(dev))
+	if (!dev_is_dma_coherent(dev)) {
+		arch_sync_barrier_for_cpu(dir);
 		arch_sync_dma_for_cpu_all();
+	}
 }
 
 void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
@@ -357,8 +362,11 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 	struct scatterlist *sg;
 	int i;
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_direct_sync_sg_for_cpu(dev, sgl, nents, dir);
+
 	for_each_sg(sgl, sg, nents, i)
-		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
+		__dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
 			     attrs);
 }
 #endif
@@ -370,13 +378,20 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	struct scatterlist *sg;
 
 	for_each_sg(sgl, sg, nents, i) {
-		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
+		sg->dma_address = __dma_direct_map_page(dev, sg_page(sg),
 				sg->offset, sg->length, dir, attrs);
 		if (sg->dma_address == DMA_MAPPING_ERROR)
 			goto out_unmap;
 		sg_dma_len(sg) = sg->length;
 	}
 
+	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
+		for_each_sg(sgl, sg, nents, i)
+			arch_sync_dma_for_device_relaxed(dma_to_phys(dev, sg_dma_address(sg)),
+							 sg->length, dir);
+		arch_sync_barrier_for_device(dir);
+	}
+
 	return nents;
 
 out_unmap:
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
