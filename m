Return-Path: <SRS0=4dF3=NP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DE3C4338F
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 07:17:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B60761361
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 07:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B60761361
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AC47404B1;
	Tue, 24 Aug 2021 07:17:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2E8bQzlRWtIB; Tue, 24 Aug 2021 07:17:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EC98540494;
	Tue, 24 Aug 2021 07:17:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFCA6C0010;
	Tue, 24 Aug 2021 07:17:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BC69C000E
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 07:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 25C7B6069F
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 07:17:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4AnRm60NXBX7 for <iommu@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 07:17:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 674C660683
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 07:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=u2jjKxNoYoIqkuUBOVaU0g9hA7j5FEUKEzONmfPEFRs=; b=l0RA5+0lIDtpN8Qsm8qgG9uLOs
 8eClxBaokH3TyZM/fu8ykw6ZD3oCED17rxUrpLs0TtHot/9XJECBVSsY9dqwrfZEMuNDPQh43FRwB
 gwr+bd3HMFV1W5C6/t8vtIAK0gchzdE/kqUnfspiLdm9pQGzx1360mkBMMfe+XyJFRijFq2K3ePSr
 Jff3vPErlsbRwyhgZ70I86mOyH8JMJcY3mI4n/qCuMatfUmzB4kKpKhH3faryhLixp+fcY+HXVAOh
 PoC9+BbF8dkfZF5wppyEi6qopLgHXvjed9HLCvhzBV9c0zMcG0Q8n3Oaf7OpZqZFQwTLhSiLC+K35
 CAj2ybqg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mIQdm-00AhZQ-Cu; Tue, 24 Aug 2021 07:14:45 +0000
Date: Tue, 24 Aug 2021 08:14:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
Message-ID: <YSScWvpXeVXw/ed5@infradead.org>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
 <YR4p9TqKTLdN1A96@infradead.org>
 <4272eaf5-b654-2669-62ac-ba768acd6b91@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4272eaf5-b654-2669-62ac-ba768acd6b91@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-s390@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, x86@kernel.org, amd-gfx@lists.freedesktop.org,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-graphics-maintainer@vmware.com, Joerg Roedel <jroedel@suse.de>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

On Thu, Aug 19, 2021 at 01:33:09PM -0500, Tom Lendacky wrote:
> I did it as inline originally because the presence of the function will be
> decided based on the ARCH_HAS_PROTECTED_GUEST config. For now, that is
> only selected by the AMD memory encryption support, so if I went out of
> line I could put in mem_encrypt.c. But with TDX wanting to also use it, it
> would have to be in an always built file with some #ifdefs or in its own
> file that is conditionally built based on the ARCH_HAS_PROTECTED_GUEST
> setting (they've already tried building with ARCH_HAS_PROTECTED_GUEST=y
> and AMD_MEM_ENCRYPT not set).
> 
> To take it out of line, I'm leaning towards the latter, creating a new
> file that is built based on the ARCH_HAS_PROTECTED_GUEST setting.

Yes.  In general everytime architectures have to provide the prototype
and not just the implementation of something we end up with a giant mess
sooner or later.  In a few cases that is still warranted due to
performance concerns, but i don't think that is the case here.

> 
> > 
> >> +/* 0x800 - 0x8ff reserved for AMD */
> >> +#define PATTR_SME			0x800
> >> +#define PATTR_SEV			0x801
> >> +#define PATTR_SEV_ES			0x802
> > 
> > Why do we need reservations for a purely in-kernel namespace?
> > 
> > And why are you overoading a brand new generic API with weird details
> > of a specific implementation like this?
> 
> There was some talk about this on the mailing list where TDX and SEV may
> need to be differentiated, so we wanted to reserve a range of values per
> technology. I guess I can remove them until they are actually needed.

In that case add a flag for the differing behavior.  And only add them
when actually needed.  And either way there is absolutely no need to
reserve ranges.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
