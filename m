Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB37383311
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538225; cv=none; b=bfjSA/zdacsayhifLCqDl/UqrCar4+Viao7IBY+JnUJoS47c/G9BQJLBOOUGolF3TIo2r1FBEW0GVVehYcNrYZt88q3ozT4ksxyAPqtaD1ypYIeHsQqwi4iz4GHxgz17RW0wYwi+oJSG3SPPI35f1SfH3DPjSXl2hzkgAwfgVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538225; c=relaxed/simple;
	bh=qFEjGgC4wb1fvQfsiuDZ/uQBzV5scQmb40bLkCfeBGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K/psCbMspjXnhA95J1kckfMDCQSdgPDwArR/z1ObEa63gX5v32h9I7rY26FLNQJ+SgbB5wWR1r5rDZrmLirFLYKocKH8gu4SgTMLCkoDot6MJxLDFyzjZUKeODV/vCZj6AGGLlbB12f0QbVa1kBe4kJqdCYkDc6iutvTsSEYa0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hKo9MRf3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FKgAb4Tg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hKo9MRf3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FKgAb4Tg"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6huE2803763
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i1Ik9X4nwCWuWmFkc7YBJISS24AV0UyjAE4EfL4tKIs=; b=hKo9MRf3/BMSbuvJ
	o8LINdzdvxd16Af2Put7T6zzZBBUBCJI1tB5ibOUFOhmhaLx9iirsACJRiU2fHj9
	mphD/eMOE/pybz9LFSFRLFTnrpfZuM915o42jL6vn2kmsrpO23Ap3NMwoZcPtStv
	ko/waX+jd3cegtaEimjRbEQ7uNwFH5raSxLj3ECssCrZj5QOupsqKjdRUPhshMEg
	76ECORk0L+sioTLrAdxa65fWi6PllGBYSv4ktJyHsm0+2gxquJ0ZDC2pDkDkFbk9
	c5NDnqy6nCJ5L6bp/KrXE2hk4/y/eSiVAgS8OH8rjFHyMM6/Jj6DpkZuNJVSM0U9
	7zpX/w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv38g4j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:23:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8292e18166so674231a12.3
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778538222; x=1779143022; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1Ik9X4nwCWuWmFkc7YBJISS24AV0UyjAE4EfL4tKIs=;
        b=FKgAb4Tg2eVfwIPNXAIKF3a5jNJ/eT+vFMBBMeaxAJ1FEnXbsefCu2k9ZSKUs1ty2I
         dn3TbycsGlJtStr6XC95so7rIzV/12d8CgFSUCrlw/eRa1oOwepvxa7yVYjWe1uFmeA+
         M9dChaHRxqB5S7mZM9te7liT6Qo4OxxENEnm2ZEFUI9pO05CK/+RYhWUo0P2XSdOLzjt
         QAzc5rn8axhmWEJ4URlcsFbpnzqrc/0E/VHXARCEQO1bjoRyHLxP7Jl+YK2MNqfHpaM2
         2Tvqa1Nqkej9caVnIVYHWywBZeZOKgT5r1V9Nt7PgdqiqSDrbmx6+UOQyEhyvJ7Q12+f
         N/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538222; x=1779143022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i1Ik9X4nwCWuWmFkc7YBJISS24AV0UyjAE4EfL4tKIs=;
        b=A+APCR84NjE5aR3+vM9OniaFQXMw1nS5GRDCvi7n0VR9HsCzueCyi7ai9RUXtAcH7g
         fluKmetoA4XW06ougU8Sbn0QFJZ2bwcl9SQzxB11QUEODuEgSNtFIQobC4Ab7NWf23Z4
         44UkyEOf0Fs5WmutH7HrxmfltDCt+X9eLAwpCkoi3KsISGibXjL5OCFZMseyt5brkqd8
         ZgFABckTilAZvKpxSAtlLNdLhhPonwhqDjyVbYDI9+TrZXK55xmvTzcqB+X4Yp9wosVn
         Xls/fJG8lnKh77zm/iATfbASpQ5f4u4EHJ3VYsdg4sB/4xCaqKEaykQIyV/SZvvvdUDz
         gp1g==
X-Forwarded-Encrypted: i=1; AFNElJ9965S/ZSG25UkhaJccALbgsb6LoGccuGYaSUS/ig1Cuo5OtyiuIgE+JDPdJEJgo5UjqCiBCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZF1YH/msXyFBXD78LN9HEdw3bZq3Hi1NBTu1mgy3PhLPdPEnf
	DJ1WBSfPsAEorydd71ULxvBzpkDUamhcnFJpKqBtgGye8g1eNVJEQUs9i/uAol8kW7SFxbwU37U
	nEmEovHptAnNR9gYCQrfF1Y57zKmaLSw1d+jmqqr6x/euUUOtrNE1PTrKcg==
X-Gm-Gg: Acq92OGtlVekrjg4EZcFLV758+4pQ4GYgVPCxwS65SnmTrX4ncNZMp9jFjoSlE5dcjb
	Od2mwaH1Rn/iC9yCesAR60m03ahpJUOPlgDwCH1ZPY+S4dBIGMahgvT39s6Dh5jZtvmCL1qnz6p
	Quxg/gP45alCa7c1pNpL7bVcXZHOV9UBLoY8uCZPb14JQN1Bkohj1LviUEEB6QwmvsWWDcPJrYO
	IFVUpFMwJ0drKSRvAcIupMr8PYZ5dIJg7hFekvf/RKM1g1DKSBATlcSSxBngWezuYIUBMKG8Ko7
	gwo6A/WCXFzkOGVxKWdoO+71dAtPXg1lboTTjGkt1BeUSkwqSbGxVuXEFI5yW0aGZvGaPi25CB3
	r79N4MUNDvqSX1NwdumVGgIgcqy4qB9LJ1bT6/o4jZ6mrzA==
X-Received: by 2002:a05:6a20:12c5:b0:3a0:b781:4c80 with SMTP id adf61e73a8af0-3aab12e2f4cmr17859618637.4.1778538222145;
        Mon, 11 May 2026 15:23:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:12c5:b0:3a0:b781:4c80 with SMTP id adf61e73a8af0-3aab12e2f4cmr17859568637.4.1778538221662;
        Mon, 11 May 2026 15:23:41 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:23:41 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:15 +0530
Subject: [PATCH 1/8] dt-bindings: arm-smmu: Update the description for
 Kaanapali GPU SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-1-13e1c07c2050@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
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
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=866;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=qFEjGgC4wb1fvQfsiuDZ/uQBzV5scQmb40bLkCfeBGg=;
 b=63jkHzMyfC934McaMS72qQzI1obDzNntWJQBUz0AVtE273amGFUWx7fovSDObmw7m1nz/fPSz
 r8jcxbe20XFBLRx4d/OizdOTrANdLrOMhCUnnVRkTpMBeNetRGijKeL
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfX9udmKzgNfu2t
 z/VcZkWyx8f7ZS0tcP5VA7+ybILnlPUot1jTAI1nte7lA2WE31K6jk18T9nndCVaTTnWVnieqeG
 Ngt6QPTQljWjYqFU+gJCDLtCk9UJFBmeZhRgMxTBqOZghEom+TwB81TSRCOq855/29vS95xGpK2
 y379TIsXgBG/CvQUhADkJ/g8ZXsQtq2eMageQ6pgzjRTaQTCLC5I2XgExy6HSqNJPYs5xXqnhbK
 OfdUfwsFXJHURCbjRQ5Pb4n8DWcR7u6Nx+HdMPduruR07qs/FuRqZYSFDlTl9NuoP8rZ16zCuFZ
 r8uGB3LrTWW8yuQ3qPQZpsgJuNDEWcxaAOyHST5BKRJZ5nZaBUZ83++i6b2n+J/7JovbYb1EIfJ
 xJ6287xyCzR4A9ICfJOJmbuZHf1FJsQsDyAkjqzWwMR5CdGUw1mQeStXyoHZLjkg4npuBzdIFpn
 mSZuSS2s0gcKUhYxcxQ==
X-Authority-Analysis: v=2.4 cv=Kvp9H2WN c=1 sm=1 tr=0 ts=6a0256ef cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=RQVZ3Ks9ONUmwc3llXAA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: anB9syVPWWRdbn7gQGBA37UGF4_VMdL2
X-Proofpoint-GUID: anB9syVPWWRdbn7gQGBA37UGF4_VMdL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110236

Extend the sm8750's clock description section to also cover Kaanapali GPU
SMMU since it uses the same single "hlos" vote clock.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index b811ece722c9..d1330fc0178a 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -568,6 +568,7 @@ allOf:
           items:
             - enum:
                 - qcom,glymur-smmu-500
+                - qcom,kaanapali-smmu-500
                 - qcom,sm8750-smmu-500
             - const: qcom,adreno-smmu
             - const: qcom,smmu-500

-- 
2.51.0

