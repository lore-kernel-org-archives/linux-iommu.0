Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116DA480328
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844254; cv=none; b=h0RCySowpVsDNPEQTru/Z9vjKu2NlGWw3v6/aGCP52rzpsIZVxNGn0F/OREg9PxltRzD0P5roov06A5zpkJBJwRGdnfRwfabdm5A4mpdnEYz/FhxBvbUh+2ElKYZ4B37iauTv4ssouw3ePEPkvilR6wEqj6K9ShibruoGiD2B+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844254; c=relaxed/simple;
	bh=onJeJiw9EMeTDpFkD/CSfgq5ekY6oL32ti+K4AKPSPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UchXEn05uBzCxmzG806Xm2HYZRE5Ma0AgqDHORdAmNnPJo8MRXAHhxFHVpqzBZ1EXkWo+y2V7/cpdcrKixEMmMdXRa40LNfU0asspDC2Y/nMj1sGWUFtvj/RNm81+arM9k/ANE3q/j3MqMDup7Shl/cQWEu4Pd0T2CEZjvAUK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VpybtXJK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z90BHo2W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VpybtXJK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z90BHo2W"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAsBgf3671196
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kqDWRt1uVdCbnOpqf0M1wXSvFfZm943941fN6LZQjNI=; b=VpybtXJKXRzZNwba
	8WbuhX2Zkcyaafql9qS1X3k5OE/Od7UaPjK7oTgpT6XiYFbyceoWLueLj5NdxkeS
	thxq9h3XGvhKEZqJn3aduRpz+5wHf1orYy2j5WIXYmE3uBQod/5QlRgndk6qHstF
	Mr47kxvWj3mdyHsSGwYjyfW8cgvluSe/q8fRiIp0KEkNsra5JtWUFS+YxlXPtFp/
	uL8CJ0koAlbNoiA9miVsWhyHez4HbXPh6ZilUb286ZpgOBKiWYz8m072x4vW1VpH
	TEqIyo45LtmTAfV0lqOlTDtrg8P3xMJyhiqnGfVenDcaVlJb6RU1Vw2+UivkYhOB
	HOrnjQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s334u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:24:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-366ded5ab5fso13409951a91.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778844251; x=1779449051; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqDWRt1uVdCbnOpqf0M1wXSvFfZm943941fN6LZQjNI=;
        b=Z90BHo2WxhxeESBo7leRe/3lKWBd7QyjsY4KnllqMBYY00KVdIkHqV69qQZtu3yvxi
         2Wyus6Vd/A4HNPxbrMEWEUOpE/k21kezMGPF3YOT2Zq1E4a3Q6b1sy1xG4mibgZDSRZh
         b615SJQbDvh/0+iqARNRJPyILSl4Y4fLqfUeFEMVi56IMHZ0Q77kOberp0nq42snTYYt
         nN9GzO9nxWYY9YjyneZJ0tGebh65aqYt8mB6G8NNfqX6LOu/HVIHe1gd2lDj43e8kNt6
         WSbq8EBobGrN34BhsvCsziKg5tSCWRttwL9Z3l4PJG66Y3J7vN41vSLqjam58iWtDojs
         nMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844251; x=1779449051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kqDWRt1uVdCbnOpqf0M1wXSvFfZm943941fN6LZQjNI=;
        b=NHMxKJ6U1zEBfYEWdlMFgx+rsaL2LTbvDxsXIx5mzRtVO45WRk3xs0QsOD359Nd1wF
         c6gCdbKIQeg8E6+K9QMh1Vrll838PvBN9MLXJF6OVptprDBaT3wTZRjaleLlS0Ritm3d
         Tk18+VQs1WpC+ncxcdS1/MJl/jzOKac57ehJ2f74T46OF28LxFFmOOdcDN2qKMUrRiBs
         /FUuRfpheEBkka243uyAJNQkUOyJ2LYjyoi2fx5DtmUV/sBge079yqrF0QsyUOn0JpMV
         MVRJA0rRn23FSO+Boc4Ww8UE3m3Eb553GiqrtBaCCrNA50BbVge+AjA7H8L7C0ZhkSH6
         qj8g==
X-Forwarded-Encrypted: i=1; AFNElJ9XF58UXSiEHenzCi2PHvT9gBBWy1G6qoz+GvqNiMzsOkfGD2urbcvKJSbj4x/74iY1te6e5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgHOsRNlYv/WmUn3Xcv1AEGuEeo0FGhQ345VGJNRmbi03ghy54
	WL6oPl9evhl86lwTxtggplKxWR6YqHtE+iieXi6yUJ9Y4C3v6pkzCadWrlnWl3oojcyeZmvrVDj
	bx9tkWR9+uS4d1ceRlZm6TnRrASoL7tr362PGQza640U/4fSOpqaZ11LFYA==
X-Gm-Gg: Acq92OFpzYIyaDjJuXh5iMhCT90ZQH4QuEQNi2c7+5FogeN5HJi/9laJSQUUWVWSlzZ
	tWYQSrRcc9QSbVZOfO0/lNZ3T91hIZ8t6w/R0/+Li2guFZWG/Bhxj91GrovrGJ9qFsSF0+KvYEz
	0FekAA5hh/nlrU79kI9Mwt/p5w4cnPZn6aWo9ivFiIQhpa5FcOnEkkUBX++0Ue5uS8ChLAKt2o6
	JJMQIrg7L1255Wf0fqEcsDFCZIFdasBoot4w6Ngu/mj4ZfD6WyW69Cid6tmOaYnD/bwqv2PDpGM
	mmbOpBJxnsZcNZ4VH9jDjLLez9L9lZQkRSXgoc9KlzqLkasrylpjwCAMACGsrVIOrKoWhUt0zxG
	1+7SmCGE1IkxnmDx2mw3j4/18CjRX1orYWj0jgFIBKOTbrrwDnn1T/T0=
X-Received: by 2002:a17:90b:5203:b0:369:1dff:6bd5 with SMTP id 98e67ed59e1d1-36951b7840amr3169832a91.17.1778844251400;
        Fri, 15 May 2026 04:24:11 -0700 (PDT)
X-Received: by 2002:a17:90b:5203:b0:369:1dff:6bd5 with SMTP id 98e67ed59e1d1-36951b7840amr3169793a91.17.1778844250844;
        Fri, 15 May 2026 04:24:10 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2476249a91.7.2026.05.15.04.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:24:10 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:51:22 +0530
Subject: [PATCH v6 07/14] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-glymur-v6-7-f6a99cb43a24@oss.qualcomm.com>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
In-Reply-To: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778844197; l=7327;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=37/hiTXVX9eQYBQu3HR7YyKJBAxiMFbmP14R68LJz1k=;
 b=q2XsJHyGRXSvCFhZ9XflyOp+xKQepeFWo5kYnqWncMEmKnQ9NbTfv1uP2lLTp6gG8XKFZTxf1
 hYis/YIYViHCru8bXKmV5UDifTIS+HbBgHtglbIlfNn/Tcn4zV6cfbh
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfX3alSnN+eeHUm
 Or9mn7Mqr1d9v9+fcDv1yLpguQocYoa8BYkYz7lmhLYysTGaSHmN4tDXXwmsi4nE/Fw65/zWtHg
 HdXK7zT0z7pqXPK+hayvaT1pRxfGF17BY5NN3rSshRycXsDbrmtwOeH3nVGeQIo1EzJd60y9xHU
 Sy4JkasqPkG42iXLJqkpLIKBNB4ETwMdp+e2aNIXSTyoSTMOO5/rarRjZbj9p8RLwnHR1oxrI0t
 Ir5XId1FSFbg5Vr1C+DzFT6v5eHvBWclqz9AjZoqFVwpwl4gm8/LjxNJUFes6P5hf+sH7qrCyRt
 Tl2ql2wDhBJkH5/1sFpPRVafwGAyAibgEQ+1cVSV1mOR/iyzNQNvmnwOyakLfF3KWEJQPX0VOpr
 Idcla8I2C4w0/oq0+fcZOHQMD8l7HKN9H5H2ojadHGGVn0fg5rGk9jX9iJuO9MzwWxX0Suo6zHq
 GX709yiIrFiYX34LjDw==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a07025c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=U8OLdchxA3Z7P0hrdlYA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: AEI1M5gFTWpoJPgj_hBxkbPXGCZ0fBpc
X-Proofpoint-ORIG-GUID: AEI1M5gFTWpoJPgj_hBxkbPXGCZ0fBpc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150115

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
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
 drivers/media/platform/qcom/iris/iris_firmware.c | 73 ++++++++++++++++++++----
 2 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 24da60448cf2..2edba569fa25 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -36,6 +36,8 @@ struct qcom_ubwc_cfg_data;
  * struct iris_core - holds core parameters valid for all instances
  *
  * @dev: reference to device structure
+ * @fw_dev: reference to the context bank device used for firmware load
+ * @pas_ctx: SCM PAS context for authenticated firmware load and shutdown
  * @reg_base: IO memory base address
  * @irq: iris irq
  * @v4l2_dev: a holder for v4l2 device structure
@@ -81,6 +83,8 @@ struct qcom_ubwc_cfg_data;
 
 struct iris_core {
 	struct device				*dev;
+	struct device				*fw_dev;
+	struct qcom_scm_pas_context		*pas_ctx;
 	void __iomem				*reg_base;
 	int					irq;
 	struct v4l2_device			v4l2_dev;
diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index 1a476146d758..8bdc9273036c 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -5,6 +5,7 @@
 
 #include <linux/firmware.h>
 #include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/iommu.h>
 #include <linux/of_address.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -15,11 +16,14 @@
 #define IRIS_PAS_ID				9
 
 #define MAX_FIRMWARE_NAME_SIZE	128
+#define IRIS_FW_START_ADDR	0
 
 static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 {
+	struct device *fw_dev = core->fw_dev ? core->fw_dev : core->dev;
 	const struct firmware *firmware = NULL;
-	struct device *dev = core->dev;
+	struct qcom_scm_pas_context *pas_ctx;
+	struct iommu_domain *domain;
 	struct resource res;
 	phys_addr_t mem_phys;
 	size_t res_size;
@@ -30,14 +34,18 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 	if (strlen(fw_name) >= MAX_FIRMWARE_NAME_SIZE - 4)
 		return -EINVAL;
 
-	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
+	ret = of_reserved_mem_region_to_resource(core->dev->of_node, 0, &res);
 	if (ret)
 		return ret;
 
 	mem_phys = res.start;
 	res_size = resource_size(&res);
 
-	ret = request_firmware(&firmware, fw_name, dev);
+	pas_ctx = devm_qcom_scm_pas_context_alloc(fw_dev, IRIS_PAS_ID, mem_phys, res_size);
+	if (IS_ERR(pas_ctx))
+		return PTR_ERR(pas_ctx);
+
+	ret = request_firmware(&firmware, fw_name, fw_dev);
 	if (ret)
 		return ret;
 
@@ -53,9 +61,27 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 		goto err_release_fw;
 	}
 
-	ret = qcom_mdt_load(dev, firmware, fw_name,
-			    IRIS_PAS_ID, mem_virt, mem_phys, res_size, NULL);
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
+
+	core->pas_ctx = pas_ctx;
 
+err_mem_unmap:
 	memunmap(mem_virt);
 err_release_fw:
 	release_firmware(firmware);
@@ -63,6 +89,18 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
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
@@ -77,13 +115,13 @@ int iris_fw_load(struct iris_core *core)
 	ret = iris_load_fw_to_memory(core, fwpath);
 	if (ret) {
 		dev_err(core->dev, "firmware download failed\n");
-		return -ENOMEM;
+		return ret;
 	}
 
-	ret = qcom_scm_pas_auth_and_reset(IRIS_PAS_ID);
+	ret = qcom_scm_pas_prepare_and_auth_reset(core->pas_ctx);
 	if (ret)  {
 		dev_err(core->dev, "auth and reset failed: %d\n", ret);
-		return ret;
+		goto err_unmap;
 	}
 
 	for (i = 0; i < core->iris_platform_data->tz_cp_config_data_size; i++) {
@@ -95,16 +133,31 @@ int iris_fw_load(struct iris_core *core)
 		if (ret) {
 			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
 			qcom_scm_pas_shutdown(IRIS_PAS_ID);
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
-	return qcom_scm_pas_shutdown(IRIS_PAS_ID);
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

