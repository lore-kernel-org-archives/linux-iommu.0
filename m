Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614691;
	b=TLYWo2YM2P/a4XjFHBn99Jt6XetjohEim0rbGcJR4u97GSDjZdjoInaQDjstDZZ3L+fo
	 kAADoAT1RDv05hT7NRCSRv0sY04iCH7ZWe7vvID3mwefz8EOEyFl+mMFY91DGs5rCJ8Mm
	 voFHZp7ewE8AsrB2ufT/xbrbnNdZJwr2VMmEvD1VL3RhTech62z0m0QCgSK35ZD7qCYVS
	 ugj7FHg0sTNJ/90dRoobBCep2VjJL7XI8voGIaSNTE/rTF7Rv190svs4JybgCXv3CwS80
	 VKzeZhd5g6HsEkHtQX8DqgZFQLwj4TBLJj4tFnxKRVq1EsvLkJFeq+ettGpf6K2sKuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614691;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FKKsaX0iLIihjEs0HiQH6IuZ/cox9XgvibcPxadi8NA=;
	b=DipWfapQLtXO/l89VBcwGok3tVZsn3N6gKL3PO2WUdkoX00ur/WyDszxKEdo0BQ71FOh
	 wHVAUpPKAmsuN5z4+6B801Gx+pACEl+Q5xLu3z/7RL1tW6L6y7h23n+uTm8KFqjZJ50Uh
	 NtfCoYFPKnSf5uU+WkLYOnuFmVU0zIgCGTc+sSsHF/n6ry/DWLb8wkF0c+pAnDn+NcvKG
	 ed/foK70wUKWbSi9rjVy3csKt1HJzEqcCCcjiV2bA7tf59KgiIyje2CmJvLzJWtj1aKFW
	 BgHKRk3X1c15oLvl0rSJHe5aj33L1hj60koLGB+x37NJEjMwvNx+SS6mOSyoe5QfTdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mrw8qz7V;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="CoVybnu/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7D606A31E
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 13:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9F7D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mrw8qz7V;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CoVybnu/
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mOeZ3127120
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 13:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=FKKsaX0iLIihjEs0HiQH6IuZ/cox9Xgvibc
	Pxadi8NA=; b=mrw8qz7VJsviWHPggc/MnckouP9kLpy4wM3ID+zbWiqixOTp9nB
	R6rYFdgJCd1Pu0BinrYzcN31/dtipILpujVSHGRhtAuJR7rBtdfDbStVM7y/04YT
	Xix0uBww7/A4TP4BZ3kxIexEFYKm+9+3w/75QZIq57/GuH++L3ZkHgQKPUp5nfxT
	VJ3OBYR+jVJ/vLPij9tNhMFkhQbMV3QUC2SN0Tg0ylUiKKR2u4UCOCgDtxKEPNqH
	YOoa3rhzMxBFKo6qWAGwCn1qtxwxgT0Xg1py6LQE7h+6pvIPrcBA9SLo+VbhGAim
	fyNsHdn8EykbBNalgqVaqhSKC8IdZI/WcPg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eydcek4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 13:51:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b3f3e256e8so5740934a91.2
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 05:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795614689; x=1796219489; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FKKsaX0iLIihjEs0HiQH6IuZ/cox9XgvibcPxadi8NA=;
        b=CoVybnu/xVLnXGlRy7UVDMtWaJeK73cFn6ayxNsxfgZQTItzj2k5rPO6iQ53UUy1mG
         LSXF2qs+pa2yFmXBEuD9wMH2H2o7wp7lcSzbOTWY5ElvSaqSsLP4CaB5f2OdEfmfO4h3
         7ZAmakqlskay960AhsY3aZXMAV85wnZb79RjThjw1k7dWQTvscQjriiKpYhSQ9EnDnEW
         LhJWRWrizFEiRl438wNbz5s/oDVwy+cUIPP2ckCU4H6gSTsDSPuO6w40hKZhLqAghCyu
         KNG3qvg+pS2w4wNtkHtgFu+WwWTz6H0eL3bMyJVRCN7JO5DZfPJZHE6vpWOI4WeB4lZG
         K1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614689; x=1796219489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKKsaX0iLIihjEs0HiQH6IuZ/cox9XgvibcPxadi8NA=;
        b=wQyhafxWx3PpCQ5Faie9nIVt5G93pWbzRTGRX7bv8SuReuuM7MtxkYiiat6yzzjU1Q
         OpWbn3G8acf9IMKodX/jnWnB9EvC57CqF8NsNuJ3gO6HcYOojTDJrw7mgDOb7K7WJ0Ff
         4J5BSVmxhc/Cd/ZgwT6CbzKZLmyL2D8dDS3ciB+DJwj4NxFkIiFB21Ktlg7agvrYK2Jo
         I+ImrqYMovDSw3BugwhWpU66TjF5GmyFmJZ8+MhYcsGKuC0aZgvS9A7MNXfuUgkv8VT8
         ImTx1c5F2Xf3qiOC9TjExhzP8/xl9n0ngp0RPpmsPSA19uDLWoycoyPTaft7aqVPODW6
         QtKQ==
X-Forwarded-Encrypted: i=1; AL+hErGchONTjVL/uBrbxfFCPyZUzgchH9KzDGgCs60t3CCHcW1DWVRdCYj/KJAbHLKfYzetuCbBZg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9yKtUwD9+QIMKHlgVgoACMCkIA0jOxiSYS58kLtulrNKnGS24f
	a8V121nRsefknCnEnEnslFqbb5CLhO6R2nhqGPm2x5LShm8JnIyVoxLz/gFSAF3snuUHgdKNstI
	MXppDxFBS8024PhIfndYqHFnJBQ5/ZOeH5+ZkZ1z0iyOJzM/NHzz268ZmHg==
X-Gm-Gg: AZFdTZdePicqNFMrZd/AsPw9IhstEXue8N+gEruds+MM9KZHfKccwixxMha8j1rL78g
	+fOFDkK6BdickZ9XccN+WfkICeY039ascgGujZR8eDgvfYbssehXvRfyvBbrz11qJrs+oAfNpsm
	5ilhOFh0rHn8okTlikMGsbpMRvMPvnjY1ZcqUhl8vfe9TEskDvjMa37xHehrByJqyfZNd2yN26Y
	+W8qFIkvEJbgGxxZIRA/tE3OA/P1LfcebYpnPFoJkHxLHWTGygSCvnPn9W/sn5q5VkNkavccRGe
	HJy1eZaVeu8mm0ZrXvO7tf3yUlavQdBFBpa1+6vzAVafsBjrhdJoZmYghlJlKA9PZLYZ6T0jQ/h
	YFKTZRXsuT1l6RUjOistUWOchhbBkCibimiJMHkgLJ8egfLkb+UoDWhLjfT3eaTf9HojFr/+0jY
	7YmnM30qm8UAOI122AWU0dXS1EpH0eYXlR94HyUoOgG0dC+StuXYMat42XOV+rhl29
X-Received: by 2002:a17:90a:e705:b0:3b4:fa3:36de with SMTP id 98e67ed59e1d1-3b41c9750e2mr15507416a91.51.1795614688902;
        Wed, 25 Nov 2026 05:51:28 -0800 (PST)
X-Received: by 2002:a17:90a:e705:b0:3b4:fa3:36de with SMTP id 98e67ed59e1d1-3b41c9750e2mr15507383a91.51.1795614688084;
        Wed, 25 Nov 2026 05:51:28 -0800 (PST)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm27710815a91.4.2026.11.25.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:51:27 -0800 (PST)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: will@kernel.org, robin.murphy@arm.com, m.szyprowski@samsung.com,
        honghuan@amd.com
Cc: joro@8bytes.org, prakash.gupta@oss.qualcomm.com, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] Revert "iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper"
Date: Wed, 25 Nov 2026 19:21:20 +0530
Message-Id: <20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1NSBTYWx0ZWRfX8v12Ya0xd3yh
 4cXHzQJJY/qljDosP8GoZVEWeoGtDzmGNJxhyhtnPpHWr0NKwVlYYw3OBq5smEbs024w7AZQB2R
 +CAv0W7NUBJq3YvmTbLWroq8E+gYxRY=
X-Proofpoint-ORIG-GUID: SYvZiSCAGiti8wKA6PVsBfEQkJqdBQIz
X-Proofpoint-GUID: SYvZiSCAGiti8wKA6PVsBfEQkJqdBQIz
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b06e7e1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=cR5wH3shGYeZUv4u9kAA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1NSBTYWx0ZWRfX9F5BDHRobwuw
 ivf8cPzCf6/u4r9z25UNHTMPw9v7bSJ0/kkrIAHkX8BmKNWpeNgsKEB7Ug5JRLy4btvdSaEvD9+
 4NBX6Hia6NMLFEjakdMJwhaYVhuZ8Q4HNVWlke/HvC+tCwHSMzEzAhq02dCK8dwHPOeGMQvZWw0
 70UYmLC0IEfFAebAQcAjbg+tafJCoYVlViVRPPfV5lVElgO4ny/F4T0RMrlu8JULC3D4GFQK6UQ
 KTXrTMTSlw8FAxxeCWCbbKVmNbuzWYggCfm3dmkzqpD1Wme9mL5qI+tPNaS6ChvkShKkq7LXbXI
 6KHCfiGRT+ADc/rVtHndA4InyoSOLEGbm4QN8RYNsapfUFIOwpMy9lWHNLST8uDmb6rP+Uxya6g
 B/AEVJKcTgEUcseruhsKTw3239VK3aGalMkqLY+0/l7OOHEK2TkUVNbl9JK8X/22bzvAp5uTaI4
 RUFW4xzgs2aupMk0vDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250055

This reverts commit 1acce29926d93f3eba427696fe3da6451504dae2.

Before this commit, dma_iova_destroy() unmapped through
__iommu_dma_iova_unlink(..., free_iova=true), which set
iotlb_gather.queued from cookie->fq_domain, skipped iommu_iotlb_sync()
and freed the IOVA with the queued gather, exactly like
__iommu_dma_unmap(). After it, dma_iova_destroy() calls
dma_iova_unlink() and then dma_iova_free():

  - dma_iova_unlink() never marks its gather as queued and always calls
    iommu_iotlb_sync() after iommu_unmap_fast().
  - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
    the IOVA goes straight back to the allocator through
    free_iova_fast() and never through queue_iova().

DMA-FQ domains therefore get strict invalidation on this path. That
includes the block layer's blk_rq_dma_map() path, which NVMe uses for
all data transfers, so iommu.strict=0 has no effect on NVMe I/O.

hw/sw details: Qualcomm Glymur CRD: SMMUv3 with no RANGE_INV,
	       4K pages; NVMe SSD on PCIe Gen5 x4

Fio sequential read/write numbers:
  Domain                          seq write    seq read
  DMA (strict)                    2694 MiB/s   2693 MiB/s
  DMA-FQ (lazy), flush queue      2707 MiB/s   2803 MiB/s
    bypassed (this regression)
  DMA-FQ (lazy), flush queue      10.6 GiB/s   11.9 GiB/s
    used by dma_iova_destroy()

Fixes: 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 drivers/iommu/dma-iommu.c | 57 ++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b66e83cfbc5f..e71a10e14c36 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2101,20 +2101,10 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 		arch_sync_dma_flush();
 }
 
-/**
- * dma_iova_unlink - Unlink a range of IOVA space
- * @dev: DMA device
- * @state: IOVA state
- * @offset: offset into the IOVA state to unlink
- * @size: size of the buffer
- * @dir: DMA direction
- * @attrs: attributes of mapping properties
- *
- * Unlink a range of IOVA space for the given IOVA state.
- */
-void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
-		size_t offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
+static void __iommu_dma_iova_unlink(struct device *dev,
+		struct dma_iova_state *state, size_t offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs,
+		bool free_iova)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -2130,13 +2120,35 @@ void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
 		iommu_dma_iova_unlink_range_slow(dev, addr, size, dir, attrs);
 
 	iommu_iotlb_gather_init(&iotlb_gather);
+	iotlb_gather.queued = free_iova && READ_ONCE(cookie->fq_domain);
 
 	size = iova_align(iovad, size + iova_start_pad);
 	addr -= iova_start_pad;
 	unmapped = iommu_unmap_fast(domain, addr, size, &iotlb_gather);
 	WARN_ON(unmapped != size);
 
-	iommu_iotlb_sync(domain, &iotlb_gather);
+	if (!iotlb_gather.queued)
+		iommu_iotlb_sync(domain, &iotlb_gather);
+	if (free_iova)
+		iommu_dma_free_iova(domain, addr, size, &iotlb_gather);
+}
+
+/**
+ * dma_iova_unlink - Unlink a range of IOVA space
+ * @dev: DMA device
+ * @state: IOVA state
+ * @offset: offset into the IOVA state to unlink
+ * @size: size of the buffer
+ * @dir: DMA direction
+ * @attrs: attributes of mapping properties
+ *
+ * Unlink a range of IOVA space for the given IOVA state.
+ */
+void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
+		size_t offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	 __iommu_dma_iova_unlink(dev, state, offset, size, dir, attrs, false);
 }
 EXPORT_SYMBOL_GPL(dma_iova_unlink);
 
@@ -2157,13 +2169,14 @@ void dma_iova_destroy(struct device *dev, struct dma_iova_state *state,
 		unsigned long attrs)
 {
 	if (mapped_len)
-		dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs);
-
-	/*
-	 * We can be here if the first call to dma_iova_link() failed and
-	 * there is nothing to unlink, so let's be more clear.
-	 */
-	dma_iova_free(dev, state);
+		__iommu_dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs,
+				true);
+	else
+		/*
+		 * We can be here if first call to dma_iova_link() failed and
+		 * there is nothing to unlink, so let's be more clear.
+		 */
+		dma_iova_free(dev, state);
 }
 EXPORT_SYMBOL_GPL(dma_iova_destroy);
 
-- 
2.34.1

