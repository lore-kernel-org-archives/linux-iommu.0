Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850D8344D9B
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110947; cv=none; b=OqRpW0EQ0gl3871pQlxi/0NYfP+JuK8rxzQmJx6RzD3ueFvrFgZ9UeWDy8yh1ZPhBAG1fixDO/QrGMp4bpmm4iPEVaUHAfSe76mprN4Qamzn5iw5Yy+la36fLPdxsM6oLR3IeVGDuXroZqbJ1k4xwluQ3nX9T7nf6nQzDP8engg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110947; c=relaxed/simple;
	bh=8G002/IxABPssrEzt3TqDoNY1L4MUJqdSn00j40u6ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5rAJlF0ISWcP7xhprxEKEXf01X/X7zOhQXOOCIbqb3W1pz7yJn0pcs6PUdxurnd0AVlgxcv8skwWdMr2iyD0p2YpQom/Eoe67uEFTh0vRWTHiwwE00bQA6zh7RbcrXIJR2/bk1sW4jaRLKUbC1v25wtcHUYyn3ZqgNy6wLl7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OomLeSBG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bcu4Ez7c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OomLeSBG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bcu4Ez7c"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPYQE837841
	for <iommu@lists.linux.dev>; Fri, 3 Jul 2026 20:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=; b=OomLeSBGdaXwW9nF
	k4zirJkKvIjQMNSCeeMHkgHg2Nu41+fTSH1hESfZCyqPqxPLdnBB6nyVzOsIP/1f
	npgRwIiurTWf0CEL6Q4jBVciA4VGbDTS9eCvC1/E1fOh+eaNJsRF/lSRshNXlsxB
	6pte5e140Wu3DOMLOzi5j74PoHdWQ+fRbH69UNzrVI/nOaQ/mRVRuorfoj4DlS7q
	aPbzZbNv8igCLD7FJa0Qx42Lwm2LKb7lsaBxh9pp95l5SHgjqdjWUe9cAJT0hmYy
	DSST4wfvfyJ8TwNN3aOfVPy66dRhq/kUMyzHieWnfmv0eXLU0R5jMx9FNZp2QMO+
	epyy/Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68jytqx1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 20:35:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37d4eede8ccso795899a91.0
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 13:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783110944; x=1783715744; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=;
        b=bcu4Ez7cUePoH1XrHUQjMSTtSNDn7QG7AnWH8Vb0oK1SRBbuRH1bTyXaERAqx1M/l9
         ICi5tdjN0lW6tTLPgpSg146If+Rk8jn6zzxkNlDnwCecgz9Oa6rXSpyZHdtGOTcxX1fO
         35QIwaP+oVa1gWYOJy1d/iy8RiDKUuJF6dDL+v1cW5UWIFm+LjtyQU80u3c7Ah5u9DgP
         RAhVf/p/ymDKdY8mNwqWUkkwpeJUB6zL/WRp19CUQdrKuouqEorBuBA5PaKGEa0XsH3b
         yxC32/6eK2HlrWrtJTnZC0DF/Tcje9xGr10VelLvuTQU25JUE7JQgcT2RlW6S/ryX1uD
         QEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110944; x=1783715744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=;
        b=PLMb54BUnPLO1DZsKdUc9CXbSwpOsEycd0eu9DgkW5x98bOOwL8spR2X/8EQ1OY9nt
         RzdL5ocV1qKKelOgrcRgq3o1xo2HYzXzgfhbljEx63o4eh19CI8pEG+dr36M2toLzatT
         0cc+sh1JPLZBkRU4JaxNttq7bM77vIHnHnA+G5HFqYwgRc8suFc/AwWqhpWWk8Hk7rzN
         lBS88217c73u4I5XBszlme9hGRT4hOD29tkN9CesuUXHsFUcEymUkhTziyyuJ5tKceBP
         g8H9rRWZBbePrikE/k2f07E7r+Ul8ee9QQJTUs2U/DWzBu5VKMTCZzNNhBDxds67qzPt
         AB1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrbZ5B/KA/IyFHbAL+IjYcFJh6rVv6rjYdqtyNXOi7Q0HPX6s0/L0Pk3SrLiYEWVwKUSP1qrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgcfRyAVr48VLbslTWQ9cpgK6SVdxh+S2fqUPZAYtKKIWXYVby
	1ZdjOwPWU+23qtlG6g+VP30N2unSoxu7AcS716QM9c+HJ5wSMzqVD5x6AlduubiRma//DKCRBXc
	h8Qcb3HOWBOpApAhFN1ILHxmVKUtELF6kUaTIviCbOHCXAT85dWKG1nQsPA==
X-Gm-Gg: AfdE7ckWRhBuyLAn9yyER5jICottM5faXcZJOCInbV9+aE+h4IBK8dyB1H1NdeQkqAq
	B88fVOWBGc310MtNnravJv5QCmhSBOzWbG546R8HHH6BbWzATaBJyAJ/xVeq0HAzpmyJ05HhBwJ
	6D9KmtNpu5p/Xiac/ndukcEtChw30UP/mibqUaMZxwVhDMblbTFyIUyecjZYmz/J0uvL3aD0DOS
	Dbuy6abzmkRYhH/lSqmT7Hv3R844+gLEUEfCotyHNJOGwpMPYouUSinYjxvp+da/WPxzKmjm2u4
	1kwi42Fy8YBEMAYSWJn/izKk7s1UBQsQtLBtU6eYw4Ly9F6vF8SmfMKXlBVbJdssJ6MXzzIh/M9
	F2CogH2I5GGDcRDwpe46O/aMjS6GplqLXiQs=
X-Received: by 2002:a17:90b:3808:b0:37f:9ce0:af31 with SMTP id 98e67ed59e1d1-3829f4e6e58mr958012a91.28.1783110944174;
        Fri, 03 Jul 2026 13:35:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3808:b0:37f:9ce0:af31 with SMTP id 98e67ed59e1d1-3829f4e6e58mr957959a91.28.1783110943675;
        Fri, 03 Jul 2026 13:35:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:35:43 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:29 +0530
Subject: [PATCH v4 3/9] dt-bindings: arm-smmu: Document GPU SMMU for Shikra
 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-3-90cf1a52e539@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=1298;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2jQmU1XEfwX7ksFDjORvPn6m0bWV65j9hgt3Tl3GEMo=;
 b=KNwcyIU5VqC/XQr4QH/U8KJlsgyT01EHf38v8j5tlJ2UjyZDi/yhU6ttLhTIayHlMRgIJ0PKZ
 lcgwcjlSFQYDI5rA10heEZb2fIAwdN9cVwv6HJVUEhVI+ZiVqtcHGSt
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX1GhXQRwl4bRQ
 hFSVlKvxphnbDqBpEmauZROsPdwhAMuAcczV24Ec+agTcY+mqD8YLdBMCpmm9V/MPLEN8DgOXrc
 vVbaeTFrv+3U6etMKdbXe0pw2DGaTpxxr607xYjafEY45+Qin3w468a2gzMnguibZa2ZKH4S8lX
 DOv1CzUwcvtCtLwmDr1rjmz8B0zqrvsEWwb9XVpImi+p2lbk/dOQkn+RyZWcVVZIu9wCE7TC6OB
 snxZGbUsuWpZB8OY+3bvT0UseK1NgpyXYOmdndva0Pzv8WSI3TFYr+qQ7RFj/QvTv9+DwD/yJ3T
 pcxR69Y6PMfS/ezlQco257uoaJ0f7yduS/fv155s3J3XBisGCzhg2FJvSfwkyoOSB3aw0uK7Slb
 6UfCEGL3irHWXqCeWh0IAR1suoRuVN5W6sMMLQLSy0miwjrjHibAL3SjkovvT9GxtjtkdG53KbJ
 reOkNhlNc+C2TylwSwQ==
X-Proofpoint-GUID: yJKtcE3nBy1T4UsmWgNHno852bubhEET
X-Authority-Analysis: v=2.4 cv=QbFWeMbv c=1 sm=1 tr=0 ts=6a481d20 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: yJKtcE3nBy1T4UsmWgNHno852bubhEET
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX9eMMH6toiiF7
 Aq/XmxOXB6lZsIJAH3drPtbfWqxhvi4W5XbA/Zq8zjWQE5WBVWsMGy5C0JZlBYmqO9YZ+Ih0S/W
 xOix6rukssylF0OTDiPRFigcZuz4fV8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030208

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add specific compatible strings to document the GPU SMMU present
in the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..ad15fda5c25e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -108,6 +108,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
+              - qcom,shikra-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
               - qcom,sm8150-smmu-500
@@ -543,6 +544,7 @@ allOf:
             - enum:
                 - qcom,milos-smmu-500
                 - qcom,sar2130p-smmu-500
+                - qcom,shikra-smmu-500
                 - qcom,sm8550-smmu-500
                 - qcom,sm8650-smmu-500
                 - qcom,x1e80100-smmu-500

-- 
2.54.0

