Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769334;
	b=ykStq+tpdBOgxEsjRubZbbFfCX9JNdVHU5d1nGhKGSZows3Vny03HO3gx4Q22bMaTuq1
	 AJaj6CpLFUNfijiTdXZIEIQZuzkA5qTsyJ2iyZs7G2WuM3aRk+glLMrf0l05dsFOFKejf
	 2URLsM/fHFMVojTJxO93Wep0qqCIic5T2RDLBYuSF3LuwHVIhPui+8NpKb82KhH6WiNAl
	 7ZpnYPPXjksONggJqcFCD2Bd6h6z0rqWSmKMmMoFGzbFWMhNrCpCg/0KFC7CVhMfP790D
	 tbMCCv2sUBgglvx5jjTX1Aib+ddNhTNPDCZJo7Few+DzJh0Tj+rVvsSipkQUlSMmLaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769334;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=K9GE5EqxXG5dSPh7D6jFDueWLhRzAd8DelVKAgzkI0Y=;
	b=H4f59/BSGoTHMNsChp+rLLX5/+5B/33LFmlwktjKQLKA0+epesy5SP7QdNy/JCg8jw2S
	 dAEF5eKQqpmQfCkvB9aga7NfPc8WhBQQ29KbaJ9xSwZd/gnm/FWR9nZGhLT2r0mRWZAS/
	 afG17goyTEBQDDTib96X6y4xfPfKSfv5tLPYooLZ98gMSZyT5Zcg3cGxl/fKJDzxM3ctR
	 RwsLMq0G/b4CghoKBakhq0A4R0j638KKxYCGjwRFQsQ3ZA03+frTBug6wCBes0al1l9uh
	 QSkZE4Lnr8fPCD6prcXydJs6sbiZ88aIg/HK0H4D4v2nz7/WGGQApCa8vkzzjacrr6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fq9D2Reh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2E606A32E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 08:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA2E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fq9D2Reh
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7GbZ73759043;
	Fri, 27 Nov 2026 08:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=K9GE5EqxXG5
	dSPh7D6jFDueWLhRzAd8DelVKAgzkI0Y=; b=fq9D2Rehhh/KXAWWZ6ifmA40oz8
	8ck1IWsOyJq7pKwhbs4wnamR8n90TCHhsTQTDC/nF4Q82+uRzgytw4A27JhZ2jZ6
	uGM6X41COLW9NCOSKfgt4sY/asrwLKMoTY5krzMaqGI39N0KRx6EPU4gFANMRTpF
	9PGF3xJBb2d+RZ/zS2IJi35mhcXS63wDS1ZewfChdpuYyLcZgW42acMt/IvXji0e
	ARFEP3sMNTyx3Z8aQoMxPJjalGhAJQqwLq/zC7XuIAgqTfFKawjGgOO87njQguHb
	fWryBjJlnQa6HAm0ezpG1rfoyj1vrdVjxMHgtzr8FkMiLC547jlP3+du6IQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6rhvh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 08:48:30 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR8mRbd1693407;
	Fri, 27 Nov 2026 08:48:27 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mohis-hyd.qualcomm.com [10.147.253.64])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AR8mR5G1693395
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 08:48:27 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4840500)
	id 98A246AD; Fri, 27 Nov 2026 14:18:26 +0530 (+0530)
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
Subject: [PATCH v2 3/4] arm64: dts: qcom: shikra: Add q6apm DAI compatible
Date: Fri, 27 Nov 2026 14:18:25 +0530
Message-Id: <20261127084826.916361-4-mohit.sharma@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 4iIrR8MRngmXFkn0F5oDF5dnEeXhAPMc
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b0943de cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=5Lo-wh1e_jXiNIEOTl4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzNCBTYWx0ZWRfX9OK+pLiDFwuX
 sqe3XXrnK+X+5YlngN0OqbynT69tY97LPob5zLmwQZrGSS4VBrOunUA/dH06+Xkmgrbc5iH+k7g
 WFm4bgTxa3Dp+yzq68+0KUWhSIQoQ5I=
X-Proofpoint-GUID: 4iIrR8MRngmXFkn0F5oDF5dnEeXhAPMc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzNCBTYWx0ZWRfXw37i9MAKv+iY
 YUYtp34zo0dDsLt3nJC8hy8T7R0KV6Jgpxq7dOfy/1G7ZrSHUtES9BYX7VjQ4lJ9K5eVrSQyb2I
 BKrYF9PeTfEeoHhmvl5xzPGv5WgenmhGUkzS4UFBkrxOsUAGgjo/xa486X5oVbC75qdpKYTNZeE
 PLegaXSxWArOmOKIl5bogDTTFmcA0aaaoqjB5B7VJxkwFFQVjG6Dze+eDjuelgQvRYiKVcWR/YB
 6d9ew9yoDEN2rozmOBJhmVNxUWzHbTgff/wTM0YFq8CGdYRiLWceM8/SELlM/+8d/wIFlgNopTc
 4q3XRWErg1z/+ESMgXMvh7tfO8ymb1Q/AQFHzvHpoNAIyePONMo0aFazCawZwjpO8cJlKwS8LOO
 oqWqYnR0aVbTf4JCxz+pWVFN65TM8hlM9DXp867aDNSGjOYHSKJcZP2C4PoiTYpHuZ4K1GoU1/7
 O4MkViye2xJ7afIF4ZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270034

Add the Shikra-specific compatible to the q6apm DAI node while retaining
the generic fallback used by the ASoC driver.  The specific compatible
lets arm-smmu-qcom select the identity domain required by the firmware
ABI when the EL2 overlay describes this stream to the SMMU.

The EL2 stream description is part of the prerequisite Shikra EL2
overlay series.

Co-developed-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 0a95ad5a5582..796d5225d161 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2358,7 +2358,8 @@ q6apmbedai: bedais {
 						};
 
 						q6apmdai: dais {
-							compatible = "qcom,q6apm-dais";
+							compatible = "qcom,shikra-q6apm-dais",
+								     "qcom,q6apm-dais";
 							memory-region = <&audio_heap_mem
 									 &audio_mdsp_carveout_mem>;
 						};
-- 
2.34.1

