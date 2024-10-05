Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632014C79
	for <iommu@lists.linux.dev>; Sat,  5 Oct 2024 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728090255; cv=none; b=WhIllwBQyoMnw/dmkeiAx6iScIxS9l507TvB30p+h+GcqPAM+8c+kANywHU0Gv7XOY+8E+Ez1hKyTAdzqE7vn8hn21Bt8DxpoTgsAxAAv4ad4J+OafvXHlzPqAKhecRt8R95quDkIIsiX8iGVg5OF5CG+Yam/Dpk4m6kOyBId9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728090255; c=relaxed/simple;
	bh=+Hllg7Ei1kQ90PkyK7T+LkkHENwzGhCWKO33DkU90vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ii9Ho7GGbfNNdMcNO2xFBZQD5gt3TgOT4iNuQVEwewfgQU0tO0vxdB+vqTUeZpwX7H8ApylVUR0ygGAoaa8p42a59yPvXXBxaZroD2/7UaZL/tF9bqQi3J2W6h4EJyGUDuz1Jd2r2Jody2rG8QQl0GNZCdY0g0TfbDrAEHHfwbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ydtwDsEz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ydtwDsEz"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c87aebabd7so10168a12.0
        for <iommu@lists.linux.dev>; Fri, 04 Oct 2024 18:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728090252; x=1728695052; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvGWKlnjWQBeRKa2edao+xrpWXp1CYlba5T40jSMewE=;
        b=ydtwDsEzjb0xgfoN7f/OWrNx0b21gS4JjIu0aAb3dRyP/EDT1pR77Z/kFBnwdGwVeJ
         71WSjiaCE+r1q5RjUT6TOTkzkmFtN4tNav0Asf9hQHb8HU8jYVkuBkns+mRxGMMRtFoy
         X1uUsjKSBzevj9mkmOjWb8dxMx8Ci6EVXVwXqMgVb9t7/Vjn6UtROKboCgHP0H1OFbVT
         OLKHJqtkiHZkQhRcTBAC6NLBahdPt70OSKoXb0jI8HzbaKUBYBLfSq8Pbwql39Ez/GNq
         ZM0VUCs53qqLWzwh1yRig5Z884ZSapsnrMcVa9qlDUVmEAqnPCrsN1d47pPagIvzu70C
         Xy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728090252; x=1728695052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvGWKlnjWQBeRKa2edao+xrpWXp1CYlba5T40jSMewE=;
        b=w7RqRhDYDAYuhMsk2o/OSSsqQ5tB9bCHiOucXCpU5YMERj2okphcpqyfss/Xit0+Nj
         fNF0D11/rr7G1X+jqkMcCyqA1GZyDsYC4EMVSVuxsqx4fcG6a9bcEIuNLQfJ07VXgP1C
         K39NNVOJYorPteDAgMm9uAUKDSmAjtpgUfEkhQix7yhOwDT3B7gb73keYWDcK7xnYso2
         zLEzwYtVKans0OD3Lr8Zt0JLOlx3gORzowg0a2zIMLd5D2LRAzIC0UBEPhfXvObScxHY
         sCQmZak1ptG1yoirAlp7doFyzThZAoXaR/zUQ6Ea5kzs+ja64ymBH/ph2yHi6F9XarAc
         P5hg==
X-Forwarded-Encrypted: i=1; AJvYcCUZMh++0KfUvUe6fgeOTV45GrsEY5+UChClnV6RFwfLfbezpVAW46DENlCWHf7F10fe+vnbsg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxf0BIssGNhO9hywW8QDxJRJpPp2CkOqP88c9pYTPQ07Qg06A88
	YKfAmAIu+iwl4ses4AYlLpgQ2g7dCytmWR/IYIbHI/xcX5bPAc2WewJm8Il/o90vkOQq4QGSQ4P
	LLybSntYZhVmvu7p21vW5w9i/3zIywK+ooPbL
X-Google-Smtp-Source: AGHT+IGDAlry6zV66LY9gAmPT1eybIGYw49sB0rcxhPA60/E0wfpIIBO2lfeMekrYW+O8ONemKk3E7d2G2TyNAe7quY=
X-Received: by 2002:a05:6402:5251:b0:5c7:18f8:38a6 with SMTP id
 4fb4d7f45d1cf-5c8e1e8b32amr77729a12.5.1728090251434; Fri, 04 Oct 2024
 18:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com> <87ac9686-cffb-43ac-b8f0-ccd3632fe5cd@os.amperecomputing.com>
In-Reply-To: <87ac9686-cffb-43ac-b8f0-ccd3632fe5cd@os.amperecomputing.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Fri, 4 Oct 2024 18:03:57 -0700
Message-ID: <CAE2F3rARZ_qq7MYnAT7nNKcNsL3DzaTH+ehPTNrwaaP20d9Cag@mail.gmail.com>
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Yang Shi <yang@os.amperecomputing.com>
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, james.morse@arm.com, will@kernel.org, 
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:47=E2=80=AFPM Yang Shi <yang@os.amperecomputing.co=
m> wrote:
> On 10/4/24 2:14 PM, Daniel Mentz wrote:
> > On Fri, Oct 4, 2024 at 11:04=E2=80=AFAM Yang Shi <yang@os.amperecomputi=
ng.com> wrote:
> >>   static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
> >>   {
> >> -       u32 size;
> >> +       u64 size;
> >>          struct arm_smmu_strtab_cfg *cfg =3D &smmu->strtab_cfg;
> >> +       u64 num_sids =3D arm_smmu_strtab_num_sids(smmu);
> >> +
> >> +       size =3D num_sids * sizeof(struct arm_smmu_ste);
> >> +       /* The max size for dmam_alloc_coherent() is 32-bit */
> > I'd remove this comment. I assume the intent here was to say that the
> > maximum size is 4GB (not 32 bit). I also can't find any reference to
> > this limitation. Where does dmam_alloc_coherent() limit the size of an
> > allocation to 4GB? Also, this comment might not be applicable to 64
> > bit platforms.
>
> The "size" parameter passed to dmam_alloc_coherent() is size_t type
> which is unsigned int.

I believe that this is true only for 32 bit platforms. On arm64,
unsigned int is 32 bit, whereas size_t is 64 bit. I'm still in favor
of removing that comment, because it's not applicable to arm64.

> >
> >> -       cfg->linear.num_ents =3D 1 << smmu->sid_bits;
> >> +       cfg->linear.num_ents =3D num_sids;
> > If you're worried about 32 bit platforms, then I'm wondering if this
> > also needs some attention. cfg->linear.num_ents is defined as an
> > unsigned int and num_sids could potentially be outside the range of an
> > unsigned int on 32 bit platforms.
>
> The (size > SIZE_MAX) check can guarantee excessively large num_sids
> won't reach here.

Now that I think about it, unsigned int is 32 bit even on arm64. So,
I'm afraid this could (theoretically) overflow. On arm64, I don't
think that the (size > SIZE_MAX) check will prevent this.

> >> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iom=
mu/arm/arm-smmu-v3/arm-smmu-v3.h
> >> index 1e9952ca989f..c8ceddc5e8ef 100644
> >> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> >> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> >> @@ -853,6 +853,11 @@ struct arm_smmu_master_domain {
> >>          ioasid_t ssid;
> >>   };
> >>
> >> +static inline u64 arm_smmu_strtab_num_sids(struct arm_smmu_device *sm=
mu)
> >> +{
> >> +       return (1ULL << smmu->sid_bits);
> >> +}
> >> +
> > I'm wondering if it makes sense to move this up and put it right
> > before arm_smmu_strtab_l1_idx(). That way, all the arm_smmu_strtab_*
> > functions are in one place.
>
> I did it. But the function uses struct arm_smmu_device which is defined
> after those arm_smmu_strtab_* helpers. I have to put the helper after
> struct arm_smmu_device definition to avoid compile error. We may
> consider re-organize the header file to group them better, but I don't
> think it is urgent enough and it seems out of the scope of the bug fix
> patch. I really want to have the bug fix landed in upstream ASAP.

Understood. Thanks. We could move the changes in
arm_smmu_init_strtab_linear() into a separate patch to accelerate the
process. I'm fine either way, though. I don't want to get in the way
of this landing upstream.

>
> >
> > On a related note, in arm_smmu_init_strtab_2lvl() we're capping the
> > number of l1 entries at STRTAB_MAX_L1_ENTRIES for 2 level stream
> > tables. I'm thinking it would make sense to limit the size of linear
> > stream tables for the same reasons.
>
> Yes, this also works. But I don't know what value should be used. Jason
> actually suggested (size > SIZE_512M) in v2 review, but I thought the
> value is a magic number. Why 512M? Just because it is too large for
> allocation. So I picked up SIZE_MAX, just because it is the largest size
> supported by size_t type.

I think it should be capped to STRTAB_MAX_L1_ENTRIES
