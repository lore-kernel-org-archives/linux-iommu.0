Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3D3254AD
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792700; cv=none; b=oBBmBDZ0LwYG8euUX/re0TvHkj+4DyGHRVDXsgj0tv/E6qbKxe1xWpwG/zyBJeRlfQGic24ogip2WiZOf7a+sjdDc7+prlxP3bQEm8WUwUHiPJc7buPKGk2AgrAXeP47iAJrKTYEMtkOMf1idE5MVxVj72BSxpsO1wRFHhRX7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792700; c=relaxed/simple;
	bh=0RH5+HB1DhuPB+qO4uxLrDpF6juU+e+LzCOFWLT2Qxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YgeVkFGGTCoFDRDiwePBpA0JDhNXijcpMDKqGoiZIkPql37RaHiPbPur2dkwXhhPwZILNinD+zpAt06hDMmUgFywnzu1rqT0ejLOewN/BC+DxebpFx5bR+P/b8VDUhJci4KIkjJv7KK//Ype0+JCIxjVdTqIy/kGYEqiiBwdl4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FylzTH7q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hF0clN6y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FylzTH7q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hF0clN6y"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFhoqH3985681
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mcdYC2GUWX3Yt8G/A+qwsr5JfoxF8rsQMfbirKGchD8=; b=FylzTH7qXckURdUD
	OLX83HGhHgJ+Q9hrI7XQQPI62RDSKKMBhh0bziVThWbjjxWf5o05jdu1XEuAvH8e
	y2wjqPz9YWG1klmm6PcsEK+dGJf1TE1OFvEQ5q6vtg4vTtft9dNnvAYFpwAGqYtI
	5cMkGqXJG1ErKfP5JM7siZHbbmnWs/YWf5DSJ0zsNpgkSHyyNeWJZlJCu9fSBCTi
	h22vLn4WnQF6xiaI8+hwlP4O/MMi5QIvHss41z8H5CVHvL/9YdB88qbjl7VH5R9z
	+pplPbbGPpUqPwS7snab8AalsHi+UjuVhJcr9kzTwD78uwY5lHZ24hYcBCC7LlYH
	BaYOPA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abjxqg6n3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:38:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3418ad76023so8108477a91.0
        for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 08:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792696; x=1763397496; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcdYC2GUWX3Yt8G/A+qwsr5JfoxF8rsQMfbirKGchD8=;
        b=hF0clN6ywpu5U65CSxbw5Zs/XYiPVgKg42Zs7VcoZu9QX5f6mSQpaQ0RZ6KA0yuHW0
         PqprzWRagXE3Ty/eKx8flbkRC71HEG5jYu+nknxAXoJMKJ5Mu8bGGbn44RACqzePaEvg
         PNCIFzp1xwX1omcElP+Oq/a235uxwSEWNAf/FVKz17YCmo6OMl42kfj3gaYQGtK+BRJ7
         zHB5TAVARFbxbzVbhwOIn9V+VhrLJ2YKqO9Uc8JxYs3iEkh8MMUdFvBNdPDNlvP7h4uw
         9zbo5F1skTgeABxK2pG0dEgf6X5fWzEnPJjPnmJC0XDB8wYcummIfaeoBx1h+UJRYwds
         AZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792696; x=1763397496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mcdYC2GUWX3Yt8G/A+qwsr5JfoxF8rsQMfbirKGchD8=;
        b=MESm43T4pUZ7FshZeZjgEwIYcbsssN3RJPwM24ZwC0fPZYGjNmslDzwRb2486smtkT
         ENTI8qpBo1pHPIdrkqUZyFogl8dzudNTBRn1RgLqSnU58CUEMRDZlLSfwceDYKQSmLYh
         clbnbPnnzypghY+8z3A7/P4/QLKs27hCPSxw5ZJvzvBfXdNIciJHfr8Ufjj6qUtFxjL4
         jC7H+XdakCfrKdFeOUN+AdZX7aaZuLqnlBHApp3OaVlHqstxlMpse8tdEfVDlRR/rEij
         zv+gCAwKTBWTDq4xZwdfWqtht9dLoPvu7rfgLRFkSKv8d48GzL2AwXAqwsFRxkLjogqy
         wpAw==
X-Forwarded-Encrypted: i=1; AJvYcCXy3M0ga7AwucPNNXDdbsEF/1TNoKalRmsUaWL1B1Jy6BtdBIHwZZfP3Zn+BXEcUGoLIzoMMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOBwrHSFlgtqzOb5yLRqDUvwaqB7Ll+Bm2KQDtH12j1DdXlQK+
	2Ykk78oz0P9znjnB/DeCDYmVfmO5ykwVZriXwY4+56bVx8IwEwWLhRzJ0zepi0U2AHttb8yYqZt
	qDoFBHWAeVIt2hQA1x0EkDfjhVocpvmBOSD5dYrqg9urBc5UdI/nI8RIzRw==
X-Gm-Gg: ASbGnctcbz7fluHA8RgmPCvJWClrHMJxloSy6/n3txp2sIVkVH9APyZjw9wUndzQP38
	lanyIHdPNK34NoH1CIZzvW9VoY+rcriVCc7j/A3bTbz1Kr4a1pg4z1ZCMWwlzXOuKbFCk57aXSw
	38Z2lzj6/tU1MiTPiOxkZg2Dk04ODT9nA4XUklfFJxdQlyvVPZZz5ZWzM8IK7Uw6GtDGGuX5Hyc
	hcWg4xD+hTEbS4QJL6a+hzf6y38ci7ZgfIt/jpCjZggbxG14A6h5qTeTbwjXeIv/dzQjpxPd96b
	kLftiuT8I4PCmj+qo3Mjm3oYXGhhacYMvDFFYHvtuaDOj3QSdhwdNOrxFh3aD/POKB/d3GxRYgA
	seTJItUQjtPUP7JhsE8yAXfg=
X-Received: by 2002:a17:90b:3d8d:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-3436cba90e9mr15119936a91.12.1762792696044;
        Mon, 10 Nov 2025 08:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpeeLzlAYES/pvtPhYhWt6lEiwIUScD1B6YRIb/1r23lLyKUJQumTRvtgD/qeTqkbN1zcfMw==
X-Received: by 2002:a17:90b:3d8d:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-3436cba90e9mr15119892a91.12.1762792695560;
        Mon, 10 Nov 2025 08:38:15 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:15 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:07 +0530
Subject: [PATCH v2 01/21] drm/msm/a6xx: Flush LRZ cache before PT switch
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-1-bef18acd5e94@oss.qualcomm.com>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=1640;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=0RH5+HB1DhuPB+qO4uxLrDpF6juU+e+LzCOFWLT2Qxo=;
 b=QKpYscsE7JUidxLJTjdztF9wYuuFQ9/van/0jE0PIt/jNOJ6D3vBNzOOdZyJ/eo0wJsHZeZJC
 YOytieMGrHrAXCLYQcFt1IEg81WjWnyBwdBPtLgVa7LKRAYQ44FDAn7
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfXyi2/4LptVrFk
 0cMpydhPYcv4YNDGcqXqoee4KOdVhrQ2rVKw5KbkQeOJXa4jzll0csEHkze/3kgeviWfH3bKChR
 +fIkbEhNl/Fr24D2mURYEIAiBGNBTM9I2t3BP35E/RcS0lkGN6tZXr4zwiypYrBo3jU/w/AluqI
 B71BfshwwjX0O6YnZ1y6FGDfnkgIk6tZs+GwAMnmKVQ3OwPMDM9M4DfWDMo8LULc0JW6t1GCKB+
 dyJY48W9MT0eMnchYAGvHJn7fwOh2u596x0Xqvc7Z5VWm+JtuSLXWEt1uARBoOD84k8dofeWJS8
 D6YEas2gEA5Djf8pqQz1AykikAc8sJO8xGwRjYJoCcgMgZCIe9gx/C0hab4EPJ7bfFyhMmngA2O
 fl9UGUheJTFGHmbsPcZ8E2Jlc0ScqA==
X-Authority-Analysis: v=2.4 cv=CsKys34D c=1 sm=1 tr=0 ts=691214f9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bBR9okFf-Jgdumx6fEkA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: hurXMyqR1bvdE4JB2wxAadJRap_AgjjI
X-Proofpoint-GUID: hurXMyqR1bvdE4JB2wxAadJRap_AgjjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100140

As per the recommendation, A7x and newer GPUs should flush the LRZ cache
before switching the pagetable. Update a6xx_set_pagetable() to do this.
While we are at it, sync both BV and BR before issuing  a
CP_RESET_CONTEXT_STATE command, to match the downstream sequence.

Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index b8f8ae940b55..6f7ed07670b1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -224,7 +224,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		OUT_RING(ring, submit->seqno - 1);
 
 		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_SET_THREAD_BOTH);
+		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
 
 		/* Reset state used to synchronize BR and BV */
 		OUT_PKT7(ring, CP_RESET_CONTEXT_STATE, 1);
@@ -235,7 +235,13 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 			 CP_RESET_CONTEXT_STATE_0_RESET_GLOBAL_LOCAL_TS);
 
 		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_SET_THREAD_BR);
+		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
+
+		OUT_PKT7(ring, CP_EVENT_WRITE, 1);
+		OUT_RING(ring, LRZ_FLUSH);
+
+		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BR);
 	}
 
 	if (!sysprof) {

-- 
2.51.0

