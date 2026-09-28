Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3044DDB4A
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606278; cv=none; b=RrrgGuOUE6l9bDw2+cEFM5TWshiH9620Tm8pxqCOuVhebQejy++jdnmZRk5RdsWp2KtX3zXkFoQ8q7vTMthPvz0b17R1MZGjEM6IGlWZIetrlMjVbTvC699O+R9xx3C7uY3ZHhL9LKuXlATo/B9StU78KDXy/pTEmkjyEL5uKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606278; c=relaxed/simple;
	bh=yjSyVpAuKGH9gMGCFpQtURI7YjmlqFUcCzwwT3vYzks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbrylU1nneSBt+1EwdpPqsfw53gBiKsLQY8zLeaWY7tnbo51e45vefABPCr7ZVs4vryCXJfzqGN5S10EMpUuSd+/K5BBCMDXFEspxMcox/IABvFtzKqM+XyEyjGST+u4rRVAxPEIrhM6py98ZihL9Y5tu+YZYFUA6Qns8W36BNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A1khsbUY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dLBWJmEA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A1khsbUY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dLBWJmEA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAAVZ1189370
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g7ykt7LSEJe
	/IvR1ZzOjMBU3wKZ7WY6AweTJQ2yjaag=; b=A1khsbUY53TyX+IouxKKcQgcDYK
	8RmG3YIwh2qQRPk8L9AOg75iU5OhtzUQo61HU6vp30hzLq8NwzUNx3kABtBGg8bB
	zFC3VvlPM/YcW73HckfLlY8b6h1eHSfB79tRRdkKLZYXGZvUlzpOCqLolVE/fOMz
	9SDa14kaU0pqJkAuyegYSvTOjpLEQO+VzjNVEX2T6oCjSEhv0VsItB82zWcvTth0
	KSM3IeTuI+7qhUIK0Vdgz4ClN4LxsH7fpUi4hsp+TVNP04VOUCVNboUePJxH0T4v
	MDK4OqUJJhF49TuMdt+sEFKGLQ5SyOyP5hOVkMx67Z2RNROj3R9QZAJNVzQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc16h7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:37:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5328dae1305so37897261cf.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606269; x=1791211069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g7ykt7LSEJe/IvR1ZzOjMBU3wKZ7WY6AweTJQ2yjaag=;
        b=dLBWJmEAwMIzsosHYvT3ZSaHr/IIBeL59xAJ/Ye8pRJa24kOieCe0N0br2q6+Vlpxb
         Ht80nPXo2pDxypIZP46R0WUqeqqw152kyK7sLi4E63GYLGpAnUPQHCkJYF8G6Gq5DdvM
         7ZZBANv8/kleqbh/ERpkF02BkzsgBKJ8sb94lw/xXAS9ShvLAOqKH4fZRB0ezprAfGlW
         S4XhKKFFB/j5swKrMqguEbjaS1tbRDUXbZqjAgI3kXE6GuMZJFrCjsDx4QN0nr59MKNL
         PhkyiQ/sCc0m+IcQ1FVYyAEkH1SyzBEUtEl4kEWI+ha1XiMzbDoMcqRqMSWXvvNsJyE+
         Fw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606269; x=1791211069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g7ykt7LSEJe/IvR1ZzOjMBU3wKZ7WY6AweTJQ2yjaag=;
        b=ZfEUZkzyr6wgaU6rMzsr9CsoyHKzV/x0m3y0Eqfjt3iLv6Z5dTBQpKEiGgA8GtcOR4
         gitQNR5WumQp7z1hzmWHbLlmSwue6UQm7n3U+Xylwof6lP4/ZF+V1BADKL/R8+L8Bnrb
         2iG2xl5Xola8T4yr9K21qHaywId/I0lHLsK14RarFhlBO/nKoZvudgVmxY0aC3FnFG5u
         CkkNQwRtlPHOQdtvxOR7Ns0VpbCMObUKXVtgLNP2ZkJG8lusLsj8E01LJMZbIjohCF7u
         HLI46yIQNBg2fCJ90NCLz/3O4CaaX/WMzEh45yOseHvuRjJoJZUKxfgmnKhC3vvJxQkJ
         iZ6g==
X-Gm-Message-State: AFuF++nt9T2kc0fExxTnl3l1nA49U0CNs3VSZVELng2H0No60AuLXQtd
	mfyqKTTlkhqjLVBFlwBrWSB1TXUWHxTHbxgsxnHx0KQbsmzbIuEorICGZV86ZbwEnN/ElPXCLkP
	cDetK6K54U4DEEbuO7fhoyHqh3RwrIRpAz+8NbMrjPWrm0Rd6mX1apTp0W5Rt5gtyrA==
X-Gm-Gg: AYBFou05Dr6pUvXJg+kicj2eIWV44FwuZO2wrN9RRYIMk+RMa6yIvjA3mboD4eyGo1c
	NKVdGD7TxHF1V/mBrJ0k+Goaf6yinpEQOK8zhoLsKwg8n9OMGeAlH0h2tf/7sIeSxA7e74gLgVT
	FlxKFyoA6lu5QsHLMzY5ud8owADlHLbIBnM3/uc8Ms9am0meAVfL4UjtQf8fEANs+CZjDkRp46G
	x/xyQxAP039N+cjC/DANJjfYVSd8YCWCeYW4C8roZD0BMdkvwbEhLOlP4SK8S+TF8H5QwjeMT53
	topwvvgf9NrFfuPlAWzs5V8Bxc7yteyIMvWELl36kqViZ7g64OLp6akEMSobQ3qs/GXxe3/WJNO
	RJXLmZ+5baVDkiVatuZ/uwfEHRjDAMMazOenkyQ==
X-Received: by 2002:ac8:5a86:0:b0:533:35aa:700 with SMTP id d75a77b69052e-53335aa0b59mr108962041cf.50.1790606268808;
        Mon, 28 Sep 2026 07:37:48 -0700 (PDT)
X-Received: by 2002:a05:6102:32d0:b0:7b2:7aac:8ccf with SMTP id ada2fe7eead31-7b27aac8d4bmr3266533137.29.1790605937424;
        Mon, 28 Sep 2026 07:32:17 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dcf626b3esm211882366b.27.2026.09.28.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:16 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 11/14] iommu/riscv: Prepare info->domain for concurrent RCU access
Date: Mon, 28 Sep 2026 16:31:10 +0200
Message-ID: <20260928143113.49838-12-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
References: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba7bbd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=YVOiLqTVN_ovv9J5ge0A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: F8W86RBO2uSF8cPlm1HUhcJV2b6E-0IJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX4kzdVjQ/yoad
 0rKPALNcUfofv0sgG3AQhRxiF2kuL1Z0mrd0mjT8n7yeLHUkernMgQvy5EErPscdWWWJc287Yu8
 lIbtEF45tJirGPXfpnzMpQRfj2bE52jE7obClUUwTV0jemd7NqXjp0IENcoeiy44OvLKHPwTuSM
 x5Me/ic3sDYMEyTrXQfGyyBjtfhqiq1cJEOKeUI58r51n+rB4uCXOhoe6j0HH4ofj6yF6L+UgDp
 jk7Jq4xSdJm5k4MNCxQ/VCoj/7gjayidyEnL0/1w2MgNQKEBjSpF2Byp/iNwpgKb2px6SvKpn7V
 Um2VB+NfxvOFg98mUFXRswWWRx0otXej/DWg5vObS55TWrNp05Eic0shhdRZ+vYTFL3yucmAuVL
 DnurJMY9UrKGP2dGeGZJ+vI1t6jxt8hLLhfG3eVniQuw0Eo9kWnLgB8NmZYQDsC7Q7fGXYAWnkx
 S1nogI0TthSQLguNXZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXwk+h27XHlD+O
 eVwTvRvkwCnNwMLylBtlsp0RIIf5FGgpMAs9EcZSrvviNvqXyg4fUit7NBvdJ+2GDu0jHt9GVuZ
 YUf50AvLwK0rZMroxOa1RD1JyKTuuAU=
X-Proofpoint-ORIG-GUID: F8W86RBO2uSF8cPlm1HUhcJV2b6E-0IJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280058

Upcoming interrupt-remapping callbacks need to resolve a device's
currently attached domain from IRQ context, concurrent with domain
switches.

Protect info->domain with RCU and wait for readers before freeing paging
domains. Provide an RCU accessor for the domain-owned MSI table so
interrupt-remapping code does not need the private domain definition.

Use the stable old domain supplied by the attachment callback when
unlinking its bond instead of dereferencing the now RCU-protected
info->domain.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 34 +++++++++++++++++++++++++---------
 drivers/iommu/riscv/iommu.h |  5 ++++-
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 7a8b40d311ea..514470291fd9 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -869,6 +869,16 @@ PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 #define iommu_domain_to_riscv(iommu_domain) \
 	container_of(iommu_domain, struct riscv_iommu_domain, domain)
 
+struct riscv_iommu_msi_table *riscv_iommu_msi_table_rcu(struct riscv_iommu_info *info)
+{
+	struct riscv_iommu_domain *domain;
+
+	lockdep_assert_in_rcu_read_lock();
+	domain = rcu_dereference(info->domain);
+
+	return domain ? &domain->msi_table : NULL;
+}
+
 static struct riscv_iommu_msi_table *riscv_iommu_domain_msi_table(struct iommu_domain *iommu_domain)
 {
 	struct riscv_iommu_domain *domain;
@@ -968,18 +978,22 @@ static void riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
 	smp_mb();
 }
 
-static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
+static void riscv_iommu_bond_unlink(struct iommu_domain *iommu_domain,
 				    struct device *dev)
 {
-	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_device *iommu;
 	struct riscv_iommu_bond *bond, *found = NULL;
 	struct riscv_iommu_command cmd;
 	unsigned long flags;
 	int count = 0;
 
-	if (!domain)
+	if (!iommu_domain || !(iommu_domain->type & __IOMMU_DOMAIN_PAGING))
 		return;
 
+	domain = iommu_domain_to_riscv(iommu_domain);
+	iommu = dev_to_iommu(dev);
+
 	raw_spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(bond, &domain->bonds, list) {
 		if (found && count)
@@ -1415,6 +1429,8 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 
 	WARN_ON(!list_empty(&domain->bonds));
 
+	synchronize_rcu();
+
 	if (domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
 	if (domain->gscid > 0)
@@ -1577,8 +1593,8 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	info->dc = dc;
 	riscv_iommu_bond_link(domain, bond);
 	riscv_iommu_iodir_update(dev, &info->dc);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = domain;
+	riscv_iommu_bond_unlink(old, dev);
+	rcu_assign_pointer(info->domain, domain);
 	riscv_iommu_msi_tables_unlock(old, iommu_domain, flags);
 
 	return 0;
@@ -1732,8 +1748,8 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
 	info->dc = dc;
 	riscv_iommu_iodir_update(dev, &info->dc);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = NULL;
+	riscv_iommu_bond_unlink(old, dev);
+	rcu_assign_pointer(info->domain, NULL);
 	riscv_iommu_msi_tables_unlock(old, NULL, flags);
 
 	return 0;
@@ -1760,8 +1776,8 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
 	info->dc = dc;
 	riscv_iommu_iodir_update(dev, &info->dc);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = NULL;
+	riscv_iommu_bond_unlink(old, dev);
+	rcu_assign_pointer(info->domain, NULL);
 	riscv_iommu_msi_tables_unlock(old, NULL, flags);
 
 	return 0;
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 4c1c681ba2a2..ed973979d795 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/iopoll.h>
 #include <linux/irqdomain.h>
+#include <linux/rcupdate.h>
 #include <linux/sizes.h>
 
 #include "iommu-bits.h"
@@ -85,7 +86,7 @@ struct riscv_iommu_msi_table {
 
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
-	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_domain __rcu *domain;
 	struct riscv_iommu_dc dc;
 	struct irq_domain *old_msi_parent;
 	unsigned int nr_forwarded_irqs;
@@ -100,6 +101,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 
+/* Caller must hold rcu_read_lock() while using the returned pointer. */
+struct riscv_iommu_msi_table *riscv_iommu_msi_table_rcu(struct riscv_iommu_info *info);
 void riscv_iommu_msi_table_inval(struct riscv_iommu_msi_table *msi_table, unsigned long addr);
 void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table);
 void riscv_iommu_msi_table_update(struct riscv_iommu_msi_table *msi_table, bool activate);
-- 
2.43.0

