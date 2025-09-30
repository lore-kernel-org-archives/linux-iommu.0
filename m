Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7A2773D4
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211407; cv=none; b=Duj064RszKA6Mv9x60gbihxkM5iVpZ+B4S0coQo6O5AUw1mmI29aw2HuWjV14ZQG18XPXKb14tWhJKmD91D0F9SuzXAgVgzMlzxIHy0ZDSPQFdf7IunYhZr8+nxsDC/LprpzLM96+RzUzNDKfd6wJ1BccthCnF15LuorGtdCOiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211407; c=relaxed/simple;
	bh=JAlufx4bcWYhOFT96HAmSFs8ixvBu4zisfH0Ny260iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZ3XQ/BUwoifU9MghFlfm3DZE1naWGITHx4cw+wJZixi+lrKMAlHRgjfa6njUCHuWsCFlHjPD5o7GmD7X9uRhl3yksauASOdNYsZIfDzThgI5Jv+GDkFLcmlwCJuWEdmU5ntzcq3aW/hw0VnNhdXMls1h0qkAwh44L+Ir8o7Xx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ii2dq5xc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ii2dq5xc"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4Hs2P001259
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 05:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H+Y5nCYPwx7u+eftr16tQ9QPU1KFxFK+YtBkCK2a/5c=; b=ii2dq5xcszBZzzX0
	Wi7biX5+UML7GS+Tb/ZhgIoxVbQ+1qwEi/cDIlAlwf/fMA+qWG2mMqDq0E5F/7or
	CrNK46VHO1RKASZLO+qYahBGFq9ZBDEKVRtMXpcZhjOv8/Cv2DfBe0oiO/Ty0rYi
	3oKTq53euWSqlqF/2G/TEoD7vGRm3FFtUleXnsc7tixui7wh+DJjFBhZtE7gJNdd
	Yu9Zd74aPJByCatfs3g22JX1hxj7zf0s22sPpklclSv90dzTNvRcZJR+z/5orn2V
	uqTSTu09oFreAtcz+gHSTmKM4E+H+Qc34tSDcm7/H/F9d8Irz2PTIhzUpYeog369
	uSWR0A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fppr38yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 05:50:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27ee214108cso107537435ad.0
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 22:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211403; x=1759816203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+Y5nCYPwx7u+eftr16tQ9QPU1KFxFK+YtBkCK2a/5c=;
        b=SDJn3dOot3HM5RTWh5KNH2VE04Jvf270PQ3sYeYIWbzVfmd5wjZMgMAn+1QZr1wCCX
         suplHOjd9Yy8c6ruV0Icv9NOSj1RwbD/TSO+Z6lxAuN4XEctGeIYUTD2bM8d2YlLVGOD
         X+n5TcZjfrdSsIzMfoDJlKlXAlpSa1OZAiCMhYc7r46t3cx6v8ZnPOJN9LRe2W52w4Ms
         r6MvYQLKTXETjh677FHhyI6+q6uM6TVUN0ltrCd637BizhyALR5TsEJGb+zhBiqbz8aV
         wWIQj7B9FtLGQM5S9SaKG4aE+jNKWlp9jA1vowM4lhz2wiOLTyYm6qkFXkmjbONz9qYE
         9jbg==
X-Forwarded-Encrypted: i=1; AJvYcCUQk389aV752rd8mxV2Ux1pMpqjT9atf1wpGvo6R/7tVa79EX+0U0x9it5N2UQuBDDvqSJNMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHQWc02CcqVp5kbQlbjtSCzyWNO5REWrTR8PwT5aojhrWxpAcI
	MktAdJd6ft+RPniabetXKF86716F0v2bu/JIKhJHnTQllpZ9Ge6i1m0hCJ+AS07MmSkHFNQVOPr
	AZITB6avs3ZD7PrpJUdQdGViQIQqpKBxI9exf/ongeDlmDAXBg9z5ee+FRg==
X-Gm-Gg: ASbGnctyVHXaDQwOdONyVbreN//bL8m57deSbtZDwJvj+ZmSioli8HE9+OzrtJdtC/o
	7oOgNk/I/neEhB0yMvFJhz/4h9Eu6v5wQscH2Mi2sY+8vWcv1S+CYjbYPnZj9NAwSQpTLgrcI16
	Q/9jgJgh0Fly3GnO4pacCN+AHtDiVtR0vhVE54jnPzBWpC6MCddepdAkh/T3sz4iLCPM862Rium
	QyPS51GeA0EuvwYr/txsOmmVKT8gDdi21mVc/sr3zlzjqJGbjIHdoCNCMnnFqCCmzcoQ6FwGG/D
	ummtt9UTXAsrOlg4gjTtmfKTwBy8wwekiH3n8xUwTbwBlPfZ6jdFPRTI1vOHvuEwWbWGGg==
X-Received: by 2002:a17:903:2343:b0:265:604c:17e7 with SMTP id d9443c01a7336-27ed4a89825mr178638125ad.60.1759211402708;
        Mon, 29 Sep 2025 22:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfxMz8cAOPh+Vs43kdCM5oU0zEFqqAy+EADwvCBEeDKHCk/6ncSzf9Kw1lSxzqRRosJ9WkNg==
X-Received: by 2002:a17:903:2343:b0:265:604c:17e7 with SMTP id d9443c01a7336-27ed4a89825mr178637855ad.60.1759211402274;
        Mon, 29 Sep 2025 22:50:02 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be23412sm19029779a91.20.2025.09.29.22.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 22:50:01 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:18:07 +0530
Subject: [PATCH 02/17] drm/msm/a6xx: Fix the gemnoc workaround
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-kaana-gpu-support-v1-2-73530b0700ed@oss.qualcomm.com>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759211380; l=1521;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=JAlufx4bcWYhOFT96HAmSFs8ixvBu4zisfH0Ny260iw=;
 b=0SDd5GWlf6Z1edx32Bey18kAogkeePh7FfDo6CnNR1gZeWIj1Lj2prEncun2xLJyodvNcrtLE
 Us5ChPyi+I2AV+S7wi4gT4RlcjAd4tPRBxegTfXxDxVU9VnlSZRyDoS
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MiBTYWx0ZWRfX8/32tRIDpLba
 DQ2Zfsyp6yXvVxpg5BXwJi14RmVEr/ag7F3UCTJKTKN9biOS2mFSVwQkDtF1HM5NHvXTF+SH4Rg
 rbXRoib6aklrTR/+bJEh/d8sWppx9izdkOacSaiSDqUOLjqV1ZRU26uh7A/mYvOGTlhmRQOm9RT
 Si4f/z42A2ywgTNa0lfmZ/ox/pXKLDtoTkiD/vEYiFTi1CmGCQvI0klIt8D3mtpWAupZ0Z+d9X/
 WQSlvx3YRH6Jia3/YDq47f+l4OuwQOkCWjogD/bZ+OgmdukyfwVW+WBR9G4MzO7ALP79u0H4lMM
 ooai3rH+50AwHDCYB2lc/RbTmjkHvGi7xuv8bfge3G7uyMc4BRoIqWYhV/EjG5CQD+kPzICyJiR
 V5u+8rm+Gf8R5QYcV7U3ziAqEeZLwg==
X-Proofpoint-ORIG-GUID: Hhfy5ijf0L2IV_BXtNGUzFxOLu2CSoow
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=68db6f8b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gggc3m2WwWe7Cuz57AEA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Hhfy5ijf0L2IV_BXtNGUzFxOLu2CSoow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509290082

Correct the register offset and enable this workaround for all A7x
and newer GPUs to match downstream. Also, downstream does this w/a after
moving the fence to allow mode. So do the same.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index fc62fef2fed87f065cb8fa4e997abefe4ff11cd5..e22106cafc394ef85f060e4f70596e55c3ec39a4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -485,8 +485,9 @@ static void a6xx_gemnoc_workaround(struct a6xx_gmu *gmu)
 	 * in the power down sequence not being fully executed. That in turn can
 	 * prevent CX_GDSC from collapsing. Assert Qactive to avoid this.
 	 */
-	if (adreno_is_a621(adreno_gpu) || adreno_is_7c3(adreno_gpu))
-		gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, BIT(0));
+	if (adreno_is_a7xx(adreno_gpu) || (adreno_is_a621(adreno_gpu) ||
+				adreno_is_7c3(adreno_gpu)))
+		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, BIT(0));
 }
 
 /* Let the GMU know that we are about to go into slumber */
@@ -522,10 +523,9 @@ static int a6xx_gmu_notify_slumber(struct a6xx_gmu *gmu)
 	}
 
 out:
-	a6xx_gemnoc_workaround(gmu);
-
 	/* Put fence into allow mode */
 	gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
+	a6xx_gemnoc_workaround(gmu);
 	return ret;
 }
 

-- 
2.51.0

