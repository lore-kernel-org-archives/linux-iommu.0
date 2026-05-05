Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C93D9042
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965317; cv=none; b=ITz/5ENwo8Jf/jAv9RUnrLAHFgSu3bk8KZyj9Agj4IzB5Jz5FnCKvThIbbV2cTR/r80MdSXJy2r0YO0F/qSignJSMXeLuVlbFYy4MTbNahP37kEjPgvWDairpDepgdj0TY86w2MloS9BvD536oRldOHcO8IjQE0VZSaJYHekuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965317; c=relaxed/simple;
	bh=u62PmuJsFC53eibE16AfNNhsuEadr/Bcjjx+Id9tJAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjXmE/istn5mGQstczIwI5jP25H6jJVoxzU831hMPedZeAdExiI2ME5OOposHG0CBIl5nnPQAscciv5j6289+NJFnwZwvKAhNL30/gHu2oxurwd8C+2GvghPI+zwNvPKOCUvDsndmFkDhb8fT4tSvY6o0up87FAn5c+VKQdyPB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=INtSzHHb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fshuDPQh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="INtSzHHb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fshuDPQh"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644NHJM31346303
	for <iommu@lists.linux.dev>; Tue, 5 May 2026 07:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GNzLk/F53WBl/rRiE34Stecm2fn5k1JBi+j
	gtwl5zYo=; b=INtSzHHb+MXnQ8S3/6AXKi6M8NPaz/Zc5XdjEKBWk76TpkwegUS
	4m9cqzIIKCCusmGh5JnfsO8bYo65WAUhlBFVfrNavDGOt6RU3/AaMPwOnbRy/0PN
	VoFcTsaivs1hgX7vcfljo+KSU5polX/2kGyS06UBe4/2mXdWXtVlKNd1ej+Me1ie
	M2c/9pfziXaSPnZ0Eh8Rkf7o9EzHazq8nmeYHzPghwcGtdESzZW54p+U+9zBKUZX
	Jb/gNTv5om2BHY393hjQ+iGEOtbW9COUn7Tlwor+QWAHEHQ9ox3ebzOkyvuIUj/O
	5cT9lbn2fOqipW9KwLVugA9F6Gzcm2AtLQQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxx2xaw2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 05 May 2026 07:15:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50eb8bad331so16558131cf.0
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 00:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777965314; x=1778570114; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNzLk/F53WBl/rRiE34Stecm2fn5k1JBi+jgtwl5zYo=;
        b=fshuDPQhvHe9tswDxk2OhJDUdDNVjpNUhJtqLbVP+114kKdpkkw0oi6HPCya6iXYHj
         JQO50sjcio7sSRp5nyX8bbuegFj+Gr6aUJo/doMrFCLrqKxaC+S0XBOYiZSeYQ/7PybN
         cpiOvu+0/9NgSYr/KCYb3SzG4ymCAJIOilAh+07O/IdhogHxjTkISLhQ0v7uZcDO15uX
         CwJHfbz5Q8p/eWe9FerQV4sa5m3KxQCvks98uMQPqQWYFU5CDstiDQVPyG5JPgYJ5nVr
         lr3shvUsVluOmHYyjR53liLSF/VinAzXhc3HZ8/ITCdCnsqyMJc1gpfq9aqX9giDxUFM
         YI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965314; x=1778570114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNzLk/F53WBl/rRiE34Stecm2fn5k1JBi+jgtwl5zYo=;
        b=Tn4IVal9LgnMO8QzIf99N3OK8d9hxvAccrp6olipJLRhAyf56qv6oeFGuR1BRRfos4
         ZbzO5p23noe9Perca7a9SIZdMJqhRt5ZnG32URDPcDjzOaAM8BkZQxMEn17YgS/Tc+xv
         mMty/TFBxL7+qJO1vAgMoqAWgq2FtgmXJKbI80I9629X9xNJ2c0N91F2mIA/0VpppVXT
         xYv2Fq8cqWDYx9R+wj+KlGHZlO8O/oQx/DjoHjKk/FoCa8zRyCmOYZZ7K5YLtQBGBa+0
         vNGU/wy2zqlygBs9UORHCteUoJ90iRyeC/qo7Ln+OvmAgV9lUWDkYo9YUs7Fndy5i45U
         iBxQ==
X-Forwarded-Encrypted: i=1; AFNElJ88tqlH9B0r153hZppgizgqv2CZkWrSP9mHTQbSbz+n73Zssg5F1hviqdy+wBJ5NcVDp2JrxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVnIPltMYKdQEIOQg8DGu/QJlyAEy9bFGEyujqz1Vj8r0lSyjB
	ionI4oyhJMwuCrbJEvBAQD3H/d9yh1uymlhcPFwnHDY7F8NB3ycDRTkOOQ0/8x56/SdwoE7YjMl
	Gxi9PEbda+fCrrkGZZ+M1W6R2LdhNAUQIl2DQPygHI9TMgXE5xWK61z9UnQ==
X-Gm-Gg: AeBDiev27nDUQUUQZRRDq5tppyFH/B/0KmGQOAGHAkbPXfSrE1g7bdPj1war9KpDEvv
	F/Ntp8ksMYJ7fmQsir4RjtrW6bcLOhveI3FjInVxT7opRNyEtHo2ycVfjfNJTZJE0sCFTFZxj+u
	Nhg1Vb2tWciEL0UuKwing66BFZdy0Ex9yP4VdRsJQk4KeAYGof9ujr7erZnYxFqZduXP70Xa7rW
	8elW3cnkp7Pvc7O1753KsxlsNo8ZxnvcIDlL/wJZxxMf5Xqy9M7RF+aCoyS9W7r85oGrXfwlkSQ
	Tw89SEE0bCoAHdJAugp3l24fDfVW/sBeFNiKvDIzPSVLqgBSEorM8fl9bUem23m0YTZgnMYPMPK
	fHqd30/iGP5chWiX8Fbt26ywTWAxDxAK58M4/xXAikqj1jao=
X-Received: by 2002:a05:622a:558a:b0:50d:86cb:db75 with SMTP id d75a77b69052e-5130695bafdmr28103641cf.7.1777965314052;
        Tue, 05 May 2026 00:15:14 -0700 (PDT)
X-Received: by 2002:a05:622a:558a:b0:50d:86cb:db75 with SMTP id d75a77b69052e-5130695bafdmr28102171cf.7.1777965313243;
        Tue, 05 May 2026 00:15:13 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b02f76sm2210535f8f.23.2026.05.05.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:15:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: arm-smmu: Constrain clocks for newer Qualcomm variants
Date: Tue,  5 May 2026 09:14:54 +0200
Message-ID: <20260505071453.34000-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2935; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=u62PmuJsFC53eibE16AfNNhsuEadr/Bcjjx+Id9tJAg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp+Zjt0XAduVeRYEa/7OpETJeNBP8D6y9vWNM/T
 +QqfyGIYXyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafmY7QAKCRDBN2bmhouD
 10jgD/9J01XMkz+LeeUYM1W3mC4zKGc7dGAm/Bx2FVH5akQYlMgkbIEpVS3Ogc5mjsITedSD/j5
 fAubOMCzqSwc2ruOoFZ91lpk1n8GmKMP/6bxoN6BhW6we+pL2Vm+xGMv5vALlYN068vZDIdbjpo
 pBvCrzDFA4w4WR9LwXdRLcl+cfQS1+QO9M2mj9GTQ4g28e8xeeQ7KblUvrJzNd31BdijCzqZ+XD
 MVsWQopo4t14DN6sJ9w7lcvcrTHVvmI7X1y8yHacfBZL1g/Fsh/FCTXuK7nx0m8/G5HUM0F9Ug+
 FqtZ2v7FUmMXdjofB4Z1rDwkaOCPB4nkfrmpJ2lX500HpfVpoZ329gHBTM/jI3VnhHoVJztJijI
 NxRm6vahaM96AZNQigFNbW9OvDZdMIkrnGvS6T0JVNSyZjBiOvLV4LdM7Vh6s8XKS4KFDVWWZAD
 0doyi+nw+f0zPC+InA9rAh1mfzqE4iHeRORws3iql3WRXhpE5GVFxEnu7GT+NAlMz2/w93oVVR/
 3gWD2YdHd5d3VBGARjGq/9QZVtbUIRH9CsWC26wqoNhwDrqXV3OohztPNRjGe0gXGdwBgs1HPhM
 /+yl6YtY17BKRzCWqex282CV4nnU9aiZBkHojfXwT7A0a9eS76vUZz1/GeEq3oWmoLkL3NdHVAh RX79Aam2Vbn40zA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=U9eiy+ru c=1 sm=1 tr=0 ts=69f99903 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=f71n7wxJgtiWRlcSn5MA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Aq7rPz-1nGyP5qwSCPljOeO54JXap7Qv
X-Proofpoint-GUID: Aq7rPz-1nGyP5qwSCPljOeO54JXap7Qv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2NSBTYWx0ZWRfX1l1n4+zMEWDA
 W1oFZOxVt1X3o8Odr1zvCOquAl7VvbTT4I/04cJV68NE/CeA6NY+Kb0fc5yeO68PVO6AWzZ+wUi
 Bq+UphS9dbpRKarGvm2P+2ILvueZAjE1I2nJr9QKUzu+ZL7jNOZOFJUW/VlRRT+DqhCBfFpz26e
 xPYqbHajNbbV+khiEsCIEfvZrmjNfFbv2wrPnXXK2Ec1j8rW7XPwU621wVjmOmND0LbUXn3Xg7h
 xkqUp5rKm7Oou8YvchkcAb1te+sHHIj8HmQqzQzHli9aSgvU0loNomCXtM4SsZiHxG43AZPUW4S
 pLRppz5Oqtbu11bg1P6oenEuFNvzu1pzZmuSOrbTMO7NmTInkuB5PkqeB36bIe7KnX530lZ67Ly
 TXBqZJWPYvPZ2qU5kDu7oUCsb42rxxSRQKOYUncfXtVMR2zzxRFMhY7ta40C3T0A4WG2M0rXvqJ
 N41KY6IsF+NmSmXZ/SQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050065

Many of SMMU on Qualcomm SoCs come in two flavors using same front
compatible but a bit different fallback:

1. For application processor, usually without any controllable
   clocks,

2. For the Adreno GPU, with some controllable clock(s) and using
   additionally qcom,adreno-smmu fallback compatible.

Add missing constraints for Glymur SMMU on Adreno GPU and several other
Qualcomm SMMUs for application processors, to restrict the clocks
property to a specific value.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

