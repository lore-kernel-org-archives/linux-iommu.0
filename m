Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23EF422E24
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989271; cv=none; b=pmt/EwtYiRzA/H8zINQprznmvfx+Did1+Q62J+ELfIjTQmArs1+zAuXf/Lj5viLE/o3NtvtiFPbxy3U0ST7r+4EVY2/QuVXfowday0CSSjJEVsY3zmHH8iWBlZmmr75Lq4dhlGNlyDulKZJKVJjY2AWVfA9AXB3JPYIX6o7n4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989271; c=relaxed/simple;
	bh=UfzUqObrHW956c1xKsoqj5yyvanxTjUVeX7QbcCLlrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lskN3QF+YlTcGjIgTTOFL3Xmlu7FhBQ1yvRJ637R8rFDKin/6T32KgV9iEHrOriK/F9ejuOb+Z2LOW56TzD2nVXL9pM/xtMPRLYP3R158LvLqQx3rPMpLiazfHI0r1VvcLLhIC2N1TaOTVowL2xiVCs++8QHIMOIokPj0iLP7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n4fAKTRN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SS0l1Tif; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n4fAKTRN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SS0l1Tif"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAduW81926513
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 11:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AvrL4PtNR0NVOnol6eHyAO
	GAnIaYwDDVRqfmwFSfFrc=; b=n4fAKTRNjlP7N+3611wzoDfKdrjGPgvIDq7MDi
	zXdfx6trI6oJThNF7OTICHGtwHsEbl5PV/Jzr4tLwGnXT/qSpwHoSv4dS27EgfHB
	AFnHkj3zpJbL5c23zNeGIu/nPst9Oief3ZBFNF7EgOiSIAozf63V0l2L1021GcEC
	QC1aewFbN2iUI24+hkU9eY54qPMri7G4L08P9mpC9E8qem19VF9R4/anCjftzojy
	j83+2W5lXFmFMgLItBql60HTX4oTRdYKbindh1TNfmqWtYXWZQxXVhUSUC2mkdz4
	IlCsP0eYbrcJSHsxTPtfvBQ1V4VvGQJwFZZQ7HbzF3RhgT9Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3va31n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 11:14:26 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1cade6b71so2769405a12.0
        for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789989265; x=1790594065; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AvrL4PtNR0NVOnol6eHyAOGAnIaYwDDVRqfmwFSfFrc=;
        b=SS0l1TifluvgltA0AzT7MU9jFe9cFjVs2eJQZk49TTrtfiZ+WyfEQvVOixj7irfonl
         vzmmahctstHabrY+KUeUVzXenqY3aSwjfFlpDp6MBrG2/E0m381i6p/zQwNn/Wy3LuSY
         IpfdnKODrhWiEy7bLZ/aP5YgOZAo82syLeLiRZ68nO8DzqPQg96/Sf7a5Awt0ntfohZN
         GGaJpvGvqKlaVoQdxsr9W94qN2o0pdIp/9IaJlpxmuQgPFstk88xhJeYEaRyUUg7Q0Vq
         jqrXY/9dK4UCWYTe+G4GLKuA0qThzsc9O9jrDyH9cWvtrhS6CyS094KUGKJ3uaEd4pe6
         Jwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789989265; x=1790594065;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AvrL4PtNR0NVOnol6eHyAOGAnIaYwDDVRqfmwFSfFrc=;
        b=goEPnuNRzW5/BSrXNVIRZnYa5bfUdbreHHGeZ2qTnnlWiTD2JNXUIbo6lmZbx3MYhC
         0gSQ0h61v8MsRu7N6rCYG4YvlJLXowWVGC6yLFfyMC/xemqSO1Ei6/ksP5LKode3fLXB
         OCo4R82lxCfe58xjfENwewOc56ZWl/M1qKYt4aAhYHgGKMeMrJlppR4SMrRYp7LBSeRx
         qMC1e4Y3wDKxVD0m1yBDenCFfdwltt9Nw9WNkca87TJmURXnax7zZN9ywN0qL6YLz1dQ
         POswYv4kmPsANxU9n3kM7FyfcapgFHrhGQee03yaSpQp2F4S3QCUpQPQHvQRAmncrUxp
         ilnA==
X-Forwarded-Encrypted: i=1; AKwUvByO5ewHVcZXfv1Yg+V19d/Oi3PR2hJO48OVHM/7iU6akgh2lz0vNK8DhL/+YDPYtlU0rRWeUQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nV0LE+DD6TmLrFa35qu+y+sVEXJwN2V5LsnlPgIT3b+iXHlow9
	a/7meD7WOFmCA49JFc468kjhW13/tO0/twvM2dfgjTiQRtToow2//rQOW06Z7CzSiHmZ6VSR1pR
	mqDp1z2DTiqXJKCuvxkUWKNMbWAoJy2FIkEBUHGD+vKerP6wEAMEwOJQOPw==
X-Gm-Gg: AYBFou2mkHw3Lo7s/5KM64sGwoB3kacbIizGPG50RpwlqXBZaMarWgjsnxxiR8jUG75
	RxNuYxSg0z1DUhksU+pFc/eohLU3YZgRzipQpEjkD/Pe+5/uoo5+L+pvC3YyxZS5vludSK7pjtc
	ykZgjmRrcv8WtjzkFQBr1kqnHJNYGo8lnQFh1TKW0FWNojDmgYr1q5QsrWGYBPTj5Pg+m9GQEc0
	IlcTkd3lgY+Z5vwwPx6lH4oHLtkBRbLaLI/yiThWgRo5UZ/i+9VUNHDVNSc7bttqgOZR9WKFxjM
	jXsJvXZic18TEAJuzIQncAqzQFzpy9mzXLkhEpF10ThOHnLI5+lDPgUvMrIuABLZTQAXKNMYmle
	n+Vpc3LLv80adZEkPP5TCFWtTtxhxd7nPgQ==
X-Received: by 2002:a05:6a20:7490:b0:3dd:85a8:4c51 with SMTP id adf61e73a8af0-3dd8bcfcfedmr11631592637.21.1789989265420;
        Mon, 21 Sep 2026 04:14:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:7490:b0:3dd:85a8:4c51 with SMTP id adf61e73a8af0-3dd8bcfcfedmr11631554637.21.1789989264693;
        Mon, 21 Sep 2026 04:14:24 -0700 (PDT)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aeae0b8sm3194466a12.19.2026.09.21.04.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:14:24 -0700 (PDT)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:44:07 +0530
Subject: [PATCH v5] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-iommu_contig_hint-v5-1-e7fbd1c3774d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH4RsWoC/33PTU7DMBAF4KtUXuPKY4//uuIeCFWOM22MaAxxE
 oGq3B2nLMoiZTPSk958o7myQkOiwg67KxtoTiXlvgb9tGOxC/2ZeGprZlJIIww4nvLlMh1j7sd
 0PnapH7mFQOjh1DRasrr3MdApfd3Ml9ffXKbmjeK4QmujS2XMw/ft6Axr7z9/Bg4ctZBBezLKu
 edcyv5zCu+xdvd1sPXMLO+QlbAFyQp5Ea2CgABGPYDUX0huQapCILxUwTiFCA8gvENO4BaEFWp
 tQEutbhu/9dqyLD8G0DmapgEAAA==
X-Change-ID: 20260618-iommu_contig_hint-71ae491fbb52
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789989261; l=16382;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=aiF1vYCQUGaw+hd53karg1s2i8Jh0DKomIag7s2wwlw=;
 b=uqYHcSOuEt0cSlWcWSHCG6bh+HXIJ4OE7NJnUbNdnfsUT6CBHpaYghuruWqFUwitN141OWT2T
 1XrYdRs70Z9AhfNyk3N9pA3LqV117hjfjS3oJ0F0Op1xS8Isxl3M7TB
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Authority-Analysis: v=2.4 cv=Ytia1IYX c=1 sm=1 tr=0 ts=6ab11192 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=7CQSdrXTAAAA:8
 a=tA7aZXjiAAAA:8 a=JfrnYn6hAAAA:8 a=XMnUve11aTPCSsswyJsA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: Eu6JhfXCX0WAFi93oeQjKOdxYgRDU6vv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2MiBTYWx0ZWRfX7YfoOVno/w+g
 ShIrrf4bPO96XUJSuEhBBp+fgwIG919WYODx2lBRHUiuu87SXiuqRjTUVVnNqHXjoiLAcKh69p0
 UIB9TQgybcvjqbd/kj/AqGf9Hx8ZUHo=
X-Proofpoint-GUID: Eu6JhfXCX0WAFi93oeQjKOdxYgRDU6vv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2MiBTYWx0ZWRfX5l6eqaKa24mX
 FJ988fTXruMK1q6gDS9yWgmHDrALFl03aDANhw62dGjlYDFnp4VgI+INX9P7rX2sS6gUKGDzpLD
 +sL2+uaVxEWdb/gNB/ECkfzMoTXtkXDlJe5XAJy3Po4Cmy7e7NoMZqrBH3L7IQlEDsIZDzCZzMO
 fKWin6YbW/fYR4syYlYoO9HlkQq0NmtERe4xeQbJ3HJ2JHPN28ELmo/DL+5umWN2GjIECQ/AsFN
 yjlX77dB/NV23vE7IL/alEuBRx/ftfxzYvUnUEwxKDsbqudepNwI1qmNvJlCSfX/aD7wpf2AAm+
 0AuHtU2gP4b2i2DbYjxMgC7gbSkFJDc5CfVz/jFiWiPiw+B/xyG7+9aexIntnwFdK549iGnaoUi
 UqgIhj2WKaeio2Q/qU6xKe/mk0ZhF/vXhuav/Xs6PNH0uvAcOofIs5fqHOCBpbvuwWxDx45T+VE
 iFc/MZka5NFSM/IAN8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210162

From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>

Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.
When a set of consecutive PTEs map a naturally aligned contiguous block of
memory, set CONT on every descriptor in that group so the hardware can
combine translations and improve TLB reach.

Advertise the supported CONT group sizes in pgsize_bitmap. Callers select
those sizes through the normal page-size selection path; io-pgtable-arm
then installs the corresponding tagged descriptors directly. A partial
unmap of a tagged CONT group is rejected before modifying any descriptor,
so a rejected request cannot leave the group partly unmapped.

The IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT quirk allows SMMU drivers to disable
CONT support for hardware with implementation-specific errata.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
---
Changes in v5:
- Keep CONT sizes that exactly span the configured IAS or OAS, allowing a
  valid mapping at address zero.
- Derive CONT sizes from the architecture-valid base page-size bitmap and
  constrain the final result by IAS and OAS, replacing the bespoke
  arm_lpae_get_cont_sizes() helpers.
- Guard CONT-size expansion against 32-bit overflow.
- Let callers select exact CONT sizes through pgsize_bitmap, and remove the
  internal prefix/group/suffix promotion path.
- Reject a partial CONT-group unmap before any PTE is cleared, making the
  rejection a complete no-op.
- Link to v4: https://lore.kernel.org/all/20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com/

Changes in v4:
- Merge each run of consecutive aligned (or consecutive non-aligned)
  num_cont windows within arm_lpae_install_leaf() into a single
  arm_lpae_init_pte() call instead of one call per window. idx and
  paddr both advance by block_size per entry, so once a window
  qualifies (or fails to qualify) for the CONT hint, every later whole
  window in the same call does too - collapsing the common fully-
  aligned or fully-unaligned case back down to one call, matching v2's
  call count without reintroducing v2's alignment gaps.
- Fix min_t(int, pgcount, max_entries) truncating pgcount (size_t) to a
  signed int in both __arm_lpae_map() and __arm_lpae_unmap(), which
  could go negative and spin the caller's while (pgcount) loop forever
  for a large enough single request - especially reachable now that
  pgcount is scaled by num_cont (up to 128) for whole-CONT-group
  requests. Compare in size_t via min_t(size_t, ...) instead; the
  result remains bounded by max_entries before being stored back into
  the int num_entries. Reported by the Sashiko AI review bot on v3.
- Stop short of the offending entry instead of returning 0 outright
  when __arm_lpae_unmap() detects a misaligned CONT group mid-loop.
  Earlier entries in the same call may already have had non-leaf
  sub-tables torn down and freed, so returning 0 both under-reports
  the actual unmap progress to the caller and skips the bulk
  clear/gather for those already-freed entries. Breaking out of the
  loop at the current index lets the existing post-loop clear/gather
  path handle entries [0, i) correctly and report i * size unmapped.
  Reported by the Sashiko AI review bot on v3.
- Link to v3: https://lore.kernel.org/all/20260722-iommu_contig_hint-v3-1-10923a683441@oss.qualcomm.com/

Changes in v3:
- Collapse arm_lpae_cont_ptes()/arm_lpae_cont_blks()/
  arm_lpae_cont_pte_size()/arm_lpae_cont_blk_size()/
  arm_lpae_find_num_cont() into a single arm_lpae_num_cont(size_t size)
  helper, since leaf/block/L1-block sizes never overlap across granules.
- Fix arm_lpae_pte_is_contiguous_range() never checking that iova/paddr
  are aligned to the contiguous group size, by removing it entirely -
  __arm_lpae_map()'s new arm_lpae_install_leaf() helper scans for
  aligned sub-chunks and independently verifies paddr alignment for
  each one before applying the CONT hint.
- Fold the CONT case into __arm_lpae_map()'s existing size == block_size
  leaf path instead of duplicating arm_lpae_init_pte() in a separate
  branch. A request whose size exactly matches a whole CONT group is
  normalized down to block_size/scaled pgcount so it reaches that path;
  arm_lpae_install_leaf() then walks the resulting range in chunks,
  tagging only the sub-chunks that are both index-aligned and
  paddr-aligned to the group size, since a single map_pages() call at
  the plain block_size can still contain such an aligned group midway
  through a larger, otherwise ungrouped range.
- Replace the unmap-side WARN_ON_ONCE(!IS_ALIGNED(iova, size)) with a
  check on the actual ARM_LPAE_PTE_CONT bit of the PTEs being cleared.
  The previous check incorrectly warned on any unmap whose size
  happened to numerically match a CONT group size, even when the
  underlying PTEs were never CONT-tagged (e.g. because the original
  iommu_map() wasn't group-aligned), and even though iommu_unmap() can
  legitimately assemble such a size from multiple independent prior
  iommu_map() calls.
- Close a leak where ARM_MALI_LPAE would gain CONT-sized entries in its
  pgsize_bitmap despite the format having no CONT bit, by having
  arm_mali_lpae_alloc_pgtable() set IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT
  internally rather than special-casing the format in the shared
  arm_lpae_restrict_pgsizes()/arm_lpae_get_cont_sizes() path.
- Gate each contiguous-hint size in arm_lpae_get_cont_sizes() on whether
  a single group actually fits within the configured IAS/OAS, so e.g. a
  16G level-1 CONT group is never advertised for an IAS too small to
  address it.
- Link to v2: https://patch.msgid.link/20260721-iommu_contig_hint-v2-1-90c731a41163@oss.qualcomm.com

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

Changes in v1:
- Initial version.

To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
---
 drivers/iommu/io-pgtable-arm.c | 125 ++++++++++++++++++++++++++++++++++++-----
 include/linux/io-pgtable.h     |   3 +
 2 files changed, 115 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 476c0e25631af..01d98959c514f 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -86,6 +86,21 @@
 /* Software bit for solving coherency races */
 #define ARM_LPAE_PTE_SW_SYNC		(((arm_lpae_iopte)1) << 55)
 
+/* PTE Contiguous Bit */
+#define ARM_LPAE_PTE_CONT		(((arm_lpae_iopte)1) << 52)
+
+/*
+ * Contiguous hint group sizes per granule:
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
@@ -453,6 +468,24 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 	return old;
 }
 
+static int arm_lpae_num_cont(size_t size)
+{
+	switch (size) {
+	case SZ_4K:
+	case SZ_2M:
+	case SZ_1G:
+		return 16;
+	case SZ_64K:
+	case SZ_32M:
+	case SZ_512M:
+		return 32;
+	case SZ_16K:
+		return 128;
+	default:
+		return 1;
+	}
+}
+
 static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 			  phys_addr_t paddr, size_t size, size_t pgcount,
 			  arm_lpae_iopte prot, int lvl, arm_lpae_iopte *ptep,
@@ -462,20 +495,41 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
 	size_t tblsz = ARM_LPAE_GRANULE(data);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-	int ret = 0, num_entries, max_entries, map_idx_start;
+	int num_cont = arm_lpae_num_cont(block_size);
+	size_t cont_size = 0, entries_per_map;
+	int num_entries, max_entries, map_idx_start;
+	bool cont = false;
+
+	if (num_cont > 1 && block_size <= SIZE_MAX / num_cont)
+		cont_size = num_cont * block_size;
 
 	/* Find our entry at the current level */
 	map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
 	ptep += map_idx_start;
 
 	/* If we can install a leaf entry at this level, then do so */
-	if (size == block_size) {
+	if (size == block_size ||
+	    (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT) &&
+	     size == cont_size)) {
+		int ret;
+
+		cont = size == cont_size;
+		if (cont && (!IS_ALIGNED(iova, size) || !IS_ALIGNED(paddr, size)))
+			return -EINVAL;
+
+		entries_per_map = size / block_size;
 		max_entries = arm_lpae_max_entries(map_idx_start, data);
-		num_entries = min_t(int, pgcount, max_entries);
-		ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
+		num_entries = min_t(size_t, pgcount,
+				    max_entries / entries_per_map) * entries_per_map;
+		if (!num_entries)
+			return -EINVAL;
+		if (cont)
+			prot |= ARM_LPAE_PTE_CONT;
+
+		ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl,
+					num_entries, ptep);
 		if (!ret)
-			*mapped += num_entries * size;
-
+			*mapped += num_entries * block_size;
 		return ret;
 	}
 
@@ -660,12 +714,18 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte;
 	struct io_pgtable *iop = &data->iop;
+	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int num_cont = arm_lpae_num_cont(block_size);
+	size_t cont_size = 0, entries_per_map;
 	int i = 0, num_entries, max_entries, unmap_idx_start;
 
 	/* Something went horribly wrong and we ran out of page table */
 	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
 		return 0;
 
+	if (num_cont > 1 && block_size <= SIZE_MAX / num_cont)
+		cont_size = num_cont * block_size;
+
 	unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
 	ptep += unmap_idx_start;
 	pte = READ_ONCE(*ptep);
@@ -675,9 +735,27 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	}
 
 	/* If the size matches this level, we're in the right place */
-	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
+	if (size == block_size ||
+	    (!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT) &&
+	     size == cont_size)) {
+		entries_per_map = size / block_size;
 		max_entries = arm_lpae_max_entries(unmap_idx_start, data);
-		num_entries = min_t(int, pgcount, max_entries);
+		num_entries = min_t(size_t, pgcount,
+				    max_entries / entries_per_map) * entries_per_map;
+		if (!num_entries)
+			return 0;
+
+		/*
+		 * A CONT group must be invalidated as a unit. Reject a request that
+		 * starts or ends inside a tagged group before changing any PTEs.
+		 */
+		if ((READ_ONCE(*ptep) & ARM_LPAE_PTE_CONT &&
+		     !IS_ALIGNED(iova, cont_size)) ||
+		    (READ_ONCE(ptep[num_entries - 1]) & ARM_LPAE_PTE_CONT &&
+		     !IS_ALIGNED(iova + num_entries * block_size, cont_size))) {
+			WARN_ONCE(true, "Unmap of a partial CONT IOPTE group is not allowed");
+			return 0;
+		}
 
 		/* Find and handle non-leaf entries */
 		for (i = 0; i < num_entries; i++) {
@@ -691,7 +769,8 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 				__arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
 
 				/* Also flush any partial walks */
-				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
+				io_pgtable_tlb_flush_walk(iop,
+							  iova + i * block_size, block_size,
 							  ARM_LPAE_GRANULE(data));
 				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
 			}
@@ -702,9 +781,10 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 
 		if (gather && !iommu_iotlb_gather_queued(gather))
 			for (int j = 0; j < i; j++)
-				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
+				io_pgtable_tlb_add_page(iop, gather,
+							iova + j * block_size, block_size);
 
-		return i * size;
+		return i * block_size;
 	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
 		WARN_ONCE(true, "Unmap of a partial large IOPTE is not allowed");
 		return 0;
@@ -943,8 +1023,23 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 	}
 
 	cfg->pgsize_bitmap &= page_sizes;
+	if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT)) {
+		unsigned long sizes = cfg->pgsize_bitmap;
+
+		while (sizes) {
+			unsigned long size = BIT(__ffs(sizes));
+			int num_cont = arm_lpae_num_cont(size);
+
+			if (size <= ULONG_MAX / num_cont)
+				cfg->pgsize_bitmap |= num_cont * size;
+			sizes &= ~size;
+		}
+	}
+
 	cfg->ias = min(cfg->ias, max_addr_bits);
 	cfg->oas = min(cfg->oas, max_addr_bits);
+	cfg->pgsize_bitmap &= GENMASK_ULL(cfg->ias, 0);
+	cfg->pgsize_bitmap &= GENMASK_ULL(cfg->oas, 0);
 }
 
 static struct arm_lpae_io_pgtable *
@@ -1001,7 +1096,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
 			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
 			    IO_PGTABLE_QUIRK_ARM_HD |
-			    IO_PGTABLE_QUIRK_NO_WARN))
+			    IO_PGTABLE_QUIRK_NO_WARN |
+			    IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -1103,7 +1199,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr = &cfg->arm_lpae_s2_cfg.vtcr;
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_S2FWB |
-			    IO_PGTABLE_QUIRK_NO_WARN))
+			    IO_PGTABLE_QUIRK_NO_WARN |
+			    IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -1224,6 +1321,8 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 		return NULL;
 
 	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
+	/* Mali LPAE has no CONT bit - never advertise CONT page sizes */
+	cfg->quirks |= IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT;
 
 	data = arm_lpae_alloc_pgtable(cfg);
 	if (!data)
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
base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
change-id: 20260618-iommu_contig_hint-71ae491fbb52

Best regards,
--  
Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>

