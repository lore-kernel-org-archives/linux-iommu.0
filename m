Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB44126C10
	for <iommu@lists.linux.dev>; Wed,  4 Dec 2024 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283819; cv=none; b=UvUOCCGY066rH4vaC0+WYZY8z1Ymx3qQq96Pg68dtjULgh4OU6E82xV2aD+4zzKBfzhUL1V+Fc3d6qX0kFT3CD7JD10vhjW1dpgZjHRjGHAe3PI/UY+WnupLA1LzY7APmaO0BOp//HhW1s4YDbzKV6Vh6Gf1063m12GvPtwA8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283819; c=relaxed/simple;
	bh=+kQgx+gnUJbkShBpT4dRk72hfPx4Z/Q1SR5sEmPhons=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7XWsid5ZS1JBWEjyaOZOiPAlTVLOaK3kmJe4W6nIg+GyScXiW5Y80v8tZpBxu+e2VQnp9mVmeQ8bPBleeycBvOH6ac7uZJTCYRoBndnmdFpp4iutptv4Mnc8Sv58u4FQNfmbXm+3UBP0ETxOf8vl93z5z6Y7MJ/jzb9P0t5lq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=E2bOX5ma; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="E2bOX5ma"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-843e3b49501so203052539f.0
        for <iommu@lists.linux.dev>; Tue, 03 Dec 2024 19:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1733283817; x=1733888617; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGkT/pl1gB1Evs4ReRwjiJx5mPh/IBj5HFwD48IlujU=;
        b=E2bOX5maw2xIaiCxGlFU2660hkgAbEm9ogDLxok/pX4vKVOyDFlg2cA5NJxWDUIHiy
         NhnEoUSeaqjmuKR7HCD+SxQgx32YYgU+XMJZencqoY6Oz8XdS/zrJtyGbKz6YWCDPAyp
         +/xhpctMrJTHs+9wnUhqlHrr98dnsGwyy325ycFW6pZqHKu+vph3wB/VrLc7iIHLPJRj
         YixgbxZkwHf2bH4dOdKxG6mOGsNrn/4fNqdkSlrAkHYJBdK4x/vbGYjQ4HM7ZueAHu4n
         w3CCDqJZgimOwLI4ZxvGICfUQFG3BIni4/cPSVubZLhHYMCHpKx5BExg6qohqWRIfDO7
         p7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733283817; x=1733888617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGkT/pl1gB1Evs4ReRwjiJx5mPh/IBj5HFwD48IlujU=;
        b=HCCsBX1Bon1jdQ1igo8JxLlL/CtklSyOfFZRBDkegt7UTd1DbhBvUhspJZ2Y2EyQuV
         Xq8ouBaL0iLjiBxBtrgJ+ADEK9TT0bPCTr79fZ8A0B5lXY82jEcDahZdAUqB4lLV3YGR
         Id8AKlBx7Ykanc1enkzDfxsBmM//bU3+jI8XZVQ6XMqE5ZHc3MDkZhbM/fYtKUlG5eep
         4n3cssys1EzkK0Vomy8d5dh09txr63Nc9r6fbgcvaj16hxx2fdCL5NwCbDDxFy+BHrFU
         edFFkxxWYS7KQEOAqHs/8qEmk0sGPbLS4cmejNQnGqYyaQXWGh+LFq4InAc1E/Nxu9y8
         yUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDqhaAZuA7IjxMrLSy41HvPpOa+YbW2EWoTYPYVuTlK4u6+fUmExZuJ8ugeBWa+FjT0w6gTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMjpV+JqROqttEPjPD81hsjWC+JMx0LDq6+aL/oZUn7EdXhXc5
	QPLAa6/98Ucx0tGPhJ1CHFXP76Bc0vO63HrweUUCTVIO+Gk9N6Q+BGGKRV2LQPLBugi6Uk/ShcU
	qQLeQVfiuNX1eQakdtkNeTICMeiviqj6Rg7GE8Q==
X-Gm-Gg: ASbGncte+gwxUx8nPf3aulTVLfX7tLJBF2scRhkS7UTqAoUN4jKPEOx1kkwAm5XxYlA
	7TlTXuign+ZiXEAAsyZhA8wVoRjcj3t2lrw==
X-Google-Smtp-Source: AGHT+IGWdFp8FF+1NtOQA0riwNaVCNa+lNq7c5BS40O1U8dW0QvsTp35bk3sIYPxMlaLCPGVX4HHb6tLAmO9iVR0CsU=
X-Received: by 2002:a05:6602:29c8:b0:807:f0fb:1192 with SMTP id
 ca18e2360f4ac-8445b5477f8mr665966539f.1.1733283817005; Tue, 03 Dec 2024
 19:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-18-ajones@ventanamicro.com> <87mshcub2u.ffs@tglx>
 <CAAhSdy08gi998HsTkGpaV+bTWczVSL6D8c7EmuTQqovo63oXDw@mail.gmail.com>
 <874j3ktrjv.ffs@tglx> <87ser4s796.ffs@tglx>
In-Reply-To: <87ser4s796.ffs@tglx>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 4 Dec 2024 09:13:24 +0530
Message-ID: <CAAhSdy27gaVJaXBrx8GB+Xr4ZTvp8hd0Jg8JokzehgC-=5pOmA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/15] irqchip/riscv-imsic: Use hierarchy to reach irq_set_affinity
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Jones <ajones@ventanamicro.com>, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tjeznach@rivosinc.com, zong.li@sifive.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, atishp@atishpatra.org, alex.williamson@redhat.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 4:29=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Tue, Dec 03 2024 at 21:55, Thomas Gleixner wrote:
> > On Tue, Dec 03 2024 at 22:07, Anup Patel wrote:
> >> On Tue, Dec 3, 2024 at 7:23=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >>> Sorry, I missed that when reviewing the original IMSIC MSI support.
> >>>
> >>> The whole IMSIC MSI support can be moved over to MSI LIB which makes =
all
> >>> of this indirection go away and your intermediate domain will just fi=
t
> >>> in.
> >>>
> >>> Uncompiled patch below. If that works, it needs to be split up proper=
ly.
> >>>
> >>> Note, this removes the setup of the irq_retrigger callback, but that'=
s
> >>> fine because on hierarchical domains irq_chip_retrigger_hierarchy() i=
s
> >>> invoked anyway. See try_retrigger().
> >>
> >> The IMSIC driver was merged one kernel release before common
> >> MSI LIB was merged.
> >
> > Ah indeed.
> >
> >> We should definitely update the IMSIC driver to use MSI LIB, I will
> >> try your suggested changes (below) and post a separate series.
> >
> > Pick up the delta patch I gave Andrew...
>
> As I was looking at something else MSI related I had a look at
> imsic_irq_set_affinity() again.
>
> It's actually required to have the message write in that function and
> not afterwards as you invoke imsic_vector_move() from that function.
>
> That's obviously not true for the remap case as that will not change the
> message address/data pair because the remap table entry is immutable -
> at least I assume so for my mental sanity sake :)
>
> But that brings me to a related question. How is this supposed to work
> with non-atomic message updates? PCI/MSI does not necessarily provide
> masking, and the write of the address/data pair is done in bits and
> pieces. So you can end up with an intermediate state seen by the device
> which ends up somewhere in interrupt nirvana space.
>
> See the dance in msi_set_affinity() and commit 6f1a4891a592
> ("x86/apic/msi: Plug non-maskable MSI affinity race") for further
> explanation.
>
> The way how the IMSIC driver works seems to be pretty much the same as
> the x86 APIC mess:
>
>         @address is the physical address of the per CPU MSI target
>         address and @data is the vector ID on that CPU.
>
> So the non-atomic update in case of non-maskable MSI suffers from the
> same problem. It works most of the time, but if it doesn't you might
> stare at the occasionally lost interrupt and the stale device in
> disbelief for quite a while :)

Yes, we have the same challenges as x86 APIC when changing
MSI affinity.

>
> I might be missing something which magically prevent that though :)
>

Your understanding is correct. In fact, the IMSIC msi_set_affinity()
handling is inspired from x86 APIC approach due to similarity in
the overall MSI controller.

The high-level idea of imsic_irq_set_affinity() is as follows:

1) Allocate new_vector (new CPU IMSIC address + new ID on that CPU)

2) Update the MSI address and data programmed in the device
based on new_vector (see imsic_msi_update_msg())

3) At this point the device points to the new_vector but old_vector
(old CPU IMSIC address + old ID on that CPU) is still enabled and
we might have received MSI on old_vector while we were busy
setting up a new_vector for the device. To address this, we call
imsic_vector_move().

4) The imsic_vector_move() marks the old_vector as being
moved and schedules a lazy timer on the old CPU.

5) The lazy timer expires on the old CPU and results in
__imsic_local_sync() being called on the old CPU.

6) If there was a pending MSI on the old vector then the
__imsic_local_sync() function injects an MSI to the
new_vector using an MMIO write.

It is very unlikely that an MSI from device will be dropped
(unless I am missing something) but the unsolved issue
is that handling of in-flight MSI received on the old_vector
during the MSI re-programming is delayed which may have
side effects on the device driver side.

I believe in the future RISC-V AIA v2.0 (whenever that
happens) will address the gaps in AIA v1.0 (like this one).

Regards,
Anup
