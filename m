Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2292C282DD
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 19:49:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B2A206BA
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 19:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn8Vkti4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B2A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 981AECBC;
	Wed, 17 Apr 2019 19:49:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D4771B4B
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 19:49:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1E18C87F
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 19:49:18 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
	[209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 9F541217D7
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555530557;
	bh=un9JngdqTRaqtIrvykfJj/MFL9SGLhvcacMgNjMe4H4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kn8Vkti4sBxNwzVpRT0c4mTQmL2NZNKopl87jqCVp809RH0mPB/oMge5j1G1+57D6
	mx2SzHFI79Y6yc98bMu7vvnU5XaVTnC9MROa8/O0GhnxRGifXFOrQbSxRMIrCrkHaY
	kdQxYP95wXhAxvIbkelVm11g9KylGmv40LeJYNT8=
Received: by mail-wr1-f41.google.com with SMTP id j9so33474859wrn.6
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 12:49:17 -0700 (PDT)
X-Gm-Message-State: APjAAAWJOmNhEFPItnG1zxofx9Au9C4bcyGpz2mSwtwnJ8JtK4X67xXZ
	wMfg2tNoQbN3HqUB3izumzjoe39q+AAgIZqel6zefQ==
X-Google-Smtp-Source: APXvYqwslPQOOCGBluAyQ370prOUXMhL8otOt2EJTpreLpaaBphk3bN4/Rpkbdm1dLisarFpIiIJANwuHztMcLGcdZw=
X-Received: by 2002:adf:f344:: with SMTP id e4mr23917370wrp.77.1555530556240; 
	Wed, 17 Apr 2019 12:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
	<e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
	<20190417170918.GA68678@gmail.com>
	<8d314750-251c-7e6a-7002-5df2462ada6b@oracle.com>
In-Reply-To: <8d314750-251c-7e6a-7002-5df2462ada6b@oracle.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 17 Apr 2019 12:49:04 -0700
X-Gmail-Original-Message-ID: <CALCETrXFzWFMrV-zDa4QFjB=4WnC9RZmorBko65dLGhymDpeQw@mail.gmail.com>
Message-ID:
 <CALCETrXFzWFMrV-zDa4QFjB=4WnC9RZmorBko65dLGhymDpeQw@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Dave Hansen <dave@sr71.net>, Thomas Gleixner <tglx@linutronix.de>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, deepa.srinivasan@oracle.com,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, X86 ML <x86@kernel.org>,
	iommu@lists.linux-foundation.org, jsteckli@amazon.de,
	Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jon Masters <jcm@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	chris hyser <chris.hyser@oracle.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Khalid Aziz <khalid@gonehiking.org>, Juerg Haefliger <juergh@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	LKML <linux-kernel@vger.kernel.org>, Tyler Hicks <tyhicks@canonical.com>,
	LSM List <linux-security-module@vger.kernel.org>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Kees Cook <keescook@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, "Woodhouse,
	David" <dwmw@amazon.co.uk>
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
Message-ID: <20190417194904.ge1vnOeYIlTROauRLfaYEAZ5oc3Fg05iSm8XuNFhHok@z>

On Wed, Apr 17, 2019 at 10:33 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> On 4/17/19 11:09 AM, Ingo Molnar wrote:
> >
> > * Khalid Aziz <khalid.aziz@oracle.com> wrote:
> >
> >>> I.e. the original motivation of the XPFO patches was to prevent execution
> >>> of direct kernel mappings. Is this motivation still present if those
> >>> mappings are non-executable?
> >>>
> >>> (Sorry if this has been asked and answered in previous discussions.)
> >>
> >> Hi Ingo,
> >>
> >> That is a good question. Because of the cost of XPFO, we have to be very
> >> sure we need this protection. The paper from Vasileios, Michalis and
> >> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
> >> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
> >> and 6.2.
> >
> > So it would be nice if you could generally summarize external arguments
> > when defending a patchset, instead of me having to dig through a PDF
> > which not only causes me to spend time that you probably already spent
> > reading that PDF, but I might also interpret it incorrectly. ;-)
>
> Sorry, you are right. Even though that paper explains it well, a summary
> is always useful.
>
> >
> > The PDF you cited says this:
> >
> >   "Unfortunately, as shown in Table 1, the W^X prop-erty is not enforced
> >    in many platforms, including x86-64.  In our example, the content of
> >    user address 0xBEEF000 is also accessible through kernel address
> >    0xFFFF87FF9F080000 as plain, executable code."
> >
> > Is this actually true of modern x86-64 kernels? We've locked down W^X
> > protections in general.
> >
> > I.e. this conclusion:
> >
> >   "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and
> >    triggering the kernel to dereference it, an attacker can directly
> >    execute shell code with kernel privileges."
> >
> > ... appears to be predicated on imperfect W^X protections on the x86-64
> > kernel.
> >
> > Do such holes exist on the latest x86-64 kernel? If yes, is there a
> > reason to believe that these W^X holes cannot be fixed, or that any fix
> > would be more expensive than XPFO?
>
> Even if physmap is not executable, return-oriented programming (ROP) can
> still be used to launch an attack. Instead of placing executable code at
> user address 0xBEEF000, attacker can place an ROP payload there. kfptr
> is then overwritten to point to a stack-pivoting gadget. Using the
> physmap address aliasing, the ROP payload becomes kernel-mode stack. The
> execution can then be hijacked upon execution of ret instruction. This
> is a gist of the subsection titled "Non-executable physmap" under
> section 6.2 and it looked convincing enough to me. If you have a
> different take on this, I am very interested in your point of view.

My issue with all this is that XPFO is really very expensive.  I think
that, if we're going to seriously consider upstreaming expensive
exploit mitigations like this, we should consider others first, in
particular CFI techniques.  grsecurity's RAP would be a great start.
I also proposed using a gcc plugin (or upstream gcc feature) to add
some instrumentation to any code that pops RSP to verify that the
resulting (unsigned) change in RSP is between 0 and THREAD_SIZE bytes.
This will make ROP quite a bit harder.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
