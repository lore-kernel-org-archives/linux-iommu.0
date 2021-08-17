Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A487CC432BE
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 10:05:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D49960F38
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 10:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D49960F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0398F402F4;
	Tue, 17 Aug 2021 10:05:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IFmVQJPSrKk0; Tue, 17 Aug 2021 10:05:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7DE8F402EC;
	Tue, 17 Aug 2021 10:05:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5149DC0010;
	Tue, 17 Aug 2021 10:05:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F042C000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 10:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 551E680CD8
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 10:05:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qahrgd_bqiZr for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 10:05:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2ECE480A62
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 10:05:33 +0000 (UTC)
Received: from zn.tnic (p200300ec2f1175001ae0093e4550657c.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f11:7500:1ae0:93e:4550:657c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95A9E1EC054F;
 Tue, 17 Aug 2021 12:05:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1629194726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=G4eAMTLu2hDkmoQ61+xUHXsjuZXklNaVdRb9b01R0LQ=;
 b=Ezlf7E6kfbk0wj1UX675PJCY/0eAzfm/7wQ3tUGxLlaOWwjDy3wVFlLkLlMNFvuVYmxMAN
 rZSuujCI9mCbXFtsrDcS2WemZquPZaiynSjn8JL5aSXkmF+a+fD163HXMC9x07FG8oGDik
 Bg4RCUoOLPaIIAXfzgh6O65GYecZeCA=
Date: Tue, 17 Aug 2021 12:06:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 07/12] x86/sev: Replace occurrences of sev_es_active()
 with prot_guest_has()
Message-ID: <YRuKEhzOh8pO4He1@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <0b8480d93b5090fcc34cf5d5035d4d89aa765d79.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0b8480d93b5090fcc34cf5d5035d4d89aa765d79.1628873970.git.thomas.lendacky@amd.com>
Cc: linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
 Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 iommu@lists.linux-foundation.org, Andi Kleen <ak@linux.intel.com>,
 linux-graphics-maintainer@vmware.com, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@redhat.com>
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

On Fri, Aug 13, 2021 at 11:59:26AM -0500, Tom Lendacky wrote:
> Replace occurrences of sev_es_active() with the more generic
> prot_guest_has() using PATTR_GUEST_PROT_STATE, except for in
> arch/x86/kernel/sev*.c and arch/x86/mm/mem_encrypt*.c where PATTR_SEV_ES
> will be used. If future support is added for other memory encyrption
> techonologies, the use of PATTR_GUEST_PROT_STATE can be updated, as
> required, to specifically use PATTR_SEV_ES.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h | 2 --
>  arch/x86/kernel/sev.c              | 6 +++---
>  arch/x86/mm/mem_encrypt.c          | 7 +++----
>  arch/x86/realmode/init.c           | 3 +--
>  4 files changed, 7 insertions(+), 11 deletions(-)

Same comments to this one as for the previous two.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
