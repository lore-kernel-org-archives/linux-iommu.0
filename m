Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B243B4A9
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622557; cv=none; b=Q1YpbaxxP9DhrINwtTtGnwYR65zCmaBJftFFcEvqow70tpMgBwRbd9gQSU+Y+MWoHhbqWTbJaI7qml5jrH9s/gAT1Ml69Ar1w60fNh5+gpeHARVTRQIFA1J/0XVvTZFuijftYqVplRgbSdTkHjUI/36Ipq6OwybxvMxy/2668W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622557; c=relaxed/simple;
	bh=49NOvaGVwlvi581GKoxSpuUe/4IKdws2QDL7UFNjgdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JE7/fyUvxnCICjDOsk8d/PCFl41mVPlcwfcFqJC9CerDD5EEXJn+6LLIyXxLK0R619Vs+cBaqvQlgp9QAikGDe2W+cJJ4ihLkeavuWryt4wdM0Bt1cSKHktqkkyYlVHI32R/yl/tij561FBGlV1Wp/ue7M59htv/OQ6ZH9GVpls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dAwLOPUC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GccRwRdm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dAwLOPUC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GccRwRdm"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HX3UV2295179
	for <iommu@lists.linux.dev>; Thu, 9 Jul 2026 18:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=; b=dAwLOPUCN4+fS3FY
	zSMbQj1VkLrgSvjf90D5Pv66M0wHcSeFsoCjPd3BuNGPPzjo4gq69Zr2EPuf87+q
	xY51GcMBq1NbBDYfLCy2PY4fi7BdQ3iwUiBqA+zJyxKyW6zXIdNu3zj2XEwihOg+
	NUfgX5QVOrcv7xIlGsEMRuE0LbXPRUnZsMCDlCmaLy087f16esmgAvpimQ6i4KYM
	aLgvtof5MdJeIJHSaljSMpo1NHxzwWTcs59aQA1+pGWqIlktr0y3wh/2TuYVzq+a
	tceDmYbcefwf6gkuY2BkT3dlAXVR6+gUlj9iqSR3Z0x4Q5Rrl7ZsY+R3sksmOxGk
	JoWkhw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vkqf8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 18:42:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38c7e26ecabso185334a91.1
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783622555; x=1784227355; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=;
        b=GccRwRdmRcAYxRPZnEqxQCZaprL8CHlWXWCtgn35DOsdcfAHWphhdcoBvL2ib7vgLE
         qZyCVO/zY+2KJyaZXnTPivOcm+UmlPNbT2BYetew8LM+73WRRzFUkafAdf/MIjUy+YMk
         HYnzE2d+1FLwoWtyN9EPHEp2SHxiGK9Jn7ySa8Y8dy50yjyYS3xYcK5HlJRDGkHx+ZJf
         9+Awbh0PKQ/QokQvaBPV9JOvLgdyFCC4AU39h8DbIzD8pYfY1hQRqqcLuEVv2HDgXf4a
         /RrL2QOdqBbnrzRb1e2hFIZxUrR8GpcjyYkBb7PkV8qdcVVE/YxZ8DSmCoZ7auwOAq0X
         Gpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622555; x=1784227355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=;
        b=aArj25uTIEiFGOcHf9mZb2aIOr3NkJ/z2d4HkLu1TdlShmLUj9A1Zyfq8Mrt3QVp4/
         HKTCf8/wYFZc9a3ZaZMlbzpPEzVQidRRyj7T8yLKA5aQsoHhALKOrJ6wWkBT3gLRFMY7
         Zp9oKsV14vrshpXe1pF0K0GhDDivrdZwOkOBHX15I36d5M5o7T6U+UWh7NQ43mxNphh3
         JKEJIMTE2ATsHVW+X4JQZcCyzs3OBgBGp47qVO8guQD5STTDJwQekjeIzezwudoUUrem
         xn+MlmX9hixjjPd1xdd2bH32q2cXnenLXhXgC85xn+moARGExY2C0PdmeChehGUT0LjY
         d+kw==
X-Forwarded-Encrypted: i=1; AHgh+Rqso5SuTNjOYsdkPmWv4HQ7zIIK54iLTjJAR6WXsBynHzn5BlvE0zKm+Stxcv9EIvDKo1H20Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxP29wOM/H7pdRnJiSbsec+zl52kAGMnGkxX++TLHxRL0NZjyzR
	m1gjyaXCpn/U5yZgHX850Af5i7zl61XqJKVr88WkAfw1uyDZZbAZEYfcfotYch5JLR0hfXcHGd7
	Z46WHyfDhGjJcm1e/Gs1UGneTVUe5LZAyYGo1Pr7cbl7+nYb9zwMHvbY6Xg==
X-Gm-Gg: AfdE7cmnTC6uo77Z5ru1lJUOmc3/A0zcAN5jnNrNIMjDNnoj7GSOMCwZROcrw1YvJgB
	WP3jbMGvuCjI7/IY0bfS4nda0VVRwaz0m3/V7Sf6MoqEaz1ncHYJMdWdlaaUNnL7CSsRQn+0XTI
	owsPYiR4+pe4Q6+J/l/d8OQzM7uY1rOtQ4fxefSNBem/UF52n4Nco4oETc3Jz4qNU7/vw53jGFT
	Nd9qR1cEqPeTkXp7eXaIW5xSshs4Eo4WWMC0FZhI37azJdQ101rdhqd+I8O5Mh8OpmR51DL/Xj8
	fGz/ZFNSKvfoi9hbl8iBj6L3iK5oSAmm7FH7qfju5/0CuSCTZxWu5O/+UClY1CRKjN3hRTj5wJv
	5AlXA2+YW2G/FdXdmjUcOLPQjeVrL3ETciRA=
X-Received: by 2002:a17:90b:554e:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-3893fe5d587mr9351774a91.14.1783622555152;
        Thu, 09 Jul 2026 11:42:35 -0700 (PDT)
X-Received: by 2002:a17:90b:554e:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-3893fe5d587mr9351738a91.14.1783622554713;
        Thu, 09 Jul 2026 11:42:34 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:42:34 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:00 +0530
Subject: [PATCH v6 1/7] drm/msm/adreno: Add support for A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-shikra-gpu-v6-1-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=1210;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vmi+IpVwDwItd0JsdKwDI4X0C7GvFEMaBv3VFip4Ixg=;
 b=nxXrfXueHCc8y0f+NSNb9djpV2+XQhcnHRgE6tAiSlaz/KzrkKd70ZDgPVMGFyhqmn/+r/2aH
 qjx5RZWOQQCDnIJSYqVVjc9IR1xwlOARTfmr7T/GKNDW7jB80rJlUhx
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfX5viwXzw4Q0L6
 nnlyBuhyvFVXTWVGQUennlhf+en+p7u5hhT8z0uAyTR+nhgOpNNahwHrigkFhysU0J4UeRl211a
 VJKK7GcVQk+9PARH/PXorhsVezjqKSVRVcPuVdooBBHsujVzcl0NYZ5KPP4cEvy3ds91zaygWQW
 Qfs1GtWMLx7KvfjZw0EB7yPjsvZ8rQ7XbHJVBkLj3tjo+bEHu1grTJulMcRTWPGVLpugYCk+D93
 gMDHwMHwK+llADeIHnqHQQ4/AGILh0R9Dvid7AtqUdcEpBhDwwCmGg6X0UZZOQXpCANMWRt5194
 LbLiB3dJdukNTpNUt6l1857jKYVV1bczPjuDy8Ws8+Tjqwfiw33kPYIoEQhY2SxPQaxB+u5Zjfr
 1xxG8MQ6ado9bU7+/CQFLyv46IXvz7IQUcc7unfUMzMsAggv2yeW+i4BEoE2xYO0ohXLUba4fAz
 8ejqE60M48FLyMbyhCQ==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4feb9b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XFVbiEAxaSnpWCc0n_YA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfX+Bck2g2oEqR8
 i4IuY7HCsNP2NXXVeEBlhIyND+fTUOtgFfHdbrB6mXM4ct2jJZfpp8XpF6ulOLQ763XHbCbOzOX
 NFgNZWpXzfJce3VcuxtH2EbuYyOl5Ok=
X-Proofpoint-ORIG-GUID: 3PY5XUXQ6mnMFyHeIr3in_DS10jiP40l
X-Proofpoint-GUID: 3PY5XUXQ6mnMFyHeIr3in_DS10jiP40l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090184

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

