Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B28209680;
	Mon, 21 Oct 2024 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551939; cv=none; b=WngXx+d+1injOyBi15Uwh9+8HVl1EU96XCHZdHXnxdWfhmK4wRiA2QHO5ZnYxYrMQ5ZGLeCdOGqgEm6puLNc9f+vi+L4aHcpvpjThSJNTdubK/M2++MlHzp9Nqjd762l73UrOBfPgx3JQOB8JBsAFd7FvCUHXXpXqaZ4IWs1MhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551939; c=relaxed/simple;
	bh=Y6B48dfvOzd1li/uXpLL2OFiGtOi+hdPvHZ9GSoXTD8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rV2WxMXBgMwg9iRWT1sN2RoTYxTazVY73P/DpjsZfO96GZxnxxuvKAwPVihf2frD/gj1RXcSbwAll8wgiR6Oy18eFOcmQGMjgXD4qlqPdYmZ+aM5nFcmiwHHcd8bWWoTfsMHMxRFpFl3A4D5E/UsmoFHhNeaL9cGuOuilNuvAyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IbmpP2d7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IbmpP2d7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LJBdae016474;
	Mon, 21 Oct 2024 23:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1W+DEuty/EAVxy096hXJh8
	BBfOdA+NXsG0S+63a4T98=; b=IbmpP2d7GzNX/+HSXk7WvHzuC8pQ+bSSmRixgl
	BHIyKD+VIkQ5x6A39X9gZES13gkdW09ddqZKfOTg1SnpSNwsprT8ouafybAb210Z
	4He9hKZhfCIe+X3J7QJFnKOzqlq+XaitxdtKwcP4zzfTmul7b2K26aNJ70O3N57y
	Zv2ZEfkGtrsXp2cocmgryN6A6AxNSL9sja/lLwYnuWj/jWFNp5OHfXEvhzJAeMx5
	7ySJDkYQntccBzdkZpW/EKRsjBUyBNjlV9EjhdWFqJPfuFMcOWwoMTP+1yGqSpih
	FysFwnvS4NInRpu9ZTnuR7c3ONSljgdP5gMUrE8Y36yKYYUQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dmdqa5dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:05:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LN50TJ002383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:05:00 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 16:04:59 -0700
From: Melody Olvera <quic_molvera@quicinc.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg
 Roedel" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>
Subject: [PATCH] dt-bindings: arm-smmu: Document sm8750 SMMU
Date: Mon, 21 Oct 2024 16:04:49 -0700
Message-ID: <20241021230449.2632493-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V23BZZ22PbsjnKZ7RNkVh-7kZxOz1F9O
X-Proofpoint-GUID: V23BZZ22PbsjnKZ7RNkVh-7kZxOz1F9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 adultscore=0 mlxlogscore=929 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410210164

Document the sm8750 SMMU block.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 92d350b8e01a..9eaea70da559 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -59,6 +59,7 @@ properties:
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
               - qcom,sm8650-smmu-500
+              - qcom,sm8750-smmu-500
               - qcom,x1e80100-smmu-500
           - const: qcom,smmu-500
           - const: arm,mmu-500

base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
-- 
2.46.1

