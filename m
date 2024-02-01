Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D73B18C
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759178; cv=none; b=hSzw6VvKv83AH3B3gJMR7f+wTeH9+dHXFEOMppDckVp6MubKwgkU6kUzcXCLPvHB0JsnekNL/Ih/dbbt0fH2XsXxU9Wvjb1WK2Bv8VSN0xcoj8VTJ37FWefUXNMf6bRVHw3nYfm+NuCMn8VLz8hUZ9X4XdMpkycU1I7ALfbkucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759178; c=relaxed/simple;
	bh=jLZl2svZauxC4ea4Z0jDZi5dNNmdxwWEhOWyRJ7STJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3qWuTG8z7urmkelRtoTSUA4xTcDa6ng0dG9AuSkaEu4KEo3YydVouMmcmxk6dTEUxgfvsJETO1oV9zd6J5wuZgAWdGEtqSZB8yuRDdTRpPA4BadX8Yvwmnx0FJO6ssB7nfjFNF7lEQJPeMNeJuZqtp/AZr0eetl+4F3Ji/OQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2iWBfiu; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2iWBfiu"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6861538916cso2756876d6.3
        for <iommu@lists.linux.dev>; Wed, 31 Jan 2024 19:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706759175; x=1707363975; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFF8rhKxfnZfXzZDWT495muOJWGnqIPs5LoDZ1rl5gE=;
        b=C2iWBfiuhyYbO5/u1jSGVgc7W21tS0UOHj6l0D0wbm4bDbS0Os3EFyEUF5F6RdzSZ/
         6vn7gtZ5Rone+61ndbIOlkD8tncd2kvjCxSrDqammahYXBzWF9ZU2Mwbi9N/7gUVHlxV
         aKOVAfWF1yL3vFdy+YWQtri4OatUKV3PmjA8U+Z5n2eUJYbAhSwDrVyM188VhAC8ashM
         1OKZ253IFzsepRzwOun8DQ+cZt1jCHyo+wcfKGinOpgDxbSk9g3sWQcxBpIKZIoJTkpz
         +cumROGuecL/o91Y5LmjE7X+ZKTG5hd8JHyD6fqM8pGXAwMY9Q7k8xhHT2q8bgYgYfoF
         H2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706759175; x=1707363975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFF8rhKxfnZfXzZDWT495muOJWGnqIPs5LoDZ1rl5gE=;
        b=c4xI0e03urkrGr9kgIMWaJdd1PdwDvRgdotvef0zKM3QHyIB7Eb6ksZ4YU4Ul/t9mN
         qe4r3YBFuAs0fn9FV8DgN9wNaj3//s5NxZ92XmBi9/zYD40wuEs2Tx6R2qiaW3awZjm6
         edzGVuzwvgT/NGCdXVaBceTCXCQX0/iU3dMsTYsCipjY+Z/HEbCiZUg4VwILFWM64Y4W
         xhCR1kdp2BaGMKbnPHmdIpwda718ke0ia7mk0jOTHQOBt6pEkDvjATTqCRBA1goQkcIm
         g72HsZC5OO8OAYYLG78PAy3k0xJ9OoND5nx+DcPPG2IQ4RADh9wxXvg8dS32ez8U/64I
         J+Qg==
X-Gm-Message-State: AOJu0YyD+dfOSyKIhV8XDcHlvDB67FrS/RWQ19ZguEj4TQlQCQnNbcyK
	qmoM11aSStN2ajlLFKP7BWVWbI8qCIAt74c+8pkDPanbL2dFwuxiTcG9hhPy7toWp4CESiOhVSV
	ON31I+NjePMV+lnqmktCYxINmotZTQgd6dPvf
X-Google-Smtp-Source: AGHT+IGl3N0KrMo4pI0gs+wWPmLLPDTG5QuX4lcGW2kiKQyFlHOmi4pC0Z0bfHJbRXQX44gvJC50zjr6/z8SDinOs0E=
X-Received: by 2002:a05:6214:21eb:b0:686:aaad:e36d with SMTP id
 p11-20020a05621421eb00b00686aaade36dmr3110186qvj.2.1706759174991; Wed, 31 Jan
 2024 19:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-6-vannapurve@google.com>
 <6709a57c-48a0-4ddd-b64e-a1e34ae2b763@intel.com>
In-Reply-To: <6709a57c-48a0-4ddd-b64e-a1e34ae2b763@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 1 Feb 2024 09:16:03 +0530
Message-ID: <CAGtprH_ANUVU+Dh1KOq0vpT7BGbCEvD2ab9B=sxjzHYsKxFGeA@mail.gmail.com>
Subject: Re: [RFC V1 5/5] x86: CVMs: Ensure that memory conversions happen at
 2M alignment
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rientjes@google.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com, 
	pgonda@google.com, michael.roth@amd.com, kirill@shutemov.name, 
	thomas.lendacky@amd.com, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de, 
	m.szyprowski@samsung.com, rostedt@goodmis.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:03=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 1/11/24 21:52, Vishal Annapurve wrote:
> > @@ -2133,8 +2133,10 @@ static int __set_memory_enc_pgtable(unsigned lon=
g addr, int numpages, bool enc)
> >       int ret;
> >
> >       /* Should not be working on unaligned addresses */
> > -     if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", ad=
dr))
> > -             addr &=3D PAGE_MASK;
> > +     if (WARN_ONCE(addr & ~HPAGE_MASK, "misaligned address: %#lx\n", a=
ddr)
> > +             || WARN_ONCE((numpages << PAGE_SHIFT) & ~HPAGE_MASK,
> > +                     "misaligned numpages: %#lx\n", numpages))
> > +             return -EINVAL;
>
> This series is talking about swiotlb and DMA, then this applies a
> restriction to what I *thought* was a much more generic function:
> __set_memory_enc_pgtable().  What prevents this function from getting
> used on 4k mappings?
>
>

The end goal here is to limit the conversion granularity to hugepage
sizes. SWIOTLB allocations are the major source of unaligned
allocations(and so the conversions) that need to be fixed before
achieving this goal.

This change will ensure that conversion fails for unaligned ranges, as
I don't foresee the need for 4K aligned conversions apart from DMA
allocations.
