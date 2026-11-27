Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769327;
	b=eMX8WCJICtljAuXAqemjvcoy3gIK8qHoJkFArv/ax0j6mbknU6OdwcbV+b4v6d9sruoR
	 ede4h3bMqeuePVSmRft3os1BwOZeldWM2gT16M65gMrJMEWsiMzRSuRFnPRg4nkVXfF5h
	 hkbSKgJ2JgA/MdcKAc3bcRHeBWd7gifDVm7vFDfoAJltTl4R5mDVuozMeE7+FdLkpg0Kb
	 DzG5xoC0HB0wN8WWhgcKZ/IaFDLpcVZ8A/y0cE0u4AqYsYdoRwQmxVqnqD67yWLsGE+AE
	 A4bs7TIhs92r6MyN0ux2TGGyqBeZPhgVR4I5Ww3U+2c6FvK/9gv3Jflfm3uthNFfaMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769327;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ufKoELyG5OJVjqqU3c/Qvt/pb5qRk+F+TxVqt+FkFmg=;
	b=hNznU9RSvO1MRJPbqyJBJhlMg4DbwxEnpHcwwbI1Muqiwq4+masL6CT+Ve/0ztctFnjK
	 H44HVZppxu+dsjahW0Ab3t6vMk8wbxFFydpWDst7Sbckvz+03s+9iENPnY2tmrDe4ZX0B
	 cV6S6J4Yew9BcHrAUl244+vumvsohRIvytjHZyXbbOi0MPPXLsdFp/RVz9M2Q6MebAenV
	 8dOLLQuruvkZFzdZypTW2gUn9MViKBy+J6D21vgmmk7f+i04ZYLwK+WfGS7hXLVN/2aH6
	 //ojLVdcKDBi92xU+hY9ptM+XvhwS0JoP5X3mvbxbTMrTaVjiGwBE2CMo4bWKZKRd4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OkdZKMFg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF7606A333
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 08:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90BF7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OkdZKMFg
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7GcNk1564733;
	Fri, 27 Nov 2026 08:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ufKoELyG5OJ
	VjqqU3c/Qvt/pb5qRk+F+TxVqt+FkFmg=; b=OkdZKMFggOe17aEGFaaCtZVdPNx
	9xdMstrsu23pgILp0qZOqHFDhMK3OBNFT4dUE+712Ikj/COgvv4zVjL80d/xDysX
	obmHVDWhrAEisiPtjKqSHJIySClLjeh2fn2YthXnRLdKfVDxaDAsdgx1FbLmex84
	LbqmBQRVP2MfVAgWPy44qwPgB31j0ueK0HKBkhDBMgtyVz2pE+FtXVJNoO2sarXx
	0/koXkp3+aB1dBXRDP30fk9zhzb1hkcJzZh59Y83a3uRoJurv/WcSYNh053D4B8q
	7YJJcXuJMOmCKtiiCgFZmAotIrui24GMKj+fQjSTbwEuqwKxfOM8pdSgmiA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74garjf4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 08:48:31 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR8mSCH003714;
	Fri, 27 Nov 2026 08:48:28 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mohis-hyd.qualcomm.com [10.147.253.64])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AR8mR6J003695
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 08:48:27 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4840500)
	id 963CA6AC; Fri, 27 Nov 2026 14:18:26 +0530 (+0530)
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
Subject: [PATCH v2 2/4] iommu/arm-smmu-qcom: Use identity domain for Shikra q6apm DAI
Date: Fri, 27 Nov 2026 14:18:24 +0530
Message-Id: <20261127084826.916361-3-mohit.sharma@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ZLC_RWqU_nT0re1kPnz3DgEpv7EmtYN3
X-Proofpoint-GUID: ZLC_RWqU_nT0re1kPnz3DgEpv7EmtYN3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzNCBTYWx0ZWRfX11F6Sps7mC1e
 deErkYJTWkPUladT0zOxaYlgUFYzF90RJUU3r796hzVZzTcpPkC8SmzO6uPrvj31wgsy0iugE5N
 251GdtjnUIY94TzsPHN9cXzWb94pH3+fLXMuWFVAWkqXeQg1sKgJXNbG8psH8RJWjPoYOwzXXJ2
 YftHBAZbXw3kHEDhrvkkCQM5NxPX+E2dS8Nlo1UAivZ3TICx8FM6SDj1xBv8XGjX4pKjvbVvy44
 97PFg5TOTxieSn4yaad1I9vmc1u0VqKCn9e1CkHd+rjbu6WTmzWuM52WyoVr9+2DXck7KvFO7Oq
 N/pxHkSUqXlklibJY2ZsOVsFkitffSeJgkQsuhnvYwzpOiZ4rtFFPyabxDJ9InEQZr6Nn/9PHbO
 4uB1vZsqF+3WvFNh8PLz+WO4Dh5x/jxG9eZ0glOdJPOtRDk/cRHem+5EW237nekZZFkmVkrCcKw
 MYIwsFjqMORoWQIXe0w==
X-Authority-Analysis: v=2.4 cv=I5bw19gg c=1 sm=1 tr=0 ts=6b0943df cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=v-17ujD_Twj6ygAmxgMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzNCBTYWx0ZWRfX/nnedxvKa/AO
 frhAmY3MuRREW0LMTSYV0XAIMe1lWtR4Mt0yzVk5y+8XnvDoV1jtLWeK/HRiLCapygQJUemnBYZ
 CQKtIa4adeqlJnTXitz98bTee3g3eGg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270034

Shikra's q6apm DAI is hosted on the modem DSP under SMMU stream ID
0x1cc.  Its firmware consumes the SID-tagged shared-memory addresses as
physical addresses, so a translating domain leaves those addresses
unmapped and causes context faults when Linux owns the SMMU under EL2.

Add the Shikra q6apm DAI compatible to the Qualcomm SMMU client match
table.  This selects an identity domain for this stream while retaining
an SMMU mapping scoped to its own stream ID.

Co-developed-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 795e8ec7e8fa..09ea293052b2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -420,6 +420,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sdm670-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,shikra-q6apm-dais" },
 	{ .compatible = "qcom,sm6115-mdss" },
 	{ .compatible = "qcom,sm6350-mdss" },
 	{ .compatible = "qcom,sm6375-mdss" },
-- 
2.34.1

