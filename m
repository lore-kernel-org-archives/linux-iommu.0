Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F793A7D98
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498807; cv=none; b=M9LyExkAJkQ1kZgq6S8pACao4JgM0Xe0vNh+84H7lB11sdQwQ9sDWw1f8jagpd0gadW1KXkPzFRQlYyq8IchckkfvplkFtaUXO9U84OXrTuFMr7rZoM/NBmxlyCiDM0+lv7B4fP1JNWm7tNbmD1+m5D7pTYCEevQBEkA/Pi2Q54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498807; c=relaxed/simple;
	bh=SCs9KQKBtzRapnZIGqIOvP+xU2+TnEvlesLmeM6sxt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CtR8kF2au912f1J5NZVE/Oh/sj/tE4c/ULcEeVf5nYQ8zv5aKKmzcwiyUrkCrDUxMAymZM/c/ev8fsMT9ZvA+Y1/oQVfJTRYABfFDVPvyo9GvjoxE6BFX/He2qXwPKCwXr4gXe2Ql2F2L70mnc5EacwrPZj+27QmOSwfmjaQqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GGS0WfoC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I0cEPUov; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GGS0WfoC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I0cEPUov"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653CDmMi1200157
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 15:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y6UZz8IjVdVITbvOPHhdrUuJW0/kbNYyuOsWRAfVo8o=; b=GGS0WfoCZgeHzqnl
	hw8vxIT23xX19xU1PnDB2cO6B75LrHO87VXfv1DKd8XjSbhNH0kwKiBv1UoOeo3f
	ssrPtwoOOEBHX1PH+wVbAtGsS/0Xwho7H8jgZGQzE2nCWf3BnujxZOLELrwl+Nz1
	K40mw2BBnmDFTAndAZ4Djp4UpMEoxfDxUdWax/x0YQb8Ie4uxItBIBvY7q/iKMoe
	VFQxQVLAA2eTrOwe2ntQibVK6otdNWkUT+F9/LbvC5lHfmH/lsjfOrw9M+TYhEmp
	90pT85AWiTWdQT5odpQiRn4MvWhSEO+t1sLyr7zwKqaPuMt/X+9xpAu4jNHwtMXM
	W56/Tg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejckw2ma2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 15:00:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423f6247c6so4517182b3a.3
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780498804; x=1781103604; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6UZz8IjVdVITbvOPHhdrUuJW0/kbNYyuOsWRAfVo8o=;
        b=I0cEPUovkH7XYO6sD4XGvGashMp5dSo3w5hDHymPxwoufdDLfGYx31iRqE8qcaWKk/
         omd2EG55PD2SGvAv06kOh27tDpr1UHk99wDIyq3kKzd8sBt0Efgx8vAt4mnkYVPtwM2N
         3/6FmiU6uYpjfmUGsBQDNJrUKNC/xQ1ASPSoF97AzSM5mfRU2vnq4ycobfosQusMxoE9
         BVhAnGVq43FTYg3rjggCq7VDAkx+jb9TjHNsiqErvWrZbGT8sUWxwUGmmZ7/S33BrI8U
         eIi2jCUbKa/EpnZf4ZLj4rAwUBvtQWuBfmXlFn7E6I5gw8trLFH964UI28GAT6HNbOIl
         2FNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780498804; x=1781103604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y6UZz8IjVdVITbvOPHhdrUuJW0/kbNYyuOsWRAfVo8o=;
        b=QSGib+4TQ+/ftpdtnYHvTIecU51CF8rh1dYM+vBBR6GuyuBVzY4SN+Z1nruFygcdAo
         RYiyy8YXl0dNR9eYPU1Fa4gztKbkhcg20mb2mUd5Jc8+q8sUHQwFuZVtCWLhTrbicnxg
         oN7KU7riZTeRUwcG4KnMSNS8m1OMD55ViCRFvVhHHIH4EYGPIWcW6/1ze4ACKlDfsPmS
         jd8zMyulPV5n0XJW4cBM01ab5AM11vip50aDdilENydQFacY+f4wn/4QLNa89ZmrHN39
         4GbGDLrqA8sAmaybL97hCJFPeTt8SgPIwRjScTHBXS47NMZotSMpVUOUcqBp3c1vIsTl
         yhyA==
X-Forwarded-Encrypted: i=1; AFNElJ8FRCMLVGHMNM9o00p83D/MqbgHNg72nyZsSoVkGzn8qYaqL8LW+aQzT5BYW1OnHfe0xaUvEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YymVPFCxw8vFuCSQrckxWrLpPafABb1Vl0Hkh+bXEPkey8fOQYs
	Crlhykk2JNrK2KnDwve/VELTtFR05j4flzq5QAcj6pSWlg1wqynecsI3zMs2z8zfEv04HRCk+Nf
	249cilmi0OrTXkTcHxgDe50RORl7xxeYgIQFx2hZ5wbd10osm+j4k1NnRhQ==
X-Gm-Gg: Acq92OEma/MLffFYy9/bQl0hJs3hKEq9To6MSTKHWOfaF3q8Ry0f5McfN4pqke54Wq5
	LU27U0M1F2oCDnON++/556tJYkCoGhR3ldyR8FntVkNDHyj8Rw9P2XuhISWgtU+yuy314rSK9KE
	0BMdLwWQgiLyQv4OC76IkNGu9viNhPFYoyons6eBgdcKC7GZbpiILp4UlkzT01W7yX0pCeuIY/Y
	rwoKCMJ8urLCGuKRdlcRwuCjEYSgcuV32Ozjn7vzXlIy42OO5b7MJOTnZKHJBHEMxo8zfdcLast
	v3Vysv9e/yW9Tq9GbZrsLxvJs73b6QU1ljOdCKddmM0Sa1UsIKQipO+oGD5MLdKHUzg3o+vDRyc
	8SgC6VvcY22p9cK4HpKWiAmiwJ+6UHxeEFcR2ua7Cr5Zs9jkZPPpEpbnuSgs=
X-Received: by 2002:a05:6a00:3695:b0:842:48ae:1d43 with SMTP id d2e1a72fcca58-84284ee8c92mr3870649b3a.23.1780498804279;
        Wed, 03 Jun 2026 08:00:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:3695:b0:842:48ae:1d43 with SMTP id d2e1a72fcca58-84284ee8c92mr3870595b3a.23.1780498803819;
        Wed, 03 Jun 2026 08:00:03 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882170sm3747409b3a.30.2026.06.03.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:00:03 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 20:29:28 +0530
Subject: [PATCH 3/5] arm64: defconfig: Enable ILI7807S DSI panel driver
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-shikra-display-v1-3-aeac1b94faa7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780498770; l=708;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=SCs9KQKBtzRapnZIGqIOvP+xU2+TnEvlesLmeM6sxt0=;
 b=gUg6b8DX/BHqfCi1J5KoY5oWrnsM+HG3We+0qp76rEwPG/U5JUeiHQ71ZupKip7+1WYpddQA2
 CnY839GbgoyCf7ysCC7p9za7OOQ7Q8Ys5N6TLLl+YlfMU9KTqS7JKzv
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: CGTuGDx4fktklDIOhkvxL-jNSLIytBRW
X-Authority-Analysis: v=2.4 cv=edUNubEH c=1 sm=1 tr=0 ts=6a204175 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=aMhaXRkMA95IrCOZcTgA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0NCBTYWx0ZWRfX0xz+TVMklyz3
 jOB+O2CF2VzKoiSKV4RtciEYLjYvAoaVX96BbrLbC1jYrBv0F/KWUsu0ZU/xq2OpZab5NLeGVlW
 EkVdl2HsH87nyTKRgyg7zsNgkH4DElVttIIgDayMTi/X+9JhFW5TmDBUBrSHbbhpMhYGWS0qiMt
 uAOUKHToODacgGrXrnGiAeCOuY+Kv4kzVoJNS5cXlTxe7kSsM5Tmck1dk9V0++XbEI3v5Bvrej/
 gOFRvZLwASAdWQuX/VskGdITLTPoJ620vLUYJiVe0DzQL0YLqpfTItFSDxYMU4QdNe0EUCQ+WH/
 uGJ/S1wedOWoPfBEMZ6vSnPsExsLPZ4Apwt1m9GPrhbwQF6fooEQ6qfMDpNtfraTZRXMEx4Klj6
 Zo1EM7DD9WFH6MoKTeJMMY+fB5/0x9iCADL/9wzJHdNmcIjrFaGvEqTTlnZj+NmJpWamGN6DTfY
 ohAMmZz5tjo6btgQqzQ==
X-Proofpoint-GUID: CGTuGDx4fktklDIOhkvxL-jNSLIytBRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030144

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

