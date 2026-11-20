Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182229;
	b=izEzTrqCqoSR7x4/bk21cMDB+ykP7bnzRaP9TbdG9jtKAgWbgA1IfKlvik2y+DoKw2xv
	 d7p3HwfQNjlibtW9KTjxox5wqFkgS9E0MDHRjxBxYOw2KbK3et7mC3ZgHF8jkLQbp1wZi
	 Pq5XVW7zs294LTBLaeAPIEtof5E33IbdgOfojFAHeViM71pPmXUfi4CkRvU6Ay8bQtidD
	 K+bst9vHSRc0Ahiz/WN6NpoUdaWG0md7PONwBExd+vgMUP45yKgVxWue2h7aMx1SCgXCf
	 es7MWwivW3w27xmNSHFD2ADIdu53kQH1Evi2MwOUFKl9HfbHlSrVVi6vM27ahgx71Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182229;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tGy86xBzxOdtKe/pt5x0J8JCDH7VjEkzSSCaoMU+88M=;
	b=uny43qVB+5T/AdPkBxKV9p0zj0Yd3UyHDPfWSHL1EH00Xxbc1sLta0neeGmuhhwo3F40
	 wchObLtyD+ASkxaHTHxI2nWCvmXvfQ2IpC0dlF95Mo+3uvaTWpiBWG3YAq++N3h5waysH
	 rSgykZ1moANwIS+4MAEUDS43VCRPdO/6S2dAMezvtRkJkjzSLMmrQPn3b6sB9RId4ZXe6
	 JYH3KkIQg+yhLjtPnU45pJjtlDDLeNWc58FtunG6el0ZjHUZFgM8cSTgnVoOMO3AjTvAu
	 HkJeo2hOYLzOFdlqNjRyI/a2EpESFlgjU/RupsvwEjRNN3K9knDRhzKaYGvKBX1UQZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YCsF+IDs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WXWB9vYV;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55460A2636
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C55460A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YCsF+IDs;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WXWB9vYV
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAkfUP3107598
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tGy86xBzxOdtKe/pt5x0J8JCDH7VjEkzSSCaoMU+88M=; b=YCsF+IDstQv6MIvZ
	xsCj27b5QrM6GVtFKhA+KTZ8aWrMjUB1690xvobTHxxplPXUy1Z5FnIZLbs2kkGS
	62YheN/JbLYl6x1eu7setWiTXCBncPR4/J//f4/OOXMPTGzDrFNIeDTGKCtqlRe+
	UqOdIZA2zTmxIcbgjIRT9hn2DUZ2vEJUTaz1mT5kpOuB2uZTUaXMBT7oa/hP6fxz
	LUW/S7MiERWNIFQ4Y4dTKeJMGAMdoUMscUNh+T+Xzqi4soHVa6zqO3sPgM3rEQ8u
	joaJQsAPVS5506TQmnNHOEk0sWdrytK+n6cZX21/EOwkFJ0x4U0y14ZNZtpR/uC2
	S2TSPQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27au3x1f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so1374162eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182226; x=1795787026; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tGy86xBzxOdtKe/pt5x0J8JCDH7VjEkzSSCaoMU+88M=;
        b=WXWB9vYViniUOqv0dUS+KAZjXDA0O/p9nKgmk5htAmk83dveTDOAKgMQPADZoZtZlH
         /jXKlZUgT774YB0T3AcR5vmvwooTsDU6OoqGDPYMp70SpKR5Erq/FIH/4uA0BzgdofXq
         DnyZgTgH5He1h0dRRqKmq/04shHzsz2mh2I1VSzos/OZVSBQomwxCYXKwockqB+F6lVu
         Jk72Ykyx42bd1CzaD8NQeychxrvGWgo8+u5qqR/GGgWy4xZ5x5etRwILCq1HVp+jRkfz
         4yktgkwprbii7sBXqbR81FYY68f38yEX3Wpui4ZHPFPLR1Dr8qACHQyYWxtEa89rB41O
         luBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182226; x=1795787026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tGy86xBzxOdtKe/pt5x0J8JCDH7VjEkzSSCaoMU+88M=;
        b=X2+Lk1oXnTj1cO8jl8mqKSvKXJCiqMtm2CCwOrjoUEmRtFz/DAj4Np4eQM9jO+8EJ0
         /TbkdiuDKlvCfWfGZrGcvehUm2ChN+oUiOm4KGx73/Fj1InmchXa1nrzClTCMmeBiiss
         Xt1xmare4YF2uWJ3JmgEgtDIKHVrPEfOfQOAaqqvga6iy7X/uHeqUnkiE1LcYmxxSUNM
         wXjtxapl6TlJeImKxTSYBrvDOw8J47h6SOl7D/F7gvSHQNTHG+Seq3/RnQazVkKj8pT5
         LB//Wd2blkgKrCcCKqMtQ0iDHvkGl6GrSrR/vZwqajGtmwFZy+oQUTJMLlXAssslYgbz
         lGIw==
X-Forwarded-Encrypted: i=1; AL+hErFN6CgCgUe4lThHUDeCvfhQM0dQx7/RD5P7ZJVXofvRy9QYboTPIrUGMnEFQPD9TJlQyA7TCA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8PEUcb5s/DIu7/fnADMOQu+lew9JCpKHYZqVhLZPJ8wTSGsT05
	K/0p6PquIzq3CaKx1xnk7XH3zDWYvZCWWJMfwbQdeLdYy+6Shb6HscvjZ6k+K+2pQbQz8MMlFA2
	xSK9NbQAh81S/7KMfqv0lSuhBFXynuAbjeww02cDY2MH0YZGqe7E9tI41Lg==
X-Gm-Gg: AZFdTZe+SqSVFvyTIXETNHmDnYHq9Dy77q7P9kl1HAZhskcyTCUp+47Olv+D/Ti9Voi
	svgYguSzJCUthrduJBGgwn8UTpSmfiGkdE3uOiD5oDndnH2cjLBIhcCTQz7Qxkeoa86EoatZdmL
	W+DUxl7NW/TAgho8sRxU1HD9EVMu7aQUGOJYgVOuBkdNWKOEsY2xmgXKpA6oh2fjoSg5Dvvdr+I
	1Sa5fp3hqgGbj6xelEaCLFJC4Ar+moZXCMXOclZ+yOlI9t5psJ3uTC8f6RI1H87NWxant3Nx8Eu
	8zksSheuzFi+ZqXn4YS7uQ3R8yzGIraJoqq8JxO3H2Xx0igJI71+DeHRYvKR8E6wu/o4dx16f8V
	DZGp3Flj2xtBKuqhpv7n6zEz+8N+dRcDNMLnXsEzfwdvHuORGtW9Tay5VwqOZkcx1sNxp/K/Mlu
	pKRUQ=
X-Received: by 2002:a05:693c:8951:20b0:384:ce59:5e19 with SMTP id 5a478bee46e88-3856f257bd6mr2694904eec.6.1795182226331;
        Fri, 20 Nov 2026 05:43:46 -0800 (PST)
X-Received: by 2002:a05:693c:8951:20b0:384:ce59:5e19 with SMTP id 5a478bee46e88-3856f257bd6mr2694873eec.6.1795182225726;
        Fri, 20 Nov 2026 05:43:45 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:43:45 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:46 +0530
Subject: [PATCH RESEND v4 15/20] arm64: dts: qcom: hamoa: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-15-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1049;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=o8a7Ojp0eNjNzQ0rCM2WmCZSQ5u7xFkQL6aYtQmrXTk=;
 b=shWpSkfNSnmk/Jcw28HmhRNuejqHcOqrgMbIwuKPiGgefABQtWtryhrv+xF/ZuYuxLXp4XrdJ
 0EjfJJi5GtKD+6oXZONpBDOmHdTkkm4Cw/3B7UEMYg15dD4bavucvgu
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX9tifbVHH2eae
 A0ZxsuPDy10AOlCrauNeshxZCUwtrcmXHuVUYlM5NGCnAk8NNUk27OBJS0vla56oteBFC6kMFhx
 /RQcMfFE8EBoSkiGwAFmGNTpSMvLuLWX13SeSR2IxQ5L2z5BXfsRwetUXY6TKdaiBIAsy2zoik8
 Gr13Wjxw9jxlhRHOhVRyvIqXQX1i5ex+KN6YQ0Jm3+xisctSfZ4ZkWokLAXWvhurLiUy7TrNr1+
 N3CW5FMlkbVk1QbQfh14duJvI8II463SxMeCUQ891reTs6Re9uIB40aMU3+VE1WzeWanGbzA79z
 BJVQTbJqIU6EVcMMFJVUdBpOifIkWTlkV7y5kFQ4/EjV63IgOMlUbRk4/xm8I+QULoEVZWRhoy3
 Ts0BSOH61/yGEjisa0yCLOvxzAVkGB5ZhxbZK8Snp1lxgOTnkxQrxP6HznBVSQWoyjHOPDL3wk0
 tIHT0fDUAIeNyfhNKEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX4VkBUboCbnbm
 whBl4Hra21FTcwtqokoF/Yn80Yb/N43CT5X3BUr39F931psYS5mThmztwfb35i37hd7xt3syIEA
 TZG2T6rWdkqd67yjY8wCjHT6V3r7l1o=
X-Proofpoint-ORIG-GUID: jJkcEHeui9J1QyZIFi50o-yXup5UjPs7
X-Proofpoint-GUID: jJkcEHeui9J1QyZIFi50o-yXup5UjPs7
X-Authority-Analysis: v=2.4 cv=KuHYSmWN c=1 sm=1 tr=0 ts=6b004e93 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=WAcSZy-hVgrt5OVmuNwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200054

On X1E80100 the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 443c1a5c212d..f5b720d73a4e 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -4289,6 +4289,8 @@ adreno_smmu: iommu@3da0000 {
 				      "ahb";
 			power-domains = <&gpucc GPU_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		gem_noc: interconnect@26400000 {

-- 
2.34.1

