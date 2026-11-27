Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769332;
	b=vqnar+IS5UMiNyxwBEszF6druCU0HzJPO9HqZMbfd9MT40LTQDgDYsSp0jwfUtD/emAF
	 U08vX09UNWncqcuQvxi2j7i31uGqWxEEx2CKxMHHAE3iXsMWxghqy3IXiIMbgOWFChApR
	 nRgioBTxPiWIIcs4WiwN6ulFISQFbMTz0Esg6qdsAcE+7Itvuod9/yt59wfVONiVmyQek
	 RY1TD3kGOyEyQLLgW0d/DDEuUHhMTpWDgpyzrRN1cAbBwyKipLvWesdwQYcReslpOOTzR
	 Fa/8Yr9fiRWvSSDVXHPbBrubiR7aVJBbmPyIvGFiyGcv3w0/9Z5Aq0kP7a5NxZMTW7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769332;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=GRTB6scsvX2+8rRiFj5H5s6fLmWfs5A6B4E6WVX03y4=;
	b=b0TFTMXOpEsk58dmkI3rIpCe0DGYO60YZRcea3Kb+9u817wkc7tVfCUvCSq8BCmJENbi
	 rlL8DP5JBQhKgBMaF/WuyOejs2CR9f+rxPuUQxAEtM7l/7l7UXzxqQ/eaUeGMqjCtfU7X
	 /OG6CilsN6Iq7cchRa1dvnSmnJnoI0zziAvScCd675FGSVIQAcPQCb+QD9VtCKNWYnGGM
	 BoQR8TLYucG7AVjRd4nFdmJwGUk8OQphg1JKHSEbRbG+cv3w9rIIjSZQrOnfnV8YsInps
	 UptFGd+vHoCkMbreJoDzU5lfH9z5Yt+Xg0WV5pnNN4zlYiHJCJ9Lm/Lo50MoOOcl1xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=btDpjFHh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61691606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 08:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61691606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=btDpjFHh
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7H5bd1076621;
	Fri, 27 Nov 2026 08:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GRTB6scsvX2
	+8rRiFj5H5s6fLmWfs5A6B4E6WVX03y4=; b=btDpjFHhO2VzB2DxQ43Q2bcrL5q
	wvmWwkm77Ci0U0cRIeAwKGjnrenT1NzSWbN2ttkA7h00sRQXAeYMPu90/yFzG0JD
	bBvuNfknEMJ4qakTXsRePwNid6VSAf7QvMOHmt44pxb1ul4LeZG7VA5rNH5u3L6Y
	qIVtrHEbiIJwMLx33b8J9EiZ2JkrlvcJmgE2s7eTEvKSfrSWSH1KLATj0MtR6VaL
	PvFn8x3UJPjrv2+sHfaWQ1DAbNtxUkZTcmbeES0uxnsf/t9hs6zrgZRs2zEtkT5Q
	2ejM0e7cjKy3CsUkvSNnNmaoWcrOB9kksgX5l0MpY2rcNyjHDQVIu33hnBw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u55t24q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 08:48:30 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR8mRaB1693406;
	Fri, 27 Nov 2026 08:48:27 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mohis-hyd.qualcomm.com [10.147.253.64])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AR8mRTO1693394
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 08:48:27 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4840500)
	id 940C163A; Fri, 27 Nov 2026 14:18:26 +0530 (+0530)
From: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mohit Sharma <mohit.sharma@oss.qualcomm.com>
Subject: [PATCH v2 1/4] ASoC: dt-bindings: qcom,q6apm-dai: Add Shikra support
Date: Fri, 27 Nov 2026 14:18:23 +0530
Message-Id: <20261127084826.916361-2-mohit.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127084826.916361-1-mohit.sharma@oss.qualcomm.com>
References: <20261119164705.1594066-1-mohit.sharma@oss.qualcomm.com>
 <20261127084826.916361-1-mohit.sharma@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzNCBTYWx0ZWRfX/tGUYjqGOuLX
 0mkOi26k7mQzlsIfqZYdTyLDFBoIGY6oho/TSXaajW4Z7morxf5BCR/NYeYpPd44LFbs3e/xrwK
 xAULddIABHmCJLCXN2+yRd2dgynACu8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzNCBTYWx0ZWRfX2LNr8SUbScoQ
 8ca6m34sr7xtP+pIn8xzqe7whkjfo2YUHdiF2GSdnIOnvqRpft2sKoH0MsEowJkfCPIP184zn/R
 CIOuQoV89eALt8RywZuSMsdAJEZVlidqeVS3R/eLx/E7M/qanQWMYjr7XVTXk2WMJiAoGCVRFfn
 eqSMfLRGWjGwQgaOM9n8jpTaSCOeMcOgNnUe/WHw6j6UBAQLOIz9z6vlbTnUZDVnO74Vo6HiCbO
 0mRNlPviF7TslfxrhHT5xbZGBVDck3+cz8Td63RCN4rrs5MEEJ7qfTZtvMs+2N5D63hfCXvxTgD
 WiD0nmAjdG+28z/JZ3KEmfIy9UslG2ZtozZ3JG6VrNdav6U+wrOr8yb4Z2F4WF2uQLKdppeAa7b
 Hol+FQwZgYz4RdTeV7uCoXgIWnhhZSy4HpnHVFcldDlgoO03rj/c6ijpjxTyxeBRugiape8nC+A
 pEcz9ZLKNLyqCl+Q5nw==
X-Proofpoint-ORIG-GUID: hAjDorOppvsG-_0KMWh2QOQ0orTbt8IV
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6b0943de cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=Mho0Gg_QYPVSDt4oThAA:9
X-Proofpoint-GUID: hAjDorOppvsG-_0KMWh2QOQ0orTbt8IV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270034

Shikra's q6apm DAI needs a SoC-specific compatible so that the Qualcomm
SMMU implementation can select the identity domain required by its
firmware ABI. The ASoC driver continues to bind using the generic
fallback compatible.

Shikra uses a reserved-memory carveout as the backing pool for its
audio DMA heap. When Linux runs under KVM/EL2, it also owns the apps SMMU
and the EL2 overlay adds an iommus property to the DAI node. The resulting
tree contains both memory-region and iommus, describing the allocation
pool and the mDSP address translation respectively.

Allow the Shikra compatible followed by the existing generic compatible.
Replace oneOf with anyOf so at least one memory description remains
required while permitting both properties in the Shikra EL2 tree.

Co-developed-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
---
 .../devicetree/bindings/sound/qcom,q6apm-dai.yaml         | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
index c1f9fc9eab64..8ad20f95c814 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
@@ -14,7 +14,11 @@ description: |
 
 properties:
   compatible:
-    const: qcom,q6apm-dais
+    oneOf:
+      - const: qcom,q6apm-dais
+      - items:
+          - const: qcom,shikra-q6apm-dais
+          - const: qcom,q6apm-dais
 
   iommus:
     minItems: 1
@@ -33,7 +37,7 @@ properties:
 required:
   - compatible
 
-oneOf:
+anyOf:
   - required:
       - iommus
   - required:
-- 
2.34.1
