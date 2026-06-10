Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0FA379988
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073049; cv=none; b=VcQCGDiq7q+syEGZtl2xYy8ilcsa5JzsthEpMxGSLJ3RF4K1mhspWb9b5Mp+H9w9FDM3ESJBPJFdRnKePPahND7AzFSck2ekTqXrpw8UggpCH+njjMHl3Aborka2E20bsDSviLrmuLNuys+u4AlQTswcRt3dpC1mo//5284rjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073049; c=relaxed/simple;
	bh=s9wTJg7+ivqEyqOea5nfQPWB3ECRffaa/U/6xK1IonQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTAMzZ54fo3CUaxiGP+ZLKCm7HPCFqMYfiyKikKKxzqQzjXT/AYNacYtDYabaeOgFCMgHh3zuDC+Us68kgaccUzyopi1+thqbx5KKGmOjbxf4zcq+C/O8Inj6sPlbspcYy8uDnXa4T/lSTCwEEMZTkgImdjoWR6OZ34J68Ja4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T4mIcnMj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L84bUnmK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T4mIcnMj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L84bUnmK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A5SmTY688976
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KcjYoxNYJZSF7oYA+rD6cGH2cTKuwIPF7kWTMRGHtCA=; b=T4mIcnMj/34gviTl
	dTDAWLi6fEbNh6+A7ZYs5s8NPKDcVZzH3jma5PoKR/EXeY+WyzrRz4TXsdLR+aGY
	Tccmo5Ine1GZvtM31nNmKomMkrOpSN8RmR3za1cc/B6Khc/Vytz7ElOhGQIKkNVZ
	X2jDAuY32JgrYhDWAOG+spmbRli2+9xx/0dGZGdh8fKP2T7X13uSIVAOUTo/dXon
	MR1CBPPk7Vz/4C/wHaTOCKAtlxU1C/moivKHeEkOiaDi3jgYVcTwmRuvVPgjzZmf
	NT/eki6WGKAc8hpl4LhoyPCSSnY6v8v8B+uhys83p1Y19IjzioS9OoKfC4DUjaij
	aFFtfw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq1tg071y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso5992360a91.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 23:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781073042; x=1781677842; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcjYoxNYJZSF7oYA+rD6cGH2cTKuwIPF7kWTMRGHtCA=;
        b=L84bUnmK3FaYQDRyxVkYjQMvb/aZd6sZtgqU50k2SSDmo1kaeAoBEejyLuPCcjI696
         3tGA6Ij72vaZaTMjkddierDr9qj3dea1/1Y7alZm9VZBRNOx8wDgCqf1Va9bPtP4Q+vr
         b350O39c/Cr9hrQ1L/n2AJ9aeYJ+rDF5+nPoWUzDOC63bIQ/MHyPBH0Hkc+7NwAnPHxp
         Q2S2N5S+5f+a0SOqQHxBePqOaXChRgtfm7YnNvPuZtSs7AJcaI64yOJUbPVvTdjS/QT0
         JtzHF+ojty3p+W6ZCZSoUYrY25Yx9hGK/krZZDHzGjrpeMpWA4kLeRqPt3ic4b1I6B2e
         5+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781073042; x=1781677842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KcjYoxNYJZSF7oYA+rD6cGH2cTKuwIPF7kWTMRGHtCA=;
        b=mOLbg2ROI3oBpK48w2WpxEg3jB1KbQ0y1DFMdSkn8C68jF7zZ9ydh9gN6SPd0mMQoR
         +fCEyajBG6mIISQqmHYseg1DNDDGd+uPnH7xwMM1NLgZPkkDnrlfDxYG+o5NS/9pM/qw
         oQYABXzi3XB8SeR/lRr7e6KOPTEV9Gte5Bwg4H7GODETQis4QpwUburZaRa7fXFa7AxH
         w2tcdzzUwXfarH9uHSOHWyHKBQH7ABzTcqZ0rlDxNXpb336VqddSvBVBkKu5UzScHhjB
         OPIIoG5F+DSKdisgUsL1McLBjtQYUzZtn/VhKYba9FnCRsKLdQu8K1D2G/R3l0bqeaco
         Wrxw==
X-Forwarded-Encrypted: i=1; AFNElJ/8tJtbrYflq3AWAlNyGdXLW2zo/oSqMyLf8sQAnNhuxwra3rvPWydbXEK/0BiAkqz/fALo2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEIpG0dgaor9XI3gLpH3fIzfrAMyYNaTuoqf3jjBCt/SlRc+db
	D6teCAs9uEfBO8dkU3kCLy0a1xkSbcfAhW7OoRq9ijnPFR0b1qmhNkQ6mssmHPwCi9VrB/LQ0d/
	2WK32wYcLCdaBJP/qMokwWv6PQE+KcVJRkArIjss9r9vxSGlx7xQLfPZCrQ==
X-Gm-Gg: Acq92OFcxoO+Gg09J3ZH7c5txE7c2iAiCy1X3ymjVlqVjJmcvPyunyn32c+0B7v0267
	a99CrwsJDrDLAKR61JYBROGpbpqoa7fKyrz/hpGZytJgVnlFd4ifPMDWVlz6edBPSBKWDKqpXyR
	e2DHuUkgkkbCMeN3kagF9IoVvfY+4UpoI4b/wFZoOB65OfAY3c7qoyKnzOptxINmq6zcCxn8PFq
	E9U2MCSkHc/QBzse1tKpUa2yWorVjX0U/VTXNy0Q8dyhnTWdrv8Ef8i2Do1q4xI5yxPiNNrY05C
	gazfaNZlLFUOz5cPpi2L8cikPvBNv8BKWyxQk7FlrbPh07j+IAG+bxJ7/y8/BaHVoSU7PwhDjVt
	JxMJ7PVZyGELM8nbJtlu3KR3ARGl1nVKubeXFFPP9NJX34qc5Q1AcHu2HCBJ7FA+aEQ==
X-Received: by 2002:a17:90a:c2c7:b0:36b:9c70:3367 with SMTP id 98e67ed59e1d1-370f0480c9emr24546896a91.17.1781073042472;
        Tue, 09 Jun 2026 23:30:42 -0700 (PDT)
X-Received: by 2002:a17:90a:c2c7:b0:36b:9c70:3367 with SMTP id 98e67ed59e1d1-370f0480c9emr24546839a91.17.1781073041515;
        Tue, 09 Jun 2026 23:30:41 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a2892esm21580420a91.10.2026.06.09.23.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:30:41 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:59:41 +0530
Subject: [PATCH v8 05/12] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-glymur-v8-5-1c79b9d51fc0@oss.qualcomm.com>
References: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
In-Reply-To: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781073002; l=7472;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=xDfVfdVapDwiA6cb5Xkv+E/anLdZly0Gh0yY4RsIYls=;
 b=G5/h11HQ2YGX5yoC0q1s6abElPR03Hs/F4++PLBRwtKyflllLfJyj1SRvj3POX3p7KFWlSxa8
 kb/RoJCH5+nDFeA3PaPbC6z2bqZjK5W1Y3QLdDRE8M22oCNy/IsyPB0
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: Qn890eC7MByjmzE_E-eiDeVyVcmAsetn
X-Authority-Analysis: v=2.4 cv=dLmWXuZb c=1 sm=1 tr=0 ts=6a290493 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=U8OLdchxA3Z7P0hrdlYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1OSBTYWx0ZWRfX2Thj9O4WakuA
 T5Kl0VbyPF6m3xQsC6ATgGL1d7/z7RhjaH03qnSO6m7v7eR3x7S/o0KQPVl5ECtOhm0nwtaIA5c
 a4kH7awKEhUE8Pz5HWvj4U5i42+Odz05RtIItvi6VUKSgyIcFsLwF5Q2XAhe+90Noq8txopDu+I
 lmYDTKRVxJmDI1K29nknCwn9tuFqX8voee6QPlycuttTPge4vMtGj9Pc06EPq7rmtI5YglOn8Ij
 bW+oHYqED4o17nicaUZPB9ixH4SKsxZvLxHzVzElP/4jx3b2wZtzNJzZlHpy94XtT9s96tAps9b
 bLuAlMqWnMKVEky75M5ZwGYJCHu/18Cdq4osW49fyAjHehTvMCuPC4K4/OkyXxEw8xNXhWwjFU5
 6Z/9ty7nH5WZsiMgWj8r9xGXU7ZDg+c0sjwBAaIrsRJiKCqM26/a788gEMrAmkRvqLvDZbMLmP6
 yoAtcp4nbcfp8o1qEGw==
X-Proofpoint-ORIG-GUID: Qn890eC7MByjmzE_E-eiDeVyVcmAsetn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100059

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
 drivers/media/platform/qcom/iris/iris_firmware.c | 69 ++++++++++++++++++++----
 2 files changed, 62 insertions(+), 11 deletions(-)

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
index 1a476146d758..07b3ade88777 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -5,6 +5,7 @@
 
 #include <linux/firmware.h>
 #include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/iommu.h>
 #include <linux/of_address.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -15,11 +16,13 @@
 #define IRIS_PAS_ID				9
 
 #define MAX_FIRMWARE_NAME_SIZE	128
+#define IRIS_FW_START_ADDR	0
 
 static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 {
+	struct device *fw_dev = core->fw_dev ? core->fw_dev : core->dev;
 	const struct firmware *firmware = NULL;
-	struct device *dev = core->dev;
+	struct iommu_domain *domain;
 	struct resource res;
 	phys_addr_t mem_phys;
 	size_t res_size;
@@ -30,14 +33,21 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 	if (strlen(fw_name) >= MAX_FIRMWARE_NAME_SIZE - 4)
 		return -EINVAL;
 
-	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
+	ret = of_reserved_mem_region_to_resource(core->dev->of_node, 0, &res);
 	if (ret)
 		return ret;
 
 	mem_phys = res.start;
 	res_size = resource_size(&res);
 
-	ret = request_firmware(&firmware, fw_name, dev);
+	if (!core->pas_ctx) {
+		core->pas_ctx = devm_qcom_scm_pas_context_alloc(core->dev, IRIS_PAS_ID,
+								mem_phys, res_size);
+		if (IS_ERR(core->pas_ctx))
+			return PTR_ERR(core->pas_ctx);
+	}
+
+	ret = request_firmware(&firmware, fw_name, fw_dev);
 	if (ret)
 		return ret;
 
@@ -53,9 +63,23 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 		goto err_release_fw;
 	}
 
-	ret = qcom_mdt_load(dev, firmware, fw_name,
-			    IRIS_PAS_ID, mem_virt, mem_phys, res_size, NULL);
+	core->pas_ctx->use_tzmem = !!core->fw_dev;
+	ret = qcom_mdt_pas_load(core->pas_ctx, firmware, fw_name, mem_virt, NULL);
+	if (ret)
+		goto err_mem_unmap;
+
+	if (core->pas_ctx->use_tzmem) {
+		domain = iommu_get_domain_for_dev(fw_dev);
+		if (!domain) {
+			ret = -ENODEV;
+			goto err_mem_unmap;
+		}
+
+		ret = iommu_map(domain, IRIS_FW_START_ADDR, mem_phys, res_size,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV, GFP_KERNEL);
+	}
 
+err_mem_unmap:
 	memunmap(mem_virt);
 err_release_fw:
 	release_firmware(firmware);
@@ -63,6 +87,18 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
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
@@ -77,13 +113,13 @@ int iris_fw_load(struct iris_core *core)
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
@@ -94,17 +130,28 @@ int iris_fw_load(struct iris_core *core)
 						     cp_config->cp_nonpixel_size);
 		if (ret) {
 			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
-			qcom_scm_pas_shutdown(IRIS_PAS_ID);
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
+	iris_fw_iommu_unmap(core);
+
+	return ret;
 }
 
 int iris_set_hw_state(struct iris_core *core, bool resume)

-- 
2.34.1

