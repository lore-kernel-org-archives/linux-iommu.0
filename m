Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46337F01D
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599453; cv=pass; b=mfux6YUk254omqVUi2pgqdyPBR6DioeUchnG+PliFCnPRQMV1UHfAaz9GJafijeqoBfqP337BL8PU3mfui+plp2YkPC+MpsQe8mOXPil6AkrwLn2OmUZaCKxpO9nwe03vQeLhiAsBrGWpaeY88y7lUiH8MW2u4GWZXAy+6hm8bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599453; c=relaxed/simple;
	bh=J0ok1UgS2bPn5V58cGyuMXbk6aARtIyxbOkZy2VAM2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJUo8ZAHqTYvzzpqUnrosjemXc0kcr8ZwvMSCjZzSmropy8H1UTPbFRDhkYrE9JDj9Qg/PgPCRVbqnT3fn6BlL09kNXXEERt8UbYhcTC54KM+zPAjb/jd1n9SgO2w8d74Dd2JXixjEHiHu72TGhIF3NA/3uoMr6mh37gM3sYYFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=c9FW1cRN; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="c9FW1cRN"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a46260385so54260837b3.3
        for <iommu@lists.linux.dev>; Tue, 07 Apr 2026 15:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775599451; cv=none;
        d=google.com; s=arc-20240605;
        b=PTXfZ/8o4O08ea9k5kSBNdVXNJuSbiWRB+QPyKZmC5/h3q2P4PZc4XIvQ1cglh7hv6
         +l7usDLAArmyDl3IPd6OtIjb74dpzdsJ71js1C7rjRqPIIaXTVH5SRVWQr0nom20a/rt
         zkcNFYHLib8xN2K+xLyKexzs+gvFpMN2A84yeuGLXa9vf9iZ+uh2KdqMuNnGaCwAszx+
         aoj006Adb4H+NOHHz7LScJJ3x/c5chZtYykaRUkc3ZduB5aPBfXdTOy/M6yFGfG0oBTf
         GJgBn9RomV2ZqRCD9Eh6X2uQnf5bSAcnZ3klC/BQh9cgcClO1MDMqLljT2F6miUmcD70
         Hk1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FtPj7Ef85yI425sjR5PAdJDDVT9TZGTbmZEYRDqH1RE=;
        fh=tmbOOK2LvH2cdiK5jzAabQqYCV0x+XSISuYOC++vcrg=;
        b=WbE8/UpG8C2QfH4WBbC3yp0E+n5olqOPzkd6Hz2CWr13W98rpBbbZ9BhHZl5agGaer
         ZB+VRdS7wMVVmslR0ndob6RNvyZG4wyHvXZteG2LgRPb9ZhHgI3RuDr/hdXZN1q28QT5
         O6/MnCNBKuueDMl/wFmFheWfsszmq1LFiWGG/LO7qu0WmNK+zuL6rVa/GCY4w8RROCSx
         AssUOM8IJSp2TNV6wtayvvYvQgYClEa2/eEEV5l9sJPa3OKo3TEQ9pHZ/3RtVZ3z04Dp
         JRsrTI+9m73RPtBhdX5K6cNeS9XRHDeZBpkNP2StRGJIpLEQVOVlYX6KQtipzSPxBejA
         7A/g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775599451; x=1776204251; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtPj7Ef85yI425sjR5PAdJDDVT9TZGTbmZEYRDqH1RE=;
        b=c9FW1cRN/u9F7nZm52prNJa2rrWJQcDg3IT6Xu50k5tc7OSpKDQo66JLYvyacJhQ5e
         j6pyEJy0wE4IBzQoim9LNnjgxoF669fgygxZVAso6O6aas9sOoUbXrfFHqG3orS9EFOz
         7PL/oijSQ5vVxHEh1P5vq95PqY4HrpkoC+E1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599451; x=1776204251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FtPj7Ef85yI425sjR5PAdJDDVT9TZGTbmZEYRDqH1RE=;
        b=EZKNkXE5TotKs0sr2aFZLpOa8ifuQvQvm9QjMdBoETzZBiUEflToXnuRGjBf/8ATrz
         z4rGWjbpovND6f+P63m9P1+uw0eTqE1FpMxH3E5EIgiE1+N7Lx5QJzvs7ippVpJ9+kGA
         +cfscjdcirnzZw2wiKiX0bVxlSooiUBOBKOqXDTLoTm5sZWO9USHC4XTu/FW3mvga5gS
         r+/RGcsBoZEg129Px7NDlAvyMZINLEgTc8RUj5Zy3eDWYes5FiHL2Jff2+5pD+A01bgj
         aM5VnlnHSFeS7soBrWA3uzSjN7mkbZi75LCX8EA/7CedmIwQ/yyUP53Rget5KBIEjuMO
         AiPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3P6nGMKDYOMHHlfBw0bNhwFYc+/LsejEiEW178cJN3TVvKufFKfmp0uD1e1n5ahqZ/AttbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYoD1D8FAyxpP1LSAw4RMxvb7S67PhAgvUQPar9i7OgHvQ10l/
	YdFpiOXoVz5WysAHABJ5bQ7nDeP+9/QDmA+F0jOwFnIOq5akcdF2LP0oDpQPO1WygN54EcAc+pA
	LaoJUsSrU+hrfyODcIP/FoZpSRDm6dvJhu5cQjszFIw==
X-Gm-Gg: AeBDiesau1HsoBFMDR6pBZ6lEBWBjHPRkbjCEkV34RFWNlpRVgMqYfJmMh73IuQMV3R
	tNzoH8q1B151Pt7YXUWE7iRFlmo41cbIvpvimlKO3X8dMC7P0k6PjfClm/dK2kc5ez9XYQP5SCz
	UD+Bvdoq4Jj2k7L1tvtt/ZWswHc1XoWJRxP7uNfal39mbzvZMlJK7+QGPu1wEf+gMoPiP45BGAy
	AJC8nnVEldwzsvdvuLeKLnwYFLLQkuVTfyKkBbRTwFDwFRPCyucoLSxFEdsTpjUmWH2xb1LPwhY
	T15HQJjQOLuRygeWPmmFZTcwJVQiof5K6aPLZTdNQ1uhJInGazc7tQgJlbelV9SLc7T0MWTh68M
	XylelaStP8wGjwATeHGjfSxUzBsB5yuY6SwjITMKyusL+zyuguB4ftFvpykMqos0=
X-Received: by 2002:a05:690c:6891:b0:7a2:4cdd:6b22 with SMTP id
 00721157ae682-7a4d5f5389fmr191889267b3.39.1775599451147; Tue, 07 Apr 2026
 15:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
 <20260407011210.GM2551565@ziepe.ca> <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
 <20260407012726.GN2551565@ziepe.ca> <CAAJpGJTNKxCfcZxgDj_sZYUozrOe=vxbWUUi4PVwdfvGx=WEfg@mail.gmail.com>
In-Reply-To: <CAAJpGJTNKxCfcZxgDj_sZYUozrOe=vxbWUUi4PVwdfvGx=WEfg@mail.gmail.com>
From: Sina Hassani <sina@openai.com>
Date: Tue, 7 Apr 2026 15:03:59 -0700
X-Gm-Features: AQROBzAnPVkw7OB8rG_YeO6I6vQFGrIE_41cIYIVP5BqIXerL2I7kB4wz6TnJ9U
Message-ID: <CAAJpGJT4YyvoT88qVJ4oLmWQXG8GfnGQdFSTXBmHh7X2v+kHsg@mail.gmail.com>
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly ping

On Mon, Apr 6, 2026 at 6:40=E2=80=AFPM Sina Hassani <sina@openai.com> wrote=
:
>
> On Mon, Apr 6, 2026 at 6:27=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
> >
> > On Mon, Apr 06, 2026 at 06:17:24PM -0700, Sina Hassani wrote:
> > > On Mon, Apr 6, 2026 at 6:12=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > > >
> > > > On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:
> > > >
> > > > > io_pagetable *iopt, unsigned long start,
> > > > >                 unmapped_bytes +=3D area_last - area_first + 1;
> > > > >
> > > > >                 down_write(&iopt->iova_rwsem);
> > > > > +
> > > > > +               /* Do not reconsider things already unmapped in c=
ase of
> > > > > +                * concurrent allocation */
> > > > > +               start =3D area_last + 1;
> > > >
> > > > area_last can be ULONG_MAX so this literally overflows to 0. It is =
why
> > > > I formed the suggestion I gave as I did
> > > >
> > > Yes, in which case the  if (start < area_last) that follows will catc=
h
> > > it. Are you suggesting I compare against ULONG_MAX instead?
> >
> > iommufd does not have any overflows to 0 and rely on it tricks like
> > this. You should just compare to the existing iteration last
> >
> Just to confirm that I understand correctly, like this?
>
> +               if (area_last >=3D last) {
> +                       break;
> +.              } else {
> +.                      start =3D area_last + 1;
> +               }
>
> > Jason
