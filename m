Return-Path: <SRS0=qbNH=NK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC46C4338F
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 09:54:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A1A610FA
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 09:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9A1A610FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B45A880EC5;
	Thu, 19 Aug 2021 09:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vfiO_B3dU9ix; Thu, 19 Aug 2021 09:54:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B060480C4B;
	Thu, 19 Aug 2021 09:54:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8499CC0010;
	Thu, 19 Aug 2021 09:54:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38A2CC000E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 09:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19A4F40182
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 09:54:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KefP2-6oTVSI for <iommu@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 09:54:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0ECC1401F5
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 09:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=30I+7nEm5zbvXFaNjeCP/URwvn0lUxkdZ8/N2SFqU4g=; b=hdp6qYYIiawPbHWzGgJGbeGDoL
 TskujUOUgkw5fqQ32Dq09FqOv51wvLWbNrcrdw3wg7CGsAtqwE0y+rW5EzXhdMJx/nO7U+/vDSAxy
 ZGC4r6aC4wc44wp1pn/5iT/tBmcMPk/3CafPQ6Y6Tjjhb6zYRI/6S5OA4cG/Qk8BIe9OYWnnx7d8w
 7GhnTeyRi2ZmTBFWwHRyV84JdQ6eKrGvxUZFLENaT0zcmJ62SNY0OjvyFBg+eHiiFyXh1CKCQ5zLg
 4phvLD2DSvHmVFPqRiYmTfBtb2/AVqElq02npejAimvBLZXPdunESEx0AVEqb2PzRTbXPbtdOrilL
 U+nUWJXA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mGejF-004tP2-Ci; Thu, 19 Aug 2021 09:53:07 +0000
Date: Thu, 19 Aug 2021 10:52:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
Message-ID: <YR4p9TqKTLdN1A96@infradead.org>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-s390@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, x86@kernel.org, amd-gfx@lists.freedesktop.org,
 Ingo Molnar <mingo@redhat.com>, linux-graphics-maintainer@vmware.com,
 Joerg Roedel <jroedel@suse.de>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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

On Fri, Aug 13, 2021 at 11:59:22AM -0500, Tom Lendacky wrote:
> While the name suggests this is intended mainly for guests, it will
> also be used for host memory encryption checks in place of sme_active().

Which suggest that the name is not good to start with.  Maybe protected
hardware, system or platform might be a better choice?

> +static inline bool prot_guest_has(unsigned int attr)
> +{
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	if (sme_me_mask)
> +		return amd_prot_guest_has(attr);
> +#endif
> +
> +	return false;
> +}

Shouldn't this be entirely out of line?

> +/* 0x800 - 0x8ff reserved for AMD */
> +#define PATTR_SME			0x800
> +#define PATTR_SEV			0x801
> +#define PATTR_SEV_ES			0x802

Why do we need reservations for a purely in-kernel namespace?

And why are you overoading a brand new generic API with weird details
of a specific implementation like this?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
