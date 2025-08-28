Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9333EC
	for <iommu@lists.linux.dev>; Thu, 28 Aug 2025 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369062; cv=none; b=rFcNzYnORe++MdYJtlpMd/yEWwwDC5Rs1aRbtwaY6GtZU0aIosnJDJZ01xpWMNgujX5oEGF9rcPQARbHGglCe2Kg60y3QBnlONc/TEhUUuAs02eYsDT359ZexQYAwA6wm+pasrahbqXLTASTXNs7PqPjQx48g6RlT/AzCmYumLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369062; c=relaxed/simple;
	bh=FKTWsdA6IZ93bSaQhX1pWr9LY3oqj3IddAD/RuxzfsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S7gQuK1Rwj9EFMKbckilopKfdGBDT+wN8X3NR/G7GOlU+eC2DUaIUIwUFXWQHFqkGM9bBQouZM54HMh68YpworX6VEMX2AtHoeEIyibaXwRexgItZ+g3vIFnNF1EvnHtAVUcp41EPSIu1k6INkIo5Z+QKkX6S9Zl4NSv3Xv7X8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WC6Inp+I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WC6Inp+I"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S4pwj3029265
	for <iommu@lists.linux.dev>; Thu, 28 Aug 2025 08:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rzoIR8Y5Bui+pM/FURb8FN
	MSIseTPwwe7QtZJ+qN7HU=; b=WC6Inp+I5iyjXHCXhJaZbIM/pL9qCBVKhlxORP
	QrG/g0ECMmukHZkkLf8wEEkcH50+P+f2nYm2Yr40ahueXGhrJ1q57TKrZh8eMeqJ
	aIwufa7OIH43wvVB+ZoVPDTqwvc5Tve2wXvPzf7uv7YqVEBoi53xR3ufcS+nOXEz
	T3lOrFC62eY0HxS2Ur0cul8YYbmwEpaXrJSvRQH1IbpJiIxdByVaLTxfoiBPj6/+
	y828RvHi1H/ffhMr0zpefU7LrKGoXQlfchS7firq9kdVBr28os9exubtM2+e683K
	NBS+6YXlm8PLnQz/S4kuMskdLwrbes21oKVEYPFPNSkgAzxA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2ynr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 28 Aug 2025 08:17:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso645304b3a.2
        for <iommu@lists.linux.dev>; Thu, 28 Aug 2025 01:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756369059; x=1756973859;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzoIR8Y5Bui+pM/FURb8FNMSIseTPwwe7QtZJ+qN7HU=;
        b=vk8yAog/zVtSUKntL9iRhUrsKDi7iLzV8TtwA8CffiVu1k6ZwURF2Z3XQ1rpzeQkGz
         vIc6W2UC2R3Y8bwBIQ5wH5Pmn5ql5plr1yvmOtlWN38Jk/kJCjLbjTuPLCKVixKjdun8
         3c9IWTcR1SB01eVdBNqeVURm9FjnIwN05fpzxX97x/9CvZDSc3RHBYS+qD0Zj0rJ51B2
         xbverMPW6lE39g54kyD4GenjuTwRuBLdqksfZ3mpyVkYF7/9NE7DYl1uJozgc4eHZ59k
         Yy2jcfwG5wIzT1IKQmcRO71xmcoNYdllWMXSOOweXmTP1BYJk1zpTyBU95g8yOlEXSAs
         1f9g==
X-Gm-Message-State: AOJu0YyJXQHakE1bJUB455Ncg+hdIwt7wrNx1JYU0AugHDbs+EpVrA6/
	aYy1DUbd2W8+Sqd0rU8YhJ/I+fJEo7thoQdTFAB+6QwU4rQ6GTdSOMM/3I8SRfPtF6oNbOSHdUG
	cXY5syiY3HZyRxTPqmB268GG/x/2jWKeQruuOm1GUZOT6iEDGgrg0xtPy9g==
X-Gm-Gg: ASbGncuEZQapV0YLJDaokfO+Dkdbit+kQYeYK67SdgZfnk24dcSA3BUCKsxSHj8bgyZ
	TN+EVpflzNAPdQ3HUrB890ANju+CORjGic/bbAVlNlYKf1v1zOpz5H7xYYjvzeqGYE7DliZgJhP
	/D9fSTZvYvlueuhTyuxz0IihXZn0JnxVNRdvbbJP1/Q/Rn6Kygi2v4/bSV8ZsiZfTvDhTlEViIX
	dv2LF+plzph03yKyM6hoSh7CMj0v9EkcM8W2F0lHntnYw3odOjH3uTeNJP9foUl5ZGtufmLAdmS
	/8EsR1DY1Hgti8qIiwtHWWM35FcKeMW/fPPKPwGOF4gjPfMn8qvQXTpFXGdF0mPT/vQhPdLNG41
	r0MnyIYx/ygd2TNDP8g==
X-Received: by 2002:a05:6a20:748e:b0:240:2371:cffd with SMTP id adf61e73a8af0-24340ad0a5dmr32409016637.7.1756369059245;
        Thu, 28 Aug 2025 01:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqlqgsl1b6t+N/20ARa3vSPPvbvMXiHdm2s9sVXuPscBZ3EF0CG4+/NyoOtw2wh5z3z36jow==
X-Received: by 2002:a05:6a20:748e:b0:240:2371:cffd with SMTP id adf61e73a8af0-24340ad0a5dmr32408984637.7.1756369058748;
        Thu, 28 Aug 2025 01:17:38 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7c0e0sm13474213a12.37.2025.08.28.01.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:17:38 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 16:17:33 +0800
Subject: [PATCH] dma-debug: don't enforce dma mapping check on noncoherent
 allocations
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dma-debug-fix-noncoherent-dma-check-v1-1-76e9be0dd7fc@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJwQsGgC/x2N0QqDMBAEf0XuuQcaTIn9FemDTbbmKL1IolIQ/
 73Bx2GHnYMKsqDQozkoY5ciSSt0t4Z8nHQGS6hMpjW2dcZx+E4c8NpmfsuPNalPERm6XouP8B9
 2uA+dDdb1Q0/1acmo8lUZn+f5B3xgwQJ1AAAA
X-Change-ID: 20250828-dma-debug-fix-noncoherent-dma-check-8e6915d58494
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68b010a4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lGNrSFP5dTkWF7ljvXsA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXyAiaS8GnQBYf
 ynTY5hXK0eN4Kp+Yw5mC90p3lKTChYA01P5khAiP30vRAoVOy3EuKMsC7YJDErSzpvqzXr0zr0D
 7VHjpPhW0uWj5Ah3FG2x6Tk1tENCuJo2rVw4QYRW1zMbuprNoT3rtd2dstRLv6pO+3+lIYwb0aB
 HOd0Aw2PVI0AN4dLi0RAkqcwE44BeehJ0s1O0qW8qD+ENtSMcKA6N0kZQsLNm+LrH2/0usRdcza
 FmrySbtjTZrQ5pZT3axghKFuLIdFM9lrDfJZQJlI68YaLMYNSaGU9K4f5QKzI/mkyn9IfM2nzAj
 wUBewgD0XWGbLTOw7jKThi79KAtyyuLGWVMf9+G8LnLFescRoYYdH67K+6tS3nCbfgqee1B1gFk
 FB3yotTo
X-Proofpoint-GUID: cwE44690dZnY2A_uZjD1niAdfB6P4nxE
X-Proofpoint-ORIG-GUID: cwE44690dZnY2A_uZjD1niAdfB6P4nxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

As discussed in [1], there is no need to enforce dma mapping check on
noncoherent allocations, a simple test on the returned CPU address is
good enough.

Add a new pair of debug helpers and use them for noncoherent alloc/free
to fix this issue.

Fixes: efa70f2fdc84 ("dma-mapping: add a new dma_alloc_pages API")
Link: https://lore.kernel.org/all/ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com # 1
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 kernel/dma/debug.c   | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/dma/debug.h   | 20 ++++++++++++++++++++
 kernel/dma/mapping.c |  4 ++--
 3 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index e43c6de2bce4e7d3e58f8d9601a7637d8f6da767..b82399437db03116a396c7d1cebd16b2e1af98c3 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -39,6 +39,7 @@ enum {
 	dma_debug_sg,
 	dma_debug_coherent,
 	dma_debug_resource,
+	dma_debug_noncoherent,
 };
 
 enum map_err_types {
@@ -141,6 +142,7 @@ static const char *type2name[] = {
 	[dma_debug_sg] = "scatter-gather",
 	[dma_debug_coherent] = "coherent",
 	[dma_debug_resource] = "resource",
+	[dma_debug_noncoherent] = "noncoherent",
 };
 
 static const char *dir2name[] = {
@@ -993,7 +995,8 @@ static void check_unmap(struct dma_debug_entry *ref)
 			   "[mapped as %s] [unmapped as %s]\n",
 			   ref->dev_addr, ref->size,
 			   type2name[entry->type], type2name[ref->type]);
-	} else if (entry->type == dma_debug_coherent &&
+	} else if ((entry->type == dma_debug_coherent ||
+		    entry->type == dma_debug_noncoherent) &&
 		   ref->paddr != entry->paddr) {
 		err_printk(ref->dev, entry, "device driver frees "
 			   "DMA memory with different CPU address "
@@ -1581,6 +1584,49 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	}
 }
 
+void debug_dma_alloc_pages(struct device *dev, struct page *page,
+			   size_t size, int direction,
+			   dma_addr_t dma_addr,
+			   unsigned long attrs)
+{
+	struct dma_debug_entry *entry;
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	entry = dma_entry_alloc();
+	if (!entry)
+		return;
+
+	entry->type      = dma_debug_noncoherent;
+	entry->dev       = dev;
+	entry->paddr	 = page_to_phys(page);
+	entry->size      = size;
+	entry->dev_addr  = dma_addr;
+	entry->direction = direction;
+
+	add_dma_entry(entry, attrs);
+}
+
+void debug_dma_free_pages(struct device *dev, struct page *page,
+			  size_t size, int direction,
+			  dma_addr_t dma_addr)
+{
+	struct dma_debug_entry ref = {
+		.type           = dma_debug_noncoherent,
+		.dev            = dev,
+		.paddr		= page_to_phys(page),
+		.dev_addr       = dma_addr,
+		.size           = size,
+		.direction      = direction,
+	};
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	check_unmap(&ref);
+}
+
 static int __init dma_debug_driver_setup(char *str)
 {
 	int i;
diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
index f525197d3cae605aa7e0499eb2ca6f1ae134ec93..48757ca13f31403f58090e1015de828893b8f94f 100644
--- a/kernel/dma/debug.h
+++ b/kernel/dma/debug.h
@@ -54,6 +54,13 @@ extern void debug_dma_sync_sg_for_cpu(struct device *dev,
 extern void debug_dma_sync_sg_for_device(struct device *dev,
 					 struct scatterlist *sg,
 					 int nelems, int direction);
+extern void debug_dma_alloc_pages(struct device *dev, struct page *page,
+				  size_t size, int direction,
+				  dma_addr_t dma_addr,
+				  unsigned long attrs);
+extern void debug_dma_free_pages(struct device *dev, struct page *page,
+				 size_t size, int direction,
+				 dma_addr_t dma_addr);
 #else /* CONFIG_DMA_API_DEBUG */
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
@@ -126,5 +133,18 @@ static inline void debug_dma_sync_sg_for_device(struct device *dev,
 						int nelems, int direction)
 {
 }
+
+static inline void debug_dma_alloc_pages(struct device *dev, struct page *page,
+					 size_t size, int direction,
+					 dma_addr_t dma_addr,
+					 unsigned long attrs)
+{
+}
+
+static inline void debug_dma_free_pages(struct device *dev, struct page *page,
+					size_t size, int direction,
+					dma_addr_t dma_addr)
+{
+}
 #endif /* CONFIG_DMA_API_DEBUG */
 #endif /* _KERNEL_DMA_DEBUG_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 107e4a4d251df65fb86a1d7302261c31138061b7..56de28a3b1799f7c18f7e3f8e5ecd438c5748677 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -712,7 +712,7 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 	if (page) {
 		trace_dma_alloc_pages(dev, page_to_virt(page), *dma_handle,
 				      size, dir, gfp, 0);
-		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle, 0);
+		debug_dma_alloc_pages(dev, page, size, dir, *dma_handle, 0);
 	} else {
 		trace_dma_alloc_pages(dev, NULL, 0, size, dir, gfp, 0);
 	}
@@ -738,7 +738,7 @@ void dma_free_pages(struct device *dev, size_t size, struct page *page,
 		dma_addr_t dma_handle, enum dma_data_direction dir)
 {
 	trace_dma_free_pages(dev, page_to_virt(page), dma_handle, size, dir, 0);
-	debug_dma_unmap_page(dev, dma_handle, size, dir);
+	debug_dma_free_pages(dev, page, size, dir, dma_handle);
 	__dma_free_pages(dev, size, page, dma_handle, dir);
 }
 EXPORT_SYMBOL_GPL(dma_free_pages);

---
base-commit: 95bf875b89b48a95a82aca922eeaf19d52543028
change-id: 20250828-dma-debug-fix-noncoherent-dma-check-8e6915d58494

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>

