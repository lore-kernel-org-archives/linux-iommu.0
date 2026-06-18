Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE53D0C03
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768030; cv=none; b=H9ED9V7ofC+wkUrICokYxmJd0f1JlQPXSaK7vtfUfoOn1uEYJPpkEuG11g6egt3AuFu3CqcvnjTA4W19rpAX3o2PUzo+SmsCxA+PauZdiAZHIJpUrjWLAfcCuOP6sAZFkwgzbOPSQb/2K+TCOaX5qrHMl2EJOcAYo2S6clzVQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768030; c=relaxed/simple;
	bh=JmyXY+NOEPjRFDg1y/+SFvtnm5R3Jn9ZGcpam+ur3N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jk30cs+srLVKiSY/EGslzYUhmfeK9io1udAhlZUPrHVZmJ+Vj+tk1aa13vfmEu2BBUYQQ670yOYVNy4d4d54U8qcNH8g63KdgFgn05RjFpmz1UjYLcq2Efke3S9n8se+g5+tZSHmc5gKR3QPz3QLIpd0iIHZjLeDoJHA+XkAL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.107] (unknown [123.118.218.239])
	by APP-01 (Coremail) with SMTP id qwCowAA30MhJnzNqCH4tAg--.7817S2;
	Thu, 18 Jun 2026 15:33:29 +0800 (CST)
Message-ID: <e051d822-d0be-4a88-ba86-ec9b5905fd1e@iscas.ac.cn>
Date: Thu, 18 Jun 2026 15:33:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: Guo Ren <guoren@kernel.org>
Cc: zhangzhanpeng.jasper@bytedance.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
 cuiyunhui@bytedance.com, iommu@lists.linux.dev, joro@8bytes.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 luxu.kernel@bytedance.com, palmer@dabbelt.com, pjw@kernel.org,
 robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org,
 yuanzhu@bytedance.com
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260615123821.373248-1-guoren@kernel.org>
 <7c490aeb-a3d9-4fe9-81de-f9662577851d@iscas.ac.cn>
 <CAJF2gTQ+-gpvUDtOh99aKP2-iDJy3MYOWti9k2Ntd0-J0MXqxQ@mail.gmail.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <CAJF2gTQ+-gpvUDtOh99aKP2-iDJy3MYOWti9k2Ntd0-J0MXqxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA30MhJnzNqCH4tAg--.7817S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr17uw43Kw45KFW3uFyxAFb_yoW5AF17pa
	n8G3WUKF4ktr1Iyw1qvw1xXay5K34vkayUCr95GryxZwnxZF15twsFgrW5C3WDJr1kuw1F
	vrW2q34xWFyDCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU56yI5UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 6/18/26 11:45, Guo Ren wrote:
> On Thu, Jun 18, 2026 at 11:20 AM Vivian Wang <wangruikang@iscas.ac.cn> wrote:
>> On 6/15/26 20:38, Guo Ren wrote:
>>> Hi Zhanpeng Zhang,
>>>
>>> I noticed you posted a similar fix recently. However, I had already
>>> submitted a similar solution back in September 2025 [1]. It would be
>>> great if you could review it. A few concerns with the current patch:
>>>
>>> 1. Using spin_lock_irqsave in such a small semantic structure is
>>> unnecessary. IRQ protection should be provided by the higher-level
>>> IOMMU driver interfaces. Many existing call sites already handle IRQ
>>> disabling, so adding it here feels redundant and adds avoidable
>>> overhead.
>>>
>>> 2. More critically, the RISCV_IOMMU_32BIT_ACCESS Kconfig option is
>>> problematic. According to the RISC-V IOMMU specification (Software
>>> Guidelines, “Reading and writing IOMMU registers”):
>>>
>>>> Registers that are 64-bit wide may be accessed using either a 32-bit
>>>> or a 64-bit access.
>>> This clearly requires that any hardware supporting 64-bit MMIO access
>>> must also support 32-bit MMIO access. Therefore, the IOMMU driver should
>>> be built on a 32-bit access base for maximum hardware compatibility.
>> I agree that the driver should be build with 32-bit accesses to support
>> these hardware. However there's one minor thing that I want to propose
>> regarding this, for the sake of clarity:
>>
>> RISC-V IOMMU implementations that do not support 64-bit accesses are not
>> fully compliant with the RISC-V IOMMU specification and should not use
>> the standard RISC-V identifiers, namely:
>>
>> - Devicetree compatible riscv,iommu
>> - ACPI HID RSCV0004
>>
>> This, in my opinion, is not only the right thing to do (not claiming to
>> be standard hardware without actually being standard hardware), but also
>> saves a lot of trouble for operating system developers (yes, there are
>> RISC-V operating systems other than Linux out there), since invalid IO
>> accesses usually manifest as mysterious access faults (that would
>> usually suggest an incorrect IOMMU address), or worse, system hangs.
>>
>> I would appreciate if the hardware vendors shipping 32-bit-access-only
>> IOMMUs would consider this.
>>
>> Vivian "dramforever" Wang
>>
> 32-bit MMIO access is explicitly supported by the RISC-V IOMMU
> specification and is a valid choice (64-bit MMIO access is optional).

Hmm... I think it's optional in software but not optional in hardware,
but the specs are not super clear on this. I've opened a GitHub issue to
ask:

    https://github.com/riscv-non-isa/riscv-iommu/issues/765

> 64-bit MMIO access is not "free" — it consumes additional interconnect
> hardware resources.
>
> Could you elaborate on the concrete benefit of using 64-bit MMIO
> access in this driver, for these non-PMU registers? A clear
> justification would help evaluate whether the trade-off is worthwhile.
>
>

