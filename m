Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9CF3F7AAD
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654783; cv=none; b=sWsOoIVNMdCzeG7pCaaPwKiPCfHp65/KbHhqJJ0ivSU/0opQ6nve1OqQzyavMI6PENIPrcDIX/SYX0pQDBGmrhZB44PCdGHP8Qd9YCYtUBegncx1pzdTao4x+nyFYDsaCnwabYQVoIUifDlhiLCsZ4K0sIeELFty/uv8AH0MoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654783; c=relaxed/simple;
	bh=rVf9yUiI4s1YDWhWJ0K07qBAlGQcKyt9Ku/bgoySARA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m7D8+c/o8s3NpXrbtx67OeLRy6JlEGwaKXOrxmVXE8Vkysplm4/bH6fmBw+LsOG4Eez2M//Gokw7JpOhqMECs2VLM5nqbi8LG0V2il0QPHLBvx1wiN8kqAnvWFbnaE7oduVOP9fzG8wNiP/LkxyZlSKryeQ51Ww2T8Khnse50Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oZEblcQN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b8A0zSus; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oZEblcQN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b8A0zSus"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6558nlQV1957385
	for <iommu@lists.linux.dev>; Fri, 5 Jun 2026 10:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jg/4zRj4OkceNTXlSoSEHKDpleifNPnfj3feVytWbh8=; b=oZEblcQNWqkqEQSh
	X9TIIJWFvrr3+sTd4bHurOifca7MU9O632Yhg6hpI9JFjGCAO0Gvdczd949cun+i
	aYnuOpuOIK3uokao1T5xNXKdQBcnRdLS04S5kRzkrxlI206IdjlfXxiOj1eX9xcB
	0QBU3D5B3mDyEfMxcdaePg3Aq4P3w0WPjeFt805S49fdFmdTzhCWSHULO8W3nhNc
	3GqqXIyK2bjO4DBzVw7gDH5b5Hr1+ooPRL+GH6E6aEgqSGR1bvt69lIaghpoqj6i
	NKFqDsjklb4T+GBRRGY0cl6/lXtqZ8cxUaPXQ++VN+fndJqaoWZSLHhwA86XeXVI
	K5Ud/A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekckpv51a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 10:19:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c272e532so19770515ad.1
        for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 03:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780654780; x=1781259580; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jg/4zRj4OkceNTXlSoSEHKDpleifNPnfj3feVytWbh8=;
        b=b8A0zSus3gcdjgtQDe4GoiE42U0awi1A4hfHBs3QsSo0NnNjbcmZnyPFv6xXDTtyfP
         iIsFNaofCbAUEBev2Cj0xiEOK91HI4UAIDwJmyNAbajOrCpA8EPAE0mSasSUUFKuXL+C
         etLj03wtdfb4stwgEg7JW4+kXjFkyqBjzYhj+xElImGaDGXbcwBbfPHOvoUQxtRFq5OQ
         z9lZ9ZAVmHc7e/1L4LY27N0ixVUlcuXRVKNBQkam8rKGwOQ0adLu5nSooqrzjRL9WH7d
         FzZ6plWVrAnvPNFbGFVYZU9VRiXg1SPZN2s1TeTgbOvJNs/cLPhZdOwouZKynHFLYDk+
         cNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780654780; x=1781259580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jg/4zRj4OkceNTXlSoSEHKDpleifNPnfj3feVytWbh8=;
        b=qFY/FOAdGVBfMBHcGUOc8qo85MIVBELHzecwSldjQ+49SdNJWJRAaE5XSKRCtic1k8
         OkGOS6JwcYjZe/2qV+8B7QjOer5g7sW+gKC190rrhnr7pU6qksAFYLoafGNGNS9/rI9T
         mgcx3pF3gb6aJBs+UKmg3vqA4xVtbVXR+lp1DhImzFziHNyvZM0z7JdxBk5jYdWhOVCV
         eCo0BefPBw/1Rl1DGh/VHK2hOcjrmHdkprw3K8R5IhtKogYhV7xESY75ny1r7w1tlLMy
         VL1PXCEnmtCeAkVjMZGIUWq8Kaq01cM+/e4Z54fFRzIvCqTG2PseR5F6gVVwVJYUMVd2
         kiZg==
X-Forwarded-Encrypted: i=1; AFNElJ+vZ6nHxqtWRXwrNptnELJMMbR+M2nquUtCSmfxD8YW4z0wGvqrJvpkMqFNLvMpHNmAfT0EYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRotBgJM+1wch+9qf38TKi8LhOHM0t1X9ebAo2JAMZDMRUqh5m
	C4ga5omQIea9JHdEIyM0IDN0dP9O6kbDnNd1FyKanKlnsKR9R3+UZChJQHn0iRxf19LHKejlmps
	FZeunM/yy0bx79NBItA7zX3KY80gqeSySBUhoroE3fT7xd3gRbHeQM6ISZw==
X-Gm-Gg: Acq92OFUqpRxrxEqrNNMtDEnEi97FWXXXffj+TxaR29SqjmZfIQ8ZGjFML00SyVuyb+
	TqciTTUe3Z7Pgl0G8qdizV8n+o+WmguMqyDzQck7QjfKAkhbh6b81QujJsBtniGC6PnJrucl2BJ
	pxLyKBc2mq/1XfoqzPOBz6ybkBdt9P56RYSFQeKKNFdKaVT4t4/kKb5S0Ao2gct6HwqpURyrqMW
	41G68/fgA4ChiorHE5Y9hD2XnqbKK/JWdFhcd8hUR+pGHpCRu9wEFWj6twhV9OcZeBFJEGex2tG
	LlqmHGUycviVspxLhwycWmNPlQKnBqmxa2kFwQuFXEouqatHtH++9h/+zpVUtiHWk6KzOtbnq+M
	nIiPkDJKkTaZh7gl9h6Ot/4qU4hZyV3pMZspLiPXIgDXMmM9n8dYHQv8uCaA=
X-Received: by 2002:a17:903:2c08:b0:2c0:bb11:19c8 with SMTP id d9443c01a7336-2c1e820db02mr32151715ad.36.1780654780035;
        Fri, 05 Jun 2026 03:19:40 -0700 (PDT)
X-Received: by 2002:a17:903:2c08:b0:2c0:bb11:19c8 with SMTP id d9443c01a7336-2c1e820db02mr32151295ad.36.1780654779579;
        Fri, 05 Jun 2026 03:19:39 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa0236sm89741445ad.33.2026.06.05.03.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 03:19:39 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 15:48:53 +0530
Subject: [PATCH v3 3/3] soc: qcom: ubwc: Add Shikra UBWC config
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-shikra-display-v3-3-9846ba5fe635@oss.qualcomm.com>
References: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
In-Reply-To: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
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
        Nabige Aala <nabige.aala@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780654747; l=1072;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=rVf9yUiI4s1YDWhWJ0K07qBAlGQcKyt9Ku/bgoySARA=;
 b=7rX2EC8uhcDt/DiMdC/pz/WYl5oqxXXseJ2Vos332fRcblOHX5myBQRMg8/MPOkIQQLugj07+
 GhyQMIiwGzaBxX3jfm0F9vACJHj7WKL6YaYot4dhEnVPhF2JXqDCa4V
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: EKXrAcPtwIaBBBvL7iUzKk_Ixwt-Lzxy
X-Proofpoint-ORIG-GUID: EKXrAcPtwIaBBBvL7iUzKk_Ixwt-Lzxy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5OSBTYWx0ZWRfXzbbRCLSCaQfh
 o4lwKO3McxG8aL61CE2EBTkNpZa8qs1JgVTgjI+raCwAlY2sHUHZbmP8gg8c8QhJjtZhbSu9byE
 iTGwnSy4PyyBZqzKTeBBvo+U8U8PkwIQTCYZvxYBZ0Bgkin3DeR/Tc103gbgZgMSA92ClBL1AR2
 DU/0Ap38ur0wWuCFEwuZjD2LuOFO13N5p02yv9EkHzu/OnFlSGzxNOGF5L1hLbtIVnz2KX6yRAI
 6CG4RqjWxfmZmqYUYRmu7k7FWxKrL6ULCUd7BvxDXvIPtQpcGnkLfCB+qU0WALFrnPN1vH65Edn
 OOr/Uq0tNVCZSesEwIRcaf9nGj8idwR9rUx/IL+q50fxFhxAXIE6aud57ovjq4U1eD8NR94okKb
 XKUgfqzD33K7FPIE060MCTjNjEIrCepzU0OfpVpe0zh7IGv7u4oYa+mjPGf8v28Y6C0ggbK/LhJ
 ZRUxIpjryBzs2Fg8O8Q==
X-Authority-Analysis: v=2.4 cv=H9jrBeYi c=1 sm=1 tr=0 ts=6a22a2bd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=XuKMx7f3ltwE3Y0lsuMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050099

Add UBWC configuration for the Shikra platform. Shikra shares the
same hardware as QCM2290 (Agatti), so reuse qcm2290_data for the
UBWC settings

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

