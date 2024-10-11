Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494E14293
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644736; cv=none; b=qH+ztJNtK9ZxcyKjxr2gjYfIWxI/hd2JV0AWW45+mG8O61gC0gl/U0cCM8xEeWP34z+1xM7vVpUZyFcu70EX2RHOiPf2ABzv0iihEWpu7gLcp9niBY70oIWsrTdOxHpnMNzDGaIhkiRofXAaCGzVQmf7vAZ/FcGisd93q0dyvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644736; c=relaxed/simple;
	bh=6h8GvJLsX+Sl7OCFk+Nar08nJuxRjfgTxwSgImIeTYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qx5TA/P6ywzqcLHfZiyN87hogK7rMU6EQpAj8uM8rFRQEO6dCwdcKOOA3ksG6nQgqqrTMZh9RIkZvPvM7LBqiVvaAlbuthLC9ElCU4s848PnDBIQSJQZ/7YWueDM7muJWfVFr7+WIYsPblqL+2tExOkF+Z3uwbS4TH1U61h0BM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngnxhocB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngnxhocB"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fac63abf63so19719261fa.1
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 04:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728644733; x=1729249533; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kbOpiasA0JVBn4x9cSd301RQLbZlOSTgBQKKdmq+rw=;
        b=ngnxhocBoi1w6E9VyrwzKwoQzpnJyxvQOUjXlAv8i7lcrJP+xr5+i1sz0lyi/RLP5e
         YKYhwRsjd9S4cja0YpWCHbIK9e7/yoPW0dCbl1yidRS5TDJEtcqtZoUSxhWTQ10zJmgf
         wBpSvCk/TGeBd/j3WIEkekZ28hYFVhZY68nJlSAxJ+hUd3u2C3AFxSliX9EOIPNabQiw
         RkiihU8S2uD4xhklGSF+J5AeRFC4d6FmL4wSrShsLfHtb4pGYi2jW6pxpJrBjQRlh2oh
         isonkvUGMoWNsB3UisIzX37z+J3aqUQ7rhE8i563LOT8WSX0Qp9AmT9FR7LxZp+0eSHx
         KHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728644733; x=1729249533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kbOpiasA0JVBn4x9cSd301RQLbZlOSTgBQKKdmq+rw=;
        b=V2dnw6uco2zwTIaxJxMJnpy3hX/bj1nHy9dpLZ8uDm2auED1XI5PQbcRJNV9kP4tqB
         UBvVeaxN2D+e/4S6C+zt51LnLFU2/lWUmBj4KjKcRTj9w2m5kjQl6bceFi1nozHFRyK8
         Er2l8BSLN3wxx/O44L0DV4AGsgpwdKlUWgZrqEZ+PpKB3qkbYQdCCW05eMZCX7IQoQlk
         cao2fFy4s33+pa5WD3VnQiC8cG9gTkB834qW8he3V0rWYslipDv2BFSdXe4ubUfqH+/c
         hY/TLFFEp22dWko0UZw6WDmP7L46TGJiNwp1WTlLlGRWxEPmbHY62sN5ZD6ys9gGqz4u
         wkGg==
X-Forwarded-Encrypted: i=1; AJvYcCVrFwVE7wnpsLEKvfo8I3a0DZV64mZxHYtM1enLp2bcSpaJQ5ycbFS/dui119hbtqzyWb6HWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwV6IKJXoFE+7fGPiUO5dVNZuoX02+YTx0PlSlKToUjowCZwhX2
	Oa2uF6cZP5GIZNm3jB98wgUwSgVIWCyNXNuKz9mKHEhXRR5Sh7uqVOFHUmxFmYA1gbzSSSfAdno
	mhPZILy2ApfZ1H7pzQJxky+YUQF4=
X-Google-Smtp-Source: AGHT+IFG8A1O1crUYuVjiIX6ubtnKN9zIsHPvYsElRhWpf32TC8GUZgVzHZQfooXVAgdqmR/dpUtsZPjbJv9MYuu2J8=
X-Received: by 2002:a05:651c:b1f:b0:2fa:c49b:1106 with SMTP id
 38308e7fff4ca-2fb32b42172mr11064571fa.44.1728644732395; Fri, 11 Oct 2024
 04:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
 <20241007041353.4756-3-suravee.suthikulpanit@amd.com> <cc44a5ca-ddf9-ca7a-93f8-38bf26ac1f1f@gmail.com>
 <7accc5fa-7e0b-4cb1-abc7-debc451285b6@amd.com>
In-Reply-To: <7accc5fa-7e0b-4cb1-abc7-debc451285b6@amd.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 11 Oct 2024 13:05:20 +0200
Message-ID: <CAFULd4b12ytimeSiePmwppyEjQHQMSikHuG2pO7DhxMxwu3z_Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] iommu/amd: Introduce helper function to update
 256-bit DTE
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
	robin.murphy@arm.com, vasant.hegde@amd.com, jgg@nvidia.com, 
	kevin.tian@intel.com, jon.grimm@amd.com, santosh.shukla@amd.com, 
	pandoh@google.com, kumaranand@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:22=E2=80=AFPM Suthikulpanit, Suravee
<suravee.suthikulpanit@amd.com> wrote:
>
> On 10/7/2024 9:42 PM, Uros Bizjak wrote:
> >
> >
> > On 7. 10. 24 06:13, Suravee Suthikulpanit wrote:
> >
> >> +
> >>
> >> /*********************************************************************=
*******
> >>    *
> >>    * Helper functions
> >>    *
> >>
> >> **********************************************************************=
******/
> >> +static void write_dte_upper128(struct dev_table_entry *ptr, struct
> >> dev_table_entry *new)
> >> +{
> >> +    struct dev_table_entry old =3D {};
> >> +
> >> +    do {
> >> +        old.data128[1] =3D ptr->data128[1];
> >> +        new->data[2] &=3D ~DTE_DATA2_INTR_MASK;
> >> +        new->data[2] |=3D old.data[2] & (DTE_DATA2_INTR_MASK |
> >> DTE_DATA2_RESV_MASK);
> >> +    } while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1],
> >> new->data128[1]));
> >
> > Please note that try_cmpxchg inherently updates &old.data128[1] above o=
n
> > failure. There is no need to update value again in the loop.
> >
> > Please also note that the value from ptr->data128[1] should be read
> > using READ_ONCE() to prevent compiler from merging, refetching or
> > reordering the read. Currently, there is no READ_ONCE() implemented for
> > __int128, so something like the attached patch should be used.
>
> Thanks for pointing this out. I will introduce the attached patch
> separately in this series on your behalf as author/sign-off, and review
> the current code to properly use the READ_ONCE().

FTR, for the mentioned patch:

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

for Co-authored-by: tag.

Thanks,
Uros.
