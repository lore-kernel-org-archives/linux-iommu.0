Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B602742A7A4
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299579; cv=none; b=nQqPGlYuNNGk+cAILaj8ROlBrsBSxD/xPGK5vFdxWTE1NR5wWS+kOIZQ2WvVGFvv6BTJM0RC/ieaPZisI0SIlkupyJxFUUZOSuQzu4gNxz2ucJzST7NmaB43vWtWETy5O9pfEb5GYl5rh2RyvYm2WU9TKhEhgo0FIquLjY9BZdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299579; c=relaxed/simple;
	bh=jOGIwyba4ZD4BXF547fgfmWYOt4Y+WSzqc9AXu9rVoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ihKO/aERb/jYnk7oTVjNG7h0U0nrOtj8MKnfXlF1FZnDLBlB86/cEEkJ85Zlg503hntHco05gdzM/uHBhz0MuMoxBI7i/aYOjkj2LgMgzPDSBADN/udQF1dHVsoqxgrz2r2Mv53OgWruZ+GQ8UkrNjZA7u6iSTqrZgWmpAkCoZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FXUQOOHj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HtFHrUZ0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FXUQOOHj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HtFHrUZ0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE7cEi1809061
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2YBmgYqqiWvkxoGNGtW+gM
	+8EwicKHDMEQq55ODtwzk=; b=FXUQOOHjq/PnecFHk+Zv2FZf37IBT1HTLmr97d
	okn289KMuITPbIdvBVxZ7R7LhqeEhEQIHZO4//29WVmxBkQv3HaoOfgW302gBK5h
	Ed5F4/W3ObgyugXXB5BvnSk2nPjyhHTEm25dDs6lCm07YrEEeEkjk6r6mvZgkLll
	Pzeu07iOCzbduurtrN2BCDg/+IZn0jQMoMfdzwlJrR/2OeaVQPqaUZRwLB01hymv
	d/bxhfAUmjx08FpzYyLZN3b6C7iTP0jgQsZyy0rFu18Jysccb+4hjXHwqks6t4ip
	1hKUZaSYrW5I90SZaaK48F2IFY4BctjbYGzCfosLDBFBE8mA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u8m7q0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c12e43b98so155072581cf.1
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784299577; x=1784904377; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2YBmgYqqiWvkxoGNGtW+gM+8EwicKHDMEQq55ODtwzk=;
        b=HtFHrUZ0LVT7U8V5HIPoPmgmFKcEmho1NuUhc/UJ+oQD5klVKAe+k/UUciQhbFDKJr
         a++hrz7jhbb7hPDXY/6AuRZ85koEOi/ZKPxEbDZjos6jFUCPWRs5/+VPv4yzV1xCNTNa
         684KO3NF10CfL+PebXzZiYtEIDvzzWoSHDjoRG8KY3IH7MqiD7bE4a2W9hf9jfqD8TpV
         jtwPR+d5eXWWsYYvmM7tj49ItCHUAvp0vq9biU0U9nVltF/n9vn8mhvj4Nl5lAer1bSm
         9bWJg64W4RzXDX/oiubbdQ/uFEaZzZjqBcRuv2cjg8K6zEsvfOxrxFxjSCWmhtXQipml
         Ztsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299577; x=1784904377;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2YBmgYqqiWvkxoGNGtW+gM+8EwicKHDMEQq55ODtwzk=;
        b=SQMfSyCeQ0q7bmp7kixYQzijT7nGs82bxg8WvIS+CRcp8TuT9GU00kN8+nAfxaRDid
         pv88kmKsVDbZcgkc+A8Mu+3gTqdGGfgnNlgHimYf9d2xGJYLslHirUfa6kPiV6DLAR8Y
         aGmj0H1fTeuO/hVi0Vxa29dm2eHi4K3e3VK8TS19VDHlToDT1oKshieQy4aDFjoZJsn6
         VgMRIPwP3SBqukF//5vgQb7xIq+xqpdfIuTdEJmNmlexfSu0dtz4FKqxHq79rM7hj5kJ
         uNuWnJdCbGQ9b1TkY6/AI9GYEGrG9bw5rCbj6hXnWVYWJ1V+Q/C2gZFYVx43lJuPvvTI
         /6Xw==
X-Forwarded-Encrypted: i=1; AHgh+RoKaF1PUQKRMknCCulbZ70Zdp6MsjR8RY1twSCGCqWGgxez5BoeOYeWD71MCFmbViobj7Llvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywhlq/NtcSaDer4oTuzkaDrvxZWzmsuICZ9nWExdUY5WGAyfG6+
	d726ha2wkeW4vfYjq7Ekjir1mL7lNH4MyqoFZdZRWogVNA/FHfHqrAljOLQpK7Ip0OiwyW4Nqsh
	R4zLjPWvXX2kNFunuzhYFipLMi/Smk883XXDXtb3pEG3s8bbpI1J5xotmDg==
X-Gm-Gg: AfdE7cm8J21XIZhAHncCFzz7z/Vpj64Y2nDSLac6fjeRRD0RfC07Ru24bC3jxxL2z/g
	LEKiuvdsy3uGWfkUvhZpdQKE3SmtU1oNH9A6t7cop4wH2cfHf9C8Og7uNnH45gg8jI+1L94NG0Z
	2j4OjjSG/sPeZEf8G2ECGRxlCqQFscC6/xH7H36MIb4w5VYI2Y/DIB6HyuQ++lYQyl7rjELS30y
	CP3FoDCQGDX38XoV7L7RZQrqMqRYuXlgWqMRUhlZypBXNoWJ8YcdcQKPQFdty/REpjANyeG5VPy
	eNWN7LbI0JLGMypP97evBnpyj0guwyepxI+E/qBApG9EZznoXQv/a7kemNQZxhnY2Jy+OUiNYDg
	D6wW2vNSBALru1dclYCfgtUa28W4=
X-Received: by 2002:ac8:7f8f:0:b0:517:8011:3a4b with SMTP id d75a77b69052e-5213c7e50cdmr24070101cf.21.1784299576630;
        Fri, 17 Jul 2026 07:46:16 -0700 (PDT)
X-Received: by 2002:ac8:7f8f:0:b0:517:8011:3a4b with SMTP id d75a77b69052e-5213c7e50cdmr24069531cf.21.1784299575917;
        Fri, 17 Jul 2026 07:46:15 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52149a3ce4fsm13414801cf.0.2026.07.17.07.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:46:15 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Alex Williamson <alex@shazbot.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 0/6] iommu/qcom: Misc Fixes
Date: Fri, 17 Jul 2026 20:16:02 +0530
Message-ID: <20260717144608.3216274-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RxG8jgFLW4-9UqqoY8JdmvyQPJAM3fPa
X-Proofpoint-ORIG-GUID: RxG8jgFLW4-9UqqoY8JdmvyQPJAM3fPa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfXzMZcMujYTZwK
 55KZ8ylCuyAiBppmQT4ehLu76TfEhkLjNTzE+yQnVrRNBXR809vmfGqKV2uh+gUyf+OVY10EcXT
 vFEo0Ixf8rFh7TL4UaKaKyhIU4+ylag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX4+0U/uN7Eyy/
 wA7XC4qjHFo6kIznVyObW4hzHzwj2CB/2klvlbWdBkUTFoSsg4Cb+1oEGGEJE6yGM987h0qIk4F
 57+viJHyKLnM0CI4PajwSFFT6MfogTDAddDLoWMkwAS7YNtL7mxjkiCs/UdFSITMIS4sFe/DI9U
 s97hVsIgD90oCeKzkYMqip2Y1XyItOBak2as8xk/W1laTlRNyjqzsVaWaGwB9pnsLD3rfYKSeqC
 Yn4MhqQDZXnjPSG/tnjux8PARQ0aj680IQOgJIfHaj+PExlUGOlgKnDOgmNBNwdy3fsSHIvAHde
 JLnveypDbeyPoGRFqXl9yWQmWazvXyZnX+CA3jSKGXbs1Tx+izqFb0q5+eennSh8s6WObH2fkAE
 AdegMtoRrhtDJRONMC+CxdrVNf85qufo+wwJnT0+J7tG5P3BigQvisfhKEUn4GC/ltVSk1QBN1u
 j7QZPWGKKWOS49RJhdg==
X-Authority-Analysis: v=2.4 cv=TL11jVla c=1 sm=1 tr=0 ts=6a5a4039 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=AmUTqjPzaPleRPW9gFYA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170150

Series to address fixes in legacy qcom_iommu driver, it is based on top
of  https://lore.kernel.org/lkml/20260623071245.1985938-1-haoxiang_li2024@163.com/

Changes in v1: https://lore.kernel.org/lkml/20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com/
 - Used devm_pm_runtime_enable in 2/6 as per comment.
 - Dropped 6/8 and 8/8 from the last series.
 - Added R-b  and fixes tag.

Mukesh Ojha (6):
  iommu/qcom: Fix inverted fault report check in qcom_iommu_fault()
  iommu/qcom: Use devm_pm_runtime_enable() in qcom_iommu_device_probe()
  iommu/qcom: Check pm_runtime_resume_and_get() return in probe
  iommu/qcom: Fix pgtbl_ops leak in qcom_iommu_init_domain() error path
  iommu/qcom: Publish pgtbl_ops before releasing init_mutex
  iommu/qcom: Enable clocks before hardware access in
    qcom_iommu_ctx_probe()

 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 31 ++++++++++++++++---------
 1 file changed, 20 insertions(+), 11 deletions(-)

-- 
2.53.0

