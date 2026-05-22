Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6643C81A3
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444761; cv=none; b=b1rAtWqybWrjad7pIXGW44y99lmY9E/DME+LvGmkxBFDoUjZjnvrGGdOmjXw0ajp1o3qgusJjyi9HtNt66ePhSJhfeMs9nI4fyRJ4unXL/0R6mYBI7R47VIrIR7c9eRLhttlYsdYnHkttuQ6kjt68iYFkb98ENha4tsbqYXOVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444761; c=relaxed/simple;
	bh=obY0yd9A9w1nKiCc00V/sWC5PfbbK/PzpgmtQExUcNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sScCYcf8GiY4ZRw/etF/gPwzzyE4RBnMNSN+OpfC3gyzZlb1AEbuGL1kx2dX8ghGgTgBeOK3qwtogMMcBtM6F6j6D/efETQj07Q5xLhxdbs+5Vvl1J3ap/uzs8SgsquQA15gaivqekSyGLhcJqNz8wTUSrwjX6sQWvwIhtH7Z3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aVtlyU7m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E26zp9tT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aVtlyU7m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E26zp9tT"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M96VJM3532232
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 10:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9dYck4F1ifiwH0J/tkMJzJATF4TXnrW2srpgDnF4SLU=; b=aVtlyU7mQF+q/O1S
	1s04tHwI4DI6ylk6EAp4BO2qHva42VLz1V/Ejlq087p3/nTCbuE92byMZnA9fylV
	nu1j9+YacCsHELOvlfxUb03c44tZe4gRbhK+3oN7aTXp4hZ7itJXKvJPUWmhj3pi
	1U5QEDSzgCsWndExIMmkqkguioaXwwVJIBEvTxO5SvnUIJQJ7qKNSh2OQhYKmyNA
	24LvgUwTqVlOsGEHoLrk/dBU30/GH2XF4QHYcjE0RpgA3I6gM59AIEPo8ZglKWF5
	RaT2uikmyaW+TKHiNjBdbXS1IoyewaMCSuPar7om/Zn3fZ6fhIGyW6cptlQv3Igk
	0ZuU/Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea39gvjjm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 10:12:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd00a65673so53920715ad.1
        for <iommu@lists.linux.dev>; Fri, 22 May 2026 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779444758; x=1780049558; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dYck4F1ifiwH0J/tkMJzJATF4TXnrW2srpgDnF4SLU=;
        b=E26zp9tTYUXmocSrShGjFm87xMil+mG6uUMrBioDh+AwNxrSb72P8myxdE5qQEvvPt
         QVH86sYsWY1z5rzfqQmdLQ0Z8r9599/8YWf1dF19f9Z98LqjTq2lAOlR3/SJkbuXWTmB
         hk7OU7tcmUR0Pq12UyoSW9UGhkH4dJWbUhwqTduPmdPmiDNemJNRBSQQqXgu/OrWIBES
         C4/jkJY2fEiTwumI1xyFt4efdFxythyIDvuUIDQoYzVKdZ0Tx3ncU3O7v7T60Apc1ZTg
         entMoJGrsTOrs//5ia6r4j+ZGxl0wUpkkUExd5FFKqZ6LbQUbMV2P7QR67ural17Hyye
         DXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444758; x=1780049558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9dYck4F1ifiwH0J/tkMJzJATF4TXnrW2srpgDnF4SLU=;
        b=bmMBlPt6/grrcqIV8cFXfmJhSik4h8AEoJWVTfP40bEeB9WKlzBDFqXxwKx2Zw4ZET
         FU95iju1dqAsY2YoQC7JK/xeDSXQlf8H5VHNvdvSXSgLqvD5E9Hz4dCyj36nfyv1ZIUQ
         Xt2hkjDrq57mA6Z1SN2b5KC527CrxzosxApAsC/zzANkMzYobfUq3KW+GcuIk3ES7WWv
         ePh1i9JmfugDPcecBzABQFM4QQDqD2D1ptwYmX1m98y7IB1gpRF6vWQP6E6qswK14U4u
         zVEnCH7jQm08lzml/NLgs7XEG8EOnavL/kQWvjMUkZ65sKezWNvSzP1P4LzmQJ76IrDX
         4ZBw==
X-Forwarded-Encrypted: i=1; AFNElJ/lupoSnjOHjJPtvH411TAt8Y3gttp26AdKz8RTnqCjESAmuxQRVhxINUaDD1fi8iuG5Xd85g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdCd0/t+z1d1M7ABtzq9idxyoer7kDjB24cBsjx4y4lbN2W6On
	bYqr0Tb/nTqNhJWXkshtvfD2HbjJgH7WhlcRwgs+dZAK3qahdIcQoBi8igXVPAKTWtVziGwCvyU
	09UgOSDvm9W/iIC9Oz+58mmlFKHIJ5QqQmHO0HJNykeS/SC8pYPVz+x6a6w==
X-Gm-Gg: Acq92OGtlS5JIJPUpvLv7im36eIIvi2dPSmtiYfGeJhclWOZIN7B622DjPrFpRJ6Wki
	u6kCRHqiFcbMW7XhHAAqy2fVO5VDnYuUZdwSJpZzEgJmwWVmQ8pQFv7NE02JM3S4Al2JYYKOHx5
	umb5hjtuaak55vCuW+uFb39Sx85A8Y7U5ND8yatJo7WcDuYIotDr3QTLJjg7zzQYS+LsVlAaTBC
	jGwV/ezYYxq9F2O521aAYrI/KvH7sHOt4aszxAGoUMT6uWwPeUbyIx4GYbRGZnInS6CZCefd8kT
	aUvY7JUolL1eHcSrOJ5bsG17cmQDkzBypuOTK/NIzGnyjSSPbru3fFDX6J5kPoYcRvzy5u32uqZ
	zsc6ZxImoTMdkgOc7WxXj19Q2eEcZtWspgSrOBdnjI6NnlA==
X-Received: by 2002:a17:902:da48:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bea22b759amr66987555ad.20.1779444758359;
        Fri, 22 May 2026 03:12:38 -0700 (PDT)
X-Received: by 2002:a17:902:da48:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bea22b759amr66987095ad.20.1779444757875;
        Fri, 22 May 2026 03:12:37 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202b4442sm1143498a12.12.2026.05.22.03.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:12:37 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:41:57 +0530
Subject: [PATCH v5 1/5] drm/msm/a8xx: Fix RSCC offset
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-glymur-gpu-dt-v5-1-562c406b210c@oss.qualcomm.com>
References: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
In-Reply-To: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444741; l=1052;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=obY0yd9A9w1nKiCc00V/sWC5PfbbK/PzpgmtQExUcNY=;
 b=pdp64ebXg5HPwlKwhpGKdCt4wHbjegnmKMSMu4DM25HTq8+oXTKxhTVqzHseUN+lTBUiptQH4
 KmSKIH80NuvCyqgY5lRGeS7K/Ol9xitlYW+htTssbvNc4sWExXaTNX2
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=Yr8/gYYX c=1 sm=1 tr=0 ts=6a102c17 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4MPhRinBehVJTi7DQIkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: nblep2kNVuiL3s9cCg8XgE9ITHuuZ9an
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMSBTYWx0ZWRfXzWjfoDQK8grg
 SU1L1oe+FCOMGRz2NEwfH6ipHz0k9wHDGFUhXW6hlt14OgEfY0yJ42Nhft8jV+ujGbA6I5Pmyon
 tEJ/vqvGJ0dL0L9P6XbW2VNg7P5KYieL1Tcxsr4YPbIYVb635GT8DGdzvBPY2anBLEaJbc+sgyf
 2uBQnFmKiUIjBydQUrCe1MZRmRRZWKLg0zR5mB/Mq8WAr2Mrn9w7PHPXbOfobn8THmm0xBNLrr6
 uvSy3FOnS7m5j0AYLHScJvla9PXnwVakWis6Oo1FvS1ggw4vN3Ir71yRn02Px5Kerw6zZ74+rZk
 MX49eXOgbo3o5gebKFpcY4Yrz6+RgeiwuRvfJeuY8eJI8WQd496MA8JiUIVlzdN6p76opWVqOxB
 w46itV8EmxhgBdl01p5PTflFkJ9cxvhHj98m87PQz1T7p8EWPovCsu5qAZG0ulCdJtWnLQh/ev4
 Oj0WlXIgmL5RYHCHFvA==
X-Proofpoint-GUID: nblep2kNVuiL3s9cCg8XgE9ITHuuZ9an
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220101

In A8xx, the RSCC block is part of GPU's register space. Update the
virtual base address of rscc to point to the correct address.

Fixes: 50e8a557d8d3 ("drm/msm/a8xx: Add support for A8x GMU")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 1b44b9e21ad8..cab4c46c6cf2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2357,7 +2357,12 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 			goto err_mmio;
 		}
 	} else if (adreno_is_a8xx(adreno_gpu)) {
-		gmu->rscc = gmu->mmio + 0x19000;
+		/*
+		 * On a8xx , RSCC lives at GPU base + 0x50000, which falls
+		 * inside the GPU's kgsl_3d0_reg_memory range rather than the
+		 * GMU's.
+		 */
+		gmu->rscc = gpu->mmio + 0x50000;
 	} else {
 		gmu->rscc = gmu->mmio + 0x23000;
 	}

-- 
2.51.0

