Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2495DC433FE
	for <iommu@archiver.kernel.org>; Fri,  4 Feb 2022 23:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA37882A0B;
	Fri,  4 Feb 2022 23:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SDombtvSrbGA; Fri,  4 Feb 2022 23:22:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AACA88281A;
	Fri,  4 Feb 2022 23:22:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76B2FC0011;
	Fri,  4 Feb 2022 23:22:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAA17C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 23:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 832D260BAE
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 23:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="aBDit1Lk";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="0USIK3EJ"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tmd1OWKstZGy for <iommu@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 23:22:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD16760B77
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 23:22:14 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1644016932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DBK2yZNYxvLy8x/PDAEC/NG09v5eFxGT61LctE0oxSY=;
 b=aBDit1LkinvPfla5El5YaYm0kJu7cY2oxGsuMNIho93oSkb23VHPKLKfDIuNZT5GL2ZXsK
 TMF2V7N8gzmmi0wwtlMRKOtVPURyNjzeSE4j1kVjooS6o1HavQyxx7MlHx8vnTkHQtG7/x
 Faijrr64fpfWl3bPcBV63Zh5FNahx4KE7LxngzjUc2UixffxT5Ba0OuhgmulGbv8SbFNO7
 sd06yCQaFBq0jrREyL0RfZDMXkfzYpSTa+w+DKPGvNXH3JOkQB4gXct2S8dy9ubTJs1Ypt
 0fNlno6ElIe3scEa9P6ceksKYw3OHjRhSlE2E8tuaK0w0orsacxqjRRdw4JxDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1644016932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DBK2yZNYxvLy8x/PDAEC/NG09v5eFxGT61LctE0oxSY=;
 b=0USIK3EJKSRVIDVzeQ8qFn4rlRy37TsVmeexs71EbJ4kLHSFBJnN3VeIjAdrtxVUaJU3HP
 dqhQiGyXYf0dqEDA==
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy
 Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok
 Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v3 04/11] kernel/fork: Initialize mm's PASID
In-Reply-To: <20220128202905.2274672-5-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-5-fenghua.yu@intel.com>
Date: Sat, 05 Feb 2022 00:22:12 +0100
Message-ID: <87wniab4kb.ffs@tglx>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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

On Fri, Jan 28 2022 at 12:28, Fenghua Yu wrote:
> A new mm doesn't have a PASID yet when it's created. Initialize
> the mm's PASID on fork() or for init_mm to INVALID_IOASID (-1).

I must be missing something here.

> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index aa5f09ca5bcf..c74d1edbac2f 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -8,6 +8,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/gfp.h>
>  #include <linux/sync_core.h>
> +#include <linux/ioasid.h>
>  
>  /*
>   * Routines for handling mm_structs
> @@ -433,4 +434,13 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
>  }
>  #endif
>  
> +#ifdef CONFIG_IOMMU_SVA
> +static inline void mm_pasid_init(struct mm_struct *mm)
> +{
> +	mm->pasid = INVALID_IOASID;
> +}
> +#else
> +static inline void mm_pasid_init(struct mm_struct *mm) {}
> +#endif
> +
>  #endif /* _LINUX_SCHED_MM_H */

So this adds mm_pasid_init() to linux/sched/mm.h which replaces:

> -static void mm_init_pasid(struct mm_struct *mm)
> -{
> -#ifdef CONFIG_IOMMU_SVA
> -	mm->pasid = INIT_PASID;
> -#endif
> -}
> -

I.e. already existing code which is initializing mm->pasid with
INIT_PASID (0) while the replacement initializes it with INVALID_IOASID
(-1).

The change log does not have any information about why INIT_PASID is the
wrong initialization value and why this change is not having any side
effects.

It neither mentions why having this in a global available header makes
sense when the only call site is in the C file from which the already
existing function is removed.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
