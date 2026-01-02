Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB393191BC
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358217; cv=none; b=l1TlBz0B0q1+lD4mKyod0TZPbzBAMqAl44YhQbh64+cP6fivSajygsZ+oM2zTPh6FJlgDVDPFHE6EMiFfTtBPGaS0O2PjdrikPM+Q32KrD3EAUj6bdXr8BOqs8suzt8L7cgyqqW+dpwWnkRqeWnO4zpGpbtFvvm69OV/eLi2RGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358217; c=relaxed/simple;
	bh=f0tamSSSQFETd/BZgOeOBR45ekM+X1VWM1B3+8zR7G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7HTyTzrORuJ8oF85bN3zPXHPJ02ku1rNasH1C7moGbGtzZNKFq96udxqQtftHjS1GLgjbGGa6fcB6Qcw9/GZ1ajWjfsmd2UwBpbeiXon8/1L+xxvKjccHe/gHLK8Hgrl3lnILiD8LdjY6JQ97/Lb31ZtpmOoCfMVin/Yy+CjXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G7ZPQnui; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QjSNC8XU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G7ZPQnui";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QjSNC8XU"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029W2Qk3961084
	for <iommu@lists.linux.dev>; Fri, 2 Jan 2026 12:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=DZfhIgqMaihcSk7F0bvXWQ7mJhxuzZv9ZWK
	aeLwNCbY=; b=G7ZPQnuicD7TCrqX+36FFvKDSA1U0y0gZh8PDVrBhL3xj/yJhyh
	zNEveQq40Q0qXl+BMsePEER2txjQXHImPe7Gm9JqZDc1Sp2LAz18LlqrwVRt9fdE
	xFAuypL4FPALAt7forQPXjeYP1gCdCS+VUTGaTZpFiOdF15WHpqYOo+h8VFTBNOk
	Ryyea6PvnsgfdhvB0dqpwVEEMsO5djqZlSNOwhMQerQ78UryonDu93xPVihufoM6
	9TaFGIDaqJL9Fl6pgjOBO10BdEFSujvd9SxWkuNRfkRMJdOk+rTnA1DEMXyYesqO
	ar1OxCtc2rCCaxHF7P2ztwHchXjIikwm3Sw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd77v3ff1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 12:50:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee16731ceaso237578761cf.2
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 04:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767358209; x=1767963009; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZfhIgqMaihcSk7F0bvXWQ7mJhxuzZv9ZWKaeLwNCbY=;
        b=QjSNC8XUqzJzMq/Mz2CEtbBXnXwkCg3hrAooEdkUkdQY3cn1RpcTz6YW+67j8VXp7Q
         8dU4kynlM5v5EXBZpWaDOVfveAlFhnbSZA01m4xLgW+kF6n5x+Cv6LYy4Og2VaCnGKno
         IcweM/VrA8+3SumCc6eZXP57cAvcfrlcwk9JZlOT4nlDK/Huzv/uQUBwIk1NDfFVzq1F
         ihc0Cx450g/REvYBs7G+kR8lk+9r8ehtXNrahCyrijlYFvRJTt+G3hCgWNx9eadg+cTn
         AU8v4LIiqkhLl4xWMsyeTVkMfZWK9rqw1IMcsKbJ8iRbgt1NPJ9gbfZdOZ2ghxEnEe5z
         UOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767358209; x=1767963009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZfhIgqMaihcSk7F0bvXWQ7mJhxuzZv9ZWKaeLwNCbY=;
        b=GcqD3FxCJuRbXQoL6eHcHOZReqhqUD0G8FMe60020NhNq7P6KYsuXyE+MUK4MJp6t5
         DQI8esw5TmNLoWDDwewWo2PxBUrLd5pGaTaijsnjtqn074n9E3jtLEqKHwrMq9V/wrhh
         SaTuwX4iKraFz6erJfdjy9/pk7KQ85iNw6wmyxypJotPDM28DnypmORJNYjGKHgNMZe+
         I3La0vxJZIHmE4x3T1SXKNbC3yrvEzGD/a5PJNGBztAcCTDiuvau6orX2eBLdO2CJvcR
         tLtlxlkG3k1JcOWsUrUykxhzy9wKzD21dN8CzDy4m3bcZ/4qBZrkYCqaC9BIloib86Zo
         7QLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2JQ6k2ZEwuxUTBKVOM9M+mozMDgmVf8PIRVxPNcoHXs0bYELibUc4tNlbsHsqEO4GMicZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfaJO2hr0494LdfeEeJbmaiiXzdzP2I34Ocm+RwtRpnGEuqund
	MhVogAVl4VRRyPFgLmhy90sjIPjDcRCF4Pe0gi82/sGbO4Jj0THeFzllQRD4b0t13MSWwXcv1j2
	7DxBxgqeUghMFz7/xlOrk1ovT5DoazhWNd/O5twFQvrEjk1uAZlOWqTgkhA==
X-Gm-Gg: AY/fxX5Qa9X3UZIdxI8Uq9ec6NmG5igbfwujhH/pLdxCE0AmnwXAXKA6yxQogvNkcB4
	OdLFHFHhsoFaM47czGtyXs5rh6IWpUJLsXviTsTj2AAtIENzzqSWRiYGvm+VYPeUWOQ+0N9d4XB
	UyYURJa94+GyU0Hy+R/k+HEJvkJ7M5xVDcRd4UE7iGTE9gU+14Tsz9zhJ0NeXNeKCVSneDgn9ZA
	UMZmymJ6dUAni0QiSt2u1Ig8QJSmYRnpQntiOpnHJOnrLnVDwwPmRXEZZ6H5GE9kEDUgyGaqBpL
	cvxmvOZYhyeGyDt3nIP7luea0KNWbFtlbJCsdydaKK8omgvM69EVB+c+5+yskvgZp73ZBEimot7
	jx1y/LKMyh1QGLIAhJIKp3Ih6uA==
X-Received: by 2002:ac8:46c8:0:b0:4f4:c7c0:bd15 with SMTP id d75a77b69052e-4f4c7c0c07bmr435981901cf.12.1767358208824;
        Fri, 02 Jan 2026 04:50:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaibJGKRcufVQsFtoFkkLusGl1EteIcRijgF1eum1S0BpyBUz176ZDnEeSiz3Y7Vi4Imr58w==
X-Received: by 2002:ac8:46c8:0:b0:4f4:c7c0:bd15 with SMTP id d75a77b69052e-4f4c7c0c07bmr435981571cf.12.1767358208430;
        Fri, 02 Jan 2026 04:50:08 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3964226sm340423585e9.0.2026.01.02.04.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:50:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] iommu: arm-smmu: Simplify with scoped for each OF child loop
Date: Fri,  2 Jan 2026 13:50:04 +0100
Message-ID: <20260102125003.64962-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=f0tamSSSQFETd/BZgOeOBR45ekM+X1VWM1B3+8zR7G4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpV777jI8tCOET4TbjC+HPZB2dgMi2DF44wcwnd
 7brPjPkQ0+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVe++wAKCRDBN2bmhouD
 14dLD/9dX7/M267GN7byFB1WBkxv5LFfVDmSjqOu8wDOq/vbys5RDZBtmo7t46mLBieqJl4ivae
 j+2eaRVbXnSe//gLWSK12TcZ96tvCg5QVi3itFmmv7/acBweHB60ZQn2xje0chv70QcD5BbCAfJ
 zU/N9NWfFipg19oPKvJUB5jwbUDk8B5pc8rK8ay1Wv2SuoDsz8HRki+Y38RBiZjyotJ+wJRVqXZ
 n8AIApW0sJFoNNZ18SCw4LH9qZ+ZpjBBdVdrrOrKdqMDz+iZkvK2QZEQVr6q7SbL52N8Hd0Jxj4
 EPkUfezX2iSykBXPwLjA+CQZx4WmeMXZKzgTjfQj4QrD10fA189YWUriQ8D2llQFQO3Kw6RyZRc
 WaqU9VKpNglcQsSdb0NRzAhS2kPyHwnDhHQSxqHsdYuFPO/L0xhF30LV/lz1p17D71jwUWC4O5L
 lXSZDRw3YyWJc3mQ81kGEt+eTZccennc/rXx5fnoV8xqO4fbEjwXqzV0+I5OFiJjthjEGMNrUdB
 X+Om0XFx3BVsxiYBaIxkjJJ1YJDlgH94hbRz7z5x8Kxh0RiIV3isDQjU9pxsJkzpvfreP2mHeuB
 pxNuMg7fIBfqDLiY+4JEM/r8LPajA58BR27l0SpqoglqsnsnIPtQqa7JljTi2jwiZzQ7ioYFUgi sbGPVJLBsihEYiw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5i5l6Hi3XOMuGAuNNB4e0PhtUts2CST2
X-Proofpoint-ORIG-GUID: 5i5l6Hi3XOMuGAuNNB4e0PhtUts2CST2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDExMyBTYWx0ZWRfX/kmvMo2P9l8d
 +HOCRH8kb0MMMOXUlTLkF7RdXt4PQKv18djBjdeDrYXHYzII4ci+AaRqcrRlPg4oTzw1SwBo/3j
 60/qIu7bpOSZLBI0NADSnkp1o8q7e7nGUlQMWl8xV+1EZR54eCOToJ2dQnFTGJJhB94aQLV7b3c
 YstXZoSc3GhCZgNvSK/UTo8YgEYz5lOaOEF9wm0SnIlSudz+5ozKZ9w0k+UDMxLD7/VxJj7TikB
 KCImEYqWdNCD592t1/MlkGTdzcsl5vIWJEUaBgW68fbIbVFAnivdPps/Lch1Nx5bg6Itj6dfppn
 vmib15QT2DaX8Iz2Wn6P7uh+s3k2Hq7Zv8hMeU33//5WJZDkjPcrCHD1dqlMeCiw1TbBTZL6a/k
 /VfsUyTvMUxcSn2i++7bK2DgEsdhMl+MbBjtAU5ecFVuzWqb2t5TqxDMP6uUcSTlZOwc2czfL5L
 hNqEdf8EzG5jIpgA2Gg==
X-Authority-Analysis: v=2.4 cv=ev7SD4pX c=1 sm=1 tr=0 ts=6957bf01 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DNxOUMVqX5WKlv-K9SsA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1011 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020113

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index f69d9276dc55..c98bed38c58a 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -761,14 +761,10 @@ static struct platform_driver qcom_iommu_ctx_driver = {
 
 static bool qcom_iommu_has_secure_context(struct qcom_iommu_dev *qcom_iommu)
 {
-	struct device_node *child;
-
-	for_each_child_of_node(qcom_iommu->dev->of_node, child) {
+	for_each_child_of_node_scoped(qcom_iommu->dev->of_node, child) {
 		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec") ||
-		    of_device_is_compatible(child, "qcom,msm-iommu-v2-sec")) {
-			of_node_put(child);
+		    of_device_is_compatible(child, "qcom,msm-iommu-v2-sec"))
 			return true;
-		}
 	}
 
 	return false;
-- 
2.51.0

