Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A7348C55
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111619; cv=pass; b=sfCNBetU9YBAvtQqToWeE4DC2KXQMNAAekfuFThcGnO9wir6UMBQfk7wJpzmzv0OgbQz6TltQBX4svosHctRBowrlt6yIdboBihdBNg4jo9nxLuaq9plRwByztVLGrL8H0zg1nobfpYf7egUuQLSlOYogpSVPTSei0cXTFL7mZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111619; c=relaxed/simple;
	bh=/3Dk4DGAHT5kVdHZq2KMBq8jvYUI1MA69Ze3j0Sxuwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/1BID0oaKD1xcmVmiF3ByT9NaYCk4tgklLBVPfBKUmrnhmvhuKJlYUtUhHudWY/plnCzJtBbU7Y4T/rUarVuCVd51K3zotCxZ0KOyXoWNvfrI/2rk26CXJSrOkM08QMfsAEoelpkzMG/AqrezmjMUIMLVHgSC3i/kNcaXaYb58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJLSwa7B; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJLSwa7B"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51765331535so25031cf.1
        for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 10:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781111617; cv=none;
        d=google.com; s=arc-20240605;
        b=jZ3wajc70xygJLcihe2YTfhcmCFYuUAjMk++s/vfjSw2mzTD3xb7TN2sfUlAXW9Rv5
         CdygPcE7+FrQFW+Ri2vbPBsShTPW3j2hAdIK14DTvodhZowi0chQwgTt7t2y7Nx+oIpJ
         8nI2tG1IZmbELvKO3JdI+NvOfO8RdNQpZNB66G5du6WMTanDLo9myx0/hhuZ2b6Kcuar
         kmlV4BZW5zCFMsw5qJlFVQ/lpZiPma5owgaN6UEqRxmn0NMFezYNctVWnfpq5oZ86FAL
         VmdbLoNouMg3RGATMpn2s5CrNq5kuLW81xuf0vggb9GPsN1qKjwIefaA0uk7BVJvd8Gu
         98MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/3Dk4DGAHT5kVdHZq2KMBq8jvYUI1MA69Ze3j0Sxuwo=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=PAr2TWk7EnKxvQ7/jyQWzzE7aXL2eIPboU72f3y+ddqyod3I6Vc9Z2jqcN0P29oykm
         Ovb/M255aiDg2vP33NQPcu0dX5ku/27lIwcF6lc7YbY4poXKG1XMBuqJH+ybaEZKlgmx
         RybMiYnUmIpozG0bMT7r1KtOAnrqgm25Bf1s4+kBSWDjQtpMt5M1RKYvTKLVKh7w9PLA
         3rUbzActxniX0ekeujNvkGTU1hG0yO1vw7pLxLf5cv+U6z8pDvK85jfkggkBXZ4KGAtI
         VjINdgmsueQriZQfYvKlLQUKzDX0T9wvVmy53ES0OflObMrkSwJLULBsiTDB+iJtytBu
         jv8w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781111617; x=1781716417; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3Dk4DGAHT5kVdHZq2KMBq8jvYUI1MA69Ze3j0Sxuwo=;
        b=IJLSwa7BQtBbOuFamirqv+10vlruHeSNSX8w0IElOC2eWQlFa4E3SKwnEHmyvwV/0i
         E0q68iAFQ2hPAi0sOiy3GVpiGJcptQE7b2q6uDVxfpiNZZfc8TN6guHS++a1JdrfKn6C
         kFVSbad0lu+UfqV47upfRLaTHq7Vkq71d2HVdZn0/9PuN/IQcwgaeDR003oJJjBIWDZr
         yt0UgqQe0DtYhpk/S8A+4nMiK0/uiW9KwVJPE3L8Tj5XlAerzEhsyViZdPJLPRQ0VtO5
         6cHfTBDD/JzEg1iDkAM8lxzJFQ5LGEjznO+z46qb8Cfhmyp2vOIcPoGIzunNTQKw4+Bm
         4EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111617; x=1781716417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/3Dk4DGAHT5kVdHZq2KMBq8jvYUI1MA69Ze3j0Sxuwo=;
        b=nkuYhBtsRHafgMcglV8yE3c3umqrhpC0kNIfGjDmdvqDvVh1GHbUwHEXSopLWgSeBW
         tvo2H0O6czEjdLANKBuidlnC+9u8JwXMyk80AYMBBZr2UfAQZysZzg2IhXazAk87niYN
         HSPk4Y/oIWnWnI117TvMyUBr9S5DWVy1MmiHMlPvlc+eciBaHiZQZYAOLq22NoIEMd6+
         Vmjty4JLuhZj7+IVoNyAiOBwpvod8wybyy87egKfIqeZstxdRsHdCxDUyhVNbi2tdFfg
         hjUzYbGym/73Ux9whR5lfYIK7InwnHrqtxOPhs1pG4BfPi92BamgoMEBnG4Z7mt3oKCt
         GQ4A==
X-Gm-Message-State: AOJu0YzSBxs14h/vtbwJ6OizVcsfFw/7g+9rDYejj0R/YJ8QFlAzKxiv
	dtQj+PkB1LquHcfFupX58D9SF0mXGciA4VXUvmqArljLfLnbzTDVUF6iOJU2qm/ZPj+j0Tyh1WX
	DI+x5WAZYHti5ObuEMC6VxtdNfTgFITfqIYMBAKnA
X-Gm-Gg: Acq92OEVSFPL0OgRdDCShTk6DDxibZSqzEsd/bIA7teTaJ/iuN72RksWlxC7ZI+iuYk
	bEWteG9oXJL5hnrl3NRIXxhQoZNSGNS9LuXyaPeEBMOBozcXW2kp87wZrtRSieUFAfs3XxQyxR5
	FLPuyH/WMhav/R9OdWz/6zDKUCheaNxDVcuhV1ugu4XSvdgEQnKv6VUwpBtQC5dMFtGBoJN4BkH
	Kk794ScU7XqFzUdzSyEO76NU/zW04BiQGLsWovZkzeQ1Rw5gpO2zLBD0rP4sGnmiwaRK8DpvFTC
	o179aMSZdlEVZbw=
X-Received: by 2002:a05:622a:5089:b0:510:fa1:73c5 with SMTP id
 d75a77b69052e-517e9657a18mr1278231cf.16.1781111616126; Wed, 10 Jun 2026
 10:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-12-praan@google.com>
 <CAE2F3rCPgnFU=d5At1zrOLhsuVEbsweogOHGz9gDddRx73zRtw@mail.gmail.com>
 <aiEawEFsnG-LIahW@google.com> <CAE2F3rAWZ4Ac23D8eyAHfmaVVkHv8pz45+_dpMO1M4D7+RVCoA@mail.gmail.com>
 <aifsSxEXX64J1Etq@google.com> <CAE2F3rAGLH7si2S4aYhSUWyL-zZL7B_uo+WLE4zKY9SqKVi8zQ@mail.gmail.com>
 <aihzgtczL99fM-1c@google.com>
In-Reply-To: <aihzgtczL99fM-1c@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Wed, 10 Jun 2026 10:13:25 -0700
X-Gm-Features: AVVi8CewAZMr6roH_IQPlZnUww9uTnzxF93M2QjoTnsJlUETs84PkeRXRhhkFzU
Message-ID: <CAE2F3rC1PkiwgJB4M-9qpRx2Tpu9d_5YZ_De_=Sv-aby=X3RRA@mail.gmail.com>
Subject: Re: [PATCH v8 11/12] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 1:11=E2=80=AFPM Pranjal Shrivastava <praan@google.co=
m> wrote:
>
> On Tue, Jun 09, 2026 at 11:34:42AM -0700, Daniel Mentz wrote:
> > On Tue, Jun 9, 2026 at 3:34=E2=80=AFAM Pranjal Shrivastava <praan@googl=
e.com> wrote:
> > > > I'm not sure if I have a good suggestion here. Have you considered =
the
> > > > following: Do not call arm_smmu_handle_gerror() from
> > > > arm_smmu_runtime_suspend(). Instead, call disable_irq() at the end =
of
> > > > the suspend handler (and enable_irq() at the beginning of the resum=
e
> > > > handler)?
> > >
> > > I thought about using disable_irq(), but I think doing it at the
> > > hardware level (IRQ_CTRL) is better.
> > >
> > > By disabling in IRQ_CTRL and keeping the manual arm_smmu_handle_gerro=
r()
> > > call at the end of suspend, we ensure that we don't lose any gerror i=
nfo
> > > We catch and handle any errors that occurred during the drain/quiesce
> > > phase right before the power-down.
> >
> > I think the beauty of disable_irq() is that it synchronizes any
> > potentially running hard IRQ handler, which helps avoid races.
>
> Alright, I guess we could:
>
> 1. SMMUEN=3D0
> 2. IRQ_CTRL.gerror=3D0

Should we call arm_smmu_disable_irqs() here?

> 3. disable_irq();
> 4. handle_gerror(); at the end of suspend
