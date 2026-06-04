Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA92636F91F
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554443; cv=none; b=V1G1LA3WRye0ecdqAFHCqiS6sTpYkkfZMqY52/5WKuYQJA9ynGIZC9/GUPyByompWn831Ysaq/9hO8mN6j7ibVb1lwEeDVbHX7ItUo1AXWbLYuPcSpSwjH2uSRKF8LkdUlbMh4Qpsl7mWO/Q9UVu8V/p3qOBpuZ7cCSVz4wiqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554443; c=relaxed/simple;
	bh=NZERs8wx80yARkytyQpZqVQr77EzJSMIZuUlqv9WUlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKJo9w9S1rRNlMH4pqee7PPVFrnpNH+RJvDNEk/5kZyEWXw2JTVIjTRbFzvlaxIzF+e8mutz7SBbX6lS/JGjq2V+5Oo4trUtVESb6wRMwSxUfomNHFjtOZ/WUnkaD1vExc6WakNb5UbWjxxD+fz2h9o2X2Pyv3xCwYHECW+tF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XqvpaIUB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqvpaIUB"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf2d865383so54275ad.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 23:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780554441; x=1781159241; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TUX4p+/g3In60o10PoOm58/dfPztgEd/GT0xX0N5jBE=;
        b=XqvpaIUBXQpcRYOdC2tl/cpMZuXMmyCQNfmY9RbNcWAaIkMBm1/2QpH41kdS948Q71
         2Lqt1yFYsRp8Akbj0gftYICw0DF/YKpiNKmzLSdr36EipHlIwQJxtLSIX5cD8wUBi8UK
         CunavwnKGzjd8dvMEvZlmPo8Grgfxu2p/166AAh0sl9y4prl5oOfqmUlYxOudLB1EXlN
         5wkJL13KiSBAP4Y+d+ZHOb9LXLr3bUj+mkq2X0CQksOuOjc2GcPVP0p4U+Y6wl9aEy5A
         HlzjQ2x31pJVLJcqmbwXho95xw5UH0h5xEb9e2p6UlajG5eqKvh3euEzNCKqLUnZ1MNg
         HZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780554441; x=1781159241;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUX4p+/g3In60o10PoOm58/dfPztgEd/GT0xX0N5jBE=;
        b=fx9USD6Tfl061CpAqqKzVqq9DDI5ibARQIi64jT61NO+iaGQixMirARqi+C8f1XQkT
         0lNJix19WF8Bk1jwzYFH9aE3qqz35tS7ymeQebbPzUuYwIRR7eUm579QIBNc7+t0JXGC
         ldCAbmFe4f5Px27aOH+ztX85o4DCr8CrKcKZHeIaIM5Orxt7GqkeaZ0oxq2HliCakWTo
         tCYXpdbwheWRuPSqE56VR4Kc5VDAld00NdlIXoxLdcxj+jbWr/P+554dcq0eRmo7o8fp
         Swk+ktAgO0Iw4J2RrMByIarwHRsAEFJyfxIQSzUfK/ndRZppPNP4xSPIxe++5iIB2DUS
         gjuA==
X-Gm-Message-State: AOJu0Yy1UYv5lhDukr2ioX06GKkiQixmuFIssaNFoMk7fErUMiPBKB5Y
	qO8gjj/FX13olfhbfKxbEd2JoPpySFNmxeTUdARaTlUOfj2nA8Q6eir78V/2nSsC3A==
X-Gm-Gg: Acq92OHW0NpMT3iVL3Q7bw6GInRaVBqlgjZyh81wLrGVl3D71yYI3rgv8EsUicVPMJj
	xAF7OaesYw5PIJiKSqmBDvQD8qI+tkEyaUExtiLrUwz2fkV9KtRAiq8nPv3KqHpWwyd+Xz/AuM1
	c2SdeRMeox8kNsSqjlwzg881Q53i4OZcWFZWQzo6xDBrAaO9VYrGtBzUNn8DwVbRWj8S4dqhChe
	7R2l3lV8jhAE0A5ztQkM4XYnYUviHUtj6rMFibL1myRkNbhTZfe7XueEjWsDQBy52gQyLYwjQ9b
	zoUJaJwtl+BDc2NrEAjSMGJFnINSh58jT1l4amA77pukNEXuX6mT1eAWAHyWdCvax1JE6EW3g8y
	Da2PFQ1QrHa4XsvLVRsAp71TuJTbjgIV9vXNXdJoUQRUE6Os5MuFYPOKqUPbi8sbPVIrc44wQF7
	BA7S1vCrIuuD40lz7YFMRh79OFB4gk1han+EnCbNOa9QXDul2ii2zH8n/epAdDFWlB9dCsq9XMM
	TEA/X745w==
X-Received: by 2002:a17:902:f745:b0:2bd:3c1b:3073 with SMTP id d9443c01a7336-2c198b2b92fmr2310625ad.16.1780554440352;
        Wed, 03 Jun 2026 23:27:20 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649293esm47008075ad.68.2026.06.03.23.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 23:27:19 -0700 (PDT)
Date: Thu, 4 Jun 2026 06:27:12 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 11/12] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <aiEawEFsnG-LIahW@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-12-praan@google.com>
 <CAE2F3rCPgnFU=d5At1zrOLhsuVEbsweogOHGz9gDddRx73zRtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rCPgnFU=d5At1zrOLhsuVEbsweogOHGz9gDddRx73zRtw@mail.gmail.com>

On Wed, Jun 03, 2026 at 01:28:19PM -0700, Daniel Mentz wrote:
> On Mon, Jun 1, 2026 at 2:59 PM Pranjal Shrivastava <praan@google.com> wrote:
> > @@ -2361,8 +2394,33 @@ static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
> >  static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
> >  {
> >         struct arm_smmu_device *smmu = dev;
> > +       irqreturn_t ret;
> > +
> > +       /*
> > +        * Global Errors are only processed if the SMMU is active.
> > +        *
> > +        * If the STOP_FLAG is set (can_elide == true), the hardware is
> > +        * either already disabled or in the process of being disabled.
> > +        * Any errors captured during the quiesce/drain phase will be
> > +        * handled by the explicit arm_smmu_handle_gerror() call at the
> > +        * end of arm_smmu_runtime_suspend() callback. On resume, the
> > +        * STOP_FLAG is cleared before interrupts are re-enabled, ensuring
> > +        * no valid errors are missed.
> > +        *
> > +        * A lockless check is favoured here over a dynamic PM core check
> > +        * since the runtime_pm_get_if_active would return false during
> > +        * transient states like RPM_RESUMING & ignore level-triggered
> > +        * interrupts.
> > +        */
> > +       if (arm_smmu_cmdq_can_elide(smmu)) {
> > +               dev_err(smmu->dev,
> > +                       "Ignoring gerror interrupt because the SMMU is suspended\n");
> > +               return IRQ_NONE;
> > +       }
> 
> Have you considered using arm_smmu_rpm_get() here instead?
> I can see two issues with the currenlty proposal:
>  * Returning IRQ_NONE when an interrupt is indeed active and needs to
> be handled. This might be interpreted as a spurious interrupt
>  * Nothing is preventing the suspend handler from running while
> arm_smmu_gerror_handler is in the middle of handling an interrupt
> 
> I understand that using arm_smmu_rpm_get() also has downsides,
> including an unnecessary resume operation when the SMMU is already in
> RPM_SUSPENDING state. However, using arm_smmu_rpm_get() would make it
> easier to ensure correctness.
> 

I don't think using arm_smmu_rpm_get() here is possible..

GERROR is registered as a hard IRQ handler, so calling rpm_get (which
can sleep) would be wrong.

Regarding the race, the STOP_FLAG is set at the very beginning of the
suspend sequence. If an IRQ fires after that, we return IRQ_NONE and
let the explicit arm_smmu_handle_gerror() call at the end of
runtime_suspend catch and clear it. After CMDQEN, PRIQEN, EVTQEN &
SMMUEN are all cleared, getting a Gerror should be treated as spurious

That said, I understand your concerns about a real IRQ being interpreted
as a spurious one, and creating an IRQ storm since the gerror register
isn't really written. I have 2 ideas here:

1. We could have a "suspended" flag and check it with can_elide here:
arm_smmu_cmdq_can_elide() && is_suspended() to correctly return IRQ_NONE

2. We could explicitly disable Gerror in IRQ_CTRL write after setting
the CMDQ_STOP_FLAG. Even if there are Gerrors during the CMDQ drain,
we'll catcup to those at the end of our suspend callback.

I'm more inclined towards 2 as it prevents potential races (execution of
an IRQ handler with handle_gerror calls at the end of the suspend).

WDYT?

Thanks.
Praan
