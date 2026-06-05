Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C23F7AAD
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654775; cv=none; b=DOfe5GQF2g86fu0qfo37PKpmn60ypsbvuC4gysvwAqFoAf5i+B6Ya03Ufqu+nkw7FvnvBFQomETaptPXITLb4pYUxJ/37PvAmmJS0HWOT99O5PhiPsUpBhw8rJ/UL1lg1H8rfDjVDVxB+VBUgHUkn+mCBigQl6GH31LnnT5giyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654775; c=relaxed/simple;
	bh=b3y/Ri3dF5pPUhVma/VEkqg6XXHRERmZ3NYb/UDlu8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qajvzNUKGbdw0PRODgBs/MC7xN63KONBUnVTCfoaMu9zHSEK+aYIpO/58zGXwrgMkOUzKjmrWckIs3t2xu8nuUkt+d9UNAogvCQfZgo4SGxLQTFts/P/AU7yDmwIWwzo209REZDytGKCgy/DMMNOpVGi+oKhmH+zqOnZfiy1EJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ICYn+N7m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fz46Urnj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ICYn+N7m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fz46Urnj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6556iqOA4048025
	for <iommu@lists.linux.dev>; Fri, 5 Jun 2026 10:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V5YZKQX2ZQaazK+ofLFvgf66g1BJkSfhht9kOwrmms0=; b=ICYn+N7myKnXgswH
	bQo/8lg0kxpiIsoldDGC/gCBvv93FgpFUDsZiqWxEW5IyZI9xSmOtpZ4LIwn+UzD
	YD86S2Oh7R5qvswSwd9/vySzJkbatdiifBNHWj+VyWU+lFp5rh3jyoNMKl6+k92b
	Bo0uVS2dDPj1s7IrkaKU8MNvuhBDlbW8mzjGJtXvhtS7RM4WeWUVey8f8JKF0BNo
	HVP4MSj79zvTpbS2ZAmCVQM5pBT35uE1OmPx17Fs6KQgzvNvzJjpyo6GBLIgAC1o
	jSy5twHm6Kq3/QkqqSVuBPtfaRUZdTns0JQnGWdoTxyagp5KZ3XwGtO+63ujvoM5
	gF/90w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eksf8gvcb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 10:19:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0532a6588so17533835ad.0
        for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780654772; x=1781259572; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5YZKQX2ZQaazK+ofLFvgf66g1BJkSfhht9kOwrmms0=;
        b=Fz46UrnjcuDSFF04J7p2b9jbb3hqlRly2WV3Avet02f/AsQxYhNC39cITavfm/6WE7
         vgTuabzPQGs/cAcjBMgqzH2bzpVNfAGa0RMWYhSTymYw6zmJGp2bcywCQHJwhxy0+59t
         Si3AxCCwcyg1RTgxCt5lyWw6g4/PDGr4ThTS4XG1bsP8RAWAKwxgBnVjVqfOli98N4RI
         Q1YiDS2GUH5jYTK7e5mnRp3VDn8wbkFhqyvqswqCoQm6D/FTuDYCe2h3GqRWVY0ujobu
         eK/fvzIGUJXqvmmw33n/NBWxpCSpuEMVF8TNf8MMHdk7h938qzFn4nqny7GtkzxwMfrl
         9FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780654772; x=1781259572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V5YZKQX2ZQaazK+ofLFvgf66g1BJkSfhht9kOwrmms0=;
        b=fVRzYUUETpZcDcxH94ldRlKdu+aFw7VMhDz6Aj36GvE+ijGf97O6m8EHggcqWt6w/c
         piCtvuoOi6q1FiqkRCDMJ23+7dAX3t7336Mr/I/AETP35sQgE6wdE3zoXslS4r5g62nM
         OjL8VbrSi9oYXrrnAuEp4P0Jbbo0B4wQSRJBuWKjLTBOZRcen0dY5AxcUKZlcQ9qCMan
         WKFe08zCTnKyHgB9huxsQNVF0uL6yaQu3zRc+jT4ZaK3xDlrZUATuot8Cv3UZdXvHtmm
         nYN1yruT7hajPhy+lkffZjfzrG00e8+Uj9S4O4Z1mvqwV/we/aHD/5kK097s9V6K25tR
         Lpgg==
X-Forwarded-Encrypted: i=1; AFNElJ+MpmtsUcY3d3aPykP0nNDP1WTHCEOIbt87a8JkPAcmGCAs1U/F6q0pZLuhlYWjnLGJj8up8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqAUqGLERJxgQlX/hY/X8DRVHS5ekjiUD1Ki64Pddp/31TK+wx
	N9QfG5F17OL+/yJ7V/1IYyvVm+g0+Q+W2ZbNL2gx2I+YDqDIFJ5FVPDbVT4e0fHcyvShwRU20+5
	lpaad4rUknwhvxPmKh8Qx4Tx6E/n5CSSBTT9/ZnI89v1uiTmp8Q19EYKryw==
X-Gm-Gg: Acq92OFH71g9z2cjo05GdcASmiKlQ/efHwuqDxh3CSGvKMRt9IvrrrKjQUBCxSdSyLP
	fJN3FKhr17trWT3ig4j3j9Z4yiO6qAh6EmyCNPe4rC1/qp/AbTj6spVGFiDB7Q3SXbBDckhvtyl
	G5E30MnmQ5SFkeJEX9SpxmlvG7DjsQt8ux9SCgRbAGxRAYQTIVAaFmn2klgULr5fCO9rqjcFVVd
	aIbQyM7TLvvI+CHcerDCMzf0pNiNZj0wbY//hA04NwNyK7qN878XqPVnRbSJb3A0swX6zezY0k0
	rKWNB7zhlL+9GXML1t1WQioheKf6H7aJjKfPqZM5jbh51hpKjslHPhPEPUzpjnXI6nQDaFVENcl
	0EN2m9K6026MGrVVR3zsb4PtaRgY3Az9ZjaHhdJNfVygeTg9nUsX0aJIHVIg=
X-Received: by 2002:a17:903:1b47:b0:2b2:5491:e32f with SMTP id d9443c01a7336-2c1e8344ef4mr31586215ad.16.1780654771923;
        Fri, 05 Jun 2026 03:19:31 -0700 (PDT)
X-Received: by 2002:a17:903:1b47:b0:2b2:5491:e32f with SMTP id d9443c01a7336-2c1e8344ef4mr31585795ad.16.1780654771441;
        Fri, 05 Jun 2026 03:19:31 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa0236sm89741445ad.33.2026.06.05.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 03:19:31 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 15:48:52 +0530
Subject: [PATCH v3 2/3] arm64: defconfig: Enable ILI7807S DSI panel driver
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-shikra-display-v3-2-9846ba5fe635@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780654747; l=775;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=b3y/Ri3dF5pPUhVma/VEkqg6XXHRERmZ3NYb/UDlu8k=;
 b=HHM3jKlqb5X26mBRFsD9fw5P1MjZUiGWDaoGxngkOUjuZ5dFNTpjD798rKw8GJ45ZtvnSvf0d
 90SFK/4Eb5ICuvRht1mtLZquyu5ms+kCPxWy6f9+XSOw5aD7GeN5o8L
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5OSBTYWx0ZWRfX6+RtbQmo2d7O
 HM0FVeMSfAHAGCUBMUNMZLE/+wlj/F9zDNtu8zuSsgyff1OqrQmLqN6MwpR5L7DfGi2J/adi9iw
 Tl8I6YvXz2BNq4q75bWD9hcSFZkThi5NiGEwpJe1tN71R6iu1neSG/io4trBgTC+CDQDjVSI5s7
 ahzlss1ZqZzFANYlRH6u2KZsQ7slPSV3fyXJuB+gXFss6FtXnjbCVEcGj8vWfUZwh8XKsIS67vm
 W69mCqaQL+Y32SAhjcNAYBtmmBmO5jhqUK6b/mqSYa3IDZIVWHZYk4TKST+MtJoAAtqnzH0bqRp
 wzVQKA1SfSnZCIsHNFw/P+dcPcKxJu788PtDr5emaHTyeyQTx/fUtscNhahaCx0V71G8nXFuCug
 K2mA8xro0usjWylF//vA97yIPW7HboX6fXBwLi36nXIASG5XOypC6qzJHUGHTJKwqrb4SSOqBLb
 oIdM5HlOKToEsdRtCjA==
X-Authority-Analysis: v=2.4 cv=K8sS2SWI c=1 sm=1 tr=0 ts=6a22a2b4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aMhaXRkMA95IrCOZcTgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: nf-u83PLc1_NwDexaHXWi3NOQoIEXnTx
X-Proofpoint-GUID: nf-u83PLc1_NwDexaHXWi3NOQoIEXnTx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050099

Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
used on the Shikra CQM EVK board.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

