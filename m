Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182201;
	b=oh1tXCrTQM8+qLYWVqTrunN4IxRKsWMXMadXTpMoSu7HWeM+EhNtUEzns5vuX6XombWf
	 f/odSG2c4wUKYb8fBzpfGMDBfGp62Lg/iitj/+vdY+gTQNX0ecIeqV9oLDSg0IFaTJacT
	 dOCDCv38iDoIOVhNNYYNJKZGmXirvd8xTwp6WmLWZr2J5fBhNM1Shh666XGx5AJOfe+wd
	 +OtRmKLVRQZxBC52GYLcYQbivkqWKYQo9JobW2K+jSQRhXv9kEY/4j099BoNbnkDBs2nY
	 xs03QwmUeMrzgAknRKuH9d6xeGYbFskI1h3n4FM13YwrHsBsmD78NBXdbSbO5skfEzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182201;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/c/KG/bwxMNjDAMEpOfesqcMkfEXvpGwewsDe4qI9VU=;
	b=3BFWAvoGQOuZVrmj6lFGbASxpFYJNIPhw9N3gCm20HXbwsLckpCQk7E8dcbrRCCGF1Ys
	 asfVlKf5D7oL9Vd/dnFPd++15R/fTDT8RrPQ9NDz8x+8FId8vkP7BQSn8j2M5oeyuX0/L
	 v0TmCIeU9AAP1mF6OM97ZNAAZc5dSQmiWRdxmM8/Si8doVyGA5/yl1DAHD4Rkg6QqZ5hH
	 rDjRh4PJ5xey2/ZmU1tY3stR7yrtR1PWSI9/fLXWeO66s1yH48JP7eLj15C2BJdK2jXx3
	 BwAIyU8xKaAQuB2tfKC2DdwXtGrJzSOXiwt1wgBlJeDAY2sXz44kxmQyrOEvLHJc2Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=foY1MxOt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JVFw35we;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3ED60A2616
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D3ED60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=foY1MxOt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JVFw35we
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk6k33987225
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/c/KG/bwxMNjDAMEpOfesqcMkfEXvpGwewsDe4qI9VU=; b=foY1MxOtGLeNTRxf
	Wpqzp1LgBB1omD+/4FjpAXV6k6mvbWzzlYh82qiTcZUF+SfmZIbBdpu8INIvIzKd
	/ErMKdgAAa9H/6RDBGfP1moSSYgYUFgoBDih9PSjAcsUoShwF+8I7zfBff5+V+xn
	eEtHGtjVmYJt1+xIIFfXp/duW8GP8arigTaRyHTptHzPzsGDPCHlVJg5ZaR071Xb
	ixou/MSXqbT47om0AaP+eC36HrpmqvyfNiXUNNwznEuvDJvDxn5fph+STgwwl651
	knBJim8tMzreuEwNcV4gyfWtveBXOskzSHVIFGdvDPC3Y1rzwK2fkaQExyMAXF4I
	yTvNCw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2gu81pww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:43:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-383165e9b0fso1015571eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182200; x=1795787000; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/c/KG/bwxMNjDAMEpOfesqcMkfEXvpGwewsDe4qI9VU=;
        b=JVFw35weesWpsR3+BIXk3gjHjK/U/mg6djkhGPWEp2Ei71Z+1Va+BnmdGsjST9Zej1
         Zs97rLJtWo/oBqQx+djffX0ZI9xmFnu3Yn3GGHWWnolhAqLcKF0/UYeccFmoggNj5bEi
         vx3HUFK4VB+gzM2oYE4aHXX/yGgZ8VMXO3lsB1qVs/xHXEVLZ7GiH9CgA+M4I32gIlXY
         gCAl/A4uR1Qpm1k/mi6sUuG6GTmWDxCzkE95yijr9B0hp50Mt1FGTZYR+iXwb1FZD1EC
         8yzeZVJ/ylxPvQXgxz+nIbV9DVTtMSFUlEgmhYjWBidU8hWZFqW+IEmS5g+HBwf3tXzs
         yKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182200; x=1795787000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/c/KG/bwxMNjDAMEpOfesqcMkfEXvpGwewsDe4qI9VU=;
        b=fyJIx8xii1Uol689P3xtHYdjY7xvWVu/dYsz6VWlnV8/misn6hWk4MbKHjPEeRwpNA
         5w6OcY1e9XLwtmxSiIT7gJgQSOtd+XSVVRXwGhVjBchstQxz2XlObPzrD+1tOsTDJUBK
         x4RDsKATX/+kCUgL7ePzmSOpDH6jTANz568+0YmZXp2Nvz4gGAz49XweGprHLXeALh2k
         WPYO5INB4T+ACZLI90aKjE6wIsvqDgtCszEFT5vr+P9OwWkGLfW+EjHkA40F3w3OG1QV
         Ak2iU074YdElaNQmJGd81PzQlueTUn1F6AugE76Q9/GLEFxjOa0Z5G59ED7r7MhZ/o3h
         S69Q==
X-Forwarded-Encrypted: i=1; AL+hErFSDWYcSk2ykjOBZaLcdL3u8XMUhsTdsd32DL5poiMsJWwFtNWTC24ZbaKQZcTQ521nJB4rYA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8QDQ6bvglkiKvb/aEAI+0q85fHmYDBUZ0eJxpFlLLlot/yiMMs
	XPrcRpH0lSuMCQmpZkCfQyLaQlcRIEaEK4YeS8oMhE+U2QacFvlQLO82FbwN95kyxBp699SmjwL
	xkXOtjLk9ktcVApR9+Jvh6BGE9H7urN3BI26Eb5OYRZshXZDvupGnvD8W82eZMmrkzg==
X-Gm-Gg: AYBFou1XQEcZuvxkLAeYYiG2n7znVnsefcp3vXwGQEx11jjPVnAyZMy1TZv5onMik6M
	fcoWap7tnHm6gCJS1ps2Wk+hcozn3TQAU+ADkJylXLFTEq79wF84zhwqBOBEhyKer+VpQdtVZd4
	tvKE30Y8UoSxCFu/nap+mkWv2mkxABgvAVKHQvlPSHzWlnrSRpmz2U7uxtyLeb+QgDAhQuyz6Yj
	3RoXaLUeS0toFRgO1ejNEJOhhGVE1k5e0midLwKYJbKZECgh+DVCzIX/ZBvC2xNKhkVZoKiRK2U
	ApgokPiAH1whqtbVQ+8iYHdiAikWR1YemWEl7UbhAvPm66RNrXKfBBqGU9bpH/rKSP5D4BLbBGC
	tx2vza1lk3A9n3FsVkox+3VDYWVHQSRR/uo182A6Qbr0Gv1C8elgBQLceNLSj08LMzp3R65fSgf
	ECNso=
X-Received: by 2002:a05:7300:881a:b0:385:8aea:11bf with SMTP id 5a478bee46e88-3858aea13eamr3495324eec.41.1795182199471;
        Fri, 20 Nov 2026 05:43:19 -0800 (PST)
X-Received: by 2002:a05:7300:881a:b0:385:8aea:11bf with SMTP id 5a478bee46e88-3858aea13eamr3495275eec.41.1795182198873;
        Fri, 20 Nov 2026 05:43:18 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:43:18 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:41 +0530
Subject: [PATCH RESEND v4 10/20] arm64: dts: qcom: sc8180x: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-10-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1059;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=EEkH7RME5qFBUL1GYWCz8dsl/artX4YyT169jSjW1ag=;
 b=D19IVJaRY8IM7fDFyum4SvhwQsx4wXunIKVaE9hZ9h85bUztqtI7mZs5BEvllnGtD1p8qtRRR
 KprqJp1ygTlAGWbe7sl8ozE4DjPRI5YllExdodSObEJfkOc69jqxYru
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX7OeCHF0XGPqs
 4RX4fvhsNjniO9v18ZlWzO0wnTbUDwymkP9fMS48LqkjYGaywNvTz8D6UO0sLVbP7OgrLSagABJ
 nhCT/7M3NcsTBTIBwOf+UE7eDuMIgL8aCmHQKRFnTo7DmGOZLavFsCWUl+USLBeF0TyxP+6FsAw
 1mLWCJt9wIsLHc1ITu/KJMiX+DpMO1j9gqFkBGmQya51tT+2ekhppgvw4lJD9Ca7wTbRp1VS0s4
 lO31WeD8ffn/WIiw96/OjzSsLbbek2wPVz2QjemL+znKGwT0sQOmIZuD0YTpGc7FxdwprmV4Joz
 AT/DMGN9SD/+cdSIQYPYvotfEjzgmbdFokv5UoT6wZut2So5bKRCoKNsTEcSX71Odr4iPgDJpEF
 TuepaWsVCFHkl/jybJ0RO2afEdhAw0U1hDnlhpxbDuBU5fdU+sWCfz680bniDIanUTq0Ar5O1Qt
 RIRT011vS8gWkOxGWkA==
X-Authority-Analysis: v=2.4 cv=bLeDs/+Z c=1 sm=1 tr=0 ts=6b004e78 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=THzGGTBd8XYxRjXI8TEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: gQXXkqvKxHTn7GkbmBvGxgflNnzPu9tB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX4XxzB+/CtqGc
 mhMDwK/liwtmyhtNLwD/zbiCY1l3a3loPHFgeU+u9ge/6dIgx52sVldi7Tv0EYPVw6X15VQ2G4e
 VRsZupgvxlSvBs90YhO+aWisnHgA78M=
X-Proofpoint-GUID: gQXXkqvKxHTn7GkbmBvGxgflNnzPu9tB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On SC8180x the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index be79608b7161..acd05eac700c 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2410,6 +2410,8 @@ adreno_smmu: iommu@2ca0000 {
 			clock-names = "ahb", "bus", "iface";
 
 			power-domains = <&gpucc GPU_CX_GDSC>;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		tlmm: pinctrl@3100000 {

-- 
2.34.1

