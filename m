Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E334B662
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110938; cv=none; b=lg0irGRUufK2DesF5/I7Xy5G3/YzgrttYxdqXPjiur9ayhUt/u6syZxpU4s/F1E4uxq7Nqv8OGI9JZCPeRsQ/2KdBbhvQXU+teFHJD8BWoas524ZkL9MEGLZoWKtzOfsuMmSPW1wqu6GK4eiyDYkw7CdvTpbA/95xKpFovjAZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110938; c=relaxed/simple;
	bh=49NOvaGVwlvi581GKoxSpuUe/4IKdws2QDL7UFNjgdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3olFJZZ3KpMOt10Q/wMdXksCeKcC/o9zJooHXs5R1zlZA6ZvF94TMazINyAfSd4vEzAfywkfZCkDaFJvF6s2PqZUdIfKY404SGpPhYqaLGJBearvDh6cjiZkneXY7n+wRq1SnqkDCH6RJWROgbtdeBmBsa9lPeGlJ/KiHAyMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QK0bT6ac; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=goWZBvWp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QK0bT6ac";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="goWZBvWp"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KQ9gQ889500
	for <iommu@lists.linux.dev>; Fri, 3 Jul 2026 20:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=; b=QK0bT6acctMmVRcC
	2/da5Pd4TXGhQi4kOuWThCPpHrSeU90ccV7oPPbEG/ts6Xwajo54zSQS7shMXiVf
	z90g5tuSbTLKlK0r+3Bpt+Woe9V5rm0OQMqW1zbBFCpaTITAsTBeFZKUTBRXc3gp
	Aw1lsRCA1j+A0wJ2aPqhSjkvjzJMR15gBUCHJhR+RE+axWX3+lmfVbNZqPEIqOgp
	H+Tns85ndROt4nEsfLIYKbPGq5wDmrxdCygCHlpmYqMJLkN11fX2/PAiTyptGVyH
	jjLA5cauqLhul+JvsmQQ9I/SwdbX4KhLdw+fMl+mkNOZ1lGTxKMb0xKH3N9PiM7R
	5p2wPQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682btv58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 20:35:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37fc66ee6a4so1541481a91.3
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783110935; x=1783715735; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=;
        b=goWZBvWpFeUF7B0i6i2He1TwT+llzGIPEDjVZvg17tgMp5JnunsiRAMJOS90fs9ZsH
         lJXxjoECFxnD6m6MOlf3HdwdSDp//xx1XOEIUKX3tbXTVW732V48tyVNKGQ3Z59ajd3c
         Bdd3EcF1J9H6GN1AnlKvluWJVwEtYFHZhCwIx5ejLSVaXzkghh2c9PiqiiK5gn6pGMw9
         BzZTicv6jYMk8CMtPX1hYwc61M5v0NaW2gnV4ds5T1GXBUfsUW3ioRCWdoIq0wS9IqEj
         aEXDoHlOdDZHdRGAYHSKPYIUA3gHzmWNiA7UTIXjrliPDhrr1i4vH+7hrfcAougpTtH1
         mirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110935; x=1783715735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=;
        b=Uk2NKlcy8PHDF8CtJM5MWdgeULn0TuILoQ4AHM3p+90JvFt/JH85+cezThpZAWoQAJ
         /SxoSUvJ8m5ZmhP/I6eQANSs6dh8tzoGEnCtgeJWfnaqrFqBPeTURjGHLZZjIjg51y54
         Pqfh8armLkRTMX1nq71u6QwrzoJbMELhg5Rf9vQkUJJztFy8l/CL7l4Vk5xwAxrzFHtE
         YdhqG6Rav45uYoHMyvt8VaUUPRRRA63mNPbOVVgSBDdWSSk0/wU5RZNsaon5vNcNnaJh
         jx3yVdxvEd+262ZRHsdxJRq3JVgQDXZo4AvBofOQEkZAC7rCeRMdL4aTMJGyAni1f0gG
         4qTQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzaoPumVfcci/I0scbXCsG5lwFFFWlGq62rg6B30n0otcQaSKROX1TgTaciXhrsvSqNVM59g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqvfP/X0dNwusOl/cpLjHIJC/meXDbSxYYYeUpBDy7+nIV2i3c
	2y+0s1cHFeGAYVE+KNUJKH2fchDuXr6cpJX3KZ7MfPmDWKgh+/4eDnulyC7R5eAEb2onO00Qvk8
	EMtzpk/LosGDlixgGsuBf2g6EU+Efn1omSAIUtsFl9bGtWizAy97bW0nTIw==
X-Gm-Gg: AfdE7cnkYlqiAm13/Od6TbgOlpAyFgCiHVx0P9F7Plh3Rerk99g1wFND9BWrJzrf41g
	5BNvTiic6rmPG1ev8BTVXCzvPy+RvAGQdz4UzvqXQCQhgIDcUgOgv1n8aq66S8Lvu5l1Kqnvbr2
	/u+swmhHBm7NcMz4tgXMIiCxFlq9sypivHnaKuexUCk0JeRMXHBsZkb5wt+PyCsl/CriX4iZt57
	cS6HWndDtwOZhaswf0VgfBpoCZ1eCKPfThbuxCd0XX8CJI08LbTypRkRAyyGyS2HkBo7nWr4aI6
	g57lWBt/5MTExkQJPECN+Z6zIiv0yF+ie0vhv64zGXv8vDqPCSk5lZHQwXMAunk6a07qOhfUW8B
	+H04H75E/8ASE8udw+KLKgBeZlMey2CsXsUU=
X-Received: by 2002:a17:90b:3c0f:b0:381:939e:adf0 with SMTP id 98e67ed59e1d1-3829fbd7827mr851925a91.31.1783110935537;
        Fri, 03 Jul 2026 13:35:35 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0f:b0:381:939e:adf0 with SMTP id 98e67ed59e1d1-3829fbd7827mr851893a91.31.1783110935077;
        Fri, 03 Jul 2026 13:35:35 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:35:34 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:28 +0530
Subject: [PATCH v4 2/9] drm/msm/adreno: Add support for A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-2-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=1210;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vmi+IpVwDwItd0JsdKwDI4X0C7GvFEMaBv3VFip4Ixg=;
 b=cN7pn2+JEuwNoT9wv704PT5FWDf0yxNfWzcSdWVP2z7Sjet4xiZVOgeM2KvXBFueaSmGt4kuy
 CcHPa+9lH75CVOuJgzKjvkpem+q3xyNaj1NqF1nIpvU+/j/iI6FWZIZ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX8GzT4kS8WWw+
 RLmgH3a/Q+NbGQ+sQluXZL50qBkFtotU10nZhrFp1fvatskRPRLhipoicmUapcQBS4OiFxVQWgV
 1s4pcc5gWjGh0qLX5dXjzbok0IvbYKvzVNS6kX2oS13JIfXO2NgBq+Bi7GDGAkW+yQEFG2wdDmE
 t0hW6ZlIT0Ea7baCqT/xH4fIqN1GhzcU7PXak0MAMKqR05iiGbNOIEik0wP3SkJzvveI8W2oKtb
 oRVFyW8zePNDpxu+pDIguJFjMBGWoWb7A6mXYH/eix0SFjHWBZa9ZNKCivpCHXfLI4LdH9xpN5D
 T9zuhp8cw3pI5v9iXH1J9tHdJdE9kG4a8nxoArYEr+Z04Qfc1cyehS8eBb/ZfWkpkFru5o8CDgP
 gLjcacr4EVRKSoxxAQ6JdV0dGkr9pwpdITIn6i2CSWIbzTLqnCpnq4mVAXOg5EoMtfdY8js4gw4
 5KrkuPAFR+rH28RFy/g==
X-Proofpoint-ORIG-GUID: k1FmMEN2mba7GvpPQagOf13enDSMyFrF
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a481d18 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=XFVbiEAxaSnpWCc0n_YA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfXznlZFngMRq6N
 lENugt49Ju93PSpBrcfEH2m6NHDqWHD15BxzAYw6igWEOaMyx4XC3I8BejBZ2pxndBnbM7qsvux
 C5po0fZ/Tqazjs/4sItaJZayy3ILoqc=
X-Proofpoint-GUID: k1FmMEN2mba7GvpPQagOf13enDSMyFrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030208

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very
minimal changes. The only KMD facing difference is the chipid and the
zap firmware which is specified via devicetree.

Just add the new chipid to enable support for A704 GPU in Shikra.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 3e6f409d13a2..2de3ab010135 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1454,7 +1454,7 @@ DECLARE_ADRENO_REGLIST_PIPE_LIST(a7xx_dyn_pwrup_reglist);
 
 static const struct adreno_info a7xx_gpus[] = {
 	{
-		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
+		.chip_ids = ADRENO_CHIP_IDS(0x07000200, 0x07000400),
 		.family = ADRENO_6XX_GEN1, /* NOT a mistake! */
 		.fw = {
 			[ADRENO_FW_SQE] = "a702_sqe.fw",

-- 
2.54.0

