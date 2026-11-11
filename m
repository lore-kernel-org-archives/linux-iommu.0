Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362504;
	b=Vz9KLnKG6aYEIKn2w0GaHang4/U6P9TZ0SPcik6entYKKiDouxPcb2CmYSZU612skkPt
	 GzRWfDHI2uAgutLzkNyzXxvo47ye8QOMssAa5XyG57tvGT7eaoVM0D/YCyixyBxHtGi8h
	 gBOhkaFzR3jIlTl/+U6+pp7ZQgQEu9fischXIzq6o1r4ZI1alK92iQNkl6MGfH+ai00xy
	 28eTk6GEL0FZD4uEXFmrHpIWudvRoxwSbqV35hac2H47Reu7aEjazA9JlkwNT20uQavoQ
	 50OZG/DrHXN8TjEt1W4ZWJ3fOqN4HuX4PWAaaeRROqLDDjNHZT+pcxXvXUrsJTx4UTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362504;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-QCInternal:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HJMSr5s42M45SyI96QjTIww7A9WUNXzMpTJLyGJ7JjA=;
	b=z6qW7uqSnl6zehhpYG0g5ir26QcE5u0E5K2rFgyt3EjVX3qOhqKhNQfSR5rwnk0lZPLH
	 nt6uJC/Rbq0yTRzKC2KEDlIsWJrsB3zLFRpGwYXnHyAorF3IfHm/kz+hUQR1fiqjELNOC
	 Ib3copdk5wtK0HD7u4/Oe5MSsdnVbF06T843Gg/MIVStgixVoDbMvb3hRQsrFMg37ORXr
	 JtrFxojU7DVK85ByibtnH7s/hDTupqCrjkMN8PWYXS4R8MGZ49tSAoz+e8uzEylXoSRqr
	 xJCgWT4hMWhdU8zW9SkpIt59HjxpkR/3mAsH/wyycbbpEGoSMOvlbFgbGQx+kmwSaZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qti.qualcomm.com;
	spf=pass smtp.mailfrom=qti.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hsUrz5bV;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BE606A31C
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 02:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B21BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hsUrz5bV
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB1tKhl1571272;
	Wed, 11 Nov 2026 02:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=HJMSr5s42M45SyI96QjTIww7A9WUNXzMpTJLyGJ7JjA=; b=hs
	Urz5bVKIvbdAY3D0y0k+D0HRhaFQ0IMbnNuWl8OwtyNLHATbBuzYfCSyxigXGabn
	qJt3lM/jeW6BMlqdzmGndn/sz1Cu6CKse4htt94R+n0Mt1rTFbyAvBWhGKloEuOR
	gNlCFm97lyVQfvgPj+z7xEDQKn1nZcir324432NLjbDn44d1cea09lQonpNPLaND
	s7TPbXeit0bL+deTM4B7DEx1wPZZVm8FdK4zXU5TqIkafMxUp7SlDaKrpXAVPzd8
	3y0zjdRzPfpGejf526K1WM4x0wTdbthR2ENZaoEBIJXLGpp/UE6XGITEFW1U0aVv
	Twe2Yro3t3SHej2S7vWA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv4pvapd0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 02:01:31 +0000 (GMT)
Received: from hu-sukadev-lv.qualcomm.com (hu-sukadev-lv.qualcomm.com [10.81.26.104])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTPS id 6AB21TDn1062260
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 02:01:30 GMT
Date: Tue, 10 Nov 2026 18:01:29 -0800
From: Sukadev Bhattiprolu <sukadev@qti.qualcomm.com>
To: will@kernel.org, john.garry@arm.com
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: [RFC PATCH] iommu/arm-smmu-v3: Set CMDQ_PROD_OWNED_FLAG to bit 29
Message-ID: <avPMed8A/VIZ9obI@hu-sukadev-lv.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=XqZvqlF9 c=1 sm=1 tr=0 ts=6af3cc7b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=3Ct531YMCLnOWvRfXdsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: JYsoCURURLSAEYw-yjr8hGApNVe7apy2
X-Proofpoint-GUID: JYsoCURURLSAEYw-yjr8hGApNVe7apy2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwNyBTYWx0ZWRfXxM4KK6woa47i
 6+ix4W9Ol6GU34/0+weoRH3k8O5t+SldB+znRUiTPjHWGKVov8oB8X93Qxd3a/hsknGST5O/+lx
 5eZoU8Zuvahqnl7W7DhHz/f+Db/UK1c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwNyBTYWx0ZWRfX869eQTg7X3Up
 JwjPtBfbT+aK2jxsUozKTVFWY0hIo2sRO38A5KF7c4Jmq2yMOKaRqEUnNnjq17XyIX0H8Ca2Fa8
 leERlT6qPndSda//uwAKFPhbw9v8JUXssImirLHy/UBy/y6ucrBS2wPgRKGiyCOwb2+yy/aunFZ
 qXD5V5t2m57lPhBpNY8AiQ2DHXz3LGc+hBHqZ/4A7jrxh/aQNKD0G0RWRDX6MwV7WbogcURsuKH
 jKIHUblkogaOu8f9uQi7HlVCHWdTXReBotO0/7BlOL4SzRcZkSc5nYrXkxtNp5QhwRYXewA5FV2
 OYY6fifK+ha+ud9NBBRvbDE4nDXKYtzWkF0LJ57OyCNEfkhfHqdscuTx+2HLl/AnKZvANRXbRXR
 y+wxmqRdS1YdL3gSlxBMDWwN9X6zYQJQ24go97u+1pqHangc+eZlHNKUKjBLK+pdaOSwXqa4hJM
 V5DSzXYOBjg61exK9dA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110007

From: Sukadev Bhattiprolu <sukadev@qti.qualcomm.com>
Date: Mon, 9 Nov 2026 20:45:29 -0800
Subject: [RFC PATCH] iommu/arm-smmu-v3: Set CMDQ_PROD_OWNED_FLAG to bit 29

CMDQ_PROD_OWNED_FLAG is currently set to bit 31 but with support for
ECMDQs in ARM SMMU spec v3.3, bit 31 is used for SMMU_ECMDQ_PROD.EN.

Since CMDQ_PROD_OWNED_FLAG is only used by software, use bit 29 instead.

Change-Id: Ia171b73ca7b012fc25a2a8f3d7e1dc71f4c2b528
Signed-off-by: Sukadev Bhattiprolu <sukadev@qti.qualcomm.com>

---
- Would it be safe to change the OWNED_FLAG to one of the RES0 bits in
  the SMMU_ECMDQ_PROD register (30:24)?

- https://lore.kernel.org/all/20260908171712.356645-11-praan@google.com/
proposes using bit 30 for CMDQ_PROD_STOP_FLAG.

---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bb048e08d613..f79353582909 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -398,7 +398,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define CMDQ_ERR_CERROR_ABT_IDX		2
 #define CMDQ_ERR_CERROR_ATC_INV_IDX	3
 
-#define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
+#define CMDQ_PROD_OWNED_FLAG		(1U << 29)
 
 struct arm_smmu_cmd {
 	u64 data[CMDQ_ENT_DWORDS];
-- 
2.34.1

