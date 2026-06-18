Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6641F30BB
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776921; cv=none; b=qM+lRwX1yMTRuGXE2AX0pzX29+5gudkzaIU434YtgnDyvzDJZE6y0+qLEKd92mWBy3VGpRM2P7QuPSCfKLfT6074XhL7NHTpsbzIELSVY/I9qqg/AR9MjBZXu8zhDqqD/6hm59pOY7KeLKHWnuSekXktxr0D9FaqeQ0XeR7vp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776921; c=relaxed/simple;
	bh=snWj25CZu4UlLlKljPv183c00k8IgTzMBpQr00K8YuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XesVQPiedWolHxuRg7hbMaX+ApSGQJHFXfVUdONbqBILpFE5wAlzybiM/c6aelG9fpSPKNN2CCuuSNZtPZw+nqC4UvUpQbMdjLeK4LN6LGZjGSZwfbO5no9ozb5GOYknWNzJTkNrswTWf8mm83ZqAuzKqSbIuCNO0P8w48igF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.107] (unknown [123.118.218.239])
	by APP-01 (Coremail) with SMTP id qwCowAC3WtMHwjNqx7MxAg--.8767S2;
	Thu, 18 Jun 2026 18:01:43 +0800 (CST)
Message-ID: <ce3c80ae-fca0-4728-a93c-778dcbab32f2@iscas.ac.cn>
Date: Thu, 18 Jun 2026 18:01:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: Guo Ren <guoren@kernel.org>, zhangzhanpeng.jasper@bytedance.com
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, cuiyunhui@bytedance.com,
 iommu@lists.linux.dev, joro@8bytes.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, luxu.kernel@bytedance.com,
 palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
 tjeznach@rivosinc.com, will@kernel.org, yuanzhu@bytedance.com
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260615123821.373248-1-guoren@kernel.org>
 <7c490aeb-a3d9-4fe9-81de-f9662577851d@iscas.ac.cn>
 <CAJF2gTQ+-gpvUDtOh99aKP2-iDJy3MYOWti9k2Ntd0-J0MXqxQ@mail.gmail.com>
 <e051d822-d0be-4a88-ba86-ec9b5905fd1e@iscas.ac.cn>
 <CAJF2gTRH6x78A3J5HJ5kUM47aDv8R0yFr8LRP+7jiLX4GL3ssg@mail.gmail.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <CAJF2gTRH6x78A3J5HJ5kUM47aDv8R0yFr8LRP+7jiLX4GL3ssg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3WtMHwjNqx7MxAg--.8767S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1UKry8tw1UGFyxZF17trb_yoW8ur47pF
	4DWFnFgF4DJr1IvwnFvw47ZFWfCaySkrZ8CryUK34kurn5uFy8tr47tay5Ww1kGw4kCw1r
	KF42g343Ca1vkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU8IJPtUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 6/18/26 17:51, Guo Ren wrote:
> Hi Vivian,
>
> As noted in the RISC-V IOMMU Specification, Chapter 6:
>> Whether an 8-byte access to an IOMMU register is single-copy atomic is UNSPECIFIED, and such an access may appear, internally to the IOMMU, as if two separate 4-byte accesses — first to the high half and second to the low half — were performed.
> Therefore, the atomicity of 64-bit MMIO accesses is UNSPECIFIED and
> not clearly defined in the current ratified RISC-V IOMMU
> specification. To handle this correctly, the Linux RISC-V IOMMU driver
> should fall back to 32-bit MMIO accesses when reading 64-bit registers
> (e.g., performance counters). The behavior of 32-bit MMIO accesses is
> more precisely defined in the RISC-V IOMMU specification.
>
> Thus, many hardware vendors implement 32-bit MMIO (rather than 64-bit
> MMIO) based on the current ratified RISC-V IOMMU specification, and
> this driver does not appear to benefit from 64-bit MMIO access either.
> Performance is fundamentally constrained by bus latency; assuming that
> simply reducing the number of accesses will improve performance is an
> oversimplification that ignores the underlying hardware
> characteristics.

Just as a clarification, I had never said that the driver *should* use
64-bit accesses. In fact, I said:

    I agree that the driver should be build with 32-bit accesses to support
    these hardware.

Perhaps I wasn't clear enough. I meant that I agree that the RISC-V
IOMMU driver should use 32-bit accesses. At *no* point had I claimed
that 64-bit accesses are better.

> Hi Zhang,
>
> The hardware targeted by the 32-bit MMIO access in your patch is
> precisely the kind that deserves the official ACPI HID RSCV0004 and
> Devicetree compatible string (riscv,iommu). It is rather the hardware
> that supports only 64-bit MMIO access — whose atomicity is explicitly
> [...]

IOMMU Hardware that supports only 64-bit MMIO access for 8-byte
registers has never come up in this discussion. If they ever show up
we'll talk about them then.

Vivian "dramforever" Wang

