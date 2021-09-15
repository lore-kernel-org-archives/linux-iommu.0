Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78014C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 16:46:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FF16121F
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 16:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9FF16121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2E2440413;
	Wed, 15 Sep 2021 16:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZiQYG0B2JmhC; Wed, 15 Sep 2021 16:46:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E304A403DD;
	Wed, 15 Sep 2021 16:46:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAC4EC0011;
	Wed, 15 Sep 2021 16:46:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA594C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 16:46:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9974827C6
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 16:46:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vg1-qDNF0CWx for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 16:46:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 32AED827BB
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 16:46:19 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0d07008534a6109a52ea91.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0d:700:8534:a610:9a52:ea91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 04D0A1EC051F;
 Wed, 15 Sep 2021 18:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1631724372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=ohcK2lrqZI/0Un5cQQISQvRNuEO3HIFBods4v3gznU8=;
 b=OinwDiMHyIs6ppSqYums+HJ/wABxvhGKKUPvdDics4JXpIwsFCihfmg/tYjRwayQUS5zAl
 /A8dCEMw7DwHpgzspvS586x6N5hMBRCXCrXZr4wBrq7mNNSRVp8ss+I1qG84M8RgMvHJvz
 7a85Vcl/oUKHuIwbTjsfd22UCB+v5Mg=
Date: Wed, 15 Sep 2021 18:46:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v3 0/8] Implement generic cc_platform_has() helper function
Message-ID: <YUIjS6lKEY5AadZx@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1631141919.git.thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 linux-graphics-maintainer@vmware.com, Dave Young <dyoung@redhat.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Sep 08, 2021 at 05:58:31PM -0500, Tom Lendacky wrote:
> This patch series provides a generic helper function, cc_platform_has(),
> to replace the sme_active(), sev_active(), sev_es_active() and
> mem_encrypt_active() functions.
> 
> It is expected that as new confidential computing technologies are
> added to the kernel, they can all be covered by a single function call
> instead of a collection of specific function calls all called from the
> same locations.
> 
> The powerpc and s390 patches have been compile tested only. Can the
> folks copied on this series verify that nothing breaks for them. Also,
> a new file, arch/powerpc/platforms/pseries/cc_platform.c, has been
> created for powerpc to hold the out of line function.

...

> 
> Tom Lendacky (8):
>   x86/ioremap: Selectively build arch override encryption functions
>   mm: Introduce a function to check for confidential computing features
>   x86/sev: Add an x86 version of cc_platform_has()
>   powerpc/pseries/svm: Add a powerpc version of cc_platform_has()
>   x86/sme: Replace occurrences of sme_active() with cc_platform_has()
>   x86/sev: Replace occurrences of sev_active() with cc_platform_has()
>   x86/sev: Replace occurrences of sev_es_active() with cc_platform_has()
>   treewide: Replace the use of mem_encrypt_active() with
>     cc_platform_has()

Ok, modulo the minor things the plan is to take this through tip after
-rc2 releases in order to pick up the powerpc build fix and have a clean
base (-rc2) to base stuff on, at the same time.

Pls holler if something's still amiss.

Sathya,

if you want to prepare the Intel variant intel_cc_platform_has() ontop
of those and send it to me, that would be good because then I can
integrate it all in one branch which can be used to base future work
ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
