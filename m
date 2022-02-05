Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CA4C433FE
	for <iommu@archiver.kernel.org>; Sat,  5 Feb 2022 00:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7228E4019C;
	Sat,  5 Feb 2022 00:00:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2HcJsDEOX86; Sat,  5 Feb 2022 00:00:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3050740519;
	Sat,  5 Feb 2022 00:00:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16250C0011;
	Sat,  5 Feb 2022 00:00:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A06DC000B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 00:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 694F860AD2
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 00:00:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="ZC/k4ygM";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="fmhRS+PI"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VAMjoMCtEZ5C for <iommu@lists.linux-foundation.org>;
 Sat,  5 Feb 2022 00:00:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D457260A79
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 00:00:13 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1644019211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mx9Em6t7Oq1XkCGBllE1H//5kNZjsQ4FsvjxDnQCdsI=;
 b=ZC/k4ygMJrw6KhHoq+lMoDt/kP5qXmR99l2FrtN0PFRAxhikYflsbFVcByf8t2HY+WsgUM
 rAsVLzDv/DH9qJ8MtCHpfPI2xZ0v/Q3ixkhH4MpDilGj6A4SiBWv76wZdNyQa1ZNoAcjYs
 6kf/Rvl6BRxpxlzmtvPV3I3aWmi66KIzLgtFGfJS4cPH6h/yYMQ1wh5XLQJwRRefTqdJN/
 0pUMmlNJptuNwr8/cMejjDrFJIjhbgNfuP+jKaDta+q4otsagp6p+wPNOSMUzL/lku3Q5N
 NfUWc26LHIszQxVS41725w6NdYp5ehCeF1pbSI7l2wpQzjHMTZ8qErO6Gw1DHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1644019211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mx9Em6t7Oq1XkCGBllE1H//5kNZjsQ4FsvjxDnQCdsI=;
 b=fmhRS+PIT8HbTJahChStse4kensgIhjloMAre7/3TGNh+Th9f94mkf+siIs2XOjrYvgTz6
 JkWo3ipIJOarTdAg==
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy
 Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok
 Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v3 08/11] x86/traps: Demand-populate PASID MSR via #GP
In-Reply-To: <20220128202905.2274672-9-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-9-fenghua.yu@intel.com>
Date: Sat, 05 Feb 2022 01:00:11 +0100
Message-ID: <87iltub2t0.ffs@tglx>
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

On Fri, Jan 28 2022 at 12:29, Fenghua Yu wrote:

> All tasks start with PASID state disabled. This means that the first
> time they execute an ENQCMD instruction they will take a #GP fault.
>
> Modify the #GP fault handler to check if the "mm" for the task has
> already been allocated a PASID. If so, try to fix the #GP fault by
> loading the IA32_PASID MSR.
>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
