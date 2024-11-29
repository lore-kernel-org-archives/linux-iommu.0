Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879D19D07B
	for <iommu@lists.linux.dev>; Fri, 29 Nov 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885003; cv=none; b=rhJ/VQArUnG8ZV3h1id7ZcTzUoW5hYUiql6ghgqVyXmN3eQ/cV6KvkxqZ2d/XhAmAowsiRn+F59zLLkV9tyAWOld+dzyyzrfDBYVDm8VA/vviPBau20i0TeSzKzV+NZCfUlB0LAnETa+BGgVGoeBUhKPn18u2RcoQ065x/tlkOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885003; c=relaxed/simple;
	bh=aFOTinN8XXnmG6MjJIoWrFa8vtgrKo7N1ugl+WyvceM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVuc8u2XY+WECe/2Gnoe6Bt2cqKwoRif1VJHkTZatlTu9BXo7hBxDyj9pwSKJ4QIsSr8hmUazqufdtKPvqbeN4c5p4hO8gbhaz0JbRPtRlsT6nns85Efwd0fq4g8dGY00j3ocZ04mHBnB3YwfVX3zf2DtJEdqSpTwF1zo+hx2tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wvfDGf3m; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wvfDGf3m"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-211f1a46f7fso193765ad.0
        for <iommu@lists.linux.dev>; Fri, 29 Nov 2024 04:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732885001; x=1733489801; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N4/YcHEUtpy79vFpDuBIbCNlhL4ueObsuMvu61tXWJ0=;
        b=wvfDGf3m3ONl7tX37BCT8QKKI3vlNGgbXhHXIJd6hgLr+5g8o5sZTRvGiOX9a+9yQ0
         XEgL9DHcbVkFZDF1LRzFCLiYsN7PM/KSicW79h4FeioxSAdmuRHWeO35yQ9p7O31/5j6
         9ABS5LwJMo82b7kv3EakHZgMuD69qanjPPcjkgcrqzjz6qfVhxkH32Cth/+TsJRayKGT
         hghV4UeeFPdPEvoUSbVUAKghOWGheh2z345YfeesPJB1WKXzXAhxgjSkxfq6hMWHsbg3
         p5WcsL/pbIhNSMbABZkz4ij9NRxaF51OEEBcSoPWJyoqVYIM39BTLSqTDnJf0LHS9YSS
         Ujpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732885001; x=1733489801;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4/YcHEUtpy79vFpDuBIbCNlhL4ueObsuMvu61tXWJ0=;
        b=k0HvfPEnUOdEm7FRVmJzsKf6M8krr8ujx4Y6c75/z+r8XB34naGAFIEs7KWnwaB19B
         g+DmX32PtwqSkdwGICoiNQZ5uS2xtDbnkb5+WvRDepET4+fnkgu/0oA0RJ4fhWNnibGp
         2j5Z3DqZpXYdj2QPlouf8X8Y4RQ0k+Ojd60s6k8JH/x7VthofaMB2cTsFgCsA3IclRoV
         AaII+KxMv3OZIRvlkHdXzmwC4h0/XU138P28Hnu7HjNAD78tSVu85IMf0YXm7Pd6l29q
         H0n9XvDFdOBaqjUVlC4ca5FB5RkF+o7xpvAmz0RJkvZadIS4jnnhKEMvJhXczAS4hfv9
         QBAg==
X-Forwarded-Encrypted: i=1; AJvYcCU5jFAweuCBG5LIXRn+MdYHJiQ/6DTgGqC1gRS+NYe00UPS09xTygJa+vVcGnfkRObNWNagvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwB8/9mcoTPMPqOnp9/gkClM2h7NU8oKNYQcKOUJeOiM901oUI+
	PXRuxGUdVikdT13PhQNQgG5ykX/HrSi4c/7C3CoHcqJj4ZFdmijpXM/W4XpZZRmNrveloehRcS+
	3vQ==
X-Gm-Gg: ASbGncsC6Ex62FGsu5Xckx5JAAzjXSFm0ElckqbResWRRImtUUPpqbcsHLc5/midjte
	F714Ahsd8+9X9jn3bnNO8RQAEykyg/0t4a9PwwjDNNQgveOrSwN1H1Vwk9NvrV8oFLO/7jcw/bX
	HBfo7Gegq/9xAPT0rLHd8LBcQebdXKRKIXgyTVq6Sa76i19IdsXT8ownrppOiSU6sFw1lzf2xmV
	hvjd8vcPShFIzEokPNzfCax+HugGxOQthkLohn5MB5RgHYqJZr+uFeAESJOYdy2vSweb8895MCF
	ZnqKWyHLr0I=
X-Google-Smtp-Source: AGHT+IHg5VkZMmbl7UmrsSDnWCEDPjHxmhpJ41v1YpWqd/8EOfFMrPie2qq4rMkk4+uQjSKhqZYU9Q==
X-Received: by 2002:a17:902:cf42:b0:215:367f:2967 with SMTP id d9443c01a7336-215367f2b4dmr1990585ad.2.1732885001240;
        Fri, 29 Nov 2024 04:56:41 -0800 (PST)
Received: from google.com (104.132.143.34.bc.googleusercontent.com. [34.143.132.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541849509sm3363210b3a.197.2024.11.29.04.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 04:56:40 -0800 (PST)
Date: Fri, 29 Nov 2024 12:56:33 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <Z0m6Ac5Ch5vTLl03@google.com>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-2-praan@google.com>
 <CAE2F3rCO1PbzMEdJB1zRFK+FsbYa0w2TWrGL-XV6y9A9vrqytA@mail.gmail.com>
 <Z0blg7wbWr05qp3w@google.com>
 <CAE2F3rA1g7+KoOAjr5CUnD14zsnmnDxmW2KSpVZmdtzoA8ggrg@mail.gmail.com>
 <Z0eGtoLovKLBml6R@google.com>
 <CAE2F3rBgxk_Ma_xOJcaqJ2XiPiQbJhGe+jHZNT2USqaTX7DGng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rBgxk_Ma_xOJcaqJ2XiPiQbJhGe+jHZNT2USqaTX7DGng@mail.gmail.com>

On Thu, Nov 28, 2024 at 03:40:51PM -0800, Daniel Mentz wrote:
> On Wed, Nov 27, 2024 at 12:53 PM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Wed, Nov 27, 2024 at 11:42:11AM -0800, Daniel Mentz wrote:
> > > On Wed, Nov 27, 2024 at 1:25 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > > > > +       event->class = FIELD_GET(EVTQ_1_CLASS, raw[1]);
> > > > > > +       event->iova = FIELD_GET(EVTQ_2_ADDR, raw[2]);
> > > > > > +       event->ipa = raw[3];
> > > > >
> > > > > Shouldn't this be
> > > > >
> > > > > event->ipa =FIELD_GET(EVTQ_3_IPA, raw[3]);
> > > >
> > > > No. For this, there's a reason for not using the
> > > > `FIELD_GET(EVTQ_3_IPA, raw[3]);`. As mentioned in the cover letter, this
> > > > was the root cause of the IPA truncation bug, i.e. FIELD_GET only
> > > > fetches the IPA field without trailing zeroes, truncating the address.
> > > > For e.g. IPA = 0xfffff instead of 0xfffff000 which is faulting address.
> > >
> > > I disagree with the term truncation bug, because the information was
> > > never there in the first place. Truncating the IPA was presumably a
> > > conscious decision made by the architect. It is not a bug.
> > >
> >
> > I'm NOT claiming that the HW or architecture has a bug.
> > I meant that SW can't ONLY look at (and log) bits 51:12 only which the
> > `FIELD_GET(EVTQ_3_IPA, raw[3]);` does (the values I've shared in the
> > cover letter are actual values printed on QEMU). If we'd wanna use the
> > `FIELD_GET(EVTQ_3_IPA, raw[3]);` then we'd also have to shift it by 12.
> 
> I believe that using FIELD_GET(EVTQ_3_IPA, raw[3]) and then left
> shifting by 12 is the correct approach. As per the Arm ARM, software
> shouldn't rely on RES0 bits being 0.
> 

Ack. Looking at the G.a version[1] of the spec, I agree with this.
Apologies for the confusion!

I'm planning to take the raw[3] dword, mask it appropriately and store
it in 2 different members, ipa & fetch_addr: 

	event->ipa = raw[3] & EVTQ_3_IPA_MASK;
	event->fetch_addr = raw[3] & EVTQ_3_FETCH_ADDR_MASK;

This way, we can use either field as required and not clobber the decode
func with if (event->id == 'a' || event->id == 'b' || event->id == 'c').
Allowing the user to use the appropriate member  as necessary.

For example, in the `arm_smmu_dump_event` we'll use event->ipa or
event->fetch_addr as per the `event->id`

I'm slightly against the `event_id` based checks because it may not
scale well if (in the future) more fetch faults are added.

> > > >
> > > > Since the SMMUv3 spec ensures that the bitfields NOT representing an
> > > > address, i.e. fields other than GENMASK_ULL(51,12) or GENMASK_ULL(51,3),
> > > > are zeros. It's safe to read the raw[3] dword directly.
> > >
> > > Somewhere in the Arm ARM, I found the following language:
> > >
> > > "The RES0 description can apply to bits or fields that are read-only,
> > > or are write-only: For a read-only bit, RES0 indicates that the bit
> > > reads as 0, but software must treat the bit as UNKNOWN."
> > > "A bit that is RES0 in a context is reserved for possible future use
> > > in that context. To preserve forward compatibility, software: Must not
> > > rely on the bit reading as 0."
> > >
> > > As it stands, I believe the code relies on RES0 fields reading 0 which
> > > would violate this rule.
> >
> > The fields I'm talking about aren't marked as `RES0` in the spec. For
> > example, if we look at Section 7.3.4 in the spec, F_STE_FETCH
> > *explicitly* marks non-address fields as 0 not RES0. The same can be
> > noticed in sections 7.3.10, 7.3.12 - 7.3.17 & 7.3.20. Unless I missed
> > something that mentions that the "0" fields in event records are RES0?
> 
> It's RES0 in version G.a of the spec. It appears as if Arm changed
> that between versions D.a and D.b.

Ahh alright. I was referring to D.a version. Thanks for catching this!
The G.a version clearly marks everything as RES0 which can cause trouble

Thanks,
Praan

[1] https://developer.arm.com/documentation/ihi0070/latest/
