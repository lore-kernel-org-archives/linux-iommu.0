Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD094C1502
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349465; cv=none; b=Msv6QNcQbdcNM7zweWYGNkrSeTkrzp+3hXQLqaJe9+G11inzYlGjDDVD6qKbZt9Ih/IhnW4xV3ws4jzfPVGfEoTP2IqtO906ygVkYnbJhfj84qr6UGsSwd56HiDr/eC4g85P6oBm7Y/rrPzH5K3blXMCLjLbQlNdsk+RJEKqexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349465; c=relaxed/simple;
	bh=0+RElOVHA6/v9QdaGHpeSa5xXMjPBpsgLeJoEqQJ2v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzjTPW9i0U3zWElcp8llnmXqd9uoCCm5H7FZrMqDGvJGbkMAQrQ2XOawXP3Jt7nFfDWOrp6OLF2FmnUrnRj9iP6OOkSesU5Qx2U3mosL01q6OaSfdBhYT71lLIebv1cLCvYMnm+9gEjYnNpS7whs+AUpG09W76nNbCC/jnv/4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B+H5VGGL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=frPxlfEc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B+H5VGGL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="frPxlfEc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PDFJcI1055788
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6+ZCox6I6Xy
	vCSNnN9WRqr7BjiGU1q6t4GbQWDFuB/8=; b=B+H5VGGLe+ueTu/jsPyM2c7vPxQ
	9CEGbjpLevonCkfYu1jXP8atyL0NfsSliGZpuwdM41akpDy+LYuJf1xflxTsdzMo
	gz1ixDlMiISeeXYA79Nsv7gcKiNC0yZSnUH4uidCfgxiYvPdJEULt23ekOwLglFv
	MSkMmJ/+Nw75s+JS13BYEplEp9Cq5ZC3J2NQM/XY9djuY2bHRSR1wV9QTIrFt57V
	Z9HHd4lNcJtc9YJSxzSFjxZIpXBV5HhU4xKRSpIora0gZzPWlPMPYew3GH07JL7v
	4K/BXH4cpALd6kmOK43l6hEQGn5pqw5lNBpYspV7g1k4VIpSywB3Lmps5DQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7b0h1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:31 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7a5ed2517b7so217755137.2
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349451; x=1790954251; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6+ZCox6I6XyvCSNnN9WRqr7BjiGU1q6t4GbQWDFuB/8=;
        b=frPxlfEcJke04l6hS04YntJQVtjhlZKLSSw03ggcYXwPA1tUZHPq1Hporrq2OlQsJ1
         8qSY+UNwcbUUkjx+vPSc8ai5GqrO15muaVKfpc8rZztZNmCoQbge9GGAuyqtk5u/adUo
         6EIyuESSk3Spa3REUkgwqZCINFUqgtH2E17YcFgENTu6XeIJlOjPnl8e8NIcwB2kUdll
         RoGUVTvneW7D9PBjznewpr9N3dfb2LlAMrUV6OXU2VGYsL+wR2SNkvQb2aFpTPTPOeMI
         IWkkUX4rUTYWNVp4ZzrJmgSeGzaw/WoHQU83f5Sli21rM8wS5NoGuAuIvFZjeuw/iyrP
         7dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349451; x=1790954251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6+ZCox6I6XyvCSNnN9WRqr7BjiGU1q6t4GbQWDFuB/8=;
        b=jW9wvqxvDvUM2qemdRaEzvI0bHvdy9WFyizhm4+92ByMwgwgkTU3jha4H2NzHVjJV9
         M+XR2A41AAZGVeDYjkqboJytMnMqpXrdkZSacqoR4A+ufFNgGg8RAiLp2YHY+UTg3PZC
         wOwuj3jm4nvhx9UMYu6Vyds2H7Y9WDE2brMvnHE7+qJKwV0oN3Dv7hs9BQbdfHpN0whB
         398QmsdSlwmdfKlbEwr0hUY46bkLt+sQ6pSEcU8yca8VX+M/mTie13Na7GaGxQ0uGmos
         4i11CsgskYco6GFxiBlFmbZLhtw7Rl7kl2hfL+ch4x3hwI8owWAuaNR+smO+P3ZCRjPS
         kSEg==
X-Forwarded-Encrypted: i=1; AKwUvBzjmp4RGB1Ply4GDi/RMbNe3B2GVZztmiWmvhDwjrPHDG8eEgOHGQk1iSepqWx/P9FIjZ/cRA==@lists.linux.dev
X-Gm-Message-State: AFuF++k6G5mmix2TEYtt4pqKC0Osk/vmXYUX+fmXjRTCfzJUgQAHYNVv
	8aHJwEsl4BMtjMSvQFJyoqgQY8k/vJ9dzcBgyLZys51mOlF0OSypKERKUQnjdpjO24DZ0TpLVpB
	lGlk7PyfRnKxsdSlznahARHWboRa97LAdsEY1DlwXRM5fmT60jSpF3Sk9jQ==
X-Gm-Gg: AYBFou3PQneFW/V+tn2O+KMJuNM9mtmrsWKwoabT7cJL3eiTBiRBsk+NbL0YJuLoGwF
	pdE55BOX5bTBxdb6cFFc0QxSheIi6Nmx5aPFlGJpW9O/JlWNJF2g1MgJRp78T0x5ZMzqSyroilV
	ylk6wWVY4qB0z6QQPXYBRiQmlKtXfxey1Tc8gxKQ7TSZ9QjtYKXa0KEuJq4wGJ8TeQkUHJi13kX
	zSnO7eTNJcLgCaQQbEiu22B9wfc5tEA5dMAm436GiY4CKC2ncQHLgG7XkyW86cdm4lHmHLc73mj
	tOdrXcxFZncK3I405CfharMFH/O7vxrfVaiqUzvpw7ANoRnBUuyWd3mKrc6Ag2OGYSD50kzNdyf
	IgW8RJeSN6HRRGtxpXqP+9YPKTag3NyTqyFoyzw==
X-Received: by 2002:a05:6102:4497:b0:7af:4a46:4c12 with SMTP id ada2fe7eead31-7b1c4a2ca24mr880488137.2.1790349450929;
        Fri, 25 Sep 2026 08:17:30 -0700 (PDT)
X-Received: by 2002:a05:6102:4497:b0:7af:4a46:4c12 with SMTP id ada2fe7eead31-7b1c4a2ca24mr880459137.2.1790349450416;
        Fri, 25 Sep 2026 08:17:30 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b1dfsm8224246f8f.4.2026.09.25.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:29 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v6 15/16] riscv: defconfig: Enable IOMMUFD and VFIO
Date: Fri, 25 Sep 2026 17:16:58 +0200
Message-ID: <20260925151659.419512-16-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GawxNW6p4JwiH3UlFm3TxLiMMaXSsd8e
X-Proofpoint-ORIG-GUID: GawxNW6p4JwiH3UlFm3TxLiMMaXSsd8e
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab6908b cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=SRrdq9N9AAAA:8 a=B9Crq1QHcyRNgBBHHYMA:9 a=zZCYzV9kfG8A:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX6E7DqW0N8jdU
 w9uaRVwwQk1cBfbxUbpXHgxZnX0qXXsMT6RjDME5olRwiAZO49MpXxuP2lbEiZnE9uL3MpMeobZ
 qnTwgFNBq73gzqXYB84q5nciFXjv2sXg7PmenjRLpzoY5NzfCXN40cuFKHkpUqIPtPTBm3UvaWS
 0Wo2G1qLwz7ZQFlXwW54JcG8zlhOYXcFatocFzsWWrks7d33/jVUfejjlOpwC0zaKgFjY2Omlpk
 Tq5T4wBrDP8Xb0FB80zD0dKDij3nPceN6Y2lddy5KBQnDG+/8hUqo7M8FysYRb2rq5sVTnXxkrx
 dxu4jbv/o9LEhjNdZNQuetKP40h7LVp/96xDZOKXwPRvT5O8X9BGjrP40CYysCazmq0FNpJi4Ui
 NE/iuJCua1qxo6Y8oZFHCRk8hJZrEAUZTOfj4pVeuclcwby07PQPks4AL1xB/PIS7ntQ3RbW/df
 PBy1W9PG4DnF7gnU4WA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX8+xBFhe0Akt0
 TnU5UgkfImEOLUzSeu4wSq5k7QyKx8WyhJGm/Jt4ie05AHu5SsoXSyOdFcDTVywWUsm6AOlANch
 nAiPw8ePulaghbFp7lyIfaNd0QZSZSE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250060

Enable iommufd and VFIO in the default configuration now that the
RISC-V IOMMU provides the DMA and MSI remapping needed for userspace
device access, including assignment to virtual machines.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 04ae305d5511..daf382c05441 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -251,6 +251,10 @@ CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
 CONFIG_MMP_PDMA=m
+CONFIG_IOMMUFD=m
+CONFIG_VFIO_DEVICE_CDEV=y
+CONFIG_VFIO=m
+CONFIG_VFIO_PCI=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
-- 
2.43.0

