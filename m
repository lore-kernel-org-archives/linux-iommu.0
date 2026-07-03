Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06F354AE3
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110993; cv=none; b=jMNuEenhlNvGAp4yPQ0K9e70x/qD3VHsXvcqWxAkgzsT2ujFbqozSrEyB52lVxes1aSctoDkeG6QwZwlsD+x+oVpZXpC2nnCIuX+Hb5hRh/yfidpODET6C9Zo0Poyi8cSlVHzC7SxhMIbF+xajqAQQNRYWfBbMmW/CADT6wsxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110993; c=relaxed/simple;
	bh=e7loczfllL/pumoewaOymYiokr/D/1bSGb//+r4vM0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A39IA8WgmQ2elu3Le6t06Beo5AvNzfMhzDtBHF7G5oj8cFvo2nAwRINFzWlPzMg3uxfxW4LeEuh94DODxrS6aBBT0sf1GI1ifK/6pH2X9NESQtPpechASMNMrIN8BPGHy5KjMjzr+PUukNcShcQJJAGBUMVv1HMgc/eESWNEap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dveUoURl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CQ1rZq5x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dveUoURl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CQ1rZq5x"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPRRu1005362
	for <iommu@lists.linux.dev>; Fri, 3 Jul 2026 20:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I3Mr60y0+dO9JKpcFRd8+KSXVcXHZQThl+NbZHMGx/E=; b=dveUoURlYPAM5nVI
	5PErai44qS1UMMuNlvsWX+1GcwixZE5ClKW2MidRZEDujcUNX5k1DLccb/+8ixjm
	4Knjeh7HodckZpt8JkQIn+WOG97zt171QbUAn3uQjZ0fTK1QZ6wE26QuxLFBRoTx
	ZHL0QxBC1J7naXn7Xq7c6EuQpm1tmTI4BzNVDIUAhPpKDm146kTkisdrRoA2rGFs
	W/ziGpTcnX/Tovv8XR800cxXvTp38Kp7ZV8ZxcPOdht8VlvHqEWKAmpD4mr94jyJ
	v5fAUBikl/SyskA6uCGhGVo/qUsn8GeKN9XMFPP4zcMmUHMQbHFMhrA1F1F15fZH
	gHRppg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eyckqd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 20:36:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88fc985a65so1548180a12.2
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783110988; x=1783715788; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3Mr60y0+dO9JKpcFRd8+KSXVcXHZQThl+NbZHMGx/E=;
        b=CQ1rZq5xzxlbyW/Jv8IU2ap3ekIcWAcFS1kwBewpMZShxmiRzP6Q+/koVbmccV5bs5
         rvdV4wqVQpQPyLhEhEKGoHPhqXLgqXXnB7E1ApChbX+YAmOnSIhP5kUB/pgPq4ELiSB3
         AWHItZf+Ma9VOQVvvUpXQQiDFjqW7MlkITwrFHQt0ec5bcLT31x71lpnJcly15d6K1SK
         pywXIFBCZhB9L21DKqBj/66EdQSVK5EEoDUBtwRde1dHqebO89cjQpVhixJ28QN5jmJR
         D98JTiUKv7BC1OqucpItITgbxwcQGo3NFH/Qv3vVeVTILoLyyg3wpblc/C/AyGORH5sc
         3Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110988; x=1783715788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I3Mr60y0+dO9JKpcFRd8+KSXVcXHZQThl+NbZHMGx/E=;
        b=JON2rmcG22b1PZaAjhlOm0KXIbLly27QUmv9IBrSrVDMkvQCyGqjf/OatZcYAej1f8
         AjQwSmYtqB62VIKKWm3DBySwyATFiCZVc+6dBLxCdVsAEiEqOPK4IzktlC4tZzRbHkuh
         +tN63UYcXGTxi85RddbHf4H5z/rTGluDUIQ9uYRr4kL0mqv8U47r896qWOJqhPizeX3b
         slDjFB85vH5Em9lT5UfqnxHscspDhDYnpHHMm7fXwHWPimTaMVYhtOhF84t8tTEQrhCi
         5HJ8+xgKIMWFDo12yfFjtVLp6UjcJThM2+99RGnSg0LS4/Wz+k9+kpXM1Mi1R6nn7KBE
         FoUA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/Zub+m0x4IEo2JpwOxR3OF7nmvJwZjqaP8hUI/ojW8XWRHih6b2jYhfhRoX7f2Bkb4ZXEew==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdJoIUCwTqxSNz8fdyJ+B3tei5mCJA3XEQfck8UET5JK/lDEhk
	Tq9IHdSzI55Z/1r8/JJjC3xvTYxARDC9VnQY6Ks3azIXnyOdmN+k/YPznRuxMHgolO3zm9m+hMZ
	RNh722driQRSOwvYkbmOJL0V1x7kdk1jva1V6OkahLXwx+VewkxU9JL8OvM6AYsyfAg==
X-Gm-Gg: AfdE7ckxIPswm+PC/iPJgKyB5clZ4aox3vZ92eUBfSR+IAKcA7Y1np2ttgjVjZvi94j
	lr2m/wtVyUaWIpopZIwdqsjjW8/+DpbebQCuFnDF+eS8WHFWRotk3kp/cN3DO9C0tbl2YwVBCXc
	ERmmZJve+TtXw5mXC2GdmhxtTlc6T7JehZZxDXODiTCBc+bSsM7IFke/WaDt/R1dkMpdyq5jgX/
	DSS8cx7oAdpaCFaBJrl7uKHnxOMQ+eKVCEQCbunjUO4NXenJ00uXeCE7E3HYX6JVI+hAgD8bCFU
	Jd4RlgYVKmgefjPxvLj/AIQPmAMvkqBwLsdtD2f5wdBCTEeLM9i2pJ1MhzVCOEToDQ87vOIegAy
	w7jDHGnynL5Vt53vdQXnTJ7Ae6NnHP5WoBQs=
X-Received: by 2002:a17:90b:51:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-382808b43cemr879952a91.8.1783110988386;
        Fri, 03 Jul 2026 13:36:28 -0700 (PDT)
X-Received: by 2002:a17:90b:51:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-382808b43cemr879934a91.8.1783110987939;
        Fri, 03 Jul 2026 13:36:27 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:36:27 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:34 +0530
Subject: [PATCH v4 8/9] arm64: dts: qcom: shikra-cqs-evk: Enable A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-8-90cf1a52e539@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=894;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=gfyhHgOTYf7Emr9cLrvSN0kypJSlIEIIltSML9/b06g=;
 b=K/LDEKPGoZfUeH0tbE74ajfDKOByD2ZHrcPWd7L5t+EUoogX2zIW7VdSETU2ARUATIH0akAMR
 AAKcD2XotdRCPLTyDSnzTY7LWtZbQ9VE2nior29pU513KlghswTzcfr
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX/ubpzeBW7U+l
 DTST855pMljQ9aP4D+Oj+yHwovY32YbrWsRAXWzqEfIJTXoMjwAfP0m3CD3XhT5pTNa0Sa7Ebb1
 grl0hi0zKTMunYfYgy0+BuYqsN89JyVkZMzw/yi2Qp5FSIWg0kts5ENOTJbgJrbXsg7FYwUFj69
 KwqIaHzx0l0PAB8VLu51quvTUljkZ2dlLMLUM3Eh/A3e3PYJt+5k0dl54QvBrjx3jYc2czhCWvr
 4HTN/rRXKRoCkd6vZdpCr4MhOqhBHlvrIQg/M5wwhv+x7HQmwYjHEQIi6LoiEeVRVXloKg+qKus
 9wxUTlGXAiQfnlbJc6/CHCbDkYMH6YPgOjGfzDOODFgT7QEkmd1/dihAggmKW2KjoL5MyWUIKhu
 9hyukj7b/T66TxTeLL0eCU2mxdqXJFIMV3oZknDiaO1YVDCIYuE9A9kaeih0RL8o1WeRX9UQyze
 Wf1tjJQYmq00eLbTIDw==
X-Proofpoint-GUID: ixXiPY13KwjJspOiCScClerkRHdSbjl2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX6OKvSTRvrHZu
 0dkPEptS+e+NutIyejI9Hj7ohE36VUt4fWAoh0TiDpd4F07S+t0woHHeVjdoojp3rEzKI3sTk3X
 j80d62tpp23hxppjjwY4Zv08h2hTdAE=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a481d4d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=JW4bpjJLMT2bmMDKeKQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: ixXiPY13KwjJspOiCScClerkRHdSbjl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030208

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Enable the A704 GPU and configure its zap-shader firmware on the
Shikra CQS EVK board.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index ccf8f856e994..a95daed1581f 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -50,6 +50,14 @@ &remoteproc_mpss {
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
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;

-- 
2.54.0

