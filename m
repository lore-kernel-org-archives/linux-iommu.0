Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C17C55178
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 21:35:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24C420731
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 21:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGuTqV/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24C420731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 05A1086BE9;
	Thu, 29 Oct 2020 21:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORQXx9hr3Bjn; Thu, 29 Oct 2020 21:35:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE11D86BA6;
	Thu, 29 Oct 2020 21:35:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A16AC088B;
	Thu, 29 Oct 2020 21:35:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CB65C0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 21:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E7512228D1
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 21:35:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2mdfwxPcJSol for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 21:35:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
 [209.85.166.46])
 by silver.osuosl.org (Postfix) with ESMTPS id 1204B2046E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 21:35:17 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id z5so5320581iob.1
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 14:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=o/fZRhurDRoh3x2KXwZGFT2Yi8JsbQLcBDCy2LAivAY=;
 b=gGuTqV/6UjMeGtDxjXYhwQPHTl/X7tzC8nyDkopIigNmkrO3mCPbuH/1MhlZEXs368
 ilsmPmjF8/8PcamJS4tzXcIssUUJKuowmvAaZpvnATyfAuLpyzByye2ob5V27GVE8qIT
 KZP17N/xFAWoIKkVe0RuMkFayeP8BWuJYRQfihoxN9IcITuyVnsNMyFFHot0k3ChkDxn
 nFZSLwwceJfQxsoqw1O2SZk7WDZNX5WeTFIk5dkyBtO3OtvmEbw8mG/eVrbi8eoLhfOn
 0GZOx0BOnNgBQieydv87h3zVPKI0C/CSIt6VEOi3C7rjEkzw5bkznPJoY5+aGh/Uu3xA
 /g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=o/fZRhurDRoh3x2KXwZGFT2Yi8JsbQLcBDCy2LAivAY=;
 b=C38K+6L7eoBZcoNa6mi6PcV4Jujm89f3AytfokXkKfQ/A0/UKL7qSrVgw5qwgrTuko
 buGXYc8RxJ8RndkbvV+XFxZhKyz9qSsyqgXAyl4fHppRP0qIxa6V18esYeWFZmhYJbC6
 kqhBgcM6pDdDlWTEuwPCcMt41LToYed3uxv1nNmAxrvFW3tH/HhC5rpD8JvBLOyKfDMH
 lLisyBquTjB2q8oUc3TLcnd2aIUgJHfHJvjl9KJvPSS9zTMYFEUQRM5xCVrVix6X7ZnH
 2vE7FQTU+BVgROAxBtuKekI/mNb8O6jGY0+38fE9uW0U+Pr8tyvBKU0FyHKl+rImsaN1
 xaUw==
X-Gm-Message-State: AOAM530P8tBa/RmJEiJAgOlbUJRUxtn01dnH/f1iICFSvWFfxZvY6lfy
 iJy/NS7iJRVeMXmiXNnsiXc=
X-Google-Smtp-Source: ABdhPJyTkgnuu9ypsiIO3xCkmwdOh4o3IIPvbsxF62gfZSdk4g2zCe1B1vFwKdXsPs4FzLAVBSR7HA==
X-Received: by 2002:a05:6602:22cf:: with SMTP id
 e15mr5087695ioe.1.1604007316212; 
 Thu, 29 Oct 2020 14:35:16 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
 by smtp.gmail.com with ESMTPSA id r3sm3065346iog.55.2020.10.29.14.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 14:35:15 -0700 (PDT)
From: Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date: Thu, 29 Oct 2020 17:35:12 -0400
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [v2] x86: apic: avoid -Wshadow warning in header
Message-ID: <20201029213512.GA34524@rani.riverdale.lan>
References: <20201028212417.3715575-1-arnd@kernel.org>
 <38b11ed3fec64ebd82d6a92834a4bebe@AcuMS.aculab.com>
 <20201029165611.GA2557691@rani.riverdale.lan>
 <93180c2d-268c-3c33-7c54-4221dfe0d7ad@redhat.com>
 <87v9esojdi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87v9esojdi.fsf@nanos.tec.linutronix.de>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Wanpeng Li <wanpengli@tencent.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 Arvind Sankar <nivedita@alum.mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Arnd Bergmann <arnd@arndb.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 Borislav Petkov <bp@alien8.de>, Jim Mattson <jmattson@google.com>,
 'Arnd Bergmann' <arnd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Laight <David.Laight@ACULAB.COM>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Thu, Oct 29, 2020 at 09:41:13PM +0100, Thomas Gleixner wrote:
> On Thu, Oct 29 2020 at 17:59, Paolo Bonzini wrote:
> > On 29/10/20 17:56, Arvind Sankar wrote:
> >>> For those two just add:
> >>> 	struct apic *apic = x86_system_apic;
> >>> before all the assignments.
> >>> Less churn and much better code.
> >>>
> >> Why would it be better code?
> >> 
> >
> > I think he means the compiler produces better code, because it won't
> > read the global variable repeatedly.  Not sure if that's true,(*) but I
> > think I do prefer that version if Arnd wants to do that tweak.
> 
> It's not true.
> 
>      foo *p = bar;
> 
>      p->a = 1;
>      p->b = 2;
> 
> The compiler is free to reload bar after accessing p->a and with
> 
>     bar->a = 1;
>     bar->b = 1;
> 
> it can either cache bar in a register or reread it after bar->a
> 
> The generated code is the same as long as there is no reason to reload,
> e.g. register pressure.
> 
> Thanks,
> 
>         tglx

It's not quite the same.

https://godbolt.org/z/4dzPbM

With -fno-strict-aliasing, the compiler reloads the pointer if you write
to the start of what it points to, but not if you write to later
elements.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
