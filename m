Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BD477E57
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576304; cv=none; b=ZAOD6RD+/1qInqiXEcFtBOE90REXfn0Fj6tTHgnHBOXX/UXvM8tg99M/+nmw/QhFJvpG0OLLHqxnwrzwDcF1Wu1Uo2WfHFPpIpQWwShDiC4L8eJyakXF/tC694aH/5M1tKl6/hTQuBPNcHmHFlquhDvPimuhj8BcO6UgjzYddIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576304; c=relaxed/simple;
	bh=RszZ82isccZ6HTay6fmDewNiy8+hVMevI+lNe+sJbQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPnPSmgv9QvWkTpYvtBDn8zCeRLLORyTvITBRAoFm4afFqM2N0QHyt79tulBGJ06ZRiWDnTHUetBwuvzT5f3nK9LzaiHMBw2PuQQ9UsLjV62KTce8+gfP059il3ae3wD3rlpBLfiAgIJr66ZIsSDaIQjhWMgr0pfcB6hijkFvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IKKcfbiQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PK7iiHnm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IKKcfbiQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PK7iiHnm"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548AkPJ140442
	for <iommu@lists.linux.dev>; Thu, 4 Jun 2026 12:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q5uBWSpIKAMT49XBoIDUyB5FAbxKelakvTHVeHNdNyM=; b=IKKcfbiQd4EX/21Z
	A6rxQE9bFiAjZalDxu5w+ZGExnX8akdriSFl4molN+SrcgB++6I0Zz4D6csgi/sQ
	CkVNQzKtcspqMHIMbZ/1Ew+/EPoQHgjinFCqn/7pMn4rSYhCZnRQq9rB+syYX4Hn
	U8bahJGzatQZUYPRngyTONXjAYU/hdaPQwlJkXUdaL49+8OZ5OUWTawcJv1AzgiO
	wzfdrfbmomKfTVnyK+YMhzJ624xZi+WLOnryrOe3b/ytmmDLFIndfHD2AG6xJSma
	FpzkfAznOuLB+XGDmEH92xNcfq2iYNYcc+4yQqPVOd71y51JDa3IluqYyS57nmUv
	KFKbvg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejyenaab7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 12:31:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85a2c665easo937093a12.1
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 05:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780576297; x=1781181097; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5uBWSpIKAMT49XBoIDUyB5FAbxKelakvTHVeHNdNyM=;
        b=PK7iiHnmETPIjLhaQQaQOsl+7S/BPU58kqZYl/TvKW6MtEH/mzPrptmiOtS7/MWM44
         avzrXuOoRJ6Z8NQvjhIFV1o4RKfNz0iXpPDh+CRWWlFptQXBR1uFXrJDzngXaoVcU77j
         4nOCMpHuFDhOjNOurQB7PK129USojEQHc33M+kUHX5rl+xiUrcfEbfN6qUB49dhazcC5
         3AWEJf44TkHd7CeBhOsOXBPeHWjulb9cfvhj/mrJDEF7A+GYVwm4DMMYkJT88UMTlZNV
         ucRu4sxi4pcEx8AeZuQSELQdv0lHxSgriCR6fGpaQYRg92JI9CnuP+Q7iW+DTQqyjoWM
         sdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780576297; x=1781181097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q5uBWSpIKAMT49XBoIDUyB5FAbxKelakvTHVeHNdNyM=;
        b=MH7dS4ZTdGOT7p29eIKtprrxY6zrUCQr4BhwUMg/3RW02zt981dA0RgaBi6alxGKJx
         GUpIDqgp7Xw4GV+Gdc5MKGRjVNi7Qd2XsoSmEhALqzZDdgm94zt14rbdH2x8SM+k0OVw
         /zhKjOFxhZrmcELKZbINoCHJjo5lgygZ3AJtX9al6FBojRsMLTU0Q9ZXmGC1nNd5R6KK
         EJwE7QlDXAU58HxexnI/FTRfkq2bvQ/dEVkheCBSY2mDSGQSeQUzEiiic0ohPWRpTnwQ
         lJiKtDYi0+K/4y/++cenJehJ5pWObLmfjgcXjTDN9G7JXHFF65r1igaJf4xLr/LsscM1
         kekQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rSwmB+27xsmpYy9YHDwNXWjiiG4Z/AXnQMqpRqRyRAN8uuuc2vNHNdQY4HL21NNFSOYm1uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzI1fI06uSucTftaWfpwVuS/nY4iGRNlLj55gyasMN+B63JrZWW
	hehqCY2LHdL1ux3WJi3dUZ+zruGAPcBYPi3TQV7+IzU7GhJws/brBSSYvKH5h6rVR1ueMkUm6Hf
	Jyg2HmhZpAf6Yc5I6RepHfKRQFmUFx3Y1WHbro+fSf6AmTrtwJnWGabARgw==
X-Gm-Gg: Acq92OHyxhfOtisiyksaQf9HDSrgQYF0Y0vy/da6Bp3X0Hzls9UBypJJVaLVctEtG+E
	B1N7gWG4KPlAkeBNmnP5RkwLyCh2x4sjumjASGoVrTuKcaGCjpTCJFHc5VEZH0CbK70hd4UqgwT
	a0mMgKdSIpLtxN1KADzXTj9r3IiTraSMKe7VglIzA3iZFW6gKQG8z49O2Jv/AQGzYOgIF7UqjxR
	SxmtZqGcMz0u69Zx6I04VWafxSmt+D5MskNUVJSI5wjhJR68Kwtf2rJ28M8LDQFDbnMRKC00oYA
	aNSt+cR2Jjki9Gz6zLb+rXaLjN9C32pGMipQdBa3YROs2JKP0TwnEhE8S9WwgsVUEUN1N6xs7Bo
	TNxWMnULTpC1k9UqLCNVpEaCzL6OtP6t6BCZ+9hDzaSRE1+63ihkmKyZaxx8=
X-Received: by 2002:aa7:8887:0:b0:82f:355a:857e with SMTP id d2e1a72fcca58-84284f19a34mr7916022b3a.47.1780576296732;
        Thu, 04 Jun 2026 05:31:36 -0700 (PDT)
X-Received: by 2002:aa7:8887:0:b0:82f:355a:857e with SMTP id d2e1a72fcca58-84284f19a34mr7915977b3a.47.1780576296198;
        Thu, 04 Jun 2026 05:31:36 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428325d9a3sm6015917b3a.34.2026.06.04.05.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:31:35 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Thu, 04 Jun 2026 18:00:49 +0530
Subject: [PATCH v2 3/3] soc: qcom: ubwc: Add Shikra UBWC config
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-shikra-display-v2-3-b3c1b2b67edc@oss.qualcomm.com>
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
In-Reply-To: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780576263; l=1005;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=RszZ82isccZ6HTay6fmDewNiy8+hVMevI+lNe+sJbQQ=;
 b=b49w/HlsBNCONlirsUpO5rkEIu3aZiKg8UbSER51g6trjxtIHBA3pBF3VltP4RNl+n6X4WcDy
 tWxKEYVttzaCry/mB9JVehbo1q/1hFQVEJvE8KFVIUyofFNpmhHZ2ea
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Authority-Analysis: v=2.4 cv=JaSMa0KV c=1 sm=1 tr=0 ts=6a217029 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vtxxaatxrD0BdpsZsnUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: PCbe57f9G14euiSCEgunc63x2GjvMQFX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyMiBTYWx0ZWRfX7DCbwS4y1ZM/
 0w8Cq8Gy7K2H/Rt/5wFAnYJMmiOytLmxP+uMdJfleOTWFvb50q8Owjg3152mI3K1Eh7xBS57KML
 7qxfoE82p5Il9XoXRcMpHNTAy1P879mbW/fEbqHD+vXiAkaTiefBwVfXvc8poY45uI4OLM21AyK
 kltgUjp58MKi1D2Hd5DcdCSgrNJG62WyXDX60Y0KNJkiqmLr3jcjSsKlo1ST7QhrLHo3QA6O9lC
 g4q1u43qWIaINz7Ehnq+tyKCr/pT0qP9tP5n76qcPXEFj4Tnsvm1uaV4XGB1td2qoPk3fLRph1V
 ej1B6zHpS1FNjYNhLSJO6tT5W1q6pMzeGXcHang2NdUzIETP0sVgQ2R7fYvEt0qxO2caOI+UTUV
 /IA/PHKwFxi5eVz4PblHfsPH3z7RRr9sldEb93MQzyqVag+vNrzUWnTzvPPNg3dl4vLgvW3cYft
 r1pe/Ij4aEa2sIfwLLQ==
X-Proofpoint-GUID: PCbe57f9G14euiSCEgunc63x2GjvMQFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040122

Add UBWC configuration for the Shikra platform. Shikra shares the
same hardware as QCM2290 (Agatti), so reuse qcm2290_data for the
UBWC settings

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 3fe47d8f0f63..1a2e54c6480d 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -278,6 +278,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,sdm660", .data = &msm8937_data },
 	{ .compatible = "qcom,sdm670", .data = &sdm670_data, },
 	{ .compatible = "qcom,sdm845", .data = &sdm845_data, },
+	{ .compatible = "qcom,shikra", .data = &qcm2290_data, },
 	{ .compatible = "qcom,sm4250", .data = &sm6115_data, },
 	{ .compatible = "qcom,sm6115", .data = &sm6115_data, },
 	{ .compatible = "qcom,sm6125", .data = &sm6125_data, },

-- 
2.34.1

