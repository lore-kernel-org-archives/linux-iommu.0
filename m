Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C5A202635
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372737; cv=none; b=HGecD6SzCUcQgENstU7ArS8CPk0G52GqMU9tUwDoRGsIRJX/dG9zXUCfhM4Z7FeCmwS+YPalcnTyM6YAYIDaqrSD6jj1wCs0YQ0sbkA6iiaq43FQhMWPhLPfGtYYfUWRQd5ZPxZya6GO01YRcTOQq/neNVf0rUf9dRznxUMUMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372737; c=relaxed/simple;
	bh=QSa03cVkOtG5TbWjXhPE7C1bv3dFgbQIKffI+I7mFiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts3F9VdZpdYEW9t9o2iprYITJ6ZOZdFr6xtSYdG/bKZTYij9khyJW3tF6Ke3U6T/PRFh7qd/BUBB6VltmQ8WLGLqvYW7qz4brmLR+fQNyaz3Ji8OxUEW4Otk+2BZFU3LO8wJ58Wq7ocau9ZVlopvIPa43TlkbTtAxhjxnsCFIMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AsF4N3eT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AsF4N3eT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c87b0332cso41285ad.1
        for <iommu@lists.linux.dev>; Mon, 11 Nov 2024 16:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731372735; x=1731977535; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jT9IS2ghsrSbTBZiu8lpOBSvXGuMCdBEefRepDb69Dc=;
        b=AsF4N3eTlas5j2bezypDhuwiNfWu0Qhx/hYl+EUdoa1ojePL/alaWRlJSjgCx6WMr/
         gPp2kX2n6CF3FI3S4Vpd0QFtBZlH+rr5A6NG+joOMHhqY8aLAfbWCLN3yOgM/4WlzWWp
         XoMyy7lywx9Q61Fmk0LCOOhFYfGIEBpQiW1kfSW0P2UxMV+LAawfIeRyidPl64heZgOq
         wH9ARZ71lgHWbDIbDpRKmdnevPKMkz6TjsEYzVIBYpNwdgv55828LIdRSKC45wqv8B4S
         Nn00dKizeNS/DExzq2ot8jz//t9aglYFurIoAi1XLRhbwFE0409WFeL/8UM4P1XswOiN
         fbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731372735; x=1731977535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jT9IS2ghsrSbTBZiu8lpOBSvXGuMCdBEefRepDb69Dc=;
        b=xTySPNrcO+MXw3ZQY3DBmGCnCa2s5W0iLPZMeNC71xjGElwItp/Yfvt/l2a8AV6Xl9
         G7RXUXpj3rwwWzr3Gp0A2HQm0wnsdixncnTkujCBUJalEDpTC/iAp3KvbvsJLoNj151I
         GalziGxeqkF3ceqJ1f2tYEF3xQYomlTGheX40gTRnXy4yzhwHRq31+Uuvvim7z3kwyyF
         QXrW5EjJ1jWUJpNkojksV3JBPeK1jkTQxlH7Uq2mIM4Fcmr6rRSy2QEtNT4bYWyrxTy/
         OYofFzyzuLH+dWy/I5ImzJmIHHRCEEQbQ+5mqd1mEj59NAErxM8N1bNE3rcSsSm/eK70
         W6yA==
X-Forwarded-Encrypted: i=1; AJvYcCUPYSyT2A6nmqo6/tJL2r1bAcHd4s8Rkx1CuI4zDqH2vFhngF4H2++adc0CIn0nx5Cl19crcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZkqpGpATOM2BZQPY+eNKxmfq09NSNLaq91njMTaKCblbdwHwg
	rkLGfDu1GUu28KFwb4JoDP9ad7+MwecDtL85bbiIhW3ZoHmhBc5VWiVmm2HKGA==
X-Gm-Gg: ASbGncuaAkyS5Xq7Bvhmt37pBZOIcu5GUY46dimimmc0V0AwC5UrYQxEAsq5By3twc0
	mdaTMxE5q4mBZ4tZYdYD44JOZVmlLqu11Vg/EfGByuI03lCOH9d2ZnjrbgIE0StCOGPQ/dxFCIw
	hZmEFtOLytzBvF7inx5qCxUqI3ighWHkNDgTT/Phh7btq3912DC4wqyxKvnyHiZvg5XA5kvK73z
	G+ReMpelWo6xnfXHFTkWsQZEjdaaMPYdJbrF91Lml1vMwczfxoF8aZRwgPvHXgEyzBI9Iy0HJSG
	P7XPI1sSyjk=
X-Google-Smtp-Source: AGHT+IG2R0eEkWdDL3+HTcAXlXcPToceg0sEpoYkvrHXP+2gaX5Wj1HKtogDQLVTB2VQ8LzeJnqnAQ==
X-Received: by 2002:a17:902:d512:b0:20c:e262:2570 with SMTP id d9443c01a7336-211ab6fcd10mr967425ad.8.1731372734549;
        Mon, 11 Nov 2024 16:52:14 -0800 (PST)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407863defsm10166114b3a.24.2024.11.11.16.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 16:52:14 -0800 (PST)
Date: Tue, 12 Nov 2024 00:52:06 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZzKmth5__xVUme1P@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <CAE2F3rCZALbQQUNeaAqShgXz6UNnSQAagqE7RA9kAewBFJNenw@mail.gmail.com>
 <ZyzVTG8ffcFD8YFR@google.com>
 <CAE2F3rAL=a43NNK30omCyfKZR=_Gp2cNxHuUMcDd-xHN-Kvv=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rAL=a43NNK30omCyfKZR=_Gp2cNxHuUMcDd-xHN-Kvv=A@mail.gmail.com>

On Mon, Nov 11, 2024 at 02:20:46PM -0800, Daniel Mentz wrote:
> On Thu, Nov 7, 2024 at 6:57 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Wed, Nov 06, 2024 at 04:16:19PM -0800, Daniel Mentz wrote:
> > > On Fri, Oct 18, 2024 at 11:00 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > >
> > > > Introduce `struct arm_smmu_event` to represent event records.
> > > > Parse out relevant fields from raw event records for ease and
> > > > use the new `struct arm_smmu_event` instead.
> > > >
> > > > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > > ---
> > >
> > > > +struct arm_smmu_event {
> > > > +       struct arm_smmu_device          *smmu;
> > > > +       u8                              id;
> > > > +       u8                              class;
> > > > +       u16                             stag;
> > > > +       u32                             sid;
> > > > +       u32                             ssid;
> > > > +       u64                             iova;
> > > > +       u64                             ipa;
> > > > +       u64                             raw[EVTQ_ENT_DWORDS];
> > >
> > > Consider removing the member named raw from struct arm_smmu_event.
> > > Compare this with struct arm_smmu_cmdq_ent and
> > > arm_smmu_cmdq_build_cmd() which keep the encoded and decoded versions
> > > separate.
> >
> > I had a similar implemntation in v3 [1] but it was decided [2]
> > to keep the "raw" event array within arm_smmu_event itself. Since
> > otherwise we'd have two variables, one pointing to the other when they
> > have the exact same scope and lifetime anyway.
> 
> I understand that the concern in [2] was that "one [is] pointing to
> the other". At the time, I think you had a pointer in struct
> arm_smmu_event named raw, and the feedback was to embed the raw event
> data in the structure instead of having a pointer. What I'm proposing
> is to neither have a pointer nor embed it in the struct.
> 
> >
> > Do we have a strong preference here?
> 
> Not a strong preference, but I'd prefer to have the raw event and the
> decoded event separate.
> 

I see. So, do you suggest that we should have the raw print as it is and
then the pretty print separately like the following:
---------------------------------------->8------------------------------------

	while (!queue_remove_raw(q, raw_evt)) {

		arm_smmu_decode_event(raw_evt, &evt);

		if (arm_smmu_handle_evt(smmu, &evt)) {
			dev_err(smmu->dev, "event 0x%02x received:\n", event->id);
			for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
				dev_err(smmu->dev, "\t0x%016llx\n", raw_evt[i]);
			arm_smmu_dump_event(smmu, &evt, &rs);
		}

		put_device(evt.dev);
		cond_resched();
	}

---------------------------------------->8------------------------------------

OR should we pass the raw event to the dump_event function which, I
believe, is a little duplicative:

---------------------------------->8-----------------------------

	while (!queue_remove_raw(q, raw_evt)) {
		arm_smmu_decode_event(raw_evt, &evt);
		if (arm_smmu_handle_evt(smmu, &evt))
			arm_smmu_dump_event(smmu, &evt, raw_evt, &rs);
		put_device(evt.dev);
		cond_resched();
	}

---------------------------------->8-----------------------------

> >
> > >
> > > > +       bool                            stall;
> > > > +       bool                            ssid_valid;
> > > > +       bool                            privileged;
> > > > +       bool                            instruction;
> > > > +       bool                            s2;
> > > > +       bool                            read;
> > > > +};
> >
> > Thanks,
> > Praan
> >
> > [1] https://lore.kernel.org/all/20240928005143.2378938-2-praan@google.com/
> > [2] https://lore.kernel.org/all/5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@arm.com/
