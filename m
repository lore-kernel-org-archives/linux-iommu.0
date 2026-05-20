Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7DE37A4BA
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262501; cv=none; b=sOVNb5dyGGwC5URuxsbeiQ3PSZCQnLJAEYlfiUV901UX6vCgOdd3b0GfyiSSiUaiAsu/GQXhPT+uFuifLdc+ELHYLVEx2fNdDfM3m8AFKHAjRVLKWnEBs5KwQS53i3Xj7m82+s6RwNf/6ZvfHCGw4QoJ/Q/ZziERvSZBKwcu1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262501; c=relaxed/simple;
	bh=AEfgsGvi9yL+G2ODkhDfRy3sTJPqdtst+OKv5XnT3BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5/4peIHEBK1K2pS3us7ZTd5BEF/gP0i86GoYZgkUF5Ixm0zQr8RShi0mElzd5lVfRO1UvMeyerKMdYgN2g3QXCVL0k+ACvkev99VOZ1fUfciDtNYvqHU2ER5LDE6Tvcj6N8g9JCoIYTaroWfJ3SJpwLOFVe9hFpH5cT6/UPBTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EM1GfqNl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vl1fmG+b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EM1GfqNl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vl1fmG+b"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7EfeE2867942
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=AvYd5tbvhBUHZMwEcf9N1zyeQ7mj2VpD36m
	kIvdywsA=; b=EM1GfqNloprxHWcEUMGvA3c/hj29XVH+CA1K5gPn+AxZGUJe8Nf
	8vltS7Jl0wTQkIdMzbZO1vC6s4TlYoFOZ31ksCgGvyPA1TF9zMtKTgSvryjdCSbh
	UXcapC8jeYwlo4YAcCJnVZUgF57XGij+oZ253fM9ilHPROt2mLO0g/bkbaDZOV+s
	gSEPOSOao94eE12k5i1rEbxpcmcL7EUCooMxs4Na1JlDR9Jl6Y69Hj2qDR9SoO4J
	+4zxciTfnAaL15ZyCYdMyKicXauXaEJx+6frHvHY1v4QifYIzDsL3FEoDAd+gN8r
	kz9HZpA9FS7zNECuDvPuhrybNLU27ylZmBQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3wbkrf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:34:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2baf7378ad0so48469355ad.0
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779262495; x=1779867295; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AvYd5tbvhBUHZMwEcf9N1zyeQ7mj2VpD36mkIvdywsA=;
        b=Vl1fmG+by8lbmUfbUujxRRcnUf5Hlms7rdcZ68R9Q/IMqk4Lx1/os+XQ2U7JnuluGY
         19/bo2bTQ1bSW5Gu1yvTAlYLHKsT44CDDdFEsnlJ+ZEpENSALJ89Tsp0qvgHFas6nNex
         FdaFNL5a3QUyZPCap9CS2kZUmra4SpmkdJjjB4c4QWfcpZ4edIgz9e4DoOA2ArCv7hKM
         f6P+uaE2xi/LIC53zefebbrbKaTdDm6WkyPPGV4ei+ZNwDKpZx+ks37vp8zkoOK/nN5W
         ZvRmE49xBN2nCUBDzJAoPZctAd2vYEdDJq16B6xb+/7i1n8b2eW++KiQXcYPGHNdG1hs
         /gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779262495; x=1779867295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvYd5tbvhBUHZMwEcf9N1zyeQ7mj2VpD36mkIvdywsA=;
        b=dhjBcGd+aX/b/tx4K6L2wpUzD5lXFS1Lf5c7Ao0aotdtx+czu5AD12umdKCqJKMA5W
         fpLl5JnwoVMLXqK3eFotjzc0hemRXoM3fe9qNIe1zEeZ3i5mdUU0AolIxNeJiskldLC3
         M17WsVdIEyxfC/0IGWgmSVsAWBYTIJpyUt5xAW8XSraz2k8qd0zDLPX5fs45iyRIOgd8
         pndPiE1nAbbjjcPQZdyLNAnh3BPqWbcYJBzGZgeZSUULmEdA9He1221X9xvDY/qrm4FB
         BxYAn6eQVAp2qopIHYelWCKuBnhI+jfVfIxum7hoPxpI9EWiS6pfXEKWIJb8m5ABlogk
         DUEw==
X-Forwarded-Encrypted: i=1; AFNElJ8LuPyikXQ9Pm0nPwrmco9ZGpCjHBHTYkKFIX1//Is77RgFcU1ryLing12PqV0tQiXPZMgBbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPbNKwWnMcPYZDa1ldg7FKS+daCP8SWNHk4OTlJTAwTXJWlHC0
	MnFdM7XvVHA12zvh0rP/Ze3qIlL3/H9pBDThCzfeyde9RhdOa3Rh3pGaaTOa/a4rNIi5VpJHl4o
	VQWEKqaYdP0nU3o7ZpJbcMlmSTzS2VwCAUOzq3JFmgD/KZBjS1yeDDEoCKA==
X-Gm-Gg: Acq92OG+uZRfeJ4oztAkfQb/pN0fBks7E7E4ZA17fhSpqHwdOP0Gwn1k1bib1B+3L9d
	7HUlj0b48sItZ9+BnILR7ZkmfZJZSr0Bf1eb7E8LKp/skLakOL3wLXD/4lKLVBWPY52R4NZbWSc
	/NNDtFfg+YYQkmt4i1tceVVjD8Gwiavct+3Nlc7EmfnYsgjtZErTGKZTQj2Chk3nqrrI05KM8eO
	ppJVpn4qrYjoSSEl2M6+v8/wX53qQTOAofgAsClduTvBcTgv1ZSr2o4r/+2dl9KywAqJ9oB82Dv
	F9H+/ZW+OZSMWezqtdZv4NKEdxtmkEbacXjLxxbndKA654kFNF5sxxR+i+0PWb/Wt4WxR0IfdXp
	YfQKWJ5yg++6l3C0uxTbBDvpl57Zy37Gx5s5OxKvub3qWbdrF
X-Received: by 2002:a17:903:1a8f:b0:2b7:86be:7673 with SMTP id d9443c01a7336-2bd7e85fce5mr245719015ad.6.1779262495339;
        Wed, 20 May 2026 00:34:55 -0700 (PDT)
X-Received: by 2002:a17:903:1a8f:b0:2b7:86be:7673 with SMTP id d9443c01a7336-2bd7e85fce5mr245718585ad.6.1779262494646;
        Wed, 20 May 2026 00:34:54 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49c9sm213562825ad.49.2026.05.20.00.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:34:54 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: arm-smmu: qcom: Constrain clocks for Hawi SoC
Date: Wed, 20 May 2026 13:04:47 +0530
Message-ID: <20260520073447.2138384-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA3MSBTYWx0ZWRfX+BgVsELqGbRA
 rkoqncwOmc/Cdkbzp74UBM9qouSauVC31wZPklXRBScc1FlhAybbrGAkrKozlRz7wQJbeba6hR/
 avUNBZ3W62ARrsLH3kbHgzVpRucF4ZFfwjeDY1fydQVkezpUnMemVZ8S6OyHt1tXNTxXj/YE6YZ
 KETCuE0YsVmkLitR20EIjouiOvW20Svc3wLfTMAJ8AOytxJvEuqy9F1ZFM0w05ebekOcozUSGcd
 RNA0ygRaIP4g9fmNn+fqBT4NkeaEvwdiEiMrrQMVPm/m8vQ9cq5PmKtR1+kEBGT8AqLDVHHKTgh
 prv4CT9X+rZEsTMihOehHxpKVcscBD2YXFCA5COb+ED1/M8B5nTUMOCL5+44QhUCSkeKmLuUezm
 LdYqK4jTArTdnR69ZyI36q8HXD0RNLexXqTaawIK7z8fgCNpGEyYAUXJ/t2qrnQQa3K3Baa+dkA
 d4td8Ro4wb12uOqn0Lg==
X-Authority-Analysis: v=2.4 cv=Q/viJY2a c=1 sm=1 tr=0 ts=6a0d6420 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=xU9kCb1ocPNtrCwW_qAA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: MqiqIt7TxE_Ggdwd8A9HVdXKrsMjfDT8
X-Proofpoint-ORIG-GUID: MqiqIt7TxE_Ggdwd8A9HVdXKrsMjfDT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200071

The Hawi SoC has two SMMU instances with different clock requirements.
The Adreno GPU SMMU uses the qcom,adreno-smmu fallback and requires a
single HLOS vote clock, matching the pattern already established for
Glymur and SM8750. The Application Processor SMMU (APSS) uses the
qcom,smmu-500 fallback and has no controllable clocks.

Add qcom,hawi-smmu-500 to the single-clock constraint block for the
Adreno GPU SMMU and to the no-clocks constraint block for the APSS SMMU,
following the pattern how it is done for other SoCs.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
This patch is on based on  arm/smmu/bindings branch here in
https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 25fd3efa2420..e413564ce55d 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -570,6 +570,7 @@ allOf:
           items:
             - enum:
                 - qcom,glymur-smmu-500
+                - qcom,hawi-smmu-500
                 - qcom,sm8750-smmu-500
             - const: qcom,adreno-smmu
             - const: qcom,smmu-500
@@ -616,6 +617,7 @@ allOf:
             - enum:
                 - qcom,eliza-smmu-500
                 - qcom,glymur-smmu-500
+                - qcom,hawi-smmu-500
                 - qcom,kaanapali-smmu-500
                 - qcom,milos-smmu-500
                 - qcom,qcs615-smmu-500
-- 
2.53.0

