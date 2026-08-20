Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5647E48C412
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262149; cv=none; b=CDbvhte2UyrdmiB5agG7xHbTPbvmEArP2U6AE7oiiDfX7na0yVorUogHq3vWGmsSS7H8CBfD3FObHas4ZCUm3Jpw97b2HS4ruCQHp6k1xx9pK/1+l4qlVAt0ik9eYXCmR7femNCT0ha5Z9prRowitJuQVRc5NC5As0Ca/V1xmdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262149; c=relaxed/simple;
	bh=QJemTMFb6jYPUyyQJDpGn/btz/pUsv6thE5HbhiN6os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uO5/ckcU4E0FfvMdK0VAyYLJUOx2JXBPsOlpT9F0FFoT47bfuMORoRVZMhp5HL7qXESfmgmrsXDSF+6zo6qYjoTPSPGv4a29CD/+YESJpIAdvZCdORYcRm/LXq/Y0S0UMeRTkRdd8mJBBv68OXgeSZZSwocp+QRPn8uWCDU7Hw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ti+c624N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EY2OpawS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ti+c624N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EY2OpawS"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7ZTt250328
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=t2TR4f3LBEz
	godoIcvRa429BxbIsUho68JNVhjuQGpM=; b=Ti+c624NfkLdR8tGgILao5rXW9R
	nLxdp0hYBTBhxQpsbCJeoXIrjsf3p7NeVi2uAnB3JHwr6c9kFACkMLDWZpXg7zcB
	zMACLGkkLD2R+uF4K6flKIn33w/wPG6wmUN9yYS9Ip8ULUXCEAnDnC36KAWOtLCl
	HIpw5ifK4LmzMTXDPSlkCvbS+2pzaO7yyj3wvBDCcucII0zVwGuQC8QVTAv+ofO3
	IeVNWeLdhoBEvJL9m94XjjMsa6gnCFvOYe7FogMd/nRLG70jG13O5fT4kJCsz5iV
	Fh3jPjgOBQa9mK6ydwuRNVG39eHXrMaZ1+eKkTo+H7xNFhq2ZmAG1sAvVIA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5w49bqrc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e538afe65so39952985a.3
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262145; x=1787866945; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t2TR4f3LBEzgodoIcvRa429BxbIsUho68JNVhjuQGpM=;
        b=EY2OpawSX+pals/nkapzzxdP0mZxIS5Z9pAXUmlLXyENXupw4gGqDJdnY2ri7HqgKV
         hCqKzM1rbMz2RygscVv1FChMOIKDBgD0bCgTBLxoiZn+AaxzSrFZwWSfWTlCCPPW51gO
         F4ZJTiUILeZaYygAZzy/TQiOB4Vu8Uc/Vd87QVEU9OKsaQ/M/fM77XiVKA+RjRRUhjXI
         EV0RYkOqJterRIT3yH++dbWOTw3V+qnIIGKDTyShQw3jl5mb5Ad5NvSe8JLvHKnLtLe1
         QxMwSW2cTC1PR+/wicGUtKM61JWByGkKMmB0QevYh0aB2727PmXmxnozm5LvaWKP/Vrh
         NBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262145; x=1787866945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t2TR4f3LBEzgodoIcvRa429BxbIsUho68JNVhjuQGpM=;
        b=NCmzkAaeqIiQDTvYJhXM/legy2uNrTdbUyiSRCdrA33FSsFWfpTABS3O8AQHVBzITS
         Iabkz4mWTG03C+f7XFasH5q7M47CyPhb9d2yPuSmWLZ+j+LQPlga/2MA54lzkObjfJKC
         5bELhuHYx2b/qHOQ4hIHKi9NrOnb33kZXW6vLwtNjMkO9UAlTS6ZXCUmbrWsVJMYFVEu
         plcuaq670/lCE9w/w+ZcOqcC+zVRyJHSzUpMk/McK+IFUxE+Q/JBRiZXCw2P0sy1mley
         vUMbcr27O+jbwX9Ne5HnoTAPc2VJ+bx/SWAEqrdJ9UO+coK4WcWm87nctnl5vAeq261k
         jGRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYxsz3+0jpjmQDMKjMs5gK5Y4tp1hEEBG0OM7dweeQYnUvIRymgIiiJh8JQYwV32bptnbg6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8Y1RPFE4misTQxZXGyxQxqBuVPqIMvjcXw3/g3yXZEuVdrfga
	dmeTC79dVASpzA+zHvoJok+Z4xV/AmYvQRu5dmZCI3BJF1DnweoRQUZzMtjA7ed7qLptFF5Eh/n
	FObHqq/hib2iA8oY0wIe1iulR1315iHiN59FhO36m5m1drju8MVb/9LU8Hg==
X-Gm-Gg: AR+sD13H/o7p3sClAWiieZmWEen/XXVQ+0hAU7/JLTCcwgbw7W75vx7TpJ75KpbtpFb
	RZ/J0Y1OKow/SX5JjUGLFUECUF89v/tpxEtWsJeJnrGLKo/j+6JgGRftpBVCz2QPHR/EOMxqA8n
	Ti+hnV3KzR7ltEiYtZu1MfUHyF+i4Y57G4tEM2zv25BbRwJ/ISw7FNFWwOxLv223yeSGuIB7sS7
	TeskXMscXnP6GweW6WKlPxnCzytq9wZrN3XOxiY7dHNUjQVY9oGn+5ZJiM5Aq3Sok/u8IsiDrIl
	4P3cEFihqdkdlIgHs24ndJDmgC3auyF2+YD223cmPFhgy3HDzRwekRgNFCJyRp+LyIuFtybF3YJ
	hyRado9rw
X-Received: by 2002:a05:620a:f81:b0:936:ef9d:2c74 with SMTP id af79cd13be357-93739553775mr98882285a.30.1787262145437;
        Thu, 20 Aug 2026 14:42:25 -0700 (PDT)
X-Received: by 2002:a05:620a:f81:b0:936:ef9d:2c74 with SMTP id af79cd13be357-93739553775mr98879085a.30.1787262145043;
        Thu, 20 Aug 2026 14:42:25 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b915cda6sm8426015e9.14.2026.08.20.14.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:23 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 15/21] iommu/riscv: Remap IMSIC targets during MSI composition
Date: Thu, 20 Aug 2026 23:41:44 +0200
Message-ID: <20260820214150.545737-16-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX8rKXtDlRSQy7
 C1fwsNPoArwC1qarHATliHBmOqhoZ2ePcFa+UmecD3dunh5YhiY8Ek3rzrAt3ACW9j3SZP/gsMB
 7zcK7rnOog58/bH56i/7CBbblswrfQg=
X-Authority-Analysis: v=2.4 cv=YP+vDxGx c=1 sm=1 tr=0 ts=6a8774c2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=M3ErguzUVTgPgCfcrBsA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: -wxbD6G41dwzsfI3ea9A4XEQB2mFSlcz
X-Proofpoint-GUID: -wxbD6G41dwzsfI3ea9A4XEQB2mFSlcz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX8Dtdu1BY/tMf
 RnJZjDXe0tnInl1MRY/5FmV6Q3rXJiprvJFwYZnJ11T0h0MgDPY8KqJBsco0MxodN+HcotoydAK
 leH9rd0BDSsmupylJIHJfvoSxKffOPDQFn8ybpd5cSS31wJheIpALT0hi7ruh0cwQkFIYCGvG4E
 tJtc3BDqleOtSTsbAZdS4JcIdFv4/2snOGhPOzDMsbc8KeUD/sDaE+ZY4A9x/Eg1GO22/2sx7uu
 nX/dAW7pTLm4I4+9KHx7Ox/0jtJWnq1/Ya6YNKi8I/rCKb43MhpOBJQkLPfVXIFiEp2agVnnwTq
 0EjWgHGPMbHaWkcF8yqAf9qjNQUt23tQRVYxMUJjnFUgVBOt1WnaQ8B98b/ASWWQYL//wyjYUAZ
 87Pfw+5jclc4Sopi3vX15pYWSQHjitipWXqeTIAEyZdb8ZHjdQEERcEA9GgFezcmC891zmtDXzy
 nL2fQA/Op+xLv9JN3hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200162

Translate composed IMSIC target addresses through the attached paging
domain's pre-mapped IOVA table. This keeps affinity updates on the
interrupt hierarchy while directing device MSI writes through the IOMMU.

MSI composition may run in atomic context, so publish each fully built
table with release ordering and consume it with acquire ordering under
RCU. This permits lockless lookup without exposing incomplete table
state.

When no translated table is available, retain the physical IMSIC target
for domains that do not use MSI address translation.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-ir.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index f61b65f29888..dacaefa62859 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -99,7 +99,8 @@ static int riscv_iommu_ir_build_msi_iova(struct riscv_iommu_domain *domain, stru
 		}
 	}
 
-	domain->msi_iova = msi_iova;
+	/* Pair with smp_load_acquire() in riscv_iommu_ir_compose_msi_msg() */
+	smp_store_release(&domain->msi_iova, msi_iova);
 
 	return 0;
 
@@ -108,12 +109,50 @@ static int riscv_iommu_ir_build_msi_iova(struct riscv_iommu_domain *domain, stru
 	return ret;
 }
 
+static void riscv_iommu_ir_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct riscv_iommu_info *info = data->domain->host_data;
+	struct riscv_iommu_domain *domain;
+	dma_addr_t *msi_iova;
+	struct msi_desc *desc;
+	phys_addr_t pa;
+	size_t idx;
+
+	BUG_ON(irq_chip_compose_msi_msg(data->parent_data, msg));
+
+	desc = irq_data_get_msi_desc(data);
+	if (WARN_ON_ONCE(!desc))
+		return;
+
+	guard(rcu)();
+
+	domain = rcu_dereference(info->domain);
+	if (!domain) {
+		msi_desc_set_iommu_msi_iova(desc, 0, 0);
+		return;
+	}
+
+	/* Pair with smp_store_release() in riscv_iommu_ir_build_msi_iova() */
+	msi_iova = smp_load_acquire(&domain->msi_iova);
+	if (!msi_iova) {
+		msi_desc_set_iommu_msi_iova(desc, 0, 0);
+		return;
+	}
+
+	pa = ((u64)msg->address_hi << 32) | msg->address_lo;
+	idx = riscv_iommu_ir_msi_iova_idx(pa);
+
+	msi_desc_set_iommu_msi_iova(desc, msi_iova[idx], IMSIC_MMIO_PAGE_SHIFT);
+	msi_msg_set_addr(desc, msg, pa);
+}
+
 static struct irq_chip riscv_iommu_ir_irq_chip = {
 	.name			= "IOMMU-IR",
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_compose_msi_msg	= riscv_iommu_ir_compose_msi_msg,
 };
 
 static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
-- 
2.43.0

