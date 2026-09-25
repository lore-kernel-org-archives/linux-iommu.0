Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D914D4868
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349475; cv=none; b=op9y3NhdOuqUTwfp0NHGrC8k/J3nB1wXhr9MzTgnZZ0xbtSqucqP+l2doWhYEqmiHZ5M8QfI0GB7mie2/4MhBdMIvnBGXkMipk5hHQUP1mYj3N3UKXA6uabDxcKPpryeMWSVOKePfqmTX+oD974RjxMM6twO6emY3WII5dTz8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349475; c=relaxed/simple;
	bh=XpVx0Vvf6Cl8/GcQvW2/MZKbXpvkp9kJ2+pArOYCUDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbY0GKP0jy8u3/s2X8xfaDM7LFdgXA9Ko9XzZCAQie4Bl0vTW5IhcIj6dtQKrvgvuLrbuwxAX+fAlVawqezJMUSnk28ZtjOwOdxoHKSAszf9CIzpWES/m6961triAuIe9K3NgMeVpx9dcDO6XJQSFKqvadG6tHzk2O8B0R5ppx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SgcxBI4/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SGX0W5/i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SgcxBI4/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SGX0W5/i"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEHpr6600190
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=abif+hmZCq2
	aJp7kZ9wZQNQ7bgznM8RBFuowQzgUMro=; b=SgcxBI4/X265Y4JYJsiJ763BzGq
	v9e2VpINOshJJJsg6kmZlqqxFROv0Y7c0VPyvskjhCcNOHhwTrrJsGUPzY/r/dF6
	u0G8cOJ9frAP9B7lBwomFaDJHzmpzPkE0DaLlC+BcJ6ROrNLwDA8cvuyP9ayX5Cm
	is9gxGoRTbXyhDJ86N0JmeKhiVfTjfWCBtsEdEmJUQnN2U+WL7bTc7Xr+DPVS6Fb
	QX9cQv1D5wfoGKtCw/rWAt+l7k0Gi4rK075mTuuITXCWOHBZS9aOXCNeMxEo8q/g
	bEZyyfiaEXugJo7+cUKcMDeKzMGdG2+WV6cKGwo03lHKG0bxb2maPgx2EwA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjpvsw45-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:33 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7b34a3d1f9eso28181137.1
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349453; x=1790954253; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abif+hmZCq2aJp7kZ9wZQNQ7bgznM8RBFuowQzgUMro=;
        b=SGX0W5/i92lPEbhK2bJGcKIUK6Pds3i5mgwQOKVLNxB8vJwnyVtu0r+yeKprHMpx21
         xSy9AJNmC35UxF6im6nXNcn4g8CQtQCDYx9kNvSf91i0yWYtFczU4y71UmG2ZXg6fRpm
         t16oG9MlE8dL3p1QucaLnqltLftJvs+UWVIiRb0kfFc2TgPf98O2NaZAHaVkDQ75gLYW
         00k4jbdEpKBurY8QRXTlhM2kOJ8kJMXwzB9yYZ2GaGGzWD9VLRTEhDG8trKEgrW+LRf3
         39JMGQGOn+/c9LGnO5rIjBOdRXFvwWh5k93+8Q70GlFJtTnE6VOQeTb1TGOWmmaiYwZo
         bk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349453; x=1790954253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=abif+hmZCq2aJp7kZ9wZQNQ7bgznM8RBFuowQzgUMro=;
        b=R/6rJbrm27/JgNj6fytz/tViSvkgGxWX0EEA0+Z2QyjnuXc3ev/kRlYBDqhwBxB1OG
         2kcahE9zOtNr4FDsRDzxhn+01HkhnnQMvqeIHEfy1DWY/rt1QeArlSSICztnOAT6yWSk
         hwdc3c2/sv9Iy/BhKQT9UN8buTyQ2f+TliJa0GCDI6LxmyMj8SgyugCfGKiBqrlS/VnC
         8F858zk/Vp7TVSvxq/i8ooQnNXWHkwFVUWYTzZ2psOTuabRo536AWZu8ZjYH3sLXh0Jl
         ChFLVRl53s02/NGpjFFeDCb73qJ6FvHq/1FaqXyjDwPRYz1tEKVI+4mqHf8fTPXqJOE7
         TPkw==
X-Forwarded-Encrypted: i=1; AKwUvBzUH/97hIjFuvK0AX5avuHQrcCab1pJ+Q1OvoIjSH47IT9GCbajtI5dcphrq9HXgpi5EisJtw==@lists.linux.dev
X-Gm-Message-State: AFuF++kxjyy1LnxuMAcsZux1yqU1L1VSqj6OVUdWgmUpLQDX8WIvnkQL
	j0yAKlKQYMRlPkNFccLvORblPc/L7IY25w+jnJdo+qdWdDU+gY/XinSB+4LY8gMKg4KYg0ijkpl
	Uxb4FX6AdEXcMQFjna33J9l8nWWnL4wo+RivAj74Qbp45wCF3lXhEovyF+g==
X-Gm-Gg: AYBFou28yo0muMG16eg8XEFZifFw18s5mxnjh8PZlaTpLmqJuA5vMerjGInJFvcHUgE
	W0nobAn0UMAiR8egk0Qi8eJXtQTi3SnV+A1GIeunEll66Lqxs1V1MkueSI+6ZKsvNZNDtXDs1UA
	QN5VcDNFgGOiZdigVKknaSALiTBHbt+FwrqObgyUv2/UfBJFzxTGk5D/lcnSP6JrKQd1Ms28Xof
	7wnnMPgv5RMSchUb9S11om7J2u6qlCs8N/Dl9ndLIEsx2eNcoWz7afkUnFXSuF9QXraA8sQzkN1
	ZAROrt/xrTz0CvSSzR67Vruwxosy196Q0q62+IzgQUqcmzqyivbSYKBO45mJlc48AiqjQMqIz2X
	a6D2R6I6GMCIisZWLKlOJt1MZYpg4P3nly1b71w==
X-Received: by 2002:a05:6102:3ed4:b0:7a1:f7d2:e80a with SMTP id ada2fe7eead31-7af1eaeabd3mr2588542137.18.1790349452765;
        Fri, 25 Sep 2026 08:17:32 -0700 (PDT)
X-Received: by 2002:a05:6102:3ed4:b0:7a1:f7d2:e80a with SMTP id ada2fe7eead31-7af1eaeabd3mr2588526137.18.1790349452318;
        Fri, 25 Sep 2026 08:17:32 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355c65sm7978559f8f.19.2026.09.25.08.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:31 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v6 16/16] selftests/vfio: Allow building on RISC-V
Date: Fri, 25 Sep 2026 17:16:59 +0200
Message-ID: <20260925151659.419512-17-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-GUID: K_MFxAOqU7E4wdDilReW2KWXKhUqkbiK
X-Proofpoint-ORIG-GUID: K_MFxAOqU7E4wdDilReW2KWXKhUqkbiK
X-Authority-Analysis: v=2.4 cv=aLBlOr9m c=1 sm=1 tr=0 ts=6ab6908d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=SRrdq9N9AAAA:8 a=2eipm_--ddBYp9jzNeMA:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX3YhnnqkeZDPa
 VG/htmwFMhzni4B7Ao3YzznknH7+vryAxOELgFctYkAU+TyrBUY9CfbLby26xqK+lHHASJjsmpt
 67BzXmVsESeHIJ4m3pA69oKa3r3gfpo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXxFO6wSA/Jg3j
 eAjbNNyDMC4O5gGSX89Gc/g3QKBGcQepMbexxvBmmN51OTUohrZFf3D2wVMYSLqSSlmmMRNSDc8
 KK1rtrMtZi2UVVRIOYHu1V5UMIGr30prupuJHq7jeUEC32iRDyhzNhArg7pYVQayyaEQoMAkDGH
 ZgGJ71gWBUXMFrCjxqt4ie+mi69kEeled3sSaV1wSm7aeslGOSkbmmOhAt9Y2HY/tktb1IkVXwQ
 H2xUwp931NbrBHqkyhqP+kuj1faGgt/mL8d8gBwAH//Px3x8txFI8acJe6g+yfkC1ZLVC0ok4R6
 niDZEwGG+uWpN0dSUT0dupR99TE6ShQAKaZ78gtPjPejNJVWGMXHOsFM0IC7iv85qWoSaleCnKD
 dQ1IW9BaHCBJV1Sy5/50GZ9l2zKTBD0Ts8imcSYq7QPKQEjbcJkOZqT00dUri+XAnGkojc+WqDr
 956NI/6jbNn53UMRkzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250060

The generic VFIO selftests, including iommufd coverage, require no
RISC-V-specific source changes. Top-level kselftest builds normalize
riscv64 to riscv, while direct builds may use riscv64. Include both
names in the architecture filter.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
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

