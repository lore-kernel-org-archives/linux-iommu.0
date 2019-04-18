Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1E4C10F0B
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 04:41:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB072184B
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 04:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/HEs4JE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB072184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DDE6210BA;
	Thu, 18 Apr 2019 04:41:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D096F10B6
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 04:41:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0F12FF4
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 04:41:46 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 6679421903
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 04:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555562506;
	bh=ZzJFjyGToYfbKAC7a2m7yS86J4A8OLDkslCG6xa8cQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a/HEs4JEstxsEorSTVr1L93FOcseGDjRBAfiOfzmx2VnD5MZN3NHHDapV9Hwsdfz9
	OKMxJ8HPfwGP/jsFOx+M/IbU16EhNKHDgGxKDCwa9lNrDogLByu5rzWFrRsScS1e6G
	Sks4+rbLnA5el6/MO/qtZgLp5K6QR4F173bPPPQ0=
Received: by mail-wr1-f48.google.com with SMTP id g3so1127327wrx.9
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 21:41:46 -0700 (PDT)
X-Gm-Message-State: APjAAAWWVjjZkNugXAUE7P2N+Y7z1mpNiD/DR4vUU9akusYUEw0Tx/MY
	uMHlrBFYm0iwja6N+Fqun93qc3A5qoNq8WVPQysOAA==
X-Google-Smtp-Source: APXvYqyfUEuC3mEmPG9s4i6tESlRo9oZEsPzue7aX/a76mK2HZr1+EEwlvQomlchaeb55fwDfrvGp+xyZoI6blk5d70=
X-Received: by 2002:adf:efc1:: with SMTP id i1mr59073183wrp.199.1555562504832; 
	Wed, 17 Apr 2019 21:41:44 -0700 (PDT)
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
	<CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com>
In-Reply-To: <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 17 Apr 2019 21:41:33 -0700
X-Gmail-Original-Message-ID: <CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
Message-ID:
 <CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave@sr71.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>,
	deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tycho Andersen <tycho@tycho.ws>, X86 ML <x86@kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, jsteckli@amazon.de,
	Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jon Masters <jcm@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	chris hyser <chris.hyser@oracle.com>,
	"linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
	Khalid Aziz <khalid@gonehiking.org>, Juerg Haefliger <juergh@gmail.com>,
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
Message-ID: <20190418044133.zrgggAS2z9h_ly8nuDmjfyhZ_xX0Suz062XjXBbiQvw@z>

On Wed, Apr 17, 2019 at 5:00 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Apr 17, 2019 at 4:42 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Wed, 17 Apr 2019, Linus Torvalds wrote:
> >
> > > With SMEP, user space pages are always NX.
> >
> > We talk past each other. The user space page in the ring3 valid virtual
> > address space (non negative) is of course protected by SMEP.
> >
> > The attack utilizes the kernel linear mapping of the physical
> > memory. I.e. user space address 0x43210 has a kernel equivalent at
> > 0xfxxxxxxxxxx. So if the attack manages to trick the kernel to that valid
> > kernel address and that is mapped X --> game over. SMEP does not help
> > there.
>
> Oh, agreed.
>
> But that would simply be a kernel bug. We should only map kernel pages
> executable when we have kernel code in them, and we should certainly
> not allow those pages to be mapped writably in user space.
>
> That kind of "executable in kernel, writable in user" would be a
> horrendous and major bug.
>
> So i think it's a non-issue.
>
> > From the top of my head I'd say this is a non issue as those kernel address
> > space mappings _should_ be NX, but we got bitten by _should_ in the past:)
>
> I do agree that bugs can happen, obviously, and we might have missed something.
>
> But in the context of XPFO, I would argue (*very* strongly) that the
> likelihood of the above kind of bug is absolutely *miniscule* compared
> to the likelihood that we'd have something wrong in the software
> implementation of XPFO.
>
> So if the argument is "we might have bugs in software", then I think
> that's an argument _against_ XPFO rather than for it.
>

I don't think this type of NX goof was ever the argument for XPFO.
The main argument I've heard is that a malicious user program writes a
ROP payload into user memory (regular anonymous user memory) and then
gets the kernel to erroneously set RSP (*not* RIP) to point there.

I find this argument fairly weak for a couple reasons.  First, if
we're worried about this, let's do in-kernel CFI, not XPFO, to
mitigate it.  Second, I don't see why the exact same attack can't be
done using, say, page cache, and unless I'm missing something, XPFO
doesn't protect page cache.  Or network buffers, or pipe buffers, etc.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
