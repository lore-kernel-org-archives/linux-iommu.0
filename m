Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106843;
	b=qEZdLtZkk2C6rP+MHQSneFjuECnxh2hrp/d8/Ww5laI5nbpWc25/xe+i+Xa1ZMBO4C8Q
	 SUwyRnwbdr8IccI+mT39JKV2JS6kNbpPbmzxckB/PgAfbMPnjzl18i3BrF16GrrciYrpC
	 P/0oEOpgitppjHHeYQnHjWee9o9GJ7+JwvQUb633Igs2JLJVeeCAVmght7I43yRS1rn6C
	 IQD9fDB4G5JgPwI1RG0cNnJdJfVaD2AK1eQKaIZXLoiK7RO8ZDCmkBAixiq1ACHuMRe1m
	 mtfo7ykPo+eut0l9N3or5k2oqcI4kYKqvp32PrfMv0U95anHgiqKuL37WgvHyIg9dwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106843;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HmwzH/OBHzhJkAjXh5yZf/iNN73jErTo3vey3XHTBLY=;
	b=HOAfckHJuaVHXVa7Vvsg9jn0lO2CcLjkK1X6kUf4y1EaOqDiFmROlXs8Ruoz87ytXMzm
	 jFjXoDqToOydUuQubPuKP/32BtfVaKV4auLl/PS3rVnZzDy33pZcq7rkcXgYulR9c5iHc
	 b+d7vI+4l5VFnIOdC1brdLxJOWImeUnHNY+j+B9PDe6utbFF9AImzVqvkJPn0LDkDPzRQ
	 aEap4BGPsE8CygO3HyaG3n7LffJLvRefW9BE+SGhH6n+C+oXl9l7FHgEtTpnNZzg7oPXf
	 EijElLCSdg3uBqpodLFPfnGf9mQpyzfNoB6bJHPWqOew92Xsb4+Yq4MKNtrm3XzOuWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iZEIVbX0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74060A2634
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 16:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E74060A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iZEIVbX0
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJF6N7Y2773680;
	Thu, 19 Nov 2026 16:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=HmwzH/OBHzhJkAjXh5yZf/iNN73jErTo3ve
	y3XHTBLY=; b=iZEIVbX0iHdFhhfgryfte1/3dHCFkIJSY1HPBHjm5um3xsZHYNx
	CF6AIZfFJj9qO7axGr0T2pBxu0zJ7/WxNGbJWiY0iY5+AMNOcOr1ygjadLVzmijc
	pyybRvfVrGk+fvGBZkoSIhWvR/7UG43QG2RQdVOrXCGTD49nD1pG0NsWfYWj/vda
	637H9YMr7voEVOnG2lIJDcywOrH3EqV8OzZmswchMLOivfUEzav4uN/Vo+BZUFJF
	+DtsmVQkVj7Js1U0H07ZWr0KW0/p9bq8LNwRV1LQdUNMRy0kU8JFkeDljkAmMgPV
	NvvMiqs47MCyJdO0wwseJu0M0ut4SLXxDTQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1pdcv09x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 16:47:10 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJGl7sX3118419;
	Thu, 19 Nov 2026 16:47:07 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mohis-hyd.qualcomm.com [10.147.253.64])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AJGl7ej3118399
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 16:47:07 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4840500)
	id F35686A9; Thu, 19 Nov 2026 22:17:05 +0530 (+0530)
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
Subject: [PATCH 0/4] Fix Shikra q6apm DAI under KVM/EL2
Date: Thu, 19 Nov 2026 22:17:01 +0530
Message-Id: <20261119164705.1594066-1-mohit.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: 8W2-Pvn1u4VWHd6K4gJKqcZbhjwOgWLA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2NiBTYWx0ZWRfXwWFNsW72DqyI
 w2xY1NVUE3zTD3wJbw7D1W8KtwcErf+ubAM5kYWhfjB0/GYbP66kBKMcugyG21X0fuySTfJuMoq
 VajfMfSjpvVya8kb3xi2UOSSYFG7fwE=
X-Proofpoint-GUID: 8W2-Pvn1u4VWHd6K4gJKqcZbhjwOgWLA
X-Authority-Analysis: v=2.4 cv=Ma/5KJ/f c=1 sm=1 tr=0 ts=6aff280e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=4aPcuxPqy7qNQcLnAOgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2NiBTYWx0ZWRfX+dRkCAwhjzzC
 YxhTLeBlF1kXRLRl3RzdlS8YcR+BVwqMj1LB0IFCWf/JpiLtIHST4T2ZiZg8iiDD/PGC4BDFq0t
 lRACLMvtHIO0EDMfhcF8xrqumLksgenaYB434Av01aPdRMtsXJM3Ejt3FBOLHrZPz2RY2eSwQzW
 YQkNDACdoWiCJp3gYM7TJBWxKvP0O8rKohbAk9y0CR1xvUUE9FoW5BkinF9S7WI0rjjLzPhqw1K
 F77hU2wFrV2PljMH4NiqQgGsjcoJCzssHcq5llXuqpCzDdFWETqXY/BALgEoPELfISEcc6z5tiA
 Fb/ZV5w9XdvcRnik9tOomzubnR4PcssWDJcPyTjzUWaUUseZfr/JaTLK07KqnPZUxlfPWwgALNG
 JCc3x3ZsSaw8x0IcQ4YR6RdK6GXHgA4SAVf/9EH4C7y9L/K3UDDOydRquEqa8pSbgv2ZeQWAfcT
 rsW8GdR2O7s2DGClMEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190066

Shikra's q6apm DAI is hosted on the modem DSP.  In the hypervisor
configuration its shared memory is assigned directly, but when Linux runs
at EL2 it owns the apps SMMU and the audio stream must be described and
mapped there.  Using the normal translating domain causes context faults
because the firmware consumes SID-tagged physical addresses.

Select an identity domain for the Shikra q6apm DAI.  Also allow
modem-domain q6apm DAIs carrying an IOMMU specifier to use the DMA/IOMMU
path, while retaining SCM assignment for modem-domain DAIs without an
IOMMU.

The series is ordered as follows:

  1. Add the Shikra-specific q6apm DAI compatible to the binding.
  2. Select an identity domain for that compatible.
  3. Add the compatible to the Shikra q6apm DAI node.
  4. Select SCM or IOMMU operation from the presence of an IOMMU stream.

The Shikra EL2 overlay is expected to provide the q6apm DAI SMMU stream
description.  That overlay change is maintained separately from this
series.

Validated on a Shikra EVK booted under KVM/EL2.  The q6apm DAI probes
through the IOMMU path without the previous SCM/IOMMU mutual-exclusion
failure, and playback and capture use the per-stream identity domain.

Mohit Sharma (4):
  dt-bindings: sound: qcom,q6apm-dai: allow Shikra compatible
  iommu: arm-smmu-qcom: use identity domain for Shikra q6apm DAI
  arm64: dts: qcom: shikra: add q6apm DAI compatible
  ASoC: qcom: q6apm-dai: allow the mDSP IOMMU path

 .../devicetree/bindings/sound/qcom,q6apm-dai.yaml        | 6 +++++-
 arch/arm64/boot/dts/qcom/shikra.dtsi                     | 3 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c               | 1 +
 sound/soc/qcom/qdsp6/q6apm-dai.c                         | 9 ++-------
 4 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.34.1
