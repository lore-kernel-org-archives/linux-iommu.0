Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CBF48034D
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496453; cv=none; b=IysPzt3/6QYED4lSrZFy9y9Diip5uAjMgWVSTrBe1vY88ohw1iD3NaXYCJaanCS5Sn7IIaHXEgv5lhRL3tNccmT3rxjlMNxcLvXgWywHOGuPrEVKf79DNcBNUbHytZewgSgzfAeWN/A/qyNPyG9rUwhK+Sg0Yp74eF+TkvH8hCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496453; c=relaxed/simple;
	bh=onJeJiw9EMeTDpFkD/CSfgq5ekY6oL32ti+K4AKPSPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OPZ7lg471XrPocUtaTBzPKfwUGpH6b9NXxp1jxDqTxXkhndM7Qu/V8eJ8Nv0XFsr5917tgCYWDHhLqwWftM+hg3h2FwWBJ24bRozBDCIeUpm1DhBY6UWN28IbhWt9uvzKKhmFvDocMNDxeHI3Rl1mNaTypvTkv82ADdwmy9Fepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YtSpB8ba; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WRdKckgG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YtSpB8ba";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WRdKckgG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653CJRbJ1740472
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 14:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kqDWRt1uVdCbnOpqf0M1wXSvFfZm943941fN6LZQjNI=; b=YtSpB8bajl0hhI87
	bRdNBnmUDZtwuAOtJY0BXhqaSHuy8hYLSO720yYTj9GGsF9KUlxJ/ywRhOiO9koY
	m/f5ie1uzLl1CpWaIHFnFJEvhO3k/S3yDDcFg7XhyyMCIaEObkErSEscejJ+SbE4
	iaMgg+5JBE2fcyN/qhcNoPZgX3GgjzTRlb/ivezZtZ87pvMjHhMW4n05HQc1uQjE
	hO24OILLxyKyRPghOVtV1YaZ8OaOPCFNTr8PnziNtHlAX3iUUl5gktkeIuHgw1Wm
	sHfztvj3YXxtSv5/pnKhAjF/L/LjS/dxQDrnIsNKiSzhFugTZLLVCDSTJ0taET3l
	LSQD8w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejdq7t7qm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 14:20:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf32fb7cb2so36108425ad.2
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780496450; x=1781101250; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqDWRt1uVdCbnOpqf0M1wXSvFfZm943941fN6LZQjNI=;
        b=WRdKckgGRlAUCubMIeARwTOH/6qM66jlxf+oUuCNeGDux2Qo++drZYStoOqoT44WwD
         pe+84elotYB4MDMzKca5ozFdkY1HAILXWNuvmD7RQAjID3VBjq0lLCB8De81vTOSJhhF
         aeTIUYUmoaJUU3YjxxNS5WqSNRfIx0PLTZXQypWwv/CXC9L/RahKAM/d3hRTzQObBaWh
         mP/qM5RWYWP4rsOTA5h8H2Ey+EEFTyqOWgQbcXn4c2JKlHxbbthKu6fJLR9uZHePZAlp
         MXcIh6KMtwX+GY7Kxcj0St68qruFs+cQ/nHZZGTUQ8Ik2VAvHzux6XSS/8f+yKGBT8C1
         VZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496450; x=1781101250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kqDWRt1uVdCbnOpqf0M1wXSvFfZm943941fN6LZQjNI=;
        b=A0aWsePGMFmoFUqj/9hGjs1J0cX3AebXR7twP7xe0SLpeMkC2UH48XvTUr1Nqy+NJ9
         f9zl7GgjO+j6AJKXg5J+NRIfy/pY9aoV7pSgyPBXoo8ZXQguEbEi4Y0OegrJ9epfWEZR
         naJIBA1MWQLcDb2qdwgDnKZ+VDT3UBbXIQUpFCHrZ84S0lHFscNZ2MzL3HgvD2O+zSjH
         V/LEgaFf/4UAcQm7kxRhqYUNye0NYe788mglJXM9Yi5IW8SWreph0fD5mR5xPr9LKZbq
         IAPvn1gKnizKthZjuyQH67FplCcOFgF8+m5QwFcBc3dj49RQFHyJZSVr/1KLRSB00+C6
         9Wfg==
X-Forwarded-Encrypted: i=1; AFNElJ84pFCtuCpUGmrTEugmQ29iTJTgdHhGd+XwSVfTOPZ54/EeRDYoLFBKU4IMTjC013Rw/ZqzNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKqHNiMz8+aq80mCf0xv0FxmZ/GBfTQVM5cBwZihW36jLt57/u
	3fpDLNCGvnNIQwJfk49TVZpMyYeJRyEusHw1kCl/Mi2VliC/jOxJmFtXov2SwOOso4KXThWR1Er
	inK+r5tExZKWFBd4kJ3qu/1GNn7gDTk7M6qREJugf6WXNtAaHkQ8delf5Rg==
X-Gm-Gg: Acq92OH2vauabariZ642ngsz+uXeFkfXaR/GpvRn8pUSp+Vy7tFht2GU9C2kaSVYPvs
	QAAQWxMRIlCNvMQPE52GwZUMMA3ip6tRPWmoOX57EVNSMPhm6cjv28QhrZ0OVzNlMoZBDCeLvq3
	J3ahEzHXrRvaG7psE591yg57VZ+ZCNl7qK9YheeJ9NbpLiV+rJXrY5z6csJ3Qa1Bqf3JwOvRbt/
	KW1IhLVsGacpGLDFSxZkM44l8f/jlsz6GTUTSp30vFQ0+5xdsry91iwyUcXavzoHwJzcMyewCfC
	E3JaXfwPqQsCg0E+KlE39JBnrhyEa9Z7HuwL1iGAZbnJ96cRRk53ODHeKOn/UGYBdzVxIKDsedw
	7PFwvKMcJWqCupkINvKMvGLFBxoGltWPwKF9MchF7auNfhbQtjmb40R1asUCAHD0sWw==
X-Received: by 2002:a17:902:d4c7:b0:2bd:606d:b339 with SMTP id d9443c01a7336-2c1644a9b5fmr36384365ad.21.1780496449361;
        Wed, 03 Jun 2026 07:20:49 -0700 (PDT)
X-Received: by 2002:a17:902:d4c7:b0:2bd:606d:b339 with SMTP id d9443c01a7336-2c1644a9b5fmr36383635ad.21.1780496448538;
        Wed, 03 Jun 2026 07:20:48 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm41514955ad.9.2026.06.03.07.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:20:48 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 19:48:43 +0530
Subject: [PATCH v7 05/12] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-glymur-v7-5-afaa55d11fe0@oss.qualcomm.com>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
In-Reply-To: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780496410; l=7327;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=37/hiTXVX9eQYBQu3HR7YyKJBAxiMFbmP14R68LJz1k=;
 b=nwqxUJRgDkdXvei9R24670xtfdO69q5JjuNJD6NKNJ0AU9FU3NtUDWQPEIZ5c4EcWNQagD67c
 262Zd5eNV6PCtIvLZYzfR1iYDWeVsWwtsNogkXxplhsuVk4bF1u8W7+
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzNyBTYWx0ZWRfXzZFJj2gVC2LC
 Tml2Jx6cM8pFuHC0B1gXvzshjxVgbk/EjFDo9GEJa23lizfmFl8CyuiSe2ERsJGDYiGJaJGvDZJ
 3gfNg2PpBGZLSVMzfQaeS4kA0YiF2NaGjifmqR+ojQwLMC4FdCkZFIOJmmuq+qNmphAFmagS7qn
 FKS/4jvGarS1OKYLDUpkrwF+Q3tYCl7Pbm76thhfxBV4wEiascwRgAr3cB5+8fH6reqtJ7eXjfy
 6YjoT2eBEl+YbFMdi8K07jFq/LVKtsJ+wmdRimawCCSDLMxe7aDYX8G/ma4jh5eglxqUYiGCe7h
 5fnJ5/xwypBBA0eY98LXeiAynyBv8kSHke3ZeZEDlsyZdfxiVupx5H/TXSlg3xRE3VItJaabxV8
 1I2wNKgBXiemwIPT15WMdBoABneD4iAu4An4UFirW5VFI0iZs1o1JpsUDJjzYGFoDkbOouMPHeP
 ocI7ANCRaVmi1UsDAyQ==
X-Proofpoint-ORIG-GUID: m-io1Jda9NZHHzsydMzQeSdlXraNa9f9
X-Proofpoint-GUID: m-io1Jda9NZHHzsydMzQeSdlXraNa9f9
X-Authority-Analysis: v=2.4 cv=ccniaHDM c=1 sm=1 tr=0 ts=6a203842 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=U8OLdchxA3Z7P0hrdlYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030137

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

