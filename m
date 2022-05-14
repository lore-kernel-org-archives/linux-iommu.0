Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A037C433EF
	for <iommu@archiver.kernel.org>; Sat, 14 May 2022 08:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AADAA83F2F;
	Sat, 14 May 2022 08:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UbDdRMDZv71s; Sat, 14 May 2022 08:15:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6E59783F24;
	Sat, 14 May 2022 08:15:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E77DC0032;
	Sat, 14 May 2022 08:15:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BC3AC002D
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 08:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0346940983
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 08:15:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="Tm0Wc2Hr";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="DQ1ba3l4"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KT2goVJVN2hl for <iommu@lists.linux-foundation.org>;
 Sat, 14 May 2022 08:15:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2940240982
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 08:15:28 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1652516125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UHF9WVJF89fHPJq0+8oiweP3wjgNVxTMSM/vRu60nYc=;
 b=Tm0Wc2HrL4EoLv6k4cC472VP8Biprl05MvetpUZPEzW0ctnc4AfNAc9GzrCaDwbUR7asay
 k9meZSHbxU07Wx7caJes3ehRYibTz13rBlObuMSuFk7ZgN3LUGwEFHSwzQDAbs76ml91Iv
 TfrRfjYmgQ6VlChzQQtCqbE57X4yHCjEY/nFJ+u//Q0QW7b86PnnHZ0bks5Z5KNxstDgFB
 8ieqdzZXwb8nQd54BAROxS5Y0qPLEeda5doQcCE+EFzABk7gxmFkNcD+FzEZp8aT5/YOg/
 zBTpa9/aRp4PQD0V/GvzjQhFx5s/3qzmVoPUo4/nyL1Yd+fdRZVYofcuJu1UWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1652516125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UHF9WVJF89fHPJq0+8oiweP3wjgNVxTMSM/vRu60nYc=;
 b=DQ1ba3l4HOXe/g0FH1Hxfxmq/Jov5eLSl+952ajCcfZuyexUDsvo3a6HGCEtaOgGvBGZVv
 W7XCCMG7O6GU1PCg==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v6 05/29] x86/apic/vector: Do not allocate vectors for NMIs
In-Reply-To: <20220513234542.GC9074@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-6-ricardo.neri-calderon@linux.intel.com>
 <87zgjufjrf.ffs@tglx> <20220513180320.GA22683@ranerica-svr.sc.intel.com>
 <87v8u9rwce.ffs@tglx> <20220513234542.GC9074@ranerica-svr.sc.intel.com>
Date: Sat, 14 May 2022 10:15:24 +0200
Message-ID: <87sfpcsf6r.ffs@tglx>
MIME-Version: 1.0
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On Fri, May 13 2022 at 16:45, Ricardo Neri wrote:
> On Fri, May 13, 2022 at 10:50:09PM +0200, Thomas Gleixner wrote:
>> > Also, if lapic_nmi_controller.irq_set_affinity() is NULL, then irq_chips
>> > INTEL-IR, AMD-IR, those using msi_domain_set_affinity() need to check for NULL.
>> > They currently unconditionally call the parent irq_chip's irq_set_affinity().
>> > I see that there is a irq_chip_set_affinity_parent() function. Perhaps it can
>> > be used for this check?
>> 
>> Yes, this lacks obviously a NMI specific set_affinity callback and this
>> can be very trivial and does not have any of the complexity of interrupt
>> affinity assignment. First online CPU in the mask with a fallback to any
>> online CPU.
>
> Why would we need a fallback to any online CPU? Shouldn't it fail if it cannot
> find an online CPU in the mask?

Might as well fail. Let me think about it.

>> I did not claim that this is complete. This was for illustration.
>
> In the reworked patch, may I add a Co-developed-by with your name and your SOB?

Suggested-by is good enough.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
