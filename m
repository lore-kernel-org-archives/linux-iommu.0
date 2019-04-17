Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E3DC282DC
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 21:20:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889CB217FA
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 21:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889CB217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 45F58D9A;
	Wed, 17 Apr 2019 21:20:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8B2DECC1
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 21:20:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9104C881
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 21:20:10 +0000 (UTC)
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hGryH-0005mC-Kp; Wed, 17 Apr 2019 23:19:57 +0200
Date: Wed, 17 Apr 2019 23:19:50 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
In-Reply-To: <063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
Message-ID: <alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
	<e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
	<20190417170918.GA68678@gmail.com>
	<56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
	<20190417172632.GA95485@gmail.com>
	<063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1402638458-1555535997=:3174"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
	SHORTCIRCUIT=-0.0001
Cc: Dave Hansen <dave@sr71.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>,
	deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
	X86 ML <x86@kernel.org>,
	iommu <iommu@lists.linux-foundation.org>, jsteckli@amazon.de,
	Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jcm@redhat.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
	Khalid Aziz <khalid@gonehiking.org>, juergh@gmail.com,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	tyhicks@canonical.com, LSM List <linux-security-module@vger.kernel.org>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	keescook@google.com, Andrew Morton <akpm@linux-foundation.org>,
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190417211950.4WUv415cHqTmTQ_HyZH76zloym1s-UM2TCpDtPnRzC0@z>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1402638458-1555535997=:3174
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 17 Apr 2019, Nadav Amit wrote:
> > On Apr 17, 2019, at 10:26 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >> As I was curious, I looked at the paper. Here is a quote from it:
> >> 
> >> "In x86-64, however, the permissions of physmap are not in sane state.
> >> Kernels up to v3.8.13 violate the W^X property by mapping the entire region
> >> as “readable, writeable, and executable” (RWX)—only very recent kernels
> >> (≥v3.9) use the more conservative RW mapping.”
> > 
> > But v3.8.13 is a 5+ years old kernel, it doesn't count as a "modern" 
> > kernel in any sense of the word. For any proposed patchset with 
> > significant complexity and non-trivial costs the benchmark version 
> > threshold is the "current upstream kernel".
> > 
> > So does that quote address my followup questions:
> > 
> >> Is this actually true of modern x86-64 kernels? We've locked down W^X
> >> protections in general.
> >> 
> >> I.e. this conclusion:
> >> 
> >>  "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and
> >>   triggering the kernel to dereference it, an attacker can directly
> >>   execute shell code with kernel privileges."
> >> 
> >> ... appears to be predicated on imperfect W^X protections on the x86-64
> >> kernel.
> >> 
> >> Do such holes exist on the latest x86-64 kernel? If yes, is there a
> >> reason to believe that these W^X holes cannot be fixed, or that any fix
> >> would be more expensive than XPFO?
> > 
> > ?
> > 
> > What you are proposing here is a XPFO patch-set against recent kernels 
> > with significant runtime overhead, so my questions about the W^X holes 
> > are warranted.
> > 
> 
> Just to clarify - I am an innocent bystander and have no part in this work.
> I was just looking (again) at the paper, as I was curious due to the recent
> patches that I sent that improve W^X protection.

It's not necessarily a W+X issue. The user space text is mapped in the
kernel as well and even if it is mapped RX then this can happen. So any
kernel mappings of user space text need to be mapped NX!

Thanks,

	tglx
--8323329-1402638458-1555535997=:3174
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--8323329-1402638458-1555535997=:3174--
