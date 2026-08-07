Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29237A4B8
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126681; cv=none; b=tYmKFk0n9QH+RVJy1aaj3AZd5GXB474zhfDYgGe292AbK8WhFOd11rRQ/LgMJAR76uMaG0LrwRGvQrR8GQW08DB2AB6S0c1WNlB4R2vuYGG6Bm9PnG/8VKNVP759mL0DMqqBhtbUW7v1gdG7WzRryTywIwy4f33hX2WENCCWi8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126681; c=relaxed/simple;
	bh=kADun90yzpF790N2W4UNBoer3kXr1Yg1HaxpoaLa1W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+hzgpmGhkb4x79Yyd0W1Ax5NR9Mpw+YkW9pZ8/SEXwbze68rxQUV/F6TCsGJDJ4I8GdEnO8XSsrVHZYcrSTBToB61E1drSmh/jL5xDyBsygn+IcTBBIn6H6WevyJ8mv9AMm6BnV0EPG8FYvTvuexr8epP63AMHj/52LJYoG4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y8nu9gVf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qrz3or2P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y8nu9gVf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qrz3or2P"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GOQFn1496399
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6hyaE9/hr6o
	71lnQwh5ZY9FRiUYlYY1mXTfO2PBThD0=; b=Y8nu9gVfTwMvcAKxH2FFXkNZ2QO
	3r/b1LdsjztA7bw7p+FMPwAmPajUf4r2q6trJOIxgq99vJQut3Oy8x4+wG41/8kz
	tIxyoxbItZeEXo9aW2QQ9Jta+Gnb599t/iicNFnbJfCogTs1eL5NBPqn1l5a3WL+
	cxA9kQRuC8E+IZiPC+ZtkFQKdvBEgjHBwzPEzPLzVO4v62VwQTsWmC5g7gKcroCA
	mImiKTJ/Qgzt7je70A0Dbh1BqIlPReKGfc6U4EaycTMdx/GUqI+j9lDfHWjCKqOV
	2oX3gnt2ElEd5trWPLEdKz6MFvTz3w67uD3JnQfIkwlOLlvCGmHpFnl72Gg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwctpa3st-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d137a68so67173511cf.3
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126676; x=1786731476; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hyaE9/hr6o71lnQwh5ZY9FRiUYlYY1mXTfO2PBThD0=;
        b=Qrz3or2PzJRAP67vrE7c5vbf44E2BWWfmF9X/mzvpXfJ6mh/o5ceHVP5vlZhzDl9WH
         5iO3Gkzst1RmcrSrqnaX2ECsqqWGYNbjIzg2C1tVMvCXoHbcHgAQQRDKOx2npRFC5CJC
         dVYwOEl5aeqMUniBki+QiL1jz8fbJiE4rCeWCoOsMg1Q7pQrdTZezURTgdMs4v8QxuY9
         Ub1AlBzpLQY3Q2TgNItxyASJhkfwuvLMHWuuuY6YbI1KP/h+x4zN8zCUH6E0649Mk1c6
         rtrw5IcbpeQ+0x2Q05Jfd3n3XQEeqfr2IU4F7LfpL3p3Xq4DD2l0SerZeslaVkKLDOp3
         xivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126676; x=1786731476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hyaE9/hr6o71lnQwh5ZY9FRiUYlYY1mXTfO2PBThD0=;
        b=evCqK3/MHEvy8ni8aQXO5cI7K+P1jOpoh5Td1JW/hp/McZ8LwDdAynLmkEeYF2Q1a1
         A/yqrJnHRwNULwkg5BblqqFVo2TkIiLo3o3mwsUD2bGQaCP+iw8s2iUaDfHfted6tiGu
         vEZoP0tGjxcn0VVxJtGxpSmKLLQW/fe9H2OONLnGPJhy58YuOgDXV4nPSwWqclxWfOjx
         f4cqdjHNmqSxiZ24OlfoSXpIxCYhiLFLjRHcy7UmHXg8fPk1jkq80MBHl7nDs5ZNX2m5
         lzMQoiMz3LnRcr46kEWim4hxWdjPtuANgn9ZDeiyf5gDBNwfMeu1cOU8kHSXnm2+UrSo
         s0Bg==
X-Forwarded-Encrypted: i=1; AHgh+RpH++lhC5fMBoQ9dMbCszF039S6tiT0tWmxmPT9li9FYlJ720Ga8F+ABI5TcRUU7xa+WIealg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxadJa8pj2S4hmLQNNzdORJOfponI3eL74Zf0Mwb2PZDLhRa8Hu
	e5PzpenWSA7QFpyT3xhhJCU0aZeS/tOOoGcRONPKjehIG2DEv0aTWFHHOJbSUIr4W/m7uuT4dID
	dkTSmtogPpFZVP19gMI5qfTEHzB6ccqA/9WdpOCLmtyQWNd7Vv3+kqh3V+g==
X-Gm-Gg: AR+sD11Q2mAxHZRAkf6ebyLmhkYerMgV4W5GbLREgsoZ3Iqo7tYs09pcoagxMWSaBO8
	1Un+fjoV46zv+J8fofJRZjy8dKhG01Ahi0Y9BJ6nlbtwoQCTBm9vrFrQkIZVODugtOeYj12XUSm
	A+yel2MqsdwNQmevJay9gDOH8NL3I+Jx3qH0OEn7rQM4b+R0XDZf/aYCoaVu5KcqYTvvWhh+q8W
	JAIQHv4MxQk1xZ9xvFgrcaFBFV7QiPaUBgJfrdwcy8EQCxhtdvNWiHILOb534QzUhAtNzRvk3+z
	hSEm95JHoaFDaTy40BB2hpNi8XUkUr/IU1a2MrlIebFqB2MHEAh3GOQzfdp3Bl1Un18Tl3uWgLz
	tOuPNKb8zNPRaRoT4WrXHtMwOtHe4K3LWiKUT9uA=
X-Received: by 2002:a05:622a:451:b0:51c:1006:a024 with SMTP id d75a77b69052e-52d20a9abe2mr32374771cf.43.1786126675687;
        Fri, 07 Aug 2026 11:17:55 -0700 (PDT)
X-Received: by 2002:a05:622a:451:b0:51c:1006:a024 with SMTP id d75a77b69052e-52d20a9abe2mr32374161cf.43.1786126675281;
        Fri, 07 Aug 2026 11:17:55 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080cf6fc7sm80926366b.56.2026.08.07.11.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:54 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 19/19] selftests/vfio: Allow building on RISC-V
Date: Fri,  7 Aug 2026 20:17:13 +0200
Message-ID: <20260807181713.228535-20-andrew.jones@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Fp01OWrq c=1 sm=1 tr=0 ts=6a762154 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=iQCmQhr-3cNeY7cWxoMA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: nq_pv-ZP3xWzu0AhYcv7bhRoplR5463-
X-Proofpoint-ORIG-GUID: nq_pv-ZP3xWzu0AhYcv7bhRoplR5463-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX81faG4N17wfI
 3x9k5EGzxFCxObCyqfjBtwMurqYF/+2wYlHRTwtyvgwlQ1WR38NHG46LILk36DzKJHmdFHi/xSg
 GRPKexqH/+htkQmZTKiB7KJXpHwG5W6RiJCSTnRWy0Ms/8AWuZc7IkJ+Fc7P/Lyh5/6eHImMKje
 phrDK79Ibe4NLtIDpcmZMglcM2/wFQzFnWwZteyfXF6vfyDzzDrb375DOPnJwDUsCaLAXUm9yYY
 QyGqi3LBikIKdHshxICT4NfjZQiWbacIfZE98Luod4JAcvmIu5pp6kzapE6EgLXScmqPjrHIAv9
 X4zDSpZrxfXBw6owThMJG133gHMgSYSKuypQtovWeYbw/pG5/8aw3242zG4d580DqoBfdN0pAqH
 R2NIyOJCTZRYKgy+OD5d+tiQerrjLwSVq2i2XqepuNb9I9f3+W1/eql/0deRDYgK+fu2ob20Zaz
 B2D8PiVkErO94IfhZpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfXwu4eJwfftheH
 s72bz7uBwCXErgHVZj2gqx0qVgaqZIiPMrVR2UJbDfmQOwII9BxbXyl808bEkBcQfcei8XfhGZo
 1BCnN7Vx24MigOrwkeWyjjpKlr22BNg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

The generic VFIO and iommufd selftests can now run on RISC-V.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 tools/testing/selftests/vfio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..c39f95086a54 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,6 +1,6 @@
 ARCH ?= $(shell uname -m)
 
-ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64))
+ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64 riscv))
 # Do nothing on unsupported architectures
 include ../lib.mk
 else
-- 
2.43.0

