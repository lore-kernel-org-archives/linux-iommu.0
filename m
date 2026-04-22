Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60223C0623
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846823; cv=none; b=AcTjiWP41RT7e3T3cYudLoFTpGMo/XzDx8l1/6Gc12wfXIE5WElxsf8zBAuZNrQlr4AyMBybKjpPRRb5ljhrqGgXuQnwlcNaIid1MLGDkRpMFU8B/8IGMHzPThnewvV9zujgLDHEnrqIRnC1OAx0cV2XU/0b6nVVjitWOhjTt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846823; c=relaxed/simple;
	bh=HbMPY8DMFPbwd2WkwpJJpBUBQrkllHGVUu7v6NMEi4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxK8Kz1MIK5l7wIier13GUwPublwc9RpIPl8td2HCk80cJrt2eVvDxEPgUMU9VSfSNdc29KwmM2jCyuY/JPpF/0v+X98r/ZugLbJzLdbpmPtS2W733h9+2ZuRqiywL5SATrhb/lWMEyawbuwSBjcyaFYvecuHeJ2Ebxu8ul1raQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nHf8nnDF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CROXSm6N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nHf8nnDF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CROXSm6N"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M4RYRS727930
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 08:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ORoTDQr6cK4leZzidTtpiy+qFbY0ke5tAac
	DsKHAGzg=; b=nHf8nnDFNaHnaHZt7EGeYYRErDn3vH2NPZ3WbhusYfIhjVT0v5X
	tl0fo6g3sdHzDDU/g57I+VbEd0qdp57tDJf6uEATLDJOK1WDfEPQ9F5GIELCzqsc
	x80yn3vlXIUHQbJtKCusBVYDcfG/4YO5C81pXA+51iNstNilD9tuUEKZaAJTxDaY
	7s/+tuXGaCMYyXyJ1GT3J9IZyK8UWpm8JA66yja23K7L+ZIJ+8xgRMPf3OyS/kO9
	0v72CVkAHBt20S3bzL8CSCIiyEPo6srNUh9gVuHLK2LSjRqRnq2Y5YO9z2RgWrMj
	NbTNdyE9IWT1gX8LJMdkim/PACXjQ3el90A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenhaged-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 08:33:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f6b0a7164so7326651b3a.0
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776846819; x=1777451619; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORoTDQr6cK4leZzidTtpiy+qFbY0ke5tAacDsKHAGzg=;
        b=CROXSm6NopGcRJOntQoGUY1tCjb9eH/j1x0OHxaZyA7GDWAsSET8o+D8l12GPSJXL5
         K0bM7NOb3WyoTNZNVz6ysv+FExkfg/G9FEWIq/LSIhTKJnNbu6Z+mj21KnD4JluvJbxo
         zIaFDS8TXVnRSRS+gFef6HzD+GSt1nKGQAxeS74ESAU7T4rVryUYH4GIUqtlRw5T1X43
         2Opz6XuTOtWP2hwD4RwP9Pirq4yXFR84Nmfg2oRiEV34f8bEpK3ywCrNB2F/sV0Lb0ZK
         z4BzSn8a4lXfcnb0g6voqVhTCatn3x7VI84obw+ozRobYiWep4cGT1r1Y3csqbJ8/sZc
         THOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776846819; x=1777451619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORoTDQr6cK4leZzidTtpiy+qFbY0ke5tAacDsKHAGzg=;
        b=XI9k25nEpDBPxjlY9p5/8DfPfz9ZqKotVVLdlflCxfhFwGQQ2i2fRXM9rx9KLupf1m
         u6yBouB7VB2ahurxl/B9kKsyrirp5ZH/i5+3MpMBsPurVD9fkVgT9HU/tts3FAJHBuDE
         s7PuouQQnM3FwV2cvH2grH3B/PE51R46COcsaP5jAIT918BUHi34bbtbQc9P1bVIpwfH
         Mqs2RQto4G2K3NPRqIC042ztxlxi1/Z7ECovOlQ16GGcaq5DiMDXn9NlWhuAAPdpWfr+
         sZ1TrJT+DljBIhOGWSK6rYTUSAJNIQqhLU8IwIaeu/C3HSx4gdvoTaEWEe+jOpFuMR0D
         69Gw==
X-Forwarded-Encrypted: i=1; AFNElJ8ktRePaFKsi444k4z8Ftfe+HzE9XTX4oEVGBnhcePyNnzBuR3d8L9zrsRvqPng3BLMcP/yYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYc6TD3wJyZMtqI1mA2FJaErVwEADBLTxr/YrN+GiAhapSKmwR
	vvyZVCj7+Wtx6KsrejIS6k5roE2hSuiM1TUeWSLGdxjcGVsqzIVFvaRKQhUD0PheO5NlmHIdajn
	zK63dSCd+bz8+Mpck74h0oxpN3ja5A6VZdSKFKqFd6XwDKoibwT3ukX+chg==
X-Gm-Gg: AeBDieu8ITqv9S9Y+A5/qQx3v1X91SHociggJOT1c38DuAKqiij+23io+keFTHBdjHb
	6q/gogiA1ERhMromGrvL/+o8O0vmosjYduXa9A4ITQF9HV1aVkcu1oxFe8euDb2ayRERrRVcdpF
	od530Kcc1i5+hmTdfWf2gqvTzoSh3rIoU0zvhYSOaXiuka1CpWCRUBb1kIvYPKDvcqyfAT1jjao
	itjzjKbSvpihtN36WG1PS0WQbUDVhdYWviRWP6fOKA0lScPnAftSivPjfHwnTSzkgLD4+nRNdd7
	nOTtoGaAfYzE/czjQiNmdIs/SPobZsZiCVanDwzR0Ol+mwvN05iRZ9N/3kfzierK+Sxsmfr5mPw
	a0KXfV4SY4Ny11LBJcAARhQ3aIKztPvt9OKUtiJtjT3ZIuCyjv+q9A315hQc=
X-Received: by 2002:a05:6a00:2889:b0:823:d2c:b156 with SMTP id d2e1a72fcca58-82f8c7db2bemr22952340b3a.5.1776846818346;
        Wed, 22 Apr 2026 01:33:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:2889:b0:823:d2c:b156 with SMTP id d2e1a72fcca58-82f8c7db2bemr22952305b3a.5.1776846817705;
        Wed, 22 Apr 2026 01:33:37 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c12sm19736603b3a.6.2026.04.22.01.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:33:37 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm-smmu: qcom:: Fix Hawi compatible placement
Date: Wed, 22 Apr 2026 14:03:29 +0530
Message-ID: <20260422083329.885979-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HdUkiCE8 c=1 sm=1 tr=0 ts=69e887e3 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=2dDrt6dFNNLvW8Gx2gAA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA4MCBTYWx0ZWRfX/wYN4CJItocF
 N6dqx+K45qm8xjbSGdp4d3Fq93E5loavT39BPkK9KXJvtnBQqS6OusYXW5mg7tzU+o2BXzhNFYQ
 hRP7RRn/yDhRJsbmynI47sTrVQvYAIMNxBsrJR0fRVNIG+nkZQMyFBdBrbp/Pg6wi3FMkwLQg+z
 N9UZSO4WJnCsgy1320cl8/oKWHextWlo+LMTkyCJUw78+vj80A9OS2cgTP0yP91xzkovaso2/AE
 a8K3Fn3b120T9arJ5PwT4G9VVpKXSJcUpbLHVVVMQ3vZvXf1EfYzJB3xMNrpjT97WLIAJ9ejibG
 DKtYWbxLB4aJMhbqQPfMMZDLJi7qyx96bd7/5PffzoIjnsGfiv2MhB78yupfiAC10jMNuOXeFFg
 ZlDiF0eCSEKJdg9C4Pyx8iSIZb9jN2OlGMtN+jq66jW/lb28zAGCFne4oGuXFTSakrmWKrZY/O6
 Tb+nxLu/9SiLFpEsEjA==
X-Proofpoint-ORIG-GUID: -Lsghbq1qerl4FGL1U-xInO09tQ-8djS
X-Proofpoint-GUID: -Lsghbq1qerl4FGL1U-xInO09tQ-8djS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220080

qcom,hawi-smmu-500 was placed in the wrong enum block of GPU. Move it to
the correct location alongside other Qualcomm SMMU-500 compatibles for
CPU.

Fixes: 5e8323c3d528 ("dt-bindings: arm-smmu: qcom: Add compatible for Hawi SoC")
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547..ba9ad1f5a8ff 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
           - enum:
               - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
+              - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
@@ -93,7 +94,6 @@ properties:
         items:
           - enum:
               - qcom,glymur-smmu-500
-              - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
-- 
2.53.0

