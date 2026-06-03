Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9DB386551
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496473; cv=none; b=dz01xzQ6ey9EuXYOAl/niTTHW5mJeAugAnLOSO5xD7AR79MmNNzzURydEkApTAyw3RPEhC6tfuZgFcleJyDrtJaNpXq2XHAXb17tC/nG6JfUf7Iefmz/hX758SjSHXbydN+adtBUjwu3byODDl51q5Nu2UPJnG/rNCpKOPAeRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496473; c=relaxed/simple;
	bh=V7PgQEmeHs85Yid9DqRUGN4/IVHySFt6tEXoQMuJaQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxV/t+M4xSBrjq7W61DtSztbBzLoZB2aVF4a8bEz/tXeG40ehcFGSe7Kf7RmCqmgLLpZ/8SsIAZdKzsGwzbsQKZKpOBcpQa8d/QSIfGcgnxIFuMzLsk7zm92aexf3vSOe5Qo97r01YZTq1TqNJl0qMCBRzNSD/r7aOHtXIxQNdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eRGj1to8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kwCi8EqU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eRGj1to8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kwCi8EqU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6539vTIF2368080
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 14:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xMEkLXNsqb0/CW0mZDeXY4YJFWXjWp0pDdNFYzT4HSs=; b=eRGj1to8SrRar4ME
	nSFZSDo2A5G1d0KWIqYdPbg54IVoIWZFhTrBQRH5nlu7b7gyFxnQQlmzrrw74UYi
	N4HwraOBzyWW7CuqZ/pEKQH9OuBQzJJ/kcacEnw5u5PfqJm8RKAlFwqka/rUJjQ1
	DE7pyosLzwb9pjyEgXnQx2t7M2SI3TwZQSJMtFUJ7IJnBe6jnfzM+0/9Gx1vEMvc
	ADtMqr9rM6R1rPnbiVcvpK6JCLVVnm+64QEtDoIlr0EHaFsYdW/OzdfyE+FYOhYH
	8jXT8KWx0G6+QrtWKsBYHYAPULMtb7jRUO2iIVmVNdUcElV/1lO/7jBfIx70ULPO
	v+vEKw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejj3ggyqt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 14:21:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0c20f7581so42869425ad.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780496469; x=1781101269; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMEkLXNsqb0/CW0mZDeXY4YJFWXjWp0pDdNFYzT4HSs=;
        b=kwCi8EqU3j8qjWMggujXPmdm1FVbO+Pvbco+Czx5NLR9JGF7BACUJns7Uniun/GqS4
         hzG5wF/M7FcPDCTfe+SCa2Sqrvl2T4mYroScu5vHNUL7VcuOh7tvXFy2CkZFcedqWKtq
         B2Ui/YlY+4fnOozGbHjvSA9p6D0qLv9SwdMwelO61f74ghzeUgis8AGciVPtViLjWxma
         2L3zYS2c5RH072YjeLv2WdMM2pcsW+rrXKlqEMKrFusvMxUbDUJoaQIVIB9wUtyN824l
         P5+RRugvg4Fe8IjnFRZ+JoCuxPG8K53U+ro5Oq0lypYXRdXpKNCM9d7QYvl0xJ9iBXqa
         usNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496469; x=1781101269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xMEkLXNsqb0/CW0mZDeXY4YJFWXjWp0pDdNFYzT4HSs=;
        b=srOrjj9Z8bL3Qrb8v8Un2DCWdF0XtmRjIRvjzkXERQXElJUwqFycjH9Wy9tiHbmw5x
         ChRvd/xNVVyD0Pv1+XtUQ/Gu+Pt+F1QEXIPTOezMgk2ee27YKNwhYsErFj5a6fhdyRTr
         CPmyweDKIvYeipIrtSOt9u5gdseHmdal1wbPZhhscRbIU/9hBHY7I38dJtwF8jGLU6DP
         Ek5ApyebUHNXdG9qA6P0nq0bgsGso/BMPdEWJplJRvenU1xcB2g85WFghB5TyDiAhA7Q
         j7PBcw5l9hOBlgF4FxApoCaf5N9Li2bpv0JVg3MLUTIQ/nL/GkVPsJJfrrSAPaHPKYNC
         uJ8A==
X-Forwarded-Encrypted: i=1; AFNElJ9GqnwUcgrq75D6jOVnlBU7i48t4iFgg3P86MjOOnc0U56vSfrZnhC/Y5b4Ksp5CpSJz6THvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcCsbRveTbliTJZOPnPcDTAOp3aJkp+b+BqJ8vpKiYcVYP77a/
	i2gVnqCfzuUK2pXroG3nWNhezQrpAIlSqN15PaXjPIlDCz9Nh9VQW3QX/TXALECXUEdohKQUpdW
	2iIUsSMcKC6Bh9q0HuH+4qlhC8gqc6Wx3rhbfYrGifrlgoH3leJjtK2+i9g==
X-Gm-Gg: Acq92OG9GEoxR6gW0eNRFMUue5NJ9ddGuX0KExncVstNOMsrhLP3MDc8VUjXcJ6dOOM
	A2OpiY9L8Zh/LKkXAAU+m3FdsI1wd+aJEnLKr+jCwI19Gn9vh+n/6egtZ1Et2gIZuT42SP4MQ6k
	0vMoTSOyLyUtqWZqj2ERxccuaB9h3qHgWeRiuSb/EnZfaLaSxFF7g8vw7V4gwJDHN/l5lbC5td+
	8bu3FrpD6hLXm6mS5xTISLiI4/x3/jnYnNnwvO6Gdbvz8YKKN0zJSDARvqZoC8TCKAPUaDR5Nmt
	n73ztTBhXRrwWLCOIYCgCUWkE2w72cyZASqNcUZhluh5c/ZsYeP34CuiZn8fFraM59Gjn2eqpYO
	pynMXFDdYEf2ycV040Y9Wdg4QuZyjb6r0fYcHuquSr8WnvWJ4Ankm32bbJHdeBqqW8A==
X-Received: by 2002:a17:903:4b50:b0:2c0:a373:89b9 with SMTP id d9443c01a7336-2c163a24bf2mr39122575ad.6.1780496467585;
        Wed, 03 Jun 2026 07:21:07 -0700 (PDT)
X-Received: by 2002:a17:903:4b50:b0:2c0:a373:89b9 with SMTP id d9443c01a7336-2c163a24bf2mr39122085ad.6.1780496466980;
        Wed, 03 Jun 2026 07:21:06 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm41514955ad.9.2026.06.03.07.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:21:06 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 19:48:46 +0530
Subject: [PATCH v7 08/12] media: iris: Handle CPU_CS_SCIACMDARG3 register
 write via program bootup registers hook
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-glymur-v7-8-afaa55d11fe0@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780496410; l=3461;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=V7PgQEmeHs85Yid9DqRUGN4/IVHySFt6tEXoQMuJaQ8=;
 b=ajH7+RdKoqMBI5T0yRV/AwqwH7xNBXME7K/NWXkfDQNofxpXSwhe5VnQvQZ6+sco6/vGoY41A
 CwZZyp4iv9TAdwckD6UqVahn0V/uorLzVRChwsq63PpGuPpcMScDciZ
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzNyBTYWx0ZWRfX5IzrxxD+vO4+
 Wse6QNZEs5gsGegGftxmOb6nMNyfghTl/+hHa10EL3NmaSvno1T36niRQ0aEwMzM7j5r+QQU9B3
 LUTIB6+vVOUk5Vw4g2MPFWjUN/a08bEUQxnoV+b7sZBw9nwewJiTexnCmNhvAk/N/bwQDGhIPBz
 h0H9cxdtkROu/MQdotxFccVhQcTz7acHyTeUXF6m8KQjuxS6FWKb2kETkkj6prujHF5DDm6P3+k
 paQ1Aa+cZqw2kFHvK6DoUWZwuTNcmfGfTJA3ggBYftmZ/XddyNl3m0k7TBCrLAK7i1HQbdophFq
 NBVLd0uC+bQNaoos/XTaXb433NfG41T9PncEKU/2Jk/AIZr2i5rQXJMAlWt12KXypbtG2FBfo0j
 Z4KLsiTGOrCVTIso+JygPTeqwhKOm0ijviEisuk0fVJJiJLramaEarc9lU8r/R7ku7HR1vq0idp
 RFkJ+1i9hYO3A/ftFvA==
X-Proofpoint-GUID: M-yW9klxb1gH4Ot74EfQhxrgNhK8AvAi
X-Proofpoint-ORIG-GUID: M-yW9klxb1gH4Ot74EfQhxrgNhK8AvAi
X-Authority-Analysis: v=2.4 cv=UvhT8ewB c=1 sm=1 tr=0 ts=6a203856 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_-2Oxswyk2Zu2Y7AJ8cA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030137

On the Glymur platform, the firmware reads CPU_CS_SCIACMDARG3 during boot
to determine the VM count and increments it by 1. Writing the default 0x1
causes the firmware to treat the VM count as 2. To avoid that write 0x0 to
CPU_CS_SCIACMDARG3 as a Glymur platform specific.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu3x.c                | 6 ++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.c           | 4 ++--
 drivers/media/platform/qcom/iris/iris_vpu_register_defines.h | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index f07eaf4b3be2..65896d0c1f16 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -313,6 +313,11 @@ static int iris_vpu36_set_hwmode(struct iris_core *core)
 	return ret;
 }
 
+static void iris_vpu36_program_bootup_registers(struct iris_core *core)
+{
+	writel(0x0, core->reg_base + CPU_CS_SCIACMDARG3);
+}
+
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_on_hw = iris_vpu_power_on_hw,
@@ -346,6 +351,7 @@ const struct vpu_ops iris_vpu36_ops = {
 	.power_on_hw = iris_vpu36_power_on_hw,
 	.power_off_controller = iris_vpu35_vpu4x_power_off_controller,
 	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
+	.program_bootup_registers = iris_vpu36_program_bootup_registers,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
 	.set_hwmode = iris_vpu36_set_hwmode,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index f35754ef53ed..5bbcad00ce09 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -26,7 +26,6 @@
 #define QTBL_ENABLE				BIT(0)
 
 #define QTBL_ADDR				(CPU_CS_BASE_OFFS + 0x54)
-#define CPU_CS_SCIACMDARG3			(CPU_CS_BASE_OFFS + 0x58)
 #define SFR_ADDR				(CPU_CS_BASE_OFFS + 0x5C)
 #define UC_REGION_ADDR				(CPU_CS_BASE_OFFS + 0x64)
 #define UC_REGION_SIZE				(CPU_CS_BASE_OFFS + 0x68)
@@ -67,6 +66,8 @@ static void iris_vpu_setup_ucregion_memory_map(struct iris_core *core)
 		writel(value, core->reg_base + SFR_ADDR);
 	}
 
+	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
+
 	if (vpu_ops->program_bootup_registers)
 		vpu_ops->program_bootup_registers(core);
 }
@@ -78,7 +79,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
 	iris_vpu_setup_ucregion_memory_map(core);
 
 	writel(ctrl_init, core->reg_base + CTRL_INIT);
-	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
 
 	while (!ctrl_status && count < max_tries) {
 		ctrl_status = readl(core->reg_base + CTRL_STATUS);
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
index e67d98b8c91e..de6a91041ea2 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
@@ -29,6 +29,7 @@
 #define CPU_CS_A2HSOFTINTCLR			(CPU_CS_BASE_OFFS + 0x1C)
 #define CLEAR_XTENSA2HOST_INTR			BIT(0)
 
+#define CPU_CS_SCIACMDARG3			(CPU_CS_BASE_OFFS + 0x58)
 #define CPU_CS_H2XSOFTINTEN			(CPU_CS_BASE_OFFS + 0x148)
 #define HOST2XTENSA_INTR_ENABLE			BIT(0)
 

-- 
2.34.1

