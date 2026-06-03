Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B74D33DEC8
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498816; cv=none; b=c6qx2EMRqDYncVE4ZWs29+KrSP8r37ZztusXropde9xzNXuc3GF7uzqL3DqJ5JCqUVD64p5ZGXDXgLFxAWRpx2YnufRr+n3/Mbkw2zYUROHayKlOM2Qbqow6iS4/35+8PmhmHbM9U+OuAXBngyPYQQxHkv0FjzCCC7qImHdFzyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498816; c=relaxed/simple;
	bh=a7vBq7QV/0yauiv4Qm+n0KSEd9tQP2btOuvl9/RRzPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSm2XKcHpu19XigZDoQfPJcbb/WPmCwpVlXn4mgzoYx4gDjFLeRdSHZa5/UUNCMkN8U1RdCLKvcZWEpMTrj4zI+OsW9X9yjSZGc5UQ2fHxPHhjIeXiBR6SbqJM3VkY/5/eFPd6/NXNHGhfx1B0Jd27hULd1eu3oNvRGFfTv+CvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sug/L9WI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HbLnRxEl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sug/L9WI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HbLnRxEl"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653Cebfr2076090
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 15:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	18c0uCFR0Vx98Z6gn2p5TRyfVjWTgQskztRp85wyJKA=; b=Sug/L9WINtQNcSA+
	VWzI4NBOLDJYWHDxbR1Q2y52ks5mWmpK/zQDBuk1kYiiuIe749UqP8HxcnCXSNfF
	+k4v1Z5ISAxbWErr5WJj3qbI83sK0npm7bm3T6/lBt8fFS/a7ke9CeXLBm0KUaTr
	ITw9IjYS2woEBFMtwqR2B4ZZHW0Euind+QTa160zVwp45K2jPM3h9ma/DBZDwUPl
	r4ZONSuc0YhF1FprECN2KA/DFYpRX7pLFZXHWuZcnTzLV56SVYM3fvcYiYIjD52T
	EeB2ULUr97u5snKtDVXW6Ig6esFb66y+3cqYs4GkTmfZzwazR/qiOlE4vd2mBwP/
	ym8XPA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev1a4wm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 15:00:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-842208d5b0eso3387333b3a.3
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780498813; x=1781103613; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18c0uCFR0Vx98Z6gn2p5TRyfVjWTgQskztRp85wyJKA=;
        b=HbLnRxElOy+pOJf/F2tFhX5ReZ2T3jJgsO8seB5P8nBPdD+0Nvnvkc0gC5HDXhxtHq
         adez5vV8FydzfAbdrZXfrtcSNLahT3e0mZ2I7HxWEsC/DzoX2Lt7YfjDXC+fF7qcKC9z
         Oovtr/1HvfO51L5GnWnc62QL39PCEq6X8Z5rb4y0OkS/CNRvHrUOse/qppv1Z5ZoDEqZ
         whupf+2Bm5PcQ1Ox4dSwlExfzB9GMtBOn4ebXr9s+C3lD69P6/5w50w7tzDBbQgKAk6c
         zGYiX83ICagLJchdcjNmIx5BxevdVaqvYRxQkqrPSrA8KBpQJa0EQXeLz8qdxQsTPW6v
         ZWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780498813; x=1781103613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=18c0uCFR0Vx98Z6gn2p5TRyfVjWTgQskztRp85wyJKA=;
        b=PecxpOfS6xgE4zLrtHgqte3gAJFu0VeLVlzybIS+qbPzl+ED8lOyDVBrgLte6Z2f6n
         XqbB6o3pWeLRv0n9eroHBb6wbz45kbBbVQNJ06cTjlgvwJWM9wqfPl+xxWoFKgZAzFaA
         AubZmnCsi1S6IFe+4PRvt0PXzLBWrNcJnQa+2Ob6cOuS30nu8OVw5haoNcNn9RM3eylr
         wmHQEwSHBDGFI55aOqgMLQj4aBnm9Fuc0SlSOnIZV+SNflNVDb1hqGKEdDHj/YB01TEj
         FlxCb6S4dccwXFiUZVAWLVPv7s1Jnyj6rJZdzHT2bQg+qvqF32pvIdCw1XSJN0dVUzg1
         XsOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ctjfohu80aoppif3BzniT02EnRhj8UCZPFDDwltbgad0EN2svnqRZy1KlKeWb0XY7IBorJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRCkailZ5bS5vKCHqfhXOsl7fzBCLksNG//Nc/LtuW2EF5mvIq
	4+5Ur6ijQRai3WwrTlODEl+F4fM4hbrTl8ziR3d3kWSSlc+Glx0RKejGZ7wi4GSDv+g5ubcnykH
	H0+Hk/aBkLxrS1/Uv+5X0QVyxfNVWwIiQnRWwxzpnSmRfOmi/agXo0U6tag==
X-Gm-Gg: Acq92OFUIayY42y5TORMv4DTwkYv8dZmLChaTK2RakSlNLzF6+e8zJxh8b4PS9udutC
	u4aHv4Skvpl/96YKKhOIQdtp1sYZAl0IPRduSryPvv5Qyulou3fiNP9BWYU+mu0yXJlhHBtpVfy
	5qiK9Cn54UDJ8A59fB0+htMEf9rtT+2nHImycFCi5uIvzDZ42ykotzka53Y6/SGKwh9tSugwdAy
	HkkdY3TxUpzTYnQ5Vg5tdL4tA3FFY7kR/36Vr1hWkziIXkq+pXX10SrKiJiousx2E9UGPtaVrQT
	NjpB1CPgMdptvHzN8R33FpeIsVyNTfZMxlb+JB77pqGwFIJ6UzwQcq5UWWUnwFjen/GE3Wc32oB
	XaO6rTnlIBDkgl6H052t9FMWqqz9b6bBhRUgK0utvc2kiKVHyv8ST2lqzIoo=
X-Received: by 2002:aa7:8887:0:b0:834:e5a2:d089 with SMTP id d2e1a72fcca58-84284f1bdfamr3771740b3a.33.1780498812809;
        Wed, 03 Jun 2026 08:00:12 -0700 (PDT)
X-Received: by 2002:aa7:8887:0:b0:834:e5a2:d089 with SMTP id d2e1a72fcca58-84284f1bdfamr3771679b3a.33.1780498812312;
        Wed, 03 Jun 2026 08:00:12 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882170sm3747409b3a.30.2026.06.03.08.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:00:11 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 20:29:29 +0530
Subject: [PATCH 4/5] soc: qcom: ubwc: Add Shikra UBWC config
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-shikra-display-v1-4-aeac1b94faa7@oss.qualcomm.com>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
In-Reply-To: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780498770; l=988;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=a7vBq7QV/0yauiv4Qm+n0KSEd9tQP2btOuvl9/RRzPk=;
 b=LODbReeosUf6ztstgUJKlWgizfw2G5LN5Ygs4s0z7okzEppVrZbtrF8DieJuyRHJDpr2KhVsO
 X+HJ7VKFlFUCz+q/m7DTxr52OcTpVegvlvq5s18YKs1fSb0RScsxD/X
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: Oad3Mcj-PXbHwH4uEGUOmWevDkjw3-7q
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a20417e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=4nfEs0z1Wzubab7DKycA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: Oad3Mcj-PXbHwH4uEGUOmWevDkjw3-7q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0NCBTYWx0ZWRfX2RJx244RqdRw
 fWCov2fuozpDxus1qkvIQdROCV5L8a7nIEua4ugO+sbkTcEsk+kAEzCbjBH8lMcNDHVVsmhikSF
 lpLeGQ9c/Ie7bxWpg+6jpFUpBzXxHNfMX6x7xEuGJJwXWXCREnjIeraxPiWvRkVay8ZIR0t5g6i
 6RNa7eYj2CkdbG9YZdu5Cf+w2xnb5uPGsJt8W+QqmvBHLVMXjmLKEqEurLzT3druUZxBhdGdsv3
 3if6J9edBrxlzq7tDBIv++qEzSZx8r1ibtsz/vmeov2YbkuW3tZqzUTcKqg/lYs2hcHPwvaK3il
 qyJHJRH7uyogk2XKAN0pG3hUMdK61bzOXdz3lbGiAt8iMRrgTOAcCrUH1ZFbrMCwmSpSEJt/Tc5
 aHkKM3+6cr1UP6YBehbYhO8ItoPKDwDaxjpS7YhMM/rHsWS2sjFwL6QQEnSGpGdraZ0NZXRDrp9
 tsU6Zq1KCxeWlNl399w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030144

Add UBWC configuration for the Shikra platform. Shikra has no UBWC
support and no highest_bank_bit setting, so use no_ubwc_data.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 3fe47d8f0f63..01dca97e2671 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -278,6 +278,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,sdm660", .data = &msm8937_data },
 	{ .compatible = "qcom,sdm670", .data = &sdm670_data, },
 	{ .compatible = "qcom,sdm845", .data = &sdm845_data, },
+	{ .compatible = "qcom,shikra", .data = &no_ubwc_data, },
 	{ .compatible = "qcom,sm4250", .data = &sm6115_data, },
 	{ .compatible = "qcom,sm6115", .data = &sm6115_data, },
 	{ .compatible = "qcom,sm6125", .data = &sm6125_data, },

-- 
2.34.1

