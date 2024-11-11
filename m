Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CF156C76
	for <iommu@lists.linux.dev>; Mon, 11 Nov 2024 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363661; cv=none; b=rAQtFjDFmh3ycw364mYkVxgwzBChxQpc27ENknL7ALP+Zu/cGuFQy3vf/f5jS6j4pfSJ9sqRykLTqtQkbYFO9ICOf7xH0uou+D/9Ho6A8ikqqAKUzKfls5aAB7LJoR8grsVgpF0AVim2Gls3Vmi1vvRvJKvCFtwrJrb8prYQYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363661; c=relaxed/simple;
	bh=96IrfasJe+huJZEb9p2zNq9wCR7SdQVFdkOuPuKVkl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3nqpQ7pF+4Yj/Q5fe57ap+cNbBmedQCVAK3B6OcaUfKj4X1tOUlCqCuAuQET57CMpJm5ZwamYj1pgstkb8x4HZFfBvfeTXN0L+lhv8b8RiXdysBRYNG/0RYGgvCnTeUlfptHsXn3Khj4kuuXk79B3wUMmsk+OI3Cr+S/hPIq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCIjW27f; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCIjW27f"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c947c00f26so43a12.1
        for <iommu@lists.linux.dev>; Mon, 11 Nov 2024 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731363658; x=1731968458; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S18UO9FJdcqTvzKYPWADeGvk/fZ+Jh7weLagrvuDqr0=;
        b=bCIjW27fNXzDVHw0qtvW02LxZcIA4SB9bDTv8911W+FrgxmjWk21z6NYg2XvtLVdZ3
         baxiV/DJMu5UsPhLeb9yp/gD48ti+EOIz+gH00XxU5eRAQYRHN3mlC5LyMy2HFkDyXA2
         nPCODjlhqb7a8S2JD3v9xYk4tN91OpxMo56wrVitRtCdu2wN2CUmr7ntk183Jf3Csu8O
         +uAJuYppX+peQ4ZpxeNqTe0TqiOyGS1h1WB0U9NCFW9Iz1TheguDf7TGDx6042ld+Yge
         GAIlswkuHLcJclliSifvW/j1yTb8bKITN80p4Glxep1ANzs5tYg4UWwlF3eyttqKksQa
         TWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731363658; x=1731968458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S18UO9FJdcqTvzKYPWADeGvk/fZ+Jh7weLagrvuDqr0=;
        b=A47YXGcxXD6dKmaYR2lKJvumn3zNm55SBNPXIRJdzoUgJIHwouWayHukSkxNz3FSfL
         CJfx0BDCQsoVeDMFKVHP3tsp85ZKnB42gRJvK8/sSK18Ml8NrDOh0N9vw+ZvyhrkdXFC
         8yJ3RGN+5oe3cLm1xa3acIIg6vHY8lGcJy3/9YxGDByMo6m/BBIBBb8XdRXN1LDRndX3
         40LaGxpeXPy/4YxyEBgopGtK1ql0ddgPW6dyUICZB8WKeCiNDKAqg5hGNFfws9Fv9/oB
         bEq1Dhlm0N6+FiK3Aa0SMXbA9fVcIYdiKU4GuoXxWF/n/ouTT/lnUUqMWfTXwJtq6x7O
         86gg==
X-Forwarded-Encrypted: i=1; AJvYcCV6pTqeZbg/XVWDmzSUVm2mYNfEY/PJrkLQklj6k2BoLgS+abx/VeikXLAvh1fYgGUuMTOJZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhhU6afvOYgzyXctovBtcc2WxD4weoMctCeiUys8wMpCQXhs5d
	qD0VBowMFcvv8Pn6UhUCcdjqKqo758IM1XVAdXfYkaTVbnFqSdF0JCbnbFEC0aFTISBaC2MCP5Z
	hrX15tRGs1edoNGVXcGnbxiT9898MA5LYRseX
X-Gm-Gg: ASbGncuNWxwWz8w5uMM81ceyQNNZS5oFbni6zwicfjzS2WbO3lYnE3EpxwJeYUNhDiH
	1ycxN31AJG40q0zIDv4JmZeLjv+5ZqQM70rxmC7xMGHIrpNgiNEbmf5SkQAHW
X-Google-Smtp-Source: AGHT+IEVhJxGEuzKb4vtD9m3W5+ALo67GxUbJbSNwBVvkJNKMmcp/lh0LICDuZWxJNq7tzYD7Q/rUz9vYrTdpODmc3A=
X-Received: by 2002:a05:6402:cf:b0:5cf:4994:501d with SMTP id
 4fb4d7f45d1cf-5cf4f1d55b3mr1076a12.3.1731363657671; Mon, 11 Nov 2024 14:20:57
 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241018180022.807928-1-praan@google.com> <20241018180022.807928-2-praan@google.com>
 <CAE2F3rCZALbQQUNeaAqShgXz6UNnSQAagqE7RA9kAewBFJNenw@mail.gmail.com> <ZyzVTG8ffcFD8YFR@google.com>
In-Reply-To: <ZyzVTG8ffcFD8YFR@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 11 Nov 2024 14:20:46 -0800
Message-ID: <CAE2F3rAL=a43NNK30omCyfKZR=_Gp2cNxHuUMcDd-xHN-Kvv=A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:57=E2=80=AFAM Pranjal Shrivastava <praan@google.co=
m> wrote:
>
> On Wed, Nov 06, 2024 at 04:16:19PM -0800, Daniel Mentz wrote:
> > On Fri, Oct 18, 2024 at 11:00=E2=80=AFAM Pranjal Shrivastava <praan@goo=
gle.com> wrote:
> > >
> > > Introduce `struct arm_smmu_event` to represent event records.
> > > Parse out relevant fields from raw event records for ease and
> > > use the new `struct arm_smmu_event` instead.
> > >
> > > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > ---
> >
> > > +struct arm_smmu_event {
> > > +       struct arm_smmu_device          *smmu;
> > > +       u8                              id;
> > > +       u8                              class;
> > > +       u16                             stag;
> > > +       u32                             sid;
> > > +       u32                             ssid;
> > > +       u64                             iova;
> > > +       u64                             ipa;
> > > +       u64                             raw[EVTQ_ENT_DWORDS];
> >
> > Consider removing the member named raw from struct arm_smmu_event.
> > Compare this with struct arm_smmu_cmdq_ent and
> > arm_smmu_cmdq_build_cmd() which keep the encoded and decoded versions
> > separate.
>
> I had a similar implemntation in v3 [1] but it was decided [2]
> to keep the "raw" event array within arm_smmu_event itself. Since
> otherwise we'd have two variables, one pointing to the other when they
> have the exact same scope and lifetime anyway.

I understand that the concern in [2] was that "one [is] pointing to
the other". At the time, I think you had a pointer in struct
arm_smmu_event named raw, and the feedback was to embed the raw event
data in the structure instead of having a pointer. What I'm proposing
is to neither have a pointer nor embed it in the struct.

>
> Do we have a strong preference here?

Not a strong preference, but I'd prefer to have the raw event and the
decoded event separate.

>
> >
> > > +       bool                            stall;
> > > +       bool                            ssid_valid;
> > > +       bool                            privileged;
> > > +       bool                            instruction;
> > > +       bool                            s2;
> > > +       bool                            read;
> > > +};
>
> Thanks,
> Praan
>
> [1] https://lore.kernel.org/all/20240928005143.2378938-2-praan@google.com=
/
> [2] https://lore.kernel.org/all/5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@arm.=
com/
