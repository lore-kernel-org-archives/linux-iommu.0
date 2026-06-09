Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA536EAAE
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030098; cv=pass; b=QS3C2bE3drA2xnJyfTJ2oolMddJ7rySK8+4Ch3ZbOViJ8UuIuAvRKpS5HxyXwaasuo/zJyUCHbfb4RlpNbAd730aEdwgs2ZEY0J03WBF3M2win97Wp+9RA91CtkPHMLFw7XCwKtZmhrkGfARjrfYo9B0r9+A4yVbP/DDospuuXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030098; c=relaxed/simple;
	bh=QAVeQUNR8QlKT88CvPGnIFfod1jue+dHBAvLJtDcBos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fE9gXM7fvETEghi5MBNE3oOPCn2VkGGi8WupJlKG6bLz/NKrVRkzf1cNDwehO4DVQFbRHj37rUwu8Ho7fUkIWrwg96pWYl2kG+wiXnHbywWE6wLvvYl49SSOiUtCleYgh53jPMGVy+XiAC+n+5K/KjFcRlJU7OFe5sMWf8KLBEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqxPdu40; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqxPdu40"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so47875a12.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 11:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781030095; cv=none;
        d=google.com; s=arc-20240605;
        b=XylvHKcmxf1cfNEw+1R36RnTalsHJbmzzxXYEwiIRk2ln3QkBcwuDng6U06hW/x6tH
         XhcFU93+GvNE0CpsauFjuclHa8jlrsFg0zBQOYqouIRmwLUtIY2cs17d8xAKFrd5YpzA
         C3WGTxAWmmtfkZGGxt/wUcfaX4NpciAhQjhRf2TqUdFtyAANPxqpEFt1uBlsBGa4yepG
         jt21T6Qw5cd5tVjadZ3TkNYx9thEzsGQbfpj6iEmAr4wmzvHEaEVpoJj9Z2WeHyPzn17
         6bLb9vy1SxKpmz3ew+YRlMfTwH1nt2MO8x4usnwIeJhFaNaHZOschpCfbe7zQEg6JhT7
         6gXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QAVeQUNR8QlKT88CvPGnIFfod1jue+dHBAvLJtDcBos=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=hcAZyVSXQA9hVFDO7oQXz7FS+xaxEyUTKEMStkyRKptwXBy794V3lLBlcQF/sfrhKE
         hAQkRSqkOKQOfpp1IEsbBGddPkI6/W4qVCXpFNuQmWqw5pIsJB1nbVkQ/zxnzJMuhyAC
         iirgcMXYAkZos2oACDHT6ZOYszP7bCyNOI3HFSMI6wS4CuV2Ed9yV9jljzL287RiBc1m
         /QbLvPAZMCjgsNgrP2ZIrQN84hOYsr7nXBY2mOUp9/WIp6qTkiMnfplqkljvf/IwPAbf
         u0uZsxQ49+WiKj/gJ9G6Qw6y+fkC1hxMe39Ug0FkDdknDJCZApFVt4pizZDzXjP439nO
         2gfA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781030095; x=1781634895; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAVeQUNR8QlKT88CvPGnIFfod1jue+dHBAvLJtDcBos=;
        b=NqxPdu40GDo+HBY9sHMb56uig79ETvnvpJ9IGckbCn46EuQBlFtNBIwqVu18mokC7N
         VEp5lCejJhAl7QGzLBgoluG4xIEjPm8QcORifYMN6TdrZfVvjIdLb/+2H6b0zVHG1Yom
         v9wljjhGnsVQZ3SnJh+BJhPXRXOgLmBAUmbA+V4sN9sjeWiIJlq+mwRQPLwqKQtROU/t
         RVZ3t/i4wlP5fBe7s7G7Lb5iFwD19d40y8/a8gzdTRn8/cjTj0+a2ZYpBWUpv4sgzH88
         RgjQDcfhDqwXKmnLo7p4H7wttVALp5HVC5PfUlSZyGW2Kc6znZpoxFakWuc2rETwDbXF
         UDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781030095; x=1781634895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QAVeQUNR8QlKT88CvPGnIFfod1jue+dHBAvLJtDcBos=;
        b=FLirXPU3EnlwiAnXfWRCmnnltvg9fVOT5kpFWIO2bK5t9S5y9/lGVBnLgRBvSyywIh
         X4z0fSbeAt7Tg91Dx4Mpf0eLyoeOwoFMwS+zOXqhl0om0FT6Muk2bb97Q7kKDYWwbFvj
         FKEPPLErZwQHhE87OJvl3TY1sXg4aIqZRgVoJfqKqk8xFLJLxmn9yfx0sPEsSP/ghcQd
         EXxXUObCRs27THRh4djUNzXhucHwzxZtUGjf8tU9ZG3db586cMcMu/UZXvA3VFV4WSAW
         bLHkCdTGqk4h9S6wZ0dhh+ZKvcnMqvJLY83CudNwtbSFLBXO37DRfLtAkm+hiOiQIP0L
         WOVQ==
X-Gm-Message-State: AOJu0Yytxm7E0G+wTuzlKlfGzfDHXDJx9gtdO1H0fSD7uB+CEU24XkcA
	UAyWJ59MSZ8A1goHkK/CizR1Cv9Jqu3pYjsvm9UGeCJQqGXN9Vt8FSwGMKk0aNgUjB5GZXpgrfr
	8zblqOmxE+P9TXoLM6IdiD4yzaroBywEssrSUdrCC
X-Gm-Gg: Acq92OEnXMrTVBd9uqbRnUjQQrmFVGAFktOWGY4qyhT4C6S2JD4VHgm1p+tlUkU0OSn
	oEmnFaYgLFUx1SrKHJ7DRTct0miuwyX/xfrAVAV0jfqNY/VIWTHxotbvHqK2SVe9p0bEbfC0lh4
	6wFaNe/hJxsiPAkCdBddftgPsHK2sU8bYrPQblYKVP1lu6C0Z1UG/4GWXbgRBKhVZ85+RiHMO4b
	44TqSRJxCK/6U3csvJ9Nlb7Q6rSgKD1/49gfCmF4SBAUhIDjyghfd8GZmgR9RnWT2yDBgTueers
	rKfDoGsm2m2He7rbx6/A7P7yFg57c68KDo0fHlh68/qqgboT
X-Received: by 2002:aa7:d848:0:b0:68f:d41d:ca5d with SMTP id
 4fb4d7f45d1cf-68fe907ab8amr241229a12.11.1781030094610; Tue, 09 Jun 2026
 11:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-12-praan@google.com>
 <CAE2F3rCPgnFU=d5At1zrOLhsuVEbsweogOHGz9gDddRx73zRtw@mail.gmail.com>
 <aiEawEFsnG-LIahW@google.com> <CAE2F3rAWZ4Ac23D8eyAHfmaVVkHv8pz45+_dpMO1M4D7+RVCoA@mail.gmail.com>
 <aifsSxEXX64J1Etq@google.com>
In-Reply-To: <aifsSxEXX64J1Etq@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 9 Jun 2026 11:34:42 -0700
X-Gm-Features: AVVi8CeNBnG-Q0YRCS6Oc41AOhRgRaeDmNuOgUCDOQbTwPVqXo8DCJDnwgsr21s
Message-ID: <CAE2F3rAGLH7si2S4aYhSUWyL-zZL7B_uo+WLE4zKY9SqKVi8zQ@mail.gmail.com>
Subject: Re: [PATCH v8 11/12] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 3:34=E2=80=AFAM Pranjal Shrivastava <praan@google.co=
m> wrote:
> > I'm not sure if I have a good suggestion here. Have you considered the
> > following: Do not call arm_smmu_handle_gerror() from
> > arm_smmu_runtime_suspend(). Instead, call disable_irq() at the end of
> > the suspend handler (and enable_irq() at the beginning of the resume
> > handler)?
>
> I thought about using disable_irq(), but I think doing it at the
> hardware level (IRQ_CTRL) is better.
>
> By disabling in IRQ_CTRL and keeping the manual arm_smmu_handle_gerror()
> call at the end of suspend, we ensure that we don't lose any gerror info
> We catch and handle any errors that occurred during the drain/quiesce
> phase right before the power-down.

I think the beauty of disable_irq() is that it synchronizes any
potentially running hard IRQ handler, which helps avoid races.
