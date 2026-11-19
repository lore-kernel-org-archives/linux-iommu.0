Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106842;
	b=UC5HTep94ATVO/yDGMbTs2gkuh1N6uDAlF16sSl7STcONh3T7PDrQsN6Zj7sTXVsUUPz
	 VsUGwNCnYEMwnkPv6t+NaQtweC8GQLou83w0cQa3hO4jsWIqgSYnWak4qWk579vJuVNS8
	 wixP5VaLL9SC3u9bl6I162hZ/0x3SBFj2Oc4qdNh9f3OKp5haLQFyeUhMyndv5ATeHaZL
	 6oiSsftjNs0nYBX7ojTzms8XF85jwWPRonPq90rGB4emv37sQt/7TbZFKdqbnBk2kZgXW
	 xqZuIC2i+w5lJZZTRXVMFsInpcPaZ3ols5Nz4qUqYpToZYGhGSarCzcMB6imwaO5BfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106842;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=I3IzgjoqgRpYlsjMaETodoIBxBsclUkysdCAkbOuipo=;
	b=RJjOqJNva0HKVf1onpR4rTJiOyNlRKL+uNrQ0oRLQcLZHCl4NSOv4WuGHj+VOaCrsxZn
	 DoHVVGBd23PDDNxW/QvuOHnxTTt/RyDE7NouD19im48EEJU7CiO0plMsxlRs448iW2H4Y
	 kOKiHFx6PuZ8pTsbedrbrymOltERIjEuolOct1tEh/BX7A1El5Di5y3S9weNsVm60+yxl
	 Osp3E74eNUXspqKgmKXPsy3BUEHUSSbhZzf/RaTPJQpLJBWnSyWtZl+xfFMqKCZLFq7ND
	 AviwD+ZfgBXN1RP9DGI+02eTNoaZSaLrUTHb1TrJOQLvD1tv2GIPD+eqLnDRyitJlUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mzmYZtu7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52E60A262F
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 16:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC52E60A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mzmYZtu7
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJFockb2761886;
	Thu, 19 Nov 2026 16:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=I3IzgjoqgRp
	YlsjMaETodoIBxBsclUkysdCAkbOuipo=; b=mzmYZtu7oVUdH4ReJ1tf2EV1QFt
	8EXKS+LQ/eGt75xTadGbyYonSSzyeuAEXF2mpfl3U4w7Fg+DwZm3Sv0rxt+IQ/P5
	3GlO+VzBCbwntu1LEciia3WWFYpVHD5GyS+kLB/K4aVB0Xfd+gHcuogfUfPqEvu2
	tajBlHQvzzhBpM40moSCcn9eqSm8LIBNNWxPezaTR4cyfyiblGQkdJLgwV0rbSsD
	hGe1MgcJNBhWAeLzapu13vhtsemy8p8L9rIQtFId/a6LhMwFrexdrRU3sf1G4D9o
	mGny+utPCpEFfuxpoDGsJljRs9CdvLDWzbe6WRHR/EWQ/97pGOCLt8xE87A==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1uuxaqe1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 16:47:10 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJGl7E01031922;
	Thu, 19 Nov 2026 16:47:07 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mohis-hyd.qualcomm.com [10.147.253.64])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AJGl7PT1031908
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 16:47:07 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4840500)
	id 05B076A8; Thu, 19 Nov 2026 22:17:06 +0530 (+0530)
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
Subject: [PATCH 3/4] arm64: dts: qcom: shikra: add q6apm DAI compatible
Date: Thu, 19 Nov 2026 22:17:04 +0530
Message-Id: <20261119164705.1594066-4-mohit.sharma@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: cCbHEqWiiuopsuelBigcTaqef3Hss5Hk
X-Proofpoint-GUID: cCbHEqWiiuopsuelBigcTaqef3Hss5Hk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2NiBTYWx0ZWRfX6j1gfv5dmzV5
 YMjtltIBZ2yNrujPunWzhkl/Et2pFgEXU0jtYv8YYXNDtsXu6ODI9S3UODH1T4/Qe1y11ben+7B
 mmCo9kdLJ6IN/e0GmoPzz2F9q+eAyRc=
X-Authority-Analysis: v=2.4 cv=Q89HcI2a c=1 sm=1 tr=0 ts=6aff280e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=0_GNQTBepOQCxTtxIJwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2NiBTYWx0ZWRfX59RtMkbs8AJ5
 YjLg8dkCNDeY3LPzn0rrDSsFijwrKROUlOnbb1HFSaLq0PV07NzuMf8FMEGv1F58WjHZT9/hlt/
 I8q9Lad+2f4IDPRF/8xvS0FwqyNa2OZVReQQWr7RpOwaf/xLYLAvYajDSR+TLR0EXINDLVRnwwL
 myZUOOhy1bEUyt4ysTIbCigM/2vgQKuzVrNjn3Pb9cF3chwXb4dHCbkKGHc6aG+S9GQ09h3CrMF
 jY3k4ubwcHwPKiDEF2iCamImRpyKI/+bN6alWsPw/vkP4b/Mau8xh2iAqem8RN0JOA+1b2SgeDo
 aR05odgwD39xTCKqnDX3cLF1nPic6rx8p5VLcDUoW3AIZOTBN8eAunuM9RDbsaOOiuusBOw9bnH
 Y+7QfxCY8YbXkB76QwUXbmPTgBDJWmwEG4jWMjA4Ii1aEHnHHLxrXkntVdXUdK4kEDTMIk7Kwhk
 203m15fpZDK+9RmBUOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190066

Add the Shikra-specific compatible to the q6apm DAI node while retaining
the generic fallback used by the ASoC driver.  The specific compatible
lets arm-smmu-qcom select the identity domain required by the firmware
ABI when the EL2 overlay describes this stream to the SMMU.

The EL2 stream description is part of the prerequisite Shikra EL2
overlay series.

Co-developed-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Mohit Sharma <mohit.sharma@oss.qualcomm.com>

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index f096469fb984..09b268af9eef 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2983,7 +2983,8 @@ q6apmbedai: bedais {
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

