Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA97377AAC
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126659; cv=none; b=udGZFtNwjCxyN4PlR17VdoLJXRbOSrX89CpK37yObxmSfE6pyyXeRtctMAPIBY71iJQqvKLBebDm0kMIqDYageeBUxkj47gIctA6It58UklxDtiQdFUJqiPpTEwHZyMkbXAPypgHlwJnob2jKYyiEvE3MP+E3+qyJZziGdyHqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126659; c=relaxed/simple;
	bh=Hu2ytPWAa1mLThexByZ9xTaT/NGZLfvhm2Cwp+vuxSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2xjo73nAhXr9n80MQPB4EL1dlLa/jCaIj0OpmWcBFyq6u03eG6EumOap4nfIDDd/HN1kvXP8XxXpuw5y9VZgzmfFxRDoZjPXDzWxI0/2KmC2RhZIxbnTcIs9bQ+th48dg+EJbTAQHPV81vcGV2IkqD8SZBeuwK294OmRQUZgeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CrwD9ATt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BGafhSYb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CrwD9ATt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BGafhSYb"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GOEn72039940
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jLH2lzhcItT
	X3xUJhpiKzl44Klgt40OlAokl433kV9I=; b=CrwD9ATtobyEmHGlwUeaA9X4S0y
	o8fByb3QLm31pLfhn9dYcgnTv0KgS0ZVuadEMj6RT/cT6tUeSX5k4yLOUAVeXFDf
	xbBCJctI+yUqKxi/Lrz0yszxmWR0Lzq3GlNevmBBwQ8XSGRpEKCaRHELtSNtPIjm
	gD1VERgGkSxEtXvtROPkkRrqf/T9zSquBYk5QzeIqvWBr9kl9wFTAszwEAoSFy+E
	QU9rh2Hh5yOU5ybdTBmgRgfZQ2Q7P6lqqUSq5614mcGIXDqsRM1MVywQMEWfvLGC
	Te201JAKnL4iseV87DanuNk+QOODCEMZf0tLZChAE2AgF56g08dB29sXOKA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwcjb2745-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174a23afcbso39784281cf.3
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126653; x=1786731453; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jLH2lzhcItTX3xUJhpiKzl44Klgt40OlAokl433kV9I=;
        b=BGafhSYbCLdSdwfoVoT0yX3OJTTjIkDpSScoW+i6HRTQ1YOmOWS2n72WCFC7cOr9xM
         KIWZ26tGgMbfHWfx9F+35D/0l9bsfMlzx40lx/wCSo94c/3H0+d2Ro4ghOCFxjckJ+RK
         dLvS3hNj3SQ8/qq9iN5hUBqy01qsMSt9Zl6RkBGNN+63NZYwDYCqKzz4i2nnjcdgIavh
         S1UqbadObgf2gur7aGNPh+TR3PCkR8wygvyYWqb7GVp0TfgE7j0Zbd6WVZjorYeibUes
         VChjUnWrOsu305Y/nxj+4BTj1i/fvvpksEi5Ck0lJnMu/6CnG53VlnJMewvG2VPH+mDJ
         R73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126653; x=1786731453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jLH2lzhcItTX3xUJhpiKzl44Klgt40OlAokl433kV9I=;
        b=NDyKItAQM4lfFX7EIKKmJ2MGam9sH1+BCgsorKjGPWOwJWlBkupgkCHiq2YOLCLBV+
         DZcdlgLKFzSfKsv8jFFD8JIdtavpAIJqJ2NjyEE0e2dT3fZksMamQLceWhzQTQwZFGxm
         gweDPK2VJEHWNKbB4OnH5ayKURHYR4VMVmFp0XzQf9HS55pGWALxlXhimwDLi6P4Safp
         2PXOtTWAB6xo3a8LghbIWUCoTMe8Z6HF5CcHQiZ84keA/0eZNEhLzf/Iu9c4xEQhoXzY
         C5IJWmaPwqFe1a2rbPgAOB7ZBuVfVeiCAoUhO2Q1v+99ZsMpMewp7+G/e4OUegZSY85C
         9eMA==
X-Forwarded-Encrypted: i=1; AHgh+RqS1sjapobXHNKiTO/j93SHeCyku6HK2xiqbhP45SoHy7ekRvjErdo/1gDv0n4vl1uBmVXXjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzY9RGQgr6Gp4gUVyeFMujdRXf7LdBca9EjKYqEGmvYggUR4i+B
	9gnsGZ9BvKJNKEPr8m9dZQlYr2th9zKAbtlPd5R/TGX9CpOeNFNpxLH8G/JrtpslIRys7/FiHxw
	hOaRpx5443ECGQJdimvJHe90kCCC0w3bnPoQtcHC4so4NIvcRogPnUqXXoA==
X-Gm-Gg: AR+sD10r05z9mKaEE4GURw6hJPApVtSu22gq/8+xwfyYgqMBGpprTFXM7uoxQG4Xr3w
	KVV1fsOeP9y/+rOBAjReZ7Xnc08GK7YwjmgB27GgurfoQuCCPzmcC1lUuc5Y7Q/WhBy8GV2ofjL
	vAvBJ4+TDZtqhYXVpQGToqzwZ4dFfRiG4SmzTyyGwS88qnuc3QJj3CB3KcuHl8svGhtVRP8KDn4
	YT6WsuoSmA4+YBG/fNQHkhgrNjF3Ld/6K7FzB8RJooWxL3o3rrSzcYWUZj9G09HnDOR6DbAIDJy
	mGzt+2XZGRwkYCGM5DCzhAyXi9Eor11GbUW8qYvodhTpTfbbEdc+QpvTaBORFSksCSSbtpasfDn
	Hjuor1zV0cka6nt82wXiTL0AKOk13SK0Vq86+r7c=
X-Received: by 2002:a05:622a:588d:b0:528:3882:386a with SMTP id d75a77b69052e-52d18e6e5b9mr64238651cf.11.1786126653005;
        Fri, 07 Aug 2026 11:17:33 -0700 (PDT)
X-Received: by 2002:a05:622a:588d:b0:528:3882:386a with SMTP id d75a77b69052e-52d18e6e5b9mr64238021cf.11.1786126652593;
        Fri, 07 Aug 2026 11:17:32 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080cc3835sm85483366b.44.2026.08.07.11.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:31 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 08/19] iommu/riscv: Prepare info->domain for concurrent RCU read access
Date: Fri,  7 Aug 2026 20:17:02 +0200
Message-ID: <20260807181713.228535-9-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfXzkJAqJc4W1/O
 OtQUgYTTEKlum4Yl8i6hVTKYxq6NTu9QfpcqrFAMQ5HVS4zFCfaYUWVEodcDWjZ2+JRCCgpm/zN
 g2O0EJyUHFLPBh8wwqg1EAtRU6IB6njzr/M7apynESRXlaMF4AYXln0DipPN0A1SKR3omWlC8IF
 xsyv3XEQerfae4BYuTUGOushMlklKrezq/aN7yz0o+Ae+q4O8mJkgxV/APJ/rw7LOKjR5Tx5d2e
 7BSotFkKNqxOK5jWSRjX0eZViWMiWOg9eHQZFcnz8seA0ExHZDFFAsUfrChQyWJB3KXF06sgwnw
 ZGYQ5pKpt4R6e9st5she00vY+bq7wU3AudsKNwATEV0tfN0Iimzkl1olqlyU8PfXVy3oFW7Ynwf
 A+NcDQC0e3ntYVJ2tnzWX80gf+z0MjdUPPQRzE7IFRYeMf1oNcjAi/5oXsOBJNQKR5ug34s0zRj
 GsMqblFfuoFRMc/0XJw==
X-Authority-Analysis: v=2.4 cv=QsBuG1yd c=1 sm=1 tr=0 ts=6a76213e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=j3M2sUOd0rYxyD8OH6gA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX9aSpNhYzQGyr
 deKDC0jrQFxcnZY3DsaDzoitQGP2V+ZAYZPHdHqWJ35uqvsfZsja7ghFMasDozeLsCRAMPNEoqO
 cxYN+f2p8VkyjFJRNpAbPVsDGCQqNZw=
X-Proofpoint-ORIG-GUID: Raj5msO4I3NSiOo89fseZfOdG64RnrKM
X-Proofpoint-GUID: Raj5msO4I3NSiOo89fseZfOdG64RnrKM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070143

An upcoming compose_msi_msg() implementation reads info->domain from
potentially atomic context, concurrent with domain switches. Apply
RCU in preparation.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 14 ++++++++------
 drivers/iommu/riscv/iommu.h |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index bfe606a0cb9a..27dfd60834ac 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1241,6 +1241,8 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 
 	WARN_ON(!list_empty(&domain->bonds));
 
+	synchronize_rcu();
+
 	riscv_iommu_ir_free_paging_domain(iommu_domain);
 
 	if ((int)domain->pscid > 0)
@@ -1296,8 +1298,8 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	}
 
 	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = domain;
+	riscv_iommu_bond_unlink(rcu_access_pointer(info->domain), dev);
+	rcu_assign_pointer(info->domain, domain);
 
 	return 0;
 }
@@ -1373,8 +1375,8 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
 	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = NULL;
+	riscv_iommu_bond_unlink(rcu_access_pointer(info->domain), dev);
+	rcu_assign_pointer(info->domain, NULL);
 
 	return 0;
 }
@@ -1394,8 +1396,8 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 
 	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = NULL;
+	riscv_iommu_bond_unlink(rcu_access_pointer(info->domain), dev);
+	rcu_assign_pointer(info->domain, NULL);
 
 	return 0;
 }
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 5d83537911b6..ded18aec8010 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/iopoll.h>
 #include <linux/irqdomain.h>
+#include <linux/rcupdate.h>
 #include <linux/generic_pt/iommu.h>
 
 #include "iommu-bits.h"
@@ -33,7 +34,7 @@ PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
-	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_domain __rcu *domain;
 	struct irq_domain *irqdomain;
 };
 
-- 
2.43.0

