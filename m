Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707396;
	b=Gjjl2RkRcmXDyhFYFx5++bAj8lTOZZDEBKLvGMDRqjn3GHjE/5fB+rn6yYCFWiVXtwan
	 blKc3u+b6IiDojaRC/PDSB1d+4SZGy6NmcaTcGzb2f172fc/eThnsPrny+29043W56z7E
	 wLAlY0zQARiu9my8202gBusisq4qnwAWSM/QyuqhT8AcpJNQ8ifvz/weRXJlYMezjRBzE
	 Umz0qwGmzGx76pQ1Gz6zxpoA7Air/dTq93L4NVIjXcdGrxIbT+uEAxkVybEW1nmkyQnmV
	 S6pQFok407R/krbPXFmXpbj5FFxCvXT1P/tB1bTzuLLV9t6uzWpfb9evM6QflfNzPAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707396;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9rfG8B97sjeTTjA0eUoy55WlemACgXA3zSFldzaZYdk=;
	b=ZydsFzIYAbHkLVcGxi0xNYdKROPoX3XwMV69FDzaqeiHACerRKY0KnKm6EKB7HlrAve9
	 MTstLCjATfqm1X23HLfDM5Vp1+I/mZ/39YJjkxFI7QLedGg9QeM29Kkn/KDdW5Vj1RuyY
	 5CwQI5GB2t4FB3ydL2WIzoO9TbFxVdEFyanauJ38NTEiUd9lpS//b0LOINQw2O8qOP5tp
	 5R7TDoAbKulzUAC63sn6zwZQeDKDRfwTp7TDwVoVIVmShaySEjXxcUWfwIvRf/NLGFziY
	 PLGlbmP1Vao23uZZt2Wbm0CG42ip1jWRMOTqWWDmeksg8+sLVWtKKPQGIzhu2UbwGPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZpxehKK5;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C04606A331
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 12:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87C04606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZpxehKK5
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793707393; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9rfG8B97sjeTTjA0eUoy55WlemACgXA3zSFldzaZYdk=;
	b=ZpxehKK5uYo9wylmW9+2xojy0r5hWkyqoDgH89WHSGscuAx67LQ8BfPJvvnf4EtVLAMBm1UMAnH75MiWRWGkrmsyPVVDDPNhlNxd3Su2ThE90vpxLZGgQ2wYgpEVMwIoa0KmJ4RnY7uy1VrpzYWQ1JOyJfG3ToJIiK6XA4yQl04=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0XE2qH-i_1793707389;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XE2qH-i_1793707389 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 20:03:11 +0800
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
	andrew.jones@linux.dev,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	atish.patra@linux.dev,
	skhawaja@google.com,
	vasant.hegde@amd.com,
	joerg.roedel@amd.com,
	tanchi25@mails.ucas.ac.cn,
	gong.shuai@sanechips.com.cn
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v7 06/10] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Tue,  3 Nov 2026 20:02:32 +0800
Message-Id: <20261103120236.53474-7-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261103120236.53474-1-fangyu.yu@linux.alibaba.com>
References: <20261103120236.53474-1-fangyu.yu@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
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
index f7e4d0f9b156..13552cfc2cd3 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -28,8 +28,10 @@ config KVM
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_GENERIC_PRE_FAULT_MEMORY
 	select VIRT_XFER_TO_GUEST_WORK
+	select KVM_VFIO
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
+	select SRCU
 	help
 	  Support hosting virtualized guest machines.
 
-- 
2.50.1

