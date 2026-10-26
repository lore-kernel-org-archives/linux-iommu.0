Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995873;
	b=duUcM7YaawT8MeLC6mOS15wPil9iByqpwEhtulkt2irh+AGAmXtFwNykQhlcHPCEn1SD
	 JS8XofMtUJaGHI5wtF3F/i6Nkn72YE6Aa/QGYu2GGt0dQFzZXk7PsHkaHyyP9rf4pe20J
	 ARJc/z8/7LAKK7H5vXgZr6dprfjvTvTw0E9+YUD11ErHVJwhAx1IDJlW7vOlTWCFH7SvM
	 vgqGAnWjKScMg7U+Wlf5XpWpqWSsTqO2KXEk0eCwfGux9kCcbmIiFjL2apuUOIT6DkD/4
	 eomjBGcbzH4hBs6/Zsb79AauZtODjQh4rJTcZL3fWkxYKox1DWpcm1plKOMD3G/4u+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995873;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aEFp7w2tgG6bRDJtDTShC/IAhrO3WLDIL2BdyzZpv7U=;
	b=LUNMRVHxXByxsjjDn/qWzp50RMklhFgnpS+hrFFTs5+xlCxb9T8dHOcbcrLp168na2my
	 Pu1oBjE/A/hurabV0wIsxKab/69KhuAhGs+x7M7WkjERsmUonqwy4Cgn0esgWjHTtKGOQ
	 RHAm8z2rMrGPonmw02RZkrVS+q1fJeJLmEBEwxBYnRQ3HdaQ7ka58xXo5gKFhy6IEFrWn
	 CcGV9xClCOFIdw8MkMhwxqrQR49EAppl66erv+2G2gBrJOtDxxR5cMj0LtUCVcEmZH5ik
	 JH9H9Hlck0RXvaG784dfNve4ne/sL1RrNlul85/WSrI+WiKUy18j963SoHYnWHhZc5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kl3hjtqH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JIkuFavg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E216606A32D
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E216606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kl3hjtqH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JIkuFavg
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b0GX2206169
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aEFp7w2tgG6bRDJtDTShC/IAhrO3WLDIL2BdyzZpv7U=; b=Kl3hjtqHrbNM6nOj
	xuJncX+4ETr1rcO1gtaxpuptG70g6UsCA5K/Ynn7toA8YQqwLAy/rYiM47629XK5
	FrxT9GKcl4jIDO3QYrJjHf0rmW7/TBkxY8LNm27cc/2M+kLf9xUaMPfpZCKaksQ8
	kTGZOmq+fzP3GAf+oxwvMKa3fk4Iz2b83SLTGaxF/IgvbsijG8Pkz3eMB6OdnTfF
	BWFoH18dsmGDfLW6vSgthw1Cqs0lIw2PJ5Dgnr4AokMjLycCaSVw/rBAxdWIF8dt
	pp++/eEl7NDUU9zanBQvzCzqu4fe6xQ59iD9j83N7ZiGe6b9kjdz2eCctfkNST90
	iKJsPw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmrun1y4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:24:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d02df2bf09so19870345ad.0
        for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995871; x=1793600671; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aEFp7w2tgG6bRDJtDTShC/IAhrO3WLDIL2BdyzZpv7U=;
        b=JIkuFavgVfMCxtp2MWQBtQWJYgQXUXF4dqTImeJGgqhEkbB1WvQGPg56D3rlIg8u94
         9gVW9NVWIcb912JWuQyxi+L6kVdoOZDkkr3jEK/Jjk3EaJOH40ufX3+n8e/CJnE1Oxny
         pIXH0UWKDwowoGkTdOqwNfwF5rD1Qqf8G1MPdfprUpFFu5yesvAe7qwKwpYRC7XXDcm3
         A4ig6/hrFD4hHv9on8JQS4AxqTkXv6xeC0H3oUxMrSE0Us5RI6S/fDkfpPzWEe7N9fjE
         WuLVTv8uC3ZwQmmIIE+i5U4+czevJ19GaQTFiCA8Fa/TzdOjzetQZS8wm0o9VcmyoIFn
         asBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995871; x=1793600671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aEFp7w2tgG6bRDJtDTShC/IAhrO3WLDIL2BdyzZpv7U=;
        b=S5jvv3kQyHfHcOffR7ubRr3jlNcuTQ59jdJCIpiEn8scWpuSVHNB9RYYE7mckeaqgQ
         /BIikq5IYekGs2wKpaTAunwLlwrUWGOvBRkREVwDm1WcKW3BczJ5lKkDAuz56rc6SUv7
         ckVwtRiQ8UguevR4mu4qDjU7OiJYA1IO1bGJlHOWhJ8EP92YjdVWA0qg/a7OcBL5nsXy
         NkdWYyLTE9zpjkDcjawYKr4zk/G0HR8ogDKo9P6x1ayQbfYai+rNOmkOW7TVoXR768eP
         X+7890Qe6xhtTGgIB6eF3+SVGYRvY6PsUdMigXoYwZ77ZgI+stwoE6OuLTG+P69HzyVb
         HOEg==
X-Forwarded-Encrypted: i=1; AKwUvByzi2Vcl54iurXWhY6pfjogooEB3aGbKRyK9oQr06H4GxfERa/zHfuF+P5+sOkNw1dYoMTZzw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK6Q3ZWy0GihR0z62xAU+sE4T9DrqRc641PiY7iV0CqcSRIuCZ3
	7kxHxWlfxG9qIW++Dol31EwrNC+2IUfl3UzPR6WAyAnZssmpelX3aXgwyhNEH6s/kd3C/NLzp40
	0wL4DN4PZxw0xGdm27JZJ5OF5KTDQ8HJ0XJjDtPGh2IM1udHA121shF4wmw==
X-Gm-Gg: AYBFou0NWjqteSbs32BwJaovoVO1CWnUnoICKlHiYt3EzBZvN+5MkRWn0g+9Zz6ZECP
	wHtvqHsImYqHNy+DUkx8ET+LL0YlJ5rcSMNZ6WnkIsCfBEKkf35JLQCYrvMKF5C4F/ri+qH1VLC
	agFhcxjUohTbNy/xG4G6kDKGCmmwc7daithEF4yC4IYTN6KAz8dwO+FUtS9kYhaIXn9gRClr7oX
	VMubtiFUGEpOWDgq4XRUDQzsAUmPx0ZvKnBh/lVzqypYGAufrTQBDdAouXummcuK3IZsPFxBMva
	uwh98DKiYbUzvNah5peX8PDkd6fFj/NNiO0qe4gNnp+fc6OPEG17DxpNuTPH8HE1YTkCutLlF2W
	/WSsq8RO7fvEyd0Rz0JyK4MklA8svNTH1yQ==
X-Received: by 2002:a17:903:3c30:b0:2e9:821a:5527 with SMTP id d9443c01a7336-2ea9c6c73a1mr46780355ad.12.1792995870987;
        Sun, 25 Oct 2026 23:24:30 -0700 (PDT)
X-Received: by 2002:a17:903:3c30:b0:2e9:821a:5527 with SMTP id d9443c01a7336-2ea9c6c73a1mr46780015ad.12.1792995870524;
        Sun, 25 Oct 2026 23:24:30 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:24:30 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:26 +0530
Subject: [PATCH v2 16/23] drm/msm/dcp: Integrate the DSI bridge with KMS
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-16-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
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
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
        virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=4407;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=YkElIL2VP9q3UDs86ECzwDFEF/OyzmGpxHXTXDTkMBY=;
 b=dK6ojiOmJgJpI/PfAGPWySwWrv1PqCpsjGAfv4a+OAjHAZ2np/K6tzX6Lr5Vz7Q11ykgxlBBr
 N1hOZCgwbYoDaTZ7PMa47CbVwaPr/4ZRRrA8jHmArpW87PZxJe5Cdu/
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX/5DBsrnif8yp
 GpV9ZEXQNi3gs3U4iiXr/JzHGAzov4/LUq0DEuVVlcJoNu3ToAYRSo0YcK+4EpuAujy+ZQx+Uh1
 gHCK99O8KKiNNOuI1r+Ku1K0mnzliUxNhy1kLO3SNvX4MxSpW4dakJlPLx+D+v5w920WnlwlCvJ
 cW/18zgCfAwr5YDHwDVZQislI65UxlKYur0HWNB4uLjhssxVyaVoCfJpVB8NBW++qNBzvaYaFz6
 w5CXEEbXZeyifJNJGjANSlZ9H+tWj1aQ25NNqtcQpIS9ELHwO4jRCXX44R01LktBn8a6uabzPG+
 52ZBf8vYR3pkC9baNjDU+eYfAVi9y82ZlHcYdrqcpOqpZGthBTuT53xWPGYgXnnWv7mPT4xOw8g
 PyCHqUTMTMSNM+HbCZXZG1NlhIox9eiD4G0LPC/YKZ4ryrhmo1Yzj9mq4YvOknz2OqmTWtnSXaX
 wmlPxRUhy09ENaejMAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX1QfVEWEFl6yR
 S7UkTMvcibWHP3s2PNmcW6Si7cOMg1PKzHY5xk9oaaKyXo8MyqHtz3fkFvoZ2wze/WuQGY7YZT8
 0aHobVrYJwzOt5W1FvzcRgvppvRu9Ks=
X-Proofpoint-ORIG-GUID: vOgfaYPZhYQZ80eRRTf5gUvDFAS34MSL
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adef220 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vhVORTM7vdiWvPRSmu0A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: vOgfaYPZhYQZ80eRRTf5gUvDFAS34MSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Connect the DCP DSI host and panel bridge to the DCP KMS
pipeline. Without bridge integration, DRM cannot create display
sessions, attach connectors, or run the bridge enable and disable
sequence for atomic commits.

Set up and tear down the bridge and CRTC relationship, pass panel
configuration through KMS, and connect bridge-backed display operations
to the DCP HFI commands.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dcp/dcp_crtc.c    | 14 ++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c | 40 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h |  2 ++
 3 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
index ec4f74c2920f..173a07df71c5 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_crtc.c
+++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
@@ -147,6 +147,12 @@ static void dcp_crtc_atomic_begin(struct drm_crtc *crtc,
 		return;
 	}
 
+	ret = dcp_dpu_kms_prepare_crtc_session(dcp_kms, crtc);
+	if (ret) {
+		cstate->hfi_error = ret;
+		return;
+	}
+
 	if (!dcp_crtc_get_session(crtc, &session_id)) {
 		cstate->hfi_error = -ENODEV;
 		return;
@@ -559,6 +565,7 @@ static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
 	const struct drm_plane_state *pstate;
 	u32 max_width, max_height;
 	u32 mixer_count;
+	bool needs_dirtyfb;
 	int num_planes = 0;
 	int ret;
 
@@ -569,6 +576,8 @@ static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
 	if (!crtc_state->enable || !crtc_state->active)
 		return 0;
 
+	needs_dirtyfb = dcp_dpu_kms_needs_dirtyfb(dcp_kms, crtc);
+
 	mixer_count = cstate->topology_mixer_count;
 	if (mixer_count < 1 || mixer_count > DCP_MAX_MIXERS) {
 		drm_err(crtc->dev,
@@ -598,8 +607,13 @@ static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
 
 	/* Limit visible planes to the firmware blend-stage count. */
 	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
+		struct dcp_plane_state *dcp_pstate;
+
 		if (!pstate || !pstate->visible)
 			continue;
+
+		dcp_pstate = to_dcp_plane_state((struct drm_plane_state *)pstate);
+		dcp_pstate->needs_dirtyfb = needs_dirtyfb;
 		num_planes++;
 	}
 
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
index 44b1c2200aee..61a4d8565359 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
@@ -7,6 +7,27 @@
 #include <drm/drm_crtc.h>
 
 #include "dcp_dpu_kms.h"
+#include "dcp_dsi_bridge.h"
+
+int dcp_dpu_kms_prepare_crtc_session(struct dcp_dpu_kms *dcp_kms,
+				     struct drm_crtc *crtc)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
+		struct dcp_dsi_bridge *bridge = dcp_kms->dsi_bridge[i];
+
+		if (!bridge)
+			continue;
+		if (dcp_dpu_kms_get_crtc(dcp_kms, bridge->fw_display_id) != crtc)
+			continue;
+
+		return dcp_dsi_bridge_prepare_session(bridge,
+						      &crtc->state->adjusted_mode);
+	}
+
+	return -ENODEV;
+}
 
 struct drm_crtc *dcp_dpu_kms_get_crtc(struct dcp_dpu_kms *dcp_kms,
 				      u32 display_id)
@@ -19,3 +40,22 @@ struct drm_crtc *dcp_dpu_kms_get_crtc(struct dcp_dpu_kms *dcp_kms,
 
 	return NULL;
 }
+
+bool dcp_dpu_kms_needs_dirtyfb(struct dcp_dpu_kms *dcp_kms,
+			       struct drm_crtc *crtc)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
+		struct dcp_dsi_bridge *bridge = dcp_kms->dsi_bridge[i];
+
+		if (!bridge ||
+		    dcp_dpu_kms_get_crtc(dcp_kms, bridge->fw_display_id) != crtc)
+			continue;
+
+		return bridge->dsi_device &&
+			!(bridge->dsi_device->mode_flags & MIPI_DSI_MODE_VIDEO);
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
index f8010fc5d32f..333567a78ad7 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
@@ -44,6 +44,8 @@ struct dcp_dpu_kms {
 #define to_dcp_dpu_kms(x) container_of(x, struct dcp_dpu_kms, base)
 struct drm_crtc *dcp_dpu_kms_get_crtc(struct dcp_dpu_kms *dcp_kms,
 				      u32 display_id);
+bool dcp_dpu_kms_needs_dirtyfb(struct dcp_dpu_kms *dcp_kms,
+			       struct drm_crtc *crtc);
 int dcp_dpu_kms_prepare_crtc_session(struct dcp_dpu_kms *dcp_kms,
 				     struct drm_crtc *crtc);
 

-- 
2.43.0

