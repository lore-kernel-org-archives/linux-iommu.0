Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11334C433FE
	for <iommu@archiver.kernel.org>; Fri,  4 Feb 2022 23:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB4E960A79;
	Fri,  4 Feb 2022 23:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VdB3BSyuhp69; Fri,  4 Feb 2022 23:56:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4138F60B77;
	Fri,  4 Feb 2022 23:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 164DFC0011;
	Fri,  4 Feb 2022 23:56:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CF98C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 23:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 729DF4019C
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 23:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="dl9H1uZ7";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="boPOAy3L"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m_rAZYOxBeai for <iommu@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 23:56:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 802D240004
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 23:56:04 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1644018961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=96SoL3E8HRraXhW4GJvLh32KeIwpXS7GySgMx5VXOrw=;
 b=dl9H1uZ7++7Lg9O8+nklBFbOMxVaazDBU+q+U0NCRS0OTWk7CG8E9MX67//cKNReM3zKyJ
 kfncVJ1nKkBjP1L9TVRAO9C9MZtC4m0B19lXjGaKYxU/g9i5reQE8vYYm5f6w1JMUQ2WJW
 nwmm+GY9MZRT6xxG19brdWjAlnccQLCV1HcMLqbQOQgsWaK16x6fO6MqZ8A2X5irI/EiGF
 3KlB8Cp9jdF/HyGLs15k1DTAer4b/VXtKypipqgBnoevbfkipIbDdLef+PLyPU/NJSuDzn
 zaU5OWVIoXtm0i0eZd+vfVLQ1zRrawlJ7A64Andor5vrPhXrvSb7X9TL7hNDOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1644018961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=96SoL3E8HRraXhW4GJvLh32KeIwpXS7GySgMx5VXOrw=;
 b=boPOAy3L0uN2tjlbFX4t2zq9awzckTNT1mstjB0iv6tj8UuvZH2u6cEj7x9WyBdmJ1y5ts
 ZpdYSFRPbV+iUKCA==
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy
 Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok
 Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v3 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <20220128202905.2274672-6-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-6-fenghua.yu@intel.com>
Date: Sat, 05 Feb 2022 00:56:00 +0100
Message-ID: <87r18ib2zz.ffs@tglx>
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
> To avoid complexity of updating each thread's PASID status (e.g. sending
> IPI to update IA32_PASID MSR) on allocating and freeing PASID, once
> allocated and assigned to an mm, the PASID stays with the mm for the
> rest of the mm's lifetime. A reference to the PASID is taken on
> allocating the PASID. Binding/unbinding the PASID won't change refcount.
> The reference is dropped on mm exit and thus the PASID is freed.
>
> Two helpers mm_pasid_set() and mm_pasid_drop() are defined in mm because
> the PASID operations handle the pasid member in mm_struct and should be
> part of mm operations. Because IOASID's reference count is not used any
> more and removed, unused ioasid_get() and iommu_sva_free_pasid()
> are deleted and ioasid_put() is renamed to ioasid_free().
>
> 20-bit PASID allows up to 1M processes bound to PASIDs at the same time.
> With cgroups and other controls that might limit the number of process
> creation, the limited number of PASIDs is not a realistic issue for
> lazy PASID free.

Please take a step back and think hard about it whether that changelog
makes sense to you a year from now.

Let me walk you through:

> To avoid complexity of updating each thread's PASID status (e.g. sending
> IPI to update IA32_PASID MSR) on allocating and freeing PASID, once
> allocated and assigned to an mm, the PASID stays with the mm for the
> rest of the mm's lifetime.

You are missing the oportunity to tell a story about the history of this
decision here:

  PASIDs are process wide. It was attempted to use refcounted PASIDs to
  free them when the last thread drops the refcount. This turned out to
  be complex and error prone. Given the fact that the PASID space is 20
  bits, which allows up to 1M processes to have a PASID associated
  concurrently, PASID resource exhaustion is not a realistic concern.

  Therefore it was decided to simplify the approach and stick with lazy
  on demand PASID allocation, but drop the eager free approach and make
  a allocated PASID lifetime bound to the life time of the process.

> A reference to the PASID is taken on allocating the
> PASID. Binding/unbinding the PASID won't change refcount.  The
> reference is dropped on mm exit and thus the PASID is freed.

There is no refcount in play anymore, right? So how does this part of
the changelog make any sense?

This is followed by:

> Two helpers mm_pasid_set() and mm_pasid_drop() are defined in mm because
> the PASID operations handle the pasid member in mm_struct and should be
> part of mm operations. Because IOASID's reference count is not used any
> more and removed, unused ioasid_get() and iommu_sva_free_pasid()
> are deleted and ioasid_put() is renamed to ioasid_free().

which does not provide much rationale and just blurbs about _what_ the
patch is doing and not about the why and the connection to the
above. And the refcount removal section contradicts the stale text
above.

So this paragraph should be something like this:

  Get rid of the refcounting mechanisms and replace/rename the
  interfaces to reflect this new approach.

Hmm?

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
