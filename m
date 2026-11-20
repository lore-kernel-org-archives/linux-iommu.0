Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182180;
	b=DpzCgYEhuDHrGM4o2TRSjCWE9T4v2uQZIS/ep8SGeUBX4dWpqQcOizkpfy2a3yfEqTuL
	 zL6Ei4T0/Dmnv8awyoVdeuaUFiXV+m06rxXOyR2yXq/pScAN5VL5sK6pto1R5HEq1ZoUk
	 2Vkc818h8wGUIHUOGr2xpT1Vu5v3PN4MvgQIBxl72tawrHBF9zmA8q+s+KdiY1/HzjJgV
	 cOr2rxBJtPvaugb6ZzcjEIACLo2j00Pcc82PusMHZFHWDy/O1XiB+l5byrMHbVfKDo16a
	 DMiY8/XIJUeFTfSHINs/RJ4YvPZdBY9Gjc0Eo0WCN6HCTXeJhOVEUsLJDvkdv8xuzqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182180;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hL3HLP0Pt+BHfyVSk1KqizSGo5qiQYi0LzCy+jMNuKg=;
	b=cneWmbQT0zc3WDfJ9Gyu4k774Lqq8y5+DZdymkL0malGzBwMAK2hxD01i5sTOspovlMy
	 gfCN+mfOEghjyELC+5J1T5bK8QsIRrWCN/xDCOb+b9NTjWQrE2XpKve4jUduh6SZsTo8A
	 r6LO+n5kxsOcBj/8qQpW6B3D8Db1VhR2uKkC1DlxC+iLpJwljSBCI355aQefsxVPBrhrl
	 rER1Fq4b6oijP4dtkT1fHS8wGH+P4HjEICcig8lXTSg3/jgZfkbwpw4o52ZMR2HLblo2B
	 ZCvlCOmoF5TFfw9OdSRZvALa9gfphpRa18i3UcNEIaehC3I0TvuAj+/UiclXyu1o2FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="A6ZiGQf/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fqL4Jyax;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D779A606A331
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D779A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A6ZiGQf/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fqL4Jyax
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAkDqv1017066
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hL3HLP0Pt+BHfyVSk1KqizSGo5qiQYi0LzCy+jMNuKg=; b=A6ZiGQf/QVWHmv7o
	LgLmcMQ6R3knvmGb13jNkA37r0ZEeWaan8DNF+zQ+gJ4rNPLDpE9I+aQxGawgK3V
	f1cd10G1EFFqtepllVHGXB69EQp/bSDCJFG2RyameJ2Zu1vk7wB5uu6Jz6at8vnd
	gE2PATx+RF7oV8PILaO2iDD4TIzdRfbd12OtzGs3JnyexMuOHQsWS2XBqwaiewgN
	FOUCLyf7a+LvaNV60LXsRxt5HW2Ps7uDijnszZqwMYHy6C6XPJhUuX+Hpyjcwg0n
	HrSC2BDo/QU3fNneX+LutL6URlmZoHVKSbiQRUxXZIbiPYypkm+7pUjV2YCDt9ls
	SU1rMw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2ggqst2h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3846d5f54c1so1150509eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182178; x=1795786978; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hL3HLP0Pt+BHfyVSk1KqizSGo5qiQYi0LzCy+jMNuKg=;
        b=fqL4JyaxwCERVt3+0uxGC6aTaywzoEH9sKcuyqRH7Z/uluy9IyyPmTxDYNJvXrEana
         K8Xpts2jDavkWP5NWqTG5C5z+5id/TOcJ2Smh83iiuyL7Ce5v+oab8zMXGFXTwL3TTWt
         MJWNWPqZjUGq9dh7eCA9Ub8RgC8cHq9vU9vsF5C/Lt6kkyUBbPoioHI9qynIi6WzvNPQ
         HdH8NiLkQXWSDkK4b2wq1yGrIhBfoi03jA67kDEA5WeQHd5taDIDzvEvhQlMEDf4Ut02
         t0/8skyZACi68IY7zZGAgHjxWhfEAX4se6StJhY+/8tIrHDjXegW/gkiM1tVXnkNeQoQ
         vj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182178; x=1795786978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hL3HLP0Pt+BHfyVSk1KqizSGo5qiQYi0LzCy+jMNuKg=;
        b=2BDFB+/dmqVIg+TTkx8wjBk5D5HEpYFagk9F8VNhpu9NossDDxvw/byLQ9L9FXwfkR
         WH618rVKMCsZncyRc5y/ww6wp1knBWHvxmdu1gZhXVYw01cJbgYIYkyH/W9P7hxuDNBi
         r6R+X819lD7fdBvPgaNeZC5E0LV6EkTwmK7eYcL67F4aFX8D/0HKPoozgf3sAEnaLtYK
         VDsXAVNU/9WR4n2qq6l69/OB8k317PQ1Ep6XE8P/32L2An8kS8U8apQBygUv1syuDeoY
         sjz+DQ8HW1mlthZobq/5WkKias4+lEZBpqSLjM1vpEOiyt3NmZO5nQ319pCLlVUE/Y+R
         QLiQ==
X-Forwarded-Encrypted: i=1; AL+hErEVoaeSAOl5HSX7gVRJn7wsc9wDKhbBp++gB5ki85KD06MppDPh+g+yFdp4NNmzhN4nNgnUsw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/APQlGMiBRDZqbkvKx16BD8dzvkR6/tY6U62HCGMnfg/vw/6uR
	U9W2zg1a/S2s/moE/IuFoAS9CY7a9yY8wa8W1EDVfgxKcuV6+qj6LrS5EcKg4zyQxcfcyaexGkJ
	Z7M76APO1ka+DRy4mp3p+PRz2Mulf1pQc5ZWN/7JSbl30WR8/25QpkVUAS6yqQ2lxGg==
X-Gm-Gg: AZFdTZfFHR7wsNkY4XEs3BjodQQIoV2wWzP6R5v79F+q4JFgRuCKxPFDOV/th8/8uun
	WT/AdKFxKObrUElZh/epoC5xihKYeo+/mBkHPLPauO+pKfnbE1dPR38WtmMWPukZfgrTC8oecGD
	nqZ/eyROIrEe9sICSdKFqxOtoX9/77xmzhjHDAD2t/SoyPbZQw8tH9m8sAePr8cjHjHML61N4NM
	bslBP52uricZX9u+jprLTYHPN2p8drpRoJNcoUOtwR0RGNuGYgJ73ChyyOWU0UT/yAakt4WBZmk
	GRszDyJ+qVPAlQCdcRBGSGx4kpK+IoLXHEb+YczIVWafRrVVo0U1IDvLK/uQRUnIFQLPPIYmkgG
	xetQPPFIsrcb6XSItmLQpaomKQr1rNmSJQ5yORq3bXfjwGoHK+om1a7VwZsluAqwsHpnCoA7z37
	Nqbgk=
X-Received: by 2002:a05:7300:2202:b0:36a:1e9e:ae61 with SMTP id 5a478bee46e88-3857170afa1mr4024450eec.38.1795182178139;
        Fri, 20 Nov 2026 05:42:58 -0800 (PST)
X-Received: by 2002:a05:7300:2202:b0:36a:1e9e:ae61 with SMTP id 5a478bee46e88-3857170afa1mr4024409eec.38.1795182177476;
        Fri, 20 Nov 2026 05:42:57 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:42:57 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:37 +0530
Subject: [PATCH RESEND v4 06/20] arm64: dts: qcom: talos: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-6-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=992;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=7PKy0XlSNrGfUIky+MIq+A+DSi/A91nh6BKC8dJ00Ww=;
 b=Wadu/4wuZPZ1RMqU647U3aYS4S7L9vnM9xaouvrfnAAIXIZwIt/SZos6s1LhBZwMDeZqVucST
 7xgxfkv7LgTCl7Wr2EN1tW/hAh1HfiYl14p8mUp5extAyIym+swkb5c
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX9sJslF5DOIe1
 DepXwDKwgs1YxT/G/05Uv6pbtdUzxDvm4ZhSZsMcXq2hGcKxhT977vJCwxJSXbIrogOM/jJ8k9F
 tuzxY/T7Ygc5A4kfxfZqMYTv3GWb/3W4ysCRjr9yLBu7arzBtxjUpOfhciWQ/xsO4iphiODTzFK
 uxXO5k7jHxv4CMeC2qKSH0sMIrjX4vOwDQCgLWB/APGwkSn31n8jn3oHDbiMzHS6dIdSmVwj1Oh
 h8HM+XAJD845CqP0aUVL0MDhZJIdDvJiCGAP4K6oMG8LMu6Kd3tHcrwnvteqyvVAGSvKFrEcHnK
 JjMi07OHsKbKw5dky0JYYUYelfVdO86pVYAfoJpk9ozlfVbhpqn+7OdRnNXtJdG7FeEKg0zjzSi
 V9qEo3bvUnweOubSGvt2dIIej8Jqqj5G66Q3RZSLU0RkZGhsqUIFAap+SmF3Iv5Hx7KLGg+/wun
 DBKKzy3SPEGTiv4n4XA==
X-Proofpoint-GUID: RNDw_6GEemYD0yDX801mkoZ1omNk7J71
X-Proofpoint-ORIG-GUID: RNDw_6GEemYD0yDX801mkoZ1omNk7J71
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX+iVEmIvNuffs
 Qs0iom5O7VVETOzRbRaMnHGzOwKMpv+qg0UUfpyVXhEV1NLX6Xqj9kwuErz0JqnJxqvY2MLEwL1
 RuJinnkWljoY2+jdRH3bDJoVnsVSMBY=
X-Authority-Analysis: v=2.4 cv=CNy/zhrD c=1 sm=1 tr=0 ts=6b004e63 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=rfUXoPsZI_F71NZxNB8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200054

On Talos platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 1d74e459f892..f022a44ae5c8 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -2102,6 +2102,8 @@ adreno_smmu: iommu@50a0000 {
 				      "iface";
 			power-domains = <&gpucc CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		stm@6002000 {

-- 
2.34.1

