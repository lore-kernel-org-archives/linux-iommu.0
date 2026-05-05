Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF3F3D9DB2
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964480; cv=none; b=g/Jhv6r4X5LT6zOd3jysF9dnpM2hize5lcyT2JUWLhtyiUaF2te0euTnocYS/ZOGK1haVMeKsOFjBbedGp+/GGEXkTltEA7FQugqZiXNLwTlqGNghScCNqeIc3LH7KvSBWj9hKc79am5q436jcwc1mkQFztDPVV7/3Ppuu8cD04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964480; c=relaxed/simple;
	bh=5XMD1PTwD/LTxgA60yhE1YYtYnYGkszZwhjmWff2fnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXk+KF6lyaWKsK2q+Gx0xK9+8QWE8Jlb+vR++barQstJAFCMJPniamDJiqsPWb2DV/QE8pTuVd9TXo6+BYc5pU9AEsBF34az9UOiABJ9HoZKSwZeE1rcgqH+D06xFcpmjC0IldPB//2DIMOj/wL+wwGi7CS0H3vrOGUTAoxG/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J3FHkjV5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZXRB47hS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J3FHkjV5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZXRB47hS"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456lqVF3187751
	for <iommu@lists.linux.dev>; Tue, 5 May 2026 07:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bTy4Bkwh+gr6ISqDQC1YSZGoQJgQwg2cLAvk32oAfkI=; b=J3FHkjV5BQraMdqC
	kAD9aZxpOLLVPgmuABNr/GrGm41LSrvBL9i6omnAjZTK7Pjg109VdyzAAFuiN06/
	7cSzvRTXofMHnE++Q8pNv5QfojH6erN/3BXTOQIXVfpMQQsOHjjijVZaoVe+7S8O
	a+rWx2pnAP4x0KbiK0uTkmHD0BjDB/GzzHUAcVw64nLSOI7MtqatHDVmXisIVMvV
	ShIWpoAyIktLu56dw97yeGVAsdwPJoI5+r2LgQ3Ix1dkDJNjyCvqqxD47urXwHcx
	muqO6B5gDg5zaWHSlDrxLaYJlNAITu+iHknkrxCFmq8PMns/3CqcsgN9HXS0Daeg
	qLFREA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkk81cm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 05 May 2026 07:01:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24e9b4d82so52243265ad.1
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 00:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777964476; x=1778569276; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTy4Bkwh+gr6ISqDQC1YSZGoQJgQwg2cLAvk32oAfkI=;
        b=ZXRB47hSPNE1ngoEorLxgKqNWtD1XzqS0Z4pvRKksO6pMqlRbuNU7shyxnp0LZUOKh
         funXKlw49TkufiEVlzOPaqr1J0i9GxzX8rwCY0BWOMilA2TkktFloXhJJbPAt6ge4htX
         oWBm9pjke/gjTOKF4K670hXxHCGMhXdCvKmR3ns+QkWbYCAVD9lEhhcTrMRp3upApjsr
         jRWUtSZwPZXrd1Fy4YGenrGgpaIhERO9iQ0QUBbk/t850A3gvAjvSjRadmiuaLM4UDKZ
         cxS9mTcpofcwR6MPgtqg8xy/MroNSH1z0GaygSdU6nhlmOVYHZeCkpsxEAnFa0p8K8e2
         GFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964476; x=1778569276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bTy4Bkwh+gr6ISqDQC1YSZGoQJgQwg2cLAvk32oAfkI=;
        b=KPIPdS1Ha9FgXXaJzfzFo5vVa70caIpDCdHApR3yRa/pS8XMNinGeRDNc6a8XXvvI3
         ZKCEglNLyp/F2nqYdDepfajlkOlbxuGOTZcl2S8MfPdDJJZsxaRKNcz7z3MC2/fK5XSV
         vZxurA04C0ZK2ghZisvYg2POgPshKPfmJSET921WIRqFTO5pF03dXPGwqIu78BkgDnKP
         6BwshqD6U/Kka7o+3lW7+Wb869kc2LoMoYuG5WvYXLf7y2731VQACbDw9WOKBs4k3igL
         JnNxrre53zwPxt4gIQFkMI1/fFdmGqTFwRNhtCKsbfvlNkSpES0OKCwUYQbCDGGDu76/
         VCig==
X-Forwarded-Encrypted: i=1; AFNElJ8yvPHbqc545pRrddCDiBWuDoaMlfRAkNM/Di3B7XXhxsk3utuOo03YnoTnqPQtZOyIvJ0akw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfybmTYDDnw2Ci7Jkkin9xoQg+Frm2QhncDjFOXiLs7ghaXsGG
	uQsKmMKCOGw6dZlWnq+F+zWukbtN7T6H3bcSrg/Iu/vpM3Ozkg8FnKvhpYNmQA/5NSpCV4XpOGq
	BTThlIclgTmymHtPKzI/sN/uKW4QIaL/Cc455iZT2SZ+toTKtTg8v7QxQUQ==
X-Gm-Gg: AeBDieuiFGrtXiRJg5NeUflTH4znvQgIfsIAN1IyBe7NZN9FiLZ5UsglfniJmBhNQB7
	od15/mqncYcFlXlWTCTSnM6WZLvq8WaUNMFwDXSjqd+Kd86VGu7e1CoMK1U7tOeQYAhbwIWAatD
	Lcdf9XfqNu+YUhO29+NpDzXpqTe2N3TxJyuTwSbJ/LLe4OUxxkUQVKOzVlHIVyLCV8XFIHRMaBP
	sPFlEAAzIkDv335+tHKv0uUaopNbQP6sBb1uEfvOObCAEmxtNp6k0C65dnzU3HYA7C3HiMTRwQy
	IRppLpfAR8lx+mzIBoEyMFQtZ5UIvaToti16rVa6N9tQ8H4w7qIfK1XlghhoxE4xrstOdzorQCq
	IbfbMwX5c37QaJQX1PBp8ISbBhJEHefG/EJQecfq25r2SvEFgIn/CO/ABaY6wxZBbMA==
X-Received: by 2002:a17:90b:17cf:b0:35f:bc9f:e1b6 with SMTP id 98e67ed59e1d1-36572255b88mr1898180a91.1.1777964476445;
        Tue, 05 May 2026 00:01:16 -0700 (PDT)
X-Received: by 2002:a17:90b:17cf:b0:35f:bc9f:e1b6 with SMTP id 98e67ed59e1d1-36572255b88mr1898074a91.1.1777964475032;
        Tue, 05 May 2026 00:01:15 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm13840146a91.2.2026.05.05.00.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:01:14 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 05 May 2026 12:29:28 +0530
Subject: [PATCH v4 07/13] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-glymur-v4-7-17571dbd1caa@oss.qualcomm.com>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777964421; l=6587;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=+wQbHvxygQq1aTrGxrx3UsURZ3ABehuwxnmcohM5NBw=;
 b=WK87IIKqHhNQTBnHiTr/VGjkaSzt7Spi/HEsDwkgLA5pdII9e20G79MnQQxJYv0n1Ou7txiJM
 ElYBBpq6C4pDYoegAU9CGNSsNEA7Swj1oGFnz3FadtXfP0EsDusw/Au
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2MyBTYWx0ZWRfXxJjl+PBZ7Bre
 ws2mZ/e+SrE3Jc6nKJd+6XTkSgYBFY/hXFaFjROyul6E+DfovuFbq33/PAbwnAyt7kvUFeASDvf
 obM5t01ZFRd1tZU9+P3l+3K6MKR0ZrdtK/uiYOUF/VeZdHpOegjIFiTVIGdWgXGsunNnniERb+9
 hgZghYXv/Mfj6m2sjlk1Lpl3ziCKtVw8MAO1AA03JvddOfoI4CailYfaMjqkBpluUeSg/dVDCcW
 e9CSkpGmA311t+Cjq0wCC3wp0YofsQ7zMVRNjYZQNcKtOFQdkeGCj6kw/e7ulXQGCjICJgs8mAR
 ZuWTLvgClKXeIy+1zhY2AFOdxGdw2K1jg3VGgMvnnb02+PIlBtpBIydp0sn4AOUe41NU7+Xfl9Y
 C59LRS12NHwRt+LWcOvU/prTuZ5TpUW2BQsypA1vvlnQHhOOk/TU6B8V6cmnrzC4TXbY2WAq1sk
 DJIa1EyQst3uMot2BHg==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69f995bd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=gbwaY6mYjfx-u0ET_fsA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: gl2JRq61oEdAWc-NZ91KfEmzyxrB2799
X-Proofpoint-ORIG-GUID: gl2JRq61oEdAWc-NZ91KfEmzyxrB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050063

From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
or QHEE), which typically handles IOMMU configuration. This includes
mapping memory regions and device memory resources for remote processors
by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
later removed during teardown. Additionally, SHM bridge setup is required
to enable memory protection for both remoteproc metadata and its memory
regions.

When the hypervisor is absent, the operating system must perform these
configurations instead.

Support for handling IOMMU and SHM setup in the absence of a hypervisor
is now in place. Extend the Iris driver to enable this functionality on
platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).

Additionally, the Iris driver must map the firmware and its required
resources to the firmware SID, which is now specified via iommu-map in
the device tree.

Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
 drivers/media/platform/qcom/iris/iris_firmware.c | 72 ++++++++++++++++++++----
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index fb194c967ad4..b396c8cf595e 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -34,6 +34,8 @@ enum domain_type {
  * struct iris_core - holds core parameters valid for all instances
  *
  * @dev: reference to device structure
+ * @fw_dev: reference to the context bank device used for firmware load
+ * @pas_ctx: SCM PAS context for authenticated firmware load and shutdown
  * @reg_base: IO memory base address
  * @irq: iris irq
  * @v4l2_dev: a holder for v4l2 device structure
@@ -77,6 +79,8 @@ enum domain_type {
 
 struct iris_core {
 	struct device				*dev;
+	struct device				*fw_dev;
+	struct qcom_scm_pas_context		*pas_ctx;
 	void __iomem				*reg_base;
 	int					irq;
 	struct v4l2_device			v4l2_dev;
diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index 5f408024e967..0085dd7ec052 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -5,6 +5,7 @@
 
 #include <linux/firmware.h>
 #include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/iommu.h>
 #include <linux/of_address.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -13,12 +14,15 @@
 #include "iris_firmware.h"
 
 #define MAX_FIRMWARE_NAME_SIZE	128
+#define IRIS_FW_START_ADDR	0
 
 static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 {
+	struct device *fw_dev = core->fw_dev ? core->fw_dev : core->dev;
 	u32 pas_id = core->iris_platform_data->pas_id;
 	const struct firmware *firmware = NULL;
-	struct device *dev = core->dev;
+	struct qcom_scm_pas_context *pas_ctx;
+	struct iommu_domain *domain;
 	struct resource res;
 	phys_addr_t mem_phys;
 	size_t res_size;
@@ -29,14 +33,18 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 	if (strlen(fw_name) >= MAX_FIRMWARE_NAME_SIZE - 4)
 		return -EINVAL;
 
-	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
+	ret = of_reserved_mem_region_to_resource(core->dev->of_node, 0, &res);
 	if (ret)
 		return ret;
 
 	mem_phys = res.start;
 	res_size = resource_size(&res);
 
-	ret = request_firmware(&firmware, fw_name, dev);
+	pas_ctx = devm_qcom_scm_pas_context_alloc(fw_dev, pas_id, mem_phys, res_size);
+	if (IS_ERR(pas_ctx))
+		return PTR_ERR(pas_ctx);
+
+	ret = request_firmware(&firmware, fw_name, fw_dev);
 	if (ret)
 		return ret;
 
@@ -52,9 +60,27 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 		goto err_release_fw;
 	}
 
-	ret = qcom_mdt_load(dev, firmware, fw_name,
-			    pas_id, mem_virt, mem_phys, res_size, NULL);
+	pas_ctx->use_tzmem = !!core->fw_dev;
+	ret = qcom_mdt_pas_load(pas_ctx, firmware, fw_name, mem_virt, NULL);
+	if (ret)
+		goto err_mem_unmap;
+
+	if (pas_ctx->use_tzmem) {
+		domain = iommu_get_domain_for_dev(fw_dev);
+		if (!domain) {
+			ret = -ENODEV;
+			goto err_mem_unmap;
+		}
+
+		ret = iommu_map(domain, IRIS_FW_START_ADDR, mem_phys, res_size,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV, GFP_KERNEL);
+		if (ret)
+			goto err_mem_unmap;
+	}
 
+	core->pas_ctx = pas_ctx;
+
+err_mem_unmap:
 	memunmap(mem_virt);
 err_release_fw:
 	release_firmware(firmware);
@@ -62,6 +88,18 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 	return ret;
 }
 
+static void iris_fw_iommu_unmap(struct iris_core *core)
+{
+	struct iommu_domain *domain;
+
+	if (!core->pas_ctx->use_tzmem)
+		return;
+
+	domain = iommu_get_domain_for_dev(core->fw_dev);
+	if (domain)
+		iommu_unmap(domain, IRIS_FW_START_ADDR, core->pas_ctx->mem_size);
+}
+
 int iris_fw_load(struct iris_core *core)
 {
 	const struct tz_cp_config *cp_config;
@@ -79,10 +117,10 @@ int iris_fw_load(struct iris_core *core)
 		return -ENOMEM;
 	}
 
-	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
+	ret = qcom_scm_pas_prepare_and_auth_reset(core->pas_ctx);
 	if (ret)  {
 		dev_err(core->dev, "auth and reset failed: %d\n", ret);
-		return ret;
+		goto err_unmap;
 	}
 
 	for (i = 0; i < core->iris_platform_data->tz_cp_config_data_size; i++) {
@@ -93,17 +131,31 @@ int iris_fw_load(struct iris_core *core)
 						     cp_config->cp_nonpixel_size);
 		if (ret) {
 			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
-			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
-			return ret;
+			goto err_pas_shutdown;
 		}
 	}
 
+	return 0;
+
+err_pas_shutdown:
+	qcom_scm_pas_shutdown(core->pas_ctx->pas_id);
+err_unmap:
+	iris_fw_iommu_unmap(core);
+
 	return ret;
 }
 
 int iris_fw_unload(struct iris_core *core)
 {
-	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
+	int ret;
+
+	ret = qcom_scm_pas_shutdown(core->pas_ctx->pas_id);
+	if (ret)
+		return ret;
+
+	iris_fw_iommu_unmap(core);
+
+	return ret;
 }
 
 int iris_set_hw_state(struct iris_core *core, bool resume)

-- 
2.34.1

