Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409434;
	b=BWWQPXl8SYcTVY35QAo2R7E7b/BsjI/FGK+5bmeWRLuFvrV99tFJ3A/TFuGgBdYQX77J
	 mcMcA43kmLHWFkq2ZGne/dxSGFR3rc/ChQ3fCbSlGeArPeNuac/GLJb8ACNYJM7rt5jVs
	 Oh+g17fXXKWPS1p0PDBXivcwnVwnuzjEjtrhJeDelmbi+qAasZgJSbAaRtElxH4J4hUMB
	 vQcQSq3E8BjoaV+a5dTYoCpxrl0VL/CyXy8SRj4Y62JcsH9pdcmzSQeFFRDaYVjYOSPvA
	 fGvJfZiIkVPeokmByEgJm2yTH8V7otznqlqLSKxRGDXQdXqfxgtPLlGDeuL1pJIttPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409434;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=RQw5QMudu7nxqgW+ejX3A9gWo/spZoR/ZUehK/P/8NA=;
	b=k99m8moa6kwoLWEjs6aSfpCZkJ2wN0CmI37LebFzyDn/Sthc/8pNO+7xd7ZWLFre4QVq
	 1xj/aDi87eSlAt6iJBTqfrTIyRuBA+7hMSgHtSNqJhBn8T4UeIuUY1BMRIMeV0z6cGsj4
	 nGxCrB95ZOLAsN4pCHjM7kAoNnTyBNltEJECLz4fSysZXhRcasHySJ03gNI4fqMIGtPot
	 FOyMSNZDvJN0LYB2xx4aaXBpuk4BFb29nipc3eoOoQTX/pEbOFubbsRrVXUl23JueuR+0
	 3DH2MfnheDBMjWsNrAknWDKfAp3689TW3VAVs4ARFTHHB4c+uAvDLoxaEdFdqkj6uhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mails.ucas.ac.cn;
	spf=pass smtp.mailfrom=mails.ucas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC32606A882
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 15:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEC32606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from k3-03 (unknown [159.226.43.8])
	by APP-01 (Coremail) with SMTP id qwCowADn1f+Zg_RqA8XNAA--.3086S2;
	Wed, 11 Nov 2026 23:03:13 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: fangyu.yu@linux.alibaba.com
Cc: tomasz.jeznach@linux.dev,
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
	gong.shuai@sanechips.com.cn,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v7 00/10] iommu/riscv: Add hardware dirty tracking for second-stage domains
Date: Wed, 11 Nov 2026 23:02:49 +0800
Message-ID: <20261111150249.13262-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
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
X-CM-TRANSID:qwCowADn1f+Zg_RqA8XNAA--.3086S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOU7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
	6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK67AK6ryrMxAIw28Icx
	kI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r4a6rW5MxC20s026xCaFVCjc4AY6r1j6r4U
	MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
	AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7IU0zwZ3UUUUU==
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/

Hi Fangyu,

The following QEMU patch series adds support for automatic PTE A/D updates through AMO_HWAD:

https://lore.kernel.org/qemu-devel/20261108143934.129923-1-tanchi25@mails.ucas.ac.cn/

It may be useful for the end-to-end dirty tracking tests mentioned in your follow-up work,
particularly for testing G-stage dirty-bit updates triggered by DMA writes.

If you notice any issues with the implementation, feedback would be very welcome.

Thanks,
Tan Chi

