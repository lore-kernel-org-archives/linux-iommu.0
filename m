Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29917750
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 18:29:59 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4036bd4fff1so44591cf.0
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 11:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296999; x=1692901799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwYh+kePTjMmxljMAz9Xt13TYo4scp9mgDZ0UyhkoJA=;
        b=A8Oj0MA6eqOQbzanZvqIHAdaiSCKjoFGl6cNKY88LVT0R9Nzi1jbf3TkqeDF8oqfmM
         5i9LWvb+oewmkabEd7USKmAMDaaxNGt3wjL6vV6xiz5NEuCJH0cOdUMSeobbsjQzC3XS
         lq7XRRseqFIov2FzXG4Xvi9t+eP2akaMsNjWQ5vLAnxGueiayEc2iz+Xa5A6mFrM4cVV
         fJIKYuJMP1n7xtm+b4IAiMWc0hzeSCgUiya9XoLOEhfMNJ0Dyn7Km27w4UPwvCQQK2jt
         olSVfXU7FxoDopdHKQaYfc08uIKp5uFvgFk6wGag1nEwuj/iVO1P2tULRs51Ig+zGdfX
         kxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296999; x=1692901799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwYh+kePTjMmxljMAz9Xt13TYo4scp9mgDZ0UyhkoJA=;
        b=Ti0HIfDrnBf4zH65eqBTE5uaeKYCRHBnO4SmfUwfPlu30wdshQTKvcXhnbiYnuO0do
         ecFn2ez9ErsJF05iRmAISKOIAhOVnvTIQiqmFexcAJnu0s1LYU+w1hI1wlBf5sisq9JU
         Sj20lkZ4hNuLZqfMP9NiNAeK8ehQwFjYkMsNnMY/jxzoy1s84uXiq9p+n+X01WSLQVSv
         CGna/oVmqjdm9ZaZFl10/T5RwKf4muUSpRkZAgCDAU1gZtd/ZT+mATcIz0rmfPGVDKRc
         P9ZFjbA5Cn11523tBYcPrZV1zOmoNYYvwhiXoGApYO3xD3IoF2SiOI0Y7h9+DeS1uiaD
         A7HA==
X-Gm-Message-State: AOJu0YzVAn4pAZ97FVxWMNOyONVFbtFrdsEeVSRij5svK9a3uAUfR3Rw
	HQCEqB95FicxmT6tvzAN7peRctexMYwXOTLAeZBjJw==
X-Google-Smtp-Source: AGHT+IGDDMM5gCD6SYSVcMwn8Bjh/47KrTKCzkFUsgyPorQbeGqAjOh0vvOtUcO4zGG5I/VRexzOoK4u8GPQqhWlwXA=
X-Received: by 2002:ac8:7d03:0:b0:3fd:ad1b:4e8a with SMTP id
 g3-20020ac87d03000000b003fdad1b4e8amr38751qtb.22.1692296998646; Thu, 17 Aug
 2023 11:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230818000321.1.Ibca43cc8d1bcad3ac3deef5726b9745128aea634@changeid>
 <928822fd-642a-5ca7-7b42-dc7885f3cf51@arm.com> <CAKHBV27bsDWsS_dUsj=xdTfnc0CDhcH+0ZLZ2z481BZMsBQX4w@mail.gmail.com>
 <a8623bd8-1df4-42b7-4993-006316594818@arm.com>
In-Reply-To: <a8623bd8-1df4-42b7-4993-006316594818@arm.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 18 Aug 2023 02:29:22 +0800
Message-ID: <CAKHBV27W+7P_A1DbU0MBxQ9vzRDR+sPH2SyASKXSr5fXvUwyWg@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Simplify stage selection logic
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Tomas Krcka <krckatom@amazon.de>, Will Deacon <will@kernel.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 2:19=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-08-17 18:06, Michael Shavit wrote:
> > On Fri, Aug 18, 2023 at 12:35=E2=80=AFAM Robin Murphy <robin.murphy@arm=
.com> wrote:
> >>
> >> The reason it's like this is because of arm_smmu_enable_nesting(), whi=
ch
> >> *is* the additional thing that's going on with the stage selection log=
ic.
> >>
> >> Thanks,
> >> Robin.
> >
> > Right, but arm_smmu_enable_nesting isn't involved in this computation
> > at this point in the flow.
> >
> > arm_smmu_enable_nesting returns early if smmu_domain->smmu isn't set,
> > and smmu_domain->smmu is only set after arm_smmu_domain_finalise.
> > So at this point, smmu_domain->stage is being initialized for the
> > first time. If this code is responsible for handling some special
> > nesting case, then it's probably not working as intended.
>
> I think you may have misread that code...

oof, yes, I did indeed misread.

>
> Anyway, the point of the logic here is that it is not "selection", it
> is, as the comment says, "restriction" - i.e. it is checking that the
> already-selected stage is actually supported, and coercing it if not.
> The default selection for a newly-allocated domain is always implicitly
> ARM_SMMU_DOMAIN_S1 (which is explicitly defined as 0 to convey that
> significance), but it may be set to ARM_SMMU_DOMAIN_NESTED before the
> first attach finalises the pagetable format.

Thanks for the explanation, that does make sense :) .

> Obviously this could be clearer, especially for anyone not so familiar
> with all the history, but at this point I honestly don't think it's
> worth doing anything without completely ripping out
> arm_smmu_enable_nesting() as well. Jason already had a patch a while
> ago, and my bus rework is now also very close to the point of finally
> fixing iommu_domain_alloc() to be able to return working domains, such
> that all the "domain_finalise" bodges go away and that whole "modify the
> domain between allocation and attach" paradigm is no longer valid at all.
>
> By this point I'm not too fussed about breaking the current meaning of
> ARM_SMMU_DOMAIN_NESTED any more. But what I definitely don't want to do
> is have a change like this which subtly but decisively breaks it while
> still leaving all the now-dead code in place ;)

Ack, will drop this change.
