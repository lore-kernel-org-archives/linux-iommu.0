Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEBA3DB629
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806554; cv=none; b=OlGqvF5V0LYAwJJNRxeIZ/gZ2MbGcwnrBNaTQDFPZ5dASxSm3k16HEl3ECc9Fe8NK5rPEVunHUom1lETvuURBRnQ0Z+S7FGNJfX0v5IMmptq79QUpxIzQ47TLHLnVPmEdSR7lV9hUTAVzR02W8U0X0YqBk4tpXU/OlcXD8kU7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806554; c=relaxed/simple;
	bh=7CPjDV3gT347BVwRIdRiO+KfIxW2/766GVcN3yxQ6iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eoypoStvDi5pfSMP1It0kok77HQrPHz+bp0XQLWDPAQ4J20KUkV/xnsBGEsbu9aQu6yLcCkqHPjZgFA2cHr93npXdMNlj9js4ai1GAQI7ZG6tT6mdcAIOmxynRQzZBWiw487sIk0aqvpOg0KtFNhe4rBzdX2uNaSAYmEOyh2kLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d3DrVQ8k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KuP26t8B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d3DrVQ8k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KuP26t8B"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QEYDiE4030433
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dYBJoUSY2tXC4JkVJCKKmh/DGRM73qQJsyU7sSPqj0k=; b=d3DrVQ8kibecECdq
	5e8AI8zdo2z49Yhp3ixD41bW5GK89MCHb7kbrptCsrcIp+1YpGJ0Gs0+7DvYhrEw
	Hl7KSKUlnqf1HnMNcmHEpOnowuvc335bffuhItaxn117uNjFupmtrNeuvLiUcB+M
	wk/TETWCa0Mg/mkZEpM0qaD4yhukAdCx59cfIRSsRpeVE//c42S2ZhzWN6Jv98AO
	gJRd7VkcbJcmJtsqwo2fLaR1awMJODS8CXXyRQKqJ4pHxLsqPPU57GwvOYSXWl+O
	HC74Pl69Zil8WBBaRFLYiIDTzV0XqJ7+hf3IlZi4Rjc3C4ggxG80mL9Nz6EFtIG8
	9VNiGw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eddd7r1ae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-83836443305so5239321b3a.1
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779806550; x=1780411350; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYBJoUSY2tXC4JkVJCKKmh/DGRM73qQJsyU7sSPqj0k=;
        b=KuP26t8B/On92qw1arYD3uYyA9Otr7Qqiey1opdC/Zpm5ccaxqyXsDeCR5g96bouNl
         z50EqD5T9DnHqIlWfXQHypul2GoLf2vSL28gim4aGtAlLDjYKM0lfXi77ioqLqkuWihp
         9yfvBky+q24Ziex4LdV/mD+2vy8vF6GcbTOlwH6rzc5MhBHr5NzfwXs/pRXxAhRcywiN
         ///JuQEwHfZlUSlGp63CwkibgxB66SvHYTc1cvoYTFV9NBT9ljGgoJ2VO6OPpx2a1LNP
         COy5tZElaeFPo0olPLEEiLv6WXh6HtrTuDGutlrCKxmKxKqqT6JcKWS+C4cfbfvoH583
         8WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806550; x=1780411350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dYBJoUSY2tXC4JkVJCKKmh/DGRM73qQJsyU7sSPqj0k=;
        b=AUNNiZtQRIoAH8p6a3oVq1EqIE6PCCJj8B9kXEitKk6tdDGuaXw8SVQVohDzQnC6eQ
         FOXi4UNQJ3NpiUnP/dxfKL6IgQCNY3RyCaXJUcZwrvzkRvToi85smigGwDJYU1Yjwiaz
         UewKB0kquoYxkjTYbI1ZGzu0rKaUTV2BQ4uBe4P7+u0nekOwzBaeldKrvBW9nIQbO6cb
         MQKsxR29HtUTop7ERe+SAphETi+0xtY+QLrSyGOE/DBadN0d/ZZygiRAp9J/zaYKgOuW
         d2NX74mhjxNXeL6YmRyCWZzLRwK6gxSsXTl/6gyV6V8vN/eqCe5aTDOk9OIRbEgJrkaY
         A6YQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NfUU2DcQXVWWllhpUTn4Cc9lcLRJpUH4HOzo2Uwo3BG7lTXvnsGsnLM53mgRl8L86PWeq1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwisV40ShFZEwnmmb+on6zOnRPpsMGDdIxIkC9BB+eGKGhltasM
	vH6sDlF4/RWueGcMgWnRV/xnPcsJ44Yw/sb/N+lMT7mNWhK7wJbR7gVA94ZrBThTiZIYvWmvEw6
	ah+mHHANS80hx2o8Hj7u0euDnd/22xKTD6iYtH5sGd5jkLZonAePFCAgdjg==
X-Gm-Gg: Acq92OEI+NCC/tonH3S9ENOt7P83FWrfM0kmAMSAQRr0pZAEOky2MKSZOKbWRUqY9//
	74IMEXHYLSkNnBsvwsDXbumROMxZioUriVFM0cBxktnskJ53xKpe36jmVxWQhXgUKm++FAAUb7L
	Hg6Kwi0pV/xw5LbCVyJ6yznEAskb8sGLOKForB7H5TxqVIbF66x41+O2vg7E0BvhPr+6uYZOhWz
	E+6rMjoEE5oB893ffoUadizOKGihEVpDdIUlg58p+9TbQbXGz7U01VutXuOSaEkdNVaKi1UWSSl
	HgpqYvTbMbckjyc7i8raXWNYqY+KtoXbZWrBc6fLf4U6gHutmRoC/oOyrhoJhvZZFzct+ywkYyM
	zhcGqj3RjQDT461GrtNya91XNKncKmXlLWdyOVIlrY83noYqWTiZk
X-Received: by 2002:a05:6a00:b486:b0:82c:24d5:63e6 with SMTP id d2e1a72fcca58-8415f158b74mr16699460b3a.15.1779806549976;
        Tue, 26 May 2026 07:42:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:b486:b0:82c:24d5:63e6 with SMTP id d2e1a72fcca58-8415f158b74mr16699430b3a.15.1779806549485;
        Tue, 26 May 2026 07:42:29 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164acc288sm15362019b3a.10.2026.05.26.07.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:29 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Tue, 26 May 2026 20:12:05 +0530
Subject: [PATCH v2 4/6] arm64: dts: qcom: lemans: Add GEM_NOC interconnect
 for adreno SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-smmu_interconnect_addition-v2-4-2a6d8ca30d63@oss.qualcomm.com>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
In-Reply-To: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779806527; l=1122;
 i=bibek.patro@oss.qualcomm.com; s=20260408; h=from:subject:message-id;
 bh=7CPjDV3gT347BVwRIdRiO+KfIxW2/766GVcN3yxQ6iA=;
 b=A/MmI4Ssrmi7OC54VaSN6M7oYxKCp7bADQdsPSx5UgsPBDQc5G12sWOGN7601WKlO+UYo08og
 Ad8Nd/5nmSyDIpYtetjAHcaFmeiSUGJK2WBXQkcB8NlOSmxjTTSqPgT
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=V4oTa+TgRi7dib76fc92V+rslyRCAKbK8D4b2RVsMbc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNSBTYWx0ZWRfXx9wNv9S6adAX
 2kinLFPEGf7cY6hiVcnRvabWe/rJCa5udA4cEYMDXWfViwAahe8YJhIQOmg4J7RtaCgguiVUCjG
 J1diSXSjVyGmV7FNtXNyuHeFX8Bcd9+3q07bH7dfgjGNP7MkKKEYir0E4yOW0noXEx25EilK0yn
 B595jkMZju6E6fxDqOI0EcrWyA7RH4yslwG9tDUMseRUJJ3hgS9dLc558X1Ww2PlsIGEgFA3LSA
 v1Dj1RVj58FXBSVdfJF0cjfV6xGhhXdm6x8KRSpqvHE/KApNdEHAZyVSzoz18u5HjJ4AR5U0dEf
 pZb34U8NWEBH1Wwdup7OScJDcRSrMLD8IT3wcM6GRjoz3hHqCNGhapyaurAEZErnr1h8guMS+M1
 0WuU7/I0chEvL+D8RwqBB4XVOSVddP6ISb1qvhoKzD3ngY55mZ1KQaT/U962MUNRDR2UI/uISNj
 EbGtOHRNFInjgZmmvqA==
X-Proofpoint-GUID: _02FwDwYg1NFxxBtvkywd5bwBAxkWjMR
X-Authority-Analysis: v=2.4 cv=fKsJG5ae c=1 sm=1 tr=0 ts=6a15b156 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=JCeWlrImN8qIMoXkfH0A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: _02FwDwYg1NFxxBtvkywd5bwBAxkWjMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260125

On Lemans platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 522ba43836a2425a8612506f5f7113f291f34706..ac9f529d2719105609d997874a6319c7d04e1655 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -4796,6 +4796,8 @@ adreno_smmu: iommu@3da0000 {
 				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		serdes0: phy@8901000 {

-- 
2.34.1

