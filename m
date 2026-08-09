Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2141F3D6CAA
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306563; cv=none; b=W6Y0BeGMoxj87R2XyihXzMdAC97qnT+b9MIak0FpzGIa9/C12eG4Vx9c/YWYSgRVQB8zeLlQmkxlBs7X9GRvLt1MKSd883kMg27A7i6xgll2f1DNFx2c/00l0ZdWqfiYUAly/SunP8WyQsocZ02tMg8DGEy48pjWzL9/edLLbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306563; c=relaxed/simple;
	bh=+sGtB20DBa8qqNqIVi9KLViUpBY6FE9rYJuuV2Wv9ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vCsQq1wyi9q/lO68CF8oWT/Kf0Qqo0qxvNUO2Q9IRmjbya8RXcyaXItl6qzm2zlTx06gWMgLbHCL7LCmrgHyvbA9KovuGi417Tvo3Fkk0qCCNOSziUePXnZlh0zXE3g1mS2ZMDK35OuTvNWO8BBVm85I/sEG5qk6+kjizCVtpKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j/JeoyK6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rp8/WfhH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j/JeoyK6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rp8/WfhH"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679Jb1mU3925136
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mK+aHqMyUy9njtJyec2hF8DLwos0hr+XP1bl216r8YQ=; b=j/JeoyK6QvGzfGHB
	ZJM7uNlRFk7P9Goo9zIO0UiL/WOWQDMnkUrs9Sud3lDk0pNCVx6pLp8ubUyQPRlz
	MCP+3FgMudL0UoWNPwQf63/Bag/i284Y778eGXKlZTK2V4wMK5u975aJfkNPM5/o
	JSQRKeLO0UXpBHXV1JT30UK7qq0jnJhIMIwikGfEt1gAefTv3YQpo1jEZvEH9mPH
	jtCck0F8Hi8c1B710uwX4xod+wapDUScDH21k+A3LELc3ybfgHjy5FfMbhuLQwJo
	CuXEyosTJ0vV9PsGtbI/2xZ1uXQxrKoRqJjrYsxcUTQYhzGpU63zCQLfS87DbB0R
	t2PXeA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf7bjf2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:16:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bf321d786so15338381cf.1
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306560; x=1786911360; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mK+aHqMyUy9njtJyec2hF8DLwos0hr+XP1bl216r8YQ=;
        b=Rp8/WfhH9Q2hTbntOpansMASSYej6JHZYR6v+lLgpc4XBhboOTmle/vVjNQwjOM+6N
         Uuf5olsrmCIMAd0rFh/TyhvpPYCjgsdQguAgqvTpLTuAT3HHElhAKxTNiXG05uUcv2da
         wI6kIesLlX0lzwlg5rVSM9BFYY7lRl/v/iwFqMHZUjV/N/up/16+8Yd/NxXGiN/pziyQ
         +f2rPTiZoJpe3ozNpyS2UoA1Vh+CDxTMBCQs5KI//ex1FxmnbYBO7v5L40rlC5kG3dHx
         UpWjtA++mtzAE2sbw6sRgVu4q7x3p8+cdaC9Gzgl/+s2y/2Y/AOGIZo4j+z0w/rZLe45
         QZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306560; x=1786911360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mK+aHqMyUy9njtJyec2hF8DLwos0hr+XP1bl216r8YQ=;
        b=p8C1rpEYNIR/23B/UYmjW+Ql0J0K7gljm6v8SB1OUBtkFQKf+iE08+EeGuWTlabNhk
         JqRjaKqhjhFFXJlLRWzc66LYCPTnUFl/cLceSjPfE7ZhyTOAfIJoLAbrvIVzwIjBZD8q
         pQ7rTS1f0qXeMrHSCtl4b5d96AnqDjYUctCobOu2shCgPPpDBbSXSaASdPm69VAat+f9
         RyGYJn2pL7KogltiiV4erSCjk0xxY/Pf0nRRb4mU9NRPI0QaPToPhYGkJQmokN192eRz
         afDABgcZNw0yAB+BfkQ3X5BXLl0JtYTUJxPKPLf3C5bQ27cpe6vEC3DeNyEYxF7HHB4m
         jlGg==
X-Forwarded-Encrypted: i=1; AHgh+Rqeqmdy10stoARltTqPYdCh+1qbKEcqWyQItWKriO9VjrtkCEKOABckbtyc+6Jrt2BKbxaIKw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yymt4qYkIRUORQtVelLplmtGEjl9ZrT8+9h/WsKnUcAjZ+p+GC2
	AfnOZsjZp609OHc4MdveImpGsMlBMEE6cfGM/ZKD3gwgDt2QIiKoIxupfb7v7ZVQQ+0FQam3Qe/
	pWfX17W6yZSBeAHtNOveZYRL0WN2I412HIPFRfkvk5PTe6lgyXk+1NUcO0g==
X-Gm-Gg: AR+sD122fSc8pR/lOfjoO7op5QH4YekP48HmW0SCL2s2muiAMyhog0yHCmWQ0nF2oAG
	JCuMuYO1qnZEYFT+aC/Ujjextxmfke5QX1kE79DT6gU2AZLU2bv9O1LuWfCKB9vtUpJ8tj3iE++
	VvyKiPr35JHIKr/P/+Jq+/7YiH/I2JLLYSxOegzfcTZ4D5NevXHpQU+eRVgmNXtugucLucfxZiO
	1IhnTIwJVwR9AT50I3+RMrZNDHFA8c+NWRg2w9LA2d0NLeFESrlMTRfwaG78G9TKi0E8Y5ltZCZ
	J3GivMOJrCvN2N6P4tCFMtsBT0UxtvLqfSy86BB6AXi1v2xBzUtNS69JYu1EpcjBNMcrSopmy+9
	86NoXSDDXj3Ag8fCeMig8fCA8onU6WZ+AfKGdjUFo0FlubXgcBVk8uZl1oydju4K8vAdZiExPAt
	3pv/TAI1q5BkdjHQ==
X-Received: by 2002:a05:622a:2592:b0:51c:17cd:1fe8 with SMTP id d75a77b69052e-52d1904b11dmr207282371cf.33.1786306560336;
        Sun, 09 Aug 2026 13:16:00 -0700 (PDT)
X-Received: by 2002:a05:622a:2592:b0:51c:17cd:1fe8 with SMTP id d75a77b69052e-52d1904b11dmr207281981cf.33.1786306559841;
        Sun, 09 Aug 2026 13:15:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:15:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 23:15:44 +0300
Subject: [PATCH 05/12] iommu: qcom_iommu: handle the SMMU global register
 space
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-msm8974-iommu-upstream-v1-5-87f5cd492560@oss.qualcomm.com>
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
In-Reply-To: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5119;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+sGtB20DBa8qqNqIVi9KLViUpBY6FE9rYJuuV2Wv9ck=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeN/uzq2IIlj4vq4UZMQqBWgBuq+dTL6lcATnd
 c3oAVUOahGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCanjf7gAKCRCLPIo+Aiko
 1bVqB/9eOKxGGydYLpvk9Ll8KLUoK8OR1oxKAUEbO6UsA81v/vRkXO63K1qpBCDgCEm5PKDUWRU
 uifVOkGaX72mkIcVut/2vzGPPy13y7IPlJgrbCqLRtABm8rc3bkXJ7GWPz4UAr8GlhseKxRlKSU
 0JLgzEPhnCZHojnfzZh/SSQbzL2Ko9pn27JCzCqPchnz93OJRPWLQCRatWoYh7k5cRzvdhGZhaO
 wxVEwgFPXz2U6zS8QQBYkkpTgS9WAuE02UwaOk7ez89Hd3c91uE3hXi26dG1UpcwC/l1AhzCpN4
 tx6nesPf/snfpK6qeo9u56hJqx/dxq0J6oEeQXdUpg948oVe
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX1N3BZYPWrUvZ
 Xv7tsesPqFqgZY0yD58V168AteCSgGZhdjdVSig0lEOboCM0fLt6uYGNpkLgfcdf0RKVt9k0grU
 ibfgqNgq1eNry4copqjHidTfxPxAXXM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX74Un6V6RhUty
 mQSYLDjYTMoHAdetkyAAjiJAAT/i05QbW4ib2PYFfm1Nvn1qXfhgFLJdmmZYm3cu/NbicurEN/Q
 38dBdlY0sxLbqYg0UpQWqVSrm7ZFybQfhGI14kqX/7GRwi1f39UC1kBfAdXxnu1dvcesJFa1WVV
 UrWRG8cmcbd6LQBjTrhONgkmE/sUhGvxbRk1KSE3yiz64zl/RfGMw6wNagVmmxgq3eXH8gUhlrE
 mE1BhWi+RdIc8DR/DHJm8q2S6/G8L/kzgAhJjak0i+Zy4e3COEVu2CGgsYBSQEsQ8WnZM4ZBEZa
 F1E6NkkV82RT1zL697cu5nuEsUH4oKhk1s8jRP0hayrXMdVNVhTAdt14nXI0V6vg9GWTKHobo1/
 Q+WvOvi9UPsug5/UiN0eEa0t6geOt9UCEdlBtk9M/ZSqUWDSxd40zxYvcTtOiwEAMKtjIp66kiy
 /Lzzmkc0nzF/R6iSZWQ==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a78e001 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=2qLXTtW6F1X4e_bQErwA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: qdviIrlEopJ8n3Zui55_bZ8oweG-ydk3
X-Proofpoint-GUID: qdviIrlEopJ8n3Zui55_bZ8oweG-ydk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090183

On msm8974 the OS has to access the SMMU global register space: the
non-secured instances need it fully programmed and even the TZ-managed
ones expose OS-writable implementation-defined registers in it. The
driver only knows about the msm8916-style "SMMU local" region in
resource 0, and has no accessors for the global space.

For instances with a per-instance configuration, treat resource 0 as
the global register space and require it. Never perform the
SMMU_INTR_SEL_NS write on such instances - offset 0x2000 from the global
base is the implementation-defined MICRO_MMU_CTRL halt request register
on this IP, not the interrupt select of the separate msm8916-style local
region. Provide gr0/gr1 accessors for the following changes.

Do not clear the FSR of the context banks at probe time on such
instances either: they sit in MMSS power domains which may well be off
at that point, and an access to an unpowered register block stalls the
bus. Skipping the clear is safe and preferable to powering the domain
up for it. Safe, because a collapsed context bank has no active logic:
it can neither latch a fault nor assert its interrupt, so the window
the probe-time clear protects against on msm8916 does not exist while
the domain is off, and the first runtime resume fully reprograms the
context bank - including the FSR - before translation is enabled, so
any fault state the bootloader left behind is wiped before it could
matter. Preferable, because taking a runtime PM reference just for the
clear would be a power cycle with no lasting effect (the cleared state
is lost again when the domain collapses after the put), and the
get/put pair is actively harmful for the MDP instance: at IOMMU probe
time the display is still scanning out from bootloader-configured
state with no kernel driver holding the MDSS GDSC, so the final put
would power the scanout domain off mid-boot. The same treatment
already exists for the TZ-secured contexts, which skip the clear for
banks the OS cannot reach.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 44 +++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 77c01f217d7e..428b18697244 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -34,6 +34,9 @@
 
 #define SMMU_INTR_SEL_NS     0x2000
 
+/* GR1 sits one 4K page above GR0 on the msm8974 QSMMU */
+#define QCOM_IOMMU_GR1			0x1000
+
 enum qcom_iommu_clk {
 	CLK_IFACE,
 	CLK_BUS,
@@ -57,6 +60,7 @@ struct qcom_iommu_dev {
 	const struct qcom_iommu_cfg *cfg;
 	struct clk_bulk_data clks[CLK_NUM];
 	void __iomem		*local_base;
+	void __iomem		*global_base;
 	u32			 sec_id;
 	u8			 max_asid;
 	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
@@ -130,6 +134,26 @@ iommu_readq(struct qcom_iommu_ctx *ctx, unsigned reg)
 	return readq_relaxed(ctx->base + reg);
 }
 
+static inline void
+qcom_iommu_gr0_write(struct qcom_iommu_dev *qcom_iommu, unsigned int reg,
+		      u32 val)
+{
+	writel_relaxed(val, qcom_iommu->global_base + reg);
+}
+
+static inline u32
+qcom_iommu_gr0_read(struct qcom_iommu_dev *qcom_iommu, unsigned int reg)
+{
+	return readl_relaxed(qcom_iommu->global_base + reg);
+}
+
+static inline void
+qcom_iommu_gr1_write(struct qcom_iommu_dev *qcom_iommu, unsigned int reg,
+		      u32 val)
+{
+	writel_relaxed(val, qcom_iommu->global_base + QCOM_IOMMU_GR1 + reg);
+}
+
 static void qcom_iommu_tlb_sync(void *cookie)
 {
 	struct qcom_iommu_domain *qcom_domain = cookie;
@@ -749,9 +773,10 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 		ctx->secured_ctx = true;
 
 	/* clear IRQs before registering fault handler, just in case the
-	 * boot-loader left us a surprise:
+	 * boot-loader left us a surprise.  Instances with a power domain
+	 * may not be accessible yet; they are reset at first resume.
 	 */
-	if (!ctx->secured_ctx) {
+	if (!ctx->secured_ctx && !qcom_iommu->cfg) {
 		ret = pm_runtime_resume_and_get(dev->parent);
 		if (ret)
 			return ret;
@@ -845,9 +870,18 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res) {
-		qcom_iommu->local_base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(qcom_iommu->local_base))
-			return PTR_ERR(qcom_iommu->local_base);
+		if (qcom_iommu->cfg) {
+			qcom_iommu->global_base = devm_ioremap_resource(dev, res);
+			if (IS_ERR(qcom_iommu->global_base))
+				return PTR_ERR(qcom_iommu->global_base);
+		} else {
+			qcom_iommu->local_base = devm_ioremap_resource(dev, res);
+			if (IS_ERR(qcom_iommu->local_base))
+				return PTR_ERR(qcom_iommu->local_base);
+		}
+	} else if (qcom_iommu->cfg) {
+		return dev_err_probe(dev, -EINVAL,
+				     "missing global register space\n");
 	}
 
 	clk = devm_clk_get(dev, "iface");

-- 
2.47.3

