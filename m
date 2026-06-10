Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0437DE97
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073068; cv=none; b=l/q+OfCE4ccaoQrG9zk6GDA95rJEhOJ0Bk4aJ53B277Atcrz+xwzgXyCHXgSvhY2PI2KLazyQ15sgX0ej/XzQG8n5hp35EcNIs+dzp+sa41dgoUerfUfxdF/JKYAOWvHtRyM5vGLoQZSfhA8dp5Cb4qo0Rpvast85eWzmRiiRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073068; c=relaxed/simple;
	bh=mLL1VQMpy9N1BOZ45ldfQL+Mb3ztVhn7sg/R9eDAGTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3/8YqMoGbXfQpfhu2tr3+tWKyMnwT45mxgu/t8kTQJ7S1Dog853ml4iFGW3P0JPLHYR81uvNpJt34SKpjqZ13D7qanGC8pWUVZAsdIwYEisWABhNznqNDxPsfZV1it44HsuxrdNlPcwzkJMtONDokHFb2uDpuzzHiwFcxstfjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ey4IBKwJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PHY7lLIR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ey4IBKwJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PHY7lLIR"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A45Dde387404
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A2ytESqp4IIaVb4+TyQ22iWPJANF7n5yQgd0/Sz1Gvg=; b=ey4IBKwJmiEYjTLL
	qyHIIFqWbnknd0D8xBdjd6NhrfynT0khwDQOWnYXrDWecDc7XGfKIGdytY3tB7r3
	n/NT9KFDuv1DdMp54VbDQt06kwj8UPgNA/aWFq15Bo9dxzVV1C7jDdRFbNp9qsNX
	W1LSpDW2DkOmINgRYzeVVpcfxMmxumicJEEFKOvZnAYH8Ppu4dNK50Gqop6KE7hx
	69oGJWpiQ4NMlxwNfR5yp+tFMlLK5mFwS2BDEq4913U1633NnkVAH/QWenO1r+ei
	/5tSaufj4iolJJ1htyZI3gy2c1+L/DinPYb26PrYpebk75BDwVt9WV1VfZk7K9CS
	3jHYdw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0kd8ek4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:31:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d97415004so12438944a91.2
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 23:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781073061; x=1781677861; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2ytESqp4IIaVb4+TyQ22iWPJANF7n5yQgd0/Sz1Gvg=;
        b=PHY7lLIRtqeZIRpl43LHenLSKO1WMd7yPlFjgZD//TGnq9XU/jUPkA0qlrzkvXe7lE
         eDYvbXG+bFkVTLeFUzv6IoMHflop1C1ujcHSOWVBSjxhjl4VDOzRRFuCn3JtYGFJxyoU
         dobKZ9b8xQpPWOrdFI/50CUhTWt0pzHck8/j7eyX+0S0D2t4v6EQhOYgl+fjAycHkszu
         AJJCKfwOvJoIkvB6uFwobKkqNn3IZrNyxAkKWDkAhBdpUC0R7phRr7RjOueLl6tsqcu4
         OeZcdHiIHQOs9h+r9FUpXRG7bAyi+JqIWOxUom6Vqiir8jRbG1SI1LJMT1zlnkuWFJXn
         Zvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781073061; x=1781677861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A2ytESqp4IIaVb4+TyQ22iWPJANF7n5yQgd0/Sz1Gvg=;
        b=TdBYs40rYGcy5Fo6psZewgKT//rkN0wT1NDwaVjSX9pTigHK5RrIdPwieEI/j/IJYw
         ur79R5evt85E6DJ7TOHjCyp/zfSbdhbtDf+SKZ/4TX0NHvlD4aETLoBE7gAg8cvnaBmn
         5V94tQuJtNFCbIoP3eiInpeqI9CbZmus3Cp3zEWP8X4XPweVQtbsaXCY8+sWRRgLfzp9
         VS9MqVey/8AwAn4Y0+sdJyS7db1hCv0ZzxEX0bo7rk7o/7SK47RipgsR0eHXlMVdNF4M
         TK6gzvwnqE8DY24X3hA/wWP/spUJX7gHjVoslYbiaNw4Pawu9ieKrQlhw3AtWavnHEg0
         JfbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BWzNvO3wdrZLrVv9/kByJ5BklWjhqJkZphJr+jtojJ5a3ymzGoiY6++J+Yuc1rzqx4tqT6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPIEqT3mBQoLzgXfVLJGjJozlGHpTJjItyhDoGJceteQjN+UfU
	H7fhRPS7LjbqJ0FEKQ81kVp/bcdJQhvS96mEdt9+LTmanil5ejjhU+2kjxiB8aVjoL3ZIRo2f7b
	NDOUSrcIVkKyt8+T3OoDmrqH7unb0xcExa9UjSoMgI61WZY38HdAdz5tu5w==
X-Gm-Gg: Acq92OGUC6jAOVOzQGjMlGPDFhLlrjuWlkybQn61c/pXWCJ6KBD8wLWradAWSazCT5i
	h1JJu+9xMwvY6MJqu+0tPJ2RflizwV9WGJ7Vhd6OgwORBS/B0GkqpIQN77syiUM+QXSofjGlZog
	a1f4b1mWgXt4YckL16fYgraAkse8RqyJFs+lftfgnoU3+jXr6SwVZUXdNuA+/4XIfqo1R9LS2+M
	2C7wgcBFs1e15nJfsNQt1ln8rNbqO4eRzzZT2S+g8yt9Oli5DbC6rcB2ALR8Ax/YXWDWuwuurko
	J+eiJ94704kZPx8u0GXoPVlpszQT8D3MBuwiB6YoSwiu9bu4pR5ceQmC0ITjItuyGlnk6WXAelF
	Y6bH2Sg/FS0IOGYnYPeNd93eStRSIcfmlPww7n+TNUuX6AEz1WcOfT/gdmma8uptO7g==
X-Received: by 2002:a17:90b:4fd1:b0:366:5c38:fd61 with SMTP id 98e67ed59e1d1-370ef2f077cmr27350386a91.12.1781073060641;
        Tue, 09 Jun 2026 23:31:00 -0700 (PDT)
X-Received: by 2002:a17:90b:4fd1:b0:366:5c38:fd61 with SMTP id 98e67ed59e1d1-370ef2f077cmr27350357a91.12.1781073060211;
        Tue, 09 Jun 2026 23:31:00 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a2892esm21580420a91.10.2026.06.09.23.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:30:59 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:59:44 +0530
Subject: [PATCH v8 08/12] media: iris: Handle CPU_CS_SCIACMDARG3 register
 write via program bootup registers hook
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-glymur-v8-8-1c79b9d51fc0@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781073002; l=3528;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=mLL1VQMpy9N1BOZ45ldfQL+Mb3ztVhn7sg/R9eDAGTA=;
 b=/Xd9va40294R+8HlxRq/gaDcnCW7BShMsRLGRWPPOvltZR94CPuN4ZK3YoENes8SdkDxtR8jc
 FC2+BJpXB2fBB9cQ4gyMkiTQgZydgV/XjudA/y95v2fDl/tN4c3wASR
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a2904a5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_-2Oxswyk2Zu2Y7AJ8cA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Z_sh24qR9e2xSM2BZB5mNzfQeuIhNQMI
X-Proofpoint-ORIG-GUID: Z_sh24qR9e2xSM2BZB5mNzfQeuIhNQMI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1OSBTYWx0ZWRfX/VOT5YK3jhGT
 7fHqoJWN8cjJTwjqMcDC74i2CyrgzbBn6trvnfQWK0fkEDK6ATrKlbPi7TCH4rFwP7vJXTDZ8gG
 fwsPlQXuGmQ3tOXrXEh7uuzdBUwPkSAjOK3ROuHbwGCYSio5tE+2S8n3BvriCrjPoAJHVbn+w7U
 UFfukOdHXoRq5Jb926ryzDmGu8i9Q8NDd5b0v9+knGYm8cBHFXx6D899OoMTYNonFQGLWbzQd8d
 hztpJdp2eE/QWaH0JY74HkEaIYiwkFXnvnkwWrGO/EYjGRCTdb+pe9Jol3kc6j7iCIVYmaQXXqI
 nPvRygdmEqcS8RwbtyXTkgFO+Q+8LogStssQA/I65JZ5tuwWehv9dReuB+7GzQfLN4kI95i92Ji
 hvuTP5WNiasKtyYJjD6fKAG6zwQ5g4aLzeDObl//nQ5D+PV0N/sIDhMzvZ+5chBK8B+ALmUmmf2
 FVfvgEjP4zgP80c0bLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100059

On the Glymur platform, the firmware reads CPU_CS_SCIACMDARG3 during boot
to determine the VM count and increments it by 1. Writing the default 0x1
causes the firmware to treat the VM count as 2. To avoid that write 0x0 to
CPU_CS_SCIACMDARG3 as a Glymur platform specific.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu3x.c                | 6 ++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.c           | 4 ++--
 drivers/media/platform/qcom/iris/iris_vpu_register_defines.h | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index afd2a0e2a3a5..bafa2ab645b1 100644
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
index 330fc85d232b..a42554272964 100644
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

