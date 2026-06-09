Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8573CEBA6
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001300; cv=none; b=idEkv7uGK/yx+PDc9D0xDnAxiCtZjAIZHutDwPllv5+xffTIfpbyQJ0hRDLyAP4vdCKRnJ5GtAWDLqlm72bq79BTeWdfGxW9FF0J+j5AdKpoSRBynzvhrF1EhYpKvuSUfUD/sta9NBZV9MN3ePT1RYY2JABZVpgL0zDofesln4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001300; c=relaxed/simple;
	bh=8Wk1fB5os/Kv1+D9oeE6QQDje2+IhFdcf5zZqMWo4Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0t+ExuSIrece0EJ34h3eSUU56fxlZgFmkXY2e9521feLVZPgR7dFd7YkbKGnYKyHtdHwoQermr5Pj3Q0piVLoKVB/ikrhaGr5tz75ttnDlwo3EEDzbwt4NhiD5tVw59z3Xb34t/6SdPMeFogrK55NfvqY7RyCYfm69rlc7uC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNDJV18x; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNDJV18x"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf2911f93cso417655ad.1
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 03:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781001298; x=1781606098; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+0aulJsKApTkmvzLBaKjR8wqqZe/Gm2cYIiLhYavTY=;
        b=YNDJV18xpBu6cSM5GUjv3RImpu3KpeSvwTPSGJUBXFwahsc7EGSqRYHTZKM7sQwf13
         v0/yWn5UbojxY1FwbLJnDip8m060zg8r2VRWoiLefIHCL6/C6BITp7uCUT24TdA7mgKh
         GPrZNC7h8aY5nf7THSOlVF2AxEijpY+v9rhKt6jI63vkyzWeYClDjzkWbCm1OmnEDh+d
         sIniWZ5VeUYyqzj9GOnDdNxbq7vZS4CjYwlnW4Rt4meOc3XBtmMKd34PXtQzb4eohgg0
         otbS0Xt7mOpdyxStMbd/TCoYLnGj+mmKhP3Ofy41s9U9qpgdD31blVOchAqZlU2feetn
         W9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781001298; x=1781606098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+0aulJsKApTkmvzLBaKjR8wqqZe/Gm2cYIiLhYavTY=;
        b=UW7KQln6KMSGkouJuJBe1vxsbI8ZmF5I+D9iC6x5iL2vyW4ppZzCrOF+uv2SnDL6w5
         rd9lI4rBTk0r9hTXt83+ctVD/WAFJbjLKL2/y7JiozbqmKFE+H1UxLn6fy9lIenxrf6B
         N8qQEIUjDttbC8fTcbtfAw1/TjGUrD0RU4EXfYSY7DDEj/6BPOXYycW6/OAltrzDf+RS
         kgbQ6KnnnQviotAU+PsBnxyupt8f/qo0TQFkbaYHDjLZOkqwY51sYSBcebIbmG1lsLI3
         F/jqqEEzLIUkbI4Mxa1jtYW8autoyvRbVicPHyUssngOBjlK136lalb2sO3eHy+tpQmt
         9RgQ==
X-Gm-Message-State: AOJu0Yz0gxBDczoz6bdeQsGi8zM5JCE+Fp3arDnJvte+wkquLe2sPYhR
	Kbk9JCFIejUjJ/paFk/+Bef05IPiBdpNCoQG/J6/btZ+xcW9bkNwidPwcdUdRV3GGw==
X-Gm-Gg: Acq92OE3gc+z6Sh+VcZUhpxSUBk9sjQ7+MzsjeXqQLPpgkkV1an+VKiEOM78R/vEq7E
	0fxoH15IgIMxXIfyaJhRQpvRlPy+riRj0FUxOBHRbEqFpKZGJy+FgsBaXQ1aYflMKMT52SFX3TU
	AAxXjLBRUDKWLU7unA0meHwywT0oH89o7HDO8BXvPPBQSk6xuRobT4MuhOXIkeVgWEuqXRVuj+u
	foypYdOzNHYCf3hm2nD3x6MU2VP/JG6TS8rm/dnZjUefn9JZUccIdeIrZZas6Dv7cQhs4LkzDYA
	2P+jZ4fKkNlEuTixnOnSl7gRmMEte4bxrBJDO9f0e0GFB2fQor4oUPwM1jYbcBJPHghqKoaIY+6
	Bs3MM1wO7MowwLknMrogeXSPG3KDpJhmiZqxqHiMU5v31iL6ZKD9RF719vJA6GzE7cbiKi/f+As
	JwZM/Q3WZJKlvTWN9P79cUWr+smH6Qfm4z55ouY6Ff2Y1lVx8vrN7IIVKmNPRC43MtniM4fxA=
X-Received: by 2002:a17:902:e5d0:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2c1eb6258c0mr8084515ad.17.1781001297678;
        Tue, 09 Jun 2026 03:34:57 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282220d1bsm22390753b3a.12.2026.06.09.03.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:34:57 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:34:51 +0000
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
Message-ID: <aifsSxEXX64J1Etq@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-12-praan@google.com>
 <CAE2F3rCPgnFU=d5At1zrOLhsuVEbsweogOHGz9gDddRx73zRtw@mail.gmail.com>
 <aiEawEFsnG-LIahW@google.com>
 <CAE2F3rAWZ4Ac23D8eyAHfmaVVkHv8pz45+_dpMO1M4D7+RVCoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rAWZ4Ac23D8eyAHfmaVVkHv8pz45+_dpMO1M4D7+RVCoA@mail.gmail.com>

On Sun, Jun 07, 2026 at 03:22:19PM -0700, Daniel Mentz wrote:
> On Wed, Jun 3, 2026 at 11:27 PM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Wed, Jun 03, 2026 at 01:28:19PM -0700, Daniel Mentz wrote:
> > > On Mon, Jun 1, 2026 at 2:59 PM Pranjal Shrivastava <praan@google.com> wrote:
> > > > @@ -2361,8 +2394,33 @@ static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
> > > >  static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
> > > >  {
> > > >         struct arm_smmu_device *smmu = dev;
> > > > +       irqreturn_t ret;
> > > > +
> > > > +       /*
> > > > +        * Global Errors are only processed if the SMMU is active.
> > > > +        *
> > > > +        * If the STOP_FLAG is set (can_elide == true), the hardware is
> > > > +        * either already disabled or in the process of being disabled.
> > > > +        * Any errors captured during the quiesce/drain phase will be
> > > > +        * handled by the explicit arm_smmu_handle_gerror() call at the
> > > > +        * end of arm_smmu_runtime_suspend() callback. On resume, the
> > > > +        * STOP_FLAG is cleared before interrupts are re-enabled, ensuring
> > > > +        * no valid errors are missed.
> > > > +        *
> > > > +        * A lockless check is favoured here over a dynamic PM core check
> > > > +        * since the runtime_pm_get_if_active would return false during
> > > > +        * transient states like RPM_RESUMING & ignore level-triggered
> > > > +        * interrupts.
> > > > +        */
> > > > +       if (arm_smmu_cmdq_can_elide(smmu)) {
> > > > +               dev_err(smmu->dev,
> > > > +                       "Ignoring gerror interrupt because the SMMU is suspended\n");
> > > > +               return IRQ_NONE;
> > > > +       }
> > >
> > > Have you considered using arm_smmu_rpm_get() here instead?
> > > I can see two issues with the currenlty proposal:
> > >  * Returning IRQ_NONE when an interrupt is indeed active and needs to
> > > be handled. This might be interpreted as a spurious interrupt
> > >  * Nothing is preventing the suspend handler from running while
> > > arm_smmu_gerror_handler is in the middle of handling an interrupt
> > >
> > > I understand that using arm_smmu_rpm_get() also has downsides,
> > > including an unnecessary resume operation when the SMMU is already in
> > > RPM_SUSPENDING state. However, using arm_smmu_rpm_get() would make it
> > > easier to ensure correctness.
> > >
> >
> > I don't think using arm_smmu_rpm_get() here is possible..
> >
> > GERROR is registered as a hard IRQ handler, so calling rpm_get (which
> > can sleep) would be wrong.
> 
> You're right. Sorry, I missed that arm_smmu_gerror_handler is
> registered as a hard irq handler.
> 
> > Regarding the race, the STOP_FLAG is set at the very beginning of the
> > suspend sequence. If an IRQ fires after that, we return IRQ_NONE and
> > let the explicit arm_smmu_handle_gerror() call at the end of
> > runtime_suspend catch and clear it. After CMDQEN, PRIQEN, EVTQEN &
> > SMMUEN are all cleared, getting a Gerror should be treated as spurious
> >
> > That said, I understand your concerns about a real IRQ being interpreted
> > as a spurious one, and creating an IRQ storm since the gerror register
> > isn't really written. I have 2 ideas here:
> >
> > 1. We could have a "suspended" flag and check it with can_elide here:
> > arm_smmu_cmdq_can_elide() && is_suspended() to correctly return IRQ_NONE
> >
> > 2. We could explicitly disable Gerror in IRQ_CTRL write after setting
> > the CMDQ_STOP_FLAG. Even if there are Gerrors during the CMDQ drain,
> > we'll catcup to those at the end of our suspend callback.
> >
> > I'm more inclined towards 2 as it prevents potential races (execution of
> > an IRQ handler with handle_gerror calls at the end of the suspend).
> >
> > WDYT?
> 
> I'm not sure if I have a good suggestion here. Have you considered the
> following: Do not call arm_smmu_handle_gerror() from
> arm_smmu_runtime_suspend(). Instead, call disable_irq() at the end of
> the suspend handler (and enable_irq() at the beginning of the resume
> handler)?

I thought about using disable_irq(), but I think doing it at the
hardware level (IRQ_CTRL) is better.

By disabling in IRQ_CTRL and keeping the manual arm_smmu_handle_gerror()
call at the end of suspend, we ensure that we don't lose any gerror info
We catch and handle any errors that occurred during the drain/quiesce 
phase right before the power-down.

Thanks,
Praan
