Return-Path: <SRS0=jPbF=ND=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00850C432BE
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 10:07:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAF960FC4
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 10:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CAF960FC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 456DB400E9;
	Thu, 12 Aug 2021 10:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CL2_N-5R5gco; Thu, 12 Aug 2021 10:07:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 11EF040732;
	Thu, 12 Aug 2021 10:07:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5344C001A;
	Thu, 12 Aug 2021 10:07:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDBE1C000E
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 10:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7557405E3
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 10:07:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5IDNYcQ8MMFQ for <iommu@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 10:07:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 464C8405E0
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 10:07:14 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id x9so9816781ljj.2
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=MYArfwyoBo3dGsKUJMsxwhHgYqZKbCcsgh7gGUNtDK4=;
 b=i5pl2dc+IIZq62s73J165t7SbTE/a6uwhQcs74jwe9KmwHHHprhV6B7adGgzY2ul5F
 h3ad9IJiBKNdQ1Yy+0atN7ISXCxsrMGXnfmJsO6X4rAencCuDMvqer1gR8DISUT+MUdX
 mFWLcuQYXLFjOzlL0+b+7kJuGkuB4wCN/YMkw/r+eyS6zgywYe+L6amtdlG3N+EOpGsE
 J1HMLNEKBn3QeV3/WPSCpmI5s5ySDG9/4fJ+UJO1H5Xch03iP3WdOduEdYUt1pTqbuK7
 XsqkYhAszn/r202BsWcaBlPgkZHQ5nFUcQEBqetJcuzusrxc9TEefXgeJD4qBlDR12PM
 /RWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=MYArfwyoBo3dGsKUJMsxwhHgYqZKbCcsgh7gGUNtDK4=;
 b=ntLDhkbGUF9YmyO06uOfdENLrSHD7yx1+SvSFG7mKzo8SQrInpoAWnuXdNe6HY3m1+
 x9DxYji0BpNVH/AKOS/gXWvtVBN4BeaNwxHydLTAHV1e+NXaNlNticCorVcSo/NaZDg6
 5qxcatlhx205AshgdwtqG0CDeR07HpG5vio5w5JPQ8uQ4DIhijS6mNWQOKVXlbi7Yi15
 yNFJvvWz5PVOSKo5ugKzylAeKLoICVUvRJVBtNzhagu9gJ+DgcGWRO5+pXnJhOazaliK
 gGwBZeiAEqz2b1C5RjD6UKU3SfLOM1AYUNz2L2Z+lPySZnVJHZm240zyMmb+0SyBtPiH
 Iskg==
X-Gm-Message-State: AOAM5325ZPoDtdQ1jTcCXWi2nmMP+Ed+v2q4PVXuipXWW6bS0NyGrVzJ
 rJebE7I7aWAxvwjZEf6FwTXyJw==
X-Google-Smtp-Source: ABdhPJzegmFCE5odxbsD4HArsZ9uuMjN7H8TkJnoN55vikWCUHEpo/5436B3LFAXNhCNvYbyx3Wtvw==
X-Received: by 2002:a2e:814a:: with SMTP id t10mr2410500ljg.318.1628762831975; 
 Thu, 12 Aug 2021 03:07:11 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id o8sm212528lfo.292.2021.08.12.03.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Aug 2021 03:07:11 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
 id B75B41028BC; Thu, 12 Aug 2021 13:07:24 +0300 (+03)
Date: Thu, 12 Aug 2021 13:07:24 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
Message-ID: <20210812100724.t4cdh7xbkuqgnsc3@box.shutemov.name>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
 <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
 <20210811121917.ghxi7g4mctuybhbk@box.shutemov.name>
 <0a819549-e481-c004-7da8-82ba427b13ce@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a819549-e481-c004-7da8-82ba427b13ce@amd.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Ingo Molnar <mingo@redhat.com>, linux-graphics-maintainer@vmware.com,
 Dave Young <dyoung@redhat.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Aug 11, 2021 at 10:52:55AM -0500, Tom Lendacky wrote:
> On 8/11/21 7:19 AM, Kirill A. Shutemov wrote:
> > On Tue, Aug 10, 2021 at 02:48:54PM -0500, Tom Lendacky wrote:
> >> On 8/10/21 1:45 PM, Kuppuswamy, Sathyanarayanan wrote:
> >>>
> >>>
> >>> On 7/27/21 3:26 PM, Tom Lendacky wrote:
> >>>> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> >>>> index de01903c3735..cafed6456d45 100644
> >>>> --- a/arch/x86/kernel/head64.c
> >>>> +++ b/arch/x86/kernel/head64.c
> >>>> @@ -19,7 +19,7 @@
> >>>> =A0 #include <linux/start_kernel.h>
> >>>> =A0 #include <linux/io.h>
> >>>> =A0 #include <linux/memblock.h>
> >>>> -#include <linux/mem_encrypt.h>
> >>>> +#include <linux/protected_guest.h>
> >>>> =A0 #include <linux/pgtable.h>
> >>>> =A0 =A0 #include <asm/processor.h>
> >>>> @@ -285,7 +285,7 @@ unsigned long __head __startup_64(unsigned long
> >>>> physaddr,
> >>>> =A0=A0=A0=A0=A0=A0 * there is no need to zero it after changing the =
memory encryption
> >>>> =A0=A0=A0=A0=A0=A0 * attribute.
> >>>> =A0=A0=A0=A0=A0=A0 */
> >>>> -=A0=A0=A0 if (mem_encrypt_active()) {
> >>>> +=A0=A0=A0 if (prot_guest_has(PATTR_MEM_ENCRYPT)) {
> >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 vaddr =3D (unsigned long)__start_bss_dec=
rypted;
> >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 vaddr_end =3D (unsigned long)__end_bss_d=
ecrypted;
> >>>
> >>>
> >>> Since this change is specific to AMD, can you replace PATTR_MEM_ENCRY=
PT with
> >>> prot_guest_has(PATTR_SME) || prot_guest_has(PATTR_SEV). It is not use=
d in
> >>> TDX.
> >>
> >> This is a direct replacement for now.
> > =

> > With current implementation of prot_guest_has() for TDX it breaks boot =
for
> > me.
> > =

> > Looking at code agains, now I *think* the reason is accessing a global
> > variable from __startup_64() inside TDX version of prot_guest_has().
> > =

> > __startup_64() is special. If you access any global variable you need to
> > use fixup_pointer(). See comment before __startup_64().
> > =

> > I'm not sure how you get away with accessing sme_me_mask directly from
> > there. Any clues? Maybe just a luck and complier generates code just ri=
ght
> > for your case, I donno.
> =

> Hmm... yeah, could be that the compiler is using rip-relative addressing
> for it because it lives in the .data section?

I guess. It has to be fixed. It may break with complier upgrade or any
random change around the code.

BTW, does it work with clang for you?

> For the static variables in mem_encrypt_identity.c I did an assembler rip
> relative LEA, but probably could have passed physaddr to sme_enable() and
> used a fixup_pointer() style function, instead.

Sounds like a plan.

> > A separate point is that TDX version of prot_guest_has() relies on
> > cpu_feature_enabled() which is not ready at this point.
> =

> Does TDX have to do anything special to make memory able to be shared with
> the hypervisor?

Yes. But there's nothing that required any changes in early boot. It
handled in ioremap/set_memory.

> You might have to use something that is available earlier
> than cpu_feature_enabled() in that case (should you eventually support
> kvmclock).

Maybe.

> > I think __bss_decrypted fixup has to be done if sme_me_mask is non-zero.
> > Or just do it uncoditionally because it's NOP for sme_me_mask =3D=3D 0.
> =

> For SNP, we'll have to additionally call the HV to update the RMP to make
> the memory shared. But that could also be done unconditionally since the
> early_snp_set_memory_shared() routine will check for SNP before doing
> anything.

-- =

 Kirill A. Shutemov
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
