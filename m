Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6632E137
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408049; cv=none; b=B55gYRKNoxMlAq6dvF3ILkryYL+vXIkqRMS6iFlVy9gU8Y9KxYgKZbXNu7zXn2es1OwPmP+grBMnf4OqfenjqGT8RsAGHxiMRrgAoyhYvcMVoycodnP/FcSrsKHCRQGT28qE5Jax4OYlHz2A6BEVMJJlGNPOwzldnkrvTE/arRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408049; c=relaxed/simple;
	bh=4cpK+rYSKMeDiyBq3UdtWW7Lob7DBlHMDZuSeWAVS50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSvB4CPpR51RFuC9p4x4fEMnrfiDIr1tjj9caqJSkhb90YV7PAvtOjqrZtr22oeTgG4qUVK/XZoa+GctvxWdD5z1fxheVHAIT/vB6Zxn2xyLEvLQPWVBUH//L2fgqh0v7/bOdR60qcvmrfLOh6+pt9QPWqDJ4dEufHdk34uIHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f5tjYT0i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QMMY/Nyp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f5tjYT0i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QMMY/Nyp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D9B8uZ3906329
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 13:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+XJtZ8JERmoHl90VOho+Ves1mxqLVsGuyUf8eQ5EWEA=; b=f5tjYT0i8mmhD4cZ
	+ctPemXVYi12YEPcf163V3xtBrgo4Dl/5tlIpNn21Q31Vu8OJyHX0uy1Sy8dg+VH
	CIYw/K3/zqfA5nCGpgX3aZBu+0ofHVOZRkFh+8CYRmz8YmUmtYMAFOtjgV836CBw
	/5u1Kf6kOGUgtf5TrtzDb0rYVMZilaqv44fmq/q8ziyBhwUpVJxqUM0GZX031cO1
	aEMrid8jmItvCep/FAp6JfkYN7dyMdUox9BMm8SkqbJTAxW1JEi7HMGC6g33SSy3
	AzX0PSlTkSI81RTwLRNtqEuBK81ifQ1dtQhR9BQzbM8s2PRB8Xki0w2CHz0rrUSH
	Mqhq/Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvfqs8sd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 13:20:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8297d261a67so1031760b3a.0
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773408046; x=1774012846; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XJtZ8JERmoHl90VOho+Ves1mxqLVsGuyUf8eQ5EWEA=;
        b=QMMY/NypdLPyCjRZlrsI6jXiVapBx+s+boxwJqmrnoyGrWmmGkkZF+OgUTIFrpSp1a
         5pFcPW7yZAxbQT9rH0bcZJLOXnYLKD035VhRkAL07PBM8eb8lmZGbuRBrLCx0KEP6r/T
         Ltgd2U+wT/A0FJScwW1pQbdVX7bd6Qy05KGC9uL3lUXsgnFP75LzeHKgOSnHJFV9AHRM
         1QIxP7vEkpn0RJ2tTVI03stBJRnCOXzAIjRU6uzlLsBx7nmYS5eH+idBKlOs0jq6WVBW
         UYnZDH71KnFzMcEYs1ycq9YrftVHCovSJAyjxz4Yi9reRkEUdI9jJILf9X0e8/7AKmrz
         hipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408046; x=1774012846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+XJtZ8JERmoHl90VOho+Ves1mxqLVsGuyUf8eQ5EWEA=;
        b=eU0BTyofZtIAuNxOBlzcBeZ4/j/HT7aLMTGK0DfTg0q6+mCI03Wq/7IhPp1wQ7oO6V
         qpOnUdNmwL6tPM1TB7AwQljQSQE/d3M0A2DKR1P3Ik3/vvrAgwJBZnRJNR7ylWT4TmSW
         me+M8WL0xKE1AE74IT3RGGGIdUYiIxVlSQ/vrqoNIaMtHYM71DC6eyXJLtncFI65TqIv
         67qZqaedzmIxucDt3ZQf4MBxHrp4YJWaYxlX6sJqYPIIKZpfqFiUWBJnyGKN9Ir66I5n
         ARcNpol3xAuQFmBATaziPIWUIrpbITs90MVlE/VBuJtllSd+RKKCpke3O5J3azoHtf1O
         l2OA==
X-Forwarded-Encrypted: i=1; AJvYcCWMEO4MPR4upWUSoXeA0PCVIzCfYJ1lMQy2njBS5HOb8t4ii/Qry9u3KbHtcPUzzX7I0AD5mw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxibUaegriiDNzGduTv4MlU+iVCbfbAk8Flzs3+q9d3OETZJQT8
	2TvM6YFHrjJV3zBY/4guBq7hPFz/Ur4gWV6HbXKUDTsYLNGRNv7OZXFkcoC9HHc5yoYJKR0FYgY
	f7pwP1Lf+w22TXps1Z8W0FrFQeillfuPoz+NT23FgV8Kqs+mx6kD0o0oSuLyXsr1IVQ==
X-Gm-Gg: ATEYQzx0AdM138LhgKRT0yW92K3kBZpQhbHMxm2N37DMaa/vMU4SMEEPj5zPvrQrPOJ
	XtmJNmMfJchthYW0NhQ5l2CrDuhs9XXbTEgZONqohyXvLLg8Xm/QV1DgkP5UscsYI/wWN3l1mep
	21KKQCt0fl4vZgRNYy8mm9SCiYgreF1U12kjC1WV9gpj3PC0C+zKf29Bt6f/XToVANMVSO9fA0Z
	OHlKZGJ43kYdYrUkKUloVbuxMCQ3XmZzMolKBvbY4B1TgSL3J5dCD4BACJNPKK5ZIs3KTc5c2CA
	dXhMkYDe0A1zQuxMA7AdIrnTZBbZ9NWMGMoJr6WdeR/ORA3sivzvMDHIBXHnWVzI3nn3M96q0/I
	xCPJxNAQLokmJT4V1au6ZneafBQe5g0M0rGJWFl3sqhN6XeyHGRz0NtuD
X-Received: by 2002:a05:6a00:94e8:b0:829:6f7d:3093 with SMTP id d2e1a72fcca58-82a1990bcb8mr2879866b3a.48.1773408045711;
        Fri, 13 Mar 2026 06:20:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:94e8:b0:829:6f7d:3093 with SMTP id d2e1a72fcca58-82a1990bcb8mr2879816b3a.48.1773408045070;
        Fri, 13 Mar 2026 06:20:45 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0724407csm5775254b3a.8.2026.03.13.06.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:20:44 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 18:49:40 +0530
Subject: [PATCH v3 6/7] media: iris: add iris4 specific H265 line buffer
 calculation
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-kaanapali-iris-v3-6-9c0d1a67af4b@oss.qualcomm.com>
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
In-Reply-To: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773407994; l=4313;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=4cpK+rYSKMeDiyBq3UdtWW7Lob7DBlHMDZuSeWAVS50=;
 b=kPpvlinusoZu/UwTxqT8WAUNw2mdn3r4dPJcxzKn143eGjy/VdW0j3HptWkRtMAdt0E6ZUBRG
 WlBPThAYLuzCMORnp/lP/eEOyPDgscnD6qn8TOS/vgzo+ZufJj1jORT
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: ENNiNSkGCeZZnnDzh9icEjNeQ6S56r37
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwNiBTYWx0ZWRfX48gkzAD7umTU
 c2gjkRzMOV3ZRp+XTvOXJB48rNe6zjnHVSlyMWKc817wJPmjBp+wf06vU0tFWLQnfvcpba0lkKe
 OnJN9L5hOUvfMkpDy4tCnMUvuvvvFaF7UBWiRpEZ57nkIBmV9brbb7B/SF4diy5ZnYQKvnpwOhM
 Xtr9wdIV5hUEvdFruzpJ0UtRZF9fhRPskujXUa/QgTb80LGYxJWo1Y0aM2uZBbSrFhiF5yiwcAF
 k3lJptZnBmV0Fe+U8DLuoOTZs1KxBCwH05f+O+L6a51k/85iQXHg1jzcKkbCg3S74B5NN7DS+Ly
 nxWSnqtOoR9dmezaHl1PB44yEtAv7A05BqMO5HsvfJ9QhNJqUf5GJqqANmIvgs1m8dtIFMBkCYn
 C6UtsylP3mbeaMYDz4novKqNtdvW6rmIZpP0+aWLngV84kZjB9FyPmsLfYc3rkr9nNBrkvUg2mn
 CDLu4Vbz4iLFiMYko+A==
X-Proofpoint-GUID: ENNiNSkGCeZZnnDzh9icEjNeQ6S56r37
X-Authority-Analysis: v=2.4 cv=GoNPO01C c=1 sm=1 tr=0 ts=69b40f2f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=MVHsPVnmqsIq8L41Ef0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130106

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

