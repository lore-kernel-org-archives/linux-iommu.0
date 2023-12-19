Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1314AA2
	for <iommu@lists.linux.dev>; Tue, 19 Dec 2023 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRE0JGGW"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e734251f48so11292317b3.1
        for <iommu@lists.linux.dev>; Tue, 19 Dec 2023 02:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702981330; x=1703586130; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IWtv0nvouCX5fIsmZ0v0oxZW/THrMx3EmTdh8M6/xgA=;
        b=KRE0JGGWPbWyhYqtzun2pTKi/HDNTbBOEI6HGrNt4hooeuncUSyySs7odGYGDSzNXu
         FwIIuAAns1MWlEcjr0aMolFXWvxjbA5Fzozmf7/Fs5oU/cXRVQhFCoRFudKegX/yueZ/
         4vaE+4vOwJpZTqZe4ayFRlHA67PVzxk8QjydRjdKUIq+TDcLHB1hztjSFj5IJ8CKG/4c
         2IpPsYBFZEkkHnj3gb8X6GLpxueIfbN25clIkCTikdwXuVUOQ0yCwh7xUD5vp2UpUZLq
         bvH481R5eVjbBeT7bQwK/YHn63d9UfVzRA88snHo8nx/5LrWiFK0Cx7wT65xkkvaPpDh
         ub5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702981330; x=1703586130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWtv0nvouCX5fIsmZ0v0oxZW/THrMx3EmTdh8M6/xgA=;
        b=JZc1da7NQ44l5ceSTwx2C8Lc1TDNrCxkqywnZ+pBM7vVWLbLEcrYhpF22EUGG91GpA
         U2/VPudmsP1eJDBubIHXDSgUoDhj4jY9hHQ3DAp8PHLqGCBB2ane2/xcfKEC7D4U0IeI
         px+Ivn55hrmdzys70mAW5idgZga3fMe3bKcTEbB6fM+V/4rAd2oCdQ40KrFcWgO7PAUr
         +ZcJvUs6T319aMsqJyJEyfc2L7CO09m7iyHFzY0ncC5j6BzKpeFL0NDi1dnie55Vyb2+
         W5MkUoIeQFaCd5OuXHw9ggzs2i8T3drkNLNLe934AXt3yNVo0pHM9cGUgmycX03uQck1
         RkhQ==
X-Gm-Message-State: AOJu0YwHZJmWiDiYHW/olQGpt7d7qw7EWbXKMijGri5K82CftLdWW0n7
	RtQqjfDRvR8EJZMf6DdCKujZtlYON1FVRVTGmLDfmQ==
X-Google-Smtp-Source: AGHT+IFhpDdAZ1lxMc9AEtbpDAW0YBFm8qR1mzenXUm1MTWc17RrIWYgD0L/pXRE448LohDI8TSYdryTZupOBG6uO14=
X-Received: by 2002:a81:62d5:0:b0:5e4:d68a:310 with SMTP id
 w204-20020a8162d5000000b005e4d68a0310mr481678ywb.36.1702981329841; Tue, 19
 Dec 2023 02:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231215101827.30549-1-quic_bibekkum@quicinc.com>
 <20231215101827.30549-4-quic_bibekkum@quicinc.com> <CAA8EJppcsr1sbeD1fK0nZ+rASABNcetBK3yMvaP7OiA4JPwskw@mail.gmail.com>
 <c9493c5f-ccf8-4e21-b00c-5fbc2a5f2edb@quicinc.com> <b7f2bbf9-fb5a-430d-aa32-3a220b46c2f0@arm.com>
 <1eee8bae-59f0-4066-9d04-8c3a5f750d3a@linaro.org> <42d627af-164b-4b50-973e-fa71d86cb84c@linaro.org>
 <aa8b2ccd-33da-404b-9a93-3d88cf63ec77@quicinc.com> <8338db1e-0216-4fc5-b6ab-ddf43adf3648@linaro.org>
 <a363c860-62be-43a7-930c-cab8a6f3fa6c@quicinc.com>
In-Reply-To: <a363c860-62be-43a7-930c-cab8a6f3fa6c@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Dec 2023 12:21:58 +0200
Message-ID: <CAA8EJpoMwrwQ9wBZE6AcobLLkCchFtN23SnHhw3enNOfX3CzTQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu: add ACTLR data and support for SM8550
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Robin Murphy <robin.murphy@arm.com>, will@kernel.org, 
	joro@8bytes.org, jsnitsel@redhat.com, quic_bjorande@quicinc.com, 
	mani@kernel.org, quic_eberman@quicinc.com, robdclark@chromium.org, 
	u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com, 
	quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 10:25, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 12/18/2023 7:51 PM, Dmitry Baryshkov wrote:
> > On 18/12/2023 13:23, Bibek Kumar Patro wrote:
> >>
> >>
> >> On 12/16/2023 9:45 PM, Dmitry Baryshkov wrote:
> >>> On 16/12/2023 02:03, Konrad Dybcio wrote:
> >>>> On 15.12.2023 13:54, Robin Murphy wrote:
> >>>>> On 2023-12-15 12:20 pm, Bibek Kumar Patro wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 12/15/2023 4:14 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Fri, 15 Dec 2023 at 12:19, Bibek Kumar Patro
> >>>>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>>>
> >>>>>>>> Add ACTLR data table for SM8550 along with support for
> >>>>>>>> same including SM8550 specific implementation operations.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>>>>>> ---
> >>>>>>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89
> >>>>>>>> ++++++++++++++++++++++
> >>>>>>>>    1 file changed, 89 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> index cb49291f5233..d2006f610243 100644
> >>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> @@ -20,6 +20,85 @@ struct actlr_config {
> >>>>>>>>           u32 actlr;
> >>>>>>>>    };
> >>>>>>>>
> >>>>>>>> +/*
> >>>>>>>> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching
> >>>>>>>> in the
> >>>>>>>> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the
> >>>>>>>> prefetch
> >>>>>>>> + * buffer). The remaining bits are implementation defined and
> >>>>>>>> vary across
> >>>>>>>> + * SoCs.
> >>>>>>>> + */
> >>>>>>>> +
> >>>>>>>> +#define PREFETCH_DEFAULT       0
> >>>>>>>> +#define PREFETCH_SHALLOW       BIT(8)
> >>>>>>>> +#define PREFETCH_MODERATE      BIT(9)
> >>>>>>>> +#define PREFETCH_DEEP          (BIT(9) | BIT(8))
> >>>>>>>
> >>>>>>> I thin the following might be more correct:
> >>>>>>>
> >>>>>>> #include <linux/bitfield.h>
> >>>>>>>
> >>>>>>> #define PREFETCH_MASK GENMASK(9, 8)
> >>>>>>> #define PREFETCH_DEFAULT FIELD_PREP(PREFETCH_MASK, 0)
> >>>>>>> #define PREFETCH_SHALLOW FIELD_PREP(PREFETCH_MASK, 1)
> >>>>>>> #define PREFETCH_MODERATE FIELD_PREP(PREFETCH_MASK, 2)
> >>>>>>> #define PREFETCH_DEEP FIELD_PREP(PREFETCH_MASK, 3)
> >>>>>>>
> >>>>>>
> >>>>>> Ack, thanks for this suggestion. Let me try this out using
> >>>>>> GENMASK. Once tested, will take care of this in next version.
> >>>>>
> >>>>> FWIW the more typical usage would be to just define the named
> >>>>> macros for the raw field values, then put the FIELD_PREP() at the
> >>>>> point of use. However in this case that's liable to get pretty
> >>>>> verbose, so although I'm usually a fan of bitfield.h, the most
> >>>>> readable option here might actually be to stick with simpler
> >>>>> definitions of "(0 << 8)", "(1 << 8)", etc. However it's not really
> >>>>> a big deal either way, and I defer to whatever Dmitry and Konrad
> >>>>> prefer, since they're the ones looking after arm-smmu-qcom the most :)
> >>>> My 5 cents would be to just use the "common" style of doing this, so:
> >>>>
> >>>> #define ACTRL_PREFETCH    GENMASK(9, 8)
> >>>>   #define PREFETCH_DEFAULT 0
> >>>>   #define PREFETCH_SHALLOW 1
> >>>>   #define PREFETCH_MODERATE 2
> >>>>   #define PREFETCH_DEEP 3
> >>>>
> >>>> and then use
> >>>>
> >>>> | FIELD_PREP(ACTRL_PREFETCH, PREFETCH_x)
> >>>>
> >>>> it can get verbose, but.. arguably that's good, since you really want
> >>>> to make sure the right bits are set here
> >>>
> >>> Sounds good to me.
> >>>
> >>
> >> Konrad, Dimitry, just checked FIELD_PREP() implementation
> >>
> >> #define FIELD_FIT(_mask, _val)
> >> ({                                                              \
> >>                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");  \
> >>                   ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask); \
> >> })
> >>
> >> since it is defined as a block, it won't be possible to use FIELD_PREP
> >> in macro or as a structure value, and can only be used inside a
> >> block/function. Orelse would show compilation errors as following
> >>
> >> kernel/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:94:20: note: in
> >> expansion of macro 'PREFETCH_SHALLOW'
> >>    { 0x1947, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>                      ^
> >> kernel/include/linux/bitfield.h:113:2: error: braced-group within
> >> expression allowed only inside a function
> >>    ({        \
> >>    ^
> >>
> >> So as per my understanding I think, we might need to go ahead with the
> >> generic implementation only. Let me know if I missed something.
> >
> > Then anyway (foo << bar) is better compared to BIT(n) | BIT(m).
> >
>
> Sure Dmitry, (foo << bar) would be simpler as well as Robin mentioned
> earlier in his reply.
> I can implement the defines as:
>
> #define PREFETCH_DEFAULT       0
> #define PREFETCH_SHALLOW       (1 << 8)
> #define PREFETCH_MODERATE      (1 << 9)

2 << 8. Isn't that hard.

> #define PREFETCH_DEEP          (3 << 8)
>
> This should be okay I think ?
>
> Thanks,
> Bibek
>


-- 
With best wishes
Dmitry
