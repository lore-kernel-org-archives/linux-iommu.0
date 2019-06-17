Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BDCC31E5B
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 21:38:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79D820657
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 21:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="C6LL7GNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79D820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 916FCACD;
	Mon, 17 Jun 2019 21:38:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3D041A7F
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 21:38:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8E17B180
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 21:38:27 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id m24so24864138ioo.2
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=SrvOCOvD/npMq+rdmG0iHCrr8LGFgDfdEB1g1qFDyfA=;
	b=C6LL7GNcUBRJQpB4zer0JYaPOPHc6GgFgTD7zFDsGTMWqtavFEHHHuJY9nGPFDlXPO
	F4ENymilLNms/n63xiUPRRFNez8BJWTxNgoXwuTVW7uotERbMl0IbQ7apAg9paydetvx
	lD1n/XeTl9m3wdlz++cGBLpYAeATZ+/bVS6H7s1sD7egag9nX3ECnEP220eRW2T2Ai6r
	11tQf01dDaKEYauJ3XSiCh7V71ll0lk62RmmRFg6Mhn7VomHCrA9+1zNNk6pmG261jGj
	5ymslLp68rXct5A/uqKLTRCpTU3n39CZRertUHgD/LyL5E2M7qzTrDHi51ez+hRDy/Ho
	vjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=SrvOCOvD/npMq+rdmG0iHCrr8LGFgDfdEB1g1qFDyfA=;
	b=sdzwpKHknJu/18S/6ucITswXqsp1lKtkMxGB8TlGBZLeZs+0HesQW3IJc8KHnj3dGn
	x5hIxeunhPCDGK9GDV6xxn9sLKbhUfy2dCcZI5sZI18kwqqMcSEeD0a6G90LYJUIohbe
	ftbh9TyIgVWJ5PyQKsMgRwU3N1jc0GCwYcXGVv2c70qSDzZQhpfQiFWfs7seP07qZH6+
	WyJpYu8kpkhJgjSLl+B8JdJXBm++FH6cmQJvxqir3sy1soC8VpSnBqgytQi8ZLtUTMGo
	dfqrvF32Vv4zuhTlZgamHQJBRLUHv61ETj7xqYQSSAB7TZv/FyYW93iy6PwrraKMFQzt
	sVhA==
X-Gm-Message-State: APjAAAVkNg8OMdRJHvoIiCeb8l90UsnFmC9yaLue+hiUjiX2ZDJuUyvh
	X3NQCFt67IKM2s7cKhXiwwRLVtQoItNab8MxGaoZ+g==
X-Google-Smtp-Source: APXvYqxVirGRZJLjpWkTV40u2qY6sBuMI814IzMWFyU7NNbfyMpV+sjw99r1+rkY9sz6ebwCFPPIRXNd0ehymU/LPM4=
X-Received: by 2002:a5e:c207:: with SMTP id v7mr2637922iop.163.1560807506670; 
	Mon, 17 Jun 2019 14:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<alpine.DEB.2.21.1906162049300.1760@nanos.tec.linutronix.de>
	<alpine.DEB.2.21.1906171007360.1760@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906171007360.1760@nanos.tec.linutronix.de>
Date: Mon, 17 Jun 2019 14:38:14 -0700
Message-ID: <CABPqkBTai76Bgb4E61tF-mJUkFNxVa4B8M2bxTEYVgBsuAANNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 20/21] iommu/vt-d: hpet: Reserve an interrupt
	remampping table entry for watchdog
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>,
	Ricardo Neri <ricardo.neri@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Wincy Van <fanwenyi0529@gmail.com>,
	Ashok Raj <ashok.raj@intel.com>, x86 <x86@kernel.org>,
	Andi Kleen <andi.kleen@intel.com>, Borislav Petkov <bp@suse.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Stephane Eranian via iommu <iommu@lists.linux-foundation.org>
Reply-To: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On Mon, Jun 17, 2019 at 1:25 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sun, 16 Jun 2019, Thomas Gleixner wrote:
> > On Thu, 23 May 2019, Ricardo Neri wrote:
> > > When the hardlockup detector is enabled, the function
> > > hld_hpet_intremapactivate_irq() activates the recently created entry
> > > in the interrupt remapping table via the modify_irte() functions. While
> > > doing this, it specifies which CPU the interrupt must target via its APIC
> > > ID. This function can be called every time the destination iD of the
> > > interrupt needs to be updated; there is no need to allocate or remove
> > > entries in the interrupt remapping table.
> >
> > Brilliant.
> >
> > > +int hld_hpet_intremap_activate_irq(struct hpet_hld_data *hdata)
> > > +{
> > > +   u32 destid = apic->calc_dest_apicid(hdata->handling_cpu);
> > > +   struct intel_ir_data *data;
> > > +
> > > +   data = (struct intel_ir_data *)hdata->intremap_data;
> > > +   data->irte_entry.dest_id = IRTE_DEST(destid);
> > > +   return modify_irte(&data->irq_2_iommu, &data->irte_entry);
> >
> > This calls modify_irte() which does at the very beginning:
> >
> >    raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
> >
> > How is that supposed to work from NMI context? Not to talk about the
> > other spinlocks which are taken in the subsequent call chain.
> >
> > You cannot call in any of that code from NMI context.
> >
> > The only reason why this never deadlocked in your testing is that nothing
> > else touched that particular iommu where the HPET hangs off concurrently.
> >
> > But that's just pure luck and not design.
>
> And just for the record. I warned you about that problem during the review
> of an earlier version and told you to talk to IOMMU folks whether there is
> a way to update the entry w/o running into that lock problem.
>
> Can you tell my why am I actually reviewing patches and spending time on
> this when the result is ignored anyway?
>
> I also tried to figure out why you went away from the IPI broadcast
> design. The only information I found is:
>
> Changes vs. v1:
>
>  * Brought back the round-robin mechanism proposed in v1 (this time not
>    using the interrupt subsystem). This also requires to compute
>    expiration times as in v1 (Andi Kleen, Stephane Eranian).
>
> Great that there is no trace of any mail from Andi or Stephane about this
> on LKML. There is no problem with talking offlist about this stuff, but
> then you should at least provide a rationale for those who were not part of
> the private conversation.
>
Let me add some context to this whole patch series. The pressure on
the core PMU counters
is increasing as more people want to use them to measure always more
events. When the PMU
is overcommitted, i.e., more events than counters for them, there is
multiplexing. It comes
with an overhead that is too high for certain applications. One way to
avoid this is to lower the
multiplexing frequency, which is by default 1ms, but that comes with
loss of accuracy. Another approach is
to measure only a small number of events at a time and use multiple
runs, but then you lose consistent event
view. Another approach is to push for increasing the number of
counters. But getting new hardware
counters takes time. Short term, we can investigate what it would take
to free one cycle-capable
counter which is commandeered by the hard lockup detector on all X86
processors today. The functionality
of the watchdog, being able to get a crash dump on kernel deadlocks,
is important and we cannot simply
disable it. At scale, many bugs are exposed and thus machines
deadlock. Therefore, we want to investigate
what it would take to move the detector to another NMI-capable source,
such as the HPET because the
detector does not need high low granularity timer and interrupts only every 2s.

Furthermore, recent Intel erratum, e.g., the TSX issue forcing the TFA
code in perf_events, have increased the pressure
even more with only 3 generic counters left. Thus, it is time to look
at alternative ways of  getting a hard lockup detector
(NMI watchdog) from another NMI source than the PMU. To that extent, I
have been discussing about alternatives.
Intel suggested using the HPET and Ricardo has been working on
producing this patch series. It is clear from your review
that the patches have issues, but I am hoping that they can be
resolved with constructive feedback knowing what the end goal is.

As for the round-robin changes, yes, we discussed this as an
alternative to avoid overloading CPU0 with handling
all of the work to broadcasting IPI to 100+ other CPUs.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
