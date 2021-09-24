Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81085C433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 09:52:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25651610C7
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 09:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25651610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E51854065A;
	Fri, 24 Sep 2021 09:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NnoJUuaxeihU; Fri, 24 Sep 2021 09:51:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B59A64050F;
	Fri, 24 Sep 2021 09:51:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 790AAC000F;
	Fri, 24 Sep 2021 09:51:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18EA2C000D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 09:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8539605BF
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 09:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tcCekN_0SOnD for <iommu@lists.linux-foundation.org>;
 Fri, 24 Sep 2021 09:51:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73A4560701
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 09:51:53 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0dd600d43e805889b23e24.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0d:d600:d43e:8058:89b2:3e24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC4151EC0301;
 Fri, 24 Sep 2021 11:51:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1632477106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=chSLn6PIxzKxo322BTSR3wKHxsK14lHDAqUJBVwt9Eo=;
 b=CfbAAofZ6R9ns5NFPki+7QaitPLpejuXdZJnxlWVBsvBowrNUxHEqrUKe2Y/BdplMet7fD
 Nq3F50WTgrfr42U+7z5YTTrv+pRjCylIw87rlK6B7Va1B8V8LlSqHAb6L8QXwsedXXkhcz
 4vGmH2JazfBltplsu+R4klbu0kJ61KI=
Date: Fri, 24 Sep 2021 11:51:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
Message-ID: <YU2fsCblZVQpgMvC@zn.tnic>
References: <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
 <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
 <20210922143015.vvxvh6ec73lffvkf@box.shutemov.name>
 <YUuJZ2qOgbdpfk6N@zn.tnic>
 <20210922210558.itofvu3725dap5xx@box.shutemov.name>
 <YUzFj+yH79XRc3F3@zn.tnic>
 <20210924094132.gxyqp4z3qdk5w4j6@box.shutemov.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210924094132.gxyqp4z3qdk5w4j6@box.shutemov.name>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, linux-graphics-maintainer@vmware.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Andy Lutomirski <luto@kernel.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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

On Fri, Sep 24, 2021 at 12:41:32PM +0300, Kirill A. Shutemov wrote:
> On Thu, Sep 23, 2021 at 08:21:03PM +0200, Borislav Petkov wrote:
> > On Thu, Sep 23, 2021 at 12:05:58AM +0300, Kirill A. Shutemov wrote:
> > > Unless we find other way to guarantee RIP-relative access, we must use
> > > fixup_pointer() to access any global variables.
> > 
> > Yah, I've asked compiler folks about any guarantees we have wrt
> > rip-relative addresses but it doesn't look good. Worst case, we'd have
> > to do the fixup_pointer() thing.
> > 
> > In the meantime, Tom and I did some more poking at this and here's a
> > diff ontop.
> > 
> > The direction being that we'll stick both the AMD and Intel
> > *cc_platform_has() call into cc_platform.c for which instrumentation
> > will be disabled so no issues with that.
> > 
> > And that will keep all that querying all together in a single file.
> 
> And still do cc_platform_has() calls in __startup_64() codepath?
> 
> It's broken.
> 
> Intel detection in cc_platform_has() relies on boot_cpu_data.x86_vendor
> which is not initialized until early_cpu_init() in setup_arch(). Given
> that X86_VENDOR_INTEL is 0 it leads to false-positive.

Yeah, Tom, I had the same question yesterday.

/me looks in his direction.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
