Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE928B4FA
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142883; cv=none; b=R3qwbWswkyCOXckFyO5FPV8mjVoBjGFlo7qUsuphKKo99CJi2a2N3QXP2dby9Jmv1wkjdsth/VzVY6HEuM3o7uDTPxiCsnEp/bPQNXEQR8kOqKR4LZaX5AI6v4VR8Bf0oY5ftHZ8eyq3SVuZya9ZSs+QiL8GeEQAM4e5JYKw2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142883; c=relaxed/simple;
	bh=5ySMykPzk0jhM/cJbb3bpGIddJLJdMtSMMqa/3res/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3Z4nCoymrYOL2hPZWu4HJh7G+ADC0f393vEYGDno15G2gii6zBLGN+BmzwvHIp3wQ0Tm0C0Vn5wfP8wL899IKXNtL1adCKV8gTp4xwoqCwqSIAlLx4RCH9wQhUcdkY5t4RfBy5Oh3bbN+8WUaWMf41b2ybWY8iAoecVhphKbkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MYuNv4k0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g40kJ6lI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MYuNv4k0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g40kJ6lI"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLCadj967261
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ea8Hsh8128gUo83L0ibHk5xC59Nj2dSzwKpm0AXSndE=; b=MYuNv4k0+Kn5hreq
	oldp9k8nShsugCoCA0y5Uy5SDugB5SoOE1xLq9Wa323GJQ3HbnG8TSAaV4/uKa4M
	WwDy5a00pUtf2MKl+EemNE0WDrVN2cmrAZdLSv4ueUmjf18azajpLeNuZEAcVzL+
	pDnpCkJZPkXBFhhWU9CTxEeQyPttPFvmtaiHToM28UxpZy94FmkE0pr/v+HNdtH/
	JF61gHVJANrxNjOIvuXpFIDtBBNQ02fvfU/68BSMrSbRRMQlUt7zAT5gyiKXPTUn
	kPH7rx4s6ePtN659gcaeFfE6w5jyDmSO6pqcQDyR/YNqVPWD16lpP9TChFQIzJfh
	g6q5Og==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86v11w5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:01:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b241be0126so100764895ad.3
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 22:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776142879; x=1776747679; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ea8Hsh8128gUo83L0ibHk5xC59Nj2dSzwKpm0AXSndE=;
        b=g40kJ6lI8rWHwnOD3LCXLz7n9oSX8yThEWLuPs6UEMaqKZyV7riOR1lVylrAuMkV/8
         azHdzZY/uLnxwRZDR5xkt5e40ChLE05zYABkVk/RBeWE3e7uc1FsNQKbNQJRqypp++gS
         p1v2aE9XVu67vxQt+54Ja9zP6L98mtMr+wXuZSI+dHLtYB/mXu/7n8digaaifDzCRwZW
         iDeTdCTwd1xBuIcg6CSqA5jsB0sMBJuf++Wg/vjcTo5PMH/KDyYe4ivYLxcmko9mBiBh
         VzaFS774pULw8mUW7j+2IS2Q45GkvtKp1N1v/aicEZzxGNGiia0I2K6U0RAU9N9MoESz
         1Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776142879; x=1776747679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ea8Hsh8128gUo83L0ibHk5xC59Nj2dSzwKpm0AXSndE=;
        b=gmzgLFtI3Uy4V6B5QGylJFM2PFjH/aX1/Jv0XTM8qcs3NHbn806MUoJXfZJ8Gk8Shi
         1f9CUi2O+LYCqTZ1GYAjejZQlv45zTgZkgkdVGzikpDP4o9urKMw0mn8MexSTgcqsOsb
         wQlTEtbUMg9uROyG5tP3OTxILpQyCVdZ1GqYTkyi6b4lkJMBH/4RdH67sNnvnU9Y0gLU
         0J9vzaEi87dhrGMTsZuZqX51F7WK1LsW6Kq9DG7au+rgVgwLv4KUHzorlaj9YlfKIi21
         j6O6GGwZYUhAvk/vIfchcxZrBmrug2ij++1qmm82OFFpo/vbWcU9q2mvkZ/ZlNaGh/sI
         OwZw==
X-Forwarded-Encrypted: i=1; AFNElJ92b0rsBvz30C+v0UQuUOC6oAwp8M3HfsX9m2Y1QeySOKOM6pSEAL+TlTjRzo2sAfpH4+s0wg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+kPazpA2ftKiteP7R4wijkejq3z9u8YJRJcB2KtzXjysO1Lax
	ehLZWM1jOgRZ6nyjjZjnoUGWbKfFXRkR9fyRfd4il3GITA4HrOfwQn7MBqxv8azL0obKDvbY0ou
	5WoF/X77UEHIvHcUCHvAZt8lZjgKOUxiGMuE8CAV+xeOCqNMhNd13ouykCA==
X-Gm-Gg: AeBDieu5YG/+fDWU7NIS9YDgrRi+XkNszIL/zf/h7lPeKqYik+mH8mm4SM8nGPJjpIJ
	Jvdh8VUQvwBUuQBDPLuoNJ+kqrsoE+Mfp1BxZe9MiH1AezQxrQrVfiVqBlLsmN87ksv4U5wIrnR
	/nTrmFZNdd0ok4WX5txku8o6cjPR1kttgj7JzGtu6Bogi97uJRIh4oHDnsRE9PLCcGzB6krgyNZ
	R+X27BRQ70tJoNZAkNit8smV2gzACW5v7z2X/jJ/EeUsJkgQvbTEQp/i+c2W7wgnQqRcKYSfTeK
	5M3hf2bkzYXrOfMVOKSeDr1VCR6BfcxZ5KcD05ceFedzft7fLqFjRPFWG4VAZfFu8XC0mQoOXXz
	tNSUoEgbqNEoN0M9pdKu1MO0/xfxjq0QErkOkXQLXvDJjCm/Nwfn7xc8=
X-Received: by 2002:a17:903:2f08:b0:2b0:5923:5194 with SMTP id d9443c01a7336-2b2d5a45e89mr172263995ad.27.1776142878624;
        Mon, 13 Apr 2026 22:01:18 -0700 (PDT)
X-Received: by 2002:a17:903:2f08:b0:2b0:5923:5194 with SMTP id d9443c01a7336-2b2d5a45e89mr172263515ad.27.1776142878015;
        Mon, 13 Apr 2026 22:01:18 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db198asm134678425ad.3.2026.04.13.22.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:01:17 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 10:30:04 +0530
Subject: [PATCH 08/11] media: iris: Add power sequence for Glymur
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-glymur-v1-8-7d3d1cf57b16@oss.qualcomm.com>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776142821; l=8863;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=5ySMykPzk0jhM/cJbb3bpGIddJLJdMtSMMqa/3res/8=;
 b=4VskDwawb9WrU696aGej5ktwjsaxEHq0LzEqCKYGp00JPxV2bdhFeejWIxvrzbur6vAep09WG
 TdXWQrD1k0VA21iKiH2k3aSW4YKPMERy+lmtz2FGgzSgXoJFYVdg2vA
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA0NSBTYWx0ZWRfXyI4TzkRl7/7p
 ZvvVRI9JP9j2yYOT9OkBOcEO5ilPB8JSAyugFKpXyMlREmmge7Wmx7GG7RqM773RS1sJ6UEM1H8
 macPEz50+wI3ON4xb68/G1vXaugmB1yL0Ibhqu2xCB+q7x7Bx4bFuzol0xO5+9jqzXHAu9wUF5e
 j20qc35W6v86tCAOD+HKAn74FAkaZj1Mmd24IrH6i1TOLq+7P5D99U/U2F+3qOKXz/5pIwFNAuS
 RwRK/oOkLDnhFcuO2LtUYfWdHd7bnm3f0Z91H8euyJJDixq35M5tTE5V/MinEUR3ibiZlsQA/LV
 qzuE5s+H+jHrICuRMEHlK+ALehqQ2zP8SikTWlDZLBiYZAhoqURYN2cvCxzukZNBRvyfkBsbVKJ
 7DQuFh1UZEa2tx3W9os7rYhAZsto9vzoYZMCJhjLve6c1s71Sdcd7NdZjwLX4c6mz6PsIMobKyZ
 DE3qcBvCPkFw3P2iB0w==
X-Proofpoint-ORIG-GUID: 7L-s_8oDQgnaj1i5SEJMo0ODKdfBCoqy
X-Authority-Analysis: v=2.4 cv=Iowutr/g c=1 sm=1 tr=0 ts=69ddca1f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=bPOwoyL4_xgOU_rvejwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 7L-s_8oDQgnaj1i5SEJMo0ODKdfBCoqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140045

Add power sequence hooks for controller, vcodec and vcodec1. reuse the
existing code where ever is possible. add vcodec1 power on and off code
separately which has different power domains and clocks.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      |   9 ++
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 123 +++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
 .../platform/qcom/iris/iris_vpu_register_defines.h |   7 ++
 4 files changed, 140 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 30e9d4d288c6..e3c1aff770dd 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -61,6 +61,9 @@ enum platform_clk_type {
 	IRIS_VPP0_HW_CLK,
 	IRIS_VPP1_HW_CLK,
 	IRIS_APV_HW_CLK,
+	IRIS_AXI_VCODEC1_CLK,
+	IRIS_VCODEC1_CLK,
+	IRIS_VCODEC1_FREERUN_CLK,
 };
 
 struct platform_clk_data {
@@ -208,6 +211,12 @@ enum platform_pm_domain_type {
 	IRIS_CTRL_POWER_DOMAIN,
 	IRIS_VCODEC_POWER_DOMAIN,
 	IRIS_VPP0_HW_POWER_DOMAIN,
+	/*
+	 * On Glymur, vcodec1 power domain is at the same index in pd_devs[]
+	 * as IRIS_VPP0_HW_POWER_DOMAIN. Alias it so that the Glymur power
+	 * domain table is indexed correctly.
+	 */
+	IRIS_VCODEC1_POWER_DOMAIN = IRIS_VPP0_HW_POWER_DOMAIN,
 	IRIS_VPP1_HW_POWER_DOMAIN,
 	IRIS_APV_HW_POWER_DOMAIN,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index 1f0a3a47d87f..3f269f242b36 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -27,6 +27,16 @@ static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core)
 	return pwr_status ? false : true;
 }
 
+static bool iris_vpu36_hw1_power_collapsed(struct iris_core *core)
+{
+	u32 value, pwr_status;
+
+	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
+	pwr_status = value & BIT(4);
+
+	return pwr_status ? false : true;
+}
+
 static void iris_vpu3_power_off_hardware(struct iris_core *core)
 {
 	u32 reg_val = 0, value, i;
@@ -261,6 +271,111 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
 	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 }
 
+static int iris_vpu36_power_on_hw1(struct iris_core *core)
+{
+	int ret;
+
+	ret = iris_enable_power_domains(core,
+					core->pmdomain_tbl->pd_devs[IRIS_VCODEC1_POWER_DOMAIN]);
+	if (ret)
+		return ret;
+
+	ret = iris_prepare_enable_clock(core, IRIS_AXI_VCODEC1_CLK);
+	if (ret)
+		goto err_disable_hw1_power;
+
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC1_FREERUN_CLK);
+	if (ret)
+		goto err_disable_axi1_clk;
+
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC1_CLK);
+	if (ret)
+		goto err_disable_hw1_free_clk;
+
+	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VCODEC1_POWER_DOMAIN], true);
+	if (ret)
+		goto err_disable_hw1_clk;
+
+	return 0;
+
+err_disable_hw1_clk:
+	iris_disable_unprepare_clock(core, IRIS_VCODEC1_CLK);
+err_disable_hw1_free_clk:
+	iris_disable_unprepare_clock(core, IRIS_VCODEC1_FREERUN_CLK);
+err_disable_axi1_clk:
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC1_CLK);
+err_disable_hw1_power:
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_VCODEC1_POWER_DOMAIN]);
+
+	return ret;
+}
+
+static int iris_vpu36_power_on_hw(struct iris_core *core)
+{
+	int ret;
+
+	ret = iris_vpu35_power_on_hw(core);
+	if (ret)
+		return ret;
+
+	ret = iris_vpu36_power_on_hw1(core);
+	if (ret)
+		goto err_power_off_hw;
+
+	return 0;
+
+err_power_off_hw:
+	iris_vpu35_power_off_hw(core);
+
+	return ret;
+}
+
+static void iris_vpu36_power_off_hw1(struct iris_core *core)
+{
+	u32 value, i;
+	int ret;
+
+	if (iris_vpu36_hw1_power_collapsed(core))
+		goto disable_power;
+
+	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+	if (value)
+		writel(CORE_CLK_RUN, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
+		ret = readl_poll_timeout(core->reg_base + VCODEC1_SS_IDLE_STATUSN + 4 * i,
+					 value, value & DMA_NOC_IDLE, 2000, 20000);
+		if (ret)
+			goto disable_power;
+	}
+
+	writel(REQ_VCODEC1_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
+				 value, value & NOC_LPI_VCODEC1_STATUS_DONE, 2000, 20000);
+	if (ret)
+		goto disable_power;
+
+	writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+
+	writel(VCODEC1_BRIDGE_SW_RESET | VCODEC1_BRIDGE_HW_RESET_DISABLE, core->reg_base +
+	       CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(VCODEC1_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+
+disable_power:
+	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VCODEC1_POWER_DOMAIN], false);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC1_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC1_FREERUN_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC1_CLK);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_VCODEC1_POWER_DOMAIN]);
+}
+
+static void iris_vpu36_power_off_hw(struct iris_core *core)
+{
+	iris_vpu35_power_off_hw(core);
+	iris_vpu36_power_off_hw1(core);
+}
+
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_on_hw = iris_vpu_power_on_hw,
@@ -285,3 +400,11 @@ const struct vpu_ops iris_vpu35_ops = {
 	.program_bootup_registers = iris_vpu35_vpu4x_program_bootup_registers,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
 };
+
+const struct vpu_ops iris_vpu36_ops = {
+	.power_off_hw = iris_vpu36_power_off_hw,
+	.power_on_hw = iris_vpu36_power_on_hw,
+	.power_off_controller = iris_vpu35_vpu4x_power_off_controller,
+	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
+	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+};
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index f6dffc613b82..99e75fb4b10d 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -12,6 +12,7 @@ extern const struct vpu_ops iris_vpu2_ops;
 extern const struct vpu_ops iris_vpu3_ops;
 extern const struct vpu_ops iris_vpu33_ops;
 extern const struct vpu_ops iris_vpu35_ops;
+extern const struct vpu_ops iris_vpu36_ops;
 extern const struct vpu_ops iris_vpu4x_ops;
 
 struct vpu_ops {
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
index 72168b9ffa73..37f234484f1b 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
@@ -7,6 +7,7 @@
 #define __IRIS_VPU_REGISTER_DEFINES_H__
 
 #define VCODEC_BASE_OFFS			0x00000000
+#define VCODEC1_BASE_OFFS			0x00040000
 #define AON_MVP_NOC_RESET			0x0001F000
 #define CPU_BASE_OFFS				0x000A0000
 #define WRAPPER_BASE_OFFS			0x000B0000
@@ -14,6 +15,8 @@
 #define AON_BASE_OFFS				0x000E0000
 
 #define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
+#define VCODEC1_SS_IDLE_STATUSN			(VCODEC1_BASE_OFFS + 0x70)
+#define DMA_NOC_IDLE				BIT(22)
 
 #define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
 #define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
@@ -35,6 +38,8 @@
 #define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
 #define CORE_BRIDGE_SW_RESET			BIT(0)
 #define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
+#define VCODEC1_BRIDGE_SW_RESET			BIT(2)
+#define VCODEC1_BRIDGE_HW_RESET_DISABLE		BIT(3)
 
 #define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
 #define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
@@ -52,11 +57,13 @@
 #define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
 #define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
 #define REQ_POWER_DOWN_PREP			BIT(0)
+#define REQ_VCODEC1_POWER_DOWN_PREP		BIT(1)
 
 #define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
 #define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
 #define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
 #define NOC_LPI_STATUS_ACTIVE			BIT(2) /* Indicates the NOC is active */
+#define NOC_LPI_VCODEC1_STATUS_DONE		BIT(8)
 
 #define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
 #define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)

-- 
2.34.1

