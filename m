Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309032;
	b=qQH9BWVO97coK6qjKSaLy6CNxDRXOVWXqu6ApoXA+P5zNg8li5qP8bJ15v0uXTOfsNZW
	 BzRqLGj2YMNcbeTHHOiyDtLsdoeJQIPkMBlbjPBVzNg/raqRJhRw4qO+OPbJ+xvKaTtYz
	 kmLEATxtA8Ocp1cwOqPdihynpoit5P9w9SA66UPeHkVfRp9XHNqqqzCQui4EvBFCsC2nn
	 SU43diFZRszf4HcTzmn2Zry+xVBGxnmlSQZlB+vPcsuQHfdwYsNe7I9FmqLkbEKKCEVpC
	 DJOwsnKUH2NgL6WBsunvPBHzgYeH5my3d8Nk5s6SX/SfqlQ6CgGgQhUNuPMHgBZUFFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Kvbi14Ro2Jet/rtwBr/WGcCUE+sLT8/ztxkoluFqXzQ=;
	b=Injb2gHNLoKEoicKdwLd9DntCFs7moxIKYiiamyYeuG4/QKDHxEX5jFuGq9CM0nQN2i3
	 1d45CKSWUa7SXTMY3XSS8AJj5+LbUi6NHEveV5rZH+kPx4rVlHYJxyzJh//lpY8bye5zJ
	 +rHMlSIgzl/HuixGDrqs5yrDjLpQhgHypd+7Gl0a5IcWQ+f/rXoQiCoD46Iz2PVuSiV1c
	 L9GBhE/GkLjsKL8o+KAkIW4YorFTeQxfZgGMrl2z/rLUDpd/MXARWI2YZ2iBz1psr636R
	 2vaigkGPZe3inO3ft5uKzwOnto00ovqrRsAwkL88ZiIlK7+C0c/kXyJ8LTTvArUPW2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="juhMW/ei";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BshWsqIs;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1771D606A31A
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 21:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1771D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=juhMW/ei;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BshWsqIs
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TJkPIg775670
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 21:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Kvbi14Ro2Jet/rtwBr/WGcCUE+sLT8/ztxk
	oluFqXzQ=; b=juhMW/ei599lYu0rJJYdPUNl7t3bA3+SKsV6j+954pbIu9Kj8eo
	Ciq6ohXOGQyAPNBqf8lCxt/sacTHwRTKTNXkZNYYxoLNqGU2wXydcw5IfxE5okHQ
	i0TPywtx/1Xb68BcgkEK5yA2AI8qMzmx3aumAVh3Z4wkXXMP+rGEg/KRsidyTFft
	Fcf6UooKpooD7wFPR0cEkiJSd6y+Tpgk+1c4eIaCGIjQvtiHKrBTDCo90B6F+YqG
	UoolplzT5fO0tfB6L7v4GIwI+yMuu6X54xZvT22B6coCxhlq7x0INmtrxg9y9NB/
	gIQ54PYY1jalU8w/LKiZtcQlO0pu+2snuTA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmchhrc87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 21:23:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab2395f104so34409a91.2
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793309029; x=1793913829; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kvbi14Ro2Jet/rtwBr/WGcCUE+sLT8/ztxkoluFqXzQ=;
        b=BshWsqIsLdotbdIYbj34EirbVvim0hU6ZyFwIyVndolmVSy3zFJqH1U6OCli1dkJxl
         XH3V1OUAuCY+RPitDYgEgf9koVTy6kkTLTbJy555/3Xipk1MJThMnv6H1bUu9UC4Jv55
         sfNYVYC81dJkqA9xt7mjoLe1qiGHtwdmWLJfffRpxbFc0AS7JOpwfMqrAFTDLESIanOu
         Fymmc3RC9Q+ygpkylJ0/dMJI8UuB0oxPWgnefvC9fuuRHzxFwgHhk8ieIYmGsIKraJCx
         PzMxl6LDin+Tr0gCurdBChtQX3zB4Ql1KSsqsUQM5dJJ/1YIAcEiah6RgmA3X3GzyJoM
         +bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309029; x=1793913829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kvbi14Ro2Jet/rtwBr/WGcCUE+sLT8/ztxkoluFqXzQ=;
        b=GiD65h3lgAiqWmWiM74LnkV7js2ZYKj8niLwwRp35Sn+mT+Q0aIwOKMMUma0UMB1V/
         35gQ/dyxbd0OmuZuzMKCqgOArm0CgLrcz9Bs7N/tkVlZ0CUDqjxlbXopCGyJL9VQYnc3
         LlLV3uAFOcmbBI9XCkv6LJng0lapDS/dGkCetnTXd6iQPeVPNyOEXqB6/QLukdmTKg4x
         CumIvok7hfT74xhyUAssZeDHTBuOT7Nt33nDd/ctxPaNFR5wVo6JjBjew6rkfQedaWr+
         l5qn9T8ELGF6nB7tq3MUl5AjWnCI4m2wjMYqSNqWVGqL5fm+aqYCvYY/VisV/O9zL1ql
         JgwQ==
X-Gm-Message-State: AFq9FYJt1ZXq+3HprQtM763B0+tFgwDBfmuJk6gWojkzEeIxiziWM1O6
	6GKSmtj1lzybS30HO/oj578bGWLEovpf0n0Hc3G7zj8W14fnWB/hg77fQt1zM4o2RNyWIAaYZly
	gOZ4AS2liES+UODV3C3j0c3+SQBeSKbKLnGaN2zGhwbE/kB2+4LQiip/AdKCvTi8lpQ==
X-Gm-Gg: AYBFou1W6rvcAryIEHHZDuDh74wY92Gpe30mtCdETmmrwIIs4iWc1Mnu+TDlQvobE+E
	5MeKDvhs/rIvM2Hf3L0lFSt6NG/DlKREol49utqQwuNmVYS1drBWZtBwKR/4UVUnDlrG7UH2kMO
	h4YI1yV74ZgMJAOEea7HS89GB5I0wqY+QYm9q42xxGzGJ7r45YAKfznNDtVFnYP7D0U0UGJjvBg
	Eh9a5U4EI67NHWDXSBgyrgNq70WghtvLYsslqvz9hEeRWvgb/rVFo9WVPJYUCPt+1p4B0vbttT5
	xgaRK3dxJyHOkdru48oA+FTBPplPbXoUrqikNbIdmh7orKoYM00QR+tfXAYXwqF/wXmnOSKnWrj
	DmfDL00cB/iTvKnUoyRrke0MuaezNGUStqyA2p4Sxjj69tDOGYTO1i1fENPz6EKG+pDuI83sjG3
	9h6hIMR83HKl1Bxq/yeA3anw==
X-Received: by 2002:a17:90b:3d4e:b0:3ad:1841:6f8b with SMTP id 98e67ed59e1d1-3ae8981e41fmr175457a91.37.1793309028752;
        Thu, 29 Oct 2026 14:23:48 -0700 (PDT)
X-Received: by 2002:a17:90b:3d4e:b0:3ad:1841:6f8b with SMTP id 98e67ed59e1d1-3ae8981e41fmr175434a91.37.1793309028255;
        Thu, 29 Oct 2026 14:23:48 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net. [67.168.198.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e99b267sm5559785a91.14.2026.10.29.14.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:23:47 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: iommu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 0/2] iommu/qcom+msm: Use identity domain for display/GPU
Date: Thu, 29 Oct 2026 14:23:41 -0700
Message-ID: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfX1GI6kCE7JT0L
 yG6mxhtCTIBT2HA6ObQSzJOVV0ZrcqnGkCzu9HWmo+yV5N6faN+dQX5WwYo+VprZinWwyia0PT7
 u/dy/pcqp9NRcg99WsTMyViu2otJTyo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfXyy06bMsP+I2J
 rrLlWqWFc+o6Qn/U4iDdluiJ/JZ90aNOBkUbNCylNFeculLWQBuUrDVpjmTx5TCogVVHdz0lH65
 mifDfiUBlLTX4c1MfKRMYTYb4xuzQfYdzTz3jbJ/IcbHPM41g3eXfiZCuVwxqJz+HIrjuj/DODd
 ml5sglMBBQxOHfIhdCbwXxzBKygoyBpCv5uJ88KcA7oBaz8//9RZER7+P02weRnQ3CAb3KB4eXe
 abXcZEvqRSKu0Q+Amsj1HZa/XJ8ygGuVRwVVfybkWhXGKjgNi+obZzLM8C8n51XT+z+sO/YU0Vh
 HXwslTGhGQbKmgEk7GXiZ2blp5+owKBaIs4YKzJU8O8z9F71cG/T0XDFzcIx35YCF7Via/9Y9tO
 NjgztRs5lPUHYK1fPU+sapBVrQeuoJk+U/ViFweiQ8MQl1c9UUpr8RV/lGo6e5YYCmmRWsPQnwS
 F6VzW0/50TnSjUQDjwQ==
X-Proofpoint-ORIG-GUID: xILWeCTsFoOeUImZ0EZI40WG8G34ts62
X-Authority-Analysis: v=2.4 cv=ffc4WEQF c=1 sm=1 tr=0 ts=6ae3b965 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=e5mUnYsNAAAA:8
 a=wtkIETcKxqgH55doulAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: xILWeCTsFoOeUImZ0EZI40WG8G34ts62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290084

Similar to what is already done in arm-smmu-qcom, match display and GPU
compatible strings to pick identity domain type for them.

So far, we have an "evil twin" domain kicking around after drm/msm
attaches it's own domain.  Until now, that has been relatively harmless.
But it becomes a problem with [1] when we start using sg_dma_len()/
sg_dma_address() for setting up mappings.  Which is required to avoid
problems with CONFIG_DMABUF_DEBUG (dma_buf_wrap_sg_table()).

The first patch is at least compile tested.. msm_iommu seems to be
armv7-only.

If there are devices with bootloader splash, we may also need some
work on qcom_iommu_identity_attach() and/or msm_iommu_identity_attach()
to put the context bank into bypass instead of disabling it?  Not sure,
but that is probably going to require someone with such hardware at
hand.

[1] https://patchwork.freedesktop.org/series/175619/

Rob Clark (2):
  iommu/qcom: Use identity domain for GPU and display
  iommu/msm: Use identity domain for GPU and display

 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 ++++++++++++++++++
 drivers/iommu/msm_iommu.c               | 16 ++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.56.0

