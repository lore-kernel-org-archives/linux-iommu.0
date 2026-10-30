Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397922;
	b=z32puArW+V9l3rzXY+Vbw9PHCPjVari3WB3X2e8u1DUyDVghUEd+1rTqOrEyXPwVod21
	 CQ6q4Io2GqAxE8DcLiFtz1V61SicCtTwWDgtABvxGS+luLm7yuKp9o+Jwgs4pLioTvkRG
	 5shQ+pNyQG4braesiri4LsX4cWboEZM/ENA65T5+BDcO0vMgnf/HeJihBmFwdSDA9vKoj
	 mE+/7IuIiqftIrE/W5l7FWgFojTr3cg85KmfE2wnlO0ok1K4dh4uEj0HMgQey6A1qth5L
	 jX7psZfq0hOSiWBlgEelBvXezgSezBk6z3ZYRZjOmSXEqAVdkvYL3T0s0BahnkTk5Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397922;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=z+fyA1uTF8l0hawKrmxS3cSFozenWUmVe0swEtjJgBo=;
	b=j7EuE8XAvaGjgzgMHzn7/r4reaHctD1k5zFtL35LucBAJanTdWhXsU9E/wPNAkrWbuNf
	 3EMROyeVhmTO0cCtlZLAdJJi38/l6E0KQHWIspm+3vjq96N38gRYwN4Rv9+71KY2mQ/ec
	 d/7Xur+e+R5+wmro+QwicYH0Ui/DoLPViYCm61UR6jRe/XNbHf2M2ElSk2vU/w4ytQu+A
	 EyenbtQnz13K583i1snCWUmVGDVV6AfMgbyTM3RMEZP3Q+PUQSBcvHrEk0DAYSjK4SOSI
	 hno6sSgVyqtVXzwDJx5DlUjz3rMIyYrvwZwId6YcS9IN0XHLi8/3lOdzp3N3b6wlYdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="URwG/Yit";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O4bQCryx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625AF606A31A
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 625AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=URwG/Yit;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O4bQCryx
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ULteal906433
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=z+fyA1uTF8l0hawKrmxS3c
	SFozenWUmVe0swEtjJgBo=; b=URwG/YitOWgw2Cd6X9piaQbXrbCLMbwGRR0imJ
	OMUFop06EP8Tr1TFLK9Ow/SkKwFxSWAp6u2OvFYTkxN5b7LtBG6W4XS8gIEOnoe1
	VxR3uJOm4VTHaq5OwyqwyNs8hUZJRNcfNlo8n1s4u9PC5PmKWlwuykgKksDM0i2O
	C59D5vgj3j9dyXEEuhg6Lm+xPBy5djdkicnCelV34LifVJyN5Z/dxHgttePHzGp7
	/ejqtDku2znvofM/fDQvPS3HZ8OKG9E7k0DiBC9aa/vyPkBgA0qyQmrqcfWlS4FJ
	/9VWFOGVx0Li+482EvV4+BQJvxftsWrxwZd6BRO9xpgnllOw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x10a74-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:05:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f568dee56so199195285a.0
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 15:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793397919; x=1794002719; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z+fyA1uTF8l0hawKrmxS3cSFozenWUmVe0swEtjJgBo=;
        b=O4bQCryxZrl62vR4BG0KVH3Ei6hikwjalAuuTC6y9kvcqDFJyf3JxW9TBR7bEEKDbS
         dzobLN0E4v8g7FywYz+Ign08j6Xpr7Dz4eFhLnqAwtUaHPVN7Wd2oUc7Z7OjXjYFf7pt
         iNgy1qOr7QZBlfTFcrFu3SbU1lsrGUOB2qydaoDcoYaey1f0hV+tFyJ/r9xzNdvT9TEj
         Tpypty8NobLWMFCu8saOBpkHDHuF2ciAo0wFZ0AlFPoo5TI52M+TObYaEBvq4InGntKy
         fACCl4pe72TGklUtpK4s/0uYgOTEbMS2+HaLGyipMf+TJLtjiWct/7cwxupw/5ogWQU8
         uz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793397919; x=1794002719;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z+fyA1uTF8l0hawKrmxS3cSFozenWUmVe0swEtjJgBo=;
        b=V9fw0NlkMc/aDr/3i1okMXm/xWIGxsPI6Fztcu39w04QzbuUMN87LMFKGkIq0P+mq+
         Cs//CIJa8zZvUF9GcXGtk3WktPehgOHxm5dY25KN25MJuwwZ+bHfyN2Fx3MjZPOilswn
         RylDyVKH6VUMs9KBtHyymL9wo3zKGlH1lB1nfImjeD4eVdoxu9gfyXu2Qq9nVWZbTUTi
         zrO3Gl0lpQZM6eFzfSgoY6CenSpAdsZfif4hgBBx8+2Y+pwYRACgmGB7hKYOnAU8Aqqf
         fwBujb2dp2zbzEqca9l2PdPL2Wd4Y+BFwoXMWqhgG1X/uqFhqLW+Pw3VW1E5Psq1qNva
         i7+Q==
X-Gm-Message-State: AFq9FYKqKqNUMYLafQ3Iu7OOyWgzXa80OceXQwAIiDfWvsg36+Bio62W
	N7qZXEv15ahfRdtyE0J3Qyupsr5HvjEbEL5weyezUhfBmPvM29OmRfBIK0FHlxrKA+W+zRj7sm6
	v1feJxLi1eFVpjdWlErkJ2JxqpHuV+QCFQhEkDaGcevFbDZOS1CEspjOlPg==
X-Gm-Gg: AYBFou2m+UkpFglrgNsFcId+aVryiuuRHtuWJPYgmJ2G370EOax35NR1aDKaex0r/Ie
	8l1PaOTnb0FbKKYPuDq4hEKVlT6DyEMpx79C44nU13kPRgAPcvbKgOELX4noyg/A6ErN2j3zg7L
	+UFzQsalPd+TZIcTlgJ0cIhaZxlQ2OJVmAan39P2Kf1vSCKJBXba+1HH5jjAM3guoJCveaezO2D
	z+6qmz4VLvmVbsmabFwbzUrZj88/EKPrxGedC8Q3RFskpPzi7Zyr2n5EeuJzrrwMa/YP3jpGbLs
	OR6/0Q0LysNXX1wIWGV+4jyCZKWIbC2PZ3APun2pjIPZzz10S1hgrPQLqXPCAaFlChmw9AN2UYD
	BbHBieGA+tN01KKsGpuHFKNVpgzbbGeWTsBSwCV1D+k8MbLg8udI5NIUOmE98C/h7OVTwSSQaWm
	D7cPHx8l4HllCclijjnUmrMPNRFTBtSRouKIzY216LoVF1jTPItvocrsYINzXtZg==
X-Received: by 2002:a05:620a:458b:b0:93f:22c4:e92f with SMTP id af79cd13be357-944216ecc93mr652556085a.54.1793397919335;
        Fri, 30 Oct 2026 15:05:19 -0700 (PDT)
X-Received: by 2002:a05:620a:458b:b0:93f:22c4:e92f with SMTP id af79cd13be357-944216ecc93mr652550985a.54.1793397918641;
        Fri, 30 Oct 2026 15:05:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe04edd7dsm243930e87.6.2026.10.30.15.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:05:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/3] iommu: qcom: Fix the MSM GPU and display with
 DMA-address based mappings
Date: Sat, 31 Oct 2026 00:04:56 +0200
Message-Id: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAIgU5WoC/yXMQQ5AMBCF4avIrDWpTmLhKmKBDkbSkk4JEXdXL
 L+XvP8CocAkUGUXBNpZePEJRZ5BP7V+JMU2GYw2ZaFRKydOiXNb2slHjqcqB9siGtQGO0i/NdD
 Ax9esm9+ydTP18Q3BfT9N7o4edQAAAA==
X-Change-ID: 20261030-msm-smmu-identity-6fda3323023b
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=yRLg7HFVIyBpDR1OudfdDaicEhcnc5ii023H/+Rvg+M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq5RSLiBe70SPTpeJOfW582KU9YTC3tfcH16yAM
 9Ay3jDbaS6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCauUUiwAKCRCLPIo+Aiko
 1XNmB/48FlBo5pNt8rsh2B3HNo35GC7dxYk/u+vNhivR7uRs0eE3PGoU8MvUBLnezpGw9Z6ygne
 8gQCqmsIfSQdJT8aYPoDBbYEvPTQXRlYfC3okuKkr8nrfLFiBrRg1ZvzzqQUdXZHpqfKysS3v28
 QYfEX8y72T16sW3zqsBkm7A9YUzGsdHuj8DKrilgsp3VKj8dS2ZpAt1KMbEomG+aewszvZTp1ig
 mtx6JrKjdo2Hy3DWCN+bAI0d08E2KISyzSM3dUrOG0VslIJVePvGyou7qbhflh6iSkQc0fdwVTn
 K7qHqaBr9vv+X3H4G2q5zC3gYc01ZT6XOSphcu6+nESFJZtj
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX1UWYO5JBPDhA
 p7VdRO4XTWb3W/II/M7KX22f1KU/GTZCk+P2zejQ944GmkiFBeHq3kucBYRSt8Qrg9ZGXtUq4bR
 mQiqjXIOsVYw/uV2ptyzjRW3EuAPBobF6jwY09blqP7KfqHdEl6Fd5UQg4glWPZmZRR5WVbyCTF
 ZYeP66Es5hR0nm09FSFp6R60pJzOJC4RBbqh/Q9/1ZQDw8X6pHqAOVfv9O+qz4zv+VIeZuw7xz8
 M5nF/lJGw95pzVWnAX3v05WoYSDVlpz90vXyKQkbH2i3w12utIXyjf9ZpAHevt7GWPQFF5My20y
 UwLyEuv5cZEUmzWIxNrwKjGCW9GcfJfFcPgd0fq1Q9/PPbShFJnPH7zOS7rRzI54RneWXgSBfr8
 eLDQn5DgauKWTmmSGfmZ/wKOXsSALCdNVOqPzo9berh6mRJ0i2Gejy1ANG2sw4NwvPc9yetPvWT
 SLC3i9aC4zXHSmA/ajg==
X-Authority-Analysis: v=2.4 cv=CLG/zhrD c=1 sm=1 tr=0 ts=6ae514a0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=rHzMYdhUTImRmf5BPDcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX+9HCahjTdcpa
 3U34fnQ6vkCqmuZcaI6gw2peLSw6QZAr5m5/Jj6aqQ9IZtdRXW5JyVDtciXd2gcvSURxU8w822u
 luAIEsm6QKS6HCq1G/SJ59zGxQMdV/c=
X-Proofpoint-GUID: kYTU-Qhc-Dw4Dv8YDx2L38Z8YkwEh8zg
X-Proofpoint-ORIG-GUID: kYTU-Qhc-Dw4Dv8YDx2L38Z8YkwEh8zg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610300088

Rob's drm/msm series [1] writes the addresses dma_map_sgtable() returns
for the DRM device into the GPU and display page tables, so they have to
be physical addresses, i.e. the device must not use iommu-dma. On DPU
platforms that holds, the DRM device has no iommus of its own. On MDP5
platforms it is the MDP5 device, which ends up with iommu-dma: the GPU
then fails to start on db410c and sda660 and resets db820c. The last
two patches give it an identity default domain in qcom_iommu and
arm-smmu-qcom.

The first patch fixes qcom_iommu's flush_iotlb_all, which never
invalidated the TLB. Nothing relies on it today, but the series above
does, hence no Fixes tag.

The patches are independent of [1] and a no-op for the current drm/msm,
but have to land before it. Tested on top of [1] on db410c, db820c and
IFC6560 with and without these patches, and on Open-Q 835 (DPU) as a
control.

[1] https://lore.kernel.org/r/20261027230452.130031-1-robin.clark@oss.qualcomm.com

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (3):
      iommu/qcom: Invalidate the TLB in flush_iotlb_all
      iommu/qcom: Use identity default domains for the MSM GPU and display
      iommu/arm-smmu-qcom: Use identity default domains for MDP5

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  7 ++++++-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c    | 26 ++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)
---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
change-id: 20261030-msm-smmu-identity-6fda3323023b

Best regards,
--  
With best wishes
Dmitry

