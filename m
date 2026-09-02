Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4053542F6
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313160; cv=none; b=JqWVNUhmqYckTVvSQa5GBPU2Xbxzs/dSo8nQ8IbLzrPXQ4M76p1Apmzqtgqkw4IhtciVE8AKl27n+M3XyXINeskpunJ6EPWWOo1zjZXW4hUHCw2CVtz/Qr/pWvfHz5hFDEL1T/OsEpTcPrWz+lJ8WzN/Qz1RtwbRXRP0rrhTXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313160; c=relaxed/simple;
	bh=srdvK2Pwqt7zMSazM4WQ5PLFrgZu5u3U9HplZRiS3wA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVg2YlzejDRc7fLmvJHOAL+ySgq917KPiI7pJ7DWMQ3d5BmT38NEdXM8Y7Amkmt8gRwCA47kqZ2WKF4fsP5GL7fAUpJzN25tW0KHc3OevBVJxnvBAvBDHDNfnfpbYeZah2JVah2wGcu/QhyPe7Q4e+nTwB9xRUUc0DOBHo0ZEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hgdSUzTV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AArsRWJp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hgdSUzTV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AArsRWJp"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KTbJb3849570
	for <iommu@lists.linux.dev>; Wed, 2 Sep 2026 01:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Ejjnz4o5DXG5PxCUge09LoByTrK+FdXEL33
	yjHOgIFA=; b=hgdSUzTVcHhP4DlNZmc7x23iUVor0r8ac9MbSBElB9ce0iZrqEL
	NHtZE6l4w/FiRcUCzkSl5CyC02k1v4K0xCBDg0HirNay7EwBdyv5IrX4nuzs3GJ/
	fRtIBBrdqYBPBVK16IGf5Bf1i8PVSw/gu9AP7a241AJHOHnSgQ5fuSOuDBJRIBRQ
	BrxQemgYCJMW7XBkWoOBQktuDrkLu5Y+t0G3ubEtDzwSE1ldl6jMpHfDOMhwK8w0
	kmoCoiuDRz/Sx/UJtTf2vnXz69wVZMNFyLiyb2Kx31LzSa+CSWn2yk2lhBsSoLJj
	AxOA1MLrAe17HHm3RkkOKn7OM/Pw4g2TwLQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge3n0sj88-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 01:39:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39906175917so685929a91.2
        for <iommu@lists.linux.dev>; Tue, 01 Sep 2026 18:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788313150; x=1788917950; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ejjnz4o5DXG5PxCUge09LoByTrK+FdXEL33yjHOgIFA=;
        b=AArsRWJpBKNCRG4/ft2YqMRDGG0iWiyN9E61h+/b++VjQv7L7Kut3ciKOfdRwvDMet
         J+UWSeLy7VDL32eJ8+hEmj+WmNL8R+SAWGfEHQQXwf9Z6FaBohP33L8zvVYBuGqXWUfe
         a0jJe3sQbCKhZTQuJh1ECSnxDBjvTEf5zPxm92+m6CwzEnCwgMnYVr0VQDlDzf9RXN7D
         tXv+k3bma/rZ8z0pTZ0E1aEYUhXALNUbXN71NdFwYFXELb94XfdYJD4uWEIWcXUwlMLU
         phvywF9FodR4ri4ZhT/DZ4ztFC2D2qSmHCmS0OWfOFfq/i9QPfXw5VaQfll9tHYn6vTR
         bxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788313150; x=1788917950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ejjnz4o5DXG5PxCUge09LoByTrK+FdXEL33yjHOgIFA=;
        b=btPxcCTM+gyha5K+lPddmu1mprJMStYjFxFlX96WeqFRm1gbecclmYvZjINoMgG5ZP
         wYRpWzcQYTw/DkONE06VI8F+neMEPQBr+ahvnZLolR7iw+7C3lXWFtmwM81m+1fpOfRO
         Px7dmZNMhZe+thVLYIRkOjQembkRcsW4bz9g/V7s4fiLzINYnIxU71E6VWQaFwr4XUzJ
         SUBF4IvqtzQ8bIF24r74MXzb4NVd0rfN3pP1bUwndHcMRNLI/Wd8kO/eoPB9h1m/smrd
         bICenZQWCf/GGWJh4jfeftWNHzeuDXLzaw5+mQSlyZHyVWmKjE+/v0I7N8tCATHJ+gne
         2ktA==
X-Forwarded-Encrypted: i=1; AKwUvBxMNE+fbaNP4GXd08o7gR04hB9uXPSOHXO73Tgsp+Xn5UN9L7D3i8IfqG9qoeR5+K9yGNi5ZA==@lists.linux.dev
X-Gm-Message-State: AFuF++mPArNJI+w3zq69mtaGf8m/4TI0o6zGIccwvyRSJMABmWy1TDFz
	LRjLt6VJyavBxyfnO7pBQWEipx2cxm9rYchNVeRNIONnafUhCt82ZtkH0dX6XMl1A8NVHWowpZS
	HKMT/xoYmxrzY/ORathaHc8i0AuYe2SpqaB1VO2oQP/wEF6sczX0LTiYzIg==
X-Gm-Gg: AYBFou0dh8H9uwgoSG/a8hDEn3r4k/udzFbHzh/5NSp120pk4vtNXSBv8t6FgyDBDU6
	XtCxMZ/+EoDpCiqWznEP+uVAkOvTujCdQRfJylTshYfSS+kz9icdx7EJcHKH+GfRvsVDWJImiwK
	ZzA9TzgU8WLANIOAOQ/ILhvapFAqTfC+oQ0k3Km6ILmnssIDaEKgBbLd6omUd2lfifv/xZRMhmM
	g41CG4L6qYgjBvCnL8J6kRUYsj5rHoBeeLrOj565JhPt3NVSBbjcTsmL15L6T/jRFXVl+yhHKUH
	7/mO3jbCZlmafeSPmykhR2RpUd7to5/Z0nhrZSYCDrVOUCe34sS+tqoVgDEBuq6N/yg+mGjOZeC
	yWDPJwKoyxTKJD7PJSoOpurtihcXgkoZZs9x0CXPQGwAUItSQsV7TNzJ2Jqb8
X-Received: by 2002:a17:90b:2705:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-39aee084cd1mr1958100a91.13.1788313149617;
        Tue, 01 Sep 2026 18:39:09 -0700 (PDT)
X-Received: by 2002:a17:90b:2705:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-39aee084cd1mr1958006a91.13.1788313149121;
        Tue, 01 Sep 2026 18:39:09 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430e8c6fcbsm3140404c88.0.2026.09.01.18.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:39:08 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: arm-smmu: Document Adreno SMMU for Nord SoC
Date: Wed,  2 Sep 2026 09:38:58 +0800
Message-ID: <20260902013858.130887-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAxMSBTYWx0ZWRfX8Jmv/i9ilM4L
 a6fuW0ohJKF8xT6W3S53lfMxt8narfM0o4WxB74Re3PDF6Guvo+efDShNmhsuxNl/kwN0brMVbp
 EgSjwyH8GMeqZT5/OnnpdD4RpR6UeKmuLzJvxSnw/VkJS59YMO7FqxKFNqHuCd+QVCPL6FmrAW/
 7yGrgirFOiQMNo1FdrIS1jco5RB+4vk7CYqtk9S5+ab0Kyx2T9/8g7gwKllcul1yNklp6CX8od8
 WUfiY8G4x7Ui7IXwGybiRYlqQqgn7Xjc0MJaKEBW/SEvbD7M/jr6zDrmmelLi6tjzcB7f3chzns
 qVcOxax47ldUPrYUPdFSrpviX6UGFyOi1ytL1+DS1rekooIwXuOVLil50Fm9+B/3gpi7UkHYRgy
 IeUsyUmLe2CyVjzAehqPYg0ktpdn9TY6ee0mQMfC/ieRKgcB4wDLxHucwKMlq7CjJRSWsUBXaHp
 qbT0Pq4lF6a/S+9OpTg==
X-Proofpoint-GUID: VMAcIvEzRlnVx0H3FCcfkqJZq4yzrkyc
X-Proofpoint-ORIG-GUID: VMAcIvEzRlnVx0H3FCcfkqJZq4yzrkyc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAxMSBTYWx0ZWRfXzAG5VfRXsxB5
 Er3L6Jr2PG3/HjuPyaki4ZHPZ0ReqhZqzD+JVrOI/3f+Sv7juEUs3dyqp/wNbVMogo58Pr2sVgT
 UhJEN2vkWgH1cK3NGcMCS/dRcw+t3/8=
X-Authority-Analysis: v=2.4 cv=R9oz39RX c=1 sm=1 tr=0 ts=6a977e3e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020011

Add specific compatible string to document the GPU SMMU present on
Nord SoC, and constrain it to the single HLOS vote clock.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
Changes for v2:
- Add the missing HLOS vote clock constraint
- Link to v1: https://lore.kernel.org/all/20260901140816.74200-1-shengchao.guo@oss.qualcomm.com/

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index ffa33b7f4a96..214a9c051588 100644
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
@@ -579,6 +580,7 @@ allOf:
                 - qcom,glymur-smmu-500
                 - qcom,hawi-smmu-500
                 - qcom,kaanapali-smmu-500
+                - qcom,nord-smmu-500
                 - qcom,sm8750-smmu-500
             - const: qcom,adreno-smmu
             - const: qcom,smmu-500
-- 
2.43.0

