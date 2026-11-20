Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172901;
	b=pto/U99OH/UM2ofryzHNrjjRobscBPsTItq1rdpFQayQN1tmVYEsR2f5WGny2L4JsD/l
	 fDo3Cw9ZAQKxE8mhqgNBOUKrD6QmRJkoQ2+0L+memdqilsLMkFENKPrXS2Cfw3Me9cXLu
	 Bpqf0vc7njHkzqDo/xKcvR7GeG+BE5+FtZGcgOaATmxxT1b4tIHI5d7TcbwVGnOEcCEwU
	 zkAwnaOoZXDVJ2bNqZ/eUwgcbs7TNmeRSVKYObNszD1NBa+cjUi1CEcDz4Fw8j3DUu7qt
	 eM8AzsVT2ym7RvEQPAPimZvpyooOOP7ZWS/ABG8yj8YrboBfEHJldiKTpUdZhaGnaXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172901;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=aS7LLfFWKco/ZCfqEM+r+9fW1cESciSfAHUcC+2r1I8=;
	b=dG1s1Y2PIWgEdHrxVQEo8uwO+Lx21CXkIOsi3s1W1qPA6Wbf4QkANanzUebFG/7/93r7
	 ZNelYhRLJFccDxjowwVNLwiaoB8GQ7cfT4QhgXHG6QMSTWOP1rQuNoYzl7tZXMVH8VEM7
	 Ecg89zfxr8XzwsqNzH+nvEiQ2kVwQl48KdeLhB05Yz7mxQUq0LaAJLCox6xHpJGPRTVDV
	 YgXqg0oOHEGaZoTXqZk7j5UsaV4KVWVmypFtG7ZVB5v/g0XN7I6Itzx5oz1cQgqYjJw2Y
	 gs4hxPNY6hiW2o3yrB4j1bDO/ohiRLMY2lQ9iTS95wi95lVbNOxfJQO3RvHjKcGPL7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="M/SiqKVW";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RCqT1TTt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D460A6F52
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 644D460A6F52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M/SiqKVW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RCqT1TTt
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjt081168916
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aS7LLfFWKco/ZCfqEM+r+9fW1cESciSfAHUcC+2r1I8=; b=M/SiqKVWCsBLXFmb
	l4zFOxr6T0VDM1R0F+KY4JepcSgMLlrunAvyOA1fzp/XEWO7bLUuvqRXrTDEmoVq
	jBWyM8s1t+5jghX0GC39ia2TqFJfyL9n0ST8zoe8f4C9D36bQvXt0YTyce0MRxWG
	fyClqlnYwed2v/YMdcUzPm3wM/+8ThTvA/ADNR7zlU93ZEkEDb/KfKFX74JULDVi
	eKjCR9XFi/XlO9BbRzQMqNIgyoTolQzIGV2HpBiliH0dyskfcqWzc9a0ie3rg3hw
	xKedYlmST1zQ+mDvDOz8ny54ZYvAnJw9oYgCQtuFJ4V6NQtWDp+SGXiN0LERCwDU
	BXcqxA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5ucyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:08:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-383ec96a7deso848690eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172899; x=1795777699; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aS7LLfFWKco/ZCfqEM+r+9fW1cESciSfAHUcC+2r1I8=;
        b=RCqT1TTtvsMyJ1d9XiSpwdGJ1HttGiyn5La+VTpaizG1JN7vFhTUUtKMLfAFTjkUaS
         Q61/SdBIuORcfJBB6iSzS9sALPdb8wQcBdpaLfhsQzJxCt6obw3fcZ61p4eE2u4BhQF9
         sW1z5rlVksSXLWLdO6UXmWPK5jTbEyUXVXzXHjRRzd305tTGI++Mh2NqlZyV5cRwYewo
         BL6BouBSHrwY1zyRAxEoWYDDiFBUxk4xij5P0VA65XcwaI7vh4n/GdpjrfOOP8cLnP3P
         cug/71ymfB2RlKEI0rUiURfIp9RmgtEwU+OfOCB8px7HU1pfI9nrD+cimtH72CAP9tkO
         QO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172899; x=1795777699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aS7LLfFWKco/ZCfqEM+r+9fW1cESciSfAHUcC+2r1I8=;
        b=l/ju+EMF3cE6C7P1HrXpxR13m7IvbAvDUI3jcxP6nNUhB+15SKhrxV7RVp6seab2VH
         l71Ht4QlVlxcpwAD1RSJsI2rrurgWv9Z1j5YbktbYsHWgUQ4XWLeL52CzvnXvv6t/7c3
         4z5TtXOdEdF9Xz4Oh1p/Cx7J6boL7I16naq9csXTOtehne850MJdwvLutTNgqZJLtdQY
         NbcMojk66RV8+i9Cf1aTBcyTrftFDKjGk3SU7AmUtBXdnmnTpUWcwjUgbKnNfw4K07JL
         Vge0uwssfCSs4M9W7n1h5t+1bUvzC+pS1ENX88YSxt8ir//THqnddVoqn3lI0JBha8Ep
         hGgA==
X-Forwarded-Encrypted: i=1; AL+hErEMDDK8XSZbwNUVAxyKNAc5PdQAwcDyW9Dw7isge6uktSebdd/HwbJQT7nG6qV5QuTH3yT4JQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8TPT2MH1k2vatHifgddVAVohWWiScf6ONnh4y8D/SYajuc0t1Q
	7+i6+Mpxz3t+yRTeHJ/NTF0Ci9wVdHWnvzbBqNuoXB1TKY60GW7j+aTYQTkP48typtCzIYCqd8L
	Vu+3hNcDbKracvfpe6CK7nRQdYkiWiIElzdNVoBkByUwkEJrZ1ZMItKUz6w==
X-Gm-Gg: AZFdTZfmtV8kEw5l8lJ4q6w4IdVsgB3+7n6n74PPuIRXK7M7+AvWcEl62DKNXo7H7AC
	VEU82MZWPS1qaZGv13F3xHLHzEGZbeFcBIuGgafVi3StGOZ6gpkSbvkLbzU8OssuOBLebez9uRJ
	4ncIMOc52EFvfakqE4uCAOuDS5cS8+omgSmACfLEmzrwkchG/PngS0RLNxwdzjhSKx4qk0UikZ5
	vFhQp9KbnYfBUouwU/exX7oOv79R62AoVg6CccKSWBclN08bxMBCDdBnKds6IMn+uXrRpl300oO
	HikW4DqIQ4G1Ey+kaeYpPjnPCefYSxEJwC5XlJ4JppzOR+xAghygTsWlveDOvTFeAUgS0PcVsd1
	yuXfaJP0E159ttBgd1VwvxP/rnjELqqI2UKgVarxqTDAviZNvtR+Zac3rk1QZcyKg/UUwrNkTmM
	yNcpvn
X-Received: by 2002:a05:7300:d08a:b0:386:240c:19dd with SMTP id 5a478bee46e88-386241b6dc4mr814571eec.9.1795172899162;
        Fri, 20 Nov 2026 03:08:19 -0800 (PST)
X-Received: by 2002:a05:7300:d08a:b0:386:240c:19dd with SMTP id 5a478bee46e88-386241b6dc4mr814485eec.9.1795172897871;
        Fri, 20 Nov 2026 03:08:17 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:08:17 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:58 +0530
Subject: [PATCH v4 17/20] arm64: dts: qcom: glymur: Add HSC_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-17-cab8ee8be0b3@oss.qualcomm.com>
References: <20261120-smmu_interconnect_addition-v4-0-cab8ee8be0b3@oss.qualcomm.com>
In-Reply-To: <20261120-smmu_interconnect_addition-v4-0-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1054;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=kQCr9BRTX/wWuCiHnkZ4IEloHpuZO4nxnn6nFDJWtJA=;
 b=VRQkE9FAhJjTHlJP+APs4NQ+u4MYqq3cljaL6I8nd2vmk2WV7jWXRfdZc9YMifbamkfdNbVRg
 df9S3AkG9TCDP/witUqKjgnNiQ+QU5yxEYYlir85AK+7EeOtvUUrD4Y
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX0KsC8DKn58DS
 IGsbrv2ILygrQIpE9VoBwWMHtCBVpmJD72O6fsOkTNVvDLksq/V36yScnmIpIlkY/uNKDTII5IV
 3tC0RgsILC5O4j7E/37KJb2UT9GlcA4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX4ezn/qT76ApX
 cM8BRtWDZZrMVW0m9867RFo6IDXWkPWVvNctPkQz2N2QIs+EcfaXHR56zVpIRZOCkTFYm7uT3us
 BNEfUw/Ad3RB+/5XxMIxOu2hNvvPQJdYyg/gPuOvi9MuTgAPvo1sjiIWKEJD24cBEL/wMKqa8Kx
 IOPgm4GR09j4LeG8uXyJ2oAB/EL2HktTqegNr9lqBtIFYknrCAHMHS/VcPI2kDk3plJlH+/ViBT
 +yVMFlAnAHRIabaOdUoTARjlSVz4lrZY4jfwjL4164jFRzEOFsDPlUze+qUHOylbYOCyV9N8gbS
 8GM0NiT+2XqCkI1zzMJFjbuC+kPKOWV3r8AaEXXkD3rUT+x4u1MXBnvKZlwKa1eMeyhAGAraReH
 /tqAXSiXBD9hzFDcsiJQRPJ43F+Z/A+ysesfCG2WPw6IWqL5WKhs6+uky7KsYOO2Li601aF7ypf
 muEINY02397NlM9ehPQ==
X-Proofpoint-GUID: KIlKB2DqMAd4PwHNkgnVcjxI6Y0AZHPU
X-Proofpoint-ORIG-GUID: KIlKB2DqMAd4PwHNkgnVcjxI6Y0AZHPU
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6b002a24 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=a6KFA2mGowSrcUvabvcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200044

On Glymur the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on HSC_NOC. Without an explicit
interconnect bandwidth vote, the HSC_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index cdaf842814fb..ae3cedcaf9d8 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -4378,6 +4378,8 @@ adreno_smmu: iommu@3da0000 {
 			clock-names = "hlos";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&hsc_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		ipcc: mailbox@3e04000 {

-- 
2.34.1

