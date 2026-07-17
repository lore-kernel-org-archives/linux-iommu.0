Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3742BC21
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299598; cv=none; b=eU1j2n0k5jFiEKCU9uLi/yIkeMWQzOn+vi2PxoF1LYC8tppe3+F4HVXT081KnzUfplnxY080Va+Irvr7CjkNsnJK8618ASw23hwsSjtGRazwayOVoubBK7gvSAJL88S3/CMBzCCZdcsWgi+Jqipo2+nB6mBnxB/DmW5v7VXnHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299598; c=relaxed/simple;
	bh=+AcolqfqLs3ehzGtgYntRTK/C1Fz2e1x6L3BiJ0GYk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vl8Uz6BrsaOEWuQtj9gIe/n7ucaIrK5yJYqeCGJ+SIYdVCRZqAn0xtqHxjcunkqkBPIgmfv2Zr1Mruw1qro10EbGxTfjFLhFMdOaok7wSeESLcpLDiSSHk932Skt0juVI2VeUA1VTeB2zLn8U6Nuq7m+sZbC6cl4x7LwYDmvtBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WJSKGLFb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ze0QMkPY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WJSKGLFb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ze0QMkPY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE8WOl1677457
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZDrBspdOlaS
	i5AteoQZ2h1DwLsN0BlKCwWO7NZ1k6s0=; b=WJSKGLFbMyVOizPVAe1QCbntT19
	MjaP6YIp8+oldMH7QRfinWFpZeO05GYQUbmU9+heMGeJ4d6pK0yeOqC7TuFnB6Aq
	zZ5zBDaBLNnq3twuKzsduuqU11NVKvjSxrYINKLEmULA1XKihKqDOu9yvElFj9hx
	etdeG9h5ilAmb6WLNnANz1Shvp+nq3JAlZuiVoViWvNaqacmH4Ii0PAc7jXhXtTo
	M0MYtllxR8wnvNXMqxiwt/r+7bBx9MJ5ceUPXSYqEWAFkYgwZ51FQCRb4zhFbZU5
	fyRF7vNP5AUboPZWtpvbhBkg5REbUQX7Q/eSUrTt5euAICRC2ApqkzU5zqA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffj78s1he-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d30035dso97901771cf.2
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784299595; x=1784904395; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDrBspdOlaSi5AteoQZ2h1DwLsN0BlKCwWO7NZ1k6s0=;
        b=Ze0QMkPYU5hlzOu0yTJkUFoqhRxXgutb4c+2bUgCwkKQIhwE2kUL03yi/4pltyeOiA
         Dl+xfzF2gIbASm/A4PygGlx45gH9yRWgg3ATfYVu0eIXxQeEE8M8pvRgRi1bgHxxt7cz
         PMC4JXYnCroGGUTiWThw/y3TZMRvenAQPD8dhayo8m+Mbh80kTxrUWqqhZqzrJ1I32Zt
         ql9mmt7mwfZ+ld0S0hG1USbf3JCiwUpjkmNbKiZRbI7QBd9iTOq7yn0QE5m62fwNBRQ5
         OAWmiu8Vv1ppDUl11GiBRWEP09K7wlW31jR7P1b4M1tDVRTZmKwLn3p0s6DQj854FUlQ
         BGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299595; x=1784904395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZDrBspdOlaSi5AteoQZ2h1DwLsN0BlKCwWO7NZ1k6s0=;
        b=ppX/MTvIOxRDsa62fne194eHM+VtqKqp6O3+o+i9z6dsm0YRxXZAc8b+Lc/xZqmkof
         Y8XzKft8lJU5BZlnOK6ZIV6vfR6qraNdTPta/X+l4Fc4XKqMQdH1mZQD+ijv+fKC7K++
         w24shmkg07eyfbC4zFPrho02mwoFtnKqIUCdG3Jx9PhPV2+gqki0PGpqE1tt5I9mKnod
         VM4TB7rgrYLUtULSG2nXQiYEyAbOf9lx5iqPrzbI9x36hsylB9ZG14lADzrr/Vf0XBr2
         9j5OBcJ+XqIgQGfN3my3ipmZIfhypEBiS4uDR1ZlcMoOC7gxkNW6r/rn/Ms+nqJDQ+Aq
         QjYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOy+n/0MQepAS3hmG7UMxj8PSjDy7AHC17/b1toXz3jo6tmgGpYc9U/n+43xRUwq+QCR+24Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YziilAGgBUQRrxmvmAXP89e+8VUo5RYK8aQzUU6nunVck5gF3+o
	0LUceDs7occyUbsETN6QfAaIUPtzkZKC/Ee/4SySF6uXGShiShx8gZpRETIiKCWEh3Te/WTv+sU
	2x1+wwQlvxHBjpCcIO505qc1KnzbowtM/fQhSvswo0Zs+HyOSZk9kCv4A6g==
X-Gm-Gg: AfdE7ckGbf/zxC9X+XYd+B9/bQ4I5Io0fYS4g7Qed16i6WE+AE9njnQlBh/DZv9Clts
	8UhPG2Uf0irLRkPSCEAUAz+4kxALtr9V2yVKR2qXUelT1pyP7Anxf7kFjrh36Elwdlyo3BSOE2V
	xz8zevlU3q3vlKEJ4B1jX3XYWtlpf8K2Iq66aqSe7bfDJOPM6EGNfWbIDazA1jkGTTsNSVYN6sA
	4cayTlaqUra9iGU8RnL6uG9fQeBAnI19o1FG9cr+kiFQtF5OoC/oVBH97+b79CwSXQI/5lblDLz
	nJyUt/QfXwvyFtMurvF3I50Tg5wk+VyOvS2Tsez4GnU5GAiVEbW7BvWZKXoo/TKReD2Tr18kb9I
	0W7NdMxIkDKnPvWzI2w3EloSiiUY=
X-Received: by 2002:ac8:7d0c:0:b0:51c:94f:8ce with SMTP id d75a77b69052e-5213c201a70mr26554831cf.34.1784299595059;
        Fri, 17 Jul 2026 07:46:35 -0700 (PDT)
X-Received: by 2002:ac8:7d0c:0:b0:51c:94f:8ce with SMTP id d75a77b69052e-5213c201a70mr26554441cf.34.1784299594533;
        Fri, 17 Jul 2026 07:46:34 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52149a3ce4fsm13414801cf.0.2026.07.17.07.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:46:34 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Alex Williamson <alex@shazbot.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2 4/6] iommu/qcom: Fix pgtbl_ops leak in qcom_iommu_init_domain() error path
Date: Fri, 17 Jul 2026 20:16:06 +0530
Message-ID: <20260717144608.3216274-5-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfXzkC9zMbC8Pyt
 Mg5aN1joDXdOnmBjDEWovW9Sva47D4wLKBel4EPEZhXwItdCsxI2Pp5gODnmMB+aHPci6Qnifj1
 BW497BPQp57q+KiZmBZAK5rnrUYt969BrqupXI7IKXjC28SxZdAyaJKsu2CaVIFnA6xD8vgE+8Y
 CK1O5hstIxB+FZa6qmJhFxdundVvUToLAEnm8ig1xduCp2QPr0qF3bx2poB43N8wSt14frYPn/l
 88oa5A6fW2/v968zj7wumPDwyxTNHlkbyW9SsumogGdGQqmQ5797p1294KT6s6s+hUjEalsv/MQ
 4WrTYaO2KZonn8NAD7m4hsdkEN8MkIll4WtsOWBE5PGtGxXZy93p2iIke4QAKwrB70NdroMXUZU
 Qjxh9prrTrCprOWxWqFGYU/IPJ9gW0m2ECT1zbSkCCC6h/f/npKtIHonRxICQa8nI3ug4rKMTb0
 AXnKX06HXeAEXwwO4xA==
X-Proofpoint-ORIG-GUID: UuiqzrEqBk3rruRBnUFWiLFBBC8ZqE_M
X-Authority-Analysis: v=2.4 cv=U9Ciy+ru c=1 sm=1 tr=0 ts=6a5a404c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=pv9nQ82OMFi3fEhVMZYA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: UuiqzrEqBk3rruRBnUFWiLFBBC8ZqE_M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX8VH8wzNNSr7I
 D89DtxdPtZOtQuv0/87ZBP7CEsw5fczVhC9sAxcv6mfZmwUBpfjXAchGMx2m2hjGAnN2yZE+Zk4
 QirN8jFOgoZHweLI4K7FhwZ0cmjcmVE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170150

alloc_io_pgtable_ops() can succeed and then qcom_scm_restore_sec_cfg()
can fail for one of the context banks. The goto out_clear_iommu path
only cleared qcom_domain->iommu; the locally allocated pgtbl_ops was
never freed, leaking it permanently since qcom_domain->pgtbl_ops is only
assigned on the success path.

free_io_pgtable_ops() safely handles a NULL argument (covers the case
where alloc_io_pgtable_ops() itself failed), so add it unconditionally in
the out_clear_iommu handler.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 1d04f0a19124..222bb7febd03 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -314,6 +314,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	return 0;
 
 out_clear_iommu:
+	free_io_pgtable_ops(pgtbl_ops);
 	qcom_domain->iommu = NULL;
 out_unlock:
 	mutex_unlock(&qcom_domain->init_mutex);
-- 
2.53.0

