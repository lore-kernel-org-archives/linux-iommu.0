Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3D353A97
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111000; cv=none; b=JRGU4kUr1t72t/w/90vZSG5U4vCluGACzpSSHbCRvyjeQx/zYVXZ0WRy9LNO/HHQwBFKfZxBZsOukTjrwfFBPKrwECUWgfSugVnhEf/SlOmrDcA6lKdDVL0sJFmOwzBXRCum/axURjrXFtL5QDOd0gt4K6CmlVaZyRKhBMSGICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111000; c=relaxed/simple;
	bh=wPn9MTeoeQW85931rm6TioLDv62uQ6M+ZoxoWxSWh3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFAIUBJohH3lEZ/L3T3jas4ClVP4tka3t0zCpjczo2wJgFxcx7FmRSWtJjBLWJqeYVY/xhS9NLiSOsfVZCaCOpj+ZZT+mLsAaCINfkWGFaWIWMgZokt0tmrpzFEZl3b+yN6UM2NbDu9tz8bNyRwFKt6e4MsCNz9G0eZpjunZaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GzQAeyrU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NGqupyaC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GzQAeyrU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NGqupyaC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPr0b1031312
	for <iommu@lists.linux.dev>; Fri, 3 Jul 2026 20:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Ewl6TyrZ/SLK7WpaVFEgmD0kq1oJXIxrfIN/wFdQXs=; b=GzQAeyrUtLWL/Att
	0BQGtN1jrzTo3PMxpYmNXjkP0hrCClkfQewZAXWIWWxjar8OD51Bd38B9gAe8W1z
	D9WqjaVyv3dEC1uk71Izsejfrma03HUbRJO8L3bUJwdJeJibdKzRV/Ra5BDO9IWs
	uXQKF8q1SKTXb/qI+Hz3JKMCpccz2ytTkp1c4SfdiLAJ+jaV5EMaBNg+Jxc4LtyA
	mbQiF85aF0mcSqVdK780tKeDjeK45dd8yvIN3QTb1wsm22g+OHDC73Kfy7ZCoRmF
	+dOU+6OBoHeh0ETKIAcxURhiNX2mqDqloLlkSr+myMny3zHBLPzPBegUcC3xzVAp
	/dImjA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5bw6f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 20:36:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9151bf6ce7so1128215a12.3
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783110997; x=1783715797; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Ewl6TyrZ/SLK7WpaVFEgmD0kq1oJXIxrfIN/wFdQXs=;
        b=NGqupyaCKIgy+NdWMmtksY687HPurHyRundfuYK0KZeScaHMr0vAeZe4nPEtrHcYH/
         x00Qn/QW+f4/GsAwhAPfgLTESdlaC+8S9QWivyzmO5uqK6lfFezYJ4v6DZFXjyGLT9/6
         d6ASSYauk4xBiniIZoPZwqa/5PbgFsCMHrSrRRE15Y5BwWmFe9BM3yP0aIGaUYcFz7af
         avzS4JvsmgoNtNNAJGuK5Q3nzI2RkQQ/hNL6VSE+M2xN7AcHQryPpglN+QC4C3+/YeD0
         wbPrqwQ5yMTgysNCq+Tn8S2TJYeI8+1Kd9b0MdqL9nvmXke/fBSDmoxnNxMX1eNJfpNr
         UsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110997; x=1783715797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Ewl6TyrZ/SLK7WpaVFEgmD0kq1oJXIxrfIN/wFdQXs=;
        b=AauPnT45s4zCYZHsIB+ulwP0AnM0vGthD2wBpdQoxx0bFaX5bC/9e5vzKVb/+eOIgk
         VteNVhJaRqu7LXlouKJxhYHKquYIFn8sK4u4Pri0RfAF6GoCbegsFdCTw2UdYyTbx0ll
         zZEtfTEE+oVqMXZB/8GNcNBHx0LtxF4T3uEkwBHUvv5g+J+KQDYMR56h6CHnDEZwr1p2
         afK3MMCdcutTNyW/BpxOwescCsTLIFhazttOMbxDbwgDLqZyfK9OHNw68r0v5u+SPocr
         tkVlfBKWs8DILxeLqEhNDQU/e+rtXfXWrRrsbWpaw+prRfm3PtIXwKgMJXbdmi+WfK69
         i82g==
X-Forwarded-Encrypted: i=1; AFNElJ/1ndXs0+Hhmu1yBkF+KhvQdsGLshFNYxCOXZ4yyqVmjek02flJ3Z8z4ty+168s8fC9cQKd/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0DSA8JNHr/krxtNDgIK6YM4ETHTr+X64S7KvMhxrZ6rX4v2we
	kJzDACeZXCUpZW0MXuKe7jDj4Bkp8NPFwmz5moMsSgpMGxRHe3tWU8EeDPsE2/65KvDTf/zHv+W
	m+zQuTUYYiaJhxe5j0SySiU5MegZkdFGQBZoAaxRNIRL+9GN9lNRx15Aal1YPrWYLuQ==
X-Gm-Gg: AfdE7cmbiorw+Vgc0VHKvgnvW1dEAKyIAmfiZPnB3vZHdqt0EgGsXwK6ZUhwUIFJ/Kg
	TjtYvbE2POSfgOWj7jHrzDT/gDFmSJvhddr0fTHtATpN7YE+NM5z4U33rmCb4UlY1iu85QluCLZ
	bJH+3SSC0GaZmt6y6g+tcePtkIiygxdapuQ0BTDoGK/SKFe4sIfEV83KJ6xh9aLTE283Uym79js
	LmlkpZ4fRbI7G+satN/l+adeyknBa2VwUrp4yRN9iycFogJFMiwq2O6JYuZbIvRifI8S06rnT4m
	PZpyRyHQsrH0lBixw6CVdRGqnBJL3+CRtwcl/khomTOHQZQHzFHQc0CpXRtJfsYan5QGCcdU+mT
	aItup0FPArmXqj1pPBYHNFWxAQIy0zb8+b4g=
X-Received: by 2002:a05:6a21:4cc7:b0:3b4:68e3:f16b with SMTP id adf61e73a8af0-3c03e3065c8mr805391637.25.1783110997147;
        Fri, 03 Jul 2026 13:36:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc7:b0:3b4:68e3:f16b with SMTP id adf61e73a8af0-3c03e3065c8mr805345637.25.1783110996652;
        Fri, 03 Jul 2026 13:36:36 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:36:36 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:35 +0530
Subject: [PATCH v4 9/9] arm64: dts: qcom: shikra-iqs-evk: Enable A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-9-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=893;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=MQlXtxhLQFtUqLHdZjGZifsTsVTh3ESNrqyekz7rOG0=;
 b=MzhVMhZap4fsAniWO3w2MNYPOUIaWxceqpeu98aHYIopN/QURKoMDWtY2N1HuWpigtKSVKySi
 wFaarKM7dXKBYN942TJzB1YH/LjyAJhqYOZLEi4us5GnzMYF3HTZD2L
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX7nTA/lXC9VHw
 9ui47tR82q6G5KjUrxzhx1SyoWXujOS1rlNMUczIFUsDg/T/Zmay5k8se3wh3MNca4JwBdLzAwE
 ObatmTV0oEqbzfSzoVV1L2RFoTWPHX4=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a481d55 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=C5heC5qkSJu3Z_QeR_8A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: Q3ZdzdHC7kj7FK3ompQYD0RXbmNIs3mV
X-Proofpoint-GUID: Q3ZdzdHC7kj7FK3ompQYD0RXbmNIs3mV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX2IHqwgGaU4V9
 xAjd2DPJ+SsZa3zuVmm0d9o3cObj1ih0X7apbdLoi0vYie6epeIiXA8Qs8WJI0itpgasCeyxPD5
 LZnuJAbTUQEMilPePczHZJwIBnQ6GMjPMHHu2xQPscOmu6A1Nul1gTxCj3/Ajum31u6rftbfPoK
 Wn9UCaDQ3hMzwIoDQmp8YjWZnT1VR/N9O3o07vuEfjGv0FYymytEMKb4TmGBn5ShFZTv2iyAq+A
 rvbC+eh1EGqwk5gEJKL9IQBQcBZ7zk/B/x1b+MA1sADDcuJmYJvDuEdA7tRwrRiB9FaoQhO6l/z
 moMrJ3lEvxD/Webvc2bHsVrlQI2+3WV1gr7P1GihDnJ4GMdGLNgVgAgk7NOfH0tYqvmJcUCrmy6
 vTwudRuZB0r1evsUEjNXVqw4f4U531MHayQgzW5RLNtMsZq13akbQHHaH5GPUwvoX++8q4+60r+
 pDF7D9YQzdg5vYX+ayw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030208

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Enable the A704 GPU and configure its zap-shader firmware on the
Shikra IQS EVK board.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 743979b5ed5e..b51aee19ee20 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -58,6 +58,14 @@ &remoteproc_mpss {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/shikra/a704_zap.mbn";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm8150_l17>;
 	vqmmc-supply = <&pm8150_s4>;

-- 
2.54.0

