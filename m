Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C9379990
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126673; cv=none; b=GStXVynYiAhB4VOv92XLigF+pgTafkrH2Gv336WUCjaGq7VtRh37aa6lmgGl1p8SJ/DMMIKnB32oBQ9UnKn9pmXSr+Z5jcBLAhTE7U5Mw+95hGSD+l/OUjrl/SfA9O454fu2SZzEdBUhnGDOtdpF+PIXPHiuqiSMW1T550LbBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126673; c=relaxed/simple;
	bh=TFwknJ0YqCRA1LM+i6U61SM1MSuulgej0FGruggnW7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qi1CO2iyKvX03OoTJozFWAK0H0YLqQSVGRAL5cktiFDHA/rnw05EEer10s+iQfgZ7WBNRIwk+BQa9TVzG4gmi8YNZtrvPuRmXWMu0KxEfPLp3qrO7bX4Hy8mDfjXOFetFylkSxSQQ5CBzpx/xp0QD9X9pEUfEPN47GqxzFjqF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zu8i+JO8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IICF5QJN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zu8i+JO8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IICF5QJN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GOVhh1496429
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Z/0MUXfJDNe
	HlErsfNSNArUm0DaS7PuJvPVjEpFxNjQ=; b=Zu8i+JO8qo5RQBiRZRWeCmE4Onj
	IBnBbwXNmUcqz8k5UNDaQENfARBJ/Mz6/pQcP/wf7vKA4lhk1w7Z8xX7zFjiz7wK
	DPqJ7LqAD+p5gakPY/IMDcgnTclHWiLWmKUDYNrYwmgf1nra3ALUh3eaL9M+W2EB
	QdvX0hnnS0s9PUyI7dECcpBHnn269VJUqbTsF1ssrAayZhXDEezxY2tJ5y2l8rnl
	XdAhsRjVXWrEh2LZgR6MF7hhFUKwKvLQfxVLaR+AvDJU5xYfMkrToHum+kPdzof+
	qhmeYwQhUkjSePCVPHY/duI0pg5irtWg5AA06eEd2Wcthi5Ap8Gm9Al4Vig==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwctpa3rm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1b4d961dso19902751cf.1
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126670; x=1786731470; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/0MUXfJDNeHlErsfNSNArUm0DaS7PuJvPVjEpFxNjQ=;
        b=IICF5QJNveLnspPR8Fyc+ak0Fkq9Lvql5qMqO8bkiM+tRQwXlaIXLdkq68XRUY74vg
         IaaJAqoIBSUIixreAOVR8Sie0NO7+7S1oVvHY0q50EwOw6E4p8MfmqWYvoVcgmBcFe0R
         4HyUNdgv5JV0GruNRb0xH71a5kpsRDPvQBusXmcuHiGN8P4+mp0nFNC85ja/IjEBulsT
         2C8ZaHlbXvIgdAzIyzPmuzxa+O3TS3XoIhsCOrTGfzfTNM1jk9yomxBkvgYi9AF/d1i6
         u8l28zaEQF3yzez0MMCs4AUPCrmjNDHwArrapl6euJZ+5VNn+kKIcLVUG+bqn7NYrulP
         qisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126670; x=1786731470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/0MUXfJDNeHlErsfNSNArUm0DaS7PuJvPVjEpFxNjQ=;
        b=PUQ3XqX/bM6/HU+SHYaTKMzKGudb8IypWGH0uH8IOL/tsRnNi0a+XkR0vAl/IoN5/7
         ShO3z+qSoNTtQZl/RalOBbGW7SeZ55UrH+p7vGSrrlNtYcrsqXEVRseX7nqffqv1+L9S
         9uh0HDyq96MvODMGMD64ujJnLYZPT0gDqz0vU4e+6/C15GPIyO39/X3PO/CQSxqbwhqX
         bVGMmlVelFNRxtUs9Pxr/sLWVoJoLmeyndTXo+tdMc9bLzt7PZGJy6SNlgSf8F3Hqy9B
         7up03cZ8jM1S1JE1Ax0ppMYc3FHiQv/q8dBOYj7FqwdQX4kJSzEUDw0WXQ6gSQ1Gy4st
         qPKQ==
X-Forwarded-Encrypted: i=1; AHgh+RplLKQ0OM4ZWVKH7s22T8Ot4zQlrAj0FNzJWVSYn0AAfIiJjfUOYm4IM2JJLbuxhcLzlK+uqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPP8+HSb1hS2kZC42TypW1pwv3pUex0VPSgUW2OEdDOyxM1PNv
	Nv7MnkwFIonTgeZEehIQAfwwmaXcddLvHmdDq9yjGJ/w134LqShC44ZerZnwNnqITZc/d1svoYN
	9+P/U8EOhE+f3+uHoy9vvfJEowkbZRN7omUsdFCSdua1wyT01YOconVvYjA==
X-Gm-Gg: AR+sD107HjSMFXPzUlyfR6SiWofpnfi78Y6m/dgZHDVCXEPlPG8Uesbd4IAr4wrGnq0
	b+ggIWKEIDOB69gZ5mMkmKVjRiXNRSlmOsCxtvQFV0xjKfUoeF1xMfcEdfc3HcOVvFCbXM2Ivyf
	fHcne0bM+GtZUX4h8c3A7KXZUfNoVSuApp6GDgSBvG2Qp96QmMFuKL+gUILgJFBx26i7UXw2fIV
	bssYRpWqZhKVzSfhw7p6b7xgyv8huYjTPgeA0sj//W0t1Vb3zKbe9/rDAZ+yHWaxHH3pDm8zduQ
	18nJH/oiAvCq+jhtR429+OCwkDgX+9lKqtqX3Su7Lio96dFAjDaAjyzFZfWE+zkfsuoY4zWaKye
	GE7ONfGNf/xktSglK3/Nrf9QPhW0yYvV05ToLYFA=
X-Received: by 2002:a05:622a:a16:b0:517:6fc2:4760 with SMTP id d75a77b69052e-52d236b1137mr8327211cf.9.1786126669917;
        Fri, 07 Aug 2026 11:17:49 -0700 (PDT)
X-Received: by 2002:a05:622a:a16:b0:517:6fc2:4760 with SMTP id d75a77b69052e-52d236b1137mr8326531cf.9.1786126669484;
        Fri, 07 Aug 2026 11:17:49 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080c90eb4sm80115466b.35.2026.08.07.11.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:48 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v3 16/19] vfio: enable IOMMU_TYPE1 for RISC-V
Date: Fri,  7 Aug 2026 20:17:10 +0200
Message-ID: <20260807181713.228535-17-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Fp01OWrq c=1 sm=1 tr=0 ts=6a76214e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=e-vb6wPzIjHU0Swrx_MA:9
 a=dawVfQjAaf238kedN5IG:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-GUID: O-y4v5UALaoU4FoVi9WVFUM3E2emhMjA
X-Proofpoint-ORIG-GUID: O-y4v5UALaoU4FoVi9WVFUM3E2emhMjA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX9UsRJ3WMFYRq
 S3ujtq8Jy6XsWkXf0/kJSDYLcLJhL0H8NOQ2CrRKFo4tJ/wemW0MAtGXKuDu5HVlYRVMzp3F03H
 b6AKYhyRgwUjsZph99xJ+C5WK5nOsUQlfagltC5t+LL646+/vTvCJdRxcTbDDAnIJynE8zzBixg
 LBfxvZIaA4GLY8yZg7/Ep4zF1kdbX0P427ByXDJq6uFlco7GQo5unKqHIa41iupSqpDXvAY6CgY
 apD3ZBp3DFFog6aRDB1hsQ/xghvNjdNu1o95qiyxdU6Pab1gbwoagQ/mKyYgfFJH9CmRDXe0cAL
 CHmj2YEmfs2n72Pg3VxUTzstY7KZFrKHdJDcCIeEbhCA5bn0Ivf+LHTP2fVu4aCYGeJ0Fe/Fp7f
 GHIdFvZ6dnnuvF8Qv2ZFW+U+wuqWb8v4eoy8H3P5rMGDjZwRktA7NmpAWh07ndBKHE7kHokOEPC
 I0FeRv5vCedls2WrVSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfXzFKX9v2xbm03
 DY1ggaez5ApVcIdssFw+m/fM53pthHr3japZRoyBwvZRnBdvMjBNG1uTii54AGgnUqu+B9n0kY1
 sUH11wy6m6749wQeO3GYUWBqQPy7cZI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Enable VFIO support on RISC-V architecture, now that the RISC-V IOMMU
driver reports the IOMMU_CAP_CACHE_COHERENCY capability VFIO_TYPE1 and
iommufd both require before allowing a device to be bound.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 drivers/vfio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index ceae52fd7586..ad62205b4e45 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -39,7 +39,7 @@ config VFIO_GROUP
 
 config VFIO_CONTAINER
 	bool "Support for the VFIO container /dev/vfio/vfio"
-	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64)
+	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64 || RISCV)
 	depends on VFIO_GROUP
 	default y
 	help
-- 
2.43.0

