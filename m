Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A420E7
	for <iommu@lists.linux.dev>; Thu, 16 Nov 2023 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4ztFf7l"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7eef0b931so4986137b3.0
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 22:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700117527; x=1700722327; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oc5E6kIcla/Or4QU1XuvIaiW9BS0HQZyOIehNU3S8rI=;
        b=g4ztFf7lHJmB/yBMiUCRl9P5tDDG50YLBLSCo1t2eYy7O5Ffjvf4XDGqRk6TbiQKa0
         oadKyfxQ39gDMiJ4capykW9InyJHOeKvs4vxCco39gDTakPHMqdTMctmHHwjZ+QUZ4NK
         vHJtvsRDYTROsQOPU4Ecc6oNXuYU4RAxT5BNFU68iuDrt8GfR2buE9OXqRsW8rak//81
         roECVxy06xZo71i8aBdrzGI+qP9x53Z4REU1rMaB03XtucPD271UWa508B8KPDeEuHMD
         Wa/QFPyujuqy5Uwg+3SGStTDFWoM8sojcwcoFOhDJgKuaVwjNrKM5qHTPqZyqCRj58HG
         HOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700117527; x=1700722327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oc5E6kIcla/Or4QU1XuvIaiW9BS0HQZyOIehNU3S8rI=;
        b=E0IxLG+i3RCTRRol/tlhKXqW86lNMB1LgJBjHE7PJ5bgkC8CRsmWDV4t+1YfJ/4gIb
         WiJsEVHz2WeOGhuyZzjZiCNoT/bnSbDXV+aaSWqS2qTSf12QfF49rF5oPkmYmS8TkMfK
         U5+XXwF2FSTxk3RfsAiS/qKJOQ2vbYmVMR1z2z3XJrt+bqBgUGgwFvSXAn4y4dG6Thp/
         CBZTXkiz9v15wJdWGg/Um6bXYR3X7fyJw5I+180pek5NsarS7VbuLOymwCraktV4pZC1
         ZQeQasO7XlqYl+mGa5SEX+khre2Ho8IuKeihYQIRmrhGYUGKj3nrh8LYe+pmR/8O5k6e
         eCeg==
X-Gm-Message-State: AOJu0YxIQiIjvFWg4leEX4/69bHMWzxyjjVA6JX26CkDLMJ2fpnlK53R
	kjqDMipgWwkZ819nTGh2X8cuZaxdMSz3peXTZB4I9Q==
X-Google-Smtp-Source: AGHT+IF9xl+Hc9uyP+mSbdRq22l1klxH1FdSfYmdGQLsuU3qAhFB8KEVx7+2dM8/7H2WMf9mXaTnItbCGUXlosfWtoc=
X-Received: by 2002:a81:a549:0:b0:57a:cf8:5b4 with SMTP id v9-20020a81a549000000b0057a0cf805b4mr14384806ywg.51.1700117527207;
 Wed, 15 Nov 2023 22:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-3-quic_bibekkum@quicinc.com> <CAA8EJpr1NzqiuNVZ0YcLpJ=yeOYFbLouAFgN9VMOiKpmoGVdtQ@mail.gmail.com>
 <7edad996-f148-42d5-8e72-0334d3b9101f@quicinc.com> <CAA8EJpqzEvC-LEjJrOk6Ed8utFNnqgP=qkb0mq-dOfMZd5ij4Q@mail.gmail.com>
 <dba223a1-0456-40b8-b295-ea960867dcf9@quicinc.com> <CAA8EJpqvXb_Zdmq0O0KEA8mn5UkSriCZ02w16dts7Gd84R30oQ@mail.gmail.com>
 <aebdf7f6-48b7-43d3-95af-83859ddc593f@quicinc.com> <be9675a6-a01e-4cf7-95b3-174220d4a042@linaro.org>
 <61d2885a-50f9-419f-8473-10308baed493@quicinc.com>
In-Reply-To: <61d2885a-50f9-419f-8473-10308baed493@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 16 Nov 2023 08:51:55 +0200
Message-ID: <CAA8EJpoTeonht4S5JkW=1VJmKsSFm5iCb_Tz-ZempaRufnjmHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, a39.skl@gmail.com, quic_pkondeti@quicinc.com, 
	quic_molvera@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Nov 2023 at 08:10, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 11/15/2023 10:12 PM, Konrad Dybcio wrote:
> >
> >
> > On 11/15/23 13:49, Bibek Kumar Patro wrote:
> >>
> >>
> >> On 11/15/2023 4:15 PM, Dmitry Baryshkov wrote:
> >>> On Wed, 15 Nov 2023 at 11:51, Bibek Kumar Patro
> >>> <quic_bibekkum@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 11/15/2023 3:08 PM, Dmitry Baryshkov wrote:
> >>>>> On Wed, 15 Nov 2023 at 11:22, Bibek Kumar Patro
> >>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 11/14/2023 7:42 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
> >>>>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>>>
> >>>>>>>> Add ACTLR data table for SM8550 along with support for
> >>>>>>>> same including SM8550 specific implementation operations.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>>>>>> ---
> >>>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 92
> >>>>>>>> +++++++++++++++++++++-
> >>>>>>>>     1 file changed, 88 insertions(+), 4 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> index 578c662c7c30..0eaf6f2a2e49 100644
> >>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> @@ -25,6 +25,70 @@ struct actlr_data {
> >>>>>>>>            u32 actlr;
> >>>>>>>>     };
> >>>>>>>>
> >>>>>>>> +#define PRE_FETCH_1    0
> >>>>>>>> +#define PRE_FETCH_2    BIT(8)
> >>>>>>>> +#define PRE_FETCH_3    (BIT(9) | BIT(8))
> >>>>>>>
> >>>>>>> What is the difference between PRE_FETCH_3 and PRE_FETCH_2? And
> >>>>>>> PRE_FETCH_1? Are these real numbers that refer to some amount /
> >>>>>>> count
> >>>>>>> or just dummy names?
> >>>>>>>
> >>>>>>
> >>>>>> No,these are not real numbers, but prefetch settings for a particular
> >>>>>> perfect configuration.
> >>>>>
> >>>>> Then I'd ask for some better names or descriptions.
> >>>>>
> >>>>
> >>>> Noted, PREFETCH_SETTING_n / PREFETCH_OPTION_n sounds like a better name
> >>>> in the following case. Would it be okay to use this name instead?
> >>>
> >>> Not really.
> >>>
> >>
> >> Any suggestion you have in mind, if not this nomenclature?
> > Dmitry's concern seems to be that you provide:
> >
> > PRE_FETCH_1 /* prefetcher with settings preset no. 1 */
> > PRE_FETCH_2 /* prefetcher with settings preset no. 2 */
> > PRE_FETCH_3 /* prefetcher with settings preset no. 3 */
> >
> > whereas it would be both useful and interesting to see what these
> > settings mean, i.e. what differences there are between all of
> > these presets.
> >
>
> Ah, okay got it now from Dimitry and yours' response.
> But we exactly won't be able to reveal what each of these settings
> mean, as this might risk of revealing IP as ACTLR bits are
> implementation defined (except CPRE and CMTLB) which other SoC vendors
> might be using it in different manner(or different purpose) in their
> downstream implementation.
> We can name it like (e.g PREFETCH_DISABLE, PREFETCH_SHALLOW,
> PREFETCH_DEEP) to indicate the behaviour, but won't be exactly
> name/describe it to explain what it does with a particular setting.

This is already better than 1,2,3.

-- 
With best wishes
Dmitry
