Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0034100DD
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 12:04:17 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-40c72caec5cso209071cf.0
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692101056; x=1692705856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa4ijFpMRNMdDOXZdXXDwrY7fporBKZPPmAwJ4muH1s=;
        b=NlAy2nuZM6YR9j6uv9fE7TfLbdb84+Dc3bcHB1de2on8b3q9QHMMiUaqqpZrkQfTCc
         4GQCzEK7vdfxxw4y51dSVfVL5+t+OL1kgGBV16+kVaFL6/m7Plodl3JNAfx682/FQ75x
         lTTt95SINOfPa4ECwMwnQH5R2b7ltvoy+KtDxfhvyR63QJqhmnkyqfbLqxZN3lcbE1Mi
         2LwENFpd6RuTxX+JnFJRI/4C3etxUfRuZLDPOo3lCxVXT0ARk6k6X4MTXweHPW9Ux3+N
         QxDvCF3OfjBV9yE9mL+o97vo1SoBWDXgU5WY0VvlZeZhLPpJqqXmPqhkOdLPtyJpGwLP
         XNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692101056; x=1692705856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wa4ijFpMRNMdDOXZdXXDwrY7fporBKZPPmAwJ4muH1s=;
        b=BeJraWKytXwC4KMd35zDkzpR0kL7IqkNV//Bwdh6yfndEiyDodiG6l3gAnUGHhe6Bk
         MAyRZC6OjleYANySlvMP75zyS6Wi/MBZyhU3rvUgb8Q2fv/5Pces6/V5DBwp9mtX/Okf
         1hFe0EI67PGHOS1jcCTbHpp7Nz5AVTFwVJtc/kM/DigfwjMN77OGsH5VYX3yMmV/z3Xt
         MyTImOzFrLIIVOgsjBKrwhnXwFJBp5vwongNPlEaZ7eR21pHB8maZt+UyP3c9nGVVmPP
         CpSKfgDqLWqm1rxfyPc/JmWSdl95bFuiyRiEmcz84WJvMjL3QeoqiXshyOwJzo3SHJm1
         C9uA==
X-Gm-Message-State: AOJu0YylPizOSreOrOwWA2pvU1DojNBdW2WdmRU0znQzCBbKtKUyZFFa
	5ARsndhsUOPRuyuRApnMRV+LOmtw2i+e6ebM7Bki8ufQX/ldVI2D96EQmw==
X-Google-Smtp-Source: AGHT+IFLbYrlXJqUODynvyJHT9/v4qYbX+kKrxOxLI/Ska83ZEsKVQNmI3ZCRWkbxaNCpQQIqaVcBPaHoOU23NqKoq0=
X-Received: by 2002:a05:622a:1822:b0:403:f5b8:2bd2 with SMTP id
 t34-20020a05622a182200b00403f5b82bd2mr660297qtc.9.1692101056467; Tue, 15 Aug
 2023 05:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck> <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <20230810144051.GD5795@willie-the-truck> <ZNUEuIlPmrckwMyn@nvidia.com>
 <CAKHBV24SLBNw-yWn3m6BtvvHUgD0h1e1QkEb1LrUcWSwpR85Yg@mail.gmail.com> <ZNtgD3LKwS4eatoe@nvidia.com>
In-Reply-To: <ZNtgD3LKwS4eatoe@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 15 Aug 2023 20:03:40 +0800
Message-ID: <CAKHBV25YKMGnAs2L0a5EwdaXrpwb9RPJqBcJjO6ahD7UMgEd2Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 7:38=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Aug 15, 2023 at 01:20:04PM +0800, Michael Shavit wrote:
> > On Thu, Aug 10, 2023 at 11:39=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.co=
m> wrote:
> > >
> > > Actually, I don't think this even works as nothing on the PASID path
> > > adds to the list that arm_smmu_write_ctx_desc_devices() iterates over=
 ??
> > >
> > > Then the remaining two calls:
> > >
> > > arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
> > >         arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
> > >
> > >         This is OK only if the sketchy assumption that the CD
> > >         we extracted for a conflicting ASID is not asigned to a PASID=
.
> > >
> > > static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_st=
ruct *mm)
> > >         arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quie=
t_cd);
> > >
> > >         This doesn't work because we didn't add the master to the lis=
t
> > >         during __arm_smmu_sva_bind and this path is expressly working
> > >         on the PASID binds, not the RID binds.
> >
> > Actually it is working on the RID attached domain (as returned by
> > iommu_get_domain_for_dev() at sva_bind time) not the SVA domain
> > here...
>
> That can't be right, the purpose of that call and arm_smmu_mm_release is =
to
> disable the PASID that is about the UAF the mm's page table.
>
> Jason

For the sake of this message, let's call "primary domain" whatever RID
domain was attached to a master at the time set_dev_pasid() was called
on that master. That RID domain is locked in while SVA is enabled and
cannot be detached.

The arm-smmu-v3-sva.c implementation creates a mapping between an SVA
domain and this primary domain (through the sva domain's mm). In
arm_smmu_mm_release, the primary domain is looked up and
arm_smmu_write_ctx_desc() is called on all masters that this domain is
attached to.
