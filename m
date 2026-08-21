Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA34302FC
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318894; cv=none; b=YebV1/ODIKLfb/EHJkIs2eg69OpVSvV+WmUDzUmJyaRHh1Sq+//EKjoiHnuW6VB5Lk7Ow+q+BpD1apPns1sCyKFauKW1RpyR49gfIC3YQWO8nfFBy3Oa7HJ/TXHAbZFqXfub0nR/pjdM44v4J4OG6kYlOWH5kf0NviV1A4LXgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318894; c=relaxed/simple;
	bh=TJtwwmOes+WMqZV10KyeFqw49c64kqL7395J+MxsNMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D5cZ8pTrK1CKUozmML9cyP0f+gu01Q3M8PnrPT2uwoOCQG/x7rL2ktrAOPjuE9+T3BgsqE6Fwx33GHUrvvQ3xdFRE6tVC2zE2goL5K3WrriWJBOFl0/71Mbcrhf1skaizUih8WsLUZUThO28fpVjh+rX/FyShI5en4kyESIs6as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lp+u8VyN; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lp+u8VyN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787318888; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RWu/puVJ24xC3wGWoddID7UrDVPs6J4eX8hoo+uZKZs=;
	b=lp+u8VyN+Gi/+sKK5gNB30LJPwQIWrTkhXSEnU1NLlWtpJH5GRPJwNj9hndQvMqK9mOXr51XSuF9a83ksgqjX7ayQbb5+owYqdS/pfZRKQmJtQzo/hUSHHSXLlPoWLnfRuC1Ow1It/kXS0uEgj5ogXZGpsv1niIz7Gv5/5RGvA0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0X9MSFHU_1787318884;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9MSFHU_1787318884 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 21:28:06 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	baolu.lu@linux.intel.com,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	atish.patra@linux.dev,
	skhawaja@google.com,
	vasant.hegde@amd.com
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [RFC PATCH v3 06/10] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Fri, 21 Aug 2026 21:27:46 +0800
Message-Id: <20260821132749.82070-7-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260821132749.82070-1-fangyu.yu@linux.alibaba.com>
References: <20260821132749.82070-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Enable KVM/VFIO support on RISC-V architecture.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kvm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index ec2cee0a39e0..54ee90f010ef 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -30,8 +30,10 @@ config KVM
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_MMIO
 	select VIRT_XFER_TO_GUEST_WORK
+	select KVM_VFIO
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
+	select SRCU
 	help
 	  Support hosting virtualized guest machines.
 
-- 
2.50.1

