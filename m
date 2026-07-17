Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1B42B72A
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299589; cv=none; b=b7WxFga+ba1gtOJT9gt/GcXIT6Zf4GjRYVlWVcVdgWt7wztSpAbJ5tJdWnX5N42k1/2/umuCos3VWue65Byv+qb+0UwYTepSyaog0m88S97KExMS8zNNRh5ea07Jo0O7YMCVoILURjIGNnrXU5MC4/XRwQkUSjI5RDY6yN1237s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299589; c=relaxed/simple;
	bh=SHMrIaS6yHyhN7hIfNsSI2APEMkhBUx3UNbQJXjB6Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQjq1J1kwGaSndm7vIrEQRJEPz2saPlQo4q2S9bTyyYzr6PAp5rUpPpnxvUQbNI4bBAVJ7VwYhjxUY5rnVZf445lKc8nxYrDJv2Jd1mNj+qluudqJvf9TvGw5/MD9qP9GWTORohuVrSysneYmoa86Bj/+rk+vaKRifakToOKUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XLhoDabl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i/FX2007; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XLhoDabl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i/FX2007"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE8Lfi2123393
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IJVHSO1u6a/
	Hfz7sqtNZdF678kjFyDUjw1u5+bJ5TaM=; b=XLhoDablxd/mhdo8ez1693QDxIF
	71qWgd0edCXFj0Rz1v8wKBbgAhCquMMXNm+QLqj5/FAlDufws9TACRMTd12vW2cF
	ylTN3CiwKhIUtZ8OMTz0I0UgauYIh/7GwEXI99vvk4/Ub81O/SFbonTsaq2dyzuI
	HFLJUEffr16K9D4irXhtqDpnZQY6SZTPpKZ5mehuhNsxFjMCFNYxz35TcQUT3Qjw
	veTT7Ikt6A1FvwSjmkTcC54cAy7oDD/kScH5rEL8td6Kni+fD4ZNFNfXAIzlZRpd
	HbBh7lSYfARwPIaOu+Y1gUSdTjL3q/JUpukcqVVyjzBkptdPkSzttD+fW8A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffe0ut6es-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c21c01cf3so98152521cf.2
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784299586; x=1784904386; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IJVHSO1u6a/Hfz7sqtNZdF678kjFyDUjw1u5+bJ5TaM=;
        b=i/FX2007VC4nJskR0MaIiav6RVdCz+gAiht8BJdsbfAAfYKR2koh7f+v7LpQvRV4D8
         vze9NLLed/TPXHleLg8ow+wYReAw/wE6N05ikMd1Z6TnM/h0w42qnyeFX16ximfwXEKe
         g7/WkQCKK6kdIVtMV9BZAmcX71GZEfmpPM91uMGb6PhL7S+7u4Zi2WCEIaxsLpLFpfGX
         WOj50Iu2l6MDy53XupMo2nzompJuiv+1joQ2dArr0lTgwqbuYlKKrMa3OtfBMOzP00oT
         dUDxUaWOkn0sxhY9j0JLETmu+QqUyZ/eqjDakiqoozWqnhkM227oANQt5Nn7jedrc6Nq
         U5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299586; x=1784904386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IJVHSO1u6a/Hfz7sqtNZdF678kjFyDUjw1u5+bJ5TaM=;
        b=FcOu2D1kwjdIeeZltKOs62naquR/qwMn82QbLtG8JpJd27q0NOLRFMU59JnUXpHnax
         f9k+GfNvFiqHivE/8EWVjeyZ+o6dlt926a8PvdAr2RpaPsnOua16xVxctcYt2kOxgJmV
         qsLVZpcMi0D2Bk07BMrtbrJWQeZ07op08oDRyyePaeoTTmKlkd4MdOkB2J9XD6YyOrFO
         30xPyNGsaYXaXXj0m7F5nw7AB3f0UToeSfnsfyeNs0YGFveP9NX60QiT44bLY/AufY/w
         5/5sCGM5mnZHGsj5v2Iwn91SoytDircc9iXdzAr/BDqGblgV1wVogQQEHgxYWFWTHdRN
         ODlA==
X-Forwarded-Encrypted: i=1; AHgh+RpTY1DRcPbv/dUynsOUMNF2yXxY+mtfPAGnVHdmGhuGZyL+uTqJPrs/5lRjmDtrv2Ljhn0dcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkLilwnl5nrFlfHq2nURnhaDPGrR0zr7dihj8J+UyNids7y35I
	r8xCaKWSFFAueQyTSqXl0c+Quql5S1+1OqA+1bVbBEDSIEhEbKCv5dfid6K2owtw0TIMH/IDomO
	v4q+J6jjHebXdJT29uQMsOS+agH31o3v+eP2w/YcE61UI0NOV3t+o5FmNyIXnBuQnIg==
X-Gm-Gg: AfdE7cmobi9DHQ+y+elQhfsGX8rYR4rmStV5cGjmkvlka+kR5aD2E3hfVIj9V9TNgbQ
	xOpmvseRC5k7y/3pE3ZwdfF19kr1wpdtpIEs8qLulwQE53NzFs+Idr5jEb6CVhxuPoVp7cODAvR
	zeLmp3nWM3WrGbeteCLmmfzfh4nOK0iGsv12ldLl6CbqiMM6zIZ+ea8PXgcW6DaqGHf1v9GmrAt
	9ksVYNlwiS0OAoFCMU9FsBWY0qaXh0OpfA3yCm8BfkONC9Fnp0HE+P6pmX2DKs/Lbnh1c/jgIRj
	qj/88GM7hXe0Yi1D+fpZ7lhtc7jfXkwSqRKzOQT+XZs6rNIVBJjK+ekeWVOEg2FQaJblgs3/ca0
	c7G1RmDhoChil9iaILz1WO9gpeOY=
X-Received: by 2002:ac8:5913:0:b0:517:6631:101b with SMTP id d75a77b69052e-5213f66b7admr24607081cf.55.1784299585617;
        Fri, 17 Jul 2026 07:46:25 -0700 (PDT)
X-Received: by 2002:ac8:5913:0:b0:517:6631:101b with SMTP id d75a77b69052e-5213f66b7admr24606711cf.55.1784299585126;
        Fri, 17 Jul 2026 07:46:25 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52149a3ce4fsm13414801cf.0.2026.07.17.07.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:46:24 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Alex Williamson <alex@shazbot.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 2/6] iommu/qcom: Use devm_pm_runtime_enable() in qcom_iommu_device_probe()
Date: Fri, 17 Jul 2026 20:16:04 +0530
Message-ID: <20260717144608.3216274-3-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717144608.3216274-1-mukesh.ojha@oss.qualcomm.com>
References: <20260717144608.3216274-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=deWwG3Xe c=1 sm=1 tr=0 ts=6a5a4042 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=ZhKRi010OgpVv_9PQ1gA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX4TN0J+VItv2k
 UtzO/81Ho34NOUEd3nCCHhQFiaOst741kMk8IW1kIve7FFr+mLORGHhigaVtwYeN5svTw0U9YOY
 wE6wgVyCL3+TJrwwpGwfKHMNs5a8IJfymBlFnfCzcFv1uaRbLY8fmA/nxxJYZCehR9o1rU9zQ3u
 RitlLgMkno7opSPJvtuJSbixEbzMAOBAlnBy94FEIf+p2YNP0rGMtR7zbG5T6iwF/qAqTJdzuph
 C9+jd0BqfvE8XfTVr2lSEcaE/cz2Fr5R+p0U97YrvwkEqSwPMvXeX/0RzNu08cMPFTfF71wI0lE
 09Xh90XEBLWP0fjNC1W05QZ9kN5ce+NuIDn9qHGG1ldpaVxHk1aE4cVkqnwJgGPc0pW2iGNcjbV
 qyKJImAEC3ZD+OhNLUflikKy5eRrrduKgIcMWUzm3ofStR6uw6CT1JPwxb7RMzpc47QAGqbTbMh
 Zm2lZTPWp00fHhCagRg==
X-Proofpoint-ORIG-GUID: Q4RLAWzwpl9DKuiSYeIpF1Kb-fymtnTt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX19BfYYHxbLPm
 Q3PXzz4UOds8+63Hc9d3RZ6aWC5zwt4fr5XFNRVYW1OPdaIF+CM6PC2l3IXTLYcx2AyV2VFo2p3
 oo+msbbhn4lSi92y03Ah67Mif2eYP2Y=
X-Proofpoint-GUID: Q4RLAWzwpl9DKuiSYeIpF1Kb-fymtnTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170150

Switch from pm_runtime_enable() to devm_pm_runtime_enable() so that
the matching pm_runtime_disable() is handled automatically via devres,
both on probe failure and on device removal.

This removes the err_pm_disable error label from the probe function and
the explicit pm_runtime_disable() call from qcom_iommu_device_remove().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 09f2ee6be988..71251aecc292 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -836,20 +836,22 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, qcom_iommu);
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	/* register context bank devices, which are child nodes: */
 	ret = devm_of_platform_populate(dev);
 	if (ret) {
 		dev_err(dev, "Failed to populate iommu contexts\n");
-		goto err_pm_disable;
+		return ret;
 	}
 
 	ret = iommu_device_sysfs_add(&qcom_iommu->iommu, dev, NULL,
 				     dev_name(dev));
 	if (ret) {
 		dev_err(dev, "Failed to register iommu in sysfs\n");
-		goto err_pm_disable;
+		return ret;
 	}
 
 	ret = iommu_device_register(&qcom_iommu->iommu, &qcom_iommu_ops, dev);
@@ -868,8 +870,6 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 
 err_sysfs_remove:
 	iommu_device_sysfs_remove(&qcom_iommu->iommu);
-err_pm_disable:
-	pm_runtime_disable(dev);
 	return ret;
 }
 
-- 
2.53.0

