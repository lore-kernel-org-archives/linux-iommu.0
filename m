Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890228;
	b=1jpxFSPe3HOADeYhumW4r50aUOFX1JkbNsHyU04UkAQacZDW6mKfHwTxNfEhbDfmrQLA
	 i6/20mpGLNqMrlW7+Sd/s+VewMxjoioPW0mjRCsovN3wKZnCs8ZvAfV82Ae8LH8hCSqM1
	 f1zgGoMkfRnqpqqD1M0D9ZIHl3K4LP2A4OOAqGMcxGMNipdl/u+e0PRigtzyrWHNA7lpn
	 eKhjc+5V9EUv3FROcqQtDkPEbSHM9jWDLjCcXkU8Eki9yJEbAmCYh6giQlHBNTaXSrr/R
	 PI/v+zXM6FBtNtCpcFfQl/C9QBKC/wxLHoUHL6cc7Xans7KVxxSOdYBhpljDH2rn0Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890228;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=CnKjFzowyt5YtK9g8a4fqFJqn6kC/XB1Nfz7/IvB6uk=;
	b=W4vJsBd6NtWGUWoLzlYoHgvaATqwHHBX3z/EiEKkMXojcZ4AzGEgAaw531BtdgvsSWgC
	 9ArTitb0FKCFNAIATVyjEvIJbqfrbXqnxZsasV2BgdfPadMkqlpcTp/nMbeULqxunqJQo
	 I6ciSETvE7MGLZmVZSq2qbw88wYWAOuPJbaX4QfUFZdl+aCmSBCBNW8aJeIkwiuYH2Lqk
	 LKXL2mvjzSRWHyZGK7PVPKtQroENLwZF8XdywVUwJ7ebHYQx31y7SOWwfIrX6EX7yRBOH
	 LCCBFLGb7Huq/AF33azL8Fj05DC8lBy+NcSYYBTnuOZ2fkizQkeBbX8bMbJtuuXko2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mails.ucas.ac.cn;
	spf=pass smtp.mailfrom=mails.ucas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB1606A33D
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 14:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAAB1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from k3-03 (unknown [159.226.43.8])
	by APP-05 (Coremail) with SMTP id zQCowAC3T7WIl+xqYLNgAA--.7023S2;
	Thu, 05 Nov 2026 22:49:53 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: gong.shuai@sanechips.com.cn
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	andrew.jones@oss.qualcomm.com,
	fangyu.yu@linux.alibaba.com,
	wu.fei9@sanechips.com.cn,
	zhao.qingye@sanechips.com.cn,
	gsh517025@gmail.com
Subject: Re: [RFC PATCH v2 9/9] iommu/riscv: Add riscv_iommu_attach_dev_nested
Date: Thu,  5 Nov 2026 22:49:44 +0800
Message-ID: <20261105144944.10193-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029061131.584453-10-gong.shuai@sanechips.com.cn>
References: <20261029061131.584453-10-gong.shuai@sanechips.com.cn>
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
X-CM-TRANSID:zQCowAC3T7WIl+xqYLNgAA--.7023S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar15JryfZr1DAF43WryfZwb_yoW8Gr17pr
	Z2gFWSyFn5XryF9r1kZw48GryFgF93Aa17WF15K3s2vwsxJ3srtrnxKay2va4SyrykX3W7
	Xw1q9FsrXFWUu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBGb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW5Xw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jDb1bUUUUU=
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/

Hi Shuai and Fei,

I noticed a potential issue with fixing the physical DC's PSCID to 0.

In QEMU, different VFIO devices can have separate stage-1 HWPTs while
sharing the same vIOMMU and stage-2 parent. This means two devices may
have different first-stage page table roots but the same host GSCID
and PSCID=0.

According to the RISC-V IOMMU specification, DC.ta.PSCID identifies
the first-stage address space when PDTV=0 and the first stage is not
Bare. Could this cause the physical IOMMU to reuse cached translations
across different stage-1 address spaces? Even broader invalidations
would not prevent such cache aliasing.

There also seems to be a related issue in patch 6.
riscv_viommu_cache_invalidate() unconditionally forces PSCV=1 and
PSCID=0. However, an IOTINVAL.VMA with PSCV=0 also invalidates global
mappings, while PSCV=1 excludes them. This appears to narrow the
guest's requested invalidation scope and could leave stale global
translations cached.

One possible approach might be to use the PSCID from the guest-provided
DC.ta when allocating the nested domain, and preserve the guest's PSCID
and PSCV settings during invalidation while substituting the host GSCID.
I'm not sure whether additional considerations are needed for PSCID
reuse or domain lifetime, though.

Thanks,
Tan Chi

