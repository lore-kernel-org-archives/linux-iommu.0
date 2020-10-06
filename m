Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9472AC3279D
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 21:01:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7F72087E
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 21:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CEmAhOFF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N04vQuma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7F72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6F61C87199;
	Tue,  6 Oct 2020 21:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qTiJoSkEf3Pg; Tue,  6 Oct 2020 21:01:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0ED0687195;
	Tue,  6 Oct 2020 21:01:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0413BC07FF;
	Tue,  6 Oct 2020 21:01:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 631B2C0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 511D0867E0
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:01:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hehlqpS9jTha for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 21:01:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CF6D481C6B
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:01:20 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1602018079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pMHwtHkLw4HDoWmj5/QQIiyML9PtpWcAcXgOvT1HlN0=;
 b=CEmAhOFFqnUC32Z5WehKP0GW4jN+RtJUMYTyVfIqtEI2/sHAehg7OwomgSlyRdxR/pexp/
 zwOXgOLtNxzRHInyP81D6ht8z7ODAZQpJPKqkuyD8S+/mUeflkBEzGkncj3Sj6ErfW9aAD
 KTP+/V3+9A8R7bq7H/4zWpk0E1fOwGeuM6wCxP9OhNvRKVlfkQf9+K4H4+nXRulpwKBQX8
 1Gzj53dEq+e9HS1sxsbUuAYgxNNodmmTZAEdvLVMX72+BMzHYsFif3DN2BAmPZ8E1FDfLn
 IKY92Qz2a0zovWcxC9AYAQCzjB5T+8uSDYhqDIdSsxvY9WR/t54F2E4KN6uwYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1602018079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pMHwtHkLw4HDoWmj5/QQIiyML9PtpWcAcXgOvT1HlN0=;
 b=N04vQumazGWWXo/ctuk1rRy6XCnawiqTBr4RAbWVsrEjOSp6dE6ewjP71Wdl+DjiDKjmA6
 YXD1v1lHU+LlO2BA==
To: David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 05/13] genirq: Prepare for default affinity to be passed
 to __irq_alloc_descs()
In-Reply-To: <20201005152856.974112-5-dwmw2@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-5-dwmw2@infradead.org>
Date: Tue, 06 Oct 2020 23:01:18 +0200
Message-ID: <87r1qb5ash.fsf@nanos.tec.linutronix.de>
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
>  
>  #else /* CONFIG_SMP */
>  
> +#define irq_default_affinity (NULL)

...

>  static int alloc_descs(unsigned int start, unsigned int cnt, int node,
>  		       const struct irq_affinity_desc *affinity,
> +		       const struct cpumask *default_affinity,
>  		       struct module *owner)
>  {
>  	struct irq_desc *desc;
>  	int i;
>  
>  	/* Validate affinity mask(s) */
> +	if (!default_affinity || cpumask_empty(default_affinity))
> +		return -EINVAL;

How is that supposed to work on UP?

Aside of that I really hate to have yet another argument just
because.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
