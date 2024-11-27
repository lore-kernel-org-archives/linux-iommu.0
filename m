Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D277140E38
	for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736547; cv=none; b=u8G8M+XVqGirEhbHk2WwL4SiYoEesEf7NIISTV/uPGQNF1URKQ1ALDWZfHUCFf1QXEB/BIRImYWAPRVZ7X5Tq0IkWxlpEkI7Ob+so1jmGaDj+ITDGB8GoD7lTUpgxcWfZ0RrFWl+cEM1srY3GUjz9O+Hub5Vv3iHDTzRuwgBFWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736547; c=relaxed/simple;
	bh=nQBeZZfVEyE5T7a13BM5ThC3bsTr24DIEoYo1p1Dsb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8tS1w622yBlQk5W49rJkRNlgz7beBtwrVaUEYd3yLHyCSCqm1zJKtOSngfFW/zPnXL4zSYDEALTErbbhS/VP8Nrgz097SXfLsidV/CDCKKVzGv8NmARhwQIzFqiBiMw6XAEO984FiRSQbWKgKnHOYeDl4iiLMwPAg2zUmqNf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wxFkftQL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wxFkftQL"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so675a12.0
        for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 11:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732736544; x=1733341344; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGaymKGpjDhRe2M4vRbKF6A7olhLc2Ew2DDMX2Le+Zs=;
        b=wxFkftQLIDIOAjeQVWI2+lpW67X65OkQGeFTvzW90ah0tTcXsaaa+O7qu9CDkfQyXL
         RJsY1tqWlYOIIoMcQy0KEoZK2NSko8d9Eqh3Cs4u/gViWz4wTGPaKCrQPEQZ0RKeJyPd
         lBZ97KlHqqGkMP+tE6zDGGOcrxeo7q1tYNxIUI5YLDJgp1Gxr9rKOUA3Ig2UByQB9r1i
         bp5h0jcfDJyoO1P4HKH5g7zBXD+9vo/k2s6TG+c+tIfMfJaNZ7Va7ZGNhr/Liv6F1Yx1
         CZazq+utM+zHX6gjSFOF1Z3weTIPIkCTuKADVE1/+2XyrnzuY13K5dGsTpZ/hp8sdSb4
         5kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732736544; x=1733341344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGaymKGpjDhRe2M4vRbKF6A7olhLc2Ew2DDMX2Le+Zs=;
        b=JmB6hFYlKYdryiqQiyp89AdxUf0wAqFbuYpDtRcraalHdq7YxuKop99CBr/+R2EuXp
         aNA5/kE5E6D3pRtIyBL1cMo0jUGfJ5oA+j9mlc2D6tNgs81p0/Tjfq6bkwb/Ufgdt+G4
         cdHDKH5lwqgK3ZijlDixo1L0AJabJlonInrziDAisyGS/Eq1gNPQIw1hO8ZRWuLCOlhQ
         IMyW5DRHgzlpZeTJYgS0TC9wFZuzA2bL/j2fvsvTr9jjiIcymc+D7Pa+k2+DJ435b465
         B0mMlD2mhHMGxmNDQKz1bEyTjKr6nWJ4ymqo6hgmyzQ/TnXq37rPF/WmTjzYEfaUnuwF
         5b5A==
X-Forwarded-Encrypted: i=1; AJvYcCXd3plwzyUxD2fEq26slFk/wpDQdvqs0eVnWd3BRosHCipAGxpyNCP5wAhXwCdHYq1p3pROjA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4RC6nZqHIgV9qvG0A7vlmvOhAPkC8wqP+E83XJMIywyu4JICq
	SPkHarkKAr9c3HntFWWp1XSVSyqlpqML4VpdxO93SD56F3qPJuwuUfJ4/aCmS0h23Dnfor9k0gF
	H1uan88yffsw3GMtJOOxcCtylzDs+CeUq7VX6
X-Gm-Gg: ASbGncsIa1mVaWi0bwi+pZi0/Jzs8oaaJg6MKtROSOm/Ao1q+vAHuIUiRQq31tcTvRF
	p15IfJGsKypd7SFbY05RirvFL/h3kaBK1AR3Uei4XS0y/3t/qKazmCmOPTQYyScSsgQ==
X-Google-Smtp-Source: AGHT+IHPMDB/Xavq+/sBZwQxsLH6/TuWOqNPwUFJKd7JKlHEAeGD8rqUFtfoEW683aUWW4wKNE+UCp7C0D20KhajeD0=
X-Received: by 2002:aa7:d288:0:b0:5d0:3807:bcbd with SMTP id
 4fb4d7f45d1cf-5d09625bfd1mr2926a12.6.1732736543154; Wed, 27 Nov 2024 11:42:23
 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241112083018.1662104-1-praan@google.com> <20241112083018.1662104-2-praan@google.com>
 <CAE2F3rCO1PbzMEdJB1zRFK+FsbYa0w2TWrGL-XV6y9A9vrqytA@mail.gmail.com> <Z0blg7wbWr05qp3w@google.com>
In-Reply-To: <Z0blg7wbWr05qp3w@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Wed, 27 Nov 2024 11:42:11 -0800
Message-ID: <CAE2F3rA1g7+KoOAjr5CUnD14zsnmnDxmW2KSpVZmdtzoA8ggrg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 1:25=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
> > > +       event->class =3D FIELD_GET(EVTQ_1_CLASS, raw[1]);
> > > +       event->iova =3D FIELD_GET(EVTQ_2_ADDR, raw[2]);
> > > +       event->ipa =3D raw[3];
> >
> > Shouldn't this be
> >
> > event->ipa =3DFIELD_GET(EVTQ_3_IPA, raw[3]);
>
> No. For this, there's a reason for not using the
> `FIELD_GET(EVTQ_3_IPA, raw[3]);`. As mentioned in the cover letter, this
> was the root cause of the IPA truncation bug, i.e. FIELD_GET only
> fetches the IPA field without trailing zeroes, truncating the address.
> For e.g. IPA =3D 0xfffff instead of 0xfffff000 which is faulting address.

I disagree with the term truncation bug, because the information was
never there in the first place. Truncating the IPA was presumably a
conscious decision made by the architect. It is not a bug.

>
> Also, since the definition of the field is GENMASK_ULL(51,12) it doesn't
> work for events like `F_STE_FETCH` where the Fetch address field is:
> GENMASK_ULL(51,3).

Using the ipa member for FetchAddr appears to be a bit hacky. Can you
use a union in the struct that combines ipa and fetchaddr (or
fetch_addr), and then decode either field depending on the event id? I
understand that no event type has both FetchAddr and IPA fields.

>
> Since the SMMUv3 spec ensures that the bitfields NOT representing an
> address, i.e. fields other than GENMASK_ULL(51,12) or GENMASK_ULL(51,3),
> are zeros. It's safe to read the raw[3] dword directly.

Somewhere in the Arm ARM, I found the following language:

"The RES0 description can apply to bits or fields that are read-only,
or are write-only: For a read-only bit, RES0 indicates that the bit
reads as 0, but software must treat the bit as UNKNOWN."
"A bit that is RES0 in a context is reserved for possible future use
in that context. To preserve forward compatibility, software: Must not
rely on the bit reading as 0."

As it stands, I believe the code relies on RES0 fields reading 0 which
would violate this rule.
