Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319006;
	b=dVyJE8CsfmA8reZC4bMHMV9aQS0JMSzjHC9FLB4x3QNXOXTY6MQCx3sKcAz8d1Ps67jn
	 UqLzgEzzE1kwTeE6on5CaEMNeN3tRA3wT9mt+AQ7YZDdaO70dfWblH3OPUOEK+rrCC0Ap
	 CVXOuHdUYUx6F15tuWWwOVlHiSdGyTV/HTf7lSd8FRhMu5HpBnYxKps8Nc4qE1nHbP0SQ
	 xVCurkUxafTzW4wzHTRmWeqEEweD2HpxXXxHo5hb4koLZaj+nADMpXOyxd4fVi0pGKblf
	 f7HhkAz6zofYPYzfJqbM5VnF8APBJmOIzBeaYasbK6zUxFTRYKpflISK199p0ncUfjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319006;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=94ndYM1kjVKgjoAVq0PUDULzxUfWRci365+JE1N7eR0=;
	b=VM2TuNoAbYjhPc03h60XO7KbUuFjVh92xG0rCwekEWqq63tvsJddR5FBCKrJa/isecUU
	 1bGqhU1Bjh8Kk3F+IHM506OlWosdZyGYlYBBMGro9G02Q+FdraCD7FcKwf9Xl31UZyD9J
	 YcIeyUIpPU5jGYNQYHoFAMlLG8+TIbU31MocOo21gidUR1uuGH/NsFYPPKNWkRGYRUp0C
	 nBgOwyzTqxPfPUhAAaGIYTFt27fHKVmNoNlWWJidwc6kipoM6oT6TuGWeyptpeQIrI44T
	 MwD98hPZQuDefjr716twLgpmrw4G+WUNvz7RYazmSczC3jJjRrCJi0/P4WxNa1WZO0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mails.ucas.ac.cn;
	spf=pass smtp.mailfrom=mails.ucas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A0606A31C
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 13:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 398A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from k3-03 (unknown [159.226.43.8])
	by APP-01 (Coremail) with SMTP id qwCowADnEPuAIvNqimC3AA--.4018S2;
	Tue, 10 Nov 2026 21:56:17 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: gong.shuai@sanechips.com.cn
Cc: jgg@ziepe.ca,
	kvm@vger.kernel.org,
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
	kevin.tian@intel.com,
	andrew.jones@oss.qualcomm.com,
	fangyu.yu@linux.alibaba.com,
	wu.fei9@sanechips.com.cn,
	zhao.qingye@sanechips.com.cn,
	gsh517025@gmail.com
Subject: Re: [RFC PATCH v2 9/9] iommu/riscv: Add riscv_iommu_attach_dev_nested
Date: Tue, 10 Nov 2026 21:56:15 +0800
Message-ID: <20261110135615.8073-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115137.184160-1-gong.shuai@sanechips.com.cn>
References: <20261110115137.184160-1-gong.shuai@sanechips.com.cn>
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
X-CM-TRANSID:qwCowADnEPuAIvNqimC3AA--.4018S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOb7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j
	6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxV
	W0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_Xr4l42xK82
	IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_GFv_Wryl4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjxU4QJ5UUUUU
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/

Hi Shuai,

On Tue, Nov 10, 2026 at 07:51:37PM +0800, Gong Shuai wrote:
>   2. Use the guest PSCID directly, but allocate a separate host
>      GSCID for each vIOMMU.

I agree with option 2 as well. My earlier suggestion did not account
for independent PSCID namespaces across multiple vIOMMUs sharing the
same S2 parent.

Allocating a separate GSCID for each vIOMMU seems simpler than
maintaining an additional PSCID mapping table.

Thanks,
Tan Chi

