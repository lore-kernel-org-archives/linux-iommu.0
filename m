Return-Path: <SRS0=kOFq=SY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EDFC282E1
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 22:23:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF21205F4
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 22:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Vl0fYQ0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF21205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 36C08CAF;
	Mon, 22 Apr 2019 22:23:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D59DFCAD
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 22:23:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com
	[209.85.221.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 49CAFF4
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 22:23:46 +0000 (UTC)
Received: by mail-vk1-f193.google.com with SMTP id x194so2767223vke.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Apsh13b43ex5kM603MFVFBzVRJeAAR6IMS53yCHVuRM=;
	b=Vl0fYQ0UCHGtndl0jafErZw5vqbDAq4DrFX3SfBAIMhEhneL9rXawPTcud8fgV5g3D
	W/sHE49ARVD9KYD5FloU01n2RfA2pTgnKMthR4SE5EVifhT+Zv7f89iMoQqyLkH17UHR
	Ufjeoo3iZe8A1ywqY/dQX9OJ6hQY+RdFMicuSiIFmS2kjW0kxDgF0PQchZJoFDeQwLJ4
	Bu9iNZw8/m1h5Vvq6bsIi0oFDRabTh4fUKE/VXZ1BpEeHCWZiVc862ytrlz+nAaTR+Cp
	kF/vZydc6r2yg2X0nSiZbBoPzLhOuIzzabOzb88ffPr/VLLo66HUZNIe7JxAbYTKUz7T
	O38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Apsh13b43ex5kM603MFVFBzVRJeAAR6IMS53yCHVuRM=;
	b=In44Fqthg6QId2znFeE9X+xIprmxzJf9b3cTTy47QnATb/f3KFO+qOAvvyx6/zBwY2
	DAxB2klT443nA6hbUE8AbAkAL5eOv6w6aB17zDsrM+JuphInZ1c99HpqaSBSaTz7OHWe
	smcdCb+jBEcNqswoRLMA2nWxkjxWjRwkyQ26PUONCfI0LLpJYX4Z3rh0MGQxKfvCG6A/
	405+KgzXcpqS9Pw2zS/+KZyZk0godHt0xdnaKKq3zwIbOtWjgf9YQaKL/ZyWz4D0tRdp
	nPmacTFR8H9h80DXeIiN1549jLM0qg7rw6CFzoNwd8wMOBLtoLaHWm13k1n2t2E06X19
	HB+g==
X-Gm-Message-State: APjAAAVDX98HfsVPwSWyphX8nJlV/FAX6mwOKdnMkXwCcKACPvbWY5ld
	uXX93b7A3GAznPhHCWznnd8ZiW1NjEK+l7s72wePUQ==
X-Google-Smtp-Source: APXvYqxiq50qJu8wanUuH+yOCTaJNMUpHEhGXVEwCujnFscJAmlLegU3s6VeZj+61I7iVGG+tUCCywSMlxsTtse/mUo=
X-Received: by 2002:a1f:2e07:: with SMTP id u7mr11692664vku.44.1555971825052; 
	Mon, 22 Apr 2019 15:23:45 -0700 (PDT)
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
	<CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
	<CAGXu5jL-qJtW7eH8S2yhqciE+J+FWz8HHzTrGJTgVUbd55n6dQ@mail.gmail.com>
	<8f9d059d-e720-cd24-faa6-45493fc012e0@oracle.com>
In-Reply-To: <8f9d059d-e720-cd24-faa6-45493fc012e0@oracle.com>
Date: Mon, 22 Apr 2019 15:23:32 -0700
Message-ID:
 <CAGXu5jLPkD_6BL1m2=13KVTfZ7znr-xAyz+CB23eoeboFgCSOg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Dave Hansen <dave@sr71.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, deepa.srinivasan@oracle.com,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Tycho Andersen <tycho@tycho.ws>, X86 ML <x86@kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Julian Stecklina <jsteckli@amazon.de>,
	Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jon Masters <jcm@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	chris hyser <chris.hyser@oracle.com>,
	"linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
	Khalid Aziz <khalid@gonehiking.org>, Juerg Haefliger <juergh@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	Tyler Hicks <tyhicks@canonical.com>,
	iommu <iommu@lists.linux-foundation.org>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
From: Kees Cook via iommu <iommu@lists.linux-foundation.org>
Reply-To: Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190422222332.COQaj6dLNF4scPERHWieGx2fFstcpMxQRhUV-mODLHg@z>

On Thu, Apr 18, 2019 at 7:35 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> On 4/17/19 11:41 PM, Kees Cook wrote:
> > On Wed, Apr 17, 2019 at 11:41 PM Andy Lutomirski <luto@kernel.org> wrote:
> >> I don't think this type of NX goof was ever the argument for XPFO.
> >> The main argument I've heard is that a malicious user program writes a
> >> ROP payload into user memory (regular anonymous user memory) and then
> >> gets the kernel to erroneously set RSP (*not* RIP) to point there.
> >
> > Well, more than just ROP. Any of the various attack primitives. The NX
> > stuff is about moving RIP: SMEP-bypassing. But there is still basic
> > SMAP-bypassing for putting a malicious structure in userspace and
> > having the kernel access it via the linear mapping, etc.
> >
> >> I find this argument fairly weak for a couple reasons.  First, if
> >> we're worried about this, let's do in-kernel CFI, not XPFO, to
> >
> > CFI is getting much closer. Getting the kernel happy under Clang, LTO,
> > and CFI is under active development. (It's functional for arm64
> > already, and pieces have been getting upstreamed.)
> >
>
> CFI theoretically offers protection with fairly low overhead. I have not
> played much with CFI in clang. I agree with Linus that probability of
> bugs in XPFO implementation itself is a cause of concern. If CFI in
> Clang can provide us the same level of protection as XPFO does, I
> wouldn't want to push for an expensive change like XPFO.
>
> If Clang/CFI can't get us there for extended period of time, does it
> make sense to continue to poke at XPFO?

Well, I think CFI will certainly vastly narrow the execution paths
available to an attacker, but what I continue to see XPFO useful for
is stopping attacks that need to locate something in memory. (i.e. not
ret2dir but, like, read2dir.) It's arguable that such attacks would
just use heap, stack, etc to hold such things, but the linear map
remains relatively easy to find/target. But I agree: the protection is
getting more and more narrow (especially with CFI coming down the
pipe), and if it's still a 28% hit, that's not going to be tenable for
anyone but the truly paranoid. :)

All that said, there isn't a very good backward-edge CFI protection
(i.e. ROP defense) on x86 in Clang. The forward-edge looks decent, but
requires LTO, etc. My point is there is still a long path to gaining
CFI in upstream.

-- 
Kees Cook
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
