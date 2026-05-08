Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8E33343B
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266914; cv=none; b=dw8Zs6yG+jPZN1gz/cLxvL9gW4qwz2j/uDOBIAv2HVJ+nPb8oUcm3IZmsW2M68TaWHTg4rggY2ec4uVwMRgueqxacMq7EwIQJiJHpSwU1avw74r8b7zIH4Zfb6TlPqGyrTACLYg+WI339LMj5X41gOqSWGRAbAHjmu6j10pVo5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266914; c=relaxed/simple;
	bh=kiHl1lLYV4nKXfICCZXuAhM4nH0bXvbb/KB+ab5VHpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4xh4lEmNP4lilXLkiD1BikY/YkcPhH36/QvDtaczI+slcfH4zKOcP0JIJaAsvrfLFccdBfO3Qcm9lgsyfLdyGiTC/TALehiCKtRCLLYh4zvqaKqfvN848IHmh4qHykkNqu0FbP6/nGUOOC2dqPVXXjkx/zbkJL9rfBAzJ0WoUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uu1roemS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LOkqGWDs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uu1roemS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LOkqGWDs"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648DE6uj258436
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RYPsAM9GyVf9eOjiRO6hKDynS22g8zyxVf3Jn1km8YU=; b=Uu1roemSq+rFj4Ml
	ihM70tTc6X/TIgMny2WrqMeePGk4go51ipl/8XU41N+WRi1VEUgA0qWF6JRtVRnE
	J1y27sblqHiFD7WZ2AReowo5YO0ZLZQuiiNwQ8zuzqVbYgeFLQqt9Lr83I3ewEqr
	6eyxFoGDFCMKtkhhkr0X5UAdkwqDvpXmd45AEWyUtE1I7KfdmTr/c4sKQ8u+W0OB
	0FE7LQdUN/EheV/eJE9rqk4ejPhqcGcDamjxu+SR1D93OBl9nweu/A1x+lSZ7oyL
	2JALS+ZTTafwG37gERKXetAX10Ksdgz0tYPCKo6SOu7hJ3ceR1yGlwOKMp+H5Ads
	SMTWPA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1auejsgm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:01:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so2745003b3a.2
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778266907; x=1778871707; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYPsAM9GyVf9eOjiRO6hKDynS22g8zyxVf3Jn1km8YU=;
        b=LOkqGWDso25/Mmo88JHL9Vj4Twe2hX0rrXedtzmwRIeF1kSKkZcbTXbeFCl9GqYy4r
         4ie2GHTjbHhG/oCtDtnW3ueBT+JyE7mHN926wWgpXf2inYk1vUl7xmEU2G4a0lhCZieN
         GKsrjuta282GzqvrqUzh61XP8GpXzEd4UVxxf9pshKJC32czqkFhjoBKI+A9xNJYl8wp
         As/DefPIkxuw/2zpP18qXYAkcmOAnrS/YB3AqqXM47k8T0OeazZNwcNPpJNfL+fPUw+v
         IzkN36qwbuyNrkw+pw0SrJ5Ljcf9Q7YP4PVCw9S+p1Vosa29C8KlRQsG6AiG3QWVG0gz
         DLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266907; x=1778871707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RYPsAM9GyVf9eOjiRO6hKDynS22g8zyxVf3Jn1km8YU=;
        b=cSpSv8S5cJUfodooUlzkv2GKkNIeNCVIVAZs3/vBzi0GeKZ0zH9UtNIxiSqoOS79lz
         4G9RvVekdBvMOEqC4kpF8EulX0i70THVydxcxpFI9fJ8EaiQQfanF2QEG7KGpaM9S0Cn
         ijaKCFV60WkTjQFGsYBMhninbKNS7UQU+JouX7nU5XTgnCApkLtlQG2+lubqDo8+haZ6
         fBmKuuhRFhYIRr7oybp6kxiC7Nto+b9x41/BymoF4sj8PkVMeFYig7gU3iddc8OH/HWZ
         qV1DjuP3OBKAYgqxdJ6z5x348Y2waa9758bQP9DQkXABwfmY6w2Lu4Tc82P9iHLTKjJC
         OtLw==
X-Forwarded-Encrypted: i=1; AFNElJ++BxA97R8FsJjfgv7Ex7cPP18A1SUdR1v5oaylpi6323T76dTgYC7yDPc7OsnR+6jhsSLcSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzs52KMGvMIkZO2BNAtC61hWBTuwSyw9czM9UCipO6w2Ueh3xyv
	UbQ+hbb062XQ7O63PAQgkB9TNn8TSZVaSw7E3W55aBZvJUXw+pqPpAo6GUmifN8V2XTJLvdqCcu
	O0trGsY15sfFkt9MVOsTYO8XInMGHd3ZDxuvLYn0a8JubL3lKf3ugT9L7yw==
X-Gm-Gg: Acq92OEwX2WPTH1ytVccpvw29X6XzbV2L84bHnHWK1BNuRLsn7gTp7vjrgaGEv1gOpg
	ikk9p7s1ZZHkwaMuRh1RCQ9G/bhcQfahWn/5hu5ghB7QH4RUAaDgm+ElzPdR2Vi64V55JlxXFMh
	vrjgcSWGAvAXD1MVMs0l1dr3AOMFSSvQAfBtwaxtJz+Op4yWPde+lFN5jOav8nbMPGN5M9KMmeE
	dslfjiG2Nme/H2GVicSu8+GMuerIQoDuGPA4qJW9/f2DXAdpYUbQziUGsyeFTesTUw598RtzqgI
	MGU/P/LmKX8RXpk/KFgS4UETsgzQBxNGjGC1WQeScrbm1CHmCDMsRRAIog8/0+B4B8qE5ZUogE5
	c6VN5YIZ2WV2YrjD+C0/N95o4bWuztk6sTZUaVm/xUduqR+FwyQFzYmg=
X-Received: by 2002:a05:6a00:1d8c:b0:834:ea1a:4b25 with SMTP id d2e1a72fcca58-83a5c0c170bmr13964827b3a.12.1778266906791;
        Fri, 08 May 2026 12:01:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d8c:b0:834:ea1a:4b25 with SMTP id d2e1a72fcca58-83a5c0c170bmr13964762b3a.12.1778266906217;
        Fri, 08 May 2026 12:01:46 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm13395550b3a.19.2026.05.08.12.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:01:45 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 09 May 2026 00:29:56 +0530
Subject: [PATCH v5 07/14] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-glymur-v5-7-7fbb340c5dbd@oss.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
In-Reply-To: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
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
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778266845; l=6647;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=UaR2dTIxtzS/tNKuFtSFzOFmr6sz1nG53anx21+ucME=;
 b=ksbDBtsaICiCigSCrJueomIT4etgGvpPl4AHZ9fo7TnEzQZabzy2Qc2SiaSQsPHJHoFsiTsF8
 iR5CCyMyX72BoruM0Pe+FJu6oa8abHugW0rRs7eEHYy4bEic0pOsNke
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MCBTYWx0ZWRfX7y1NrUJF8VCo
 MkfxQPQZBryr9E2K6DRboX7rUECH4EtJ2zJTiLEUAE6ati59573jvH4OWgXQlTlc2RqZBIgbEhZ
 B883Joc08vMeD6m+NL3o/3CpCLyywSCZTpGomovLZ3vGIoPwSNN47YY9I8j/txnfVHxs6CVaDDR
 w/T+jXWhSZhKoAuihcE/pumFuhgbFMuuDlsfgnPx7corq1AVZBGcQZFGCFWJORX8dN60+AQJvwM
 Q8ZP1U3N5SNvqDVb4zfzXYZiTZi52s1FaU9GiVDEzxzT2cWr/xb32obnw3zCVNWUwFfkb7u7R8U
 XztYWGaNMlR3MrM4uSqk7oFqmafKjrOgWiUrTmLnGEzJ6x+6ENatXAKUrOT+5oYPAUgN1ukU0A9
 H1nWBK0FrFQ8HT1k8BILpQm2OASq86bSsfjSNHpIsHmikutlveaGglHG/i5qwtTjOw+tGbKblXR
 l8CObTKFx0qgM3f3lew==
X-Proofpoint-GUID: WQip3AcdZXEzdtPN8kLUYe9D1jlpQPCI
X-Proofpoint-ORIG-GUID: WQip3AcdZXEzdtPN8kLUYe9D1jlpQPCI
X-Authority-Analysis: v=2.4 cv=fcydDUQF c=1 sm=1 tr=0 ts=69fe331b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=gbwaY6mYjfx-u0ET_fsA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080190

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

Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
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

