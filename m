Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F25239E80
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201550; cv=none; b=djd9opCD/0VsyySIVMQNfNvmCEYRqqAjhR5auMjyKgR1zOm4kL5ZMFJ1+ubWJ2+XLfT3pCZiWTYAeZg8hSueFz9h5LtA3ytM6z8nT80f+r+vusp7gzWCBWitp2OK18/lOW9ZWtjy+5xOOMpQ2HMmCy3kU3Dmm1Fxwe0lxGIcFHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201550; c=relaxed/simple;
	bh=4cpK+rYSKMeDiyBq3UdtWW7Lob7DBlHMDZuSeWAVS50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItcihTmMazGqVJB4vT2/eXzHHuV5gm1G4Ve2fsWHHktATUVOdGTop9e3CAnNLGTKm/t4ck7rbE5QIMGTFTJyzFmRSGEuTJnNMoejNtzfY3ojkGDVTX7RDCiH/YpIB9B0iTj7SHRec0vWu/ZgFauI0wNYMW3EgReiroaM+/+cr3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QbPqp2ll; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iCtb08IU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QbPqp2ll";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iCtb08IU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9pEit2404082
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+XJtZ8JERmoHl90VOho+Ves1mxqLVsGuyUf8eQ5EWEA=; b=QbPqp2lliuebePFr
	j1Pm47ToXDjuk2g9Uy8Tq0WQ6+LMO2fGnOA09rhk3UrD2qMSGpW0xjRfihzmJMUX
	ZLuHBPkVw96exgl7EUcfd0WWfIDiyqr6pmC29Q39idf7zrF/3fytdjXOEkmZ0/Ar
	0m9cjdG37S2TEgMVabnVp9RQPrQambmCaopQRKANBh8chzaz8YNVnA2MU3r0SDqJ
	zvCdDMPTEW+yg2hiYIOq3ni35KoAcj0+O1G4Nu5f3WHOREB5iB8V1L13MTA3W8jT
	71UJIvMzgFpglQ/tzNrM8lTW15aNtK/oukw5Zb7tl5VzG0AZzBtV9rLKWDQx0Cn7
	YGvkDA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjw23b1rw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:12:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aaf2f3bef6so20540895ad.0
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 06:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201547; x=1772806347; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XJtZ8JERmoHl90VOho+Ves1mxqLVsGuyUf8eQ5EWEA=;
        b=iCtb08IU/dUvakN21+CZ/8NMwsMOeWmB8EJibcbrAY38Z9PPuFT5QhWN6IQdTEh15e
         udqkNt1hpI6MwFwni++7t59nF+t3c8C13wuiYRky/ppcKEHAppQCy8BH8N6eQg5yeU4E
         /QgvSFhw37QIC25IRpr+kF7uYzwBjATuIlXV/ADrDRCja3D83aiNT4Ah0CXT1NtzLxo4
         OM3FUDRFq9Hn407ZNpHMc4YU4md14/aMP0d07P4kCJ9OAh3wFpq+p7ATLxzSvtWwueUF
         LqULn9OkOyecu4L0R2iOpwwo+4kgqF8O7wTatXDj4MWHDaRLD6NS4QPaxq09XJoY/NN9
         8TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201547; x=1772806347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+XJtZ8JERmoHl90VOho+Ves1mxqLVsGuyUf8eQ5EWEA=;
        b=UJFxHSNemhzfWQDC4pCgEkmrRNeBy/2iwcUxeCxYXDyFscVIyeje6TphfDD6kkE+AN
         FAuGa3pVE22DYtPZGBHqLrmL7W/Ua6rFukvmmbzKZUXqfECmbQDMnsGUyMJZQsl5+xlT
         KWQWsvNdVllM02V/srU8mq9OM9274/zm40jABQfMvekCkTQ7yCTP4rCGE28kUruwdwu9
         SmAAt6Tda0P2zX7bjJLqLrv42Uj38HijW+96h2oF/E+L7zGm5gpfzCczR/akPtCOKz2A
         TeEPKPb1ZqxwJu1T5vlIASCaEv1BQ9/xlWM1yg1NgVBy082TMI8qjJ5joQhEi03Myo6b
         3ZkA==
X-Forwarded-Encrypted: i=1; AJvYcCVOBzEdvsPme15kLBgb7a95Tvr64QUf5HH51vcazNGeIGXWqZsF48mA5MSdlmAghu+gSgQX+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx11Aadf4/0m0cUy6sq/pfFVVvsoEQI/y+RvPaMfNkRtB0/vHml
	Gjuo2HAtMD6uivetEUxVFad9GPNcC1JstoRS/SwUXra9cFacFCpTCRjXQwFYPyl2U4UXVgnRM/N
	+SokTjEGMueeq+4Z/ptROSuLfaEpc+izJ25CVPGmQDKDBe+dRWEtlKdb0EQ==
X-Gm-Gg: ATEYQzwfbXuINMlG9hEjLaXrzTsKhFq0V1jkJ37pEjnTK1G94MQmr0Dw+2rovADi8tM
	+YF/6c49bEnZfwXYPsu710iZpzKv0vVBGYFqGh+TW/X9KXRG3O2Jx7m6QzvNIjfe6nT/JbJyovi
	PElt1Dgt6+oyBCAyV7nhQAmYypLpIf1DzIUOBzK1rAAVcUrOofXAfWTu2Ur60TWipjumWhMQov/
	xdh74AZeHdkwwl6fbAUK/ENDqLplH02GcQj8d9mfy+w04l+8fbAolDfO8/tjl7GEZxUTXNvytxD
	Ul/d9n/p/fHamfEmpR9YoOs+mNJCGJxVmKQBpuiecycQy1ewwxq/DcABbKp+QFfCjqvL8L/QQDi
	Z74cWS1aca//Zq+znJSxk/avVLrmynTQqsrHF/wpU5iKWwHzUDhsPvLDX
X-Received: by 2002:a17:903:1ae8:b0:2ad:ba04:40d3 with SMTP id d9443c01a7336-2ae2e419166mr28838725ad.24.1772201546713;
        Fri, 27 Feb 2026 06:12:26 -0800 (PST)
X-Received: by 2002:a17:903:1ae8:b0:2ad:ba04:40d3 with SMTP id d9443c01a7336-2ae2e419166mr28838415ad.24.1772201546192;
        Fri, 27 Feb 2026 06:12:26 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c183bsm60960865ad.24.2026.02.27.06.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:12:25 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 19:41:22 +0530
Subject: [PATCH v2 6/7] media: iris: add iris4 specific H265 line buffer
 calculation
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-kaanapali-iris-v2-6-850043ac3933@oss.qualcomm.com>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
In-Reply-To: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772201499; l=4313;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=4cpK+rYSKMeDiyBq3UdtWW7Lob7DBlHMDZuSeWAVS50=;
 b=BUknAXG+k+86NFxEHwE9YE7QULGUx4cd71iL+7BDqbDgKfbc2uMwUqNcyto4ytlqfXZ6fLPuK
 Gw/mcauF2+yBXckzNPGrhfLNxiqFNOwzbiyamBwOk4QW+IJ4rbpEeam
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-GUID: -TVvNqO_MVz6I2bAY_i3y2quLiQAGI4X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfX4kwiHsk1Zz0K
 dlTMu5c+S/XV3OsvJL5I6Prn6Ipsm7aqQl7DbU6ISFrC1SrzvQyDYQNFZeN1g+lEcGzkVP+K49y
 pUXeasolcKxdBjIhRYJw9XJkMqg0flxz0NAe/qAVloy67FP4PWRibjdZfjdxkpC8YGSdAnKuKyL
 7qstJq5txgivKaSZgZP2RxgPO7R3u1/zifMR4wGI8BL1D/KmcfS+3W8mSNQ1HY6NK36RV4NEEEf
 0spIaQdUu+W2B30Qhx/aqwFOCONl2hRInBZPJaSVy9FyF5UIB0TPzLVU1NnolGQwmFoDLJiX4Yx
 xj3oRhGDOYSwN7E1Ex7cQHEaSjisSJJIam2xOVTL4TBzmtnFIP8D40s1PYUKQRjVbwfbJTHqz7g
 /mLvbtmqHfpU5aDQbLREiqvJKsWi2LPjOczxBbI/pwl8hmwb/R3TY0vuENRRKrfk9ag7OtFlMOR
 /72nclLLJwpO4Wb9yjw==
X-Authority-Analysis: v=2.4 cv=cJHtc1eN c=1 sm=1 tr=0 ts=69a1a64b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=MVHsPVnmqsIq8L41Ef0A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: -TVvNqO_MVz6I2bAY_i3y2quLiQAGI4X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270125

The H265 decoder line buffer size calculation for iris4 (VPU4) was
previously reusing the iris3 formula. While this works for most
resolutions, certain configurations require a larger buffer size on
iris4, causing firmware errors during decode. This resolves firmware
failures seen with specific test vectors on kaanapali (iris4), and fixes
the following failing fluster tests
- PICSIZE_C_Bossen_1
- WPP_E_ericsson_MAIN_2

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 51 +++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
index 9270422c16019ba658ee8813940cb9110ad030a1..a4d599c49ce9052b609b9cedf65f669ba78b5407 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
@@ -1755,6 +1755,55 @@ static u32 hfi_vpu4x_buffer_line_vp9d(u32 frame_width, u32 frame_height, u32 _yu
 	return lb_size + dpb_obp_size;
 }
 
+static u32 hfi_vpu4x_buffer_line_h265d(u32 frame_width, u32 frame_height, bool is_opb,
+				       u32 num_vpp_pipes)
+{
+	u32 num_lcu_per_pipe, fe_left_lb, se_left_lb, vsp_left_lb, top_lb, qp_size,
+	    dpb_obp = 0, lcu_size = 16;
+
+	num_lcu_per_pipe = (DIV_ROUND_UP(frame_height, lcu_size) / num_vpp_pipes) +
+			   (DIV_ROUND_UP(frame_height, lcu_size) % num_vpp_pipes);
+
+	fe_left_lb = ALIGN((DMA_ALIGNMENT * num_lcu_per_pipe), DMA_ALIGNMENT) *
+				FE_LFT_CTRL_LINE_NUMBERS;
+	fe_left_lb += ALIGN((DMA_ALIGNMENT * 2 * num_lcu_per_pipe), DMA_ALIGNMENT) *
+				FE_LFT_DB_DATA_LINE_NUMBERS;
+	fe_left_lb += ALIGN((DMA_ALIGNMENT * num_lcu_per_pipe), DMA_ALIGNMENT);
+	fe_left_lb += ALIGN((DMA_ALIGNMENT * 2 * num_lcu_per_pipe), DMA_ALIGNMENT);
+	fe_left_lb += ALIGN((DMA_ALIGNMENT * 8 * num_lcu_per_pipe), DMA_ALIGNMENT) *
+				FE_LFT_LR_DATA_LINE_NUMBERS;
+
+	if (is_opb)
+		dpb_obp = size_dpb_opb(frame_height, lcu_size) * num_vpp_pipes;
+
+	se_left_lb = max_t(u32, (ALIGN(frame_height, BUFFER_ALIGNMENT_16_BYTES) >> 3) *
+				MAX_SE_NBR_CTRL_LCU16_LINE_BUFFER_SIZE,
+				max_t(u32, (ALIGN(frame_height, BUFFER_ALIGNMENT_32_BYTES) >> 3) *
+				MAX_SE_NBR_CTRL_LCU32_LINE_BUFFER_SIZE,
+				(ALIGN(frame_height, BUFFER_ALIGNMENT_64_BYTES) >> 3) *
+				MAX_SE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE));
+
+	vsp_left_lb = ALIGN(DIV_ROUND_UP(frame_height, BUFFER_ALIGNMENT_64_BYTES) *
+				H265_NUM_TILE_ROW, DMA_ALIGNMENT);
+
+	top_lb = ALIGN((DMA_ALIGNMENT * DIV_ROUND_UP(frame_width, lcu_size)), DMA_ALIGNMENT) *
+				FE_TOP_CTRL_LINE_NUMBERS;
+	top_lb += ALIGN(DMA_ALIGNMENT * 2 * DIV_ROUND_UP(frame_width, lcu_size), DMA_ALIGNMENT) *
+				FE_TOP_DATA_LUMA_LINE_NUMBERS;
+	top_lb += ALIGN(DMA_ALIGNMENT * 2 * (DIV_ROUND_UP(frame_width, lcu_size) + 1),
+			DMA_ALIGNMENT) * FE_TOP_DATA_CHROMA_LINE_NUMBERS;
+	top_lb += ALIGN(ALIGN(frame_width, BUFFER_ALIGNMENT_64_BYTES) * 2, DMA_ALIGNMENT);
+	top_lb += ALIGN(ALIGN(frame_width, BUFFER_ALIGNMENT_64_BYTES) * 6, DMA_ALIGNMENT);
+	top_lb += size_h265d_lb_vsp_top(frame_width, frame_height);
+
+	qp_size = size_h265d_qp(frame_width, frame_height);
+
+	return ((ALIGN(dpb_obp, DMA_ALIGNMENT) + ALIGN(se_left_lb, DMA_ALIGNMENT) +
+		ALIGN(vsp_left_lb, DMA_ALIGNMENT)) * num_vpp_pipes) +
+		ALIGN(fe_left_lb, DMA_ALIGNMENT) + ALIGN(top_lb, DMA_ALIGNMENT) +
+		ALIGN(qp_size, DMA_ALIGNMENT);
+}
+
 static u32 iris_vpu4x_dec_line_size(struct iris_inst *inst)
 {
 	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
@@ -1770,7 +1819,7 @@ static u32 iris_vpu4x_dec_line_size(struct iris_inst *inst)
 	if (inst->codec == V4L2_PIX_FMT_H264)
 		return hfi_buffer_line_h264d(width, height, is_opb, num_vpp_pipes);
 	else if (inst->codec == V4L2_PIX_FMT_HEVC)
-		return hfi_buffer_line_h265d(width, height, is_opb, num_vpp_pipes);
+		return hfi_vpu4x_buffer_line_h265d(width, height, is_opb, num_vpp_pipes);
 	else if (inst->codec == V4L2_PIX_FMT_VP9)
 		return hfi_vpu4x_buffer_line_vp9d(width, height, out_min_count, is_opb,
 						  num_vpp_pipes);

-- 
2.34.1

