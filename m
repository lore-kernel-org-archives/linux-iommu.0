Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D5347BC6
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784604565; cv=none; b=NH8h2TaRe8GWyiOIlu4Qpx/AqD6T32zbMzLds7U/+qbFUUtlofmhhYzlxfLFlG8vCMX4cvOmdDXyLmVAYYXLlO+NiUASA5XmbVVgJOOxuNFp7042YgJWLk1VpCgUknKg+LM7xzcQznEHxJwwC0ByL2KSZOyJ1SAjl/3aVgn+gV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784604565; c=relaxed/simple;
	bh=iQENjz2aD+E2LxJmhb/iHAv2mFP6+K7Z8RGian/+A7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PQ5szjTDQ8Gzn8kmeS2F1anyW8y341OeQfZO0Kh9kNTT8I8HXQOOzCRbc4wsxBxZcO1IhVIfUODqmuZUte6Qy/e4JuW2iT4tHCTLOOeQnSIprAgrargsZTjnRIfyMfZDqQAUXfHWGPgUm8hd0NF9o6ga1GS9gGfbQOVDtRReHCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZeiFOMn4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G0acj0nf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZeiFOMn4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G0acj0nf"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNCwWZ4107655
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 03:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KqQMsNhRCbeI5u9fEKfR7i
	/tm3cnPCJCIGYqg75x0YQ=; b=ZeiFOMn4TwG6Qv8Xcwj4m7wlH/bo/lEE64iNRk
	RNuatLLOko+kxHb1VCEoqZS86xIXDlLdQz63sTPMpn9MInm4bRgcV6+WpT3hWbpp
	gU50KpfaZ1BrIeFcDDNfTlWQp432s3j4aCiuhKSztlv81zuDUPotuuZbzQD5BiLW
	pDYPX71eDU2eafnOCElcdqfM+oR3kxDPAtMtpXZtWIszpdtmRmUZjozYtClAX4HK
	oboL/Srpdxp/BjCnrt69ydqI2ohW89JC3cliobfx+pFICPafxgVNbcSCWIUs+Tjz
	ZDxRBKiZnAgT5Dh2MWEn0xJeGCzeVTqYCQV0nW1c29bwKuAQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhvqn8u94-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 03:29:22 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso2186613a12.0
        for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 20:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784604561; x=1785209361; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KqQMsNhRCbeI5u9fEKfR7i/tm3cnPCJCIGYqg75x0YQ=;
        b=G0acj0nf4ZNLYC+y1qYfuQYS/RDS+Ih1QEb4mjmiZY1sBhfV/7vtfLiMUjTqCoktt2
         Jsoce2wtvSc/siVvpeV0Lfw0rsMx3D4W8s2rAAArjP5B3aZQCubOJFlY7hFBqvyKepsR
         Ox3dcGgqonjyJF/KyiyDbmcyJfbmV2Qqrk64fe02r/7wwwJ21b69ymFUSufpvPyYe9sb
         9+xRrWef7KXg7+lJaQpylQnbqVgT5gCgDEljgc8Xgjl4EYTxE2ArtD5Szq2ZgsNEixs0
         yAX/f0fC6lcg3dTvfbqNY6XEQGEVor/eVmNturRSi/1+x4h3yu1jLzXIzcPwlxqttN/z
         Ck6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784604561; x=1785209361;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KqQMsNhRCbeI5u9fEKfR7i/tm3cnPCJCIGYqg75x0YQ=;
        b=kyA9Fwdvmm1gX/f/t8sBY+ZDQ5e8ZcQdbSq8EPGUy4KYoLBhTLxPvBFsWOza+yY5n1
         b04253UzE+XrmI1KeM+FNVU9Q0CzZj9An/TEJ+zTbkSVEpDX5RUJfZAKXtVHOXwCNuC3
         ganEpMzzg9zWBuUkatgcX4+kK4FfXHpLiyNjnggd9r/+xj9nhcj7/iVQpSJycatXn7Qb
         byrKPlpklw42sgE1FZt2UXHtAJxYzCfeyje/MkNx+LSXFFnR7+Xe97MM5j/IZdDIIwUd
         e9EKqHYdoqBgZh5c2uivaOPanWry87VJGfDttuyifULDs3hEKkqsFwIvvHLOV7imHvXo
         CbHg==
X-Forwarded-Encrypted: i=1; AHgh+RpBRmVnu5iBnLUfeCx1RTa99XTj4JkojehnK54Lny6GnPvnwfgatjiCMRelLMQvXaFM+W8zew==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYL01PGuems2Rea1NVKZdI1VLO8xD1sOyxp/U6L633Gu3PN4X8
	IsdS0J2+f82qLqp6bJsd4drYUyINrkzr/qq7T7+Zpu9Vv1rJhp/hAj/ZlBdnCQpOgLk5/fGox9H
	uQKMmeFzyeHABWIM+OqvHZ0uG3FHo3/OUVJm9ex4vbj0dslLY/WnGPQvvPS/brZsCZg==
X-Gm-Gg: AfdE7cletbkrB445ZdmGVLvgQtwYD0pv0KD1fiqdQtetS6ZKwVV013nD9T1KvqNZnWn
	Map5d9E+Q737hV3xZwjGoUCGiP5CBi7uLl7Xxn77+d/iVYDOFFTsVBwO/OLxh98uXmwNZbhNDyq
	vGoh+ttGbaS1t8UUKgWM6K2JsdHmiDwYL89ML8Vp1pLJU4ERCnCKJj6qzbWlCXKv+XokGPm/wpm
	j6bLT/TEK4D1D6wOPm7WXl1tTOjBKyfgpX85yWlEeh1L9oy1i70SRg+Zr4940AqQlXRik7N2sbo
	QoV2B8ZyP02nWDUhi6R0dSFFTEwtN/BVI9+EOuIUuvgqLhH9w8eil6dEMXVeg393wyq6Ae9c1xl
	orh7hNVvcCIb/Jo0V7TsT8LM50pzX40rU+qs=
X-Received: by 2002:a05:6a21:7d06:b0:3c3:8b83:f19f with SMTP id adf61e73a8af0-3c3ada9e4acmr15849487637.60.1784604561455;
        Mon, 20 Jul 2026 20:29:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:7d06:b0:3c3:8b83:f19f with SMTP id adf61e73a8af0-3c3ada9e4acmr15849458637.60.1784604560900;
        Mon, 20 Jul 2026 20:29:20 -0700 (PDT)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2a129f3sm32964265c88.7.2026.07.20.20.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 20:29:20 -0700 (PDT)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 08:58:47 +0530
Subject: [PATCH v2] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-iommu_contig_hint-v2-1-90c731a41163@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAG7nXmoC/32NQQ6CMBBFr0JmbQmtgODKexhCSh1gjLTaFqIhv
 bsF924mecn7b1ZwaAkdnJMVLC7kyOgI4pCAGqUekNEtMohMlFnJK0ZmmuZWGe1paEfSnp24xLz
 mfdcVAuLuabGn9968Nj92c3dH5bfQZozkvLGf/enCN+9ff+GMs7zIhCxqLI9VdTHOpa9ZPlR00
 3igCSF8AU+HzPfLAAAA
X-Change-ID: 20260618-iommu_contig_hint-71ae491fbb52
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784604557; l=12404;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=dF0M1wuVxwtejL0JWDcv1CVhPAeXAi2r4VAMCoJLSE8=;
 b=R6FTGbvbtbKCq/Rpcyz91IKCaM4JpnKXuDOsLKquUaPJObh/CInbRzhr6fxFFCFIkasUtqHqy
 hhAaDPhcpvyC9ysUQcuc8H5sjlTwQx4X+qmOmuolRK+GUF7jn6BTOOO
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDAzMiBTYWx0ZWRfX84xSj7zZMAoA
 3kxgIFJ/wPEUTsfC8xPzMLNCAVxRDUQxWW1UEIzENKz2PRZuOe6zWWQrTNAMKVu9BqnKc461msg
 XO5wdGCSEpWRW6W8K+cCtV4S/Qe27MzJDU55MlQ+5NyCl6Hvdxsbfeqpk7ZbdbAXXDilNDBeEgK
 lzUW3qZFp1O9/KuRMayFnlKv5BPZ0pkhjaN4usC6/DCs2WRCQJ27jGH97dapMT1SuUeWJX5dIln
 JzNa1sm7OWqePip6XkkSTmO9hleByUMw+zF2E0jBm9lPu9RsQFJD53K3//a1MO6+VSPhb2/Xztj
 9PaFxX7qGmZuPY3Jgy6VDHqsrM8GJEH1eL0YCRpBedIFSPxVjOi2WD1M4LmsGmg0dfcbk12Y0p3
 S/u0zWMZoc6XmUe3YHMJ6yBT0fo7elFN6GI43yWOFU0n/eaBbxUxWKKLAJwpVLE0PzccKgFxJyY
 5+Ji4ktomQOgfyAyA2g==
X-Proofpoint-ORIG-GUID: xUbme0jpFZTgQC5-SJRJdO_UZ0WJx3Wb
X-Proofpoint-GUID: xUbme0jpFZTgQC5-SJRJdO_UZ0WJx3Wb
X-Authority-Analysis: v=2.4 cv=M5F97Sws c=1 sm=1 tr=0 ts=6a5ee792 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=tA7aZXjiAAAA:8 a=JfrnYn6hAAAA:8 a=iRdae3YiAXohjq0pqHkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDAzMiBTYWx0ZWRfX3cDVHR6Lv6u4
 j+5xTFcPKEaaQut7KWJVufp7V2IgZvlzVy3oaq7i3clbsCzzJkPGLKe4MTfTmI5rswJUrxX7MLF
 vTCib+rmbHXKePccN9cvX6PrsOkuqus=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210032

From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>

Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.
When a set of consecutive PTEs map a naturally-aligned contiguous block
of memory, the CONT bit can be set on all entries in the group to allow
the hardware to combine them into a single TLB entry, improving TLB
utilization.

The contiguous hint sizes per granule are:

  Page Size | CONT PTE |  Block  | CONT Block | L1 Block | CONT L1
  ----------+----------+---------+------------+----------+---------
      4K    |   64K    |   2M    |    32M     |    1G    |   16G
     16K    |    2M    |  32M    |     1G     |          |
     64K    |    2M    | 512M    |    16G     |          |

Contiguous hint sizes are advertised in pgsize_bitmap so that IOMMU API
users can align allocations to these sizes and benefit from the TLB
optimization automatically.

Partial unmaps of a contiguous group are rejected, ensuring the full
group is always invalidated as a unit. The
IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT quirk allows SMMU drivers to disable
contiguous hint support at runtime for hardware with
implementation-specific errata.

Co-developed-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
---
Changes in v2:
- Extend contiguous hint support to level-1 (1G) blocks for the 4K granule,
  adding a CONT L1 (16G) grouping alongside the existing CONT PTE/CONT Block
  sizes.
- Replace the compile-time CONFIG_IOMMU_IO_PGTABLE_CONTIG_HINT Kconfig option
  with a runtime quirk, IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT, so SMMU drivers
  can opt out per page table instance instead of at build time.
- Simplify __arm_lpae_map() to program the CONT-sized block directly via
  arm_lpae_init_pte() instead of recursing into the next level with an
  adjusted pgcount.
- Reject unmaps that are not aligned to the contiguous group size with
  WARN_ON_ONCE(), instead of clearing the CONT bit on a partial group before
  invalidation.
- Link to v1: https://patch.msgid.link/20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com

To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
---
 drivers/iommu/io-pgtable-arm.c | 167 +++++++++++++++++++++++++++++++++++++++--
 include/linux/io-pgtable.h     |   3 +
 2 files changed, 162 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 476c0e25631af..241efa37f8631 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -86,6 +86,21 @@
 /* Software bit for solving coherency races */
 #define ARM_LPAE_PTE_SW_SYNC		(((arm_lpae_iopte)1) << 55)
 
+/* PTE Contiguous Bit */
+#define ARM_LPAE_PTE_CONT		(((arm_lpae_iopte)1) << 52)
+
+/*
+ * CONTIG HINT SUPPORT TABLE
+ *
+ *------------------------------------------------------------------
+ *| Page Size | CONT PTE |  Block  | CONT Block | L1 Block | CONT L1 |
+ *------------------------------------------------------------------
+ *|     4K    |   64K    |   2M    |    32M     |    1G    |   16G   |
+ *|    16K    |    2M    |  32M    |     1G     |          |         |
+ *|    64K    |    2M    | 512M    |    16G     |          |         |
+ *------------------------------------------------------------------
+ */
+
 /* Stage-1 PTE */
 #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
 #define ARM_LPAE_PTE_AP_RDONLY_BIT	7
@@ -453,6 +468,112 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 	return old;
 }
 
+static inline bool arm_lpae_cont_hint_enabled(struct io_pgtable_cfg *cfg)
+{
+	return !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT);
+}
+
+static inline int arm_lpae_cont_ptes(unsigned long size)
+{
+	if (size == SZ_4K)
+		return 16;
+	if (size == SZ_16K)
+		return 128;
+	if (size == SZ_64K)
+		return 32;
+	return 1;
+}
+
+static inline unsigned long arm_lpae_cont_pte_size(unsigned long size)
+{
+	return arm_lpae_cont_ptes(size) * size;
+}
+
+static inline int arm_lpae_cont_blks(unsigned long size)
+{
+	if (size == SZ_2M)
+		return 16;
+	if (size == SZ_32M)
+		return 32;
+	if (size == SZ_512M)
+		return 32;
+	if (size == SZ_1G)
+		return 16;
+	return 1;
+}
+
+static inline unsigned long arm_lpae_cont_blk_size(unsigned long size)
+{
+	return arm_lpae_cont_blks(size) * size;
+}
+
+static unsigned long arm_lpae_get_cont_sizes(struct io_pgtable_cfg *cfg)
+{
+	unsigned long pg_size, blk_size, cont_sizes;
+	int pg_shift, bits_per_level;
+
+	if (!cfg->pgsize_bitmap || !arm_lpae_cont_hint_enabled(cfg))
+		return 0;
+
+	pg_shift = __ffs(cfg->pgsize_bitmap);
+	bits_per_level = pg_shift - ilog2(sizeof(arm_lpae_iopte));
+	pg_size = (1UL << pg_shift);
+	blk_size = (pg_size << bits_per_level);
+
+	cont_sizes = arm_lpae_cont_pte_size(pg_size) |
+		     arm_lpae_cont_blk_size(blk_size);
+
+	/*
+	 * Only add the level-1 contiguous block size if level-1 block mappings
+	 * are supported for this granule. For 16K and 64K granules, level-1
+	 * block mappings do not exist, so blk_size << bits_per_level would not
+	 * be in pgsize_bitmap after arm_lpae_restrict_pgsizes() has filtered it.
+	 * For 4K granule, 1G blocks are supported, giving a 16G contiguous group.
+	 */
+	if (cfg->pgsize_bitmap & (blk_size << bits_per_level))
+		cont_sizes |= arm_lpae_cont_blk_size(blk_size << bits_per_level);
+
+	return cont_sizes;
+}
+
+static u32 arm_lpae_find_num_cont(struct arm_lpae_io_pgtable *data, int lvl)
+{
+	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
+		return arm_lpae_cont_ptes(ARM_LPAE_BLOCK_SIZE(lvl, data));
+	else if (lvl >= ARM_LPAE_MAX_LEVELS - 3)
+		return arm_lpae_cont_blks(ARM_LPAE_BLOCK_SIZE(lvl, data));
+	else
+		return 1;
+}
+
+static u32 arm_lpae_check_num_cont(struct arm_lpae_io_pgtable *data, size_t size, int lvl)
+{
+	int num_cont;
+
+	num_cont = arm_lpae_find_num_cont(data, lvl);
+	if (size == num_cont * ARM_LPAE_BLOCK_SIZE(lvl, data))
+		return num_cont;
+	else
+		return 1;
+}
+
+static bool arm_lpae_pte_is_contiguous_range(struct arm_lpae_io_pgtable *data,
+					     unsigned long size,
+					     int lvl, u32 *num_cont)
+{
+	unsigned long block_size;
+
+	if (!arm_lpae_cont_hint_enabled(&data->iop.cfg)) {
+		*num_cont = 1;
+		return false;
+	}
+
+	*num_cont = arm_lpae_find_num_cont(data, lvl);
+	block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+
+	return size == (*num_cont * block_size);
+}
+
 static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 			  phys_addr_t paddr, size_t size, size_t pgcount,
 			  arm_lpae_iopte prot, int lvl, arm_lpae_iopte *ptep,
@@ -463,6 +584,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 	size_t tblsz = ARM_LPAE_GRANULE(data);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	int ret = 0, num_entries, max_entries, map_idx_start;
+	u32 num_cont = 1;
 
 	/* Find our entry at the current level */
 	map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
@@ -479,6 +601,22 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		return ret;
 	}
 
+	if (arm_lpae_pte_is_contiguous_range(data, size, lvl, &num_cont)) {
+		size_t ct_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+
+		max_entries = arm_lpae_max_entries(map_idx_start, data);
+		num_entries = min_t(int, num_cont * pgcount, max_entries);
+
+		/* Set cont bit */
+		prot |= ARM_LPAE_PTE_CONT;
+
+		ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl,
+					num_entries, ptep);
+		if (!ret)
+			*mapped += num_entries * ct_size;
+		return ret;
+	}
+
 	/* We can't allocate tables at the final level */
 	if (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1))
 		return -EINVAL;
@@ -660,7 +798,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte;
 	struct io_pgtable *iop = &data->iop;
-	int i = 0, num_entries, max_entries, unmap_idx_start;
+	int i = 0, num_cont = 1, num_entries, max_entries, unmap_idx_start;
 
 	/* Something went horribly wrong and we ran out of page table */
 	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
@@ -675,9 +813,19 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	}
 
 	/* If the size matches this level, we're in the right place */
-	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
+	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data) ||
+	    (size == arm_lpae_find_num_cont(data, lvl) *
+		     ARM_LPAE_BLOCK_SIZE(lvl, data))) {
+		size_t pte_size;
+
 		max_entries = arm_lpae_max_entries(unmap_idx_start, data);
-		num_entries = min_t(int, pgcount, max_entries);
+		num_cont = arm_lpae_check_num_cont(data, size, lvl);
+		num_entries = min_t(int, num_cont * pgcount, max_entries);
+		pte_size = size / num_cont;
+
+		if (num_cont > 1 &&
+		    WARN_ON_ONCE(!IS_ALIGNED(iova, size)))
+			return 0;
 
 		/* Find and handle non-leaf entries */
 		for (i = 0; i < num_entries; i++) {
@@ -691,7 +839,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 				__arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
 
 				/* Also flush any partial walks */
-				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
+				io_pgtable_tlb_flush_walk(iop, iova + i * pte_size, pte_size,
 							  ARM_LPAE_GRANULE(data));
 				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
 			}
@@ -702,9 +850,9 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 
 		if (gather && !iommu_iotlb_gather_queued(gather))
 			for (int j = 0; j < i; j++)
-				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
+				io_pgtable_tlb_add_page(iop, gather, iova + j * pte_size, pte_size);
 
-		return i * size;
+		return i * pte_size;
 	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
 		WARN_ONCE(true, "Unmap of a partial large IOPTE is not allowed");
 		return 0;
@@ -943,6 +1091,7 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 	}
 
 	cfg->pgsize_bitmap &= page_sizes;
+	cfg->pgsize_bitmap |= arm_lpae_get_cont_sizes(cfg);
 	cfg->ias = min(cfg->ias, max_addr_bits);
 	cfg->oas = min(cfg->oas, max_addr_bits);
 }
@@ -1001,7 +1150,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
 			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
 			    IO_PGTABLE_QUIRK_ARM_HD |
-			    IO_PGTABLE_QUIRK_NO_WARN))
+			    IO_PGTABLE_QUIRK_NO_WARN |
+			    IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -1103,7 +1253,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr = &cfg->arm_lpae_s2_cfg.vtcr;
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_S2FWB |
-			    IO_PGTABLE_QUIRK_NO_WARN))
+			    IO_PGTABLE_QUIRK_NO_WARN |
+			    IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index e19872e37e067..7b2097aaffb09 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -86,6 +86,8 @@ struct io_pgtable_cfg {
 	 *
 	 * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pagetable.
 	 * IO_PGTABLE_QUIRK_ARM_S2FWB: Use the FWB format for the MemAttrs bits
+	 * IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT: Disable use of the contiguous
+	 *	hint for hardware affected by implementation-specific errata.
 	 *
 	 * IO_PGTABLE_QUIRK_NO_WARN: Do not WARN_ON() on conflicting
 	 *	mappings, but silently return -EEXISTS.  Normally an attempt
@@ -103,6 +105,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
 	#define IO_PGTABLE_QUIRK_ARM_S2FWB		BIT(8)
 	#define IO_PGTABLE_QUIRK_NO_WARN		BIT(9)
+	#define IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT	BIT(10)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;

---
base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
change-id: 20260618-iommu_contig_hint-71ae491fbb52

Best regards,
--  
Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>

