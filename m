Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E22C0F91
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951102; cv=none; b=CiKaoJ74CFhR3Liq+2vGofLsZEZecDXTyprnZSn6yuxmVYpQ1TitFigzZWQpYYDVGYqrO2L3U97T3PuATTLowq9WHYX+cWazmewNiyvuDVuMtwcfrPvgTFb7dJ5jihUl84I8TonPHKh34ZJ5yr+Bd1vbWyjqJggqQrqPDcrjSEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951102; c=relaxed/simple;
	bh=ebFEmvXGGkqJKD9mFiIVA1LtU6HQ5Bywf5jEMGrP3G0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pcOGCyUAPPFabJTCdxFxmeaA0toEAB7/wtlAxYEYu5CdO1GqFjxF2Q9uPq3aDdhyT8hwhjV++SU/NTbCMWCzBuBHfFZgkOqrF8ec9jSHLCgy47wnnt8Bve+qQGrS0YmkRXeZF7LCEKLjLVWvS64Xy4TBJgfsBtGoHSRGhL4KJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gg7QXMgw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PhUEo4Wh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gg7QXMgw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PhUEo4Wh"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8tqZZ028765
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m8HVxJ0pTOUMaGM5sF22jVvxmxUgeEH0LTk097GA07s=; b=gg7QXMgwOV1shweU
	RcerV4o2vU+G0PAZKT37xgsx1XatL3FYPGu/gX41xZUkofpC9P0GYLlein6D+KDw
	uEghegjDPPw9vINbXnFQeKoT9F17MvLu2/PkYcA71HBO2y/0GGBcZ6tgAn3dSLru
	dKlItWKwsvh3dGq3UtzPScZw3oVG9MgF6ri4t+TmdbArx7Qv9sCzkAaB359X6DEq
	wcDHWDhKNehWssmONfMoxmcFpB5Xcym2LPhv0DUfTnDBaeEmZ2bV8MmubF6AyKdg
	+qvh5YssFPbg0mGgpQ0d+dbA2NB26kTqNX5ib9SLZLE05tZ6nnh2tUvgXvkA4tU5
	AbV+UA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqdjm1qx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:31:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b4530a90fdso132370245ad.1
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776951098; x=1777555898; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8HVxJ0pTOUMaGM5sF22jVvxmxUgeEH0LTk097GA07s=;
        b=PhUEo4Wh8IlBpaJRPqLLUYUTtKSscaDQDIGdnVu/ZMxwBXB2tJVDt7EEhEG1yuymiz
         lh3eAauKWKcszwz7PQY29DEN/r+iiXsor3RrGWkt16w3FtcxhHW2JGL9l+cBovnzju+0
         +zVtIbwuPSsVnc7d7yt+ZagG+mJ6dFXqPqXaczc0UIaxnZxqOaD18sjQp/LrMgZJMISV
         /NGZSUudb0bD7E2JPsS7B7VE/4bX3bY0UryVd+Os8YcIPOl1Rm/8J16HY9llMxHJP1tA
         qhgJu1gWcPl02VWylH1BJlBFWnw3I+P0LX97/Zm+zj99L8GzcVQ1rn8kt5/NfTczgRxh
         K+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951098; x=1777555898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m8HVxJ0pTOUMaGM5sF22jVvxmxUgeEH0LTk097GA07s=;
        b=HQ9wex4e2XnOXMhq6mQnhxjrkxb48J+pkH690BNLer6x983M2hkdhU8ee77Rw78JSi
         FOVqZvJWb83PUau69IVgQQYEQd0GynAVb0uzPa2WRarudI6p8udOfT5wOGjz3DKYy4rA
         NNuYR2C4vK6bA53PaMcPq2JSsa52sPR7pOelU0hLXhHTOSEgp9ga2XwFwNQCrQNsqB0M
         X9dipfvOng+QgMVjyxCtmMa0f+Ige87thUfgUe16twi2UBt5RMsB6xfzgn5qwIlYP+ay
         M0Z8a0UIpiVFtXOkcor2O4gxAD84G7e6VLWHeBrgOlLsKtfb0LMmehM7HT1UoFrS084X
         h6sA==
X-Forwarded-Encrypted: i=1; AFNElJ/ld/fMN6pIc8whPDGGPts1iHJMEkE+FrSkgEwcb1W4RMUglBp5sFdILD3WPcg0SfKTinOP/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmgJ4L8SZtalyt9CJfkhvTgcMKQQPkx4T4WPn96UlzcQqFfY5S
	yiRdHatoDLdnJaowmotMagKqD70kkW0vS/m0URE4pLaCUcZf5HuTuyY8NCgY6M5fZ200P7eSQMv
	SJl9pgUh8v+D1jiVb+eKFAIarFV3YpTqsgs3rJH4kIu2tGE/29as98sI/sQ==
X-Gm-Gg: AeBDieu3sanAqfzqYV6PTP5MmL05AUMMuO/esJUmWqMI0mZat9Hg9bhVuQZ9+b0HCYm
	mGGAXD1ces2j97MJBlCDAFAB4KgqbWRm9/p8H/TW63Lt34Nn+L+Md+/8+ufUgtVvyK/kTjoonjm
	pYaQYx4TpX0FVMqs/WCVvp0krFN9WwFJxmpTiMUORya8CuHP4Ta4A5qtajmUumeec9rWI2iM4yq
	2oDWMHUbYvynPG1NaxqgOrTIksZgEx+Fac8OBGuQOZ0Ak8fF5nPclc4Pu57DQY1vJGQ116k7XQV
	wFXRQc9aKFoZLTdd6tX9X1djaJeKKQZ4exNHqa66UgzHu6+ntgC7phlL/t0bJEhtxcQLWqxfT6I
	ecmUAxpG5LXioVSlK5Y4a5ENvqIXOp5RIF4inceWebfRLqIxJ47VCTD8LCdGktu+cXw==
X-Received: by 2002:a17:903:3688:b0:2b2:501c:ba8 with SMTP id d9443c01a7336-2b5f9f7d700mr214914105ad.26.1776951098358;
        Thu, 23 Apr 2026 06:31:38 -0700 (PDT)
X-Received: by 2002:a17:903:3688:b0:2b2:501c:ba8 with SMTP id d9443c01a7336-2b5f9f7d700mr214913615ad.26.1776951097773;
        Thu, 23 Apr 2026 06:31:37 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 06:31:37 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:40 +0530
Subject: [PATCH v2 11/13] media: iris: Select DMA_CONTEXT_BUS to create
 firmware device
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-11-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, driver-core@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=1132;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=ebFEmvXGGkqJKD9mFiIVA1LtU6HQ5Bywf5jEMGrP3G0=;
 b=bQ2hOZeQXviL9nyF3kRsnvZT4zluN72vayk4KkSLYRcfIp5ZJavRUHXeaeh7XDtSU5FxhOQqO
 0m/xHMr57rABgvyiSf0X1xDEkWlvlf58cukHzX9Ec8r7jTMd6Tw/pND
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=EZn4hvmC c=1 sm=1 tr=0 ts=69ea1f3b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=LyCF3VY0PmB3I9bQj-wA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: spMNH-1pjRxu9OomQV0rrvdHOip_H-ot
X-Proofpoint-ORIG-GUID: spMNH-1pjRxu9OomQV0rrvdHOip_H-ot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX07jJrpbo+TRE
 9nRx5grZsYm80iRvcOpb0uKFQWcXUwW6QvHXMARK1BB8+VKqB6ka2kJ17j2vo9n+7avICCh/QcC
 Xb7MgGccSgMhZu8uG1Aux+GHpZ//XqTcjkeUzoQo5eaagxOGRZ0z6IlkTuNEA1A5nxDiODr1bvG
 NDxqitLWfvkVhYWC2R4O69zPDzWzs/hG55Vj0adQ/RIyeinDrX6YvjzfjwPV1atnKi1bnd8GUsJ
 /giGKnNro5S41fJm+KRPv4i7rwh2hF5DarvgTn1+WhU5TX05/5Qw6xomXisK4MkZj3Oo+QqVeee
 3pCdSKkk6bEav0+mZzwYQDkTbkslFei9voPnI6tk21VvcWrYTuyxjNQSS8fzUG7L2elHx0A2yUX
 KPNtPliby2EoBptyRIvcM/dZI5qfGRpMGEMNeq/0LbWrAYxlVR+BXwcvvAcYoTlBHAUakyBnovF
 SYXiQ2cDKEzBYpg7khg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230134

Iris need a firmware device to enable secure PAS (peripheral
authentication service) support in case of non-Gunyah. This device
requires its own IOMMU context for memory isolation. The generic
dma-context-bus provides the infrastructure to create the device and
configure its firmware stream ID.

Select DMA_CONTEXT_BUS to ensure this bus is available when
VIDEO_QCOM_IRIS is enabled.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
index 3c803a05305a..de1fc4b07ff8 100644
--- a/drivers/media/platform/qcom/iris/Kconfig
+++ b/drivers/media/platform/qcom/iris/Kconfig
@@ -6,6 +6,7 @@ config VIDEO_QCOM_IRIS
         select QCOM_MDT_LOADER if ARCH_QCOM
         select QCOM_SCM
         select VIDEOBUF2_DMA_CONTIG
+        select DMA_CONTEXT_BUS
         help
           This is a V4L2 driver for Qualcomm iris video accelerator
           hardware. It accelerates decoding operations on various

-- 
2.34.1

