Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E21C4363D
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 21:42:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F52206BE
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 21:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hPhWVA2K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IqDnbIx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F52206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 359108681A;
	Tue,  6 Oct 2020 21:42:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iKO4LYSsY4vQ; Tue,  6 Oct 2020 21:42:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9607D86816;
	Tue,  6 Oct 2020 21:42:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DDB1C016F;
	Tue,  6 Oct 2020 21:42:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00A4DC0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DACCE871A2
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:42:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DHymenpOIvIx for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 21:42:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 47DD087195
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:42:28 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1602020546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sgwoBb+lMGeaN4dDMd5GpX1k8Re+bWv1lEsLT0KLZAc=;
 b=hPhWVA2KVPIs9qDac9R5H4bbdRmwKGUdGzRraTnqzLrJT8MbsdOVjVSpONVw6Fn/LmmNQ8
 TUNY/MeF3zyGRIkYroto5fyqDCae0+zaV1czvzOfOqk0Aof9y66pWQ8l7owwfCl2WweH5w
 X89GJ94rcCo5+dgcyjYhmXDWjl4Lh2aDb6tIQLMKuY8XSaxYlgI974yrz+AMApJg3smkkm
 y6KhEZvsU1yYbxeBs5Jlx18TmvHuT0qjniIe0m9bNO6tFxj6bDhrNpADK6j5Y0sCcQ/42V
 LCu7oec5y/zwAyxh+JvVir3yZNh38tVCLi8enrqfRjwIgYkPq8cccq5SQ0VKcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1602020546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sgwoBb+lMGeaN4dDMd5GpX1k8Re+bWv1lEsLT0KLZAc=;
 b=IqDnbIx3Xxv/d+jdD48Dhpe7Gre9PdfZJ1v46I0jDRxCHZ9PfR4IfuHw1mGi9yHBO5GB60
 Nx5+QyZZa24/HzCQ==
To: David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 09/13] x86/irq: Add x86_non_ir_cpumask
In-Reply-To: <20201005152856.974112-9-dwmw2@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-9-dwmw2@infradead.org>
Date: Tue, 06 Oct 2020 23:42:25 +0200
Message-ID: <87ft6r58vy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 iommu <iommu@lists.linux-foundation.org>, linux-hyperv@vger.kernel.org,
 kvm <kvm@vger.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Oct 05 2020 at 16:28, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> This is the mask of CPUs to which IRQs can be delivered without interrupt
> remapping.
>  
> +/* Mask of CPUs which can be targeted by non-remapped interrupts. */
> +cpumask_t x86_non_ir_cpumask = { CPU_BITS_ALL };

What?

>  #ifdef CONFIG_X86_32
>  
>  /*
> @@ -1838,6 +1841,7 @@ static __init void x2apic_enable(void)
>  static __init void try_to_enable_x2apic(int remap_mode)
>  {
>  	u32 apic_limit = 0;
> +	int i;
>  
>  	if (x2apic_state == X2APIC_DISABLED)
>  		return;
> @@ -1880,6 +1884,14 @@ static __init void try_to_enable_x2apic(int remap_mode)
>  	if (apic_limit)
>  		x2apic_set_max_apicid(apic_limit);
>  
> +	/* Build the affinity mask for interrupts that can't be remapped. */
> +	cpumask_clear(&x86_non_ir_cpumask);
> +	i = min_t(unsigned int, num_possible_cpus() - 1, apic_limit);
> +	for ( ; i >= 0; i--) {
> +		if (cpu_physical_id(i) <= apic_limit)
> +			cpumask_set_cpu(i, &x86_non_ir_cpumask);
> +	}

Blink. If the APIC id is not linear with the cpu numbers then this
results in a reduced addressable set of CPUs. WHY?

> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index aa9a3b54a96c..4d0ef46fedb9 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2098,6 +2098,8 @@ static int mp_alloc_timer_irq(int ioapic, int pin)
>  		struct irq_alloc_info info;
>  
>  		ioapic_set_alloc_attr(&info, NUMA_NO_NODE, 0, 0);
> +		if (domain->parent == x86_vector_domain)
> +			info.mask = &x86_non_ir_cpumask;

We are not going to sprinkle such domain checks all over the
place. Again, the mask is a property of the interrupt domain.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
