Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E415BA
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 08:34:13 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-40a47e8e38dso294531cf.1
        for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692606853; x=1693211653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVU/Nryq1OKFV/57dRCXe3Tz8/JE0s1HOyjf1K6mQAA=;
        b=xSg2ma2LVRZYZ0pv6/ADp1TkyjzHJ0QJ2sf2Ck9WEDYEcrRj7eHF6q+XoS485T1zoW
         nVSrezSoMCceEeQ6dQKdNkyO5hy0rxYYR5a2OyzUlZ5YkTYC1inF+kwafhFBnChdsVMr
         lTe6ILLDCjVm06zLGAJDXuE2HiMFtV1tRIf3WqkDoIOOP6SOvvkxjUIOQLLogtH2Eo0I
         GZCl3u1usGEulMv922zxakIOBI4LANIH0kkNYbroKg8xP6eCpRKEIQAHcm591G6tR3jl
         F1nmbm96qR8Nb8ZdEE/VPHtmunZDToRpfWDu0HacjrXPOSxpl555h86iC8QWMddVO7e3
         +amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692606853; x=1693211653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVU/Nryq1OKFV/57dRCXe3Tz8/JE0s1HOyjf1K6mQAA=;
        b=LF/XgcRtkbtqN5wl2fggfdJkpUzgMDrasiRJIfopBlWgeTeCaPiVNQ8HdS7l3iLHds
         3TPtltI4yEOoeJJct96DO9iBPi8aI79fVs7sa0q+mpJokbp4p48S27c/bac+qI5BGjzL
         dHPaMJl609HRASuBCcNCatt5x7sQ7rkaWNQxph05G9Tav9AaraPdT2AaImbuuVreYHGH
         xu66RmtgtTunS4NHBPayxA8kW6qRP/LZ6J4EpntQLESy9HnI0bhC3Fcjrkk1p1cafNIs
         Hus2MSQf8TSafPWJXf++n8hMGw4JwEkgYVyA2SqVE7nuif0Vn+IPZrdk8EDTZ0x6lB5B
         6+aA==
X-Gm-Message-State: AOJu0YyCmsrtSfETxdmY02n56rPyI5Tgp0/pLpgR9DFFJghIsHkDQbtu
	XexoROw4qTsrlL8qoYyFLGrEll+GLCVkmC8nMpV0nQ==
X-Google-Smtp-Source: AGHT+IF5lj8CqHKSU+fGMj/v8EBHtUcF6dqeGwaeTNaKC8TL0GuPMcu82VpIJISeaDPykuUbG2akzADW3j32bjwlPZg=
X-Received: by 2002:ac8:5bc4:0:b0:410:8ba3:21c7 with SMTP id
 b4-20020ac85bc4000000b004108ba321c7mr191159qtb.18.1692606852525; Mon, 21 Aug
 2023 01:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
 <ZN5y4N8ffSoiR/sm@nvidia.com> <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
 <CAKHBV27suc5nDoH7gMHebjYBONTNqsugWvxbo2E-fRjRGs288w@mail.gmail.com> <ZN93TO9mRIrX1grw@nvidia.com>
In-Reply-To: <ZN93TO9mRIrX1grw@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 21 Aug 2023 16:33:36 +0800
Message-ID: <CAKHBV24L7pTajkStWCRiW7976+B8VtDHRDpo+Emta0RshkvRhQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over installed_smmus
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, nicolinc@nvidia.com, tina.zhang@intel.com, 
	jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 9:51=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Aug 18, 2023 at 11:44:55AM +0800, Michael Shavit wrote:
> > On Fri, Aug 18, 2023 at 3:41=E2=80=AFAM Robin Murphy <robin.murphy@arm.=
com> wrote:
> > >
> > > On 2023-08-17 20:20, Jason Gunthorpe wrote:
> > > > It is certainly wrong to skip invalidations generated for any other
> > > > reason.
> > > >
> > > >  From what I can tell SVA domains should have their CD table entry
> > > > programmed with "ASET=3D0" and normal paging domains should be
> > > > programmed with "ASET=3D1". This causes only the SVA domains to lis=
ten
> > > > to the BTM invalidations.
> > >
> > > Correct.
> > >
> > > Thanks,
> > > Robin.
> >
> > Would it be fair to rename arm_smmu_tlb_inv_asid (or move into
> > arm-smmu-v3-sva) to make it explicit that it shouldn't be used outside
> > of SVA then? Or add a parameter such as skip_btm_capable_devices.
>
> ???
>
> arm_smmu_tlb_inv_asid() is generally used in many places and has
> nothing to do with BTM..
>
> Did you mean arm_smmu_tlb_inv_range_asid ?

Whoops yes that's what I meant.


>
> Broadly, invalidation is not SVA specific..
>
> Notice that arm_smmu_tlb_inv_range_asid() already duplicates
> arm_smmu_tlb_inv_range_domain().
>
> IMHO I would split the ATC step out of arm_smmu_mm_invalidate_range(),
> get rid of arm_smmu_tlb_inv_range_domain(), and have the mmu notifier
> just do as it already does:
>
>         if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
>                 arm_smmu_tlb_inv_range_domain_no_atc(start, size, smmu_mn=
->cd->asid,
>                                             PAGE_SIZE, false, smmu_domain=
);
>         arm_smmu_atc_inv_domain(smmu_domain, start, size);
>
> And make arm_smmu_tlb_inv_range_domain() just call
>    arm_smmu_tlb_inv_range_domain_no_atc();
>    arm_smmu_atc_inv_domain();

That's a nice clean-up but doesn't really solve the problem faced by this p=
atch.

This patch series eliminates the smmu_domain->smmu handle, replacing
it for a list of SMMUs. So SVA can no longer optimize the
arm_smmu_tlb_inv_range_asid call away by checking whether the SMMU BTM
feature is enabled since there's now a list of SMMUs with possibly
heterogeneous support for the feature. Since there's now a loop over a
series of SMMUs inside arm_smmu_tlb_inv_range_asid, it makes sense to
move the check into that loop. This technically works because only SVA
is calling arm_smmu_tlb_inv_range_asid but can (IMO) risk introducing
bugs in the future since it's not obvious from the function name.

The suggestion was then to introduce a parameter to
arm_smmu_tlb_inv_range_asid (or arm_smmu_tlb_inv_range_domain_no_atc)
to make this behavior explicit in the API.
