Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF233A9DD
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348602; cv=none; b=ZwCZMLzWSLtJ8sEtaoSeN4Rlm2Bqdyvc+EoWYDZ59l5qNgF1W+0vUgkNQf43ztKQItH1HXlx1okk4OW7IQKufufZFME4mG8vtNv8TvikdljvbRRLTYCnv/hrq4CW+tigkdPz/XwvK3h/xaVHrafTqeuIffkPV1gu97AjmmuAiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348602; c=relaxed/simple;
	bh=5XMD1PTwD/LTxgA60yhE1YYtYnYGkszZwhjmWff2fnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lA1/WZ3fuNzRTJJtspW1RrcO1lTcs8rZm/NfBfQHC+BVryomWS8MHoRssJCC2O2CYe1au6ezGnd0fFlu0FyTzE/IuAhYTU8g+ei68U1lgW4QR7mj8n3dAv9/G8WikSj0QkXta9V0fIzNeXotAsom0KLHqdL0D5pnq2ch4MoUyrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jt5EHOjO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RBnEdquG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jt5EHOjO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RBnEdquG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RJ3UZd2112521
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bTy4Bkwh+gr6ISqDQC1YSZGoQJgQwg2cLAvk32oAfkI=; b=jt5EHOjOmtMzLjTi
	hvVfhUtmN6v6g7AKAcwYnAfzpHNlpdmIYXmo6uP0LNMEc/+m/nAvHn61k1InATl7
	7JKJ/nwW2Qt4Uq4bMY2uYaulZhAuEQb25dnKcCHgB2oRVXNRZQg6jZDCkEIHZMTd
	lPOdslwn/fFjGgv010aAbKN70AxOnjNJtMzsul6BFSHSx7h2gc5VPAxMf/QrlU2L
	+QS+zZ2dDxKUKb5QtmQxToTb8cpz5klIRGAKgBDtPJioWOY308NxhNRNCv32uS3t
	hPrrhqr6Q72gUlhBLqoFhk+jnEFbcjR6IvV1IBj5/icLkJ02Vb034bUO+HHXyQ6K
	RJIiPQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbhnfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3568090851aso25976656a91.1
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 20:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777348600; x=1777953400; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTy4Bkwh+gr6ISqDQC1YSZGoQJgQwg2cLAvk32oAfkI=;
        b=RBnEdquGLOXM+hDCxubF3o4y3SqU2k3Ja19T7t4oWdjf/u66Heb5P/3VDoXinDJA8I
         9GFKqQaZfxTkP1xS2/R6QXzAvXrZ/6wi0ISO9CIjSHFZNzHaIsGJmIQnJBB8y2mkcr3y
         OBc+Zyn6OcGE64msV8JnKoo94O2+kHUb1aBoVZJyWR0FVXdWNND7eEmIvWxnot1PYq1T
         EdB2VevE/g9zUMO9ZpYSjk8ss84nET9LsCoDQwmHnrpEF3R/NYkhdhIVqtHdOFmBTveJ
         hHi/JeatwADM3xpo4M2mfiK9NcR0y8KdY9G0GCVC0oLmpQdYE4+CdKdGOD4CwsEGTMIL
         qyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777348600; x=1777953400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bTy4Bkwh+gr6ISqDQC1YSZGoQJgQwg2cLAvk32oAfkI=;
        b=aVGMNFjtv8vdGN9yAH/+d25NXr8mYWmLdZmCbi/CQ9Z/yspsrvNXTO+Pr7GYn67wqX
         YK1lP0DDuYEvMcy36Q2Rkid8KZfTRJ711+7HXgudYrxhdtWmUHaTfNou5WZCsnMv3d5f
         lcKWraQ1alRp8fS2shXiuPEqieJ/JxzIj3PM2myvOfLrKXucxZeuHMdBbYQGiofMLpeK
         9LGWpQYrauwHH9R8E+yLXq/mNhPfdAW2Gu5aHCLHqH79g0gtHFyHxhCO5+tyrDmLkJRc
         NB46GdyoNi1dkurBI0xqJ4B84/jmIBQZNJs/S2f4wPZR/0frA1SwcfHHxhMC6Hk69xDt
         4aSw==
X-Forwarded-Encrypted: i=1; AFNElJ/qZC7g1IKujEC9yor8CnDq//9HuNiYaVL0+qbJJFDdvHUJdFZ1oGzabsAF5mpYHXTiN4k4zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxWrdmfOxTyZ93kP5SnvaqKFqkiHcLeGuIwYKteoxTzAzCoW9h
	k9QDeORzKxQAXjIFNXoZJKBXFKZY11CtK4GXiMkS8uh8qSibJUcVU6E0F7QCX947qzCNM5aewaP
	vxr018aMpQyrmZZbc2g6tk+bxGr1Z3mcwjFVi6xKJSbjPoC8ygJzcu4yQcA==
X-Gm-Gg: AeBDiesL1frgc19XEq3oMwas28IH4DyQvYVVl0w7KUOMPlBR5k9J+DQJYae1ki6tVgd
	qdkUc2tDDz8t+JoMM5SkfAoz0inlUEEx4JG4uE7FaLRMRupMsJ+OEhRnxt5XD3+tIwhXbV+zA6F
	0r+H89rL6szZilQkuOBn6iewUOZL3HdNu6G49gQFPzZGU6V/wmQ5gerfGFSu9ETjNIcqvnaTSGi
	04Msc365Dpk+vy2CxxRe7vaHhwjuzmpSm5rWYbvIGouG+4Fioeb9o6pjKvtpwBVhYqzuZKReqlb
	r/0Pu7crjGOTp2Zpsf1SeE1FP9VCzeliJXwzOxy9GnoZgLPCWEV+rJvH825OJG8ZUx993/qEfKF
	Spni54XGJePUuS1Hf35zoBzpwZWpHTz8J+01c5GqKhWQAfcMXzHYGwn46y8B62ToN5g==
X-Received: by 2002:a17:90a:fc4d:b0:35e:57cf:c0a3 with SMTP id 98e67ed59e1d1-36492077fe8mr1448142a91.26.1777348599679;
        Mon, 27 Apr 2026 20:56:39 -0700 (PDT)
X-Received: by 2002:a17:90a:fc4d:b0:35e:57cf:c0a3 with SMTP id 98e67ed59e1d1-36492077fe8mr1448108a91.26.1777348599180;
        Mon, 27 Apr 2026 20:56:39 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490905648sm393888a91.4.2026.04.27.20.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 20:56:38 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 09:24:12 +0530
Subject: [PATCH v3 06/12] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-glymur-v3-6-8f28930f47d3@oss.qualcomm.com>
References: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
In-Reply-To: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777348550; l=6587;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=+wQbHvxygQq1aTrGxrx3UsURZ3ABehuwxnmcohM5NBw=;
 b=Le+OHX1qkXM83hmvcoX3+cLYts84Kbt1q+4H7HJtz4T4o/TbiOL1LnwC6P7Aqgq/8ltSpl1oQ
 jpGgQr298FACq+WA40ceRRYgexnnkDm7KZ7FLcGy49M87sLu0tAacar
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: pJRRXTC4WTZEFtUUuGV9B3qO9jWSQ6Yv
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f02ff8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=gbwaY6mYjfx-u0ET_fsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: pJRRXTC4WTZEFtUUuGV9B3qO9jWSQ6Yv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAzMyBTYWx0ZWRfX6Xa1gq1cnmtQ
 szT2ZBt6kMoT70JYNFUZisDHbt6oBt5UKGZ6G/k4eGhkPDbJ3WXJj4z6FMssgD09TQWtDswbLJt
 NJOo7vSdsue3p7gJ5Mr84ElARADUki2oijchV2IVvdGg8JNdpRk+pQeJWn4lxlBSIPz18fLoje6
 TzlS3clLIRKno5GHsKKPS5JOq/tSacJhn5d2TR29Pu+OXzlXNggjiw5fW6aujuXeZm2EMEsfB+Z
 2RCZMzYetmpHeiAZsqY0reSwd0nkjhYx2p6F2OXd3KPijbZxnrhngiq8tzdMUU5C6RelxV+uLVI
 qn+I4KeImNoUB/w/P8DuJuacHoZzf8S+HQ85acDQqBO6wKPRPLWV2S1QI7jd9UU/vYIvL7kDoyQ
 qb4WCpqZVmffp8bHVnpwthf8OLrew8N9Vjic5df69qNfVWytHl3+/H+I7R2BXU1zGF8elaqMT+X
 Uz3OiqqgdsX/+Vn0+Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280033

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

