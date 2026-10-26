Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995926;
	b=pD1UVZpVsWBxxxVVIC1ZMy84IaNXEQ3zM8CSjwYMi1v+GNooKqfSSMwooIaBAtmmXIr+
	 EesGj748jrxlNTH9DlEtSI7jky4loWae+prOybQG7Dp2Gp4uUqmcs+dbOyutt/MA25/RZ
	 nk9G+ExN+2YqYzyefDK1yVZJr5FKihtjWXL8P5U8VywCnEesVszl/vIECUtk0N3lifp1D
	 AcgRuvjpJfHtroEsq4KI9UBeeLD7ZMZN30YziKN8ewAzp/otDzAJ+U17Mv5wZ8qhHt80c
	 f7qQViku5nk0hOpUgQAPFPnGcH5t8FPI+ROroIoPvUO/LRSI1JmtCFo1Cv9p9Z2ZC0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995926;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ckUCQc8xGlckkBfhDS4Z+p+cNno0WawXomSygH6j/Zs=;
	b=wGETuEHSQOcAWEAChbtT9K/GvagokCoyYNd0VMenbQ5DpNRBVkr+rzzR8FCcnaj6gkua
	 4gsemUCnJmIG89NM09Nsc1a0PS1xV9fstaB7JAy1XlqoO4ixEDZqM72GXlGSZn0zmv5kb
	 G6tysQoNCLar+mLLfDW87tiZqLp2qtS3i01QsnJKVevr5LGCr9CfGtxGEmogngoFR/SXd
	 ozK0bFMXH7kdi30rECdNV7pAESOdCy59R712GK3VTCnNynTQhhXTbrBB2wYgprmI0bl+x
	 ZLCofvig5TMiHxmGLFFCbhVksq+P0/g+Czrpi1WmBlvi/PCxX4p27hB+AEPwgrI7v6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mdi22M0D;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jlDvUsx1;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36259606A31D
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36259606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mdi22M0D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jlDvUsx1
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b4t61340428
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ckUCQc8xGlckkBfhDS4Z+p+cNno0WawXomSygH6j/Zs=; b=Mdi22M0D0/nX8L8+
	EgIDzXe9Pn4OtwYwlygs/rQOkwznYAJuyISW+R0zkTb09HRmG2w7+CB+dkJ9x3QR
	wROQ2NmY8nxl7d1yrZMAVqeWJtn+OzG0IczwEdfpNHwmuBl4EE+59e38mNe1lefK
	7G4heGBp4GKNN6l0SWxwhsd8B6tw59IiSHlRmZJwi2ajbD0Akb8X0fn6z97ssX0z
	/TOvU/98EJugFgGmR2ANrhqnvA8CA/ikTJl44fYLf2376Z6U8u+/5Ffdx/aQj1RH
	t6H72W7/4ug8+6iR81IVbR/hg9yJ/+ZD4skdctIaqJqMX9rPHhQssTIQZ59oT6XI
	YIo3KQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9vwkq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:25:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3adcb81f487so4449022a91.3
        for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995925; x=1793600725; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ckUCQc8xGlckkBfhDS4Z+p+cNno0WawXomSygH6j/Zs=;
        b=jlDvUsx1nZW2W36XYaVdWysz5uigqoUlJZLQATYWlq+JdX5Cj8VCv1ykLZVUQEsDl9
         HTXRmEddAx9CIm2alndnPNC0H9d62hrlLoaLcGg1no/RbpVqzRAuckcNk5XpLqnlpaU/
         EGIDAM3dT9AFTM2SlQlr7pR0HTVqWGtGUnHAwb7gM3/iOJxxm3XKGzjMt4aXWJlpco1f
         Wbi7PacVhdF4azJHxdYwu6K07oZtf6AP0H5e2hr6pav4nJe+gUKumyHCi6UhcZovFOf1
         6oCk2Kym2tTMOzU4QgexY04VUDD8/WqWRahyzXaMwc4uZc3F+ugJiNZg3wr7GRkR9Hud
         xfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995925; x=1793600725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckUCQc8xGlckkBfhDS4Z+p+cNno0WawXomSygH6j/Zs=;
        b=23gFXpulo8paVo4s5xoG3WEswOjhoKRexiJMdeZXUJvCQ0lSpSqySHkyPFnCyBxqd0
         Qdnp6it0mM08Eoj+hKc59QxbDXCUm9aGnoko8NDS9aALCW7HlEm1IagwmbFx2Ms2zbh8
         eUpC7eSBZYdmmRYAksvBDi1/W/06nc3L0jhV6f0t/O5Tl+p9IOa9HOpNKdIvQ9T+L22s
         a1zDkRsl03rmseyJnjGzj1NN/kj9oF1HvDct9vceVR41z0tt50Vs+Fu2zcKeGq93kSDi
         kht0GIbcIfsQC1l0+mWBxcj4hGyxGP1o/+hj7sVV0DNP8sDc3kSpheVAcH3JHChIrxR+
         TqGA==
X-Forwarded-Encrypted: i=1; AKwUvBy8gqI5NzDgtSIRzzwSLh6ljx6ziykuBCnTfbMfwuhXcUURHCAFUdBiB2mlbrmmk+eF7uY7aA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLcGOEV/p8t2roE2P+3jJbcngLpPSDvV9fCbSVs3oul5fvN0HYG
	LH1jH8WGezuAYZNEm0UoGYEjPvz4C3ykFiglUzo+eGvO9VzIdiy2yto8purqER7CEUBS8oE64rv
	l1ueD8kDk8qrbAEtVCRfcZiNy6ryKD+8S1rwJry97XzxkFF3Qt8YYaRrE7Q==
X-Gm-Gg: AYBFou1S2/SSFEnzhZlzmpuk+zGL25low74Zw5Mn5mtosPLspEJPd08kwkrhpNojplN
	ygwBMMT4/PoPkK8ErcN3BPtL1xStrcrQ1koN4JDPoHNLODF70mlv1YFZMUyKGbLlmIHfg5s8ckw
	VZwfHA1wfb/smEjzic6f92yh6Yna4QRnbXKYegYORlEC/MDlOlKwsCPCMJFT+BUhJkQXHxVD+ox
	Gn3DhhOPMjqSw4w3RnwqwMM6lgcW/hjKus6B1RsV6pnQVs+Mf9jRguTpU4EQvTG6PGjq1/+UFID
	Ge6w6F3790a6rPod7lBz7PCl2NDhgCacLeRoNo4f5uRvm3V52jGxpCtSlheWBleclf6fDLDSNvk
	3jDN2HATtTG5kdvYEHzG4FmH5eb0ABJ+VQw==
X-Received: by 2002:a17:90b:4ac5:b0:3ab:1e1c:837f with SMTP id 98e67ed59e1d1-3adeaf9620emr4744318a91.47.1792995924560;
        Sun, 25 Oct 2026 23:25:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac5:b0:3ab:1e1c:837f with SMTP id 98e67ed59e1d1-3adeaf9620emr4744280a91.47.1792995924114;
        Sun, 25 Oct 2026 23:25:24 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:25:23 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:31 +0530
Subject: [PATCH v2 21/23] drm/msm: Support KMS backends without a display
 IRQ
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-21-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=1124;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=DKmn9i1vJXXvP4IBsacfVZJPAx62TejKYArKw6N1S7c=;
 b=vcNZ0ngyibDuHfRXl+gMTdO0b/EpAD7rv0lv4FUaHdf/+mqY8ImRpBvwiZcSIeoQwYeo9vdXJ
 yc8Y5UbPo6uDgvAYRMfqwFRHOii6CxjBVS2R+enurNuUEuwobPHtCor
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: KHROeNep1H86JQGjk9uxBaHNXM4Pek0D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX14l8rgw4ZIFv
 dwGenDhY4PoS0euMFikRYzRM8Cx6U0y0m1Xv5hJ2fEK6O7u5kL0z6CXRJxVUczlU4n1y9AQGFjP
 3hNcn8IEEcrETfN6g4Pre59Yj+Lz2Ew+78xGG5/P0PLh2zEDFa3maEYS2vo6xIGNwwDd1e8/YZG
 IXQ0n6HMNkqc9pOt5PXiRAtSEFWG7+eL/FynSZPvK+eHh+Bqd972UPTcCy3CpNEpZS83M6z7/hf
 KMgAXSmyGUab569mWrcJ0aW2p5PITE69pt8Ks5jb9zk6faeJJJU2ImDEZj8ME+ZrXC4n3jeQK9J
 D4iQg6wQ+f/+2YPtIZW/WrL5mggEPnW0npsL0T9fGybD3UqyF43UjN/6QWLbChFXORkfqJdGEqF
 I3+co/MAiCOXAdxKNmqptDXxUCvFY7bGm5rrrZTv11gm2s/1w9jatIviF86HHJj/cYa9vugQ6eF
 V6kzwgi8zhSKzugEsRQ==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6adef255 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=g9RcmOnx5enkyd0xrYgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: KHROeNep1H86JQGjk9uxBaHNXM4Pek0D
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXwjVFRcbY+PAp
 BXBGl0vil+MItJOyE7HOrXlSMkj1BSi24K2LsqsvraZUU0/igXOnfNrNzgkhapSYoKay+qVtArB
 nxVQiI0T3mdpqFPXwBGFBPn9wbvM/m8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Some MSM KMS backends receive display events through firmware or
another transport and therefore have no host-visible display interrupt.
Rejecting such a backend during common KMS initialization prevents
it from using the MSM DRM framework.

Allow KMS backends to use IRQ_NOTCONNECTED. DCP receives VSYNC and
frame-scan completion as asynchronous HFI events over VirtIO; its IPCC
interrupt is reserved for power-notify acknowledgments. Existing
IRQ-backed KMS implementations retain their current request and
teardown flow.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..1870a7008ead 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -72,7 +72,7 @@ static int msm_irq_install(struct drm_device *dev, unsigned int irq)
 	int ret;
 
 	if (irq == IRQ_NOTCONNECTED)
-		return -ENOTCONN;
+		return 0;
 
 	msm_irq_preinstall(dev);
 

-- 
2.43.0

