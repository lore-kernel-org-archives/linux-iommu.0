Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F374D0CFA
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605939; cv=none; b=s42Uys9i8yqbvbCCMKTGlIuorf3mwGqqVVKoG4Uq2DZy7VekOyLxdFlH4iaIb+sQUBbKcfUBA4/LbvNlL1zCr5lFK+6RKSuCV5RiEx5N9CzM0fV4soefsGDYGOKjODLFuaDdyA8W1lTABJz9/nCOC5zxutdHiHPySgDDoC5fBSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605939; c=relaxed/simple;
	bh=xlWBoHZlI3FsV92yhipKHcVeWh8Apy+gkEcFiflzWF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBF+VVD9VolKbZfKPOld4UZqRsv7eeisYT6bmmYcIjnrhEDfF3fHcxcBoW3iEMEpcxODdBVmVwunMnv5tJ8EOu2rvx3NP8NdyW+Ex/LGYeZC6vfMzpq+tT4UONySlsFd1gI2vOkpoSZ36C+V20K+RjniJ6xArJzbBBNi8vBPdLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OcNy+T6z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ClZ4BCM1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OcNy+T6z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ClZ4BCM1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBARMs482015
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fXARlnUet2M
	hiIY+g7vNvo27h1dCmw8pyLb+qL38EuQ=; b=OcNy+T6zPRquLP+sx+2pJIVxXAu
	iloExvb24ljR/wERPOc2mqHIz8LSh5TFaOYiAlCBRGWVoAaReKzYUuLKPqEPsSW4
	ZyZZydUCHV/sThrv65cyzoDz//rcoNJINKKxojBoV5TFr+dm/tRHMSPzHKG0cQ8C
	G04wUuB1B3LrYnQGfBxSPJu3G0/uvud5AvS6Q4NLb1sSnnAAjTo5papmWFi7DdT+
	NYxsHuasNvhtRzvWK6hXol4U6jvifKztKU7pLBjO+B0UdDnLCY8q2FKEglAE3gWL
	qjJWYZbmZ7U1pvXCjii1oCyJRcMlmvA+iln5gnyj2UMljM0Nvw+nHqfn3rQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt11usy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:32:10 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7989d8ef4a6so416346137.3
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790605930; x=1791210730; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fXARlnUet2MhiIY+g7vNvo27h1dCmw8pyLb+qL38EuQ=;
        b=ClZ4BCM1juvJdI5XGVbkL9vy+Nty6HQCQev2gHTBG4J+nBm0myWwrSF2u0SqmpsXRT
         wDMA5ozS/oYFUL573xqYvMZVK/XEB0ZZZJvC4SJjKui69YLpc6GCx1apLyPc9QR3wxUa
         ttha9YLCoxVYWeipfvyZOA4dapGREsAm6kXb45c3A415pzn+AqDnA83NNJAh4uin7jOI
         EYA+m9hJkb1Cn6TAFIvWxlkj5/CdHY+b32EpxCW07yfMhf2CC9Rv+icuGcnesc/C9sCy
         NzPaJ5ew2xEWOZOQUv0Yf+OiQSqg3vWhCgtbtsfyTJwhdYrNAQi2i4cNVnyaf5/KneRm
         xyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605930; x=1791210730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fXARlnUet2MhiIY+g7vNvo27h1dCmw8pyLb+qL38EuQ=;
        b=oAmWfszg24eMFy+ZqmhiYuhGSv+ZIuUGak0lqKQXHskKVuBgylPBlIfmouR9Z+1RIl
         XwbBrJ/fzoztUD27sfA6u/jJaScS1DXxYOI+3mDAWSzvcMeavGoqskrSYmj/rLlSJpf+
         i6qaEdv8j+GMdemTrSF+Bv6Jc+t5Rr34vl4bAWOpuhxvX8iDNJB3FcS8ds5tpyfWT+lv
         MwXswguNBxcl9FE08Lk0Pg9tM0zdwYtqIB1x/h+GGxXalj/g1APLWjOp7Ep5wRMRAL8w
         kDLbjfhgbgr0doDcBiCF1uNE3EY8O8sgDHnMRAZax6oLo/ffXj5OosZAJZ44Aoq2tKGh
         wwkA==
X-Gm-Message-State: AFq9FYL9NieBvnJLE7d68FZSMt7vBkFK7mv/SOTU1wkLeJWd8CxFNAUz
	DbZFxY2YILWP74KW1b2Bj+5UDAiCuhNVneQMtjYIRN5OOvpkdSHgAkgGioM5GuIAej/jQ0j1yVK
	1/zTJHcaOGrbnNfMlyAjYjzm2rGtzBRbnjOQLf2fmytWmOakK/dERcGvmINTQ6hACwQ==
X-Gm-Gg: AYBFou0W/ag2LWuvSuVfPL+r6MrJu8nNuhShYeur3+GCOgRtCfAX3LOqulweYbqSccp
	ZdmqcttULKL/ZHz6g8/pzFgiItqapEEgb9TOHpqA5o2YBrv3KvlZOWArc/yiPo8BwS1dP5W53AQ
	ki2YwZUIiIIy5X3LeHF/CVnykudFTij3TuT+q2CYoCbB8P3TXHd+iVDuvJ1oOyCaNbiFHjOX/O6
	driZgNNdTllG9wi76qbcMCpxxqddlNqHqR/M19sicKN/kuOtKG9LRm3559LGaxGuZFLi/K9rFEc
	jYUSr/LIKm7qttx6y2pqI/KCYCBKX71l0pR1eMSer52OJDH9DdsOlat4BiX/ia7+foSfuf5pWrb
	OT3Dekbiw0jAs7FQHYJqGX2fYA4I8kQTIOJn5lg==
X-Received: by 2002:a05:6102:3750:b0:79f:eeb7:d643 with SMTP id ada2fe7eead31-7b1c50409d9mr2497049137.10.1790605930205;
        Mon, 28 Sep 2026 07:32:10 -0700 (PDT)
X-Received: by 2002:a05:6102:3750:b0:79f:eeb7:d643 with SMTP id ada2fe7eead31-7b1c50409d9mr2497042137.10.1790605929656;
        Mon, 28 Sep 2026 07:32:09 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd110c3esm296984266b.63.2026.09.28.07.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:08 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 07/14] iommu/riscv: Prepare MSI table updates for interrupt remapping
Date: Mon, 28 Sep 2026 16:31:06 +0200
Message-ID: <20260928143113.49838-8-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
References: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX59AfVLhnMqzY
 KraAkMzHeiyQK32+SpPECscJRSG/PQLBUEWYGhysVsOqzEPSojN9NMDUj18/2qfqCX3W2/1yyqV
 t9dF69NzH7nHJL3eWssCJyzzCcB11U7QKDRq1+T9vVQpAVe5deFNeC/2Cc6AIuuPhniJekyfkoO
 8DpmIcVc1BiovBxdEcCD3LycaVoBsLz9Yomupfo3BB7qn4SMman/9vBtODIDE7OyzKFnIEMpCcr
 v3I+yDz8eyiOzjY8R/eaiyV8kLN5GBiz3kYRT//W3Z8WuSSb2G2GXKHSbJoI1n1u2gU8t536d0B
 mKhxOAJmzLnN0PO/tDjWcCsMNMnqBHsaoosv3AQ8TVWZO/LYE75FEqQiLr4HlGAcb9WTbPapV+R
 OlD/sKC1aRrtLrDw+A1KP8zzDcQ4pACnafyXlbOC87cD2gy+HYsAvEP1x5YhZ2ZuM73tLIbvrIS
 9wpTYpQ6a07mTfII0cA==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba7a6a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=tpFWYQdyHN71iLxetsoA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: adOWrjn3uryGb6faXR3KxUjptLV80Goq
X-Proofpoint-GUID: adOWrjn3uryGb6faXR3KxUjptLV80Goq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX7zmTJhNcC4DD
 GwxiI5EOM93kyALGtXs+U3wrPY3BHSMDJ03G0E5URSF9tQez08pIPeNUrmDt3sJsCbqZBvOyNe4
 zNe90yCcYiU0L7R+4QHpt4JuVExVyRg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280057

Guest interrupt-file mappings require interrupt-remapping code to
install or remove the MSI page-table pointer and address extraction
fields in every device context attached to a domain. Devices joining an
active MSI domain also need their device contexts initialized, so check
for an active MSI domain at attach time.

Add helpers to publish those fields to bonded devices and to invalidate
one or all MSI PTE translations. These helpers will be used by the IRQ
bypass implementation.

The per-device nr_forwarded_irqs counter is insufficient to detect
active MSI tables for the domain, so we introduce another counter which
is domain-wide. Like info->nr_forwarded_irqs, later patches which
introduce interrupt remapping support will manage the newly introduced
nr_forwarded_irqs counter.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h |  5 +++
 2 files changed, 70 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 86d5795a12dd..db4539fbcb95 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1189,6 +1189,28 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 	rcu_read_unlock();
 }
 
+void riscv_iommu_msi_table_inval(struct riscv_iommu_msi_table *msi_table, unsigned long addr)
+{
+	struct iommu_iotlb_gather gather = {
+		.start = addr,
+		.end = addr + SZ_4K - 1,
+		.pt.leaf_levels_bitmap = 1,
+	};
+	struct riscv_iommu_domain *domain;
+
+	domain = container_of(msi_table, struct riscv_iommu_domain, msi_table);
+	riscv_iommu_iotlb_inval(domain, &gather);
+}
+
+void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table)
+{
+	struct iommu_iotlb_gather gather = { 0 };
+	struct riscv_iommu_domain *domain;
+
+	domain = container_of(msi_table, struct riscv_iommu_domain, msi_table);
+	riscv_iommu_iotlb_inval(domain, &gather);
+}
+
 #define RISCV_IOMMU_FSC_BARE 0
 /*
  * This function sends IOTINVAL commands as required by the RISC-V
@@ -1311,6 +1333,11 @@ static void riscv_iommu_iodir_update(struct device *dev, struct riscv_iommu_dc *
 		WRITE_ONCE(dc->fsc, new_dc->fsc);
 		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
 		WRITE_ONCE(dc->iohgatp, new_dc->iohgatp);
+		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_FLAT) {
+			WRITE_ONCE(dc->msiptp, new_dc->msiptp);
+			WRITE_ONCE(dc->msi_addr_mask, new_dc->msi_addr_mask);
+			WRITE_ONCE(dc->msi_addr_pattern, new_dc->msi_addr_pattern);
+		}
 		/* Update device context, write TC.V as the last step. */
 		dma_wmb();
 		WRITE_ONCE(dc->tc, tc);
@@ -1329,6 +1356,40 @@ static void riscv_iommu_iodir_update(struct device *dev, struct riscv_iommu_dc *
 	riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
 }
 
+static void riscv_iommu_msi_table_set_dc(struct riscv_iommu_msi_table *msi_table,
+					 struct riscv_iommu_dc *dc, bool activate)
+{
+	if (activate) {
+		dc->msiptp = virt_to_pfn(msi_table->root) |
+			     FIELD_PREP(RISCV_IOMMU_DC_MSIPTP_MODE,
+					RISCV_IOMMU_DC_MSIPTP_MODE_FLAT);
+		dc->msi_addr_mask = msi_table->msi_addr_mask;
+		dc->msi_addr_pattern = msi_table->msi_addr_pattern;
+	} else {
+		dc->msiptp = 0;
+		dc->msi_addr_mask = 0;
+		dc->msi_addr_pattern = 0;
+	}
+}
+
+void riscv_iommu_msi_table_update(struct riscv_iommu_msi_table *msi_table, bool activate)
+{
+	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_bond *bond;
+
+	/* The MSI table lock excludes bond updates for this domain. */
+	lockdep_assert_held(&msi_table->lock);
+
+	domain = container_of(msi_table, struct riscv_iommu_domain, msi_table);
+
+	list_for_each_entry(bond, &domain->bonds, list) {
+		struct riscv_iommu_info *info = dev_iommu_priv_get(bond->dev);
+
+		riscv_iommu_msi_table_set_dc(msi_table, &info->dc, activate);
+		riscv_iommu_iodir_update(bond->dev, &info->dc);
+	}
+}
+
 /*
  * IOVA page translation tree management.
  */
@@ -1514,6 +1575,10 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 		kfree(bond);
 		return -EBUSY;
 	}
+
+	if (domain->msi_table.nr_forwarded_irqs)
+		riscv_iommu_msi_table_set_dc(&domain->msi_table, &dc, true);
+
 	info->dc = dc;
 	riscv_iommu_bond_link(domain, bond);
 	riscv_iommu_iodir_update(dev, &info->dc);
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 2876703a6698..deb57b6a6c4b 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -71,6 +71,7 @@ struct riscv_iommu_device {
 struct riscv_iommu_msi_table {
 	/* Protects attachment, interrupt forwarding state, and MSI PTE updates. */
 	raw_spinlock_t lock;
+	unsigned int nr_forwarded_irqs;
 	unsigned int nr_ptes;
 	struct riscv_iommu_msipte *root;
 	u64 msi_addr_mask;
@@ -81,6 +82,10 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 
+void riscv_iommu_msi_table_inval(struct riscv_iommu_msi_table *msi_table, unsigned long addr);
+void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table);
+void riscv_iommu_msi_table_update(struct riscv_iommu_msi_table *msi_table, bool activate);
+
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
 
-- 
2.43.0

