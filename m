Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262955;
	b=QP5BV9l2cnA9rAMm1a96Ecx2+gRtZ3NtnOu0o6bF0nLL01AVObhOFm49KpkLjnG1arUD
	 7Z6ZD6DvQgDsAngpRLbeNUD+57dAH8lmZyFyLScM2KIydO/oJHvgwrfO/wEx3vSZK7OhS
	 BZL1dYpxiL+xfuhV1q/yp3LaRseu+6QbzMXc/Gl/IiuNRO1FB5E0mdHy9rjwxRyVGYp/C
	 w4VRSCYzaB4YMV/eenvmSDGjMfYk2AII/iDYKuVQbBJhLwElGs114w8kt7gNvQk2enhgF
	 mDG90b62tVl3T8RW6o6AuZr4QxX7GCtXQY6tzfePCuGf634ZH4WQdjEK0ehZlaGYmcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262955;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=St7kPuwx8TTNbOiHL4PqED3PJrgepz3coZt/Tr0CXik=;
	b=JAV4AuHapyAOQvq+Vh9DERhSgGpRhjOyWK2wCSl/+L1g4Pck6o7Sm/ocLM9zC3/E/GQo
	 awjS6GGlOHRf95N90BFrbJLS7NXBA3cef2WvCEWEtKAirIzj7Uk7rGXujNYYlXUERRl0p
	 X8J8W0salwAL1vRrvCtYI7DlAqlhIlrqOoumLyoNDh4LXE3CwXEGrYMa3VuJIVK2AyJLG
	 U7FS3fBTXUwHmOectszUYX5islfCDMo5iQqxy2ntZqRY+h/7ueMbm+F+UeVmDOWsp+D6X
	 mT5rMwni8TmfgLwDLLOeEfhVGztcfywDoMLy4t4u8rW6rH2IlP3dl+sGNzrw7xrcUEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ajtDnW5e;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iHLieAc2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7387660A2608
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 22:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7387660A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ajtDnW5e;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iHLieAc2
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LAEhE1352161
	for <iommu@lists.linux.dev>; Mon, 9 Nov 2026 22:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=St7kPuwx8TTNbOiHL4PqED3PJrgepz3coZt
	/Tr0CXik=; b=ajtDnW5e4q8b0C5U7nUAfVEjLFRrUXtHsy+nsTE2A0LcKOVRcf6
	LKO3fwxicgD3OSVqPzZWYiQ8ceKqU5szlzyRmKlCQqutYkqFRsCL3UAco8Etfn14
	tLro5FQqMCzGbHeE5qEN5co4PrG3Srtk0C549MlU8nAVS3UDxLx2AGg1U0lFtyum
	hSMD813FFNE0GP2osx7hK59sZujkfWUI6KSNURdKc/8+35+k64TE/03uTNbEMQMc
	fgm1iwzjY4MputaLPqXHbEWieZGoVu8oXxCnbM+44uyNU3FrmSc79MRs4l3eh6LI
	5ZYLIk2fchik5+wD8rUtwGqMiEh2BJnsv/A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucapag9v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 22:22:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so3562175eec.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794262954; x=1794867754; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=St7kPuwx8TTNbOiHL4PqED3PJrgepz3coZt/Tr0CXik=;
        b=iHLieAc2YS7GOy5yNr+X19GqdnoxtsokouI1zHOsN4hQ84d2x5vFmAWUPFwnMXtNLB
         MFs+qNWqp0kxTw0QUWQjGSyr9Jax/rIlmXleUDAqd+9XL+LGfG7ByMspKdtALzgmh2gi
         7dk/zkVFGbAs1mUyTlRRCUKGPY0+o8eCcZMzZb7visFnwNuExc4AWTx6ahpHl1JjU/i0
         +JsxOADT+J3+4tU+SNTpjJ+MoPQI9if3WTvgAhAB4SSgG2yGNd2poi5GlYDmOjqhlgwJ
         ubhG3gD0tdpmo137I8/UdHJBcl5iLvGeF0hT3MZMsyvg+WGFsuM+SD9+Soov39GKpcYy
         rUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794262954; x=1794867754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=St7kPuwx8TTNbOiHL4PqED3PJrgepz3coZt/Tr0CXik=;
        b=Qt8/v076/GPqkia/T9oUYWkAtpMQU0u02XSScBeda6nnqJwTwhMQvIw2eV+T4MwxTI
         iTBMSjcYnSSxxiKlhCgLkqGAEl4DCo70TPP+4CKDkyOWh8go6vBkA5OyhExVYV5QqtqS
         4SaH6IjWdD60k4d49sO991Q/Gqt77kDk1dVHsAhLeoDJWobpfwDPwIVQLu0VC2sDtuUc
         QJsfOSBZuEWsYMrqu3di0lI3mT0uz5ttQgALsm0yAawF70pjvjXP3I16SvBydsBTIeVc
         /a6LlkHmYgFWbNznBYJ1MGjCukEdcowRbmC8Wq2K4HUo7zbCGUYRXQmXIHJ5qQF3cRS9
         Vm0w==
X-Forwarded-Encrypted: i=1; AL+hErGAojuoksV2ORe04tjm1/V7Lfus4HwZ5/NL6dggLDRKCeef42fD1jSbnlZ3MTwH7wn7tXmshQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9BS61MPw8MYM4LvEEfZZeuioSxH2XhP1yR3x/FOa/hB3vDb2/h
	AzT0mY/f2LNnaCR9clMg8I31UxG93rG67fLEZyvvW6Ydh5oLV7MeBiI+Rgkbjm3/sB9veIHW8lW
	oyOF/GmI7+Uff4gSb2IBAB4J2OC5GyI2Ir/9LoeT+vB2fYZ4q6HYqlBf1dw==
X-Gm-Gg: AYBFou0ms8nArouuk27P6Y5uXOjfVk3dC3+XX5xUCU7YZPwYTnBrTV6bLDqDJvnRgCF
	XRS3WHX6qDAqdAYhcRZqGx7DFWMqzfxO0HiYZ4aUkR6DFdoWCLHKKKyRFvuQbNoTjA7yafo7Tju
	QBVHVKuno2OKMeNuYoPFCov8u2C8h/1giBDXpf+H3taGj/d1XXkOeO3H6Y4zEeS8N1sbb7jBAMd
	w5FskXDiCEzSmWAnFu8bVgGDnTbUwuSlWPI1vZTSxk8l4EnHk30wTmmN8NX5+l+YynmUaCg/5dL
	VEyM0N3H+Dv6zy5ghWBiSMiKv4tomW2ICrTkL7EHb69H+0K4aFyiz44uS+/vjcOjuDDk2Mg6orX
	BcUXqb02fMucXq5gTQQYlLJt57G7I2MWJzPFdlMdH0fKEvYrq4YueOPXJc3l+OdFvZUtubatLQS
	pRmVMEx0eJo1hX6WP5LWJ5c9DaI9cI8pkDPZeqO7ZaI9BJX9tI24wtsvIqr3ATZ5xP
X-Received: by 2002:a05:7301:781:b0:36f:4a4e:6218 with SMTP id 5a478bee46e88-3753ab03351mr439492eec.38.1794262953832;
        Mon, 09 Nov 2026 14:22:33 -0800 (PST)
X-Received: by 2002:a05:7301:781:b0:36f:4a4e:6218 with SMTP id 5a478bee46e88-3753ab03351mr439447eec.38.1794262953068;
        Mon, 09 Nov 2026 14:22:33 -0800 (PST)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe32276sm1252133eec.8.2026.11.09.14.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:22:32 -0800 (PST)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com
Cc: joro@8bytes.org, kees+treewide@kernel.org, gregkh@linuxfoundation.org,
        dakr@kernel.org, panchuang@vivo.com, prakash.gupta@oss.qualcomm.com,
        akaieurus@gmail.com, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu: Work around Qualcomm SMMU-500 TLBIVAL granule issue
Date: Tue, 10 Nov 2026 03:52:14 +0530
Message-Id: <20261109222214.3988154-1-sibi.sankar@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4OSBTYWx0ZWRfX4DJlMlVW1h+/
 gLXiaEvwYuMNao1QAUWSFAvFL0fRD3s+YCOmGw3RVxXU0q86PEo84zK+mUHXBOLUPv7fWVMAJWI
 1V8FzJo/RZLImAsCUgjqCURRqmHqtkpBgwZlYSq/iLU5WhWimAUhCXL4TvLNGT1TbXVRS3LPcpG
 eKYZnWoSj2EQuvZgmJkCv/tSoQAKkvA8ffvjUIQvQLHAgqSqk00HwQpzDK9kQa1YVh6gXY4/Gra
 Wu/5fYWsPluV6ua0R7jIQy4oU5vP+lKODfR1Tx7T6VWQsmvHNC700XP6QuQJM4AW/F5MehtQ4ym
 RFa8sM9IxoiqP+9VGhHJGnpla/kZvLJIGzItSLv2cq73t9OPfX6W7t9R2VpNHLsRLpTtiF/bn3s
 J++kvw6iziFVNoI9ZNG8Abb20fgAvCWDnLY3bHYoP9AFjA1GP5bDUlhYmBEf3izT/IT7ZRgxsNJ
 jnUaISZXh590WFqPw7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4OSBTYWx0ZWRfX7kMhDMHf2o65
 Sphz/BiLm7xVx1IbnXfMoHjLnwu5SlsROeZR+jZv8nwu42QJNX9PdiTothgAJi5VNDruSQKUYGG
 ayrxfNUnOSuGwTi7dYiqnvBhyN/V1Zc=
X-Proofpoint-ORIG-GUID: c2FIW6T2jXeSe0RSGIKKsjF6_K92_tQz
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af247aa cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=cRIvcy3ebCmbRUWD2K0A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: c2FIW6T2jXeSe0RSGIKKsjF6_K92_tQz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090089

From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>

Qualcomm SMMU-500 has an issue with TLBIVA/TLBIVAL where only the
base-page-size entry at the base IOVA is invalidated, leaving stale
TLB entries for the rest of the range.

This causes use-after-free: after dma_free_coherent() unmaps a large
buffer, the device can still access freed physical memory through stale
TLB entries. On FastRPC workloads this manifests as ADSP crashes when
the ELF loader writes to a freed PA that has been reallocated.

Force the TLB invalidation step granule to the minimum page size for
all Qualcomm SMMU-500 domains, ensuring each page in the range is
individually invalidated. The minimum page size from pgsize_bitmap is
used rather than hardcoded 4K to correctly handle 16K and 64K granule
configurations.

This increases the number of TLB invalidation operations for large
ranges, but correctness takes precedence.

Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Co-developed-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 28 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      |  3 +++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 795e8ec7e8fa..a51152b4e24b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -430,6 +430,24 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ }
 };
 
+static const char * const qcom_smmu_500_tlbival_errata[] = {
+	"qcom,eliza-smmu-500",
+	"qcom,glymur-smmu-500",
+	"qcom,hawi-smmu-500",
+	"qcom,ipq9650-smmu-500",
+	"qcom,kaanapali-smmu-500",
+	"qcom,maili-smmu-500",
+	"qcom,milos-smmu-500",
+	"qcom,nord-smmu-500",
+	"qcom,sdx75-smmu-500",
+	"qcom,shikra-smmu-500",
+	"qcom,sm8550-smmu-500",
+	"qcom,sm8650-smmu-500",
+	"qcom,sm8750-smmu-500",
+	"qcom,x1e80100-smmu-500",
+	NULL,
+};
+
 static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
@@ -440,6 +458,16 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 
 	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
 
+	/*
+	 * Qualcomm SMMU-500 has an issue with TLBIVA/TLBIVAL where only
+	 * the base-page-size entry at the base IOVA is invalidated. Force
+	 * the minimum page granule on affected SoCs to ensure the full range
+	 * is covered.
+	 */
+	if (of_device_compatible_match(smmu->dev->of_node,
+				       qcom_smmu_500_tlbival_errata))
+		smmu_domain->cfg.force_min_tlbival_granule = true;
+
 	client_match = qsmmu->data->client_match;
 
 	if (client_match)
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 8d50a4ad221d..92251536e9b0 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -286,6 +286,9 @@ static void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size,
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	int idx = cfg->cbndx;
 
+	if (cfg->force_min_tlbival_granule)
+		granule = 1UL << __ffs(smmu_domain->domain.pgsize_bitmap);
+
 	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		wmb();
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 26d2e33cd328..85d1f2d7ec50 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -359,6 +359,7 @@ struct arm_smmu_cfg {
 	enum arm_smmu_cbar_type		cbar;
 	enum arm_smmu_context_fmt	fmt;
 	bool				flush_walk_prefer_tlbiasid;
+	bool				force_min_tlbival_granule;
 };
 #define ARM_SMMU_INVALID_IRPTNDX	0xff
 

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.34.1

