Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC763290AD
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238518; cv=none; b=ooc5XhyDFrBdvSHgNod7ZGLZK14GA4kVGZInJcBjEFzuXWeRMZXDlicr+pdWmjTHhpLCIVaxsIVaDx/biEWZDvJ/cd7ChlIvIvb6fy72R53nAww+ulcWYzGgnX2Xhxiry8VN3qF9ynihapU7CUMsfsm3+DSreihoYGwqZIxv3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238518; c=relaxed/simple;
	bh=wcNtHiPt37tRcLONgZr/t6X+o8Dp6m14w6rdasOzENQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QE++hAgAS8H9kZvJ3/EZ+Ba8v7J2Vew9AUAnfMmGwpcrBJE4d6+blPzrUvHuuqoxA/WbtYKUDFmbKimBDBUwdXKYM83tGfnm5JQeMK0m5apy2XVcsOctrVtNvYr0OA+hoQOOLynqhZK9Lm7iLIuAu29pa8Wvl7VJjdaGvZvwg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jYWEQSrA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H04Eidt/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jYWEQSrA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H04Eidt/"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6652ADUH286820
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kJCEGFaL2BWb7t2hrhNOF7E5Nh+JxpjT/H4VU+ffr1Y=; b=jYWEQSrAUJv+G1cN
	bXwUmbtQ3c7ObjQG+ukJt9DZ40VEQ6PTa/xjw1+N2e3GCt812eSCQk+dPYd2jPfi
	rdTvb6I19xcC9R/SG8craVD0o+htkVCgDwPS6emwf2k6+vSmDtvS8BKtlB5TFCwR
	2Yvk/h9+K5xpEjlQR0+3/csSwc3swKpXMlA/fFjTxuekd8VW90Hx8V3lnn++WKs8
	uj+4EijZA6e929hOWVjRvdmmowQ8eOkNKLvKPDUsQPIEsuopeRVeIE98bduRFh/2
	dfKFu1+t9kKTb9ibDwtygmTqsxF/C+CdpJ9WnMrG8DllrNmWFT6WW5Xv5wzseDX1
	gULo/w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6tj8j8wv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:01:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3810960140eso3053132a91.2
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783238515; x=1783843315; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJCEGFaL2BWb7t2hrhNOF7E5Nh+JxpjT/H4VU+ffr1Y=;
        b=H04Eidt/fGzYtVpYE7KMvt7ondTiZdMSBZ1+OnDXAgBsXN20xo7AeFRVScBMWYzvSz
         ulBliLyMiUnsEer3G76qOzwLAvavmi43t9VkHUrwb546C/LHl23DI56vWu13CSs0EqZv
         UH4Z10ys3hCFWwbR2rhRt3pqZKrlEcBOcogG6vmcYgvYMr7usXv8ylhQPyU0nrZd4DtH
         +Zy+U7GwIfchYSIFT6M7LZBQZmI8CrCOzttilQLrJVMqMCJUOxdbXFFMJX6l2kaUOl8p
         T3vWc6pi5RlVxPl8zUVJiWBB+mQzd2F2YczOX1EWO3C6i4UxlfaEzFzSwwi2+Ttu9NuY
         glrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783238515; x=1783843315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kJCEGFaL2BWb7t2hrhNOF7E5Nh+JxpjT/H4VU+ffr1Y=;
        b=m+ST0U8fd4SzTYNlJFrHYu55HxOZuKYLSikR31BpHKumSdIrl0OPfWFHdtklFKr6D5
         8IT+ob+rMx7ka9wzjvx8ILMUBHFGBqstHP5aZDSUOuSPefDu7NSumC/m+P0t66XyIhah
         LrpkOMFcbQ4yk3yedVvPgF+VfQP7nAb125WISiyPXflHv2+AkfkzpK1tttZUmofnqBTM
         8fklgSnZtP0bBs6OCi7yG6N+aA3m5oHh8619D5YQFop6iM41+eRcWJqtgw+I1ZJDVWIW
         mH5VnwMX0FcpvEz/GJIDahmAeHFD3v1eu2SLYnwv/Df9oWdz23H3rNjzr3C7Rwiu3Q78
         54GQ==
X-Forwarded-Encrypted: i=1; AHgh+RrpMWWtdpIKKjx/A5yPZFZe90ckoIMXdI5oHPcJqBHmQa8Wf04054fSeglBAGBYJCZS/6y5SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YygFqCdXj1nkvIop21ITFbXC3/q0hsXp9F5U4csJJtSitM+Vfwm
	Ain0ruXqOn2/S3KY3+M2EEstr5mhWYxeKD1IBdnFn3l6plGEqcZEIevD4+X+LR4xQyWTvf9dCJl
	Lehp2UnjLbu0zGn6CuD4HlR3njtUo/fMXyZW2x03T5hWDr0iQGsdGgpHZSg==
X-Gm-Gg: AfdE7clyy5bJbQM6zcJz/CDhKPhsOrLHLsJ1Q5RLYiwKij9TMNdQg+y5iJCR1DIa3Fy
	ARZuY4C3nEpknBpmG68D49YEcy4hOBDmb00J5j0sjYatklGm26DIwT7r8Ggvp/e3HOLURPkgwvg
	po/Nc/xgx5p1EuomUGAhsNX6e21EDmm0p6U7kzUMo45yvnvDPTr/A5KOqpI/RXDXIwYxwhMohUt
	ngi9Y8Ov2OABwJJECdQSP6pBSW7jLmRSVhU7X/+r/Im3FLablgNuJS6+C1uxgjx/HUIF8WwXVjb
	luOEg34W+8+YES8B8K8SHg/pqJbWh08RI7elOm8IuSf7OoIdX+MK6d7Gh2HRMLJH1ZOTNA/uyyZ
	m38pwpxKwviVp2LJNeb4lhRZ/HvsYW4MOAyQ=
X-Received: by 2002:a17:90b:184e:b0:36a:fcf5:64d2 with SMTP id 98e67ed59e1d1-3829f0074aamr5305961a91.16.1783238514729;
        Sun, 05 Jul 2026 01:01:54 -0700 (PDT)
X-Received: by 2002:a17:90b:184e:b0:36a:fcf5:64d2 with SMTP id 98e67ed59e1d1-3829f0074aamr5305915a91.16.1783238514228;
        Sun, 05 Jul 2026 01:01:54 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:01:53 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:12 +0530
Subject: [PATCH v2 8/8] arm64: dts: qcom: kaanapali-qrd: Enable GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-kaana-gpu-dt-v2-8-6ac53de56314@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=851;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=wcNtHiPt37tRcLONgZr/t6X+o8Dp6m14w6rdasOzENQ=;
 b=URv+TD6nyF6fnwSALrkof6UTYsZQKMpZN6Rz87h3njAQB0CgJ4EMV5S7W8k1U/tDgpRf3l9zN
 cRBp6AKKgf8CR9cghxKkqama10bv835Kb/xUKijDgF/ifhTGcqEIvaN
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfXwydV6RiuYdLf
 iQ9LnntwCevcETuytOuD1/Y690jCtjKnWepxPEswjyYFy9OJaoGkPOsDFGdEfWxjFMeBZXuX3Es
 ThXAnQqQHv83MeY7gc64nujGiN2Y9yj7BFgue1SXDlC5mrFGR7l27FqoS/h++nXuAUJmMhsDWG9
 YvF/BsjpVFPhcTrTGOg45v2khT4Cfurs2sT//I/kpiy5iyvGcbeyzvmnNNRXHjP5XuDrYq+OuBp
 emobp3bTzbRiPkrHG+okNluv2fBAoE147nkkh1Ew9mOOphsUwSRVnreKaOdfSWZiVPSVnhpG9kd
 4+hpoqj/l/Vv8V7APklY09lbWop2vp6qnX0eHcyoyosHNS4oQU/tKLijIUfkScTfkOaUf/yp/Mp
 XdEoVbSOgfFbtHEA7T1sqny1oNLE+2pgWVf8qLUy/ilSRsVVVf6Il+T150wgHdj0GiLeXCzeK8Z
 AzstAftEuYLwz9qu5ug==
X-Proofpoint-ORIG-GUID: txXjhRS3uHAquRK1i6xUdyKkznvWzvxo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX/d+jaRAi5FrX
 XLrmzA44wQsQU7SMqsHlGD/LukB1a9U2JC0YeJh6IgbLaUbdjSEaSWwvHHLEJHjfagXXMme1hdJ
 tgABZCEuAYZz+XQLOBf6hxI3+7ZgSqk=
X-Proofpoint-GUID: txXjhRS3uHAquRK1i6xUdyKkznvWzvxo
X-Authority-Analysis: v=2.4 cv=H6TrBeYi c=1 sm=1 tr=0 ts=6a4a0f73 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ckKq4DLX54o5ySWhiFgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050081

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

