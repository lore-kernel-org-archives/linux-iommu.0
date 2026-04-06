Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15E336EE1
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 23:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516858; cv=pass; b=ot3iobNaIhagkjYItfepXnIbz6d4bvoAPtLpW9dgjWAg8RkvT8FQcJ55jCSW2sCCIl5NDrXjxiiY0NzPYqhL5JEmq1+F07iCbQbDMFhcpieOhIHPwGeCeejnkY8UNlFV9EOYXtBTGHUiRsawvAUwRQdoN5COa9uEWl245TnTmkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516858; c=relaxed/simple;
	bh=f9GmValrmhOWiwWMx0EWjyv9yPicU1uiSH27G8XHZ1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgjNFbePto8xq4Q5hJV8a5QwWGbjAIyqG/jO4SSAV9GP80rO7T0DocY84p+6JgSzP/JXuekKf6b+i1S3yAI/leZoayKUmHbr5NfNrYFKwvrfaB7UayQKV0sexcZVuylH/45GHtyBqS5mLOWCf6qpvgrg2uZioFHGXPGzkqYaEXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=QHaxwZ7b; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="QHaxwZ7b"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7927261a3acso36971047b3.0
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 16:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775516856; cv=none;
        d=google.com; s=arc-20240605;
        b=RNWAKpDyOt34qiXz6e5EnO9CyJ+lX7VdLwYDHnGtp4snZQLKYdh5fboaWBku71R3SM
         S+XHimCbWOi0Uoax97/taVI2nhP1cNQOTEDHJ+IPS2UvxxtEsjcYxaPuxgbCDJZ81U0+
         IJ+dk6azZ0z1MXoieaP9QftjI58HI0V9Mt5r5f9YwL49HqS/XQtjK9yQrCaUwSuZ9utr
         k7/7EilUaa2a6KqTVco967tCpOclWHbvP5eV0H/jdyM52Bj03kVFpjVMnkCIA2DBBVPi
         ejOze31K7WT+RkPCPWiVVlmauDogh+6XylOZl2X6iSwmv7leZ8pFDkEKblkTG588pXj7
         Fnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gA0Yacyf4du/VBGxhfihlMdchZvBBnBUviHIV/bu+f8=;
        fh=6qZZOmZHz/aJYU1JxPZqsSUiSV+G087tnh52hRMGUYM=;
        b=JJYTWZYrhDCMvo/yGqodTaO+B6Fn8FCGmkg7Z0JWQUmO2fexgbrx6U8jOyaovUfYwz
         SnRjNRfVxS5zbWIuFc8qHS1l8g3eUsfuC7S67p0VeLtr4QcSbK3vMhGtO5/Vz64vZHci
         lyl/+gAyd8BdFq6mzPNBUBdmPEbpxJvVTPpqZ5MaNk8qiaRqK2IKw1So2Cz0wesDuLQa
         /m5pgVcD8C4HlZprVYWpw7LUjU9T9kwNrh1mOjf5QsqFycCjXbgXdv7OJ9oY8nS708/P
         xDMItHLivDBq+pv5LMvxCJ4lBrRr6MOa7a0RvKv1/9xWDpVELKpKEjByTfrio+GgSnlv
         9CUw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775516856; x=1776121656; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA0Yacyf4du/VBGxhfihlMdchZvBBnBUviHIV/bu+f8=;
        b=QHaxwZ7bg24Oj5cSGi2pRXPbZZanY1aAM0FnvwcepgOIlq2qEv+qoQGM4PS2Rd8teS
         mgA24PmpY+OOjQWqpKmr+6uCUIGklqGJHnFD0i6iVjBC44B5FtvafiekWYZM8/42KWtD
         SmmvY5egsd8/7vpXqUz7Fx+PB9K8z732LqNYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516856; x=1776121656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gA0Yacyf4du/VBGxhfihlMdchZvBBnBUviHIV/bu+f8=;
        b=cn27PHN0JslGgTitAtHfUKNBYNseHgXbzhuQ7YhkLsda2V7pOmqq5PL3EWa+mIZv3d
         Abx5RgoSVrayycozwaK1AF0Oh0gVwxQrTLCy1kJGtUYfxiIrxB82XlGnOlq7djHOyW39
         ZvKgi57raFgDNuaLYuqQl2vqbBsPfIgb+WpJjqgV30RPeDdFSRu1aip8n6TE87VAghSX
         g3PmMAI2WEh/GNoU9Gpj67+E6qrcROsCaFx0EsZqnnvsv923+VoTzvqyS2bUZKpWw8O6
         k5zA/9/lSlVDUVJZf4zz0vmplln3xWgmvrp9cSaYNdQh4MhHN93k7ujMTlkoFTy8diUI
         aHzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnFdyZUMjFX8KD2jzwPD6/WaX/2T3D/q5MToEYqx9CkJHXqPSlwDeCzfG3h5XawE6E94Fsbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDP3d/52yi8rSzvi1esaTt/n/VPQAeJknkkv/9wO1ifPw6drLw
	jTbO0rDLFe4p95DQ06KFkb7uwcXmu+jKZplz1tLE+kwCtAshSSaLJDbbcGiZK7ZZ2RZarbgcAR2
	90NDIRXEKtqzNvIUGmmlK1+OkGvh7wLaDaDD4ghLucQ==
X-Gm-Gg: AeBDieuoeMJuO0lnkvRtrxnXfXekFQV08JmE5jX6AwLEncqO3k55/ptaw5RXtn875pf
	H8UT9kyE0fXvMc8QkIp437964Wl3EXzQ9TbhxBX6y+0EU4r+fFyB9oykKfJMXZrAefljAXTk1yG
	MZ1SEkhwKMir8S9pbqI1NU3yUvMtlYT56TbGp0QY2pY/3Xutqy0aVnZV+3rBgepBtm54zaj5zFG
	ob+HJnbcv3Q1XITr6UFJVEctCC8IUwolb4a0jkMSButltCLG9ZdKcY3jRj5NwX3gdJLd6tDiI4A
	5zh7ZBmkj26MBuAbMpxtZKhHysHOI9fDje9igzNbIRLI4+KyvLQq66xsI8+P2yiBk/idzm/8VCO
	IoVyq9ZS5U83QuWzRk4t84hn3q8eVAE2bS1zF5KTWbnnoPObu3bHUsquwMuufvTg=
X-Received: by 2002:a05:690c:19:b0:79a:b46c:e60a with SMTP id
 00721157ae682-7a4d8db073bmr145384387b3.44.1775516856254; Mon, 06 Apr 2026
 16:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAJpGJTzJZ0OgEU8NhyJ3dR1Y1V5x6CwbBjLW_kYLu+FTt9woQ@mail.gmail.com>
 <20260406221743.GI2551565@ziepe.ca>
In-Reply-To: <20260406221743.GI2551565@ziepe.ca>
From: Sina Hassani <sina@openai.com>
Date: Mon, 6 Apr 2026 16:07:25 -0700
X-Gm-Features: AQROBzDCxn9K8JeiKcrx3s0AoD0G54QL3yvv-7cfxuIx0UsddxRYRS1TosoShE8
Message-ID: <CAAJpGJTBy+6pAr8s5xGZerbCaoybF8v-_ZSzdHkfjt_o-iPcAw@mail.gmail.com>
Subject: Re: [PATCH] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 3:17=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Apr 06, 2026 at 03:00:36PM -0700, Sina Hassani wrote:
> > Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the l=
oop
> > body when getting to the more expensive unmap operations. This is fine =
on
> > its own except the loop condition is based on the first area that match=
es
> > the unmap address range. If a concurrent call to map picks an area that=
 was
> > unmapped in the previous iterations, this loop will try to mistakenly u=
nmap
> > them.
>
> Does this mean you are also using the automatic IOVA allocator?
>
> It is certainly an error for userspace to be mapping to IOVA that is
> under concurrent unmap.
>
Correct.

> > io_pagetable *iopt, unsigned long start,
> >                 iopt_put_pages(pages);
> >
> >                 unmapped_bytes +=3D area_last - area_first + 1;
> > +               start =3D area_last + 1;
>
> This seems like a reasonable solution, but area_last + 1 can overflow
> and that needs to be delt with too.
>
Good point, done. I sent you a v2 patch.

> /* Do not reconsider things already unmapped in case of concurrent alloca=
tion */
> if (area_last !=3D last)
>    start =3D area_last + 1;
>
> ?
>
Done

> Jason
