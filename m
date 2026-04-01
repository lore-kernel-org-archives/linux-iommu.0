Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080AD2367D3
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047694; cv=none; b=AvW8WV6qB1vVrq0z8hrNN3uyX1q71IU6mzCwXBMenh0xkT8SpyEZpke0y7e2E/DaUOBNyc2xO4Eb0Yxgh6kdSiO747y55+AFJBkHAus04tKHC+1haoI4/QedOwcEndMV8/vaRBRKd0A+kKPMlcHeVqBnN+rSzIXampnzxlr4rHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047694; c=relaxed/simple;
	bh=CuN7Ga2m8h48uUCYQYe5d+xCakFQ6D+qlF45gutWNU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nGQc2fI/caM9HdF6TbROGEztveysP3qKQfSs2rNwldW6N5OyCSpeL2kzA2pdZTTWciK9NOLCXagd6s4ICRR1sUjE8GMkPOHzhCqbsreDYHpo1tfoZbrZJAdgFyGPuTGUJb4n1HG2/xQNZ4UwZADgJXhQ3MsEbVuwzPzA+rbrFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QpYMs11l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kog+RgJ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QpYMs11l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kog+RgJ0"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6317lUwj1578312
	for <iommu@lists.linux.dev>; Wed, 1 Apr 2026 12:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=37d4Ftbfq3heDIcxaZtHZqx7NKWVEylKGmD
	eo+icNTY=; b=QpYMs11laMI31RYpLv2jpCaZVGt/bSV/CtoLtJngR8pAvpJjmsi
	rfEXyYFHlvg+9SlSfKSqSIrmMz7S+cwkSSd6tVpTCs/+l9v2ryKBDxYxEtYdgGiS
	U9eEJcEofgXt1MlVEP1mgc717xnZlJRHitepPXr6ktXVMrKPHUFbZ9SGvW0khAAq
	5zuUKRhaIazL3vqmBdbt1plm7orRbQ6ZfUj30ctLno8he/eHYD/4wWHHaPrAPKst
	8VVDchZuNpTx25f/Yap1gr7JoXzVF/ZG13rftDWjaC874ev/aHKF8BCggziJDuR+
	E9W+FcxSKRoimkCgnqgg5PmbijsYRw6imaA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8k6kv4t4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 01 Apr 2026 12:48:11 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c76bcce03d8so417566a12.0
        for <iommu@lists.linux.dev>; Wed, 01 Apr 2026 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775047691; x=1775652491; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=37d4Ftbfq3heDIcxaZtHZqx7NKWVEylKGmDeo+icNTY=;
        b=kog+RgJ0MX4dgueXfTJP7C3twJe8yKYkNMM75M29EkD/dpWYVuKpITSDnHagAwt7mE
         9Q0sjKxBtDaTIWbVXZhURSHNCPis97TDnfCGmU/2SlSDULgVwAOePEcSMsobd/ZNjlyg
         T6hB3DhGj65HFrMUUd1VnJ883L4sGxdC7o6fUa4cVgILePsIwpMuA2qhOk5IA98cLxE+
         YH1rj1zQbSj3pf7Mwp6OV3qFwj3X2sYNAbpsAePXQHq2qPr/tYaR0k1fRbTzHRAjDGfz
         6HQbmOakHtjoQe4VAWu9IILxwFvrgANem6nsPs+rJI7HHr0mNVyV41p/oA3/rlkGrrSh
         wnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775047691; x=1775652491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37d4Ftbfq3heDIcxaZtHZqx7NKWVEylKGmDeo+icNTY=;
        b=NqMy6zG007k/zmCWWH5WX3QPdA7wbCO8kR5bV7Bp5jCh6NaTzk+jjlGD9oKLfl4Ipj
         gbBUBqmQ3nO14xfbDTEfiTP44RTDm6IcK4Fg06Hdipt94M8HTK7/Ix/Lta14CK3WqTKd
         ynZLsocAoG2bMLakVN7jZUBH9UywrfkLXm56Q7mJd4E8Y9zXsFviNtuv0iYU8AnVEk9E
         Mvqs1m5kTYhh7JF1RfU55nh3ord+8p++zhgqaoP8LuJacyRCqr2nYPFYTTTLpJmFYeld
         lPNAaaWSlZ+6ZxIEE9cqmUcxB4EcgdGUei9QrxfDyabWsmQZ24L+hu9uJqVD1/tozLz8
         1O/w==
X-Forwarded-Encrypted: i=1; AJvYcCUVSR9JY/fTFqNe5vOKzam0lleEm4gufR9hkTFIpYyzvf5AfXj+2nIDSQjGDj6pNSwKZ51vYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywyph5Hr5URaY2RRUTZNEb8+ToCz3nOU1G5pCOzuwsG1EXUTZuE
	940Tbf2xmcw7HW1klDDHhtPBkbmDB3CH+dlPdTuPSzk5R0RZLeeQSuKTzmq4TR3OJ4EkUXa7Zep
	VT2O9//CnuXMTd28MMytwc/MdadE667z6wqYXBRcdNP7QbLHC9GTLfnKvBA==
X-Gm-Gg: ATEYQzyLCUBrohkhcP2yS3siB51eXpvBn6CGEKtQQliyY4efC2pJ5X7KbqN8srcNql6
	3VHBoCXgT0Ma7dXE+4a1pxgsYYen6jm0wTs4JopY0i0kELn7P/ZRXYC+JKfQeNm09s0ezv/3+Pr
	QXF4nPcHVUr5QvWwIpmNo/SHb/TUAREPswcog7Swbl3vqI4GZmJ2lSvwQ8ZOQ1uD9pBk6HLxpNy
	leKlYFS6CjmBvrZLBL2SxECKTLymWJng/XWkrDAC+mupHOqMXlVGeM1XfSw0Uog3cpoYNoyVMy6
	j961oVmHnR9aGnvVWMk1ffcZMxa3R/dQLdujaaUxI9PU8P1q01XYYySuR00ufc4RS1O51UJJbPF
	CnPnFrI2YJe/rszT6lNOLJKlzdK/QwpDO4JTjtl5pnwGeoS0U
X-Received: by 2002:a05:6a00:a1b:b0:7aa:a2a8:9808 with SMTP id d2e1a72fcca58-82ce893ed22mr4151780b3a.20.1775047690647;
        Wed, 01 Apr 2026 05:48:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:a1b:b0:7aa:a2a8:9808 with SMTP id d2e1a72fcca58-82ce893ed22mr4151751b3a.20.1775047690108;
        Wed, 01 Apr 2026 05:48:10 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc6e9sm15507903b3a.46.2026.04.01.05.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:48:09 -0700 (PDT)
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
Subject: [PATCH] dt-bindings: arm-smmu: Add compatible for Hawi SoC
Date: Wed,  1 Apr 2026 18:17:57 +0530
Message-ID: <20260401124757.592343-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bfJmkePB c=1 sm=1 tr=0 ts=69cd140b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=V65sNsENKvr6zZljLJ4A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDExOCBTYWx0ZWRfXxBoaSkNFiyMg
 MiOKXzUBLuVQdKMFnkOyq7YR2DSEJ9QRcKuF9cHeCxfQP0fPT+mSprK11B3WITqG7YHu8YasE9f
 18Czcnn55gdn8TEPnhyFFFYEaG0EBT2tkQsYoFIg3akhdUITAkHITdY90oHdxM/dcgNQrmydXqv
 HFhQRjKJuufwB8oYpnej0uk+6FOSqd3EEJVj9BY7eJQ/s2XaX0BbAG1OKy6JbUyJcS1jUeFv1Se
 TiuVBiqW6AQDYeo5ywsqkXS6DZOMcMN5hJV3qaj1r3TXCDrf1iQCp3JIeSt9nNmIa8tIcLywzeS
 hD+CxQz0Nnof0cSEHqjOmhn922dsTmZqLJzIKxtQ3uIfrRlOgZ0zt17sVrUVTpRevDE0h62+m2B
 zGBqyV6QPb3uaFmrFbkGNgWEAsTySfP9+w/9jm6UGQl3hObKdkRDqFAg4E7YWUf/JuwY4XcnZ3j
 TbJNwkieM5HJd8k7XQQ==
X-Proofpoint-GUID: GzgCXWDX8d3etloRcSlCPBg9UlegO5hG
X-Proofpoint-ORIG-GUID: GzgCXWDX8d3etloRcSlCPBg9UlegO5hG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010118

Qualcomm Hawi SoC include apps smmu that implements arm,mmu-500, which
is used to translate device-visible virtual addresses to physical
addresses. Add compatible for these items.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 27d25bc98cbe..06fb5c8e7547 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -93,6 +93,7 @@ properties:
         items:
           - enum:
               - qcom,glymur-smmu-500
+              - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
-- 
2.53.0

