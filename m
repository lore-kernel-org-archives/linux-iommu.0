Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526C3E4118
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621291; cv=none; b=Z+5p30ZkSabDBSFSpaaCsCKIeZTS/U/ExErVjoDXhnFiy4ltW9605rgu0Yca5T9Hhrzr+S3QpzxLrDCKoburp2wPFHvS5U0TeMV8ZeWWLGqMkll1GBUUeLnNaoHJ5ur2hAnFWnk1WYKeWMNSSdsL1Bb7g7eGHkwB67IYxx6m+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621291; c=relaxed/simple;
	bh=vD9rSJDP8x9PwXl9K5hnyRGQ1BA8Zsd0Mk/jziWWWSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HO0B2e/taEN9kfwNUhtOzer8B1tTdxBdUgf8V3FTjeDBmKvLJ3JQVPbz3rz6jXOh1fA6pZWQ6B7BDa06aoCIgd9ZwAHPt6vknYDJkCB30bZnPOxq5EQ8f+9TwUuOQrf0I2uGfsL76oa7vG9wxKdWw2kpjd2JWrbD9Yb1nLEj2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VmqeEv7o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dDAcb0BG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VmqeEv7o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dDAcb0BG"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H44AWi4038577
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ELOxM4ZOEXnb0gqasQYqPct6U4hXPnR2eQW+WWya7Yo=; b=VmqeEv7ouuuOPE88
	34a/00gubBS6VfvIIwPkhQnxRrkDhbOEubj5fN8zIDRCd8WEs9Nzij8z8+aLSlS6
	qUAyZx+Z9CC23bD4GE8qyqdw0f9gC5qlHpWu6JSWMsVF0bJGwkQZlTL1IQAev0uT
	vkdb8Ubo9s1BcmZyjpPizfTxs3vVi54aPL3tQN2bSC/1PxoUgisdq+6Hy04Q5SUh
	94stlTyEFsY0X0QdgZWO5Bg+2McoEj+Dv5diwnoYmHBe5etP8lNu34WK4YHi7TBp
	fpBgibPJkRy1MwZhgZvWF+0puHcsqet0DbKchBUI6VuANilBCAocP44LsJ9MCBk1
	3IZPRA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr8uw062b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:01:29 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc2229450b4so375925a12.1
        for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 22:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789621289; x=1790226089; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELOxM4ZOEXnb0gqasQYqPct6U4hXPnR2eQW+WWya7Yo=;
        b=dDAcb0BGBjMNwGJiGJu/QCkgO0gQ0ixZVJSqrtjyWHUsTXSAEle+M9/opN9VTQ4bQ7
         a8jHUVTK84OdrNl4H7+2HWqiU6pZXoFZ+SbwivWRvnk8MNg+88WcQAPkKxHD9D5LYSzk
         2OScQHCJDziYEXGMQZDaoECXTSWdkTnShlMIByH33fuLod8rgsNbC/KhcAd+j5sdE+J3
         xg4l3+ukhsmYMcAg+u/7g2GwHuC+YQPfZuaf0tNu6JBV+bCGABCJJVDDz8VDi16HuLo9
         thyaaY3AlJcG2Y+CF/6Qzm4Pa+x0i26u50xL1j/zMaCK4gOHdY7TEAh9jJOcPY7GMGhy
         lM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621289; x=1790226089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ELOxM4ZOEXnb0gqasQYqPct6U4hXPnR2eQW+WWya7Yo=;
        b=NYKeP/3HKze9jPfYT5BlrewLAasb0lZrLUwC2bMg5mZUwK/W6KYvcrXq2XwPm2xVwI
         VO7ILQpfOH9DedjtlmGTkGcJCxve0p52f7TGVsNPrFB7l91jVmWb+gvWT3sXEugLzk+E
         ZwUoujc7j6JLGVzLkep/ny7SFWTTZPeSF1ZLfYkLJ9jucz9Q00nkWkViGdyZn3FFNARa
         sTcV1BbL8hZGaPnh5D201CuFFnReDN/3WRbJsssv2B+i3wU4RvTxfNkbpu7F3MAILfe+
         Ya9ONtrqmEmxGdtEeQoIl1Jd4ELFVv5Gecnx91IoTRP9KaGBjM5YinZAdNTf2bY9LCI+
         ZLJQ==
X-Forwarded-Encrypted: i=1; AKwUvByWuf2oIuqOUVss9l+mX+0MA4Yy5Wz09FUg+veVmwaKYJikheemxrWVChBJQZfukobJRy0BTg==@lists.linux.dev
X-Gm-Message-State: AFuF++nEzyoigMULWU0brtZ8zsOuP3CtOG4VbJw7MQYJYsNXfWYwKn3p
	mmDwSSLkbkCb6MoprR69dSbDKB9PeiYjCfwaQQFIhipEGPo9ykr09t3zu5rEtV5B8mk6M0HLCps
	FNivXn86aGhn396DYy9U4iK4SJlv+088w1PfmYmxVUF4dBmXDkEOS2D8jkA==
X-Gm-Gg: AYBFou3HnmHqe6MJ5eocmv/p5mdGpfzLkHfYsQVpqJdlA7CLEqBO5auNK+BU24jYiUn
	a9Zn+PL3zlh251NeMytpnPh/CT228VkqTDnZXYEDu6l7+9ghD3h3neW41t4X1LV47b9VTXj09g3
	cqI6snE2JtZT7P49gpENxPcmhs1kI3N5YKO2mUHu4KOwHWwJRIWOAI4F7N2MynaSwUQTf+tpD0K
	fB90ebkDfi2bSK3rRkl4G8AoQSa1xnoYQJJDZJ7trAQtNbnlEJwqM5yVJsP8OIPYIRahavrYTJz
	ksBC0kHNJk2N1yg5X7FmAie8t6N6NoSlr/hwnd/WoH38tMtQGL/Yvb+URzDC2SWd+M3fVXOJUPh
	rglsky1dF4qB1VaBxf5LdBf4QdO++CGHLyQ==
X-Received: by 2002:a05:6a20:a10a:b0:3cc:45cc:c401 with SMTP id adf61e73a8af0-3dd5f5af443mr12800527637.13.1789621288441;
        Wed, 16 Sep 2026 22:01:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:a10a:b0:3cc:45cc:c401 with SMTP id adf61e73a8af0-3dd5f5af443mr12800418637.13.1789621287814;
        Wed, 16 Sep 2026 22:01:27 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b2753csm23544223eec.31.2026.09.16.22.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:01:27 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:30:21 +0530
Subject: [PATCH v11 2/9] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-glymur-v11-2-e0c8bc914742@oss.qualcomm.com>
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
In-Reply-To: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789621265; l=8492;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=2/Gq93R9cpgwk7KxsAU2reyrjwlqEiy3PAOkiucUGPw=;
 b=ysEdEgwI34d1zGh7C9vj0TKupQtTIoDYLMYw4GMTnJKnDbHaUuGOKK8unpHgFyaSsREf99LJb
 ugAu/qC23BkBKIdPhjr6vM6Bu7ezHMAWD8l4bcb2UY/MZR7aI7ZSx+r
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: ixUrrIt6nuoei0xUxxgFa_Bu6X_Jhm8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA2MyBTYWx0ZWRfX5v2PEdM+P8M0
 VkPKSohXbFHxEuOMVy5oorj949S2rx1P2FqR5GUAvOmA8WFN7zGOpAUHeK1cv/Ek24cidZINL5k
 tiFZJbFyQ0TuvBAp9Od26fsdaA3s396fMzPmLfDnNiOFYmY5CZglNiG9uNWX3/vvfYp5Gp6OqsY
 85csC/U/oCJjHDIh1/ZDIiHTe8UaidY1zw6MqCBuqq+u+3T+agD31ueW7guJVZ9ZhdfOuFrDhE2
 QO4mv4vrmiTbPhWJiBpmoVN5v6cDjNS/Chwpa1SioYjSFy6CWz9W5dFRWiDc4sklqJjDn8uZztV
 /MDrcuMSjM1JlWVX/p9PGCKcrbECAXNwCx5FPS/p1datQU1bV+oPq+RSvtwxL5bVn9JQDXiOijV
 YceWR2pF/qpgsdyy+N3jZi0HgHgO6IrD7GwdMqp3D8mcLR4vyruoPU3CL52+wJDXfJ4pGqe+cTQ
 muUDXS5IDAlvtZQZgPQ==
X-Proofpoint-GUID: ixUrrIt6nuoei0xUxxgFa_Bu6X_Jhm8A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA2MyBTYWx0ZWRfX6UFEtolXb8FC
 OAIuHbvknbps5URjEmqh+0VRHv7Ab9qMdbTpoNnvefPJ8zYLDtR0GbKbS2lKDJSQMCfc2hEMSnO
 5HPh/F2Lsb/OaoIiyKL/gCTR1DaW+tQ=
X-Authority-Analysis: v=2.4 cv=dMUzC+Zb c=1 sm=1 tr=0 ts=6aab7429 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gsvzk-epdriNwW7vwuEA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170063

From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

On platforms where a hypervisor is present, all Secure Monitor Calls
(SMC) are intercepted. For qcom_scm_pas_auth_and_reset(), the hypervisor
registers a Shared Memory (SHM) bridge over the Peripheral Image Loader
(PIL) memory region so that TrustZone (TZ) can access it, forwards the
authentication SMC to TZ, and upon return maps the PIL region and
triggers the co-processor bring-up sequence:
HLOS -> Hypervisor(SHM setup) -> TZ(auth) -> Hypervisor(map+reset) -> IRIS

On platforms without a hypervisor, Linux drives these steps directly.
The SHM bridge infrastructure required for this is already upstream [1].
To isolate firmware memory in its own Input-Output Memory Management
Unit (IOMMU) context, a dedicated stream ID (SID) is required, tied to
the firmware function ID. This SID is specified via the iommu-map
property in the device tree using the firmware function ID as the lookup
key. A firmware device is created and mapped to this SID.
The presence of a SID mapped to the firmware device via iommu-map is
used to detect whether a hypervisor is absent: when the firmware device
has a SID mapped, Linux manages the IOMMU directly; when no SID is
mapped, a hypervisor is assumed to be present and these steps are
skipped.
Extend the Iris driver to support Secure Peripheral Authentication
Service (PAS) on platforms where Linux manages the IOMMU, by creating
the firmware context device and performing the necessary IOMMU mapping
when the firmware device SID is present.
[1] https://lore.kernel.org/lkml/20260105-kvmrprocv10-v10-0-022e96815380
@oss.qualcomm.com/

Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/lkml/20260105-kvmrprocv10-v10-0-022e96815380@oss.qualcomm.com/
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
 drivers/media/platform/qcom/iris/iris_firmware.c | 69 ++++++++++++++++++------
 drivers/media/platform/qcom/iris/iris_probe.c    | 12 +++++
 3 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 3c96f46cf567..5ed2ec0b97ec 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -38,6 +38,8 @@ struct qcom_ubwc_cfg_data;
  * @dev: reference to device structure
  * @np_dev: reference to non-pixel device structure
  * @p_dev: reference to pixel device structure
+ * @fw_dev: reference to firmware device structure
+ * @pas_ctx: PAS context for authenticated firmware load and shutdown
  * @reg_base: IO memory base address
  * @irq: iris irq
  * @v4l2_dev: a holder for v4l2 device structure
@@ -85,6 +87,8 @@ struct iris_core {
 	struct device				*dev;
 	struct device				*np_dev;
 	struct device				*p_dev;
+	struct device				*fw_dev;
+	struct qcom_pas_context			*pas_ctx;
 	void __iomem				*reg_base;
 	int					irq;
 	struct v4l2_device			v4l2_dev;
diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index 21cdf1c39835..8ab8c3cc9eef 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -6,6 +6,7 @@
 #include <linux/firmware.h>
 #include <linux/firmware/qcom/qcom_pas.h>
 #include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/iommu.h>
 #include <linux/of_address.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -16,6 +17,7 @@
 #define IRIS_PAS_ID				9
 
 #define MAX_FIRMWARE_NAME_SIZE	128
+#define IRIS_FIRMWARE_START_ADDR	0
 
 /* Detect Gen2 firmware by scanning the blob for:
  *   QC_IMAGE_VERSION_STRING=<version>
@@ -110,23 +112,31 @@ static const struct firmware *iris_detect_firmware(struct iris_core *core,
 
 static int iris_load_fw_to_memory(struct iris_core *core)
 {
+	struct device *fw_dev = core->fw_dev ? core->fw_dev : core->dev;
 	const struct firmware *firmware = NULL;
-	struct device *dev = core->dev;
+	struct qcom_pas_context	*ctx;
+	struct iommu_domain *domain;
 	struct resource res;
 	phys_addr_t mem_phys;
 	const char *fw_name;
 	size_t res_size;
 	ssize_t fw_size;
-	void *mem_virt;
 	int ret;
 
-	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
+	ret = of_reserved_mem_region_to_resource(core->dev->of_node, 0, &res);
 	if (ret)
 		return ret;
 
 	mem_phys = res.start;
 	res_size = resource_size(&res);
 
+	if (!core->pas_ctx) {
+		ctx = devm_qcom_pas_context_alloc(core->dev, IRIS_PAS_ID, mem_phys, res_size);
+		if (IS_ERR(ctx))
+			return PTR_ERR(ctx);
+		core->pas_ctx = ctx;
+	}
+
 	firmware = iris_detect_firmware(core, &fw_name);
 	if (IS_ERR(firmware))
 		return PTR_ERR(firmware);
@@ -139,22 +149,40 @@ static int iris_load_fw_to_memory(struct iris_core *core)
 		goto err_release_fw;
 	}
 
-	mem_virt = memremap(mem_phys, res_size, MEMREMAP_WC);
-	if (!mem_virt) {
-		ret = -ENOMEM;
+	core->pas_ctx->use_tzmem = !!core->fw_dev;
+	ret = qcom_mdt_pas_load(core->pas_ctx, firmware, fw_name, NULL);
+	if (ret)
 		goto err_release_fw;
-	}
 
-	ret = qcom_mdt_load(dev, firmware, fw_name,
-			    IRIS_PAS_ID, mem_virt, mem_phys, res_size, NULL);
+	if (core->pas_ctx->use_tzmem) {
+		domain = iommu_get_domain_for_dev(fw_dev);
+		if (!domain) {
+			ret = -ENODEV;
+			goto err_release_fw;
+		}
+
+		ret = iommu_map(domain, IRIS_FIRMWARE_START_ADDR, mem_phys, res_size,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV, GFP_KERNEL);
+	}
 
-	memunmap(mem_virt);
 err_release_fw:
 	release_firmware(firmware);
 
 	return ret;
 }
 
+static void iris_fw_iommu_unmap(struct iris_core *core)
+{
+	struct iommu_domain *domain;
+
+	if (!core->fw_dev)
+		return;
+
+	domain = iommu_get_domain_for_dev(core->fw_dev);
+	if (domain)
+		iommu_unmap(domain, IRIS_FIRMWARE_START_ADDR, core->pas_ctx->mem_size);
+}
+
 int iris_fw_load(struct iris_core *core)
 {
 	const struct tz_cp_config *cp_config;
@@ -166,10 +194,10 @@ int iris_fw_load(struct iris_core *core)
 		return ret;
 	}
 
-	ret = qcom_pas_auth_and_reset(IRIS_PAS_ID);
+	ret = qcom_pas_prepare_and_auth_reset(core->pas_ctx);
 	if (ret)  {
 		dev_err(core->dev, "auth and reset failed: %d\n", ret);
-		return ret;
+		goto err_unmap;
 	}
 
 	for (i = 0; i < core->iris_platform_data->tz_cp_config_data_size; i++) {
@@ -180,17 +208,28 @@ int iris_fw_load(struct iris_core *core)
 						     cp_config->cp_nonpixel_size);
 		if (ret) {
 			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
-			qcom_pas_shutdown(IRIS_PAS_ID);
-			return ret;
+			goto err_pas_shutdown;
 		}
 	}
 
 	return 0;
+
+err_pas_shutdown:
+	qcom_pas_shutdown(IRIS_PAS_ID);
+err_unmap:
+	iris_fw_iommu_unmap(core);
+
+	return ret;
 }
 
 int iris_fw_unload(struct iris_core *core)
 {
-	return qcom_pas_shutdown(IRIS_PAS_ID);
+	int ret;
+
+	ret = qcom_pas_shutdown(IRIS_PAS_ID);
+	iris_fw_iommu_unmap(core);
+
+	return ret;
 }
 
 int iris_set_hw_state(struct iris_core *core, bool resume)
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 4bdb078d83b5..106dbd44ec02 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -193,8 +193,18 @@ static int iris_init_cb_devs(struct iris_core *core)
 
 	core->p_dev = dev;
 
+	dev = iris_create_cb_dev(core, "video-firmware");
+	if (IS_ERR(dev))
+		goto unreg_p_dev;
+
+	core->fw_dev = dev;
+
 	return 0;
 
+unreg_p_dev:
+	if (core->p_dev)
+		platform_device_unregister(to_platform_device(core->p_dev));
+	core->p_dev = NULL;
 unreg_np_dev:
 	if (core->np_dev)
 		platform_device_unregister(to_platform_device(core->np_dev));
@@ -205,6 +215,8 @@ static int iris_init_cb_devs(struct iris_core *core)
 
 static void iris_deinit_cb_devs(struct iris_core *core)
 {
+	if (core->fw_dev)
+		platform_device_unregister(to_platform_device(core->fw_dev));
 	if (core->p_dev)
 		platform_device_unregister(to_platform_device(core->p_dev));
 	if (core->np_dev)

-- 
2.34.1

