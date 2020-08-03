Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02014C433E1
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 15:12:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C116D20775
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 15:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0/f4b8/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C116D20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7162C20490;
	Mon,  3 Aug 2020 15:12:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gD77vVBJSUXB; Mon,  3 Aug 2020 15:12:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 908A320117;
	Mon,  3 Aug 2020 15:12:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8191EC0051;
	Mon,  3 Aug 2020 15:12:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFDCBC004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 15:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CECE185C7A
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 15:12:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9IUHhsypYy2 for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 15:12:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5C3E085BD5
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 15:12:32 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EA60C22BEB
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596467551;
 bh=+PZ/awBxxRTMw2BeBwqmtU59rWiDwd7Tyrz4gbzxrPI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0/f4b8/09auXonUnapsGzATJEFpuQt2ckgRpCmNzlIVMXQHi1eCxGLxYavFmhfKvv
 C2kxNDkhIOpg/osZuSwpo2ywTRfz6bkY3OJF5UvfhxkmNadk37TFmqVfdZP/JvTFFM
 /K7KIaULvc0BVWY+ZzLoEBa6FS6F3JWY0TYN39T0=
Received: by mail-wm1-f52.google.com with SMTP id f18so219163wmc.0
 for <iommu@lists.linux-foundation.org>; Mon, 03 Aug 2020 08:12:31 -0700 (PDT)
X-Gm-Message-State: AOAM533a0jj1hYDqn7C6QIZyPFf8vTam3eGB+jSY0Rht6W3eKFIWfp+t
 Mr6STJ+p4c3UFbvoYwGhOdMmOGPrY+i/mdik2pbndA==
X-Google-Smtp-Source: ABdhPJwiaA4kvJyZgwWanbpbA2UDgr/APeGodXtQoq2MM4XlnMkdWJK9xJVz1B9yxVMecsh5WGJ2L5eyBMVqiOoZypY=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr436874wmc.138.1596467549637;
 Mon, 03 Aug 2020 08:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
 <CALCETrXnO4oh+WyxtSM-j_pP4QgkSg24=y76OBEHxXxAfJtPhA@mail.gmail.com>
 <f6d34d59-e6eb-ee9f-d247-8fb2f0e37549@intel.com>
In-Reply-To: <f6d34d59-e6eb-ee9f-d247-8fb2f0e37549@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 3 Aug 2020 08:12:18 -0700
X-Gmail-Original-Message-ID: <CALCETrXLFwzCzoE8ZjciBO_WSK8StyTfO1yXVm4v2qFQZpfasg@mail.gmail.com>
Message-ID: <CALCETrXLFwzCzoE8ZjciBO_WSK8StyTfO1yXVm4v2qFQZpfasg@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Mon, Aug 3, 2020 at 8:03 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 7/31/20 4:34 PM, Andy Lutomirski wrote:
> >> Thomas suggested to provide a reason for the #GP caused by executing ENQCMD
> >> without a valid PASID value programmed. #GP error codes are 16 bits and all
> >> 16 bits are taken. Refer to SDM Vol 3, Chapter 16.13 for details. The other
> >> choice was to reflect the error code in an MSR. ENQCMD can also cause #GP
> >> when loading from the source operand, so its not fully comprehending all
> >> the reasons. Rather than special case the ENQCMD, in future Intel may
> >> choose a different fault mechanism for such cases if recovery is needed on
> >> #GP.
> > Decoding the user instruction is ugly and sets a bad architecture
> > precedent, but we already do it in #GP for UMIP.  So I'm unconvinced.
>
> I'll try to do one more bit of convincing. :)
>
> In the end, we need a way to figure out if the #GP was from a known "OK"
> source that we can fix up.  You're right that we could fire up the
> instruction decoder to help answer that question.  But, it (also)
> doesn't easily yield a perfect answer as to the source of the #GP, it
> always involves a user copy, and it's a larger code impact than what
> we've got.
>
> I think I went and looked at fixup_umip_exception(), and compared it to
> the alternative which is essentially just these three lines of code:
>
> > +     /*
> > +      * If the current task already has a valid PASID in the MSR,
> > +      * the #GP must be for some other reason.
> > +      */
> > +     if (current->has_valid_pasid)
> > +             return false;
> ...> +  /* Now the current task has a valid PASID in the MSR. */
> > +     current->has_valid_pasid = 1;
>
> and *I* was convinced that instruction decoding wasn't worth it.
>
> There's a lot of stuff that fixup_umip_exception() does which we don't
> have to duplicate, but it's going to be really hard to get it anywhere
> near as compact as what we've got.
>

I could easily be convinced that the PASID fixup is so trivial and so
obviously free of misfiring in a way that causes an infinite loop that
this code is fine.  But I think we first need to answer the bigger
question of why we're doing a lazy fixup in the first place.

--Andy
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
