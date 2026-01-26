Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94673370E3
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430419; cv=none; b=T/Xuhg+kkPURpBx+T+fInE1p0YAzuLmW73x6l9iRlMcXk1E0yTUDuVM2OeWRgkCOLo71nZgZ9hvyi60iZpGnV/4H4AymNPLShqR2dTO5kdC5gAUoCutMTbDyrGgfWD3oRjhoeta/z2QpjE9AFbsa6OK6KZThYdDJlN0ZR9ReizY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430419; c=relaxed/simple;
	bh=z+sSNLnXrdzptyBRfn+oKBY8noHsRG8lQ9Ek5mlYdfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jaHaEIFWmPJXe7zWKbnE8EDddCogtnrownqyl7wdBonJfwd/DLXFJNHeWCoMpdmfbO3/JZHp/j7pkfNIgrq6Sg43RDhBhxqvpAaR2qjufFfb10JM81T1LagcqYYnztk2ou2Jl/NA6O3/H3AWBAUL3DhX9zmQOgschLhaUvbtNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pmv5hOiw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CxJwINsX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pmv5hOiw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CxJwINsX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q8JfbY2168691
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ziZtcjcBbtRLEDYTeojRiwIkZOR6s0CTAjwetaujf70=; b=Pmv5hOiwEw/V4u4U
	b6v0VViS8C3Y2MqLc8EGsaVWW9YKQJ7/oOEgKab5LGKnV4fPtreIE3/uee49IHpp
	VJpKEiGOqQOfmLphAsiGTiP4t4XT2qDxodXtLrWSI3uFHt0xfUD9C9BvMMEvm4Td
	s7ZAhfj7O3lgv1SkV5s5u/KJHSgYe6U1lGxXe70cir3zVzGDdenRURxRHHSuTDyC
	bwTbZzZjfVTd0KwONEego4CRdUiQ1lrxjJ3bYd3lr3n85SQVr2u3vFYIaZ6HE7n/
	cdI8qf2wOzRCEhDweyqyPqbcyKPfBCW1vc5+feb1p/tGzPqdf/43m1FwV6UW84Ru
	mzDqew==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq8dmgy9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c5454bf50e0so7913405a12.2
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 04:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769430413; x=1770035213; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziZtcjcBbtRLEDYTeojRiwIkZOR6s0CTAjwetaujf70=;
        b=CxJwINsXzOpihJJbAn6CZlKYlqfXMKbnIitI3gC+KSHJJfxSOXfUxF1KU21/iynRD9
         pIs9Bn7Th8bJRoZ5w5bzvoaYs8gVHmh0Gf4OGXPR6Z6yOOjeQfVE6Dao+8If9UE9bO5G
         o9CLityEnblvISNOyXzRNzIBmkkblj0jc8EpLZlucpK1d2kY/eYd9WvSot4VlhaoAu8f
         fRuI8qVQUzH0lXapkBK6c4k+YXyWplDg2VKVZrTTakxHIRk0HxyBmXItphEOPSARkshl
         ZwQrTiBxncZn23j3tOBHJY09nds3luGyfxzoTfL5mEMYHSH5EkRIee6fgOYnglcKJPAN
         XErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769430413; x=1770035213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ziZtcjcBbtRLEDYTeojRiwIkZOR6s0CTAjwetaujf70=;
        b=fP12qF9ovr8IpQBfGkJNZ/h6qQFZqSjjezpIctXwiUVMjmy1XBkL1sY1n7jU8sGgMO
         6ORiBUTv+eHqlbEDYEKyOH0oWru/UgYfziQbwtwhn/R8Q1eWb9HjwsbElXyLE27J6Ebd
         ETtWT9V/cVFV+4owsiUwSu0RYkTMB7zwvriAZHC5FN9nKWWw5Mq2BiyWo0m/S2JNslEx
         Vb2Zyssdp5g3D0ZVQhW8jcpIlOE830z2T6XBizBsZtDBbPzsQhhUtKxDDOD3Vp7nMUhU
         nDbxiebAdSf2ytcogvjgXJGcwsLD42H6qp/xUz+R8feKRqoOgn2WHyk2SNSO2hpSsm34
         FzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKtA+UEydTO5cPYCzPKLm2kGNij1XaRMJXlAf/idIDPuIngEMrZ0s8fnUMxA46N/6TeAXwnw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2IvspEVqPf+4aCvEE17PuL/yse2INuPnno3B6DFO8sY8Iuf0z
	cLPvTd8V8M/t6UwetrOi1ziIaqOV1timL6q9OWfF2hB0Ft62MxhaQnjizBk2T8l13nWSz6/wxA3
	G6TTle1dMMBQp1HfXoVyc1QlemLli7ecJaaxTdHaXtB+CzJJ3zJQaQYgaHg==
X-Gm-Gg: AZuq6aLinFnNMxBUxCHGlK0Xq2hZqFfMg2ra2j3EAlNCYrLVgg78013PU5BeOrvc5A/
	Tj7g9ApvquTDWsqKL3HRuP/Eoo2O4/g1Ic+hAAbKQSBiu2gqc6K7+DK/A/gJZ2qEplprWoZ/mg8
	RJ/yb4hWRzjHHis1OXu7pW4Zg9w/WliY66VjkNTqPbbKfPbsEcnJz9f3g1DgvcIvoe8pC1k+T2B
	FTYMz6e1OjdoFALmwm6hE3wsfdwHON9x1I/cs8TPopF1gD63GUS+YfJLObHmYyUzKO84OyGOzja
	l/yFYe6YFcxCgaS8ETolz0YapAbinbJ1UzBc9FUrt1l0NwjZuc5E93NNaK56rcGo8PqTotz4fdH
	/rSi19qiyooKhdSPRJpQce5JS/uWdGh/MUH3lLoZDtLEu
X-Received: by 2002:a05:6a20:c91c:b0:38d:f988:613f with SMTP id adf61e73a8af0-38e9f284ec0mr3472607637.80.1769430412841;
        Mon, 26 Jan 2026 04:26:52 -0800 (PST)
X-Received: by 2002:a05:6a20:c91c:b0:38d:f988:613f with SMTP id adf61e73a8af0-38e9f284ec0mr3472576637.80.1769430412271;
        Mon, 26 Jan 2026 04:26:52 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6366644379sm6076022a12.33.2026.01.26.04.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 04:26:51 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 17:55:47 +0530
Subject: [PATCH 4/7] media: iris: Switch to hardware mode after firmware
 boot
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-kaanapali-iris-v1-4-e2646246bfc1@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
In-Reply-To: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769430381; l=9186;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=z+sSNLnXrdzptyBRfn+oKBY8noHsRG8lQ9Ek5mlYdfY=;
 b=yALUNdJ1CG/OGjnKOGhWYRq+Ww31ksx0ze51+Vhg8R44me9Df4yePcpWikyVPpVtd77EI3I9h
 K660ANRY9wCDhRqRerNrvBf9psdBd68kPQB7eDA4cz0EVpUDUf4gymK
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEwNSBTYWx0ZWRfXxRgj8xh6eBse
 9yhWuLXgjaKckwJgYQ8RCek/gA08YUS+oABXj6NJGoq4rXcepIltK43+QJ76aSBHLOZpL29VfHm
 9leACqFhQZW9/xkQOvPdg0g57I30ZGGlyAJeOVq4Oe4kMN3JWOArHphM+bdVu50Dpo9AabSYzuK
 mQl78mJRiZVof+9weUsE09m0Aly5mTT/ovild2DDh1Kwi0Fa9juc/uCQXArGEoLGoUQLEyRbA99
 4BiSC+zy2FMiG3OwQnLuXuoMx3NeVU1fm/3E8K7z8hnt1Vx/Ck1XguPG5v2MZ+DWqTBI/el+iyd
 fI4SGH1KgatSL6tYJQQvNafEnSDYJTnLmQGjA7whB9KkdKu1KcnJEOtDeZypOvrFpDccekrJmBx
 xJf3kvVvs4xN0O9oVT6AZ8b/Of9uWAscC83ie3kHriyiVl/M7n7vBvSluQFebOYdL1pg29sWsLI
 crxPmkdHd+zexkOj0Fw==
X-Authority-Analysis: v=2.4 cv=RIq+3oi+ c=1 sm=1 tr=0 ts=69775d8d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=kysgKbjx-F3OzzsVwzcA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: XUPq8IWYDwwXEjLrPavbDtZ-7d1Vzy-B
X-Proofpoint-GUID: XUPq8IWYDwwXEjLrPavbDtZ-7d1Vzy-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260105

Currently the driver switches the vcodec GDSC to hardware (HW) mode
before firmware load and boot sequence. GDSC can be powered off,
keeping in hw mode, thereby the vcodec registers programmed in TrustZone
(TZ) carry default (reset) values.
Move the transition to HW mode after firmware load and boot sequence.

The bug was exposed with driver configuring different stream ids to
different devices via iommu-map. With registers carrying reset values,
VPU would not generate desired stream-id, thereby leading to SMMU fault.

Fixes: dde659d37036 ("media: iris: Introduce vpu ops for vpu4 with necessary hooks")
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.c       |  4 ++++
 drivers/media/platform/qcom/iris/iris_hfi_common.c |  4 ++++
 drivers/media/platform/qcom/iris/iris_vpu2.c       |  1 +
 drivers/media/platform/qcom/iris/iris_vpu3x.c      |  9 +++-----
 drivers/media/platform/qcom/iris/iris_vpu4x.c      | 24 ++++++++++++----------
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 16 +++++++++------
 drivers/media/platform/qcom/iris/iris_vpu_common.h |  3 +++
 7 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.c b/drivers/media/platform/qcom/iris/iris_core.c
index 8406c48d635b6eba0879396ce9f9ae2292743f09..dbaac01eb15a0e622e85635fddd29c1f7fc18662 100644
--- a/drivers/media/platform/qcom/iris/iris_core.c
+++ b/drivers/media/platform/qcom/iris/iris_core.c
@@ -75,6 +75,10 @@ int iris_core_init(struct iris_core *core)
 	if (ret)
 		goto error_unload_fw;
 
+	ret = iris_vpu_switch_to_hwmode(core);
+	if (ret)
+		goto error_unload_fw;
+
 	ret = iris_hfi_core_init(core);
 	if (ret)
 		goto error_unload_fw;
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_common.c b/drivers/media/platform/qcom/iris/iris_hfi_common.c
index 92112eb16c11048e28230a2926dfb46e3163aada..621c66593d88d47ef3438c98a07cb29421c4e375 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_common.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_common.c
@@ -159,6 +159,10 @@ int iris_hfi_pm_resume(struct iris_core *core)
 	if (ret)
 		goto err_suspend_hw;
 
+	ret = iris_vpu_switch_to_hwmode(core);
+	if (ret)
+		goto err_suspend_hw;
+
 	ret = ops->sys_interframe_powercollapse(core);
 	if (ret)
 		goto err_suspend_hw;
diff --git a/drivers/media/platform/qcom/iris/iris_vpu2.c b/drivers/media/platform/qcom/iris/iris_vpu2.c
index 9c103a2e4e4eafee101a8a9b168fdc8ca76e277d..01ef40f3895743b3784464e2d5ba2de1aeca5a4a 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu2.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu2.c
@@ -44,4 +44,5 @@ const struct vpu_ops iris_vpu2_ops = {
 	.power_off_controller = iris_vpu_power_off_controller,
 	.power_on_controller = iris_vpu_power_on_controller,
 	.calc_freq = iris_vpu2_calc_freq,
+	.set_hwmode = iris_vpu_set_hwmode,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index fe4423b951b1e9e31d06dffc69d18071cc985731..3dad47be78b58f6cd5ed6f333b3376571a04dbf0 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -234,14 +234,8 @@ static int iris_vpu35_power_on_hw(struct iris_core *core)
 	if (ret)
 		goto err_disable_hw_free_clk;
 
-	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], true);
-	if (ret)
-		goto err_disable_hw_clk;
-
 	return 0;
 
-err_disable_hw_clk:
-	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
 err_disable_hw_free_clk:
 	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
 err_disable_axi_clk:
@@ -266,6 +260,7 @@ const struct vpu_ops iris_vpu3_ops = {
 	.power_off_controller = iris_vpu_power_off_controller,
 	.power_on_controller = iris_vpu_power_on_controller,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+	.set_hwmode = iris_vpu_set_hwmode,
 };
 
 const struct vpu_ops iris_vpu33_ops = {
@@ -274,6 +269,7 @@ const struct vpu_ops iris_vpu33_ops = {
 	.power_off_controller = iris_vpu33_power_off_controller,
 	.power_on_controller = iris_vpu_power_on_controller,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+	.set_hwmode = iris_vpu_set_hwmode,
 };
 
 const struct vpu_ops iris_vpu35_ops = {
@@ -283,4 +279,5 @@ const struct vpu_ops iris_vpu35_ops = {
 	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
 	.program_bootup_registers = iris_vpu35_vpu4x_program_bootup_registers,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+	.set_hwmode = iris_vpu_set_hwmode,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu4x.c b/drivers/media/platform/qcom/iris/iris_vpu4x.c
index a8db02ce5c5ec583c4027166b34ce51d3d683b4e..02e100a4045fced33d7a3545b632cc5f0955233f 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu4x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu4x.c
@@ -252,21 +252,10 @@ static int iris_vpu4x_power_on_hardware(struct iris_core *core)
 		ret = iris_vpu4x_power_on_apv(core);
 		if (ret)
 			goto disable_hw_clocks;
-
-		iris_vpu4x_ahb_sync_reset_apv(core);
 	}
 
-	iris_vpu4x_ahb_sync_reset_hardware(core);
-
-	ret = iris_vpu4x_genpd_set_hwmode(core, true, efuse_value);
-	if (ret)
-		goto disable_apv_power_domain;
-
 	return 0;
 
-disable_apv_power_domain:
-	if (!(efuse_value & DISABLE_VIDEO_APV_BIT))
-		iris_vpu4x_power_off_apv(core);
 disable_hw_clocks:
 	iris_vpu4x_disable_hardware_clocks(core, efuse_value);
 disable_vpp1_power_domain:
@@ -359,6 +348,18 @@ static void iris_vpu4x_power_off_hardware(struct iris_core *core)
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
 }
 
+static int iris_vpu4x_set_hwmode(struct iris_core *core)
+{
+	u32 efuse_value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
+
+	if (!(efuse_value & DISABLE_VIDEO_APV_BIT))
+		iris_vpu4x_ahb_sync_reset_apv(core);
+
+	iris_vpu4x_ahb_sync_reset_hardware(core);
+
+	return iris_vpu4x_genpd_set_hwmode(core, true, efuse_value);
+}
+
 const struct vpu_ops iris_vpu4x_ops = {
 	.power_off_hw = iris_vpu4x_power_off_hardware,
 	.power_on_hw = iris_vpu4x_power_on_hardware,
@@ -366,4 +367,5 @@ const struct vpu_ops iris_vpu4x_ops = {
 	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
 	.program_bootup_registers = iris_vpu35_vpu4x_program_bootup_registers,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+	.set_hwmode = iris_vpu4x_set_hwmode,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 548e5f1727fdb7543f76a1871f17257fa2360733..69e6126dc4d95ed9e5fccf596205e84ec0bfc82d 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -292,14 +292,8 @@ int iris_vpu_power_on_hw(struct iris_core *core)
 	if (ret && ret != -ENOENT)
 		goto err_disable_hw_clock;
 
-	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], true);
-	if (ret)
-		goto err_disable_hw_ahb_clock;
-
 	return 0;
 
-err_disable_hw_ahb_clock:
-	iris_disable_unprepare_clock(core, IRIS_HW_AHB_CLK);
 err_disable_hw_clock:
 	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
 err_disable_power:
@@ -308,6 +302,16 @@ int iris_vpu_power_on_hw(struct iris_core *core)
 	return ret;
 }
 
+int iris_vpu_set_hwmode(struct iris_core *core)
+{
+	return dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], true);
+}
+
+int iris_vpu_switch_to_hwmode(struct iris_core *core)
+{
+	return core->iris_platform_data->vpu_ops->set_hwmode(core);
+}
+
 int iris_vpu35_vpu4x_power_off_controller(struct iris_core *core)
 {
 	u32 clk_rst_tbl_size = core->iris_platform_data->clk_rst_tbl_size;
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index f6dffc613b822341fb21e12de6b1395202f62cde..dee3b1349c5e869619c7f7c294dd711f9ff72b92 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -21,6 +21,7 @@ struct vpu_ops {
 	int (*power_on_controller)(struct iris_core *core);
 	void (*program_bootup_registers)(struct iris_core *core);
 	u64 (*calc_freq)(struct iris_inst *inst, size_t data_size);
+	int (*set_hwmode)(struct iris_core *core);
 };
 
 int iris_vpu_boot_firmware(struct iris_core *core);
@@ -30,6 +31,8 @@ int iris_vpu_watchdog(struct iris_core *core, u32 intr_status);
 int iris_vpu_prepare_pc(struct iris_core *core);
 int iris_vpu_power_on_controller(struct iris_core *core);
 int iris_vpu_power_on_hw(struct iris_core *core);
+int iris_vpu_set_hwmode(struct iris_core *core);
+int iris_vpu_switch_to_hwmode(struct iris_core *core);
 int iris_vpu_power_on(struct iris_core *core);
 int iris_vpu_power_off_controller(struct iris_core *core);
 void iris_vpu_power_off_hw(struct iris_core *core);

-- 
2.34.1

