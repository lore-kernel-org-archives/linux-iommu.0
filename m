Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97AA4FECE5
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188423; cv=none; b=ZxN3J5sOXq5CuetvuNeNWxiCeYwj2e0o3NgosawZESaWtjDZROObf49eCThXlmy1/IroXq8uVZMPXDwlsxxpgsxrAXtxguMIgUCdZ7wNb3NYa02IBIMzKhJpxyqHuD+p4CS3xD+DX4119x/MOMb2eH9U8uPxG5j6vQgr+nSmbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188423; c=relaxed/simple;
	bh=KiBkyFbM+oUoQC7uZGJjadYNV50bpOhuhbA2S53q2Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chHP51ShPWFlU4dxHf73YEFdaLYvPym2NDgP/3xqURp8zZQPKX9vK1rKl7Q+teTndRkOthLLl8ZLXsmfETzd/oiNS6R+G7BRXDGpeLQxldPWYrSLoOnQG67iwpgHDIxGE4edi4bQnTS+YdTVdAxUgoMEV0d0L9lIVnIXDRaILqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FYpHZc3c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bWK0+4KJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FYpHZc3c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bWK0+4KJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETRSw3296691
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PUy1Ahq33tP
	rFwLZFHXp5jDvTROASK+cDxI2gHSvBWE=; b=FYpHZc3cCM72E3+XZmksRbmc9/Y
	Y/JbWcmIM7mJIbW6570Doq8DLaazi1zvFxgFtg52INa45kGJflDERYZmA/p1MfxP
	CDpzMDl37f81WkDNjjDwGYeDRAZSkLO4gJdeyX2x2kQoWh0ZzPV+EWYJSxwOSBOC
	DcQIHq+65cc4FvV7VvcRaEgYh2vup0xTYIb9XyGcaVc2e2VbO0Y5ErqRXfNiSHy0
	x7rjQpUFSA0RKfl1TTyBQpWHQXUF89blhiVX8xShmGaHW3+Mwh0fX0DnxaJahpYC
	3FYfOA+Kepzfzdh2Yw5S+2SiRen68mHov2Nar4KK8dquUhqJTlbBt8HMtSQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6ayhj24-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e53b8a302so499032385a.1
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188419; x=1788793219; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUy1Ahq33tPrFwLZFHXp5jDvTROASK+cDxI2gHSvBWE=;
        b=bWK0+4KJngj/GAE5kQB4A2o837ryj9Ki30/NgkRzvxyKVfgzycngVCYIS40xt2jNIQ
         q20K+QDx0VkXPxGLAyiPEyhlbkOS2P/wgHILYPG5nC99oh/R9uG0xBpBTB/tSBWRpBK9
         EVxmkELc5nzfoAI3bZ3afFoXzvI7NyObYF9nW4rK0+DzClW27L0q9QQWFHTFif8sbSrC
         cvIoUnN7lWIfJX13DNmD1q3gHlU9kwWhjdmnFnhfBBG26rQUnnHAqnGCW6UGHLH30TZv
         SGbgTOCWM7AhpaTU3HU0RYGg2pu1sU+R7mqDKlIyPAG0GL9In7u/Ic5UrXRfiWIHSFIF
         NNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188419; x=1788793219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PUy1Ahq33tPrFwLZFHXp5jDvTROASK+cDxI2gHSvBWE=;
        b=qZoJdQ2Fx9uvMfG/dHup2fJmG8/FGQqZcryfh0ixcvP25A8II2U6er1F0iuG5xDEKz
         IlK/QqFJP6vfSThQNAlJXuvtTdQnnVCWZdZbCIsJldaw437UY44vHgAzFhp3VKURplhY
         h6AGtopDLHb3rL77GglUnvFsE/d4UQrwXqh2IFbKM/Xn6AhfgBCdlucRgbjPfkHwPSrj
         D6hPwwdQqwIk6rV8mhTUAh8TJF7XBR6hZ/E9h0BjGVkbFhRMU0ARCy7bEws/VMDfCf7z
         DhGw0pElXCk+w7jVqorxB6BxnqVAKYmfuF2702bgIczXWBHl98WYIoaKn5j9FVjbeSq4
         1+mg==
X-Forwarded-Encrypted: i=1; AHgh+Rq3QTPqQVOe4Ay75SJrYcC6aljpvd1kEV2L/oSEeS468VaycYJPEui/TFRdNICWisGqjsoGwQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mlPzVSktUjq81IdfBHBYbj31Z9sp+SalfxF1hubhqrkEFwB/I7
	yT1blvl72fEZjBG9IOInxBtDhO5hBLb8397yHWtJTrkocUNysNXmQvknk75MuNVD0OOk2IIIGI1
	GgWcjsilk7w4db8NkNYOQSAjtn8lwOd0m2xOnP/XVd6lIyDe4WVOP7C7Mug==
X-Gm-Gg: AR+sD11AvyxbKXp6JBAP9tclxWQk16FPbS8eSugMrDDxYWjH4ozKQDLmn2DU9FAK3WE
	CbHOEtWoS3sMFIE/3zMWe2551I5yDfxE5RoR7mfYAm+aj6l7c8CcmMpnZXJGK6vFMsT7fZltZQS
	2nCXa0hKggkkpuNZfPUurLDYkKlJ1zb8Ux4pTzQ0e3L8W5v0GpSktgvRdyvAnAFdC8O3fypKIRS
	45fVOq/I2X10FoUCnCgUMzsT1DuYFomHFCdYEtctgMwtZnUqr10aqQDDJyWVKfuy8PjMzGHeIHQ
	OIHppgf4qccKSvpL4CKd+77l4vUdMXM/vdX6Q/JGIfLrYbaSPaYgMEn+ruGFRWDx1D3tl410ara
	j4W9fcMXCDE8uysLB9b5JzhQGcgzBx5tT6SI=
X-Received: by 2002:a05:620a:3188:b0:939:4a44:5f99 with SMTP id af79cd13be357-9394a446245mr25599485a.10.1788188418200;
        Mon, 31 Aug 2026 08:00:18 -0700 (PDT)
X-Received: by 2002:a05:620a:3188:b0:939:4a44:5f99 with SMTP id af79cd13be357-9394a446245mr25521285a.10.1788188414092;
        Mon, 31 Aug 2026 08:00:14 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd775dae8sm136267455e9.9.2026.08.31.08.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:13 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 17/17] selftests/vfio: Allow building on RISC-V
Date: Mon, 31 Aug 2026 16:59:43 +0200
Message-ID: <20260831145943.313726-18-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX7+Ec7qPZjzn0
 z4EaAgdeybv8kAtR4xBlJpCKvLyFXvQzueRM/CHipSqpeHCJraPhWMLRySNL8ovrp2Myzfdc2VY
 +gnd1UetH4sn8n38tWYU9KfvIN6Y4/c=
X-Proofpoint-GUID: BDZiSVtoKcddLX8I2UEpk6M7ZT9z8UfO
X-Authority-Analysis: v=2.4 cv=CYE4Irrl c=1 sm=1 tr=0 ts=6a959703 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=hTGq5wxE4AYYcur-NToA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: BDZiSVtoKcddLX8I2UEpk6M7ZT9z8UfO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX68+R6Nm3/W8L
 upcRXSkOnuo0MMhKP9egOvBqKiFCPZO5L99GW7E7LzOmMFQRuNjBB1jA5AUoEkUjkGr0lvsTuUn
 xyhOKckv9UsN+QfSUxQDurkt/Fgi2baDiEBbdDSRNo5Ta6x9QeXf2qguOjc70cMLSGBKgKUFGJ8
 g5ZNbFLAbYoROTnAu4TaDu8KZ6SiLlNXVMw+dfqVaK6d5JJyAK3Wv8bEaaCFGw7WteilGN4PSmx
 d1Oi0GVG9BQ8C7QRMjmuR52DlSXnQs9949tNcr09BlIuxUkJhiox4fWrmU9uudgIQmj+j6oyhJD
 w/0aPj+0C7GJaz7n/RGO3cyOIARHyCgbGWiTGm+s75uT/evTV1Q16G57mvOhPFV/WmbymWwt3oT
 knNKNlGOb9qmRpg4pKZiuiyNOZl3z4Q4vdlWJqeyL2P4bvHhiXmUhzJkH2+ZHFu9Vc0VFvURDLd
 JLQzbM0M8gecFMZSUyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129

The generic VFIO selftests, including iommufd coverage, require no
RISC-V-specific source changes. Top-level kselftest builds normalize
riscv64 to riscv, while direct builds may use riscv64. Include both
names in the architecture filter.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 tools/testing/selftests/vfio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..2c7d8ea81b61 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,6 +1,6 @@
 ARCH ?= $(shell uname -m)
 
-ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64))
+ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64 riscv riscv64))
 # Do nothing on unsupported architectures
 include ../lib.mk
 else
-- 
2.43.0

