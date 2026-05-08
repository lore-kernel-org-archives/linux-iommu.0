Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF5A423A75
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275425; cv=none; b=XmISaynU3hS0rNs6DhlmvOY8XQvLBwE/D3WYB/+kscW3z+pFe4S/HRv9XO0Bd0B4CGmdMjvW9Dj+Dwm0ohvT1ebRmkQTJB28lZkXpfBWl/gFIH4O4LprwszqNL2f80pOp9g3JLucUSDX5v/YJfIN1Tv9zzJxn6/PcWHmQ++f5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275425; c=relaxed/simple;
	bh=GgeC5Fd4Why5p0pdcWHLYIMffpau36TFRveP0npbV+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a12gMxJP5z2DUe6U+PCesi/0AocuHqp0lbGB86Be1zCyyo6OalDJZolAfJgA6rcJQVHlPDTEZ4OOJAcw9QrKc53RIsdjrZTF65NC69BlFLWrNcawTd57Zy1m7avY1QRQyB4v6y1YPXf2klN+oVb5kve8/ez5NJEEz76ajNe2t6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z2G6dbVu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LG9enL2p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z2G6dbVu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LG9enL2p"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648G4JKQ1094018
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 21:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TSaG2TIUJEO
	ynWBne/qXacXwZRCzgp9U/qwVIoca2/M=; b=Z2G6dbVuPoycUh79bLNcRUEZcxa
	hZdGXo5RVcWWESNy5hnfIfvY6JS5p3lD4BGEwuL1gL5xO96GyTam4vfl0yXXGyhw
	lbipSE6MoCrQ0XJSxoiwu2xwrQXiC2vPG1h5qWVglQ4yMUa1QwYXqQ8d8r75qDyr
	7BQDH++Pi2xaZKufJyDrlxJYH3f+xW6Qo3dzaMEF529oVhDGNTap8vwbS1Bn2pip
	aNEJYnXxhpb1/qiMeOwNDR8pSbkEVxyLU2sGG68NHMoPe/2wwViFgLkawSQHaWtg
	SmJzFApee7kXgPqxnT+M9RRF1fSP/WNV6i1Nepf1viuOIAOZ4iVXY4NxXKw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k1d11n7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 21:23:43 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12dc3d81736so2506914c88.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 14:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778275423; x=1778880223; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSaG2TIUJEOynWBne/qXacXwZRCzgp9U/qwVIoca2/M=;
        b=LG9enL2phE4iHT8K8xAdwG2nvVZmo0nw2f+BkCSdqUwIlqGyz2Y6igjPWgv2M3rRx4
         OBPTZx7m5V+keVxvJL4oY7uuH66feUV9Vlu00pmPu2oc4UcMdAExBH8VpTlN/ZKcMtOJ
         ifl1LYkGjxsMReLap0xGhxHSSHpavNvZ1F/3iH6lG2HKfb8dh6jfkCnJgBSVfN81poli
         NUl8LeaqdvJRfW1Rot3XHdGzuG2gqydL4F8OohKU7FAq56f9W/9cZCMrJC/XGko2V24j
         SgEZrL0Dv7z43iXigyHA9516c8aGROZ9PFtD87Ym/UmNfU/JZEGHpx9oXHxB9DE6tOGP
         QfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778275423; x=1778880223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TSaG2TIUJEOynWBne/qXacXwZRCzgp9U/qwVIoca2/M=;
        b=Kuh695nIHXs9AftvWXHotkwKvXp6RSbwvBf/fXiKqBtF30DJTTxbTxbKw32U5SPdhG
         PwjPFsxGDN9QdPt0pKR467JA9mFgpDKWL7uULAs1v/qNv/irUfX7cVfdZP/YsPA9b4Vz
         XMoZMBNN1094LntT1sSNUIw3CymqdjlgVway5aa+SqmxIml7vM4PSHCo1zPj7iddOjq9
         sfeyddNS/YG5x05A0BOWzp9bjB+xpvP0k5ptte+VowEQqJOOkThd7O9IXS9uMg52jkpd
         gXQyQh3zifRmfLqEXANwjlA8/6cpf9QmkOYl6D+teYZw8WYHpcq7iW1RtqaE9hIOpFFU
         PgOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Qgs9Df/3yAX4MeWcpJTH2gysxnT29bpjzfyAaZe1mqKlb8isIdtebp2o2r9gYT+DvDANnRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtNbXpkee8x19W3IQpuNqKI7vyuFBW4KyDe9+mZTzqCloKyzlh
	hi952aNklJy5C4mOzt5ThSAKXD/185TWv3DTIURy6SJxvGuBltxjLVerzmoamsiiWbtkspL4SHo
	bZKpYaJoT+rV63cW4P9IW7mIPC0K5C5MOc0Do1bkktd5RZAtiJses2yMjX6VmDqYazg==
X-Gm-Gg: AeBDiet5Wqfn3ta+XAhCrCoKX+gVBGdVC93MX7aOds3KBHIpyTHaB94NS1WGdAh/o0w
	fEzEQzZLSMNoqObcJtqCUSpJ/0LZsDm9ClIUb0UQL8tIwByu1omaUOSw0ojn2e/d597m1f2KQLy
	T4FX9GKdJ1Bx+TsZAUWXoezsEqikkYhpnupEsjmhAhZPS6KRkwGli98GQPnq4lTxcEmv8pQvseR
	e0BJMUrHw8es/3WKK/ClReTEdU08G7WG18F2+7d26PLjEcTAD0xKpW3D3jtHi4RGVuUn2l7Kpfd
	5duk2x7c5L0vo5FX34rwPAuZEbF81OqPEjHJjn5YY6cfl5G6R5w0tEmi0/so6dGcMhaDa6N9509
	QTlR2/198TdJZFNr34L60h39mVethCcA=
X-Received: by 2002:a05:7022:ead2:b0:128:ca83:5aa3 with SMTP id a92af1059eb24-131967d7ba7mr7777518c88.1.1778275422920;
        Fri, 08 May 2026 14:23:42 -0700 (PDT)
X-Received: by 2002:a05:7022:ead2:b0:128:ca83:5aa3 with SMTP id a92af1059eb24-131967d7ba7mr7777486c88.1.1778275422371;
        Fri, 08 May 2026 14:23:42 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865700asm3984668c88.9.2026.05.08.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 14:23:42 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tjeznach@rivosinc.com, joro@8bytes.org,
        will@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org
Subject: [PATCH 1/2] iommu/riscv: Map IMSIC addresses for paging domains
Date: Fri,  8 May 2026 16:23:38 -0500
Message-ID: <20260508212339.381933-2-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508212339.381933-1-andrew.jones@oss.qualcomm.com>
References: <20260508212339.381933-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDIxMSBTYWx0ZWRfXy4J+uIQIk8ic
 WC1KWBP3gAJj69C11+jTybxLdDWHMm4OhpaoMa2MBkcoLMCROyl17yoauwEjcSZHzmbcv68G8Ha
 d3Ew+8XFf5s2ri/KPVB5LgwLKUHLqFTrNW8FHBuUu4cKFvcMMLvifvsr9h1E2IMM09EX8P0Fn5S
 Q7d8GpETFgXlMBcs2WR7gqIwBXAk+9yMhbQda/AkyLeCXYsjDUC+qpj3e78t1gRnVXqPg+5Xk6l
 wD4H4fCP8JiRFv52Vhx931FZH4A52bk3f6FRMP4gYIBV/g7ilAj9wlFDtBDIZn1qSkKBw/22iH1
 HMwAv8qLEeqVZhFxlqZ4QAxD7g0e1bRW4QvDoqpA+n75E3jSlQya+/VvODF+Srr/QY4hGv95t61
 69e0AbdtxlZyZKxvzFq/5RZCQf8y3OnkHTwekEwl9hIN4NaZimHXO0fZTo/7K/sABOJRhqgsff5
 l0sRreMrr93qRNAC6dQ==
X-Authority-Analysis: v=2.4 cv=GLU41ONK c=1 sm=1 tr=0 ts=69fe545f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=5LAesA1oWso2HGznwIcA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: F-098mmfKQ1v94retxuLFepMunpa99rr
X-Proofpoint-GUID: F-098mmfKQ1v94retxuLFepMunpa99rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080211

When IOMMU_DMA is enabled, devices get paging domains and MSI writes
to IMSIC interrupt files must be handled correctly in the s-stage.
As the device always writes to the host physical IMSIC addresses,
which the IMSIC irqchip programs directly, install s-stage identity
mappings for the host IMSICs. But, use IOMMU_RESV_DIRECT_RELAXABLE
since the 1:1 mappings aren't required for device assignment.

Loop over the cpus rather than imsic groups to handle asymmetric
configurations.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c         | 34 +++++++++++++++++++++++++++++
 include/linux/irqchip/riscv-imsic.h |  7 ++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index a31f50bbad35..3c6aa9d69f95 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/generic_pt/iommu.h>
@@ -1286,6 +1287,38 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	return &domain->domain;
 }
 
+static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	const struct imsic_global_config *imsic_global;
+	unsigned int cpu;
+
+	if (!imsic_enabled())
+		return;
+
+	imsic_global = imsic_get_global_config();
+
+	for_each_possible_cpu(cpu) {
+		const struct imsic_local_config *local;
+		struct iommu_resv_region *reg;
+
+		local = per_cpu_ptr(imsic_global->local, cpu);
+		if (!local->msi_va)
+			continue;
+
+		/*
+		 * The device always writes to the host physical IMSIC address, so install
+		 * identity mappings directly. Use IOMMU_RESV_DIRECT_RELAXABLE instead of
+		 * IOMMU_RESV_DIRECT since these 1:1 mappings are not required for assigned
+		 * devices.
+		 */
+		reg = iommu_alloc_resv_region(local->msi_pa, IMSIC_MMIO_PAGE_SZ,
+					      IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO,
+					      IOMMU_RESV_DIRECT_RELAXABLE, GFP_KERNEL);
+		if (reg)
+			list_add_tail(&reg->list, head);
+	}
+}
+
 static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 					      struct device *dev,
 					      struct iommu_domain *old)
@@ -1401,6 +1434,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
 	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
+	.get_resv_regions = riscv_iommu_get_resv_regions,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
 	.release_device	= riscv_iommu_release_device,
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index 4b348836de7a..ba3000f047b0 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -88,6 +88,13 @@ static inline const struct imsic_global_config *imsic_get_global_config(void)
 
 #endif
 
+static inline bool imsic_enabled(void)
+{
+	const struct imsic_global_config *imsic_global = imsic_get_global_config();
+
+	return imsic_global && imsic_global->nr_ids;
+}
+
 #if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_RISCV_IMSIC)
 int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
 struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
-- 
2.43.0

