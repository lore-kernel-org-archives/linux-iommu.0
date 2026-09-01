Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E338B7B0
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271716; cv=none; b=Kja7IBrKM8MUh2tbFaZ2A3MHicIPI1Nyfmvw5tziQClUkxH91+sL3aL8BQpMEcbrkCAykAheP30lhkqD6WPVssnFhRhDYYc3jydD8l7EccvIPRjfyyUFkx8QKusJqAkhrlJ6BFzZ/+/OiaZZ1OLYw6JNn5KWZxbRZhsqJSDn/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271716; c=relaxed/simple;
	bh=colpSvQ380ywH2w2lEES0eevoSl8wWJBS0QAQ8Hjf1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDyv8HW0fsYDo3jjyo6Z1YSLmCs54QqqiDopwfr6bM0lNlx9ngJFNVUfJH2vdN1wRrZhpegTHJruKCaHzKuT7CGTSYV26ghOR+vlfJFDQFGYCiyy+HIVr9YYUZJqxwoaHxkJ4JNbFawPKPFz2nU3hJboumV9UyL9w2OAbkh6s1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kgIepFhy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TYJJeGcc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kgIepFhy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TYJJeGcc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8YxI3495538
	for <iommu@lists.linux.dev>; Tue, 1 Sep 2026 14:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Oa5JSaR2HXZbUmoPEdwIB4s32xvCS0qi1Pl
	yRPcXY4M=; b=kgIepFhy1XHtm0FYuPNVqACvHfAd8lpc129/YWZ0kIP+tvQ/MDs
	QpXkSjnSAS9TgmamOYXzRjoRh/34hn5xFIcvhxjAeJvBRruXqynT3+s0BJxgBVbK
	aDg21qL5AxhBhmgoix+HqsA4ifWsbRATbzG8I9enKZDB/WgessrYES1khb/TUfeq
	CBdnTd97J/1oTw94F8d0NwboA1NGyr8G1001ss4vT6wo3nsjEsiEFrr3V8ikzww5
	OtSAuPmUwtVN6RqCIGuMve+6Xq63BPQjxptYqTLlw634fzqz/ntGKcyAnKIezbR5
	jurnC5uJn0qDoOcA/WJyJ6Dte4eeNRdRFcQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdy9ng8mg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 01 Sep 2026 14:08:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-396901263b6so7405053a91.2
        for <iommu@lists.linux.dev>; Tue, 01 Sep 2026 07:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788271712; x=1788876512; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oa5JSaR2HXZbUmoPEdwIB4s32xvCS0qi1PlyRPcXY4M=;
        b=TYJJeGccByKmxdlC/oyF2D57csypkMHB/JP+OavdQ697rvuw4GIfWBq65X9X1WtbKF
         gP0juVPM6KxquQDnBodQ4ASopit41WRokkgMu5spRjldvziJ9CMxFBG4fwPSbNPiGEHV
         Km3N17YGe9VyyGv7F2gPvxF6usqeWNvFyDcEKpMWlx1nMnNstADASGBpK1VTLbKFk21m
         GVkRGD8aS+W+3JD6Y33/bO0G48DZrcf8nQyRQ3uVS+9UtYRCJJM+MitGCG6/egCXVRRq
         RlKBZdY67W1QG+dPHOwxva2cKJDC7C14Nw2Akh+Lr8p8u/9kns0OnUwi7HqNZKFq/ovk
         96QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788271712; x=1788876512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oa5JSaR2HXZbUmoPEdwIB4s32xvCS0qi1PlyRPcXY4M=;
        b=LqcFBKLHbsCy+agz3fyk1zwB/n/W6XT2ArF7nF/DYn1t/nyPVEgM86C+v+9+XKST+4
         M7JYzG5vrTxJpZ2EBzjm4luORWyljLIPdZ77Ho7A3mJ+ym+hhl2L9ksJP5fU7X6Lc79N
         0g4dvOImQP8TA+usTreCr4NYTbKuSMk6qptufTVl56vumPHjLuKjiLVomVmR6mEkcjFq
         CioTyqfZznYUqLTeuQvicwGh4We0L0Ylj6G+tDGjgYjcEz2igyJzhXE0NHd0gBzjV9Mh
         rqeDsRMWlQa/054YlCYQnmvBUWpaw1y/1JpjpEOd0CbGuc0dGRVMv97UXw3a7BGOuAXW
         lj9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxtLb+tDqSTSE/+YhFUi0ODMGo6mDVSFVEllEwUlUNLTClcyd6GqXeAKnCoUbGnQYuYvymk/g==@lists.linux.dev
X-Gm-Message-State: AFuF++lOOaTDKagg/ZrbNAhUWjOQrUV2J6H0Q8Cv7H6GxxLghoXHGbw/
	I1cM9uEh7Gr0uL/ehwz++UH2cM34wOrTyvpmmz7g8Q5YVU2nqrbusDAbrITBVXpu2ETBXwYapxB
	nrdTpjPzYmkv0ELPnxAkRiQBup76b6mFibLTcp4jyyTtL8L1sUFjjxUfE3A==
X-Gm-Gg: AYBFou3BbaIYJlvWOf8nIW2eFh3sa3fljcmyTb0g523BOs7ygrPGiZ26jzRcj9w3myg
	d1pcE+s1Su80ZbLwNxSZfousgBWwzRF9MZ92FQfalzroGsiOnpCtxb8RUHuOXbRfTPSHT48joCu
	5lUw3RU0ILg9DU9AB+LLdSYbH8EVODS0S50Zq086h1xZzli5TDqJ8+db/3svEP2RkDd4urpLQmV
	0uxfiVqDyrRi6chOimp9lI1MJB/zGm1i9I6t544YmVl8b+vPz0t0qL1t352yoj5vtrhR0IEtnr2
	6DP7S3RdMdD3/hnWzrVZfeB6ySBsdAoRIROwKIcwN5e6CykllfBmM/OXKJFL8n9Su8p/njBJjz5
	i1MO0TVdrgTnvYKSKmXUxDSWIQtBghVUkbuJQVjv3sdW8wb/faqQcfqFbCvS7
X-Received: by 2002:a17:90a:d887:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-39907e0f87bmr12734699a91.14.1788271712082;
        Tue, 01 Sep 2026 07:08:32 -0700 (PDT)
X-Received: by 2002:a17:90a:d887:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-39907e0f87bmr12734531a91.14.1788271711452;
        Tue, 01 Sep 2026 07:08:31 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0bf8a13sm56447342c88.0.2026.09.01.07.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:08:29 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: arm-smmu: Document Adreno SMMU for Nord SoC
Date: Tue,  1 Sep 2026 22:08:16 +0800
Message-ID: <20260901140816.74200-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyNSBTYWx0ZWRfX6nMRpWKpXKO4
 UmA2yRqdN+toIOCAfZ48nyXILFqe8BAlgflHI38rB30goyfatT/v5SyONgIc/cg9BtqNh1mPdyh
 0ZYNN/8hC7CYtlZ+Dpfx5ZoI3SODFMA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyNSBTYWx0ZWRfX7+x71XVG3ngS
 Z6sOVr+beo9KIBDIZNlgT9J2nUdDlCV65o3zmt66mHnodkmoZP/VzffqbQucPyLL/E3EgS/4Ena
 zsLY7ugZgZO8ZsZwpKkFCkT7q0mMd3inFHjFe0t/rc4xHk5eIWc9lPwYb79KFPeQZvkxhJ0Npmy
 oM0JKXa3lV962k0ds+cg0kN7p8ZSnyH5LiODg1rEXVw3HjeX6Vbh30VfJkvVhvX0hrKdNbgtcmC
 GUKO6Z/awVREYcb7io0BOsJHLEJAAazt4sMWcBt4Cj4Y6doEt1Qa+caQ7F2NAETMSPMyQOodB5b
 0B++L3jN/0BVdVctn23KTKTR0r7nnSJm+bbH5H3U2R7ST1M7Gfi44+FT31G+SCwIjMno2K4XMCv
 traO/lpuETcbY4tKBZr+Egr70Hiql0AscDz3aHzTykcU675JeAwOOpi50ip6Kp7zB2do1Yc6MKW
 L7Clw7c45xL5L4Cptrw==
X-Authority-Analysis: v=2.4 cv=e/02j6p/ c=1 sm=1 tr=0 ts=6a96dc62 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=W7vQhCiC0Tbq709-ndwA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: ISEp5hdIoBmrbOLF3jUkUsI6oYQVtqn5
X-Proofpoint-GUID: ISEp5hdIoBmrbOLF3jUkUsI6oYQVtqn5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010125

Add specific compatible string to document the GPU SMMU present on
Nord SoC.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index ffa33b7f4a96..ea338d313c05 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -102,6 +102,7 @@ properties:
               - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
+              - qcom,nord-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500
               - qcom,qcs8300-smmu-500
-- 
2.43.0

