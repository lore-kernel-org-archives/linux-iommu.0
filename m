Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98D631
	for <iommu@lists.linux.dev>; Sat, 25 Mar 2023 05:42:59 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id n14so3472644qta.10
        for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 22:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679722978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3byBldZMX6xbfG7sUM+dVzUuY7QBX3hRaMSItcVS8x0=;
        b=o+Y+NmsMhBx5QbyhIDsTsaSV3oupra1EaE1h742VyERrxACn31ZtbjP77DDjFq8unu
         o2hXVhDDsNuLO/AFJ9RGvbUtYLEvWzsO1/LXOdy2JTGEfLAaaY2+K38L1GxnXJ4OME1F
         LoS8EGCLXJaCz3wkG56mdKqgGnkxBkyFb8lQng2Kxu6C7U30GKa73vCOHdoq/ZIRfIiG
         8wajGsV+UzWKZ/CCNUWyijQzWNHxdYsmY/6NK6WbjGUvk4QVsAWBPgYIqUuidP1bM7R/
         de+pIxywnxIgLU4XL3Vjap75XFa0w7XDcUjKoQB/B6fHiUms7lRQDwzrOtok8reT8MZh
         nIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679722978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3byBldZMX6xbfG7sUM+dVzUuY7QBX3hRaMSItcVS8x0=;
        b=234D009E6kOh6+VlPRE0vsD1ylxwunI4a7hE4hW1DvMuV4RctCMYehyp3miuyuM6uS
         aZU6AGqI0SWiBh2Tmyo9EME3Hcy9YmVFgMHh3Gw/a3jWRdd447DvZtUzVagH+8LOiewV
         ztjs/d+8VuX7fkuh9RpZBZ3ycXBIqkrCp8t8jGN20KygjyueeElKxf79NgL7bG11Wmei
         7/5H+vnr2ED5hl5tQliEvFlqkwqVl9UlGLP8zJyFHJuKVEteQAY/FOUAT0wqQdwYmewi
         BGy0pTmO5M4F6xSCWx8xdYHDdfrlyerH5w3GsTfY6Gm2xSezjTtemu+wyZ6tOgZi6C6S
         FbJg==
X-Gm-Message-State: AO0yUKUk1swnHjTf1gKcwzOhn4NoKowofuN8ksnYAUqYMOUxvX62WZu3
	9xX/d5MDHoFAqtg04qzABlYfVhicRhYz+U6WJuMo+A==
X-Google-Smtp-Source: AK7set/cxmqpEIN+LcB1MuLZGruxQkZPbC9oAtc3fsM9N0sexWgcqe+2aOfpnp340YqdUlwIfPyAjodQho8Ce1pRdR4=
X-Received: by 2002:ac8:5ac5:0:b0:3e0:c7f7:cbce with SMTP id
 d5-20020ac85ac5000000b003e0c7f7cbcemr1854994qtd.9.1679722978542; Fri, 24 Mar
 2023 22:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKHBV24u9b-=cJCF=Kt=3B4hynOyNr6gmi0F6zpO6b1mHc0Z7g@mail.gmail.com>
 <20230324123125.GA1061401@myrica>
In-Reply-To: <20230324123125.GA1061401@myrica>
From: Michael Shavit <mshavit@google.com>
Date: Sat, 25 Mar 2023 13:42:22 +0800
Message-ID: <CAKHBV25_hJU3xgSt3=xt7LgoF=15=jwo9A_8z9A5yi7-CZk2Cw@mail.gmail.com>
Subject: Re: [Design] iommu/arm-smmu-v3: Implementing set_dev_pasid for other
 domain types
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Will Deacon <willdeacon@google.com>, robin.murphy@arm.com, 
	Daniel Mentz <danielmentz@google.com>, John Scheible <johnscheible@google.com>, 
	Mostafa Saleh <smostafa@google.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 8:31=E2=80=AFPM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> > As a first order consequence, when multiple devices share a domain:
> >     1. We=E2=80=99ll use more memory than we would have before.
>
> I wonder if we could save some memory by reducing the allocation size for
> single-entry context tables: it looks like dma_direct_alloc() gives us a
> full page at the moment even though we only need 64 bytes per CD
> (and S1ContextPtr alignment is 64B).

Oh interesting, I can give that a try. I'm guessing you mean by
allocating from a pool when a master with ssid=3D1 needs to allocate its
cd table?

> >     2. The SMMU will perform dma to distinct CD tables to find the
> > page table; however the page table itself would still be shared.
>
> Yes, I'd expect this to be negligible since an SMMU would cache the CD
>
> >
> > Is that acceptable considering some users might not need the
> > set_dev_pasid support this is geared towards?
>
> That does sound like a nice cleanup. When I last looked at this years ago=
,
> there were two cases that shared a CD table between devices:

Awesome, thanks for the feedback Jean. I'll start drafting-up a patch
series over the next few weeks then.
