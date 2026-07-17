Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A63A16BC
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784320948; cv=none; b=uywMlxAFAdUY+kucVVjHfGD6p9pkBQ9aVQqtuK4vAFYheogHeBVgVOjJxuAsDZ7Jb/mPYSaTiHPGdfSkeFXOsmIZ6MmvqL1/1LFTDpRpZrtZTwtcy2+rOA2ap7gITJUNlpmsdK9wuSJPdh+Mc7YajUHoJbDg1pKJkS2o5tYu9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784320948; c=relaxed/simple;
	bh=A2VsonGAk/WOFU4rW5YOJ3BUlJlJl5QyL5jYHngu07I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gqmjBZxaGq0rX9TU1sX4vB5D8UVOf4t68pP/MyL/u8eZlnhIZeV//0C5DizEeTTvK2oHYG1+AKIEltWp2yQ9jXFDTq5aOwbbo7z4SLLqxJCdfnLDT00Krsvs0wtn1uwzz7HDi+lqwtQjRfKJ5hQ1gdj9Fj1PyFiJD7FTLdzHQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g++Cc5C0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jwmJJejD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g++Cc5C0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jwmJJejD"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJtVR62619490
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jhtEkaAJenJ0hU5bVGOGxpv27XZDgT+ujwuT8/gsZBo=; b=g++Cc5C0YYJJ8Dk/
	LGGXvFZII+10CKTxAg7HF5JIbEdKqq3swihLsV4xu75qj91gk24AjmkNlMAn1T46
	bKHViNP5g+EgJfvw4HQ1Yj6S5B7PgNsc9MXj0nMUMawOTNXcLHN9NjGYYK9sB03I
	jVpxCcYB2HE7oW/VC2M/v+n7bqZAnLMLLMxBfXh0bRSOo9HWNbmH8fKe7BFpyVPF
	reeNtbuuZSEuDFa6IoC0ps+qDgUfO/hMOfYiDLQmGlLpRcGf7StQ+eXTkkeQ90he
	LaqVIZsYu1Z7UWm2FUq0fGUDMsQu30VBdhmw7LEQDizPgwI1hrIgt3Oajs9+JBVm
	XJOrVw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fffagb6pk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c856470fe9fso4291048a12.2
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 13:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784320945; x=1784925745; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jhtEkaAJenJ0hU5bVGOGxpv27XZDgT+ujwuT8/gsZBo=;
        b=jwmJJejDKdIZSuq/OrWf4X6/iYQ4KSOSnx5A0Enu9m+0kFaJx3FWh8q84qsZ9+r7no
         RIUxHkmWTerT5CORg/r6+UsOGJTcXZn9kZh1f7X1Dz1ykjkDatYW0B3GtWvuhuWqYVJp
         jmk5aWdJ11bz1wD5bz7MAHbtPyqVqmJyqDkv723Xc8gj0wscxSB0eY4pUqeqlrXu+vsF
         I+HTVxfTF2gxY8xMvgkiODAev4YKt721ASvkCQdwUxcLnDShXP9iBUd6PRBDashH0faC
         OEFQebzkNjFTVP5y2VbxLk8iDEc+G1qWKV4V7iLOKu0Fn0sCB4k+nSyFZMs7QuQUqb5/
         F7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784320945; x=1784925745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jhtEkaAJenJ0hU5bVGOGxpv27XZDgT+ujwuT8/gsZBo=;
        b=dEc8zx9eRhg/uB4C0TRSeNxaVyc0pM+94UCO0wdGd+WJV40Ge+RkvDbPh3ZqZ8VQdJ
         yWy5BPsBaQxJirAh/DgvHKXZ2MCUjquuKWAj/K5qtZQdxR5FzGFjB2A8KBTDgcI34iFR
         U16igC8f26YHUnZui+nKt+qt6YoPO2nQ2qKslwTXuJ3tMFFbobTpcs9Kyq8NJAxyKolG
         ssKeAGV/ve9BXOYucT7498Em6eceCf1xy0a96ukiNTH4TnbIi1lvM1ZJ0C515W1jJZ+L
         zXbwz024C2dUtZ7DgB0PXHBCkouGjgJXOU1PbJU53XoNwq75y0caw3CJeRBc5Is2wPbv
         EcqA==
X-Forwarded-Encrypted: i=1; AHgh+Rqspz9G3x1ZkWx0LG5uw8Szor76xiJUfLSX0R96qs/rW84NLc1pIjHl+JfUx3Vl0ayDw+pcnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+fmAMIqnqhQTFHa2uACYbAx0HHsF1x/Fbr3Zp/VNPY5RZd9BD
	v1hv5s4bg+yQY+iBCzTWuKF7bemVKwpojkGHhWNo04Bm64W/7hTZ3MD9+BxdkOy/oegOJdK+yqV
	IG+PwbRAFSfwbbCAOJ81mIR+D38+sSAUX3DnnT6OG9Lg98fJgc6Kjye7Jrw==
X-Gm-Gg: AfdE7cm2+QHAYPKTSBjv0QLTuVFD4y9A0DPHgCkpkMZElxW8owvJna0tAR+DfUs99bU
	1oWUEw/amczYcoiGnBBr8+a07jvJOAIOJjpHFI7g4S/p8KD2yMDWtXRq8ZcVArw7T0bTICh7XGl
	O6EtOxH/U8TAZWKJd1nBL3bK7stBYvaVQFzaHxSHyC5Vg1E2FIkGvbC+bAyCbiHxnuKM34r1XPp
	9JmkgajG0SxRUFzqGNDebHnCVw9fjCPcO4UgZye/UR7qtzmM6cev7u28mjBu08JAjF9JkF0gggS
	Gws93Sp9CPIBUA9lgP3pB2TuNlIMak5pum/VRLADOMeBN1sayedODwFP2XCIOKTp6oQSKEzOZEj
	UM7Mhj6cgVzzAw/MQ3Rw4XStA
X-Received: by 2002:a17:90b:3f85:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-38e4b3dc094mr4230462a91.1.1784320945463;
        Fri, 17 Jul 2026 13:42:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3f85:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-38e4b3dc094mr4230426a91.1.1784320945021;
        Fri, 17 Jul 2026 13:42:25 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:42:24 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:29 +0530
Subject: [PATCH v2 4/9] dt-bindings: arm-smmu: Document GPU SMMU for Eliza
 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-4-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=1190;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=A2VsonGAk/WOFU4rW5YOJ3BUlJlJl5QyL5jYHngu07I=;
 b=zrhPOCHooo2chb6Nfl5XD3FoSGfFuqiqKsCyL8WnuhUoa9KSgaCthbOm2ZQw1aKW/dQRH6TOg
 Li2Lbjrd7/DAd//jYP+/4uSrdQB0BTkMd/1iEzhPHbwlXmqJKEUSKvp
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX3+t8GfarobpS
 taAien8WhCLbHrpvflxguXbEc9scSAV1QWaKmJiZ1jUhsFTusQsB8lziYdJSr6xdvtC1OWE5PVy
 U0dLyGOO69sUYRP5c+2v/OdLRvdkqOk5y2ASZwk3RDNGqzVt4YjrwxDT7mNeko8stRAV8HI2yHL
 mV6Jfc9ihO3qtoMTq1A+XNaG0uEJBWNhCkB7jH1lLNPccbBzirS7A0cTdFe769YGkezbIqlsTtE
 o3Dmzw2kALEQMyhPTtX1NhmjBfcgSKigRWBwoBaL3xa6tFDIiAoLWwD6t+S6OtVxKJXrhcVJnOI
 YXDJjY9y21d6B0EggQycgD5ANHeS+V1LlB5ByUz5aAE2yZ6AeGbM8K/iQ1V99Y+kPfuWvY96tN1
 DA+iPIhEgg8uwN54qBdBLqRidlcgbeYxWTxn/t8GKl4m9UpXW53n786xQKJuh1G74u16hugtUtn
 rZ+c6QvyxG8eRY0/H+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX3b0jSSPY6zSy
 yr05TKp8ZQu1BY924U4DPZ5vd06YjacfVRYwOsVWpMVsBing6G3eibGE690yaWRe1f0+xL/0SNx
 oSmlVzY7H/mtc4HebgNRg7tUB+mlpKM=
X-Authority-Analysis: v=2.4 cv=KZfidwYD c=1 sm=1 tr=0 ts=6a5a93b2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: JCB30wLhbyzXCiZ2s_IC4piWOvvM8CoF
X-Proofpoint-ORIG-GUID: JCB30wLhbyzXCiZ2s_IC4piWOvvM8CoF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170212

Add specific compatible strings to document the GPU SMMU present
in the Eliza SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..ed556683817c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -95,6 +95,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
               - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
@@ -570,6 +571,7 @@ allOf:
         compatible:
           items:
             - enum:
+                - qcom,eliza-smmu-500
                 - qcom,glymur-smmu-500
                 - qcom,hawi-smmu-500
                 - qcom,kaanapali-smmu-500

-- 
2.54.0

