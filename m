Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C796C43216
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 18:42:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3685E60F39
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 18:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3685E60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 040AA80D67;
	Tue, 17 Aug 2021 18:42:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BVo_kziMpOgZ; Tue, 17 Aug 2021 18:42:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DBA0D80D5C;
	Tue, 17 Aug 2021 18:42:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E6B8C001A;
	Tue, 17 Aug 2021 18:42:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47909C000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 18:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9474A40222
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 18:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2WqsQ8OCD47P for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 18:42:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50CF040004
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 18:42:25 +0000 (UTC)
Received: from zn.tnic (p200300ec2f1175006a73053df3c19379.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f11:7500:6a73:53d:f3c1:9379])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 67D751EC0559;
 Tue, 17 Aug 2021 20:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1629225739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=jwHmTRBxms0tT4WTh/1AEjKmHnFY2JEsZVwdmytONsI=;
 b=KUP43T/bbaLdWz5U9wKbKVFP3nxo6dCpoeUMqYVESUmDVYPqF7FOKus0G3XWX3cM5OK90C
 Z1nlDzK6oSVm6BUH703vTAa0VXAopMrWpN5FYaeDCJW+3HCE3QNA5Iw/IIGv3elLZjmMRp
 2mfXuzpSvQPweo6qtlAFOCuqNaxW0kk=
Date: Tue, 17 Aug 2021 20:43:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 06/12] x86/sev: Replace occurrences of sev_active()
 with prot_guest_has()
Message-ID: <YRwDN+hkQpuSp+Vt@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <2b3a8fc4659f2e7617399cecdcca549e0fa1dcb7.1628873970.git.thomas.lendacky@amd.com>
 <YRuJPqxFZ6ItZd++@zn.tnic>
 <b346ae1b-dbd3-cdbd-b5cd-b5ab9c304737@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b346ae1b-dbd3-cdbd-b5cd-b5ab9c304737@amd.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
 linux-graphics-maintainer@vmware.com, Joerg Roedel <jroedel@suse.de>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Andy Lutomirski <luto@kernel.org>,
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

On Tue, Aug 17, 2021 at 10:26:18AM -0500, Tom Lendacky wrote:
> >>  	/*
> >> -	 * If SME is active we need to be sure that kexec pages are
> >> -	 * not encrypted because when we boot to the new kernel the
> >> +	 * If host memory encryption is active we need to be sure that kexec
> >> +	 * pages are not encrypted because when we boot to the new kernel the
> >>  	 * pages won't be accessed encrypted (initially).
> >>  	 */
> > 
> > That hunk belongs logically into the previous patch which removes
> > sme_active().
> 
> I was trying to keep the sev_active() changes separate... so even though
> it's an SME thing, I kept it here. But I can move it to the previous
> patch, it just might look strange.

Oh I meant only the comment because it is a SME-related change. But not
too important so whatever.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
