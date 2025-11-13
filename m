Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70448329E4B
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076601; cv=none; b=EvzSWmRqqYXotc2Ay5JFB9igjLarDRgFcwTaUws3Wwd5rVKydVbK7ajbtwHDSrGJtfQDm/U/0AbjB+/gFsZ/ZaVkiaJFMLbE7CPOHtbOR3QKNbg4IcwLsbnSmgYXDQyMmAK48lBL3uXt8gplEmc91bh1qPE1fSHEmOxqeoOzOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076601; c=relaxed/simple;
	bh=B0t21POhzhnkPllkO0aJhsfTVayUVxYvYda/rajz62U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uM9vIBEBf0wgWTEvxXB7t9yH4TZO6ZKkAJh3/niv7Ip4rSrYKeoqCFSYWvEtpzA92jjtafCgZgOyze2v6lJATCYTx1zGCSc0S4YxG8oJvVDFYYXYvAOtc11ukGoifv9KnOpgK1iNiGgpEVYyzb4HxMaciup+lnGe4ZTf9u2anIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UQE1C7LP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P+BkXHMA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UQE1C7LP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P+BkXHMA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMam9O1484888
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U76nAoGUFZhSMgN3LNNB9B5figDIPjE3gLJdeoHmGms=; b=UQE1C7LPJm9301dA
	s/+45xtya6dKHJw4ywyVCmAOJCFCYGSoQ/Tw+B1jQvDUtVdlltohTbrtBobkF25z
	GglE27Z7HJl6jHg2K0tw3THfyt8p8k2uzgtwWCmAZGw5SHhNnY8J91QQTkTTGOBW
	uBPuulh//YChgSmCTokka+eZhRZRQJNTTw08Njw30JbZUc1Y1b9exRrPE0PcQKWd
	BB0CtBOI0BQJyCd4Jnc+OvWkK8UrxSE9W7I/DtJpgbuHvDd2zZFKk+HnaYo8E+0a
	O8LeWLrwYi3t4/S/34PGPxlGx5jGPtgG5c4vbPl6RjBwBCKQ7sYQE9hIK0saT4+D
	ZSUG7g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9cg432-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:29:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b55443b4110so1075549a12.1
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763076599; x=1763681399; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U76nAoGUFZhSMgN3LNNB9B5figDIPjE3gLJdeoHmGms=;
        b=P+BkXHMAfqEVnY+L4j9gDL3arSLh/v/j5Nc1KWotHlKsDF5OwSlQzV28+sqyU1C30u
         Rhqx9uLOyrkAbF/7c3fapKOWzRvwcSYK2Vd+ASpeRKzu5Zrf4mt3VDW82EiEqtzspMt0
         ZAW69MXtxSzzVSzLpSqLxW+2vVrktWpYrovRsbnjBGnjMnqv257PCt31WyBTz0RZbu3I
         qx/N6wkV9sfZC1pWGUpaYSKtpTS4CDXS8DGiBQPVOzJquvSwmz980CiaJ+jRtxT2j26W
         onD2XfhfbmgCETNP6cTN6+IMTjWKXE0tqIihZK0PpNXQ2x2gFko1UuLAkNyGwMwuBhEc
         zO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763076599; x=1763681399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U76nAoGUFZhSMgN3LNNB9B5figDIPjE3gLJdeoHmGms=;
        b=Suw2r6WWaXayNHoT/OBYKKkmG55qL6WLKZdWyMr7qwEAo7WpwmhM6ZgjaSBLrLfuo7
         4saf09U4fWNlnavlSchf/+PAbYnJG0p0D7Bdp+/wbkxSe8SJG26TC2xgmQgd9ewveiHC
         AwSxPh/qdcQWTgyZEDWuq/RoxExLBUcH5NOdO1l0XkGOFs+Oo253j8QI9d6w4KQPaQrQ
         ukIlWv4+ibSFYG2G52+A4NPa1+wPzbdaYLTwp6YbKSOtYHtm8v9tONcIrJBksWVEeOdb
         vgNmX2mgdwP+p3gUpu9cgLprT3YyN9kC263cNFWez+zgEQF89wDPBeHS02ce+ZozElJt
         kRxA==
X-Forwarded-Encrypted: i=1; AJvYcCUNpjGWlWq7V/8FrSq0Mn345Fyn2a4guIZFikGj2ht0yJ3REAP6mA6pNWG7F2IyL44VFP0CpA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+F9s2vldNQgSar9ukPfGybaG/M7TlvPzV5sqZbHJvM7WZC9IU
	IRrmkicy6Y/+UmTcKIOC67GHSXt+I9HN4qzK8ouHdDCobLmra5ym/0i3FwtUjONR5jMFRHBZfxs
	4HsygkOwkFvKlOUBiobbPov5xjqhZ2jXiEt5lRviQqShAjQnWVg/ltO/WiA==
X-Gm-Gg: ASbGncvC+zRRvR9MS3w8fWAEqI9NT5DbRP+TYavem1l+265Jp2iQvOvIDn+N9hl9i7j
	X9Ey4FlvTAzGK0DZpXYBZ5Ux8ZR2NH3pKUZ6Y8z2Kv6c/S14FpRfhZmv228u6Ldyjfz/xETa6Ua
	FXmu1NGDTchxVIGlEBXKOUGxhluynMR6p+g4OtDMZkAtcsq/648WAlmUsVJ4/7rL2y8t5dw21PH
	SWVM/M9BdgnjGADvsxLNvujWL/+gnOQl9bZ1GAb/emz4F52AYUHP7aPzWG6QphKCcbFCguvHrSQ
	4QhgDCtS0VdH+bhqB06252z7IHT4CrjrvXdjSTST4AJZ77yRrn92AmXDb5nOBUVJP+106JJspvb
	l25Q4hPJSypgB9lgevmWcowA=
X-Received: by 2002:a05:6a20:394a:b0:347:1a7c:dea7 with SMTP id adf61e73a8af0-35a52789993mr6748073637.31.1763076599043;
        Thu, 13 Nov 2025 15:29:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe59CpeNjRSyNw92JEuQdzL8WkgOpZ7xPVnMY1vuZEtJlI/TUBl0nb1yLfJqJlaxIYROr9Fw==
X-Received: by 2002:a05:6a20:394a:b0:347:1a7c:dea7 with SMTP id adf61e73a8af0-35a52789993mr6748048637.31.1763076598546;
        Thu, 13 Nov 2025 15:29:58 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ed72cd1sm3049486a12.11.2025.11.13.15.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 15:29:57 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 04:58:59 +0530
Subject: [PATCH v3 02/20] drm/msm/a6xx: Fix the gemnoc workaround
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kaana-gpu-support-v3-2-92300c7ec8ff@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763076573; l=1529;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=B0t21POhzhnkPllkO0aJhsfTVayUVxYvYda/rajz62U=;
 b=/XPn6y9/sGaZJkUAy9FCP9e1/me5R2Ws/cxZiiYLXvbvNvzGaU1VsNsVvvUc5TDgOddrJMTKG
 G4t91gdKb/CCVOPapjdmn8NaruZHcRKYOt5SqLB3n0oACbqmHWKpKKW
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: -wBHf6oLGDltWCY45566Oux9AT715WyY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE4NSBTYWx0ZWRfX/mCyomYqD/mM
 1KALYpgyy4E7oOIXgh0yBd1jYmHttgallEBqJorZOSvt9xY+jipD2kbZmt5sG2E4LwznDiJuqmm
 pgYTi9Ii9NsN5nD3hVoR5JAJq+iV8G5ovsZVayjxNoH9K6bErffv8vnz1PTbmqY1bpLXay/dLxx
 Vy8ITQ3rujSDvBldkw14y7846wY/MeUJUzsCusi+TBss/UHLHxmXaqpPmDORnxc+7xAU8bQ/puW
 CyGlKqr4HlthtLoVVi3DCD7dubjkmuJzB7LB2Z360Trua0VRdL7phVQ99RrrTlqTSqIIvo+aaZ2
 gC/lJubJOLbrAlm1S0eW1UOCfDzNW2Qi1o8WqosdYF4ePRDvcWjXTS/QNGgEGH3nPouQHElBLh7
 I2riO3vRL91WycQYVwX7jJhSZsSm8Q==
X-Authority-Analysis: v=2.4 cv=MNdtWcZl c=1 sm=1 tr=0 ts=691669f7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gggc3m2WwWe7Cuz57AEA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: -wBHf6oLGDltWCY45566Oux9AT715WyY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130185

Correct the register offset and enable this workaround for all A7x
and newer GPUs to match the recommendation. Also, downstream does this
w/a after moving the fence to allow mode. So do the same.

Fixes: dbfbb376b50c ("drm/msm/a6xx: Add A621 support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 4e6dc16e4a4c..605bb55de8d5 100644
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

