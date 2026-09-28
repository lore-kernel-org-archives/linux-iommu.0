Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EDF3FC5AE
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591094; cv=none; b=NEBgQVljSd1LxdAG0RrJb4aShR/becr78pZmk5NVvK8y3Jjkdtob7zYcUk2nqVTTYG1MFkUK35PBJ8VN0yD9XJzdTN57YJFSvUw+mqvgmITVyhD1BYQo55WSe+ugGHTUuF4jKrYgsa277Zu8gDUiA9BAlnIVnW+9XZ1goQ4u9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591094; c=relaxed/simple;
	bh=JunxL7oqClUJ+DsAanyRKj4rdJd/Q7BGxwsr424FObM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2wMdt3NYH7gTm6dQui2GckPoakUxe/WQOaVLsuFPwqnAEzlLAliKInA1zBgB4lv0YjjSf/hcgHa2mpz51ogNWSnG8k2LJiOPYU+F4hmP8LtqW4XpkWTR6xkgOMCV1C96UaAfVxrPijSkA1gn0h8bEEoecPVQp9v0hBQT2ezcqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UX5AkMlZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eRingF5k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UX5AkMlZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eRingF5k"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9M54b245895
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 10:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JunxL7oqClUJ+DsAanyRKj4r
	dJd/Q7BGxwsr424FObM=; b=UX5AkMlZvPxLTlrKpBAg9qNfrwOwRYyTkcw5q+4j
	RPzg+7cBq5CmGHUhsfctEzZWyH5vSGsEphMCrLYeAHLbvOmTYCQ7swMf1Io/qIvx
	qrPW0tJTGV+EfNbt4SBXOV/wQ3qB/VLUwGn9352uvrTOnGK8Wjr6CTPBPHnNR7M0
	DwouI9sbwgrQXn9FMxFsUdb3ayAHPcNxrGtl++eWmBy7FoVttCnKJmHhzCRMk4uC
	QPJL2aCQsTLtQP4OXfTjyiAT5okBXpeQ6s9OtQeST/V5Qe42t/57HMgeNviHfi2G
	UHcVHi/4DYPyAo1MHBpnvjYHNmSzpkaSNgYRfX31b9Xt8A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt10x6j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 10:24:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93bfb2da664so855271185a.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790591091; x=1791195891; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JunxL7oqClUJ+DsAanyRKj4rdJd/Q7BGxwsr424FObM=;
        b=eRingF5kGM36/2Yfd2MMQ+57z2tYLetprvMupmDBny9ttbEo2jipvqm1fGLWN1D8an
         KzrNyLhpGTe24NSZaWs2p5uC2wjdqH4Ei+V6ZsStaZPZ8pDpq4m1+K+Dmvd/6DaTaO4i
         DX6a+Wvdwc0V9Rd7dUVbQi49o7JEqkP5b+GCXjMxeAzOb7zkTL62085Za4CYUUN2gIGo
         vcirRijbDhhTqwBf847LPgZYqTnZbKSm77aiuSQg365ALNi/38uFSmHwMlQPBo8YllfG
         dpSrGWbid/bMguAvD4vgD3U2+Wz9fHnYAwy3SLk3UEgvK37wmdy5hXVRxhD94XUDutm2
         GUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790591091; x=1791195891;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JunxL7oqClUJ+DsAanyRKj4rdJd/Q7BGxwsr424FObM=;
        b=E+79r5KOZbjQwIo/mXeSS9WY7y7mxj+k5Qv/BJvWznsGGY8ZRwqWNtIhO7K1UcsS36
         uSHyY3OvRnnPBuwg/F0c6Q/WROcWkrkBJffuBV25lSXW0EHRac/Rq5zwCO2kCewr1R1B
         qLLRWQV4RyUiQPOMaFQatO5uVul3qU3Elunq/WWrW+j1LR5eb/r/0qEgK14ayVTfMq4f
         PnIc0Uvpu8bFPfySF+2u83Y85Fc5v3WRin/NkK/LXEL+t4Ww1C0SzBWjGY7oAfQm1Eew
         +800MSda1IThVLStpKtr0IhdGP18zcbPbORGrdw0TK6zYbiDkxhzvPRXyPipvi13fgfB
         x3dg==
X-Forwarded-Encrypted: i=1; AKwUvBz3QMFKOq1jb/GYgDhA4LfUhCPcXOmq0oaQ0sTJG8igBME3BdLVaoeO1AlI0Tww3PT+FJNrvw==@lists.linux.dev
X-Gm-Message-State: AFuF++k+guIZXgVCDPhPUTZ0gu4d+Mi9tTVq/D9dlLmSoPuInpy6c6w4
	3Fn3lvkhTHRqW2qGOCxovur9q4bOQL+rn+ggfHU9smWUg/2VtE1TzuHM1kHhHAuvmJ4dfBJtf3H
	CzFHIAyZJDp8oRKyewRXnPkQ/t72lEkcW80Xm3u8jGpEDs838XpxOIhu/6g==
X-Gm-Gg: AYBFou0h7z/CyvqW7KreSTGrnyuu9bjgsCw83ODlCvdXDWWCQHSnzQIQPmq+ld8Pzrw
	tsBX+Q6cRu1ENMmshrOvAnp2BCFF6kZCnR7GRIFjJXsuprlaYWqVkK9JNtuijli0XiLYSb/xHcU
	sjXDLDz5KBOc7YFoxjlAz/SugRG6bZyq/8omP95IcQ6kJeuf09axLzeCiA2EiBQ/125lTDufEHx
	JKb70VgbwsOusIFdNnyUSEXp2LY8qBS7BS0EIqLEMtG/PdT6ZdVDjBqO8g/t9+7B8+KWwA4A/u4
	he5tQMS4LKa0YGWj+s0iMvf4/zEi+HVkwM+GjNE32sLUK3GCwJTBWNc3PElKiXehlPwMeOnubt6
	T/PifWfEeQ/PBxe6nidhv6Nt/uUGWAes9FqHm0Q==
X-Received: by 2002:a05:620a:27c4:b0:939:6de8:43d8 with SMTP id af79cd13be357-93c474e3f96mr1838772885a.44.1790591091071;
        Mon, 28 Sep 2026 03:24:51 -0700 (PDT)
X-Received: by 2002:a05:620a:27c4:b0:939:6de8:43d8 with SMTP id af79cd13be357-93c474e3f96mr1838770285a.44.1790591090707;
        Mon, 28 Sep 2026 03:24:50 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3bcac3sm248301666b.73.2026.09.28.03.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:24:49 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:24:49 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v6 00/16] iommu/riscv: Enable MSI remapping, IOMMU_DMA
 and VFIO
Message-ID: <k3crwedsmlusfc4goakdviqufyrsy43s2t2cksp3vbyva2u37t@ttyx32r5f3yd>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX6acvabmWnqYz
 dU8DGc/h054pqn1kxBwY7vg/74Sp7IbE8hksgfKyYiiAVikke0EWdIGFfq2x+15Fjl4ykCQl8Dv
 JAICLToCXN4fG5jrnmm0tn38AKDLQqZZbfQwl3xwHdPDP37vQTTHdnvzzgnhEKmgAHbnpB40xSV
 QUvqVRZ3XUey2ULqB54IvWujRzdC5dqexv9gclag5I5B8Mz2E9OPcaalDd0gwmoN5a77L0H/HvI
 kM8direEJKTnI9A8j6qtGOuMzbRf7KCTlV/NnJqrMnmlPZJdYCt37xzxa1plpZ+irgUCwgt+tVo
 M/kqiR6vZUwqm6u6Mz99H4/KURwP5AVwTZWEs654MAOTGmYwX6TpCrN8e37YGg4uMZZyDeWn7H+
 RdDfGWOQwr3md4epdH3ZObG2mANQ8AVvohAYrDPds0zjScxGuUQHGMn9ut2erzjbredv5E5qsUZ
 gtMxaNLTzUtXqCfP+Og==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba4073 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=rbBGQWOvsAlMenIskvQA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: XXckCXv8go_mzg4B5OIISPo-x99WJPBs
X-Proofpoint-GUID: XXckCXv8go_mzg4B5OIISPo-x99WJPBs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfXyKZv0+JTzc6U
 6F2vUe1uaxu6++uduHpc4NmMiluQuP0GAKKZ12HQQbp2IPq/2oiR6pmT5YudPTcv7F4SFPPS4vN
 h2YHrqBjp6tQImZ8qdM7Vi9GPOXs3LY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280041

On Fri, Sep 25, 2026 at 05:16:43PM +0200, Andrew Jones wrote:
> This series adds MSI remapping for IMSIC so a device's MSI target gets
> translated the same way its DMA does, allowing RISC-V to enable IOMMU_DMA
> and paging domains by default.
>

Sashiko only had findings on two patches, and I've replied them. IMHO,
neither warrant a v7.

Thanks,
drew
