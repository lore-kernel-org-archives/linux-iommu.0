Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769331;
	b=WB4be6DCvjcx2wWq5NMu8u1ri32d03CJ4RzhEv5xnhism/nyZC+qN2ZBsCYkSsRt9L6g
	 YL+pHj4Blywe3am9HeBd7Wd0FwW2WWhzvcsXV8Ew29aLTiDN5g9Ie33ab2dn4tKFXGerh
	 XGMlPpZSNpBNmJiBx/670jF91euImoQhuSktv4nMlGjK4DldemPxuyLVobO1kUvJXG0v4
	 AJlv6OVkcDg1tr6H0xWbo64T/zYbcMAnOzaEr5ZUBNGjq+Ld+0F1oWzdJM0qn4Z59oPq/
	 U4WVXFyZnyGQMGl4mVXeBPNQhggo3XhrwOZNvax7AwIbIuxd6A77Lr7geieuTvLQhWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769331;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JkFeBAeIFGXP9H+b0e/Iowj6DYNaFp8sLF647Rx6ZZg=;
	b=S6MP3aWnUPp8e67dY7ebTRRcazovkDDnFuLFmcDfzUhNP61wR39x0Bt9+hDC0zwpe+UV
	 R6UVaSRVUTcny1q9omaEOPoAqlB+KWFXTtlDHqY/X+4lUFH7EyWU4zieSQ4cTYLbqf23s
	 H1EiIdpSJ6vlGNOdWVIzkbuZdMeCAJ0iNCCQeSuL6R4uwEUJwn2mRWbsl18bNeWaO/ooc
	 L+UwUeetrJsFBj3QdGDZySeBwStE3My4MsJOfTtWFf3+i2da55A5SfbrpDeICU9xHBrgT
	 sKOQmPIipXFggRfopqHroW9s8OCvzjqT1Vut9G13C3tHLWTp1rpvbRxEuPNPAVxZeew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YRYjCWbz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43143606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 08:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43143606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YRYjCWbz
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7GbMs3759042;
	Fri, 27 Nov 2026 08:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JkFeBAeIFGX
	P9H+b0e/Iowj6DYNaFp8sLF647Rx6ZZg=; b=YRYjCWbzaY2dpjoew6GWqSJ8fls
	4y6zl8l3QLVZ6sHElAqZlbrepe+fSqfLHoHQqhBdOI7nlrJ9e1YxPVLP+mt/xuCz
	EWMNBYoB981Z/6UHdXdlX4BdjEvH1SPZ4v0TJ5eXCPhSRRMJPVRSizdMKOPUO6NC
	Aa5/8N9cb9xjqBsf76aLfURRyTfGF620UNuZoHhtUkfe3Nglu8vkeoISn11Ym+JH
	X+wnCIDONFtPg0/GZ9ySdPT/qErcaNAg6YNMNlvvNoHdQUz85TkJAY88KfKE7l6G
	onLOnZI06hSQbo4YgX1dHV3YtLvJqLNbi6A8kaAMnejOUAy5uk4WuyE0mQw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6rhvj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 08:48:31 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR8mSTR003713;
	Fri, 27 Nov 2026 08:48:28 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mohis-hyd.qualcomm.com [10.147.253.64])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AR8mRem003697
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 08:48:27 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4840500)
	id 9B81A6AE; Fri, 27 Nov 2026 14:18:26 +0530 (+0530)
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
Subject: [PATCH v2 4/4] ASoC: qcom: q6apm-dai: Allow the mDSP IOMMU path
Date: Fri, 27 Nov 2026 14:18:26 +0530
Message-Id: <20261127084826.916361-5-mohit.sharma@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: pru62GRbObx_Ac9MDrkJvZ0-zh5stAFf
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b0943df cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=2pjKgLFfhSI-GXVsdeUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzNCBTYWx0ZWRfX/WKZLsHxIRnm
 4mGtX8Kd7yelUOiKOlnUhqXBEKoZUkbyJn8a5+RiTvFZLo8ovQef6SJTxKT/FHnKHsIcWsFV5mf
 etl/CAFnmw9FCOm4tdN+jyoTP1ld/qo=
X-Proofpoint-GUID: pru62GRbObx_Ac9MDrkJvZ0-zh5stAFf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzNCBTYWx0ZWRfXwW9Cw+uaFoXj
 HriDMrKsXgw4muBzqaSPbSVbUFJ9Ts/BYDhp82iQAlpEs3sCCmy0BsYOAFlh29iOO73vsFlX5fK
 Z3nO3yKKHDHlrFN6geJlUPV7Q5ppU+tOQ90Wv75ZUji44mOQ2/fJdGWbTMqo65GwR0GEKMrmUls
 sPvAFiBL66ux1Ca5X2p8K01A40TvPL9YC6UOzp1IMTpFYg68OPcR+1Bj/SsS7VkKq5K2mPRCcf2
 KrgEQoj1+JbIfG1YWV1cUk/3wmiPP8BAFXfubcTVdJlI88m5Lqr32C7Mj//mSgoqeCx5EwIPOeY
 at5kA8T4wO626cOVXH1QxcMQSqukD0UjMDwABYklpToNON5bQzHt6L8K6wWFtDUAHRdt1GyvMjo
 WmCfgvNAAvWYYeVrniK9l7/BP0cIpPtipgt0BHz7P6T6xtlcL3GbuYHPMhLe3cxygSLcVOcSTz4
 ZIVfoY2iax1tkY9CTdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270034

The q6apm DAI currently selects SCM buffer assignment solely from the GPR
domain.  This prevents an mDSP-backed DAI from using an IOMMU, even when
the device tree provides an iommus property for environments where the
mDSP stream is routed through the apps SMMU.

Use the parsed stream ID to distinguish the two memory access models.  An
mDSP DAI without an IOMMU continues to use SCM-assigned buffers, while an
mDSP DAI with an IOMMU follows the existing DMA/IOMMU path.  This also
avoids requiring SCM availability for the IOMMU configuration.

Fixes: bb8afd437d79 ("ASoC: qcom: q6apm-dai: add SCM buffer assignment for mDSP platforms")
Co-developed-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index afa4bb095e09..94302837b93b 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -1221,16 +1221,11 @@ static int q6apm_dai_probe(struct platform_device *pdev)
 	}
 
 	if (apm && apm->gdev &&
-	    apm->gdev->domain_id == GPR_DOMAIN_ID_MODEM) {
+	    apm->gdev->domain_id == GPR_DOMAIN_ID_MODEM &&
+	    pdata->sid < 0) {
 		if (!qcom_scm_is_available())
 			return -EPROBE_DEFER;
 
-		if (pdata->sid >= 0) {
-			dev_err(dev,
-				"iommus and mDSP SCM path are mutually exclusive\n");
-			return -EINVAL;
-		}
-
 		pdata->use_scm_assign = true;
 
 		rc = devm_add_action_or_reset(dev, q6apm_dai_scm_cleanup,
-- 
2.34.1

