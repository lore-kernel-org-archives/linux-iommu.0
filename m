Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650447ECEB
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374072; cv=none; b=YkVE/+4qLG4mckGieM1cWbIgvd3uIpJQ95jLHQFdr6m7JTcDuvp9wG303fxKS16K4+477yM33ufFwnBWPcbymhhykShqnjghOPlErHTW5knVqqrEgGNr+5yJNPaK+OmR1HEIWmsgs929PIEpTBKZU0cvIkLpFOQfnzLhOE2wJmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374072; c=relaxed/simple;
	bh=HJVDDzLQpfOXNE55MkX0GzvtfcyfyTEpLV03CHtMIG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VRHLQtNW1vFauJL62uzHVgbmV9HO13aVGm+G598uoiIEE4erCieGb59cVD4hCph5fYlQ32nj0Ibx/IEDOfAU7un/749TzI5MtAc9wq0qOSOmILxyXcxEjo0QlcMxB4yKtbBUeM7M1ayyIIxSlEpZ74c+TITuYjIjjAjlGqqGDFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=njTE8qK6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d0DPOuZh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="njTE8qK6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d0DPOuZh"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KE3cx1626296
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lECXM1p7mMPSbcZ5Smb9oe9AFh1hLoc+9PilQyUZhA8=; b=njTE8qK6HOr/c07s
	nWJ62yK7y5zZB6HxnWuxRHGIbpX/GR6+AbzabIh7+TiSZ/sALesKBtbTUhXWOYaX
	UCSkt11/mJwBkA7ieDsiwlbciJLTKTLnimAuuNdf9RDmzLD5Fp4G93Ory2NbHBTL
	kJnB55MdwG2dWytvowbRjALalOlBbMX9diBjsjs2I3Mh0pu+byBkPe1A/NwC2pwh
	l+9/FfX1GWDqrJJSGektaCNA5OubT1JrU9e42JwkztuwpoLVhM6xo4fhM8jDaL3M
	Dwp0AxiHrwiIQJO6GlqVggp0tNF5uOEaMW9qKjRWiQIJpV42fSYUm7D0D+M7BQ9y
	sJLZqQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bfwa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:41:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc86cab84bso25657205ad.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783374068; x=1783978868; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lECXM1p7mMPSbcZ5Smb9oe9AFh1hLoc+9PilQyUZhA8=;
        b=d0DPOuZhHfiLyPUep2wRZ8qKuqRcnOzVVXM+E/RYb6mZrQ21zz5S5vOsLV9hsZPayr
         Wu/09nR67CKJgDhhs4lII7hB+86oOTEZy/u8vIGAGUlnPX/ygKYU6zVzWsOGlwaO2Vhi
         UiMJ1f2+qeE4UeO1/RtVsSpaLtxDU8VwpS8FviiNEHtP+QhLSBzNxhOboR36URj8HSWC
         jSUOGKCO/nGr7d92cnOHehnp7v8/ItUgUXRRrTyqH9lhRWL8NTQoUJv7M6Szbn3HDVA5
         oenFtL25tDiy6LNtgsrS517tXGQVY2ivw1OIQf9l5E965V4UiwuDxI/Pw9mddM8acpz8
         BbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374068; x=1783978868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lECXM1p7mMPSbcZ5Smb9oe9AFh1hLoc+9PilQyUZhA8=;
        b=Ak0MeIqFF07QUmrwowGsjtHzXGB200gDR6zE7+TlQYfp0Jgs7kmfdbArdDUNj0x1SK
         8alXhkYrvi/JJAxAswqoBjJ/LzBZcY6k58zuSwo+L9O9WeH7SGaT+JqnsKOutz3IldWF
         DM5tnR7nt0I3pIlz6DQFSbHfE+jzLGUeYMm/ZLFwhIzDUjUOTvDl1qv38vTQ+IhvGTuz
         iPxtM1AAm8X4vO2PovEjk0rNq9c7fVNKNg37jztcurjARPaHr0Onq2mdICWYrJAXjPhA
         hJ/QNCu45jOgNULLwsYjUxgkA0GVMIpf/2ViG+z6mogH8Pe3HSDcIo8/F5jsN7pkPjB7
         YmJg==
X-Forwarded-Encrypted: i=1; AHgh+RrAYx5pXbE2iuO3AR1OaiPELGvhuEMK3Q1muxY44G0BWgCnrv3hADMTo1fyEwJXn+ynN7RJVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyORsMQQWUNUPUJ+HVnN1JhNEay3MUl2Nd3/vZgZcRILtcyPzAO
	yntl23YOpaAOoxAnzSrcmGGNrFuHh6WfHJRk3yjFr3VGKRuG2qetXW/JkzqfOOGCDRJ3pOwZVzX
	ftKeiRnaIcT/cv/H0+R1L0Lv6M0RMmberV0Z8QYi5gqmkl7Y9AMYxbHZoDQ==
X-Gm-Gg: AfdE7ckBksW5mSQ3YsTvHlS4J1hthjqlqdnpe/EooBNLqFOKrlqc3ptjQx2de4SzxtH
	H+M/2RopA/kyJ/nOz1HmwEIvJOxwYCGbI/YTkAcmAHQ36EsNy/o/EpSC21TvMtz2+5uam8+xGk0
	6O8NnbLPyPalw8iFpd1WB4M878SU7oWyPOT3kb1uMv13cDaghacsdrvFPlOWNJjKQ6y6UOleQ+r
	FQvav1yF2APQSke2vaMp9zqppCtiBMkgOe8N7Rb6Yv7TurCmE9BU/WhQxZhAKddUKes1JlEyH/P
	o33AW9AoGzxfBbk+Rdwvnc6G7N9IzpLKslAYDTXKWBi1TEZvr+XLIDnBGs55iNPxgfBjKRHEjbH
	2iIGjgo3H/cQgr4h33/ekFz/wqzYBehFpk+c=
X-Received: by 2002:a17:902:e78f:b0:2cc:741a:ff33 with SMTP id d9443c01a7336-2ccbf07b90dmr27229235ad.43.1783374068136;
        Mon, 06 Jul 2026 14:41:08 -0700 (PDT)
X-Received: by 2002:a17:902:e78f:b0:2cc:741a:ff33 with SMTP id d9443c01a7336-2ccbf07b90dmr27228815ad.43.1783374067709;
        Mon, 06 Jul 2026 14:41:07 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:41:07 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 03:10:21 +0530
Subject: [PATCH v3 3/7] arm64: dts: qcom: kaanapali: Add QFPROM node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-kaana-gpu-dt-v3-3-8dac9a60dd5c@oss.qualcomm.com>
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
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=1140;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=xlkJOQ68/B3gMybJ9Ns4FY50UaqHntYHUufy67tsBxg=;
 b=7edwsEeVv8RHFs9wiiykhb6VXFeyYOH/HK4hwAwFZ0IHw5gWNb6aDpzyhjQU9h/vPFqbm1TSa
 s9NCvSNutLKBK4+wkAdMeVSn/V2LA9Rq/OVHw7b/aeeMzaXAawE2luN
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 1UxN4OpBZ5ewdfX0mIJXwPOli2dKr1Vk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX1K+ndcsDmSGK
 mmuCvPvYySEBUkrpXrZfzvPcAsZTehwf2aIQyHzHCNe8Tc6BbxR+CJnfUBxmRIBYPj6lpSZiahS
 NrvX1haQEUQ1BBmqoUDAVgsTxb24oz4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX1HXcnDdyaZ1g
 QoLq43UQX7rtLZoyLmAPqea8b7Fr70Izemz6PVRlc67CZ4Jw2sommoDU7RUQnikCGPHSMk/gCka
 RtUmJUquNVPslrlcxUUITBHaSUlMRM6nn6m5PTDja2UPWEDP4u7QE4K8olt5epD1TwEaZyXnEwu
 k65LOZYO5NsOcwR3oVNh2JRnW2P2qPYhjRJ6ELN5YtrP4Tjl+D/+gEPtAfAmtP/glV3m/5pc+fw
 j03MqN4jPqyMN8b7LwbwQ+zzsn3ydY11cqX0GL+RgD5tu4xqVXkroiX4kqlXFfTd/zSyItSXvvY
 t3rsxGgAT7kk4vqtuxWmVs9g3ik5Db+Ypd1zgTub89+AE+5KqZ+ghLgd/ZMMNrUWXkp81VvxJt+
 03NeDt3zk+WAlxLPq/Czx+PSqAZwCn9d7C5IKVyJDlevI4KU6WipUvxPWNb+H5+mdEG1WSM7MUv
 0KmTC4KqmiQayF3xs1w==
X-Proofpoint-GUID: 1UxN4OpBZ5ewdfX0mIJXwPOli2dKr1Vk
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c20f5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=doS3iEISOceegCkkCwMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060218

From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Add the QFPROM node and GPU related subnodes on Kaanapali SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index a41962366941..2d0db71cabf1 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -5871,6 +5871,18 @@ rpmhpd_opp_super_turbo_no_cpr: opp-480 {
 			};
 		};
 
+		efuse@221c8000 {
+			compatible = "qcom,kaanapali-qfprom", "qcom,qfprom";
+			reg = <0x0 0x221c8000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu-speed-bin@142 {
+				reg = <0x142 0x2>;
+				bits = <3 9>;
+			};
+		};
+
 		nsp_noc: interconnect@260c0000 {
 			compatible = "qcom,kaanapali-nsp-noc";
 			reg = <0x0 0x260c0000 0x0 0x21280>;

-- 
2.54.0

