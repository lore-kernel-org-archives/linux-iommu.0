Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA45329C40
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076596; cv=none; b=FzK4BqDyQ3gY9hSzYyhc1B8VhwUs2nVdFVC1ZQekBKLzIWCvqf+wUQ8qByNBqNYT9/jyOiyvJ8gW+6aHiv+EUsu5bN3G+5AbyxntXRowzSBh4+NMUUubKLZmsNT8tBRkOU7d+7fYAMYRX9+pyJ5SOdiKnvyKE7XS6qq8Z1aE5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076596; c=relaxed/simple;
	bh=P0TGR9JNBdFdJf9lbTMB3me/b527sl6CR0hvyTZlFRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rYyiD/G+SKD1jN6G4TNXz8FdWP2SKOQTSGG/y+mgFW727THPGExg+xfboVgMw1l9OdUC9OmuvXduJSJ/XFZvcpR8jrcjDWdqVK5RPScZ6B/AN4TcAm0nqOcYcbKkqoMB5NcR5+nnx5E5awQbTxut+IWL1Pgv1adKmVAdIiHhCLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KvOv8OPQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C/t8II4g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KvOv8OPQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C/t8II4g"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMatIA1611394
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DbqxdCr13kMbVMqadmJF4CnX3GwPJlihXZxUWaf1cSs=; b=KvOv8OPQjRl0Yk6N
	GG6XOAzcr2BgYjbcy3Hs5UNvU9iudmZVNrf3cQqHxVsQKx2A7PqUJRSKWEgRRLTF
	XLIOfAXzjHxgWMwdeuhLCThWdMaEJ+tLP0qgmN7G+qWSVjwQtpkL8ZAhLjhz73lN
	h7cgTQz8EDgf/V1K+WSOaWCz6z+hLrSL+RZuaNpSUvQ8IsJTLbtBQJijIMNiB9qw
	xjqSh9DVrZu+8NeGAq8aD9usSriFtPAOCOwQaiOrOfHxUuEqrrrbDhZF+4YJL5qb
	9xS+KMZ38VU++4KwUPUNNkpSvydDd06oWAUx55m1StxImY7kVw1mZ3b9LHpKPgJ7
	U8qA0A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9h03w3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:29:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7ba9c366057so109917b3a.1
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763076591; x=1763681391; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbqxdCr13kMbVMqadmJF4CnX3GwPJlihXZxUWaf1cSs=;
        b=C/t8II4gj20pHzqqnExyMx3f/XeGVtT+GrBTnzlSaT2J7ayhTfe4087s5xlsI/GbeU
         dckY1K61jfDC20T1vV/NmOmGpnPloMXWJgBx0DQya3vwExqo5qEUO92yWfOmi7+ShXPq
         17hz1EoFL2KedTtBdkUzA6hP5QiaK8592l78rsUIJuI0rIDDK0R/mlY/authPZ/GD+J7
         VUQjl5OLYKKH0GNqwjvZthrfpfj22duXJjQ0NekNEVIdeU10eJkjPbgB8LwvZFAqxq3d
         DrPPXe5/5Ynsyn+lj8VI14YKd7Psq04Eiz8M5O8jjoaxSTkywzfhjdQTICH8Lkt/k3Ob
         P/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763076591; x=1763681391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DbqxdCr13kMbVMqadmJF4CnX3GwPJlihXZxUWaf1cSs=;
        b=sys5bkfDrcjTCpUc6ohbFlMqHyOrI64L/eVlVa7VImUXfo1UjFrwIu9+k5a+d3IVm6
         dcKhAwxyP/JBmlHTKeuEf3Prs2YaqexLDOjfWAomClsLxnH2t/2deWC9XrxA8P5O4WYn
         IdU71TNmv2cQZvPzwJql37m/Q6MViDcmn3+w2egx5cUJ02dvZSPvOHEsMXl+zEDcT7gI
         AVPqsJG7FODpl/qTZOMAFz3xKR2Qs71GHpytht60t9/ZnkNLo2U5IySbuLQn+zE+uzuR
         b2fBqQdjovQyPgH7VDJst0EhGOiKbwjFcZesT5Sj5D/FQlXAMZ2VeQgAGpfcQDx6JXnj
         GGlw==
X-Forwarded-Encrypted: i=1; AJvYcCXKcRysTYb4B7k39cBkmof6X1/vmG9SztO/C6yBOG2i0J0BpK5z4fnBhXJpOowlBqgPndmRcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr2QLDjmxPddbhe0QuawsXfAPgFcAXYrbwsbbU7HOIH3tWpPfl
	tmh4+ewn5ciF1g7Ck8DjzULyd3KvI+JOESeBJghnAOxa+/YBEtLnIiryWOwrSAjHTzbMsTwSSRt
	U28Pwgn5ztlPtAvymSMJHxie/eBQM7aWByKVglx0DEp/0Ms5R3e+vgEhsFw==
X-Gm-Gg: ASbGncvDujWI6ngjFoM3169UMUOyvQ2wbp/OXYxKFG88ulnUv74Vy/utxQcJ8Kkyyl/
	tDv9n6Ix+8htaI2mXPjr0YZ/y8jJVaJntrre+AaCsd7kCm+tBaNkoOnZy7Vf26+dXSdKcwC5Vf7
	dW/GH+aAoFMgj0oN9eS4cLt1hmshgCxMG50MlT2qkcjV4zdHC6mW1xq+/Lvhsy+EHelYexRNd8S
	Tdx8NEv8jIxVSfcFl/kV0KxUpnjBYnMKE4UqS2A+IMrzMvZo9C790ZOSBdCMgmr9Tfufh5nfSOS
	TEY0xoWMHJ+/hdVSWoGmfgn4TYkLH8yU0HCsN3qhyWkG0jqPP66Ex/PlRuXFkBNtq0kK9+lcT4M
	zWQXRv9/PMlZLoA9DPXazc+c=
X-Received: by 2002:a05:6a21:999a:b0:34f:ce39:1f47 with SMTP id adf61e73a8af0-35ba1d8b9femr1418076637.38.1763076591295;
        Thu, 13 Nov 2025 15:29:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeBbGRvCFU+UB+lpyJ3viuKd80lm9qg/SW6FqrTQPCqEVq2jmUv7RyRXNmK9UZPN5Ft+Hy5Q==
X-Received: by 2002:a05:6a21:999a:b0:34f:ce39:1f47 with SMTP id adf61e73a8af0-35ba1d8b9femr1418047637.38.1763076590803;
        Thu, 13 Nov 2025 15:29:50 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ed72cd1sm3049486a12.11.2025.11.13.15.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 15:29:50 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 04:58:58 +0530
Subject: [PATCH v3 01/20] drm/msm/a6xx: Flush LRZ cache before PT switch
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kaana-gpu-support-v3-1-92300c7ec8ff@oss.qualcomm.com>
References: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
In-Reply-To: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763076573; l=1701;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=P0TGR9JNBdFdJf9lbTMB3me/b527sl6CR0hvyTZlFRU=;
 b=I95TcxJrZo5IfCg2YLag6wnr+kCPKB/xqUAfc8bUf+PfKRdx17k8+cUdMO4lgWu4+f96+05+p
 nU3+6ArVQ+8AtFUkQwj2m6kgMzzvLE2RHpuoKjwRJqkhXIvMDr5t/LF
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 9Bb6uRoPMIHJ-SE-Lag9x00f0YF3hEZ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE4NSBTYWx0ZWRfX7N/0SdhLkDYd
 hCBFiDWb+T69Lu7kXzXACjxg4es3dHSL/maPNULJTPmuSOgG8qcIgc6Xlp4NjaP9FogAjZ4HlGD
 5GLkAVuIiL0BioZHcuuszxBDt136LajYFkm0ohaMM04bpKWvQsoDZsB+soisNyGFsTlxmj/e1hF
 YTsHaNGLgCNaaQRzmqGA004t8WygImN7p6cfny1wBBD9ewHi8nFEjy+KS6YRaw9RMXdYsMOKHKj
 fLUS2x/GDWueQdF2dC925kQd/0vptVoK5GqROdiPoNvS5WnWAnRpW71uZ5UyRGILxG1IAC9aizU
 SbfWDddLZvKwVpcFjjKnBWf71Y3EhikZnev1+4rDOlYFv9LmfzgspeO78sPje6U/jzD8ScUEyOu
 NbylATzGkdma9m9pHm2izLdW8cUEYQ==
X-Proofpoint-GUID: 9Bb6uRoPMIHJ-SE-Lag9x00f0YF3hEZ0
X-Authority-Analysis: v=2.4 cv=V+1wEOni c=1 sm=1 tr=0 ts=691669f0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bBR9okFf-Jgdumx6fEkA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130185

As per the recommendation, A7x and newer GPUs should flush the LRZ cache
before switching the pagetable. Update a6xx_set_pagetable() to do this.
While we are at it, sync both BV and BR before issuing  a
CP_RESET_CONTEXT_STATE command, to match the downstream sequence.

Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

