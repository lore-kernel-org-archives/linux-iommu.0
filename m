Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960D43CEEB
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576296; cv=none; b=QSF05hycjqaqJbL35N8TwUWNf6jaMEm76oWRrHfMHmOa/LoWZJcW++SpF45AVem7r4Z7yMmfOaVc27iFhHsZqfCb8WOSoGZPSXrFaUhMTJ0PW6HhFYHPAvMlOCRk/tmWnescdsgOZx0/gHukOmhyDagqmqYKf/ihF07oiGeZxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576296; c=relaxed/simple;
	bh=SCs9KQKBtzRapnZIGqIOvP+xU2+TnEvlesLmeM6sxt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CIMuKxbdJO01hd7zjcGlRjslFn6NZLznOnpkPqQd1EWU1sXJMpb5Wm2jKjMxj2Wd12w/L965N6tfsgiDMWJktw9GVNSA76wa8G98f2cWOdfqa7Z6xwCIvxdWD/QTMxLc6R/jNwcnndpJE6RLHBoDzO7V3d7/YHQpmsSdGkJ51Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MfoqlJm3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TgomGZZ+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MfoqlJm3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TgomGZZ+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654APrRQ1993364
	for <iommu@lists.linux.dev>; Thu, 4 Jun 2026 12:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y6UZz8IjVdVITbvOPHhdrUuJW0/kbNYyuOsWRAfVo8o=; b=MfoqlJm33MHz1RXo
	VaPPkj7+9L6dYSMphzMDlXqrUxYF/tjEoIaBQsTAwlti6OLji+gN+nAsJGO/pgOr
	e4NpL7icnywOddrjOc7u8ASzihLlaBh2FYSz0ImFmOBxThr2oVP4m4sD5PfCv02i
	FaX5dBYRefGXGmnzO0Tnz02AdXhHQlZl/Kk/9Iki20jVBtV4drzu5xcwRx8/YbVo
	edZGNzE9MGTpwvdaI3whUS+bByWFPVr6stI3/QNNzPNBbn/tFvxrkF+186FmDCGO
	fzIVCAyvweoGEd7bJ1AyvG8AINWJrj9Vyb1oMQtgIs+3kYleQcfTYXtadv24EWTa
	YiUnww==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs8pumx1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 12:31:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8422a0eee68so1016589b3a.0
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780576289; x=1781181089; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6UZz8IjVdVITbvOPHhdrUuJW0/kbNYyuOsWRAfVo8o=;
        b=TgomGZZ+CxsY5ZIWP2Gjs3YhzldN5awMgprKULAO6UzVJqiOYc1/E/TcRuFOpPWTL2
         j1UyCQnnlK7CefmWljpvps8R0dWo3x0da52j5DfzUg86wDalgHwDU/Y/O+Idk2ZL+HEu
         TGd5kpDW1Yt6q4YTVFH9rX6YsU4s5HuRMd+l7jw1+gM4nMPk3zw0bBkFAWCIZiUqg3Ds
         QlMhN4T9igGA2FD8HTlcpLnSVNGTlRu+D68UaBRMOKaxsgFcSavCvOPuphqYY0V4LbYI
         4AYTlG/lXQZUVBMLnoYP10T9cR6/HBn6zFEfMQi20yA6GpBAELdpdhFCv9J2445TeaJj
         jIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780576289; x=1781181089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y6UZz8IjVdVITbvOPHhdrUuJW0/kbNYyuOsWRAfVo8o=;
        b=IsKMnHnZlI5q7eiktjquVD4Wl1Y85mIrmUjBjPf2LT4CXxUjfgN4YXJ8tv3Hr3G1nR
         WKqWWi9+9oC7VwY61k7fKjNIyvcNDTNZBlppuafVO9p6TsqSN6xZa/gwaRT04EvkncVt
         zkIzz+3iPuvMxhTSUxwcABMGEOEOHrr6T5TYNTQ6DR8xZ7rGoBtpty9XnGKcyuXWX3lP
         0JcHJVoOfq9jaG8a7W+JWTZt98iGMt4NG6FLADU0KIUbIyW6mEno/Q3mYQZxJml/C+SW
         VRd9TUvB2/forssJOVgBwBx6qdyAPf0S39y5omXFchGTKWeD77rtrZeUlrMsrLFjVQjn
         puEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dmdTe/Wq5UHunOB4HC6VprxplXRcvgkAXQnXW8awohxiW2yixKVCBsKcldj3INhqkB/jODQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+YQnnLHoXC49uW+Dpb5XKKNozAKaPM5+/JYEyUuhSZChrElzq
	iRmb+goBhQZmozo4uPcfH+JsI8ug9CmvC/fYVO5+geOTq3lvF6+T2hr0zvuvyv1YTAQ/hVy4fnR
	YAqh0He4gG4PcSXG6a7yQwMtITx3/zwyHt+BfmH6X1la2dgcY5CaKDWLKFA==
X-Gm-Gg: Acq92OFCDV+W9pd5V0MDYcLsLqDBgDwubtTbIH7H0Z3a1oS9mIrz+pFPyy3/s9NZsSD
	tei5yvIfOpH/gN2CDjP5d5gOWDWa01iguS96CPHuoy1StnDTG0USTIxm0ALcSknFHceTtXXdiMx
	ZYl3JO5ubY6heYj2vq4kDVOg+yTGdUyrlzZMxf0TnwjnTkRQBUR4kR5DLADUZg3YnWTzOrxW0sd
	aHqpO31I0tdaqnkkSHKTyzOnpywG6DB2c6MXggLow4LX+kAcTr9k6aYqiHzRkFEQwvIIM16bgsZ
	Uc1yQ5n721bvrrF3+zePK12P8vKbi4KkeI6G6wzaaonrvI02krAxr+iFGSclqAfKLxFeO5frE4I
	YJo/gRH6OgTJrxmWuZvnaD2F9TGG5suuYrj5ZA/I/WNy+HrldCchSkF5yaMo=
X-Received: by 2002:a05:6a00:6c87:b0:82c:d7c9:5479 with SMTP id d2e1a72fcca58-84284e8e557mr7258361b3a.32.1780576288654;
        Thu, 04 Jun 2026 05:31:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c87:b0:82c:d7c9:5479 with SMTP id d2e1a72fcca58-84284e8e557mr7258325b3a.32.1780576288185;
        Thu, 04 Jun 2026 05:31:28 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428325d9a3sm6015917b3a.34.2026.06.04.05.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:31:27 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Thu, 04 Jun 2026 18:00:48 +0530
Subject: [PATCH v2 2/3] arm64: defconfig: Enable ILI7807S DSI panel driver
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-shikra-display-v2-2-b3c1b2b67edc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780576263; l=708;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=SCs9KQKBtzRapnZIGqIOvP+xU2+TnEvlesLmeM6sxt0=;
 b=m9yIbYKaT8kCKl/fs9wocRmDzoj1uNJswWvdoxbvdIWYfP842Sv1SMBB1G9LaTbU0FTO9Vdyl
 QvUjcv/T4EUC2yeF7PvcAc73PU1HzUvdE6d8SwFee05DqQT2ZjtUuHp
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: q2WsK3DGKS-2kPfsHgQJG2hAIsAStKCK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyMSBTYWx0ZWRfX8+BVQ6+LI9iD
 dDyI73bSh/gu4Asy6RurnSLssIdnj9QVplIfv3KUG+F+7Xwm3Gc3ZJmZjwScz7HDO6+cWjQA+g4
 fbSTfapeHZVx9fPTTbIYaPy47AA5nSl319ZmzWKiEvrP32j1Rl5g6w/g5O50e/VJgEC223dxgWP
 Ib0kYLOH/ayk5/BqztXiYx2Arkvi8SEJ2pVhi0+nqYO96a8agLAqXizVWYolNDu0Kw+BU3ZMPD4
 gx5OzSzN1QR+FBJwhByGfeF8HJkxOLWoNTUztJ1FO9Xcf/Fo0ZzW+J+HhJzqeGSNusaEg74aYws
 /69C6put0E+kmSJbVphmyUcL1uc7CVwXWj51O6v7LyH6dIOLWFgKm8uvwzSKXeHrBKHfRve1YQq
 LXqNpb8gdw8v07Aj3g3JHNF1fHkdPlb+Z3RG7P1/JV1hrLaXfEYZVV1azzV0/2LoT33uSa7VwLQ
 T41J/qy6zL/ynCU0THw==
X-Authority-Analysis: v=2.4 cv=E779Y6dl c=1 sm=1 tr=0 ts=6a217021 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=aMhaXRkMA95IrCOZcTgA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: q2WsK3DGKS-2kPfsHgQJG2hAIsAStKCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040121

Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
used on the Shikra CQM EVK board.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 909f3c188e75..a6d72ff63e57 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1005,6 +1005,7 @@ CONFIG_DRM_MXSFB=m
 CONFIG_DRM_IMX_LCDIF=m
 CONFIG_DRM_NOUVEAU=m
 CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
+CONFIG_DRM_PANEL_ILITEK_ILI7807S=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_HIMAX_HX8279=m
 CONFIG_DRM_PANEL_HIMAX_HX83112A=m

-- 
2.34.1

