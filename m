Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182249;
	b=bDl3W2UjbyivVNxpDz1xi+NIHrQTtTSvni5waKb7xMJlbXA/luTJpulF7fvYXo/dRuCd
	 8lYCZQ6Z142IwUvlt1TWSRF1/dFyUtwU6KI8cHOjyUFw6LRRK1Wq23AAdbS3Unks9mf2q
	 /vVxiz0VtrxYz7IRwKHGoOd/4zQy4oDqt4xBvcXAJZqRsBOIQCr8ZQE1XOJX5uVdaUFQo
	 f0v8qbOeoFMqqL7nanzzVzTTskqjZSKkS+BFJFpfVuO48rcuGHaKgDgRZbUkWfZ6va541
	 PBfDyjiDMss3ED1M9hXoRL7V4eI+3mr4mINfBKwsLnu09QyI59u8sue+w5H1MvdaPXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182249;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aASYEpmDyUR0PcwON2bZC/zaz3rpAzma7SBkhcBHJVQ=;
	b=HdFxUzsQ2fhnryB8g9TwUHw7F475jSyg0UqGKddQP+3Mj9yw2zWwr9fpAF4nekX6bbB7
	 tUPXcX0PVYE0o9pZvkpDXzOFw8JjsB7hdnlPCFeF7zObEFUZTi6vx6m+Gxbl167NQmgul
	 W8auEQ8FnjSz7+MWSnhsy5VpJwyLQt/jY686sSvcnV00jBpQvgieTNmq7Sy7ncos87Wzv
	 0OqFE/hs+BsxtGMakWU8p/xpUFM/wTar+Mw6n7+ZGnhq1GgSwpchOFN5O0TDwedpDS3Ye
	 ckhq/P8fnUfcxzTPkwKnrpSuoHKY5gJjneVIowYm8diZ6gx5BAcRmuVr93rpw1Hk8/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ue94MDPu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ckd3HaHz;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A11B606A33E
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A11B606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ue94MDPu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ckd3HaHz
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk5lQ556702
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aASYEpmDyUR0PcwON2bZC/zaz3rpAzma7SBkhcBHJVQ=; b=Ue94MDPu53ssd99b
	5yrNxR81kRUlASxau7HIGQ82RGqSPI5d7tonixUXf8jZVUgM+UXr3Mk7VWP7HiAp
	bQjMHPB2qHXkV15DTPPrWzu75QqVnQqIU4Q9wTkGZz0n+HlCbVTPjPtAS0qQSHF0
	CjP/y7ulOliQZS55vDHv+kg+8Hn+NeR4wq2PF3T5zUFRRetgm22yQJPcnl+GBlTJ
	znDEM9wqc3tGrTDBlRptgMUoLhPiwDFHAeH8VVKU6jrBRAvvgLH/Ir4gBTPAEqgu
	r8E2oqtfqiRxglS5rijqi3XlHKSodiENY8XoNVZvdiYjlfL97iKbLlxVr53Jhqqr
	yWH1vw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fsbj19c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:44:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-375bac6bd21so994113eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182248; x=1795787048; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aASYEpmDyUR0PcwON2bZC/zaz3rpAzma7SBkhcBHJVQ=;
        b=Ckd3HaHzmGWRADwHFePB30HrqZrZgdT3xuVT8/LMEZGAIECQ4Wqh713KzCaBjE2IVW
         CUywIoPrUbeY1ce6kazTKI9hP/5a3AH2JDgaMGsTGIqfPQx8nYCUyNAdw8eW1v/n+5Ad
         uPvgCpQLnLPjYVw4io6WOVUlrADeJqp0YPyck5o2y1ODT+uBGzlVpOCgaBcuZyJZjoNx
         hsoxRwDqsZ0qjexn4TE/hUY+lWJWUpT34qNMfPpMo+DOIQ/4H6nZNbUHlCghf94Mr4H7
         QQV4NgwfU7mX4mc24PbqfCvehsaNA0EW/ZzgLFS+MpofG2nv2NruNr9Z+IW/wwswGeeD
         Dx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182248; x=1795787048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aASYEpmDyUR0PcwON2bZC/zaz3rpAzma7SBkhcBHJVQ=;
        b=Wxn7IaWXy9Ath7UDi/tRPqjzBpM9OoM2I7H91/sbSnRveAT+LAUTvmpbjPeLwIQkR0
         2gZKSCDgvcjo9d4rGVNrwDLoEc2UtGLr4bEHHZ360frI8xtYKkEg2mCVGZxG74xK7NBs
         M5PPavgJdGz5pgzgb6OQKfuQvO2BYlgiKCy0gqK3WNUkgH1cqxS2nE6WuYvaSX70Hg3M
         S+R6vA9owDXCdeeV/tlwKI49t5V7Vvp+UiUDhJP9MMI2tfA7zg+azfUch3yEwsbKHaye
         EHKsEp/yGdfVubeO7uVkQkMTliitT+4AOHLKQ/op0+QKAWVVBxswXb5GUyh/7bFxbeW1
         +i2A==
X-Forwarded-Encrypted: i=1; AL+hErENrw5F/aZMml5jaDGM92grt1dkzFelWnXJO5rzU1FdvwMjhyDRO723W+CoS+8YbzVzJAupxw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/VH026SKOQuHy4I8JDAnM1vZ/tYrzhpjHx6k7WOD9tZ47sOQdC
	6qU9Nahx5pFcfG3IcbDKOvmXzRZcEa4eN34gdIPUkwe0lwQZZ1+tupBMG/bM928BJdZXhZZK5p1
	CNTRmIEFfYozeSEKEBx5VFKn39FSAvQ/tKo70ewXiPJyDH2vSYABfVKXYbQ==
X-Gm-Gg: AZFdTZeL8GWK6COjCvwd3EbkLr40vo/w2zDVFyQuNd38QOBOjSbrZkVNzIGO3+Shvbp
	57NPE0KjMEWE87ph1xTLmyaGR4ifSOKAUnp1XFP6U36VhZqugvoQ1nw575l/ma0IKlCG5FnbX8x
	gwmmRocthfHoUepRemKKkwRFhI7wx6Hwm2TKVR7X+gBgaqAqcNppnif0yCHh4u1dXXhmZiQ6umN
	SJeXcjLsp/dv23LmuELQ2BT/20EvtrCt1wwBOMbX/wkN7kBxLqgQbakJG39G6pcEXrS+h6HD/M7
	/RMuZdrq4t0EboixY3rvOHhii1vcGp2DhY1K2aObvuTRn1+hTZi0HPWEXg0wNg/H5ltZvjZs91Y
	zb7zl0mxnvRRo/MF9zV+C2Ji+qILx/reR4k9NBLNjN+B5rEvcX/pVvtH644LBn7kqvaHZgNMkb5
	77e04=
X-Received: by 2002:a05:693c:894c:20b0:377:3984:5cb with SMTP id 5a478bee46e88-384b446b404mr4505994eec.17.1795182247723;
        Fri, 20 Nov 2026 05:44:07 -0800 (PST)
X-Received: by 2002:a05:693c:894c:20b0:377:3984:5cb with SMTP id 5a478bee46e88-384b446b404mr4505955eec.17.1795182246955;
        Fri, 20 Nov 2026 05:44:06 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:44:06 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:50 +0530
Subject: [PATCH RESEND v4 19/20] arm64: dts: qcom: hawi: Add GEM_NOC
 interconnect for adreno SMMU
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-smmu_interconnect_addition-v4-19-be30526391d9@oss.qualcomm.com>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
In-Reply-To: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1056;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=aYGbyD3vlcsShV5PIBfgPkIOIPXgEFvWy/UpvGRwvdI=;
 b=q0jAIPDrN516XpqWB22OPyiiHWhPk4OWO4JIauodmt8cg4tveppR8S6ZONPWykogDnxodyD4z
 imV2vWiod2ECCT/tBCJlHc3jWV0NxantFLQIjX5kyP9qJhyjQ92MeCK
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX2LjxEYxQERQK
 +3lbj6bos/or7KLFTfnoS7IJRkJkLA1n6w9T0+TRm88vxfBCLgjU6iHwtOGesbI0m+DT2SaYUk+
 jZ2narSOPRNaASinUU8qN9XMXbaI0LmAvgloBrE+0yxUgey6rQ0JqjvnJaDhUt0QoWmQZ9t/pK9
 5WwdO0gM/sdgKRk9ytiyBbUQM3iBmIdL2zaftfGyeBLWVapH2mi0Viw5dG/35m3QSQ3ZBED9Psy
 YPBkQ2ap0TISwVKO5Lsh9EugqsPUS0+O9hhgpss5xpjOFe1gut53FbgvTVUTM0PY74bCgRxfhTR
 /u3hw8utW5/JpwDsizipffA14+XegTnry3M//s9D0ozS+mlOMBgkIDbDz5Y0z8gSQ9KVad/+xea
 4XDN96aecrFUO9aqhYDC3GE3ZbRiL2tAjAa9P+aWP+xge+w49RKv7SXKEuTadtOgvO2+xJEUErU
 RIgeiPDcDuqcKLTViaQ==
X-Proofpoint-GUID: vet_YuMx9BmXv0MLkgZOdDZwV3WsVCLo
X-Authority-Analysis: v=2.4 cv=DeiCOftW c=1 sm=1 tr=0 ts=6b004ea8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=-u0lSa1b7RXV9CCC13MA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: vet_YuMx9BmXv0MLkgZOdDZwV3WsVCLo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX+msfJ0lAETJR
 lbcEUdGeg1dC4g67j18sJ/ooSgREvRM9L62YBBj6+TQBAUjysFIcGIFjJIs4amud9S+CfXxtD8w
 yhDPGcTVQ4/1uqBlEIXvxU9aOzuwOyM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On Hawi the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hawi.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qcom/hawi.dtsi
index 77d704fa6cf7..bb60ed9384c6 100644
--- a/arch/arm64/boot/dts/qcom/hawi.dtsi
+++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
@@ -3685,6 +3685,8 @@ adreno_smmu: iommu@3da0000 {
 			clock-names = "hlos";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		remoteproc_mpss: remoteproc@4000000 {

-- 
2.34.1

