Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106842;
	b=P4EID4jfNxwE9xO0AwSclb/xBNA1dcXxZ6/0cTtdLbA/Ya1NmMPXV8HTv3Fadqu4VkLY
	 QWOX4+kcq17H0h3CltAHPpYv/w55HHzuxLTK3QEwrTZXHeglf+mvVXqxBl3Af3ZsrUp3T
	 57KPiKjWU53Z0uuZe8bX7WaZcZnuC/eXiQv/FuSGgD7mjGXlLTqWwQExkLELW8EXb2bYp
	 FPgk1DXUk0KkADdvD64OLVi9itGy0cvjSE005SJWCK4qhzds9N0QBwZjwio5gKdZuAVBu
	 AhzccyjWHjfYnmeaPnQwykjtmnpAHLNXGly6B4bmooNHx94kthm6EhaF/4XeLPqO0MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106842;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EEqBQHkznGJoblBjoEexALIrR3msTp1bolN/HqeRkTk=;
	b=E5lC9pOn2vpBcijalVhwFxBGRLj0NtHCYegOMwN1s/F6qL+AtYpM4+2/skbhB6iYjDpF
	 5fXe1O87hlsQ6CQNMWkb0pMeqHRHE1qjxXgPlFCsMzyK74/MThgrHeWhArxN5tQ1Tnj6c
	 CJAwqBAWEap84gUtIFKrhp2vTW0yme98/2t6o2eYoBOEZ+9sBsJJeUgXC9IMCYUII2aeH
	 Gsi24VzZZqCSucztIgcFtfnuO9u6u6AoiRcgV/E4qOC9DhSxLjvtTvltkkI+JEhXYZxK0
	 7HHCQIi3Rk3Uriwl1dOoyjJC9hg4kqYVdrYokRE2EuVLVAzznADAdM2YsKnzzUU+DaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nTGyK9EF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57460A2630
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 16:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC57460A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nTGyK9EF
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJF73SJ525317;
	Thu, 19 Nov 2026 16:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EEqBQHkznGJ
	oblBjoEexALIrR3msTp1bolN/HqeRkTk=; b=nTGyK9EFrrvz9QhIF1I7qQyU8Gp
	j7m4pI93WMRIzWD6xwDv6TI0EWGZAcgKvXkgdCJ9ooq568UjRSZOMR5yf2ynOu3z
	Ng1sCXeHmeaMzoXWHb9Y+VNBqQdtwjrNAPlS7kKXFTQ9WBoHagDAzcIkCvcejV4K
	2HJdp+w2ozEGMrJHYf2r3mqfM5XfmdtuE2Mw9XXwykdIPEjoEkpVGbDuQwFHHLbj
	mChUnTcsd34aRAgq37AUPJSO6Vz4CvdhwKwg22UsrfgXH7zlZZXwNLw2VTKYHtiL
	TuVfAB6kAaVpKd6FcQQfCbyRATz8iHRfmWrg048M4GSEXhE9FnmFKp43/Sw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1vv2tdpp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 16:47:09 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJGl7mY3118417;
	Thu, 19 Nov 2026 16:47:07 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mohis-hyd.qualcomm.com [10.147.253.64])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AJGl7Jc3118398
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 16:47:07 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4840500)
	id 041D76AA; Thu, 19 Nov 2026 22:17:05 +0530 (+0530)
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
Subject: [PATCH 1/4] dt-bindings: sound: qcom,q6apm-dai: allow Shikra compatible
Date: Thu, 19 Nov 2026 22:17:02 +0530
Message-Id: <20261119164705.1594066-2-mohit.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119164705.1594066-1-mohit.sharma@oss.qualcomm.com>
References: <20261119164705.1594066-1-mohit.sharma@oss.qualcomm.com>
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
X-Proofpoint-GUID: JeVkKwaBpiVD29MIHFVouPHDfWLqiMmh
X-Proofpoint-ORIG-GUID: JeVkKwaBpiVD29MIHFVouPHDfWLqiMmh
X-Authority-Analysis: v=2.4 cv=ZZWIpcVA c=1 sm=1 tr=0 ts=6aff280d cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=0_GNQTBepOQCxTtxIJwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2NiBTYWx0ZWRfXxJzKZwopstic
 AGAvZQY0cuK+oS+4C52AVD/FIFVMwde3qg2sNkosOmQJuqOROm0vYOhadwdWfSflMbIQVsXq68q
 2Xno+mauMCkMjaCI/Si/XZQuHOTEano=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2NiBTYWx0ZWRfX0E8gvcgjDBO8
 HVBQyFLpSfMcgAC/vLKYbt3NFddJbvQ9BMYZIL1Vcub0E3YpoeViN77OIyZjwrZ4mRzJC6RapSr
 U/akl/hgx5066NheWIqut2RUt5ofb4HfkBlMalgp6YXrRYy+3mSG4T5CbVRj6gb05UCPN6okMGy
 eSu2V/4CAPBfXHCwV1nerJ2PDbmWQzCZtp3r5tLQBSA1oc2GlRxns0Xkqsg/7lUJJSjhGbsSUJk
 b1wUG9LXn4t8o9XgoEFGzGZGm842Te2/ZihE0fdcAslLitFQ16Xdx5vLnJD8p5uFw7b7WVYqfX7
 9par4PNdjiLuBaYJjGuz+QJ4qaoJzrig7RyvKYHRG/jbDrkytupIQyP+fnjeySRQZhETwaUTctv
 SF+yG0EYeLDRmTfqfdOQK4b9pYDT/8HK5DrL2VblgVRhxI6YQuLsHcpp0Mfv0bGru9VBrzYhl67
 TH9iLXpWre3RFukaE+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190066

Shikra's q6apm DAI needs a SoC-specific compatible so that the Qualcomm
SMMU implementation can select the identity domain required by its
firmware ABI.  The ASoC driver continues to bind using the generic
fallback compatible.

Allow the Shikra compatible followed by the existing generic compatible.

Co-developed-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Mohit Sharma <mohit.sharma@oss.qualcomm.com>

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
index c1f9fc9eab64..c5eea6698ab6 100644
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
-- 
2.34.1

