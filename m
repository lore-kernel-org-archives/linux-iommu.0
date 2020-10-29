Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56B6C2D0A3
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 16:56:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DF2214F1
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO+GpLM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DF2214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6865686C46;
	Thu, 29 Oct 2020 16:56:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id keboUeq8V80J; Thu, 29 Oct 2020 16:56:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 83DDA86BDC;
	Thu, 29 Oct 2020 16:56:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75817C0859;
	Thu, 29 Oct 2020 16:56:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BEFEC0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 16:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E53C22010C
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 16:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wUMk1f70IReR for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 16:56:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
 [209.85.166.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 1B48620004
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 16:56:16 +0000 (UTC)
Received: by mail-il1-f196.google.com with SMTP id a20so3714202ilk.13
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=46u7k16lmtR7tMf5v+7fbJj/BQNg8vF1V9HFBp6hYFg=;
 b=TO+GpLM6LycPQoMwryo9xUQRLiEvWYgbGjKPlPQ6JQhAIVJlLxzOsJaEhiiNlylpPU
 rGt9Uq2jE226wycKVWSpG3npnQmZoU8s5A0MHGd4XSgMb8BejsiG/VnzNhIPy8QMD2Z2
 F7IuQvFLeFbghxG3CEhpvXe2WzK8pXgSdiSab7Hx7KATccJNuio5nWAfuBEIbjKsp7Jl
 57A4/cWqICjr/T8wosnkqI/KIZt/A6xx/E5Z8Ir2VJXwueycsYLO4vaFWXcEsKYYZcWb
 Jn/3mLxoII+jzekPaOQFJui7oYC1wE6ekbWbnMCmXPVPkacWmJDSEidjIcgzxSpyLhaA
 1ADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=46u7k16lmtR7tMf5v+7fbJj/BQNg8vF1V9HFBp6hYFg=;
 b=aYAcsWcV5ni6VBCZ8jqYolf6L3x5if67jUFU+BBBKW53dnFJzVDD1MDL9Kbm7mpnL5
 kMif+idvtZnMNLK4NQlJcyc73p9hoO5ctMh08dA9dGUJSqP09jtx2sODRFh7A0GPf8YV
 DeGZvIyaP8iZTT+zadlPPqx2JZC2UGEreHOyMIHSMv8xFdJfmOi3c9H0JHGw+sCHL+/w
 LkTSqSa6GxLE6QqVOnMkUmP5SN5RrM/GpW8+EyVCoeZi2rN5qo2wRzTFvSOx4o8x7+qP
 vOFjqxPyAvJXWY5W0k6rHizc7ae4CT9Dw/tysJ4irYhu1Vi1wLAMU0ROnoy30lEYJZAU
 onfA==
X-Gm-Message-State: AOAM530fvnuiFVmoTOdcwXtOLR2ZeK5ZviC3d6jq3h1qcrRtFO0LsavR
 2sGMjcv4jS0advnT9u1tLDE=
X-Google-Smtp-Source: ABdhPJw9DVYgoIwqL5pROZm1JBXSItTI0Ey8t6jCLCnyLj0KmL714RaHercqOegkYMBCGEVvAtY/7g==
X-Received: by 2002:a05:6e02:2cc:: with SMTP id
 v12mr4099654ilr.115.1603990575376; 
 Thu, 29 Oct 2020 09:56:15 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
 by smtp.gmail.com with ESMTPSA id r12sm2584639ilm.28.2020.10.29.09.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 09:56:14 -0700 (PDT)
From: Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date: Thu, 29 Oct 2020 12:56:11 -0400
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] [v2] x86: apic: avoid -Wshadow warning in header
Message-ID: <20201029165611.GA2557691@rani.riverdale.lan>
References: <20201028212417.3715575-1-arnd@kernel.org>
 <38b11ed3fec64ebd82d6a92834a4bebe@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <38b11ed3fec64ebd82d6a92834a4bebe@AcuMS.aculab.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Wanpeng Li <wanpengli@tencent.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Arnd Bergmann <arnd@arndb.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Jim Mattson <jmattson@google.com>, 'Arnd Bergmann' <arnd@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Thu, Oct 29, 2020 at 03:05:31PM +0000, David Laight wrote:
> From: Arnd Bergmann
> > Sent: 28 October 2020 21:21
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > There are hundreds of warnings in a W=2 build about a local
> > variable shadowing the global 'apic' definition:
> > 
> > arch/x86/kvm/lapic.h:149:65: warning: declaration of 'apic' shadows a global declaration [-Wshadow]
> > 
> > Avoid this by renaming the global 'apic' variable to the more descriptive
> > 'x86_system_apic'. It was originally called 'genapic', but both that
> > and the current 'apic' seem to be a little overly generic for a global
> > variable.
> > 
> > Fixes: c48f14966cc4 ("KVM: inline kvm_apic_present() and kvm_lapic_enabled()")
> > Fixes: c8d46cf06dc2 ("x86: rename 'genapic' to 'apic'")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2: rename the global instead of the local variable in the header
> ...
> > diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> > index 284e73661a18..33e2dc78ca11 100644
> > --- a/arch/x86/hyperv/hv_apic.c
> > +++ b/arch/x86/hyperv/hv_apic.c
> > @@ -259,14 +259,14 @@ void __init hv_apic_init(void)
> >  		/*
> >  		 * Set the IPI entry points.
> >  		 */
> > -		orig_apic = *apic;
> > -
> > -		apic->send_IPI = hv_send_ipi;
> > -		apic->send_IPI_mask = hv_send_ipi_mask;
> > -		apic->send_IPI_mask_allbutself = hv_send_ipi_mask_allbutself;
> > -		apic->send_IPI_allbutself = hv_send_ipi_allbutself;
> > -		apic->send_IPI_all = hv_send_ipi_all;
> > -		apic->send_IPI_self = hv_send_ipi_self;
> > +		orig_apic = *x86_system_apic;
> > +
> > +		x86_system_apic->send_IPI = hv_send_ipi;
> > +		x86_system_apic->send_IPI_mask = hv_send_ipi_mask;
> > +		x86_system_apic->send_IPI_mask_allbutself = hv_send_ipi_mask_allbutself;
> > +		x86_system_apic->send_IPI_allbutself = hv_send_ipi_allbutself;
> > +		x86_system_apic->send_IPI_all = hv_send_ipi_all;
> > +		x86_system_apic->send_IPI_self = hv_send_ipi_self;
> >  	}
> > 
> >  	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
> > @@ -285,10 +285,10 @@ void __init hv_apic_init(void)
> >  		 */
> >  		apic_set_eoi_write(hv_apic_eoi_write);
> >  		if (!x2apic_enabled()) {
> > -			apic->read      = hv_apic_read;
> > -			apic->write     = hv_apic_write;
> > -			apic->icr_write = hv_apic_icr_write;
> > -			apic->icr_read  = hv_apic_icr_read;
> > +			x86_system_apic->read      = hv_apic_read;
> > +			x86_system_apic->write     = hv_apic_write;
> > +			x86_system_apic->icr_write = hv_apic_icr_write;
> > +			x86_system_apic->icr_read  = hv_apic_icr_read;
> >  		}
> 
> For those two just add:
> 	struct apic *apic = x86_system_apic;
> before all the assignments.
> Less churn and much better code.
> 

Why would it be better code?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
