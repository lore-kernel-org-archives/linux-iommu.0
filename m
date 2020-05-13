Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EF3C2D0FD
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423C2207C3
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 13:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VKrLxF3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423C2207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4041088D58;
	Wed, 13 May 2020 13:33:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b3cnYrcoQ-7Z; Wed, 13 May 2020 13:33:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 393788920C;
	Wed, 13 May 2020 13:33:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18877C0891;
	Wed, 13 May 2020 13:33:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9417BC088F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8BDCD86FA3
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id idUaFivBNbYj for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 13:33:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 109FD86FC9
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:33:00 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133257euoutp014364644aad0d5680488f41bef20c36eb~OmcIn8yfN2146121461euoutp01y
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 13:32:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200513133257euoutp014364644aad0d5680488f41bef20c36eb~OmcIn8yfN2146121461euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376777;
 bh=SMTxZNZpTSAf+VjaRdwIa7Y+Y92ELOA8MjwAFVO+Mus=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VKrLxF3KEiWmVZ1axlhSlzty0rd2nUqXsHuI7B7LU28r5TvCvsp+0bgDe4vtq9QOY
 WiKZcd124gvPVjK5otBDPFZ8OFs4Ng94v6RMIBwxoj8zDX9Eu+NKd2eBdrnLRwwAaZ
 2zo3AcPWxR1hl6t0/nrmIY5WXFjlcZ6Vzn2OE+7A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200513133257eucas1p1ab88f1465f6ce76a0c7f470a63001ea2~OmcIUwDTB0876608766eucas1p1h;
 Wed, 13 May 2020 13:32:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id FD.B5.61286.907FBBE5; Wed, 13
 May 2020 14:32:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200513133256eucas1p273110d0c8f67e52fc7385acef776efaa~OmcH5dMRP0359403594eucas1p2L;
 Wed, 13 May 2020 13:32:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133256eusmtrp11bf699394ab06f7b9d70d588c796f3dc~OmcH4xvA20994509945eusmtrp1W;
 Wed, 13 May 2020 13:32:56 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-28-5ebbf709f135
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id B7.0A.08375.807FBBE5; Wed, 13
 May 2020 14:32:56 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133256eusmtip10a029b12870de4156e2e5b8913fad120~OmcHTRPCk2465024650eusmtip1_;
 Wed, 13 May 2020 13:32:56 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/38] dma-mapping: add generic helpers for mapping
 sgtable objects
Date: Wed, 13 May 2020 15:32:08 +0200
Message-Id: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513132114.6046-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju29nZzqbT45R80UyYJGSpSf04MLPCfpz+RAVZCpkrD2ptajte
 +6Moai0NL5XDUsS8OzUvaUzFHNkUaZSaTPOaFZbZwltYoG0erX/P7X2f7/v4CExajbsRMbEJ
 jDpWoZQJxPyO1xsmX9GvrvAjwzPOVJ5pkEe1aJtxaqujAKNG1ywCqq6hn0eV98qp1dE5HtU6
 P4ZTI/onAqrx1ZSQ6vv5CT9pR+vKdIjuWS/n053rszg9c8/Io9sq0+gPm/MYXWSuQXTXeLqA
 vt9ej+iV1v3nxGHiwEhGGZPEqP2DIsTRedn1KL7JO+VBZjWejno8NUhEAHkMzMZapEFiQkrW
 IuhbsAhthpRcRTC4xeOMFQTlOj3anfg+t8znjBoEj+pKd4h1ouJ9Js+WEpABoFnSCGzYhcxC
 MJBnb8MYqeVB/2KiDTuTl6HMMLq9lU8egIovOsyGJWQgGAe0ONfmCQ3PXm7rIvI4LD/fwG1l
 QDYJ4anFaC0jrOQ0zLyhuLwzfDO2Czm8D4aKcvlcPhPBnKlRyJFcBCMZ2p37yGHS9FtgW4SR
 B6FZ78/Jp8BUqMe5/Q5gXnLizu8AhR3FGCdL4E62lEt7Q4mx6V9t39thjMM0tC+27bxiPoJ2
 8yDKR54l/8vKEapHrkwiq4pi2IBYJtmPVajYxNgov+txqlZk/T1Dm8blF2ht+JoBkQSS2Uuo
 ia5wKa5IYlNVBgQEJnORnG22SpJIReptRh13VZ2oZFgDcif4MlfJ0YqvV6RklCKBuckw8Yx6
 1+URIrd0hO9Jsp8oyDhx2P9jWkujV+g7cw3sveDhkdDL5FQ5uKvOB1eG6lLsSkM0d32TJmYV
 cWeSu8URh5zAyzF1hk3rnizOueW5EPRHqZ2XpGT/yCzqlVvknXaPLzo+ZNDspc35YGHVWOf0
 Z33bjfGpwKy4kNaSaQsVUqca8MnNlYcVyfhstCLAB1Ozir/3t71COQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4XV2O77vjDCb9MbLoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZrH2yF12i4MfnrA6cHusmbeG
 0WPvtwUsHtu/PWD1uN99nMlj85J6j9v/HjN7TL6xnNFj980GNo++LasYPT5vkgvgitKzKcov
 LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL6G1bxViwTq1i
 SvMy1gbGvfJdjJwcEgImEm8efmLpYuTiEBJYyijxasFTVoiEjMTJaQ1QtrDEn2tdbBBFnxgl
 3h14DpZgEzCU6HoLkRAR6GSUmNb9kR3EYRaYxySx6OEhdpAqYYEwiZ0ftoHZLAKqEouerWEG
 sXkFbCSOn5gBtUJeYvWGA2BxTgFbiU9bf4LFhYBq1rbOYZvAyLeAkWEVo0hqaXFuem6xoV5x
 Ym5xaV66XnJ+7iZGYDxsO/Zz8w7GSxuDDzEKcDAq8fBa3NodJ8SaWFZcmXuIUYKDWUmE1289
 UIg3JbGyKrUoP76oNCe1+BCjKdBRE5mlRJPzgbGaVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZI
 ID2xJDU7NbUgtQimj4mDU6qBMaSi692hcinJ34t2HWxjfe1+2VN/o1/Uu6n6q+MfJNzYYd+y
 f00hzz4Z6V1fjF4fPrAveW7xvIJpB6LWr0/nf+uv6ye37IqIcPXl83lKdwIYk5RO7boQpFHR
 sXx1oEHYzjvRWp+dGJ8EuNV/jedZ3idy947AAeGUS0fPXd6cFXHQk3/htv97piuxFGckGmox
 FxUnAgDvD09CnQIAAA==
X-CMS-MailID: 20200513133256eucas1p273110d0c8f67e52fc7385acef776efaa
X-Msg-Generator: CA
X-RootMTR: 20200513133256eucas1p273110d0c8f67e52fc7385acef776efaa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133256eucas1p273110d0c8f67e52fc7385acef776efaa
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <CGME20200513133256eucas1p273110d0c8f67e52fc7385acef776efaa@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

struct sg_table is a common structure used for describing a memory
buffer. It consists of a scatterlist with memory pages and DMA addresses
(sgl entry), as well as the number of scatterlist entries: CPU pages
(orig_nents entry) and DMA mapped pages (nents entry).

It turned out that it was a common mistake to misuse nents and orig_nents
entries, calling DMA-mapping functions with a wrong number of entries or
ignoring the number of mapped entries returned by the dma_map_sg
function.

To avoid such issues, let's introduce a common wrappers operating directly
on the struct sg_table objects, which take care of the proper use of
the nents and orig_nents entries.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com> 
---
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 include/linux/dma-mapping.h | 78 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b43116a..b50fe36 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -609,6 +609,84 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 	return dma_sync_single_for_device(dev, addr + offset, size, dir);
 }
 
+/**
+ * dma_map_sgtable - Map the given buffer for DMA
+ * @dev:	The device for which to perform the DMA operation
+ * @sgt:	The sg_table object describing the buffer
+ * @dir:	DMA direction
+ * @attrs:	Optional DMA attributes for the map operation
+ *
+ * Maps a buffer described by a scatterlist stored in the given sg_table
+ * object for the @dir DMA operation by the @dev device. After success
+ * the ownership for the buffer is transferred to the DMA domain. One has
+ * to call dma_sync_sgtable_for_cpu() or dma_unmap_sgtable() to move the
+ * ownership of the buffer back to the CPU domain before touching the
+ * buffer by the CPU.
+ * Returns 0 on success or -EINVAL on error during mapping the buffer.
+ */
+static inline int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	int n = dma_map_sg_attrs(dev, sgt->sgl, sgt->orig_nents, dir, attrs);
+
+	if (n <= 0)
+		return -EINVAL;
+	sgt->nents = n;
+	return 0;
+}
+
+/**
+ * dma_unmap_sgtable - Unmap the given buffer for DMA
+ * @dev:	The device for which to perform the DMA operation
+ * @sgt:	The sg_table object describing the buffer
+ * @dir:	DMA direction
+ * @attrs:	Optional DMA attributes for the unmap operation
+ *
+ * Unmaps a buffer described by a scatterlist stored in the given sg_table
+ * object for the @dir DMA operation by the @dev device. After this function
+ * the ownership of the buffer is transferred back to the CPU domain.
+ */
+static inline void dma_unmap_sgtable(struct device *dev, struct sg_table *sgt,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	dma_unmap_sg_attrs(dev, sgt->sgl, sgt->orig_nents, dir, attrs);
+}
+
+/**
+ * dma_sync_sgtable_for_cpu - Synchronize the given buffer for CPU access
+ * @dev:	The device for which to perform the DMA operation
+ * @sgt:	The sg_table object describing the buffer
+ * @dir:	DMA direction
+ *
+ * Performs the needed cache synchronization and moves the ownership of the
+ * buffer back to the CPU domain, so it is safe to perform any access to it
+ * by the CPU. Before doing any further DMA operations, one has to transfer
+ * the ownership of the buffer back to the DMA domain by calling the
+ * dma_sync_sgtable_for_device().
+ */
+static inline void dma_sync_sgtable_for_cpu(struct device *dev,
+		struct sg_table *sgt, enum dma_data_direction dir)
+{
+	dma_sync_sg_for_cpu(dev, sgt->sgl, sgt->orig_nents, dir);
+}
+
+/**
+ * dma_sync_sgtable_for_device - Synchronize the given buffer for DMA
+ * @dev:	The device for which to perform the DMA operation
+ * @sgt:	The sg_table object describing the buffer
+ * @dir:	DMA direction
+ *
+ * Performs the needed cache synchronization and moves the ownership of the
+ * buffer back to the DMA domain, so it is safe to perform the DMA operation.
+ * Once finished, one has to call dma_sync_sgtable_for_cpu() or
+ * dma_unmap_sgtable().
+ */
+static inline void dma_sync_sgtable_for_device(struct device *dev,
+		struct sg_table *sgt, enum dma_data_direction dir)
+{
+	dma_sync_sg_for_device(dev, sgt->sgl, sgt->orig_nents, dir);
+}
+
 #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
 #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
