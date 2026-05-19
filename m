Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF93D091A
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176485; cv=none; b=Nvzg+i0oz0bAipS+4017iolsBeSmboKXwkVNpy/F93Odl/BWMNQVWEyuYXGRg26qIo6Hj3Ff+s1xs3KlMPX/JGO7G4D0OScvl7I6zcXWXN8P/WJ1MC7HTML8NdAzjeBj2lloWdmpM0fpabdEMdAEfrNzK2iDJrO0yjPMMULNoPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176485; c=relaxed/simple;
	bh=KZnHZBSLSMpB3NoM0qPWgRe3yVcNSNMcooAkdHqMozc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCSuC+u0+N33e2JHn1HXnCvAwC8K1mZsd6QP441Hy0ap3DSaPgPyvIYdTage4cXZyiWz+bS9d2kTZJkeeit7Lz0gmbxLFtKcWfneXza55nBfBheadNVL/eKaAXZv4Z/DYbHqjBkEVPddbTAvNEqUZnYOqrmwbJWMmTtaaK+4Wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L9yclq2K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cAcijEBu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9yclq2K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cAcijEBu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J1IOkF2975772
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/J/OIJT7DRrHkarchUlhqWqh7n138q1ZhKA
	zjC2X97Q=; b=L9yclq2KsTJFssy9xBXjxGmgSevx++Lfe3FTGOm1gtfRa9Ht2cY
	gRGTjyCVVAcY1hkH7scTOvR4OPkPz5LtQ3ibOnGVDEdUWvbTybs0NTEI8p4Udtvu
	/ybU+EqFPJjPXOZp5u77ibbSd1tVDNIVuPnzHrUDOGAYGpkWiCV2RQ5riqg1d6Mu
	6zwGPF2153Vnqf72MsW8GmnC4WZWJ68HaMEY/5wY57INNFwuhyz+mWefRb8QNQVN
	Gx7wY2B8pb+i0myu1tYkCgCqIjT8teNYivx+zO1S82JktFxQGDzwKBNPt9j+QorZ
	rCM4AX5IODk+HeJ8Sw2DTELRLDpC8h4dPUA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e84v4b8p3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:41:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50da529ff48so94546751cf.3
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 00:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779176481; x=1779781281; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/J/OIJT7DRrHkarchUlhqWqh7n138q1ZhKAzjC2X97Q=;
        b=cAcijEBurrj9bafpuptSDJibBrwpMgpXRaBeEphAxg+Wy5b46ihUCXrK95UJAhctMV
         jUqGpHi8VUiU6WI8agX0RprhtaSrC7rZTBrWRjIcr23l/fNKoHTwuwxRPaZlRyvvinPg
         hr6jxDh4qNxyLlheN57A7ZdL9YzhPlIKdFeWL8wiFlrk2NFBCdN7ZDE285yuZi0jkNls
         0q5xvd4X3z3THNkPHk6JQee3WI0V3p3XoPscR5pG5abovs0NXyvN2yQseOd/RxL6GQTa
         AMYV8ojSXkogWPhvPrTVUt8qGYuH3bhgcFphHYeYD5TE5aK5buQNS8Gb15pUNyLAc/ol
         X7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779176481; x=1779781281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J/OIJT7DRrHkarchUlhqWqh7n138q1ZhKAzjC2X97Q=;
        b=sbfP7gd2ROpbRq6t/Z1hbwukWlhY3DYKYAAu8WeAC6jGnEmzVCPO6BiEGstT3xHLuH
         h2bDpKESYJtfqXznxx8U3UegsOnzejFC+OUb8hZdD6gt0BwigvrNFi1bQ+0UXo8mJtHR
         WRQUfcxD99QM8hkvjuYzLsm1f04aUxcEhSjdkasTcTpJg68gqnihont8u80ZO53ajE6P
         Y8iyrn3O4A8jsHDSHoy5OuYMAtfzTChYR5kWwantWMM2LS57ZA1kqMsDDdqfQ9UEv0OG
         mNGU6XT1dEHvt48KmqPfbk2TuYK50tty/fF7kjhJPeRWLg5UDJ5sULZv2LmPfLuEBdIV
         qufQ==
X-Forwarded-Encrypted: i=1; AFNElJ+sU66Gshxw8cnbzdaPXhmqJWyBUOpbYRmt3zd9FRRCwu2x5GAOjNj0UItB0ts5/B/d2n0e2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtVODE0BZBrbw64KwkNX+DfN/pHdqHrrQ4UmpaM2HIvdYjI8wh
	urr6ApIc1F5KrswQcosFEF6kKMsbX2GwTOboWLcEle8HGaERi7jxZyywQY3saBNP82lRLqTD8Jb
	WI8MZfck+jnMCK2SYB6RDeScDATUt6d74pvS8UmTvlzEfHATktvMhJvh2yQ==
X-Gm-Gg: Acq92OE/uxH6r+KXIY1Dhi4hMsS4yhdRWBaPLHnhAgs9wH2h4zg7t0JwASWwO95Ea6y
	hHyMTqY+5cHHnTnGNrJN5uazt2XvBKECWEnl+4n73a9YQ3mLCMk0MoEQ9s14mm9dD8fo4fQrp/s
	LKlmTgsusF3gHbUDYsrmZkXKTvPH3QoSeAYgtfs7+PT70TAH0zKS9RKleWkWBsqJyo7ICT1zN9l
	ByiNdGk3PTU0amDsZ1YI2u6exnR8kr8BdYfWtkVRJ2msHyXkrw1z1HsvlRFbeC5aj6DIqAlr0t5
	Af9wZ5k5jIN6/BD0ddfD8D+Tdz2ldsJaS0wFjUyn1LcOAh1cR+zndLW0kXt4m7fbeRVzCc7yMbf
	vy7UN0j4pnTeAdssPBmikYaQAQXydZ9DLBNOVgjdY5aIW4Wk=
X-Received: by 2002:ac8:5d45:0:b0:50e:a1ab:67e4 with SMTP id d75a77b69052e-5165a2112afmr266765341cf.40.1779176481243;
        Tue, 19 May 2026 00:41:21 -0700 (PDT)
X-Received: by 2002:ac8:5d45:0:b0:50e:a1ab:67e4 with SMTP id d75a77b69052e-5165a2112afmr266765081cf.40.1779176480807;
        Tue, 19 May 2026 00:41:20 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm44999231f8f.32.2026.05.19.00.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:41:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH v2] dt-bindings: arm-smmu: Constrain clocks for newer Qualcomm variants
Date: Tue, 19 May 2026 09:41:14 +0200
Message-ID: <20260519074113.61464-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3108; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=KZnHZBSLSMpB3NoM0qPWgRe3yVcNSNMcooAkdHqMozc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqDBQZmYb4h9fo1eUreNP62Frw+N5foIgep81TM
 ww/LLf+CfOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCagwUGQAKCRDBN2bmhouD
 17/xD/9SxWFwr0hMlyKbr2w5eld0df0vviii88YLL7IVd+nKEcNHKnBzbc2KsAeVLdJTupqLlwa
 X4FvnxFuKmcJoSIOjCcXyLPmiZ83vnRo49bqjv2qSGuQi+mItHaOuJSdQfZM6dBujW1J0kM0xql
 XJzxJsmEJJF48z0GG7lGMmkCzp7hCUhcNdf69m4b8AAu4M/OC54o+gpo5dCiBik54YEOn4SJa7z
 zyBcrxLnRIWtjQEy7U3/2TYuSZwI06XPNUfgwQOcOj4WG4FCF9SVsrdS0YjxGjtqLlWxfCrG/2O
 NHSqkebM6IhcKT5QUPxU6fA06YFEIIwX57SQo64KPXm3NnlWm9TeVyZAIfTxwMnbylZzPgHrffA
 iqaUGMCav+lv1JVFHeF55lC1Mr67fFT2YKasRWM+FayCSnz1f9IcizRxzCeKDb7jNQ1bLuxG5fL
 s2uLrXXV2cg6ljWZL/eYzuKN6WuqwfoqyaCPvNhCioWd6S0IgXg7SRoTrb/NKkkRDYXezqT5HTn
 dpSsA0zefRZWDSMs7RdeXiA7uwRq2HN128ij0HJytyK08/iG+ULsGlZH3mFCpUe0B0Q80HgxrAs
 JlnRuSPX3cCjEGiVCXb0OxFC8UT2YpUSUBYVHrTz6CT6l52owrDlwxmwkEd349Iyq+gZUz1wtQN toMWRpDVtxjKjgw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VJPtWdPX c=1 sm=1 tr=0 ts=6a0c1422 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=rJxAMVKw8lswYMJXinYA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: OjhcKf1g6AZz5DpvHUiRDrOQ1ixZclRz
X-Proofpoint-GUID: OjhcKf1g6AZz5DpvHUiRDrOQ1ixZclRz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA3NSBTYWx0ZWRfX0MjsUeUiA02r
 XkHyCsy6O+58y2zT+NSn0WNvk103ZGwR1KlUH1dYVpfV5XVQe1i4SsAq7jVSIk2bmekuOwj4/sp
 uduAMxcdzeq+5Hmf8CoeHSKyG9AWQLpQC9j37bWmbGf0c7397rTj/eLC5UkPVLBGXC9E5EkX2WB
 2SdupQ48eewwgggTV6qdhAv2pr59lIlqRXaI18o/HLgSqU3l2w/JEGfyST9gXBbSw7siy+8RYSs
 j/vccUhfhwq0UmUwZGy1dyeTi+qTRlRRvKzIugr+jsCHUTCgeFYbpwxyFx4vyQ5gRhUNrTc7iRL
 7GbrmrMUZdC0UIhUwiQeejem+jtlaFY+GPBsk9HKJaOiix6kRKl8EZMUcsJaGRoyW1STxSLJLNX
 WNLnny11OZzT85BsW16p0D4YqxQ5a563WX4pxMlRPmIaXaeLp7a5L+3tTUsIMMpHGbBWnzmEBtD
 oDjdAV8z84Vy7Yp0BMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190075

Many of SMMU on Qualcomm SoCs come in two flavors using the same front
compatible but a bit different fallback:

1. For application processor, usually without any controllable
   clocks,

2. For the Adreno GPU, with some controllable clock(s) and using
   additionally qcom,adreno-smmu fallback compatible.

Add missing constraints for Glymur SMMU on Adreno GPU and several other
Qualcomm SMMUs for application processors, to restrict the clocks
property to a specific length.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Tags
2. Fix grammar in commit msg
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547..ed0d10157bd6 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -566,7 +566,9 @@ allOf:
       properties:
         compatible:
           items:
-            - const: qcom,sm8750-smmu-500
+            - enum:
+                - qcom,glymur-smmu-500
+                - qcom,sm8750-smmu-500
             - const: qcom,adreno-smmu
             - const: qcom,smmu-500
             - const: arm,mmu-500
@@ -595,6 +597,7 @@ allOf:
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
+              - qcom,sdx75-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
     then:
@@ -602,6 +605,39 @@ allOf:
         clock-names: false
         clocks: false
 
+  # Disallow clocks for all other platforms where specific compatible is used
+  # with different fallbacks and only one combination has no clocks
+  - if:
+      properties:
+        compatible:
+          items:
+            - enum:
+                - qcom,eliza-smmu-500
+                - qcom,glymur-smmu-500
+                - qcom,kaanapali-smmu-500
+                - qcom,milos-smmu-500
+                - qcom,qcs615-smmu-500
+                - qcom,qcs8300-smmu-500
+                - qcom,sa8775p-smmu-500
+                - qcom,sm6115-smmu-500
+                - qcom,sm6125-smmu-500
+                - qcom,sm6350-smmu-500
+                - qcom,sm6375-smmu-500
+                - qcom,sm8150-smmu-500
+                - qcom,sm8250-smmu-500
+                - qcom,sm8350-smmu-500
+                - qcom,sm8450-smmu-500
+                - qcom,sm8550-smmu-500
+                - qcom,sm8650-smmu-500
+                - qcom,sm8750-smmu-500
+                - qcom,x1e80100-smmu-500
+            - const: qcom,smmu-500
+            - const: arm,mmu-500
+    then:
+      properties:
+        clock-names: false
+        clocks: false
+
   - if:
       properties:
         compatible:
-- 
2.51.0

