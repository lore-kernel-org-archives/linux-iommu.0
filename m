Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3801FC10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:18:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55C92183E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="R/AYdV4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55C92183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9FF861515;
	Thu, 18 Apr 2019 09:18:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 92180D36
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 05:41:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com
	[209.85.221.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1A6D46C5
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 05:41:59 +0000 (UTC)
Received: by mail-vk1-f196.google.com with SMTP id x194so224987vke.0
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 22:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=zQ9PhXUre7lv39dhKUe3RnNugaLVkc5Fpp+aduMWHKc=;
	b=R/AYdV4IFItQnfjUNNubyf9+5USGcILzz8B1DmWPKSECRCluWxSP8rnztSiAw/nHbx
	OgWc7upQI8/4NLGzsj8XCYD8CtK21EXPUD3kqVz8L9yqhXJs06gDEQL5f14t98XkKrDi
	zZLGfesRzIi7SEtmDIBJc/zWHSSeITVGpq4qWo6pCUtYoX+1nKYsEkGc/aMtjhfeYPaR
	zpe5obPY5UDXKnX5Ux3km1WyEqJmPrsvxZPBHysfpd+ZMjsl8a01eFzYpNC5mgWQOQvs
	wfgj8VJjyeSiWxP7AB+2Th18IJzOpvgz45GRbENtjjUmOZDRpabHmRe+wBMg/KPgX8r9
	SNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=zQ9PhXUre7lv39dhKUe3RnNugaLVkc5Fpp+aduMWHKc=;
	b=fh0qjDgvwtFZFXfaXncNzHXzs3LN4aFOjbbdzU0Nd87Ygxt/ZK3l1fP9WQ9VMMAKRq
	l/fx0z895Hf2qNvrASBo1XPB0B6IAWuNplzEJgnisCMfg9qf9Zx3tci3C9DsvGyvyx7y
	+HVZLjzVWFM2GotKd+H1D6PNai5/ZY/zgwmgFKkt+0UnsdbBcamnC4CThfwMJuZqWMoS
	wXfsRDLYy1Fmx4nSzaojgqgiI8yp5/zxyvVQltBonXDLOcF5u13O/urGXUJFlJZmHyIK
	Jx6d5y6cdlHIlPoMCOAdmblSmbxFq7tvErpXv3ezBzR2wzO1ppJvzUq9FRsKyTrch8kK
	hZEw==
X-Gm-Message-State: APjAAAW/am0c44lXPhfB7eAobwhFVXCFxONhYTFwkjMyDIo23kI1XFLG
	cKFrv2U/bnWrjVtr+In8tD9ORqbWIQ+9QumLAms3zQ==
X-Google-Smtp-Source: APXvYqzZLwtZBmPJJ/5v5RygK+/cFMwA6/cdqWVv/GY3jUCoHNshsVXhYcdmHi4zwosCo3mHVhlDcSu086Z/Mts0mIg=
X-Received: by 2002:a1f:a4d:: with SMTP id 74mr51091145vkk.13.1555566117779;
	Wed, 17 Apr 2019 22:41:57 -0700 (PDT)
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
In-Reply-To: <CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
Date: Thu, 18 Apr 2019 00:41:45 -0500
Message-ID:
 <CAGXu5jL-qJtW7eH8S2yhqciE+J+FWz8HHzTrGJTgVUbd55n6dQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
To: Andy Lutomirski <luto@kernel.org>
X-Mailman-Approved-At: Thu, 18 Apr 2019 09:18:54 +0000
Cc: Dave Hansen <dave@sr71.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>,
	deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tycho Andersen <tycho@tycho.ws>, X86 ML <x86@kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Julian Stecklina <jsteckli@amazon.de>,
	Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jon Masters <jcm@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20190418054145.J8UIByxBS1omoGmdgRwDPQVD6n0vQlLftSB6I5sucUs@z>

On Wed, Apr 17, 2019 at 11:41 PM Andy Lutomirski <luto@kernel.org> wrote:
> I don't think this type of NX goof was ever the argument for XPFO.
> The main argument I've heard is that a malicious user program writes a
> ROP payload into user memory (regular anonymous user memory) and then
> gets the kernel to erroneously set RSP (*not* RIP) to point there.

Well, more than just ROP. Any of the various attack primitives. The NX
stuff is about moving RIP: SMEP-bypassing. But there is still basic
SMAP-bypassing for putting a malicious structure in userspace and
having the kernel access it via the linear mapping, etc.

> I find this argument fairly weak for a couple reasons.  First, if
> we're worried about this, let's do in-kernel CFI, not XPFO, to

CFI is getting much closer. Getting the kernel happy under Clang, LTO,
and CFI is under active development. (It's functional for arm64
already, and pieces have been getting upstreamed.)

> mitigate it.  Second, I don't see why the exact same attack can't be
> done using, say, page cache, and unless I'm missing something, XPFO
> doesn't protect page cache.  Or network buffers, or pipe buffers, etc.

My understanding is that it's much easier to feel out the linear
mapping address than for the others. But yes, all of those same attack
primitives are possible in other memory areas (though most are NX),
and plenty of exploits have done such things.

-- 
Kees Cook
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
