Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C924AB1A5
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050048; cv=none; b=hj20mN7SCR3VaBpZfDXI7z41dCPAUUMx1+JRp1OuQCNrBmKngKvhhwZ4u9y4sNOY2aaH4LH8DxjICE1RegrCiT7l1H5Y/MH6NxLqV7/VnkgubVhfuP90cAjjP99wzdxxFHioCvMs3T/AqQm2jM2JGW47LA5Gw3XakFa0juhxwaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050048; c=relaxed/simple;
	bh=pTPCAX8/CsBLoyOLjrC5Lj6V4R1as0wD8+LPwQqJmJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMrCVr8boyby5czmYHlP6fwB5BsY44nd5IUKq2XIn1Zr1rfdy1kXlrVT1HqdfIVZPqour/Z6tK+OhjGCcA7CUDjJbkrpJAtUhBIYo9KCvzB1VxdnhQE8Y6ye39VEGJ/VqiHDzIvHY9iTzKfZWCcMXz/VqERLhbR0T5MivMHQZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SIdTD/9Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NaWyPF2A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SIdTD/9Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NaWyPF2A"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F3wbLk1889516
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 07:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vF+/3sIhapVNAvd6rUI9asvRG05C8hSNvhBnFb72r2M=; b=SIdTD/9Q1pJ7cRvT
	Ep5lZJ9TJoyJw65D5IM01kpMOplvmPeoPV+ixOSMXq6ROKKRAy6tpjON4a/BTQvh
	u2cnjPDWlEtH82VVQ1LHSmeYGj8yo8HJgZw5q5wSWMO1e/xNmmTbGQ/uZrG1Kqza
	VZFjusIq/Wzouc72g0bnJOApxNcMOJHRwQ83h0pdHv3Ud6MCjTupBxs164wMNfyp
	mg5aYtQmgOsfpmi2CY00Q+G8/hkvkaKqI/dT2VwNgEKup05JrbejAbp/LO61AJ6Q
	DtWAP9djkYOU6GyhQs5EIc8wT/KCK/85avZ7rzZEuSNAu1tuBH/DQ5YIo1a4KEKh
	O/ZLsQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda0snq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 07:40:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab2395f104so1130815a91.2
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 00:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792050042; x=1792654842; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vF+/3sIhapVNAvd6rUI9asvRG05C8hSNvhBnFb72r2M=;
        b=NaWyPF2AVnvtTn+Ir0ZJtPVqMOu4ZiJgryARzb4X/RrHxgBtKZsl+Gq8QrAI2i2NIa
         12SqjPmIemHt0ERIJmfFeRSlR4k134TOV1wBdw9LW3H3HoSDxdRqBWg8NihVezK9pcHl
         Q5otOhVxBeMtIt8p67NNiBydIfG9ebegL/MbHfu+N0I+QoMRIw1fYxN9bjPmJuGlcEtG
         2fjvMg3QLSnK5YRv6oTc3kieCJbrIAGVnpcw3kd1F5GnvfDglq7qKHdk4DBWG7w5Xxp/
         mGGrUqHAS42oirYsJ6GMzo/MZbu1lBbpqnsll0CPpVreqvgRCHon6AI0a0YHP7bPAmqm
         CTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050042; x=1792654842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vF+/3sIhapVNAvd6rUI9asvRG05C8hSNvhBnFb72r2M=;
        b=DVdDDHBDhfklEt/Q7WFS5rQxvrvfC2yC9Yyh/LxjGLNaPXRwS6ii4IpZEvakf7/HkL
         l6eivZjLmUzaBaydS28zdapLAw3oeoirqLNNn0kJMMUT6D9po7JvosHc2ej6zIsV11o7
         onRFw9rIO3lt2Ayj5OgTlOOG3qyZkcEWa1hPL51zrebMB8ajXubTjFSNIA4MvO42inrK
         fNiXwH61XkQQmTcsn2lxouYRdJMdPLRTW/3sbvjRB5SMW46G2XHk/6QViVgANJxTNWF2
         hU0l4CxVYT4UrDSFxMevSJvkxWzTU7c98Iz14Oyjdp6DKs5rDkXG1joClEQ0LHAGS9W5
         6wAg==
X-Forwarded-Encrypted: i=1; AKwUvBxaiSSPbctPkvhe+QHg7sI+5cCmgQsATgpzqLEQeTa904RKXkKQo6xkUoTcHBBR7igKzek2fA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIiBqXYBHktltmaba8b87Iadtnr1GGzKMPzQYUp/Bvq5nT6eXE8
	/ib9Iy96VX+Li1YjLRsQdSVLPO/wD+vn5Pb8OCal7ErRWrpibT6Rjyp/KxI89rshr/BiWDP7Ghn
	HuHFYU3PxqNwrBgoBDBX8tTDoJRl5b4Hdlk6M3GJDYGFVdCM1IWBfqCJybw==
X-Gm-Gg: AYBFou0u/pattxaKOJJcfqLeaVM/UstiliKuG24ubSDMZ+wolpp0i5v1lAV+JVL2sG2
	jkg4vikYkci+mCaz0ASdR3ElvA0sRjIVCQWDZMnkCNDowNAB0pX+Mp9NSCoSlfKxGliHSNabLWD
	NrJ7wPp0XGXcyYwHhqiNHZueg0dhPd5BJyGzemKccnr0YO6lFYn9yxiFKgb5OFvIeuMKu3LCaDR
	gcwDaUrh/sdIppWduC/Yb1qRKNTNLNUKVRhybhEw1DzZWNwHsMoUH3Yck5osoujErlg/KyGyhpf
	5A0Ozwd+8hJxJ/+6fxobXXVSh/GTf5j5jAMQufYT2eZWKzoQF6MA2vGSEuXlYG6BuhMTo5Wnq8Q
	xJmVz0eO/PtpTk8QpRAST0/bWVO2dawK+Cjs=
X-Received: by 2002:a17:90b:2d88:b0:3ab:e789:ce88 with SMTP id 98e67ed59e1d1-3abe789dfbbmr10015432a91.65.1792050041518;
        Thu, 15 Oct 2026 00:40:41 -0700 (PDT)
X-Received: by 2002:a17:90b:2d88:b0:3ab:e789:ce88 with SMTP id 98e67ed59e1d1-3abe789dfbbmr10015411a91.65.1792050041033;
        Thu, 15 Oct 2026 00:40:41 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e944c23f17sm14014825ad.27.2026.10.15.00.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:40:40 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:08:31 +0530
Subject: [PATCH 11/13] drm/msm: Support KMS backends without a display IRQ
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-jshekhar-drm-msm-dcp-v1-v1-11-48aad0fe4f72@oss.qualcomm.com>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792049920; l=1124;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=pTPCAX8/CsBLoyOLjrC5Lj6V4R1as0wD8+LPwQqJmJ0=;
 b=bpN+2azNrend/0/v4WZOz4wDoLmEO8sJ90IY/xsoZK4QTV78nMaroxlzAY8V/oq+gXHAmu18l
 9Tt1n5goJYjCSa0YqzJqvqdZna5CUksVpN7ANJ0NieJo5BBw41WGD38
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX0cZOHprO8gtC
 REwmCreyVPzU/YXgxFCvbey9OCC5VPE6N9pT+YxOqjPzXXTXBmGrMQRNSWvan/0DCzMxI1S3iMc
 qno1n4320jXpKQWEWWggizPJzPbyfDk=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad0837a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=g9RcmOnx5enkyd0xrYgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: phgfvmk4bzOwpQJSX3q5gVveKRjyAwru
X-Proofpoint-ORIG-GUID: phgfvmk4bzOwpQJSX3q5gVveKRjyAwru
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX4O3+V+jf4sBd
 BGkCmY7us4mxF7GAg42t5pAgO5QnYYwMtwEJVO0GezjSLivxEAwbeQSiYEzMPprtRb5dByb1AY0
 Oehm05uEU/gQvw0EY7vP7FgaytVZgUbUO3PtYiYxJjF10P9ZZVVaoQwGaWzjEQVfgeaI/oC0Ftg
 Fs0fCC8TZaeG5ecSEuOiH0Wb/DCRmEfBXWOKrBYOwu1bOxI+RQgXcTgcxwfKFRMMn9x0BD+g/yD
 o2SqMLFGvZ/xW6SNUx9xO5Wn2M/Q3PmKQ4MmkNUQogs45hTNpkiqVeJ/zvlim8cxupqfISDaGKs
 KOOezgHDhWTg1MWV8wmiPS1+LT8zs2EuXxFEBYGkrcrBX6JekBUuXlsLGTmY6L+LJE3qbm/CQWQ
 DNSUa7UaQUC4rGrTWxe/EOkubbGfuo4zQoEUQXPLapIGdAODi2UTte4D5y2Ejql5A65pXnljVXk
 cO3sVq58h/i/ECGVZaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150030

Some MSM KMS backends receive display events through firmware or
another transport and therefore have no host-visible display interrupt.
Rejecting such a backend during common KMS initialization prevents
it from using the MSM DRM framework.

Allow KMS backends to use IRQ_NOTCONNECTED. DCP receives VSYNC and
frame-scan completion as asynchronous HFI events over VirtIO; its IPCC
interrupt is reserved for power-notify acknowledgments. Existing
IRQ-backed KMS implementations retain their current request and
teardown flow.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Assisted-by: LLM
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

