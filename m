Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1F43B486
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622610; cv=none; b=c3X0sAsyBNujG31ZY3vrOu4Zt75Od8AsuU6DDxNZAehGZfY87x+E6+X6UkgT9+d9Hwz9KWnPkDpB/S97wP3qjB6i/QwrN4MWFNorxCpfB5GNsYmWfNW0uB5R+sn5LsVWPmPjuXmDDkO+eDNUtp1DtFWlHpQZE6XotPZ9WbZ6GB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622610; c=relaxed/simple;
	bh=I0NgFN3rF+KkU4yqBh/hyP5wG9C/1rf8uLv6/y4DOzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmIZInHAxgZmCqf6CB1s5yT2QtR0DWb8GKYkmhWeAV8bY2rjyo24WHWpjp/43O4ucre0PXrhWNQ0oifT5IISfApFwAHKot8HGpqT9kbBrmJNA9BTt59jwxJjpWHxVlTgOFLQWkO5Z14JTg/4PfInbAns57HNMc3z9Y6Zr8xnmW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XrFaRUVX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FLuentqZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XrFaRUVX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FLuentqZ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HX9Nf2503868
	for <iommu@lists.linux.dev>; Thu, 9 Jul 2026 18:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L1sQOlc7W2R+Nl5G9nVFB2M5cH4AGDkF0NzQkvcFvZA=; b=XrFaRUVXvcGaBNhE
	ipDn5AT4mzKJkmmrNwgSczG9YfhH1HLN3LqbVGfzkoZ4d+ZwQCBxGoqoiFq/8qHt
	LQeFAijKeUWmlUvtdQY844OtLzkeR113+HWzn6J/DkvbdkjV4Wzt9AljQ6uoLrvS
	/z7SYXRzAGTLe71+O2jVCHnKtHXma/1qaJij/1uOa3wOtCKGkq883YeFVm0x+Whu
	HnN80yEmEA1TBY5RL1xnMvuHcoNPyKyfIeFpPwUOUH+/xEE1H74Tl6x6a2Wzv6gl
	JXLe2o9ZvPhGwnGxQ9/dwKR3udYAL7jP/LSWLSWx4hD1y565HjsEsXkKCNuql0IK
	Z6rgdg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa6p3ucug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 18:43:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c894391f000so299905a12.1
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783622608; x=1784227408; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L1sQOlc7W2R+Nl5G9nVFB2M5cH4AGDkF0NzQkvcFvZA=;
        b=FLuentqZjcFEP7EDJ2+k3Lp4MbEhM4XyGTy8lIwMHwPVcHheLW6TDxP3E//2PnG49f
         YYAyd32n53E/sOyFvH+5wkyjWjy8H5EmZ8H0np34rQeKFfl3wzENH3gYmaTP6dThRAVs
         8NzAOSbLOTc+uOgz1/sHrHPR2s9xXjlwF71DmQ4tbh/NZznrSiqftgcREWMS39BqVQxe
         TX9vrL3ZhMJNKUbvCsI4Kpw8UU+6XauW4tKteSf6CgHhD6NLBIeriBUywMmXqWh5duZA
         PKSZ6RbjKQ2SRMATDAIl37FU+0T+vBwWZk527E3CcezQHWPUqs34Dw9L0pcmBrn/qfzm
         /+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622608; x=1784227408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1sQOlc7W2R+Nl5G9nVFB2M5cH4AGDkF0NzQkvcFvZA=;
        b=Pdq65Lvz04gv6xwuOQGlHeleIojPv+ovMHSOinPlwhIvPtrCNKZdDsFO0E6o8GQqhd
         II10jW2WMBygApBs/Pu1vMLErSkdVR+3JB4omuYGWxC3yAbOi0nRngsvJ4qfaSk4viq1
         /SKdYwp7Caajfle6d80TRnSCEYvuk8+5iofq6tQ0KfEgUV6aidKyxwwRBD2bPulja6h2
         eL7dG3GKXn/h0sS9q0nDSzQmeuo5eadHQ3fb55oKrrw3Jdx6y6BxgN9tOmxxvN9ZOAZO
         lE8qh4bMorrChzncVSG+y7Omz9HtRT6IqZ52kZS+hSFNQTPMt8QtNO3ai0fE94JZQ3RI
         IPFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqq0DB1JOnJMFmTRCwDd+WEbEhvAQIzVNj4rDOH01Fg/mgOLZ1J8Q6JBVJqcPEFD7v25KZNEw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy98rgIuC0Ya3gEgI1qxzW3lbVl2YfVyOSnDQwaAa2x+B9K+aQn
	6sOvmiyIA2wOLqUP3/Zv2SzlByDvwJgXP49UEeVDZNRhXkBzBoTqx/4APfXm+MurFSkrBmJNyE2
	GsZIOSS9+ta8ZZOFxXfIlMWnF1sGUE94wbQ0imVEpK2eGCC/EBCOxa5HEtQ==
X-Gm-Gg: AfdE7cmY707s8PbwUfT+JnwRGSTNte/JIJDoeRGsI/xYO7AdQbXP3WgF4tmBd30h09U
	6mxqUx27le/ygAQ+AF8pbukHmbSvG+JRuER7N5CSmlFZfqx4dIEHtHWBvQbJzN8qQAkX9XHL4y8
	3+DqrDATt8roTkVQL9uYa6dSXyk2urL107zTdF3PNmueL7eUgbB56Zc37Ol7hH/lMR9UdWLDzZP
	IjIglfyacC42b7iS40YRDAt17bWAOCVF2K+Zww5zscFFvkB3+8nMg4crmjBhDrjaDaN+igNEmgB
	Rd8GqtCjSmL7Db/ibBH0igtNDcTey5CuFBOb+f/Gsy0mWD8AbcZKSKGfsztygqjKQ9tJOxteXEu
	1Ro9AEUHtLvdSmOtW79J5bJeaCYwNlYGQozY=
X-Received: by 2002:a05:6a21:4902:b0:3c0:b766:750e with SMTP id adf61e73a8af0-3c0bcfea632mr10283271637.25.1783622607964;
        Thu, 09 Jul 2026 11:43:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:4902:b0:3c0:b766:750e with SMTP id adf61e73a8af0-3c0bcfea632mr10283252637.25.1783622607576;
        Thu, 09 Jul 2026 11:43:27 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:43:27 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:06 +0530
Subject: [PATCH v6 7/7] arm64: dts: qcom: shikra-evk: Enable A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-shikra-gpu-v6-7-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=849;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=TpvtLBwihWHNEKd1VwQvgAfHhzoeB2GGOqDfiPe0Xho=;
 b=ZIve4DWCl87XBF7AfPHf5g2BJeKum6itVChbN+14NX0yb+c2lSO4GLV80PWdApQDHp0lHww6y
 MmdHRS+rBCEDgn1bSRRYLQshjQmUl8u8iyr/Z7ckKek/8UGqepWFhl2
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: sGD_zY0wziDKUfgo35R3EQ2FRPVF77Xj
X-Proofpoint-GUID: sGD_zY0wziDKUfgo35R3EQ2FRPVF77Xj
X-Authority-Analysis: v=2.4 cv=TPh1jVla c=1 sm=1 tr=0 ts=6a4febd0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX0aUMolGFQ/wz
 uF+bDSPNOSpZeV/HrfR9ZR8/v0ScM4kVvq8Ltfq945mLN/i9+5CROFKuopYA8DFoH31Rk17RenD
 wGD0MUTJNAcqcgqLpkLndv54CIVnP0s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX8b2PV3hwUk5k
 MXWc1eIjfunCSAOKaSqXIzH1CoNaYXSLvtUWq4s4+OI2Yi85g/aAqL+lxTbAkYytks92sgrt5Ok
 Xm/LId+5wEfIyFsk5/1PS4pv1VeU1mLQ8qqKsROhJ5suKfleGMPMW9s9qhyABeL//Ge0/pZkTq+
 qVh4DWCPNyaTBHQeJJXpyzlHIfkO01yFiXiHE4g15O+oWp6bAcTMKB8PLidDNm1HxHjl1leEuAt
 XdHKTQF7RbdnI/y617uBH48fJ1GO09MKtOHXWAWv+b0XXM+BA+Xx1uXCZ82cKD/ChhCEpI/mvxT
 oqr0Bq2vOjFV70VcsXWvvNGSQRQwf5OVRaCwwda02068c2Y2apf/BJcie4aUI8S2PoK4WISxXvf
 HMAtZRsMxB4fvnl8sLVVcUN6ksPSJVFOG7C2cp09Ako2Km1kyvAkUffSBJl/Tp2MAFHhFwUkk3Q
 s3DZEB3VTSHIZOySAkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090185

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Enable the A704 GPU and configure its zap-shader firmware on the
Shikra EVK boards.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
index 4b7be09eb5a5..9febbf200f10 100644
--- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
@@ -36,6 +36,14 @@ vreg_pmu_ch1: ldo4 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/shikra/a704_zap.mbn";
+};
+
 &qupv3_0 {
 	firmware-name = "qcom/shikra/qupv3fw.elf";
 

-- 
2.54.0

