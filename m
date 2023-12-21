Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961359477
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 05:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="REnYVLxe"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7810992c613so30005985a.3
        for <iommu@lists.linux.dev>; Wed, 20 Dec 2023 21:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703137398; x=1703742198; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ+7iBxo9UNCq3UACj5AX8FQW70FsoHbqWsLyZj82EA=;
        b=REnYVLxe9qTWn6gj/QkUg+r5sG/7JFeRNwdFd9XaW5t9eHJZYnf9sgVnH40B8CjyhH
         1RMX7f+tTeypgb2zx2EGMmN1CYCqJ2++GEEXdGSi7h+EjITrf0Qi4rflGofQWNsoHmbB
         S0AJD8z899ZFp1tf3pVcWJQWDwlm7XXLqQMQphXuISSvQSr0c7OyxWiEMcE7q21++lnY
         FLdRDQMl51BD5fVELfRqSt7z4+q1RPUMLy36xgoSlopkPTx3UjzD29wyarWpxO6wkFCW
         3jl/RsGRO0AQ4pLI8+QWcIN9Bj0ghgQpJuY2C+7NOQ3FeAFLo6uQ2ID2cvPyL2N10vfY
         Kuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703137398; x=1703742198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJ+7iBxo9UNCq3UACj5AX8FQW70FsoHbqWsLyZj82EA=;
        b=tQ3+gYVQyBzzsSiempNyYUtj0sWla2HuQrm87A0bVTCqPyPaO2NZoW0+GeyprcZNhV
         3r2eB8k/7Tn7t4+P60bg6VCTzIHB4cTOqVROQ8/8TJXlgsxM2zBlVJpSdhqCLxttBh5t
         wRtviACKJhbGU7dkLzkm0+lP4qD+pPwqCZJGoTbnvtYzOqMyKlbvooxK1eSEqCqlHBZl
         V3RHWqg2D4flHAMXnRP78Mtze8w8VmAh8uwOVH154ymCe5l7rT4JzOVAh55YvjJ4Na3X
         +CRbt9uyos7MpW/hKPa9J9RmBk0EMwNEgsOkFgQykiWBIOr5A/nNooOQtwJsODdcN82w
         /5OQ==
X-Gm-Message-State: AOJu0YyYz5Dq8iT9rztrBz7tsb2DGd2r1k1GzJUR9/SUYe17Hr7Ft7W5
	NDDdGXnHoWKeAFEj6C3SidsqSWJHFYK5zZ8UV3tEHQ==
X-Google-Smtp-Source: AGHT+IGNTma27AOTaiFA00vgHacTFo9EKx6mq0wCyTNP+SSrAwuhug3Cmgec+ueQwp7aSP6EkRkWH5adx8HhrJdS1AQ=
X-Received: by 2002:a05:622a:45:b0:417:fe9c:6dce with SMTP id
 y5-20020a05622a004500b00417fe9c6dcemr28795825qtw.25.1703137398455; Wed, 20
 Dec 2023 21:43:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231221031915.619337-1-pasha.tatashin@soleen.com>
 <ZYO8IqiHeqs8LktJ@casper.infradead.org> <CA+CK2bBJuZPF5yC2Axo0S_P4ApjwgBWu9YwnDo+yOiOiL16Bhg@mail.gmail.com>
In-Reply-To: <CA+CK2bBJuZPF5yC2Axo0S_P4ApjwgBWu9YwnDo+yOiOiL16Bhg@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 21 Dec 2023 00:42:41 -0500
Message-ID: <CA+CK2bAHLpRWJfHCAPzAjSzF8Hue1wK_SW5GxSue9rOW6OtT5Q@mail.gmail.com>
Subject: Re: [RFC 0/3] iommu/intel: Free empty page tables on unmaps
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rientjes@google.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:13=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Wed, Dec 20, 2023 at 11:16=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Thu, Dec 21, 2023 at 03:19:12AM +0000, Pasha Tatashin wrote:
> > > This series frees empty page tables on unmaps. It intends to be a
> > > low overhead feature.
> > >
> > > The read-writer lock is used to synchronize page table, but most of
> > > time the lock is held is reader. It is held as a writer for short
> > > period of time when unmapping a page that is bigger than the current
> > > iova request. For all other cases this lock is read-only.
> > >
> > > page->refcount is used in order to track number of entries at each pa=
ge
> > > table.
> >
> > Have I not put enough DANGER signs up around the page refcount?
> >
> >  * If you want to use the refcount field, it must be used in such a way
> >  * that other CPUs temporarily incrementing and then decrementing the
> >  * refcount does not cause problems.  On receiving the page from
> >  * alloc_pages(), the refcount will be positive.
> >
> > You can't use refcount for your purpose, and honestly I'm shocked you
> > haven't seen any of your WARNings trigger.
>
> Hi Matthew,
>
> Thank you for looking at this.
>
> Could you please explain exactly why refcount can't be used like this?
>
> After alloc_page() refcount is set to 1, we never reduce it to 0,
> every new entry in a page table adds 1, so we get up-to 513, that is
> why I added warn like this: WARN_ON_ONCE(rc > 513 || rc < 2); to

I guess, what you mean is that other CPUs could temporarily
increase/decrease refcount outside of IOMMU management, do you have an
example of why that would happen? I could remove the above warning,
and in the worst case we would miss an opportunity to free a page
table during unmap, not a big deal, it can be freed during another
map/unmap event. Still better than today, where we never free them
during unmaps.

Pasha
