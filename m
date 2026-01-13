Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8061EF36E
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299778; cv=pass; b=ELxyD3sKluE1f01+ZTmVoxpoGtG4I9eyuUHlhm4in1KldG2DYKLIEmVkdH1fFKm6pAYNFqZcIez7m9niz/m9tzXXkVdM7NIHAGZgZHBveOhhogHi1lDdkZrSolYXJuVjvDrxKg7rv8tbUi5WX8kF1UmDb4ogvb3yRKfJo4GjZfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299778; c=relaxed/simple;
	bh=j3OwXXEAmSxRLTGPF30uCuH9V/84AQ8BpwM0oX197Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZ0IHzwgCzOYCZn9JxNToHqat4DTWe9BrepANwa7r17AGqARCgoRuZ6FYGTG5AS4ZhgMvO6uf6BKj7TR3OBGziL2WZ+8Cwj9czNUQSGA1Gk6xTNJkmSYhBbZHkGCIvQ6xMCO6ApzARqLkQhO3Cykraaqx+cdp0c6nwH61llyn7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vN0VIqAw; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vN0VIqAw"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee243b98caso337851cf.1
        for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 02:22:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768299776; cv=none;
        d=google.com; s=arc-20240605;
        b=izniGqbfdJw3MT1aAoCohUUqt5q0LfhA6nOD0pgI99ygEPWVFJ2zbaw6NugIq7sxhH
         ODtOqdukzJvPRHBHTP/iEEoXe18nw1seX9iEY8hypMCLdBecWDteeSPBu+v6Bna/6+yl
         neWRw8uaSIcM9r9SU5u9F9KSuS7QCxcWD0Uin6qBtKRtyUq160QmsREYTL4F8ixm42bR
         sO8DygnVI6Mi6CxxIFFRuFRSrmx1XZ+3DNXc1ybm3gdWcmuaagnZVfNjBODg+W0+q7/F
         k80ccbvGOqTQwL4gFdJujxa1LoH9WCNpXAaD6ORTa1td25JdWNi48pruBgdueG7ODvmv
         JQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O+f//pvo+PKe+VeeiEDq3PkoxP0zliahBI3UIRJy+vU=;
        fh=mIapOUl3nr6UOuEecPzgUS5ss1XKoPhts6ueAJKUENM=;
        b=SPE1GyqxLkfheGfycgeTls6xSGkxpOqnUksTZWPSZvy3Kac4mX/qylYxYdisYP8auK
         fe7lE79mdPfAlOw0rTHi2ggU7pLXQScACeu9pHZ23K4mVRk+mUUTx+IyM3M8Vmkx20pd
         NiSO3JHuu9DdnCSnm7+9aDRWZdzyWSihscjNO6xegcZNATrANBHRnlUDZ/0o3B2r4x/z
         TGfOU1WpH7hP0Ee7COIWDygZCx4hyMrmhFj5aO9xxzvtL1Z8MId3nVTnz9Eqb6iLGKTF
         8X2Z18HZv8RygObfBgS1ISJZI7ZhzFj7nYU/SI811hOp2mEGhjVdYqjKPcc0xszG+IhD
         EE1w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768299776; x=1768904576; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+f//pvo+PKe+VeeiEDq3PkoxP0zliahBI3UIRJy+vU=;
        b=vN0VIqAwKmnA1UgHQxNhriZA804ZBbETZnHNPL0ZjbRvIPQuxBKT4nBlcBwnHEG9R2
         qiY5uRRwgNOwWlNFCUDF7QV0+oqU2w5P9zneG40fpIB4exV0cgo1uNf3kS+iyYZLY/T4
         JUGlkA1uFT2Lh7eLbxZgRF15It5rZ1FjJQpr9PotCDW3AfzFlbUyAYt0fZUmNcdmIu+p
         xfyfZWhF02bOWpolyPZv1gKmJ8iDuhfr5YK6EIgo6zqrN9k6am8t9CS/xweBgg9xH3cp
         bJHjkV0FS/tI7Vva3GvRGZzv3woZFeSTpF+ZZu07BwAO/EhBuxWdQ+ukDgKb4QdF/rSF
         ticw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768299776; x=1768904576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+f//pvo+PKe+VeeiEDq3PkoxP0zliahBI3UIRJy+vU=;
        b=gUeYcvoITgYTcEaMk8FFH1sdSEGYLQjYy8kvZUsFwDf/oLQ4ZPL8/H4qOdsn21asDT
         HmAjsMK180AJkbZUYIXrQ4d170ncrKF23UZQycfiR4AZ1O30g+GY/cv1m22hmVHxfRf2
         asunnpbb893ucvLAO+RhFNXycVZ9BN0kwOBj7UH8m26zOgPcQ9kGOaf0wUX/YTe0vDYx
         Ca+o9VF45Rl9x5lqjQMj0S5IJJKYiAZTGxaRvXR2QIGIoLOLSJHEhcp6LZOb6BF32/1h
         rgZBJAZ4fzP3/0PUDaZj3PB0F4PNNIvEql0mL5rvreLrsqNj/4Zx+EJzRFAckKCgtfJL
         jrIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCB0svv+eVdZ0xQ94oxXxQgRj5MvtS9UhCBR3AgSgi+bw+iyklU96piKcsyNgJUKptiR+IJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2oJFGtyWre29YdUX0AhA4vh2j7SnWOU+8R7H+ZF1VFWvv4ljw
	nCWFqyFRxBrlbO1WrYuvYic7Q+0xSKhFKQFX8n/Dtdb7XCpDDz4HA+OdMQhyX924jK5U+dJa9F7
	wfJ+NPs4K7Ci7k3J8hMzkmC5NKVUBBIZH5mplYk9I
X-Gm-Gg: AY/fxX5+CXYhtTBG8KQppr0GiPxzVaeHkARKoIBXpZL0KxPPseT5xEmpCKgcK4no/CP
	4tN7D7JOPjp97KfkziYA1r2smUxh8J8ibLUYOHYELCUS/AWJisTfHBlUk/jBMOp5tcDGq0aWyjG
	3rRIesRCIN5kQZFaGfhWlufVF2HL4dkKRl6kCJBGn+5XxOjaXFdHAF/kJ8VrltYh30dx3uFDByj
	Wa/vvbmtoy5S0OPPN+uV+JhJAOCeaIUGqTzZoCHGLl3Z+PjNSwnKCh6bFuCd+bFyPzH5p8U+Zps
	Htidp3HkvyeM4r/X9zJeA3qxPA==
X-Received: by 2002:a05:622a:2cb:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-5013af668a5mr7179931cf.1.1768299775379; Tue, 13 Jan 2026
 02:22:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109171805.901995-1-smostafa@google.com> <20260109171805.901995-4-smostafa@google.com>
 <20260109195111.GQ545276@ziepe.ca> <CAFgf54r_au6isA10Nrve=MHL455X=tKhNsSwH1ej-TX08J3xLA@mail.gmail.com>
 <20260112133256.GB745888@ziepe.ca> <CAFgf54psxPrsvujStPNtrzxiKOsJF+aVrN7BcNxxmAF4wDmRXA@mail.gmail.com>
 <20260112135208.GD745888@ziepe.ca> <CAFgf54q+9Y5TtGJDB=8q_BW-0F=TM7zBbCcMzvtvr_N2WMnd-w@mail.gmail.com>
 <746f5adb-1d91-4ca2-8ae0-a2d171203b66@kernel.org>
In-Reply-To: <746f5adb-1d91-4ca2-8ae0-a2d171203b66@kernel.org>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 13 Jan 2026 10:22:43 +0000
X-Gm-Features: AZwV_QgLu7sBxIPXL9VWKxHh4_TpVGZL_EvYu3l8xKSz8ElTbsqiQ8JNqP1h6nI
Message-ID: <CAFgf54pbkfdFr6biE8BiNKBnTBFWxXGmvxsZ0E+C1C44c9AW_g@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] iommu: debug-pagealloc: Track IOMMU pages
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 7:12=E2=80=AFPM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 1/12/26 15:58, Mostafa Saleh wrote:
> > On Mon, Jan 12, 2026 at 1:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> >>
> >> On Mon, Jan 12, 2026 at 01:43:41PM +0000, Mostafa Saleh wrote:
> >>> But I don=E2=80=99t see why not. from the documentation:
> >>> /**
> >>>   * pfn_valid - check if there is a valid memory map entry for a PFN
> >>>   * @pfn: the page frame number to check
> >>>   *
> >>>   * Check if there is a valid memory map entry aka struct page for th=
e @pfn.
> >>>   * Note, that availability of the memory map entry does not imply th=
at
> >>>   * there is actual usable memory at that @pfn. The struct page may
> >>>   * represent a hole or an unusable page frame.
> >>> =E2=80=A6
> >>>
> >>> That means that struct page exists, which is all what we need here.
> >>
> >> A struct page that has never been initialize shouldn't ever be read. I
> >> don't know how that relates to page_ext, but are you really sure that
> >> is all you need?
> >>
> >
> > AFAIU, if pfn_valid() returns true, it means the struct page is valid,
> > and lookup_page_ext() will check that a valid page_ext exists for this
> > entry.
>
> Not always. Offline memory blocks have a memory map but no page ext. We
> allocate the page ext at memory onlining time.
>
> Also, I'm not sure about ZONE_DEVICE memory, very likely we never
> allocate a page_ext for them?
>
> I'd assume both cases are not relevant for your use case, though.
>

From my understanding, in that case, page_ext_get() will return NULL.

So, as long as struct page exists, page_ext_get won't misbehave.

I am not sure about offline memory, but MMIO can be used. We use
pfn_valid() before getting the struct page that we pass to page_ext.
Would that be OK?

Thanks,
Mostafa


> --
> Cheers
>
> David
