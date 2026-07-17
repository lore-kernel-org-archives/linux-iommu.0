Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9042B31E
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299593; cv=none; b=Heh0zlvU6ySkxQriKX1w0g8h40ED9/NLwLlu918BaoMJ6lXLQVUr9E7VyGnifYDeiy4RQxJ9P96vp8hPM4EEtkyX6bZnbke9Eb2F9BximMSjm1WSroG9Dj0hOFMwGekJOMFUmSyKqccYrHXWkzKJ3Q/qSWuaoQS+XtQt2blHgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299593; c=relaxed/simple;
	bh=Q5Zhxh+S9+V7GhxrObo3WbR4OQ5znsS0Y2jHcq5ulvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnrJchuBuhXVnP+Obg2iDqeQDc+700MibtUSBbHPfRuWzcaubC0fba1ZEKmAT/C7byxMcEf5H14Sqx+zuAGjmnHdkUEw+elfmdSbLkcs6pPKP8w3zlBnYvFA/Vpg6mgQQ4lQztFIp/u01ZRZzxGlc+4tuPkUQZAD4MlkcgV1yJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WpCJWEpL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AUMuvIfb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WpCJWEpL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AUMuvIfb"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE7iu42186819
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3uivIe4Q1p6
	JPBZcaMSYc8eXAUuOqshf8Fsi7jMSrjw=; b=WpCJWEpLxEptXN7UO3vw3bvMR2s
	WRsfv2IGmIYdeQATdBtLosTFLH99BDeuAAaQSZB2qxOkaXZ4rJ61owpQw8jmaRFr
	VHCZGP9Os2RcJFEbBSA7yF9WCHyXImihGmDuaJK+UQHxXBZOC5EVmn1jBvPbXm6Q
	mU1BvkjTk+jfb2HJpBszjq6Ul5iH0lPcux9KE3bDLLlOFK2MnjWz05hyKOiSPamR
	z8bjLw2ZYGS0sfJkwPoJnuobuF+vTsm/o+qr3Ou/pY+7d7JeTlI+oTxbiME5DrmH
	GvL0B5LiaAcmcWZMVjC4dg5UI2ZyuWgKqwe4LI5b2P+xEcIwY4WZwC7YSkQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffd3ata4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e695a3b28so354557285a.1
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784299590; x=1784904390; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3uivIe4Q1p6JPBZcaMSYc8eXAUuOqshf8Fsi7jMSrjw=;
        b=AUMuvIfbuUt9xaaGZy/llllTrAlo5KZvn2rDgusOPBwmTxF9G4MBEedxXx2SNGH32q
         GHlwq8dAuNmJuhlf8bL/DB3sFsJ+IfxuBtXEQ/7W0St/n1Qm/Jd3mPq6rlJ5dbrkce8i
         apv/RFeSEpAXlFwOdnmrZxtBMK7hq/1opUU/Pezco/Af4tq4gdcO8Y6G2Wfa1AnQir46
         xamMK88P9pNuft3eZAZRhNSanxvN7TKdZnHXs0ySiw7dWX9CBvVamfw16rjOMupEoQUa
         9Vt7+yWR1EFM/G+SLzM7aqDdrSs3lBh2nI62R9yZTXMcrsQe2xy9e20v5jvKesSkSCu1
         58UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299590; x=1784904390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3uivIe4Q1p6JPBZcaMSYc8eXAUuOqshf8Fsi7jMSrjw=;
        b=idvOdB+wkYlZdyiqheC8CIOpRXXL42zKuvq+ObuanAk8uCPzLfJQF/RuDf7WmBEFJe
         S52AJV21wTzRtHd165qhopYnA56KYqrLmIPd79dmNg4ZLYUBnkDO6UkJjZI+ZVpMbGqi
         oo2bisqYnUU47fEebVetFmY/z9X3vsZvfN65koj+MPTkD0dajS6j4LcIcZ35u+fT6uwt
         dO8xaw4xdZMR96QfCH4J3pd114SE84nEoc3+FY+vseftv+QCQGdiZ2SCCaw6G9AP9WN4
         VuZeU6qb5dfzN0Qfk4jrKFmDil3lPxeci8GRUmIegrdyuEFn0QaQ71q5asnoMtTA0r4+
         9/vg==
X-Forwarded-Encrypted: i=1; AHgh+Roi53RyN266oEub++mDxybmOxHO3kbkrdqxSRWkYZdM2SeHiczMxttZag0YqEnrMqqNp4h8DA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEaIucqP/RX6/mM/V4XNOwhcc9yaZRsKGXeQBYEAz52JFkLUrf
	Bsj/qbC0aXAURyRBhEMzJwOhHBwKTZbqMx68G1XbWzqJr8tST4K9Dc5tf1vmo7qle9zWnqs//rA
	PSkquLEWvvWpWunGbSGAnWKy1iQJ5De2RMueVTYmralHm42ejrOg74dvA5g==
X-Gm-Gg: AfdE7cmzdYDvZICJVLAAWmRqjGBNbrkor5hCNNnZutRJHLS0eS0+DzmEF/9Lso3QG9I
	M4B1cnaJOItCAOJioI1ManepoqF2+KuW7gFhPKSwTio+l2qpqnKLGA8WQQ8myoZOfaV19fNxqt2
	W3BNeh5nV3nf3ARH+wJAq/nsthXbS9chMjjxnIoRkgR3nHUvAVKDxXXQsiKZxz8baFPHGyewnto
	rvBJU9buWdZC0R28hGVcnY7ywsDnp8oDSvo6JjO2YXJj4DDyauBsvMcWGa1cchNbNgJSVPSPP47
	CjrBLuMGddL40tNzzayuFeKR87yd+LiFr6VIE8Jc90X+xAgBdmZgDkj4ruQ9y1q/64Q+JSPjCe8
	iW+oJCcTkBNtyqh1hK/Aen9LJsg4=
X-Received: by 2002:a05:622a:410e:b0:51c:fdd:f040 with SMTP id d75a77b69052e-5212b63cbeamr29077451cf.21.1784299590327;
        Fri, 17 Jul 2026 07:46:30 -0700 (PDT)
X-Received: by 2002:a05:622a:410e:b0:51c:fdd:f040 with SMTP id d75a77b69052e-5212b63cbeamr29076931cf.21.1784299589793;
        Fri, 17 Jul 2026 07:46:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52149a3ce4fsm13414801cf.0.2026.07.17.07.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:46:29 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Alex Williamson <alex@shazbot.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2 3/6] iommu/qcom: Check pm_runtime_resume_and_get() return in probe
Date: Fri, 17 Jul 2026 20:16:05 +0530
Message-ID: <20260717144608.3216274-4-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX3jHPL+zXytQN
 3RdQd6FWup8kS/im2vpOiQ2sdZtiE5Eu8e4apRm6w0j+78hjNtjvfSlc5G3RZgLtl2MCnBkge+z
 tZX9gW8DEbDz26HpZq3Venz2DslcRak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX6+1OE1uVOwuH
 qt46YTS2lj2YyDPzeLBM4CdrICx0YYZlbmn5TjgfAl8pTM1DAqiNj4frNfp2+zVm8emPzIiIuP9
 NnWiN2qC5obvVtU5kCRrAkzYiWWwpuTOPZytRw824aTuZ7ms8XPmFwHdNvL8xPVgTzdcF1vbFni
 rEoMxKwV9l48mC/kuBhZ9hh5fEYng1U0krn2NFOPxMCVQXAeFDQtyEALxw2ZkwXipZOhw9sWXx9
 0IwBdhyShBgtDgNI/crkF0vGq+rC62+BO6LQm+P8uWz2wo8QPwiLIlxhtRpqglKvj/P6qysPPoU
 8zBtrK0NozDnaDiblug3T1KpCg/DHnxN85mZ/je7j7ygKY1bIbsGpgBwERm20K7hDpjNznjcD+C
 RWwNy/NnYvJKA6mY3nHHRPb3ZhCSeoOxD43Ao97YXbZ9Lkg32iv+Om9HfSgN945tFig7ecDy9io
 DllSJ8G7GGTDs3UaC8g==
X-Proofpoint-GUID: gz-UbNBif95CvngGRV0oTusiinuwnb9r
X-Proofpoint-ORIG-GUID: gz-UbNBif95CvngGRV0oTusiinuwnb9r
X-Authority-Analysis: v=2.4 cv=e/M2j6p/ c=1 sm=1 tr=0 ts=6a5a4047 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=uh9JkKNIBQsmCcNjqRkA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170150

The SMMU_INTR_SEL_NS register write in qcom_iommu_device_probe() uses
pm_runtime_get_sync() without checking the return value. If runtime
resume fails the subsequent writel_relaxed() would access hardware with
clocks potentially disabled.

Switch to pm_runtime_resume_and_get() which handles the usage-count
cleanup on failure, check the return value, and unwind the already
registered iommu device on error.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 71251aecc292..1d04f0a19124 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -861,13 +861,17 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	}
 
 	if (qcom_iommu->local_base) {
-		pm_runtime_get_sync(dev);
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret)
+			goto err_iommu_unregister;
 		writel_relaxed(0xffffffff, qcom_iommu->local_base + SMMU_INTR_SEL_NS);
 		pm_runtime_put_sync(dev);
 	}
 
 	return 0;
 
+err_iommu_unregister:
+	iommu_device_unregister(&qcom_iommu->iommu);
 err_sysfs_remove:
 	iommu_device_sysfs_remove(&qcom_iommu->iommu);
 	return ret;
-- 
2.53.0

