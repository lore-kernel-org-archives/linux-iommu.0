Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182165;
	b=ytOPD2keyJtBjvknxHDFY+8e5/4CB9aL5UScCGBca8UyGWEZyZJUC3xqy+rSFza4FZvP
	 dqNompGzWwKorKmBFFcD0XrKxhelCgz4RtXccspLPLHrY9qo1ODNViBQtZB/J/yy8V/X7
	 jj1FGqYu7hrVb0Yli86ldrKMiWyVI75x5a5KjTu06gqg1YIZkkkEjA6pXS57n9/ID31aW
	 Dnix0aJEYEz0cj/8VFRnLt7Yhn50FPk6aINj5u8YZHwH66C3SrNP/O+Zu1TWhIUaYnXF4
	 cRAHETBdHb9FnJ2NdUyb4nNTD983/IdaQDmQBMA+P0CEb0ClcUQMQPYNgj9uJyoAtxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182165;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RlON+ka271akEIm+UwwGOcUmfCI5oU7Xqxw16FqB4Vw=;
	b=QMFmkrTW7P5gOe8FAr0bSSFdVPGA5TY0erdcZfH9NRZwtex5y5kYHn8YJWulQ+qOjq5E
	 cLFbHAU8YPQ24lcJC2dcKO7Lo84b3lea3O5uR1rrNvMSpxl324Wa2oGkGnWC5YZSuVCoy
	 YwjsEwSahQGbzcK1DslzRi0HLCMF2dPCilWAq24fjjK5wjVOAYqq28uZHQMwMzuoOKdL4
	 EC/Pg2oqbvJeUgwa2JW9Wp/27knvfZxq8eyTqqKOe+IwEaKke9litAxmvhOFK/tAAtF3l
	 DXpM1bduwm9fipViK7qWurTeHmh2h35dCrr+7Xi1ceuVZlGuWCCVBzr7J846sOFHFkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="bYmi+T/L";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bxRzWkos;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D76606A32A
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94D76606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bYmi+T/L;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bxRzWkos
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjwcW2155212
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RlON+ka271akEIm+UwwGOcUmfCI5oU7Xqxw16FqB4Vw=; b=bYmi+T/LRHoqTqTd
	94Gqlb50tfiow5+v8/rkXqpFl7NdkokObmijgUeDEaWR+e9s/xS1QFWZehImv8p3
	woqw0aXLr/+6XcP9nlay0j/n4MXOypBgrKYgpOQCejOcjtSk88FTAmz+/HeQ+WKQ
	ph6O4kS2r7YX4pwaKw1aexGUQ9H1/7MVBspLbtRIjy5mjPmk3UhxoiLx1tfDkET7
	Ln5tVYMIg7c7NgVikJrnrsBQ3KaFqefCMdkdmK5iDIpYEhKHaoxL3bRzuR+ppn01
	UO9Yu1cnzw1Nsk1+3OR3yNwgiPuiKyB+FML4DLskm4o1oi6JAvpWseKO44+PHcPa
	hLOCDA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2f4yj57m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3854627c1c8so1301575eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182162; x=1795786962; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RlON+ka271akEIm+UwwGOcUmfCI5oU7Xqxw16FqB4Vw=;
        b=bxRzWkosjS8pui+5AkxngYItwWIeKrAHWFrDhzOD2gkwncEFJLzc4C+ADJHkti4aWk
         iYxtnQvDqiX9n7gzzTrIPIau95XXVZEKfzd8ytGd4MCrjMUqUhqfExwy/88GMEkguojP
         DsxZpb6ynwBb0yPstqRybpHRRbHRX+1HDciLNJRidgw3y9iKAnikA8qoedFACZ1MWUAd
         no/umtKWjrJn/ZBNMdZqsBSSeNl0dmXiOr0eqSNDekrmBrw/hJTROPtj+dHzTAagVgc7
         IxSL65wudh1Vb4fVxHr9CJAksYlIrfboN+0P9qbR4Xgo7WhMJr1DzN5v5Fzx+2/qJtkg
         z9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182162; x=1795786962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RlON+ka271akEIm+UwwGOcUmfCI5oU7Xqxw16FqB4Vw=;
        b=itHSnRkJ6y6aLkf5ylQuhBdzWkYm2G+nB8TIs+b7YifxljrE24WcGowpJgFBOwDjqN
         k15Grwb8dfeBrTD3ZQ1IyjTp+XJgI8zTJxfdsVJlnfWvml+szVMb6sPABPrMy7Al8yvr
         F7gEy84M2NW2sDlN1wXnLveOwYcWjuEGRxS4I9t7E8HAR8quwSeGH1ehdrGJNUB9ojfl
         mWXvBpvDtgQQ2WCB8xvVwqhXBjD7A8Apy/uBjAihUaE+sqc1oTj/8RW+sJwx4VC5f7ht
         cA0uCX70EQFLUny6zYVEJ6z14YzRaoVMPufruFsqEx5up0dCdrExIxuTfYK3TTP4bvzq
         ir4A==
X-Forwarded-Encrypted: i=1; AL+hErHmRe6SiEH0q4xSu2mcVPjkMB0Q3qmHBdOEeiN8Ibd3m3wvAPwO99HOrefoTb/XcckROhvPOA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/mIf/2M7DJVYO8Qqlt8MgqMzN0HF32555/LDwS7vR7OX/opnDT
	nAMzQAWfehBpa8PZ4Xon7UYiH5oBLkswTrzB53Y8YUffOG4wLOoXYAfsIQLkde2k5Ft0ieYYDZu
	gBmKums12tVMqQ2NRnMxOBMJ//13/oi6xdl43FYOOX7Xx9bzWQS98C/+gEA==
X-Gm-Gg: AZFdTZd2dus1fwDrUIbtHgJeenkC3VA+ig/05a7zioyCX/keIYL9FGaThgK/mk9w1jr
	emEbN9xK1VXJbYFMrU1BziRyrKkR7H3W+6cEMvoVkL9ph614OajjE78Xz0qWFGfpmqIe8xePmqd
	7PaZcqY58De+xDlc+oiIw9BOTQFJEPviKGkpOzRoWEgS7ikX5FqL1E3GyvRF47XqFZp1OxECyZI
	WKFCZEGMSyAg5H3h42pjYR7pxoWxPFBo+A96NctWHV9SOcY+vT6w1JU3oCt7hwnMjn2DPJBOcRK
	jW759Fja/QgWG09sD/XR95PWYeD6WQtmWtLCrYHpGp4IRvF2NhGpvLks9PhaE0AIWw0t6y8uUkP
	zSv0qMyqtM434LsSDI+odlc1LwrahTsA9zp7sm/MxivlXZ0O6LRe/IfoELgmJJKTrKkreE1xBZj
	1Q0do=
X-Received: by 2002:a05:693c:68d3:b0:386:912f:c8dc with SMTP id 5a478bee46e88-386912fe5efmr275785eec.6.1795182162166;
        Fri, 20 Nov 2026 05:42:42 -0800 (PST)
X-Received: by 2002:a05:693c:68d3:b0:386:912f:c8dc with SMTP id 5a478bee46e88-386912fe5efmr275745eec.6.1795182161506;
        Fri, 20 Nov 2026 05:42:41 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:42:41 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:34 +0530
Subject: [PATCH RESEND v4 03/20] arm64: dts: qcom: kodiak: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-3-be30526391d9@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=1065;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=nfp8+SD9J7PQP1TIlHLZz6YXOr5xoEhGVTCZWtBdhd4=;
 b=qTaOksY7gsG0/TAQ8p0w3sFjf/8jFeRmyK9JK9OfJYDfD45oWCkSu1bCDoibZtRSCsznkA/ZT
 w+97sfQhwAwD0LQcjnDqzk8oUA/ULDRgLgiINfsKeFTjv+24w8qpbBw
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Authority-Analysis: v=2.4 cv=Zs54uN7G c=1 sm=1 tr=0 ts=6b004e53 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=wmxX9RSyIuGEu2EnybwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfXxZt6aLtnTTzV
 UDK3fpoQlxO7FkcHe9hzjmgbz7DENKQZPDbNBtpfvihBUU1rutim0DUUqqEaFTzuWScGCrOQ/Ht
 bPHBQ7kIUZQr3QQ83d6iStXezmY3LXbMmw8JmfRcTMJhHLd8HcFO8aXD0cEndg7yQfae4HamJvH
 FAOQXjiLm96IZdPtni3XiHFGebLuYu/WuBTNz1nv6QPKZ4ZxOB939GLsH/kYZ0U4SBW3JgtK98d
 IrOxuOdKPNQA3Wo8eUCj0D8PvC5m76NSSL1P459csQG1gQazMabj8BfkcskNvU0mAsijYetFysv
 gTRbUDmfcl3u0CdS8AN4d8M7eMgi9Ms1onzkebqSwKD2b9rfqRGNaRaeBWhJZSKju8nWmvtbuYL
 iaWm5cOCDjsmHcSEcQrynIl6PR6Jtc5NwqGruXdkJegwWxouSzS51fKyojS8XsNiukX9J8iD6ee
 6L9H9wz1c9acLKJb6Ug==
X-Proofpoint-GUID: 9-mURRzC6gmR6KL4iIFo0bc6s3hD261A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX9NMDPJrgSfL9
 oS4/FjCcabdDZabwB4onMoZE7XwOP1YAlcFKnt5Pd3Q30Yi3yoOypOwsaZIYDjIVryFngThiBkP
 QPXHxwanP08JjCUNzXFvo09sD4IQlLY=
X-Proofpoint-ORIG-GUID: 9-mURRzC6gmR6KL4iIFo0bc6s3hD261A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Tested-by: Val Packett <val@packett.cool> # sm7325-motorola-dubai
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 10e9a5279ed6..c142c7cb509f 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -3413,6 +3413,8 @@ adreno_smmu: iommu@3da0000 {
 
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		gfx_0_tbu: tbu@3dd9000 {

-- 
2.34.1

