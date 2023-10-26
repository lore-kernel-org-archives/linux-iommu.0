Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2214AAA
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y5EXT1fI"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-41cb7720579so162881cf.1
        for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 00:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698305537; x=1698910337; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+Cj2L0L79qBDi6aiFFwtb+ZsMKlCgLY5wUUL5erbLY=;
        b=y5EXT1fIxMDLkp7Ab6gNEa76FkNlttCmIpJoigOo6sAg6xQ5TyOm8fYXntp35nyqFJ
         0mn4otf8e4hGttAcX5Ub1GScW3R1tk/G5be5PbVQDR5wJKm+h1xQo3qxHYSzZFESjrhn
         4aWvM58L7pnuGtFG0YM7ATg0SA9MxggnOS19KQy2kZM1rHq/GoM0asZ5eFPYuN+5CGI9
         gG2hZNjT/ReE2X3ZnDBIxxD+ewC24b1DKdNACykh7iL2k/UK0eWrxpE3LQrorneI9UtO
         JS7FQNEgR9u+wW40ZWcTM7FmyhsRAFPwuOWWJ3Uic17PUdIupd+x+QVCTiXD9MRiG8uc
         iWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698305537; x=1698910337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+Cj2L0L79qBDi6aiFFwtb+ZsMKlCgLY5wUUL5erbLY=;
        b=dxdzwJ2HI5I440VjddcH0bLDAKgFmbhW7HNMnxN1pm4rYExGQwjGTtHMzsWTV0YnC+
         +IAYEOpzznIgp8v6W5QQWf0zZO58Ovz1TNP7rNC9+m19RB5/SZKy6feVpxDH8SqvZrIx
         6DrBiobwTMVuRmn6Rc2vKJrbqUuSVv5knj8Ji79V3YNviJS8m7+AACFC9IkTld/VMzNj
         56ndmX0wna+SrLqiM3ZrtnTYuSDdXy4sMTwx5rogkrhDDssIH7sV8993fhL4alyqhaGA
         8A/mVsX6l6VnSapQfl3yUhHGJej0Wp0zuRTlGSXOKMq88Jh3iU26/jbeJK/s8RfdnjNW
         KQAg==
X-Gm-Message-State: AOJu0YwsfeyBdLo60aXUe9EaVfl0j1tBqIoQTqCjleuuRpvtA7179arj
	89xCzlzjBtig3LddTaKk6WG7IbK17AktQeoqT1tncg==
X-Google-Smtp-Source: AGHT+IHd8Sj0jOc+nVqHd4c+0Qc2nd15D+L11bpcFEKr9MuHmZ07NKFSWPuJpFKUOoHcKkH2HtbsXORm9oxKWJcpV94=
X-Received: by 2002:a05:622a:770e:b0:41c:bd1e:5a4b with SMTP id
 ki14-20020a05622a770e00b0041cbd1e5a4bmr448956qtb.5.1698305537399; Thu, 26 Oct
 2023 00:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <11-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com> <CAKHBV24f3yh_6GsY5jLzUVOdJksRPuHx+w6ynhYrBAt1zyHO6A@mail.gmail.com>
 <20231024234608.GD911568@nvidia.com>
In-Reply-To: <20231024234608.GD911568@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 26 Oct 2023 15:31:41 +0800
Message-ID: <CAKHBV25oYCwRW_5J+PFNhJ3Qj_JKy54J+3Lc25Wyie40xaQ_Ag@mail.gmail.com>
Subject: Re: [PATCH 11/27] iommu/arm-smmu-v3: Lift CD programming out of the
 SVA notifier code
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 7:46=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Oct 24, 2023 at 02:34:28PM +0800, Michael Shavit wrote:
> > On Thu, Oct 12, 2023 at 7:26=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > > [...]
> > > -static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *=
smmu_mn)
> > > +static struct arm_smmu_ctx_desc *
> > > +arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
> > >  {
> > >         struct mm_struct *mm =3D smmu_mn->mn.mm;
> > >         struct arm_smmu_ctx_desc *cd =3D smmu_mn->cd;
> > >         struct arm_smmu_domain *smmu_domain =3D smmu_mn->domain;
> > > -       struct arm_smmu_master *master;
> > > -       unsigned long flags;
> > >
> > >         if (!refcount_dec_and_test(&smmu_mn->refs))
> > > -               return;
> > > +               return cd;
> > >
> > >         list_del(&smmu_mn->list);
> > >
> > > -       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> > > -       list_for_each_entry(master, &smmu_domain->devices, domain_hea=
d)
> > > -               arm_smmu_clear_cd(master, mm->pasid);
> > > -       spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> > > -
> > >         /*
> > >          * If we went through clear(), we've already invalidated, and=
 no
> > >          * new TLB entry can have been formed.
> >
> > This re-orders the TLB invalidation before the CD entry is cleared.
> > Couldn't a misbehaving device form TLB entries in this time interval
> > that we'd want to avoid?
>
> Hum.. No for the 'inv_asid', but yes for the 'atc_inv_domain'

Just to confirm, why "No for the 'inv_asid'"? My best guess:
1. Transactions don't hit the TLB entries unless there's a valid CD
configured with that ASID
2. You're relying on those TLB entries being cleared elsewhere in the
code, when freeing/reclaiming the ASID from the domain.

But this also makes me curious why we bother with an ASID invalidation
in the first place if it's not required for correctness.
