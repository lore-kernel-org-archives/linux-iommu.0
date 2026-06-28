Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE742FC037
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782671116; cv=none; b=CZOZwkUDAMD/XMdBXQUmXvWgFPWNn0fCQIEo9JtptE7rjhUOsLoo+3iDOvo41ArCePvvLw/0hD72Qg58P16YUen8KQFfj5CbakcVn4NdcFn7w5MCA2uWo+UG+3YdpZ1NW1xgqt6n4V+FOweYF9nJ5B9du2v1NzVaOt9ryiMg2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782671116; c=relaxed/simple;
	bh=KgYLpkZfduXu4dhhkJ2rhW/+ZAUERBm4D1wAyZP/jjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a926+GRZrY/V8J3eWkIFzC2U3q4R8TUQY8ibwb5KVY4Ht9LM8tCqHQebevpRIwpyEj6zemoJ9dbUc+erhhGV3jYgSuFoPLn5hRhk56roztfhs8OoczIGQu8VrYirGKFGhKigXoPWLrWOVqFWmtKBGP0Mc63FyZytyg3+mdWhoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XJWDZsXy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YAKJj20a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XJWDZsXy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YAKJj20a"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SHio1p416060
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WEEd6pGIHJ7HSv0pntu9QVw4caHLnNnK53uxzqrs9Zg=; b=XJWDZsXyybmXtixy
	TD9TZjhNYlVwupMIKDj9ccUekygjgyb2NuRhpgPoLs8FQ8nh4FrmHFtjJK8OfCUE
	TzJ490W5r6MMnxRQghIRMtQs7mRwzHxQ8cqe+cZdT7VclxE1rMDa14L8OfdKtIK3
	q5jqmu2p6FmzKE2kU+FLalq7ysbj6Oh65RiGwAqmd2Vm4iUTo5Jyou6E880qZ2OW
	bInH4OR3letKay8hMZQRrISDVRFDG4kk+fwOdLZBf4rqjzz7yM+GzCKuZlRnLr9r
	OakVsTWVs2/f3s9172k/w8xzPP4nNeh370kQOvYHyE+9lBMPY864HRQ9IA7QKWpK
	PO5nJA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7u9ec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:25:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c5b9f6a51so1828317eec.1
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782671114; x=1783275914; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEEd6pGIHJ7HSv0pntu9QVw4caHLnNnK53uxzqrs9Zg=;
        b=YAKJj20aHo8eVLmb5iFPK1d1VxulpcQ7w6G+vHDMivolOhx1Y+WSjnFgUrpdmJ2+z5
         3ebwkbN7LWhLajsOmMSepnwMgq5pZRaZ3GaJy4JXb7g89wthJIFjHZr6Dmcp8RSkVOE2
         tebJw1Jk9Uhh61uEiH2axRNuCrs251neNGDgvknybo5Li3U+ZoeSRCm0qfOhOX3ETVRO
         g9a/mjdIGdds3uZNY+MT/uJFjmHzi+8kOfthCK1b6PDEgoAc2Qlsrt+04wd5SAJi4swa
         fPvt8pZ6JFyHvbSjtv7A+YZbC5Nwt7+Xr6OcqZUwHU6r6GWat7pc/4Pp7A7KdAifNSnm
         +sgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782671114; x=1783275914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WEEd6pGIHJ7HSv0pntu9QVw4caHLnNnK53uxzqrs9Zg=;
        b=XQhnIH3hzK8uAuCpowgCJBQzpeFwQ3FJyLiSJ8aCCYFrgmUbkTSWLSm6U0gqdOeqD0
         yb1c7JwvvNE3g7CpwkMZP/eQTfySnU1IMZkFB5ibN3M6h5p7q3iQmxgXZJc019iZpTx/
         ggoaQt22EFR6vWlEEhSaAHeD8bs5g+nmGRtes5TLDQvrWA/4a36NaO9l0yZSezKr6jAi
         /1QJmrbcmzgBFAOgmXG7G0asOp63+xTxIEsFvOZEDQTxNoq2RTifFXzkTl+Tu1l9DMo2
         +2cesmrphETBVd/ZnLO/HfjqB4L0M0DjH/Sbz1N2NJtkBJ+PlDB2uspgaQfmr4YXQRds
         3+sw==
X-Forwarded-Encrypted: i=1; AHgh+RrSa8u057ktpIPBf68Xe57Wlg6vhk19ToTEEp37W6dIHR9RfOH+b/cyAuZuZcdn5QKPMtsJQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdgC1Ie+pSakDDLlJCpEXwjPRiCsVT3RZ/fc9SZM+KJm2GUwsq
	YBLycA9/0u3pqihmFkf6DtyUH02QMjcXSM4/BMHz56C6NgSVgF7drNxXGW4lNns0IBHV4O6cld3
	S+Ax+oW0J5lLnbgn2YkSgGot0C22FtpIvvvAK5xX+7A/SHHW4O29WDevVhg==
X-Gm-Gg: AfdE7cn6W5zw45ZqU2l5CdtK+3hk4d9Vs6+fcxRkkUVOK7brK057QM7WcGz6+6poC55
	YsbbtocrMiBontX3zOe+RHfP7KGUUeFwz/sKfh5a5r6eifnvY58gZNXx7oA+SoyGnJLmMpb4/T6
	vv8ns/r4/LbSsvFbBOYFzEY6JEuH+KwMubNIyLd1sLSFMA7cTV8hU8v3jePIww5GHXvqHuKqW8H
	I2SoXCuGVuD9DdJcrr2+J6IFx+fJNzxbUg1WpDwPyKnSy8z5zjIAGkdjqEJyxMut8S4esY8/C3O
	Ny/ASlWJBtm9yD07ng2ze+8AUZGn8qCJ3y7+Tl19YACjgG/QjIgKs1FMUfDPQ4Gj5ttS/9SIiBc
	ntO6FmuzinbestYpvlPIwec6jjb/HdEVEh4M=
X-Received: by 2002:a05:693c:60c3:b0:30c:d03d:ccd9 with SMTP id 5a478bee46e88-30cd04d0fc1mr4515729eec.7.1782671114480;
        Sun, 28 Jun 2026 11:25:14 -0700 (PDT)
X-Received: by 2002:a05:693c:60c3:b0:30c:d03d:ccd9 with SMTP id 5a478bee46e88-30cd04d0fc1mr4515687eec.7.1782671113915;
        Sun, 28 Jun 2026 11:25:13 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:25:13 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:53:59 +0530
Subject: [PATCH v3 6/8] arm64: dts: qcom: shikra-cqm-evk: Enable A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-6-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
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
        Aditya Sherawat <asherawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=803;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=uABArrmcbp7tI6+l6+GOP05oGpD2TXxtwDJgJbxPJ2c=;
 b=zu51LUxAMig1yDaYoqIMlPTJ3nAgm4JPkQdk45v4XIneHJFJdXsdBfMbW7Ec9GipESIbRsT1m
 E9agdOA8VanBZThtAfeTyOxBDPVcGJgnX+VmRW9w2JALr6auGuyEtDg
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfXxvhWLytPMVBm
 vcDDZEVcXgw/yyOdZYA5XiFWMhbdMZtN1370PUejF+Xnz6J41FpSPOeLlXHGlBlsXXFNatrjODC
 NSRk+VwzNh6MGqBfdxvWOCFq27Bvn/v4uIRswd16OzOg0YLrDGunO8Ayoo+hWu8V/gzziB2Y0Q6
 Qqw87qgseiec/AoODFq6eHj8EfB1xNJbMthabNN32ObJULw76Ogy+RHOMo3s7/ldXhp/zEc2QC+
 qBXDFTYyxTmI8Ze+uJuiW5sR3p5dYyvS2ouXFsP4A82lakAOQTyQDnzftI+S0oyyg2ksvsI+GHB
 odyBbiNbiv9t+gpkxaw39C70No1V4W9+VvkkSh9iLknD0jebB2X995/Mu5WSXeAghmrYToIV78s
 n25K51CAycih1rks0ZHRM/amzdRozPMtI31hNkZT+BUOChS7AdyG6itTF5v2pZ0dbxsMUegODNb
 XRZJDSyi+QcFenMq4QA==
X-Proofpoint-GUID: h7quZW1EBF7qgj5_hH6UuPD0TjPiWPOe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX93cled7AF+90
 M4FDLeqmxnpZgPrJyGvrNM8xlub+rNtpB7sMUO3YvEMF2K31pcrUP1QRoIvTupJSiK++cclu5E6
 /Z8NQJKeia9R5R9ARYxvZtNTawLdS1I=
X-Proofpoint-ORIG-GUID: h7quZW1EBF7qgj5_hH6UuPD0TjPiWPOe
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a41670b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Enable the A704 GPU and configure its zap-shader firmware on the
Shikra CQM EVK board.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 0a52ab9b7a4c..d46132e97c69 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -23,6 +23,14 @@ chosen {
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
 &sdhc_1 {
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;

-- 
2.51.0

