Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADFA35674E
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238509; cv=none; b=CkLvdeCJ+lDx8Zifzsqfpg1yWJ9FbU3VvmO9+/rEJFbdijutDePS66zqqYYx1HD6XdYzW6lDmwZzEkBjPg9cFuj8uyQbjF3OkBt4ey/AUTGv9l4MFtjzNh1ckKh+L/ETrSbjJV47ka4m65AoV6OG32WjQ6GDfCZ09mcURdBcuWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238509; c=relaxed/simple;
	bh=vUUf0SFe8a51kmB8FPrJBDQ5H++K+t9n0PvwI74fWXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8bklC3+NJNV/WDHhEXsOlSApYcFrgz5vw3yXxlHQusho8Wf+2EVsob9Zk0NBHVG22bbAldwlRUl38YdWchZ7Eh3ehHHl7ZJTw2sMyajrp+eoryboo98bpnRIWE8f10zQXrNU9nUfumay2DUIj5doFWpTKieymiPq09ZWfDrNl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PWyX7gcW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jApNGKHy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PWyX7gcW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jApNGKHy"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664Mxg9f060306
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C4mB77oGh7s9Y0Uqowh6UFsEunZgz5Qm0N6N+M/Go50=; b=PWyX7gcWfCQdAu58
	F3T9QpQ04Xkrxc6Fjh+aetKsgundaI7nqojknAu9CE0124sk4c/XVlw5eg5wdWqh
	6KpnlnCGpvUdx/MUxSRYJuLaTbV11Dm3ri5JiPVD1ErN1T7IH0OqwCcxOPQNWpoJ
	eVPpPMQb+laaQchbR2adnAbxn3/UnUE7Ygc4iAGRCr3IhicamyKvNs+sjDa0ZQVX
	cHSPBMpOuVhAwswE7841nd/k5pymYfmSrxi+T4JiQcv1PafcexV1LzZhqiksWzyE
	ZW4hZhhBA2sEXaQWBAmQUi1BUhDeK2wv2uBuYmb0YuJmQNaqrbxCFw3BRgdVUWh3
	hl5eCQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh2d3a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:01:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-380b630c505so2423408a91.1
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783238506; x=1783843306; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4mB77oGh7s9Y0Uqowh6UFsEunZgz5Qm0N6N+M/Go50=;
        b=jApNGKHy/LcTvJkIMlAimxCBSL+yxVa/Y3jYrdJxttpcQAahcHHHXnp2NFNa62/EAE
         axpWvHJrDGmx/YlDPvRQSILBYnsPKlvAUGIU7IqIZEB12hkCQKMyij0O+y1KJj4239/d
         NSqH27b5wn+c3wb0ODNgAiDKiozvFrPQV5SWAPCq0ZQ3GsqGKtS0fnfzIhlZELx1ljwq
         OY0ub0AUh9rsv2mUBa5bVRnamal69iSYOpP3zGj31vwStqYjJJIlx8lEdIFVShVSY3ti
         oft824Hbqdjyqg8L3cdRGPEsaidwn6BIn8HvT4Hho4ZNwjeWVq0HuFtBFwhS86wn50DZ
         Ka4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783238506; x=1783843306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C4mB77oGh7s9Y0Uqowh6UFsEunZgz5Qm0N6N+M/Go50=;
        b=CGf6/QBAn9TAWT9cuoY5j4xDrHk5PHYJW+5yIbwAFcKSIFdg/+W10FWut+fNmQsVo1
         iBFLe6iQwl24YYsqUD6fHaQ358VWoqYCDPZWHryesydLTnTZJV0SBnYfXf8IsqVeFklU
         If4nykmSpD17ROKa4niKIPiXev28viym2Q2stRj/pgOgynJ43+put+xZrUar+9YkbA18
         xuqbX+CNKSOzABAqF+CZXvOlx78x+3QEb1AUZZsbcR96qdOtU8TdTXDtjpA6K6mANbrh
         R9ebAlALEtgBX8aYwj+xLP9hyaZkZC66SsD6EAuJOGWzeTG2y+XQvXTbhNJ+QzG0S5+w
         3q+w==
X-Forwarded-Encrypted: i=1; AHgh+RrZMr1V1zKhRkNVlsK2NYXmFYwwyQHoCzazIUTIR4fNGcPHD4QQaa8ChhLBqIFyJB35OZgrPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsX9o6fIXCOm/bITikpQtMdkfUBGZYafTkuZqNgbiXk+mnSexm
	5Q2PnnwvQxImmTJCCbbPfZvGDVToigit1Xobp7FQSG4GoobZXzE+3Z9ex3popQasUqfpJuymSh4
	IEUcCjTmAuH2GUKfCQDGW9oDTnBsU6yTd90Azjo4ljj1CYC5n6kC746SG1g==
X-Gm-Gg: AfdE7cniPMLGDwGHZ/SXB8boZV/VeYk0yHrx/xffLVgE4p05ERHq4VNZIuwjuIoTX9l
	6TwNYp0YR1+Dz6wdLMtt+MxLMp4wLFjm9g7ZpMmaoj6SVhygoU3P7NBz0hxpjjGuwotjtRVogLZ
	1a42H3+Pmx2QjucvbLJso8lvaRCmqQ0oXlcayCQlwulDeJ0E0ChFzkWUjtWiIWPqLM/j4N2Su3F
	sa1qeffJPhW+WsKy1HW5s2Kj8xmABbTvSp27WEwMik0dkzCXlVmRI1NZQMkuwW84AXZ21eflvsa
	d9rWBhuc2dm310EWVon7IAYGzvJo0f8rjjd8F8tSZBtC8N2hYaadpUSgKwQi+yzEiORpDrf5ZFt
	UmqiFlXl9BZovlNaZv5ZLbNarDKsjJ5SEQ8w=
X-Received: by 2002:a17:90b:3c10:b0:381:270c:4dd1 with SMTP id 98e67ed59e1d1-3829e656416mr5931288a91.20.1783238506402;
        Sun, 05 Jul 2026 01:01:46 -0700 (PDT)
X-Received: by 2002:a17:90b:3c10:b0:381:270c:4dd1 with SMTP id 98e67ed59e1d1-3829e656416mr5931260a91.20.1783238505896;
        Sun, 05 Jul 2026 01:01:45 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:01:45 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:11 +0530
Subject: [PATCH v2 7/8] arm64: dts: qcom: kaanapali-mtp: Enable GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-kaana-gpu-dt-v2-7-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=911;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vUUf0SFe8a51kmB8FPrJBDQ5H++K+t9n0PvwI74fWXs=;
 b=xiVpoXS8RMGK31dPCSwHTMfXAXe0kdMwaj2WE5K5tRhNxI6YaIAXwzIjirprdtrPKj3B6P3vY
 S0POanPFfdHCTa9ugRKkr6B6iwFsPGUorM72lzVY2AIYrw8NLJxCOQE
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4a0f6b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VHn1p_zO8-rooJRYzQAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfXxG8dXxAgJ+3x
 7qLw1qn4kvS2q2v61kwXEV77/5SpGuYR8lYdSXYHWFyGsux37ffvpXcTGr2r++F787xa6qnAj+M
 PSzzCZplpPECS+FwtO60behwTFW7Aigu945Pd2kcEij4iKJzHz/G8Hdz7t8JwEaGkVI9IsZ1J9i
 7a9TNV56bnQ4vaHIp2J+pLoCN6P6IO0kPpkrBR2kFnR+HZVqj+1o32nhnh19cCoH6oGJ+fWVWBU
 Vq9pVTkHEh9n2pOVo3KhYldACmuvMHCL9vl4n8fZx6zJSkhihemIukFWbCRXtoPKBhmkSEBc9Ph
 aogtj01sOfHQK/ZAJIKT2S5japVJviU7s1FQt6IhqTo5RNfXM2LHA1yLB6evWnxByHp4Rj73uBr
 rYK1fdUhR3PZAThOKqZ0rLBPQEqYJ7LiM59pxmUneClyL8BdKEa/qn0y4t135l9PFX8GRk2gGLO
 hK0tSs1Tzdy6j41MVUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX3qAdKNua1M8x
 RXyOERazeCTZo+LSKscYB3IYaEYT26lk7XxR2aTzW27h5l+R83rVE/T+6oNSXyYdoM88r0RPL4F
 Ee5Gk6cEpCVv7LCoJLbYHTvITz/295w=
X-Proofpoint-ORIG-GUID: 65KPU-pv-xfbmdQopydFzsUxfXrLNn9X
X-Proofpoint-GUID: 65KPU-pv-xfbmdQopydFzsUxfXrLNn9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050081

Add the secure firmware name property and enable GPU support on
Kaanapali MTP device.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index f9b5b5718b90..ba256039dd3c 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -865,6 +865,14 @@ vreg_l7n_3p3: ldo7 {
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
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";

-- 
2.54.0

