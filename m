Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0336CCCA47C
	for <iommu@archiver.kernel.org>; Sun,  3 Jul 2022 15:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A25E4148D;
	Sun,  3 Jul 2022 15:22:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A25E4148D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Ajde41bE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BVvhc1mPOXRE; Sun,  3 Jul 2022 15:22:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 76C854136B;
	Sun,  3 Jul 2022 15:22:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76C854136B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 298E6C0032;
	Sun,  3 Jul 2022 15:22:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B13DC002D
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 15:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FC4C60BBE
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 15:22:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FC4C60BBE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=Ajde41bE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jVCp2Sz_CuTP for <iommu@lists.linux-foundation.org>;
 Sun,  3 Jul 2022 15:22:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DDB0160BAC
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DDB0160BAC
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 15:22:09 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id n15so8182875ljg.8
 for <iommu@lists.linux-foundation.org>; Sun, 03 Jul 2022 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7h/oDkelqUvQhnXMEHsIGaLApBCL4bVp/zpTNjHKaa0=;
 b=Ajde41bE2wU0CLXRYXxA4RUv0bp0nc6vv24Jkv3jO+pNmgV5SruaUwkgdZh2uTckb2
 LjwBe+5chzPdn9GsqinhSMRPDH/BkAH/rWbDiCgv3b73DzTdIIwCuu7rSSyi6XgKQgam
 QzYkv4hEeMuDSoYQBiHL7V7XX8PuwVWoX68+MhlsNYB1tpAW+qusPDMIKzVjewkktdka
 B8RzQXojCPXGgXsFV0Py1qu3xQ+dQ+Ph5W2hTs/NfGpTe8YoyNytz8Jxlg3eba2Qpapr
 0dHtsjY/VCs3nDTxh/rSpBzNfE0J7lWIPD0uFnZAO2fN8qfYU1kzNyc0DtqVW3j5bPa6
 jQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7h/oDkelqUvQhnXMEHsIGaLApBCL4bVp/zpTNjHKaa0=;
 b=nXlw01g5HxsqWpU7HoZxEpWR0oxqIZZPq2R8Uhnfo5LMBqUZ1dmhyUV34PdfeneEdQ
 oN7zSMa3iIFzhqy9ySWJjTcmQPhIakrS0wTam6Fu3O6eHkuj8O/9dQVHSYkkM3pDnJnT
 3hb8W3VGusmVAQKb3JAtsOSGwkS28GHKcHYjEPzQkfChdcMv+FFwimwMOA0vtAfcgTJm
 nGi0JRBm+ifWIMoZgEmir10UdADvMp8HewU4PTOSZ9+s9y35/k5gbYlSMzerNhhCx08f
 dsqQKpmifasR8NDYiUybkpg5qWbS7VtN09QYrLl2K8x2c/dtFZXh3bPviiZRZW/StNu3
 4B2w==
X-Gm-Message-State: AJIora+RB6Tr5jGp4F214oQGnWmdJ84xqgZgiEBJjY6Gwu6DoFkSLi0s
 Yrya9izr2HizORI39al/R0A=
X-Google-Smtp-Source: AGRyM1trX48ruuzycgoteqtLbzXdO1QJTxFK4a9qaPKv/Ind+sZ8MDYf+3trOk+5IJ6FZryqObKQIg==
X-Received: by 2002:a2e:9941:0:b0:25b:c885:3143 with SMTP id
 r1-20020a2e9941000000b0025bc8853143mr14475290ljj.477.1656861727485; 
 Sun, 03 Jul 2022 08:22:07 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a056512202a00b0047255d21132sm4758576lfs.97.2022.07.03.08.22.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Jul 2022 08:22:06 -0700 (PDT)
Subject: Re: [PATCH v3 6/8] genirq: Add and use an irq_data_update_affinity
 helper
To: Samuel Holland <samuel@sholland.org>
References: <20220701200056.46555-1-samuel@sholland.org>
 <20220701200056.46555-7-samuel@sholland.org>
From: Oleksandr <olekstysh@gmail.com>
Message-ID: <c7171195-796a-e61e-f270-864985adc5c3@gmail.com>
Date: Sun, 3 Jul 2022 18:22:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220701200056.46555-7-samuel@sholland.org>
Content-Language: en-US
Cc: Mark Rutland <mark.rutland@arm.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 linux-hyperv@vger.kernel.org, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jan Beulich <jbeulich@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Sven Schnelle <svens@stackframe.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rob Herring <robh@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Marc Zyngier <maz@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, x86@kernel.org,
 Dexuan Cui <decui@microsoft.com>, Russell King <linux@armlinux.org.uk>,
 Wei Xu <xuwei5@hisilicon.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Ingo Molnar <mingo@redhat.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 xen-devel@lists.xenproject.org, Matt Turner <mattst88@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-xtensa@linux-xtensa.org,
 Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Maximilian Heyne <mheyne@amazon.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>,
 Chris Zankel <chris@zankel.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Serge Semin <fancer.lancer@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Colin Ian King <colin.king@intel.com>,
 Helge Deller <deller@gmx.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


On 01.07.22 23:00, Samuel Holland wrote:


Hello Samuel

> Some architectures and irqchip drivers modify the cpumask returned by
> irq_data_get_affinity_mask, usually by copying in to it. This is
> problematic for uniprocessor configurations, where the affinity mask
> should be constant, as it is known at compile time.
>
> Add and use a setter for the affinity mask, following the pattern of
> irq_data_update_effective_affinity. This allows the getter function to
> return a const cpumask pointer.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> Changes in v3:
>   - New patch to introduce irq_data_update_affinity
>
>   arch/alpha/kernel/irq.c          | 2 +-
>   arch/ia64/kernel/iosapic.c       | 2 +-
>   arch/ia64/kernel/irq.c           | 4 ++--
>   arch/ia64/kernel/msi_ia64.c      | 4 ++--
>   arch/parisc/kernel/irq.c         | 2 +-
>   drivers/irqchip/irq-bcm6345-l1.c | 4 ++--
>   drivers/parisc/iosapic.c         | 2 +-
>   drivers/sh/intc/chip.c           | 2 +-
>   drivers/xen/events/events_base.c | 7 ++++---
>   include/linux/irq.h              | 6 ++++++
>   10 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
> index f6d2946edbd2..15f2effd6baf 100644
> --- a/arch/alpha/kernel/irq.c
> +++ b/arch/alpha/kernel/irq.c
> @@ -60,7 +60,7 @@ int irq_select_affinity(unsigned int irq)
>   		cpu = (cpu < (NR_CPUS-1) ? cpu + 1 : 0);
>   	last_cpu = cpu;
>   
> -	cpumask_copy(irq_data_get_affinity_mask(data), cpumask_of(cpu));
> +	irq_data_update_affinity(data, cpumask_of(cpu));
>   	chip->irq_set_affinity(data, cpumask_of(cpu), false);
>   	return 0;
>   }
> diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
> index 35adcf89035a..99300850abc1 100644
> --- a/arch/ia64/kernel/iosapic.c
> +++ b/arch/ia64/kernel/iosapic.c
> @@ -834,7 +834,7 @@ iosapic_unregister_intr (unsigned int gsi)
>   	if (iosapic_intr_info[irq].count == 0) {
>   #ifdef CONFIG_SMP
>   		/* Clear affinity */
> -		cpumask_setall(irq_get_affinity_mask(irq));
> +		irq_data_update_affinity(irq_get_irq_data(irq), cpu_all_mask);
>   #endif
>   		/* Clear the interrupt information */
>   		iosapic_intr_info[irq].dest = 0;
> diff --git a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
> index ecef17c7c35b..275b9ea58c64 100644
> --- a/arch/ia64/kernel/irq.c
> +++ b/arch/ia64/kernel/irq.c
> @@ -57,8 +57,8 @@ static char irq_redir [NR_IRQS]; // = { [0 ... NR_IRQS-1] = 1 };
>   void set_irq_affinity_info (unsigned int irq, int hwid, int redir)
>   {
>   	if (irq < NR_IRQS) {
> -		cpumask_copy(irq_get_affinity_mask(irq),
> -			     cpumask_of(cpu_logical_id(hwid)));
> +		irq_data_update_affinity(irq_get_irq_data(irq),
> +					 cpumask_of(cpu_logical_id(hwid)));
>   		irq_redir[irq] = (char) (redir & 0xff);
>   	}
>   }
> diff --git a/arch/ia64/kernel/msi_ia64.c b/arch/ia64/kernel/msi_ia64.c
> index df5c28f252e3..025e5133c860 100644
> --- a/arch/ia64/kernel/msi_ia64.c
> +++ b/arch/ia64/kernel/msi_ia64.c
> @@ -37,7 +37,7 @@ static int ia64_set_msi_irq_affinity(struct irq_data *idata,
>   	msg.data = data;
>   
>   	pci_write_msi_msg(irq, &msg);
> -	cpumask_copy(irq_data_get_affinity_mask(idata), cpumask_of(cpu));
> +	irq_data_update_affinity(idata, cpumask_of(cpu));
>   
>   	return 0;
>   }
> @@ -132,7 +132,7 @@ static int dmar_msi_set_affinity(struct irq_data *data,
>   	msg.address_lo |= MSI_ADDR_DEST_ID_CPU(cpu_physical_id(cpu));
>   
>   	dmar_msi_write(irq, &msg);
> -	cpumask_copy(irq_data_get_affinity_mask(data), mask);
> +	irq_data_update_affinity(data, mask);
>   
>   	return 0;
>   }
> diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
> index 0fe2d79fb123..5ebb1771b4ab 100644
> --- a/arch/parisc/kernel/irq.c
> +++ b/arch/parisc/kernel/irq.c
> @@ -315,7 +315,7 @@ unsigned long txn_affinity_addr(unsigned int irq, int cpu)
>   {
>   #ifdef CONFIG_SMP
>   	struct irq_data *d = irq_get_irq_data(irq);
> -	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(cpu));
> +	irq_data_update_affinity(d, cpumask_of(cpu));
>   #endif
>   
>   	return per_cpu(cpu_data, cpu).txn_addr;
> diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
> index 142a7431745f..6899e37810a8 100644
> --- a/drivers/irqchip/irq-bcm6345-l1.c
> +++ b/drivers/irqchip/irq-bcm6345-l1.c
> @@ -216,11 +216,11 @@ static int bcm6345_l1_set_affinity(struct irq_data *d,
>   		enabled = intc->cpus[old_cpu]->enable_cache[word] & mask;
>   		if (enabled)
>   			__bcm6345_l1_mask(d);
> -		cpumask_copy(irq_data_get_affinity_mask(d), dest);
> +		irq_data_update_affinity(d, dest);
>   		if (enabled)
>   			__bcm6345_l1_unmask(d);
>   	} else {
> -		cpumask_copy(irq_data_get_affinity_mask(d), dest);
> +		irq_data_update_affinity(d, dest);
>   	}
>   	raw_spin_unlock_irqrestore(&intc->lock, flags);
>   
> diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
> index 8a3b0c3a1e92..3a8c98615634 100644
> --- a/drivers/parisc/iosapic.c
> +++ b/drivers/parisc/iosapic.c
> @@ -677,7 +677,7 @@ static int iosapic_set_affinity_irq(struct irq_data *d,
>   	if (dest_cpu < 0)
>   		return -1;
>   
> -	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(dest_cpu));
> +	irq_data_update_affinity(d, cpumask_of(dest_cpu));
>   	vi->txn_addr = txn_affinity_addr(d->irq, dest_cpu);
>   
>   	spin_lock_irqsave(&iosapic_lock, flags);
> diff --git a/drivers/sh/intc/chip.c b/drivers/sh/intc/chip.c
> index 358df7510186..828d81e02b37 100644
> --- a/drivers/sh/intc/chip.c
> +++ b/drivers/sh/intc/chip.c
> @@ -72,7 +72,7 @@ static int intc_set_affinity(struct irq_data *data,
>   	if (!cpumask_intersects(cpumask, cpu_online_mask))
>   		return -1;
>   
> -	cpumask_copy(irq_data_get_affinity_mask(data), cpumask);
> +	irq_data_update_affinity(data, cpumask);
>   
>   	return IRQ_SET_MASK_OK_NOCOPY;
>   }
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index 46d9295d9a6e..5e8321f43cbd 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -528,9 +528,10 @@ static void bind_evtchn_to_cpu(evtchn_port_t evtchn, unsigned int cpu,
>   	BUG_ON(irq == -1);
>   
>   	if (IS_ENABLED(CONFIG_SMP) && force_affinity) {
> -		cpumask_copy(irq_get_affinity_mask(irq), cpumask_of(cpu));
> -		cpumask_copy(irq_get_effective_affinity_mask(irq),
> -			     cpumask_of(cpu));
> +		struct irq_data *data = irq_get_irq_data(irq);
> +
> +		irq_data_update_affinity(data, cpumask_of(cpu));
> +		irq_data_update_effective_affinity(data, cpumask_of(cpu));
>   	}



Nit: commit description says about reusing irq_data_update_affinity() 
only, but here we also reuse irq_data_update_effective_affinity(), so I 
would mention that in the description.

Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com> # Xen bits


[snip]

-- 
Regards,

Oleksandr Tyshchenko

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
