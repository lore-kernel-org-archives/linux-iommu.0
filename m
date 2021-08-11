Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A19FC4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 12:19:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D370260FC4
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 12:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D370260FC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9612A60878;
	Wed, 11 Aug 2021 12:19:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id inZupzHF8VxQ; Wed, 11 Aug 2021 12:19:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5D51160093;
	Wed, 11 Aug 2021 12:19:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B91AC001A;
	Wed, 11 Aug 2021 12:19:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F81BC000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E0CF4045A
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:19:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id coaDVyhS-xDS for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:19:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C36840472
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:19:08 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id g30so5291130lfv.4
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=QRfjFOudnOiwA+M7/UAaVDTJpihSFBYjea6mHo6NSYA=;
 b=FrdABWFOYFHYVQYvsn9eIFG1XXIqUnaFBCPEPrWXTbkImjcaYqnfbbDKJbjXTj8n2z
 XKpeeMl+HDYMaw1njH7BCzSmXb2GWH1pBn4+E1w1Zkax9zqjTCMN0ceFLpN0oNSL7p4h
 tTOYo06jVnb3EuSp9CAkw3RajLjCGRh5DcWWOVaUC3oCLa3fiXHjMHrKiPKxkbd9MHf4
 XWiG9YDES/j+Q6K8AbBgatHhy3Ey7EF4Mw9l8egNLjOvPiIJBkLqlDJHfGJd1OD2IwY9
 /Dj5oeYRUTA55X3eykWwXtvq+RdRhaXu8H17iGSYXfRtDXdJr3ACYPa147h4M5kexh1Q
 1YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QRfjFOudnOiwA+M7/UAaVDTJpihSFBYjea6mHo6NSYA=;
 b=YHeQJyvv1pA/hSXstwixwa3dmoMf5tvIQTo3EdO6jb9o2ELFbGxRxuWiD9Jxhm48QM
 E45yzoKvePYIz6vXNG2zq0h7VqYbfpKcX+qDNvsQ4x7mcdP28JCp4YvoWQfpljwlOO3i
 uV5YlxZLp+f2/H/n0dJqADuXYf7cfG4MpRVwaKXAnWcW2R1tvkLHlE3LWxn1By6kwaF8
 W/a8KM0eShBEEifMdOpSL5xvKk6wrF8S16QxriCPMb5rrCkk53BSOr3rRQQsJ3l5Fqme
 Iyk4pX/IbOCW63fwgHxUX/n9mDIXiYDEMTfC5svZAoVo6Xzx5kmbvfxG7+BuTcuFXlMl
 kJ2A==
X-Gm-Message-State: AOAM532+ETznhzZ/Z/OQTq2qz4CauAKtTOmRf0liA1qx/P34pOrmTGIX
 yTUHffgmVcVUo+4YVJ8yCVhE6A==
X-Google-Smtp-Source: ABdhPJwYqCmmrayYkwT8dKOh/tHUuUvcGTl6bQD02skpgV77PxIfPFHOo1k2HSgXk2Z2qwWhaj6ksA==
X-Received: by 2002:ac2:50d8:: with SMTP id h24mr4762329lfm.631.1628684346244; 
 Wed, 11 Aug 2021 05:19:06 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id w7sm2337599lft.285.2021.08.11.05.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 05:19:05 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
 id A68EB102A2E; Wed, 11 Aug 2021 15:19:17 +0300 (+03)
Date: Wed, 11 Aug 2021 15:19:17 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
Message-ID: <20210811121917.ghxi7g4mctuybhbk@box.shutemov.name>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
 <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
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

On Tue, Aug 10, 2021 at 02:48:54PM -0500, Tom Lendacky wrote:
> On 8/10/21 1:45 PM, Kuppuswamy, Sathyanarayanan wrote:
> > =

> > =

> > On 7/27/21 3:26 PM, Tom Lendacky wrote:
> >> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> >> index de01903c3735..cafed6456d45 100644
> >> --- a/arch/x86/kernel/head64.c
> >> +++ b/arch/x86/kernel/head64.c
> >> @@ -19,7 +19,7 @@
> >> =A0 #include <linux/start_kernel.h>
> >> =A0 #include <linux/io.h>
> >> =A0 #include <linux/memblock.h>
> >> -#include <linux/mem_encrypt.h>
> >> +#include <linux/protected_guest.h>
> >> =A0 #include <linux/pgtable.h>
> >> =A0 =A0 #include <asm/processor.h>
> >> @@ -285,7 +285,7 @@ unsigned long __head __startup_64(unsigned long
> >> physaddr,
> >> =A0=A0=A0=A0=A0=A0 * there is no need to zero it after changing the me=
mory encryption
> >> =A0=A0=A0=A0=A0=A0 * attribute.
> >> =A0=A0=A0=A0=A0=A0 */
> >> -=A0=A0=A0 if (mem_encrypt_active()) {
> >> +=A0=A0=A0 if (prot_guest_has(PATTR_MEM_ENCRYPT)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 vaddr =3D (unsigned long)__start_bss_decry=
pted;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 vaddr_end =3D (unsigned long)__end_bss_dec=
rypted;
> > =

> > =

> > Since this change is specific to AMD, can you replace PATTR_MEM_ENCRYPT=
 with
> > prot_guest_has(PATTR_SME) || prot_guest_has(PATTR_SEV). It is not used =
in
> > TDX.
> =

> This is a direct replacement for now.

With current implementation of prot_guest_has() for TDX it breaks boot for
me.

Looking at code agains, now I *think* the reason is accessing a global
variable from __startup_64() inside TDX version of prot_guest_has().

__startup_64() is special. If you access any global variable you need to
use fixup_pointer(). See comment before __startup_64().

I'm not sure how you get away with accessing sme_me_mask directly from
there. Any clues? Maybe just a luck and complier generates code just right
for your case, I donno.

A separate point is that TDX version of prot_guest_has() relies on
cpu_feature_enabled() which is not ready at this point.

I think __bss_decrypted fixup has to be done if sme_me_mask is non-zero.
Or just do it uncoditionally because it's NOP for sme_me_mask =3D=3D 0.

> I think the change you're requesting
> should be done as part of the TDX support patches so it's clear why it is
> being changed.
> =

> But, wouldn't TDX still need to do something with this shared/unencrypted
> area, though? Or since it is shared, there's actually nothing you need to
> do (the bss decrpyted section exists even if CONFIG_AMD_MEM_ENCRYPT is not
> configured)?

AFAICS, only kvmclock uses __bss_decrypted. We don't enable kvmclock in
TDX at the moment. It may change in the future.

-- =

 Kirill A. Shutemov
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
