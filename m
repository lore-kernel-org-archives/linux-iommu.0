Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB753D646B
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217270; cv=none; b=Pxkce3IOYDBv1+yGkqhX/QPZzWkKhjdFpdHE0p4fx2+H1rsbr1/3DEK0d7N+XsPmT9ACABOT66/WxIYIY1GCv7VhO7h2Y4wLc03naTpTwcB2neFN/YRcgJPUryQyMKTqOFh3V1dve7Sd35hJc41WDT8qxmJ+ezMeka70Ra7S1rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217270; c=relaxed/simple;
	bh=loQz1tJcYMIGFw11KS+gtAGNdvAMNzaMxWhHX4ioyWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1xCzJyf2Xkwy0KZ+enHf7wO7S8EiRDrfaZ3JV/96VmD7G5xQKe3oEMzZKRYldx6CLuUkbv+WmfsGUkfQkQkPUTADj8F3yJcFkShCSOu3cfQlIHwCPwE1vMNO9dS9vgyjQYQu+eE44IestSPl1iDPPfoHiWQ2eF4Gsk+lrGfwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EQTbTof3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TojF4e3e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQTbTof3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TojF4e3e"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXm1K3668740
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MfokqFYIIsc
	fSWuyK7hBpD3TjL2GPJaI85B2LM0b6Mg=; b=EQTbTof3FJoBbonQtk7mKD/la1P
	r9xxtDLeOePXM6R+o/pWuJkCB1CUiQIHKtd/LpabVN27DFNcrpCneq5IycM3U+4w
	j3J0N1Pv5ik1v0GY3rj0VvVDXxyzgrObgrlURkughRqd+6n2eX1+p8blA78w68++
	Hry+AOfqPFgN1m6HRAloAAHLO19LM9e0Z0WQgpZumFZLdqyjyWahWWecPjXqOQSJ
	GdJupjb4SXNBG0eI8b7HszdRbbsh1VQP5ZT2gCcFEXnuNr03tsE6RRTFZ6Nu1GxL
	sbvlawWtv/BZr8tZxn4aOQUBqKDW0Oe/7y1M2znNn3cqZxmYhlvGON7CiiA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppygwwj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 12:21:07 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84540760dc9so7682784b3a.0
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 05:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782217267; x=1782822067; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfokqFYIIscfSWuyK7hBpD3TjL2GPJaI85B2LM0b6Mg=;
        b=TojF4e3ewlDC8MY8v+qQbDFMrU64fW5h+jPvm+dGjX+NqAjhs6Rl1QyUs/wKZmR0xu
         BXC59NJTBQTPo3c1tSqV8PpoJHUNxZ4n637RbxfECX2va0laxyNKctZpQ4rp6iFdCra4
         2FNXVbRaUTt0uhIx9WIkj1po9X+xVKzcpC3X3XWOtuM9Nv75UZj8YFhw/qrq16Qio2em
         cFwyJR/dLsKU5qsuu06FPveZWQPwROsrhufxpUDzkAEZZxThjC3m+HsAzkqw+qYNhlab
         NIcJN+q574iCqDflbb+RyIDnU1L54K3MkA1qfM2RZ0/pfgkccbH4VsdPUUuYK/qfWeZo
         EOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217267; x=1782822067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfokqFYIIscfSWuyK7hBpD3TjL2GPJaI85B2LM0b6Mg=;
        b=GtNSdc/FUFeiWTd1SzbAW7yTAsmg8kq1DtHqFO2r+LYCxgO7bOPXVNWHMWBepQz4pj
         9tvawXZB2GH7gtLNzPJgKULFnalU75DxuQntBX0lPmaYSKaI9vxdLcCKcXaDtTBFSdsZ
         DDP1N2OpHMjsg8wXylVVpGQxz8LV3KJ5/X92bPXK6el7obKfMlaPgRahSNQKo2jh8ZFW
         ZLWG81+0ceD/NoqYUhK0t3GL2wrkSDG6cyjP9bC/8jZCJbrfDb2r2dY4Mx9MfqtNLD1g
         OJfC0mGrrgcaPY2/L/q73Uwn+XivFVM5HvQ5wXvL6XyyQQT6/ZtZq1nTQihkwFfyVScX
         DYVg==
X-Forwarded-Encrypted: i=1; AFNElJ9hsadctEduEhLzfhzsE4iKSdngayeozjv02qeyzcxab+JQmOfRzWl9c9oPwt1TTW+CrtzpkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOLlypkWoTmnbXg8q+n3XDWL3GtGsXkV301ZPvf23xJbZAyXB3
	aceajob3Cd3hrzr8LBExthHTqOan83KBGCXUuEbXUY9ZfwlNPE/7D7i0TVQY0u8PuLD6vcC/VK9
	0jqwPHVNbYYn3ZdjP8BUDB68Z7ANnHi5BM0lvC2eMSHh9oCmFwnStPWYKGdLQTg4iyw==
X-Gm-Gg: AfdE7ckPRVXvR1OuYPTS7L/cBL1h88uRMu1IzIVCOtRoW07i3QhQN2RFfYXkc/sJbs8
	UJX6JnX3wzeCO3iu2SiEUkMnH5TB1q5fvv9ukHsxzktXqF2pfV7V3v84y1DXw1EYAD38e+I/OGe
	qm8bw4zwhEgHR5dgmClb0VK01nAyBwltC/gINUmOQdQjYW63lRZ8gnsDZmBBCCCq1xBnRcrZe2c
	xWQveuhiTpsaGWp3RObTYy9qv2mSYv3aglcBx+LbFttfjKBiYEAUEfiAoxhzdn8INeSGmwACUeB
	zUF5XbJxoLVAQ/2Ixu73w5GmjIUenfHPTFcRQppnbQWiHUtmOKNG7GOiOvf9tOtTID5L2h04cTk
	ALd+JyegqWMaf4aoKpZq1m+Kp6OWaRzZkmSol8g==
X-Received: by 2002:a05:6a00:2e22:b0:842:6c02:2fa4 with SMTP id d2e1a72fcca58-845952354fdmr3159962b3a.14.1782217266751;
        Tue, 23 Jun 2026 05:21:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e22:b0:842:6c02:2fa4 with SMTP id d2e1a72fcca58-845952354fdmr3159923b3a.14.1782217266179;
        Tue, 23 Jun 2026 05:21:06 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e74646sm10171856b3a.29.2026.06.23.05.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:21:05 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 2/8] iommu/qcom: Fix missing pm_runtime_disable() in qcom_iommu_device_remove()
Date: Tue, 23 Jun 2026 17:50:28 +0530
Message-ID: <20260623122034.1166295-3-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfXwDqf6rdWoQAA
 ILOfh+tu2hWJcgcAZFlzR7kF4VibIsSNojHpJ6npyZJ2qqrdUPYPIN575sg0BKzRhS6rI14m1LL
 aOLAeGQESkJ6MhzI0QClsINSZ4ElgiMuNI7Jj35TBM1Ryhz3egEvohv6rrVmEsxTdJyD4w4vIiB
 S6pvWsumfty4OEL8rvvgAEQgHu9kGZWcdMjwGbI2Izu3CFRYBTTKvGp641YqIbFGvrTf0mKfOos
 2bnpWq2atIf7BWocg10kyVtiLVrq2W7bH8z7wUhQHSoVmkG9hPcYmPapw0YUzkQgRnRtGI25sX2
 j3VB7yL1vRdtGKNP4J9uFWOSU1Q7aAp1l0qkp/mI2Zh+BRD3FUp52XUMTfo84HLBX8dEYiZ/wLz
 BMxxaIzxbrejp9GoltnBtafnlzGgSXq7KyUQu5ITgyRPvYJjecBHSl8rgRwW3pz/VLBuKj4WzJj
 LW/h6jVuBfrwKT/DA8w==
X-Proofpoint-GUID: xn2IhXop7XcHXyqduiKNjUnYG03_5o3j
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3a7a33 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=NButBYuML4y5tsQ1waEA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX4ZTRjKAaRB6/
 PmmF6v1wr/Jd+Yy28RUPom/p1EMj07WRcaTxcdA4YRJcyD4QF44MSamTTu2VxwYnWKI81r+URo7
 8bNlyv1WR25TrPnxXhobZB152l1X6hs=
X-Proofpoint-ORIG-GUID: xn2IhXop7XcHXyqduiKNjUnYG03_5o3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230101

qcom_iommu_device_probe() calls pm_runtime_enable() but
qcom_iommu_device_remove() only calls pm_runtime_force_suspend() without
a matching pm_runtime_disable(). This leaves runtime PM enabled after the
driver unbinds, which can cause issues on rebind or if any code races to
resume the device after removal.

Add pm_runtime_disable() in the remove path to balance the enable in probe.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 09f2ee6be988..cb43276f4a39 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -878,6 +878,7 @@ static void qcom_iommu_device_remove(struct platform_device *pdev)
 	struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
 
 	pm_runtime_force_suspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
 	iommu_device_sysfs_remove(&qcom_iommu->iommu);
 	iommu_device_unregister(&qcom_iommu->iommu);
-- 
2.53.0

