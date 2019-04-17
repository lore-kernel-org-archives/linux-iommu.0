Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C626AC282DA
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 00:00:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908EB214DA
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 00:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IBLCLtPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908EB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5A402E9E;
	Thu, 18 Apr 2019 00:00:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EA922E9D
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 00:00:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
	[209.85.208.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AEEBC108
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 00:00:43 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id f23so299252ljc.0
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 17:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=+kn5mtINPt4na060bar/tC0RHNfqAb7J/PmuZQ0Dyi8=;
	b=IBLCLtPuOlIJGx6ETpn93rimEqBz5Au/0GjooFZAo0KIJTxoTsJPz413yAtvfmWoXY
	BqvjzirjujDpTm8Z8RGtzbE47EZiPUSxIfegDrH1aTumTX5oM8C5bVyiexfx7ifgxxPB
	UMawmkwQ/X7ZweYBYxIOjMj+Jba1Zio7Xb4vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=+kn5mtINPt4na060bar/tC0RHNfqAb7J/PmuZQ0Dyi8=;
	b=Zv7LFmgg9oTkWq1n12LMP6JNxmWpEGzLz+niGeB0zYaPxbeT7p4FTqPl1JHYEK68OB
	r4ZUnHgtyL1bC7vQ4XdPv/lzrU1SEYOZEjaJYG1W9ej7P/QNewiLRb4Ppyyn1NNMJZOO
	eld4f3OBvsB4+yeX42wYD+UyH8LQoI6+zle43fq8XJc/cCsVVQXbIIIb057CiS07XRDZ
	mPudVgPRmPG6wxu4OdL82nEf93ff97trOhtP4736y1odo8iN7AfxlUwj6oPbsHh3C4p2
	6Di8CnU99xFuAvyMTypmkoOtxEQxhSjMc7cIzNndxCPoJqgOB0t7852mjUqEc8/n2MGg
	otkg==
X-Gm-Message-State: APjAAAXoVhKBA4eu20AaHzAHSW4068kX8wex0z5GpTnTsq0eXrVyqoPL
	+TtNbM2dbWs66zTkm8M8kNkc2r1/yWK9AQ==
X-Google-Smtp-Source: APXvYqzcvKPAN/utmx4aTD/zy2e37ApbRHExg7FMIcbqueYW3HLsh0n+tqQOObRwGS2s3msmfI1Cng==
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr1358232ljj.4.1555545641677;
	Wed, 17 Apr 2019 17:00:41 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
	[209.85.208.176])
	by smtp.gmail.com with ESMTPSA id z8sm62733ljc.50.2019.04.17.17.00.41
	for <iommu@lists.linux-foundation.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 17 Apr 2019 17:00:41 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q66so268509ljq.7
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 17:00:41 -0700 (PDT)
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr48356924lje.22.1555545190479; 
	Wed, 17 Apr 2019 16:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
	<e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
	<20190417170918.GA68678@gmail.com>
	<56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
	<20190417172632.GA95485@gmail.com>
	<063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
	<alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
	<CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com>
	<alpine.DEB.2.21.1904180129000.3174@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904180129000.3174@nanos.tec.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Apr 2019 16:52:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com>
Message-ID:
 <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave@sr71.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>,
	deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
	X86 ML <x86@kernel.org>, LSM List <linux-security-module@vger.kernel.org>,
	jsteckli@amazon.de, Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jon Masters <jcm@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, chris.hyser@oracle.com,
	"linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
	Khalid Aziz <khalid@gonehiking.org>, juergh@gmail.com,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	Tyler Hicks <tyhicks@canonical.com>,
	iommu <iommu@lists.linux-foundation.org>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Kees Cook <keescook@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190417235254.tsBsWyiqR6CZrESa0BUzwnIIXDzheAy9jhAsfp6OK_c@z>

On Wed, Apr 17, 2019 at 4:42 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 17 Apr 2019, Linus Torvalds wrote:
>
> > With SMEP, user space pages are always NX.
>
> We talk past each other. The user space page in the ring3 valid virtual
> address space (non negative) is of course protected by SMEP.
>
> The attack utilizes the kernel linear mapping of the physical
> memory. I.e. user space address 0x43210 has a kernel equivalent at
> 0xfxxxxxxxxxx. So if the attack manages to trick the kernel to that valid
> kernel address and that is mapped X --> game over. SMEP does not help
> there.

Oh, agreed.

But that would simply be a kernel bug. We should only map kernel pages
executable when we have kernel code in them, and we should certainly
not allow those pages to be mapped writably in user space.

That kind of "executable in kernel, writable in user" would be a
horrendous and major bug.

So i think it's a non-issue.

> From the top of my head I'd say this is a non issue as those kernel address
> space mappings _should_ be NX, but we got bitten by _should_ in the past:)

I do agree that bugs can happen, obviously, and we might have missed something.

But in the context of XPFO, I would argue (*very* strongly) that the
likelihood of the above kind of bug is absolutely *miniscule* compared
to the likelihood that we'd have something wrong in the software
implementation of XPFO.

So if the argument is "we might have bugs in software", then I think
that's an argument _against_ XPFO rather than for it.

                Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
