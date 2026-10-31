Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793435439;
	b=JZuhJkFR4wmW39Elwhgls9s7CyjL3O6PRhB/NhMce4d+KOCjcCkLsWcQiKRekDRRCKH8
	 8x42vAu4MkltmNFddy6kR+H4ITOWBHSdlcVY+Tr9LerBO5mdpJrNhmVL7blgKqPbxK/Tj
	 eWERlL7cKrlkZYVLsAUwIllWy49pU7/aCCy0ovvK2xU00IUHccXm1c+PfliW+VwmR2/0k
	 ZZj5y/44Qv4OPIN63R+6jZCvyCiTs7wUET1JVYCcbW//+MH046KQYhzmF2DO134OgWGqf
	 pZmrTpBQNkXNnmsASWWeMOTT/+Mp0pVIBCmwapWhi3xT9tR4m1JK5llvSIyVHQIFPsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793435439;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q7H8hNLr3QrvgMDoVvUiwiv88IHAXA/9SeCjmVc/p7I=;
	b=ZGjidat9n0tHa2gb/DoTsUsVIjyg0/Q0pDR6ZXf6EqroDBw6MoAiHVZ2WkdMfi0E+Lvi
	 FCWh/XoRcmATF5p7hd5VXVmOQ/d9lRAkAEBL/ZgJt788iUwn2UvnacW7ZNN1yxMg+q6Kt
	 qNMEpcI0xm5nYQMWfTbkVHOH19qzZV6XillPJXIs6+A+H8nCqlOEAIfTJpYVSYtvPyICm
	 8+rJSEoGfeNmS9CDDd2x58KnV7HsrMSQSWUsJeh5lndRwaMbgakPCGxtOBwUv61ac7wJx
	 McZXe/5ANSwmHjw2p5VzkJUsS1CoEKi+QvN2MwYlignDG91CvaRc1vXWtfyQPwLixtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="Ia9/sKmV";
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E447E606A33F
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 08:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E447E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ia9/sKmV
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793435432; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Q7H8hNLr3QrvgMDoVvUiwiv88IHAXA/9SeCjmVc/p7I=;
	b=Ia9/sKmVT5P6bBDwpcuGidXid/mnqEa9QefabSYRTlGYvHJ4hKY59RSMI02yfKwbOmIC8zq3EdGhfZr1hodCO/KRC0MzYNzuzeYRAhucNB9Shkac1MudYJyEUM9cBy2i6U21jetTF8Fp0/tROvLomh6Mgq/gOQqZgOaDrBwNhlM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0XDo-2lz_1793435429;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDo-2lz_1793435429 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 31 Oct 2026 16:30:30 +0800
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
Subject: [PATCH v6 06/10] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Sat, 31 Oct 2026 16:30:10 +0800
Message-Id: <20261031083014.15040-7-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261031083014.15040-1-fangyu.yu@linux.alibaba.com>
References: <20261031083014.15040-1-fangyu.yu@linux.alibaba.com>
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
index 2e3c4e6c1cd7..4bc99cc0995b 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -27,8 +27,10 @@ config KVM
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select VIRT_XFER_TO_GUEST_WORK
+	select KVM_VFIO
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
+	select SRCU
 	help
 	  Support hosting virtualized guest machines.
 
-- 
2.50.1

