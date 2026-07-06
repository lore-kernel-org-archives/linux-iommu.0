Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A747ECCB
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374105; cv=none; b=O5c69pHB627E11b0O13jNVVelF3Kd/1a/Z1gtGjlXNZ47I8dNvP0VaMej00cEKWhKwzhWQt2Ti4bZjrdAyIlvC2gQtD/jFowPwsc4fgwgW+r6zeLAK/hZVRlXUTrHqt6lF5kaxHkkcye3MLgPjWGnnxhgwIzVMdGbD4h+VTLCHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374105; c=relaxed/simple;
	bh=wcNtHiPt37tRcLONgZr/t6X+o8Dp6m14w6rdasOzENQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhAfuF3Q4Y1Dqr8RfLf/hp3AhXK7IcCcj05w9cRQnm7/I2sZdLm5/Wk6h7UiLVmcbczLXFt4Dmx7EMbeB1GtykPTDclsceY+jwpcG0mN/yiVoOZKZ4mtH5dYpxZoEQyXQYvav9Gd2qsc10t55cn3Ng0Xb9+CW7L2jQCRQboakew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o/HVbnMK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iz90qJMm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o/HVbnMK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iz90qJMm"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KE4b11626316
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kJCEGFaL2BWb7t2hrhNOF7E5Nh+JxpjT/H4VU+ffr1Y=; b=o/HVbnMKBfWdPeGE
	YfYaoyoYMuON7hNNIrCJ4qeYkqm+0GAX0x95cvU6wFADsAFvB14Fg7zY9I+x8Kr8
	joP6cPJGyqRiA2M8kFUUJFkdngGFLDD/FbnO5iF12K0FrpsN328ZKuLdRNaAmppE
	Lk5BNaJEPm9ZNgfYqd28qCKnJ0VssVdquZ3ULhDf2f7u2NutjYXufb0qeY0r7OfO
	2SUgzOKo2bCWgmJUOh94Qae41HHid8+OyPNjuFM39zDUfO6vkNyzabNEfS1CXJ3A
	wnVtwXbhmXRg9vnusIQ0vIjuEzzoi3Vv/2JBOXKeQS9Scbm+TNTayATWFB55E2Ua
	VJnhZA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bg0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:41:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so2973412a12.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783374102; x=1783978902; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJCEGFaL2BWb7t2hrhNOF7E5Nh+JxpjT/H4VU+ffr1Y=;
        b=iz90qJMmj4xjdvP6lVlg59G0sYbuHAzoIen0DXwiy9OgEs5/0YGUG/xznZD4Unk7yh
         RmTCqlVVnJQgxqjZXCaFL9bnCh+VI4+cCnRV0lUhL6f794sVLgYP3Fg43ibtsKdDf8Wy
         yS8TH/t0rA/NWfBLYSs4Y7npjJ3SRi79k68LEQFZNfNikOY4mt+NQCD6zNOJygfik2aB
         xHPLaN23wt/73qqgqztc7oN2Hg2ysoXowyBYUVsBnw8H2jPXNCC4/i1/4jCLC/vLyEYa
         JaiI/BwZ8wpu0OCz26YPYVji0kvyq+KCXbfo8aBrD0sPq+zDBkkgbPGhAEuglhCNDvFX
         sI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374102; x=1783978902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kJCEGFaL2BWb7t2hrhNOF7E5Nh+JxpjT/H4VU+ffr1Y=;
        b=XKNFVX39oPpB3+AJWFSpic+VY4AoDxBxWwFyDynMgOG6nUB9ysOQp44JmNrcSHn4Hp
         eZgrj6kQH0B46RWcK7Bmu48FqQCyJQnnUgWxdyxXbd2SWkayMbTYIM33HLOFxqNxKp9V
         BU7WhfQ58L2N9BhkXqilVUJSzKAf1IBBAU7Vv5z5+wAfda0fZDJWNqzszhXt2fuyxaLk
         SE/XJhrBmJmz4pjjDjlumBwRM81SD9Ialf+l0YMi+Zxp7AO+E3ymGLxpEM1MtVcCsshM
         DHUnwaWhaOsvpVNg7qzS5YTqwubZCeU0TC+RAAJif1z78Yo4QyT9i5QqGl/ghrJM3Pc2
         clnA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1Uvx9gBJJbtgjhtZ9Kfr66dppu58tFwcjJPdX7NIw6tNle2L0pCK80bJncogCBGM1S70tPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzo3XQDqjsdCsj0C1DPqC9krC5jM/FlkdDQbv+tcJxM7KEz8MoH
	4j45vFRyErlWlfiBj5q/G0nOG2s0YHrafgO6iCwEMgY8OWqbGjnrgy2aq9VKShAkklUbXqxKwov
	S+e93StIeHqMy64k4XLVVr62zgkrrkIdHm8/wrQX9smSxlx/YZbpQKbXufA==
X-Gm-Gg: AfdE7cmW6zpE48gtjuqBhStQ7R3pFNrWSGSknbCe8YwwFhlne9Er78j3tQbjZyq+pRt
	CnZYRg/xzxoZxvBaNVz6rHJ5oC7wlIt3C9d9scVQ2D3+S/Ci2JjSGpsW3rfsBBYU3rEoGS+5uAJ
	CxKwxpUSHVGh0i6lk7YvBDSBfFEgPK0Gt/kUsBSh9OA17by1jQGTm9Dr0479sKaOiYZHnamEME+
	6sCm9LUUsUAq/aaV8sR9IbUdBzvnaRGz+FJlidoFTrulSjNEZv31Q/qvly89Q+0g3mCGYv3DFCG
	3NIp2Ysg8HLW3dBF6OuTM4OW9jAddmx2l2fzbwHMnhq5DlhyVxsYCyZiDrMNhsswzfQTtqfVcNv
	jmy+tlDS1kOhbaDbvGN9/AUF5LOEyfggtdJ4=
X-Received: by 2002:a17:902:db0b:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2ccbe6134e8mr22172775ad.13.1783374102112;
        Mon, 06 Jul 2026 14:41:42 -0700 (PDT)
X-Received: by 2002:a17:902:db0b:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2ccbe6134e8mr22172395ad.13.1783374101635;
        Mon, 06 Jul 2026 14:41:41 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:41:41 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 03:10:25 +0530
Subject: [PATCH v3 7/7] arm64: dts: qcom: kaanapali-qrd: Enable GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-kaana-gpu-dt-v3-7-8dac9a60dd5c@oss.qualcomm.com>
References: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
In-Reply-To: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=851;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=wcNtHiPt37tRcLONgZr/t6X+o8Dp6m14w6rdasOzENQ=;
 b=/vxFPiWhExDAZrwWpa9l5y1Vh5+B3MHCEDcTetW6Rnsi8OF+RTcQYPZQUwPmK0SL7uCCDX+zC
 BZENeY9M3FPA6/x/6kAZHbvTkjGW6EySXdhiV8xYjlk/ovPvpLvmdhJ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 5grqlW6INUP8wf8gxoxgq-YVPVa0U4Wq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX4dxeJCX828Tg
 7POBFNUj4fpx9U/TXkEJZoxaE2foDUCwIYHTV5ftCxN3cmOG+K3Xxf0+KQRhCKC4xZlHwlW83lr
 snTIImYLB8R0Dhd8BrbT2FQElNQNjH0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX2G1niQX12jL5
 U4Re4mAWUWFsDwOqdeC/rPzjbFCYub8DdbgjRFP3Gs8NbJskDaNypWu7TxUHz5CyY9jQSikv+4L
 M3xlar559rkdYeuvgwTjNn5DQ3eY4s/WhWvGnZoE4dFQSR6HvFn6tt7n11W4KKY7TjXYO7szrSR
 4YZAndXIvFQG0NngHhVBRHDQo0BqxQNGmCFW0nu/9jZd+Vj0YQpQI+sWr9AuAlwoMSmksQ4RxEX
 AJUI5xglL1yAd4ez7bX6/9xs9Vyjq7A+gQiYjwcXCz6sbkfOQw4CecbMaAt6e69jrvuncxTQvKj
 62e1PbuOhq8ZCXjwveqYw1r1uKllJec6iV7APHsufRD/7xaGgPZDOIQQHtNki8bCyO0nEvag8g8
 tMmUgQT4q5aE+myImVF0IVhxxXgAfko0JUQOXCMQlTIXgZZVcHOeVOAydzpTfxaMn9D8vq5SeLj
 WrFFb79P/Vbs9sgu3pg==
X-Proofpoint-GUID: 5grqlW6INUP8wf8gxoxgq-YVPVa0U4Wq
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c2117 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ckKq4DLX54o5ySWhiFgA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060218

Add the secure firmware name property and enable GPU support on
Kaanapali QRD device.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
index 55d02219ef4e..6bef8ec151f8 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
@@ -693,6 +693,14 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
+};
+
 &pmh0101_flash {
 	status = "okay";
 

-- 
2.54.0

