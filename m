Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF44A32
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758888; cv=none; b=n8MxMlbq6SbqEncZMCj6DgwkB/X/OFZi9uR9r59v0BG/sMBhpqYaU1lF1MD0aM89l3XPn/aFTbzWE1PITcaaprMG4Kbw9dP2x4IIISGT5uBMKNidxY2f/NW/tnrTVyPbsOhDjccUuarsTZicsGw7Bz3t1EfihFpX5xcIci0zgkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758888; c=relaxed/simple;
	bh=pD0qQqzTU6WGAJKcIVfmEDXMQaiBlK+UQHQsdA5kW08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rf+rEVX3XmUav/spECnjvn5FIePCVxoA6W7MZE1doqbuUoImDsVSXKhzXOWja31CvIQcb8QqxHzCeLYeJPzO9yB4xRMtKexIcxcO48Yk18zhRoMKsxucwcS0sez0dCi5FpxYTjYTuU/oz+kXxdw0nFHzCOXEZjEyj0WUGS5WDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0iKkYnv8; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0iKkYnv8"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4676a37e2c4so221960137.1
        for <iommu@lists.linux.dev>; Wed, 31 Jan 2024 19:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706758885; x=1707363685; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DGWnf0OzAJDC2ay8IuZMeYL0UHzgLCYpMni5nUB1LM=;
        b=0iKkYnv8BVaOaJ6CAp1NWjVxay48/Qr911uBqVFS0Gkaot3DtI7cPFDbC2LQ7JrQKb
         vUnxn9e/fiNAvGSBltE06zh58jRI4mpdNi6TtKLvItihQhjWMMwrtG7FIdyEx9Y904ZB
         r9DlPuwrvGp89Dq6bY3iQYoCdc49NYslNZ7p01hkZs3aqxFLnXNcMCyFBS8aimhrOtcB
         nRXYih5HX7xZ2ZzvtzsDpI+/0B2Qz3xz0TgeJLdS2kJmYEqGkZiWLx+3wxxLQbv7glsa
         ltiUe/7U7jFV7jqAeMNjZcT8jL/hlGcVPOiGLUHxeN1VppyHuyWpGNnrvrpr9KdicXqU
         Pbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706758885; x=1707363685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DGWnf0OzAJDC2ay8IuZMeYL0UHzgLCYpMni5nUB1LM=;
        b=uw3qsu5jLLzoqeEIQPiPron7zXisO1znh0pPhEWxzQaHS4YjeOq+YEJi7JCclaTKVH
         by46x3KcekVrwpYMA9RYB0thM+SUAkIwoUPY5594aYW/AUo3naWZzusrEQODGBEbW9AX
         RWdUf+DafOHRKoRQ9+FKVz93ODfXGNdDeY07Lae2Yyuc36JmiSsMdzSaC8+Ka9MHmZT6
         iBHYjMkwbQIDIdqnmYatxy7fgSiwyML3wVixPstidcoFuQKrSTDHh/OzeuGY3YG208cn
         aoReUnxrP4KNbLEh902iaRQu7Su0KXa+dNGgXrTvJBHd8kWAE15/xIlmr6ETDH4APhh5
         X/Lw==
X-Gm-Message-State: AOJu0YynUmupvdbGarBFSavaFtDsAHc9Uo6MAYHMKy7xOzkWZrF7KS0q
	VD/lN8Nhe+IShvbZqDhZLSNvtZWWHAsLJefJjBLn/qBSoY3hgjS8KhvrdDkgGKguhYe6RA8QotC
	hDlNmcAwGhSE47w5Ds9B1QGAy71q/GLlocXli
X-Google-Smtp-Source: AGHT+IG8cEzY8akfVwuYulwp7fNS1FiJpo8aIaBQKCVk7NWukI6OIqqT1l36q6zX6ceqa4hmH6bIZzQwumwKYy9Qd/U=
X-Received: by 2002:a05:6102:41a2:b0:46c:f354:efbe with SMTP id
 cd34-20020a05610241a200b0046cf354efbemr347871vsb.1.1706758884507; Wed, 31 Jan
 2024 19:41:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-5-vannapurve@google.com>
 <db477cef-f63b-4950-82b0-275bd10dbe5c@intel.com>
In-Reply-To: <db477cef-f63b-4950-82b0-275bd10dbe5c@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 1 Feb 2024 09:11:11 +0530
Message-ID: <CAGtprH8AymwMJuvsTbGcLgbCOLB8q1M9LGYyPzPUbQQwvB0_eQ@mail.gmail.com>
Subject: Re: [RFC V1 4/5] x86: CVMs: Allow allocating all DMA memory from SWIOTLB
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

On Wed, Jan 31, 2024 at 9:47=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 1/11/24 21:52, Vishal Annapurve wrote:
> > --- a/arch/x86/mm/mem_encrypt.c
> > +++ b/arch/x86/mm/mem_encrypt.c
> > @@ -112,10 +112,14 @@ void __init mem_encrypt_setup_arch(void)
> >        * The percentage of guest memory used here for SWIOTLB buffers
> >        * is more of an approximation of the static adjustment which
> >        * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> > +      *
> > +      * Extra 2% is added to accommodate the requirement of DMA alloca=
tions
> > +      * done using dma_alloc_* APIs.
> >        */
> > -     size =3D total_mem * 6 / 100;
> > -     size =3D clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> > +     size =3D total_mem * 8 / 100;
> > +     size =3D clamp_val(size, IO_TLB_DEFAULT_SIZE, (SZ_1G + SZ_256M));
> >       swiotlb_adjust_size(size);
> > +     swiotlb_adjust_alignment(SZ_2M);
>
> FWIW, this appears superficially to just be fiddling with random
> numbers.  The changelog basically says: "did stuff".
>
> What *are* "the requirement of DMA allocations done using dma_alloc_* API=
s"?

dma_alloc_* invocations depend on the devices used and may change with
time, so it's difficult to calculate the memory required for such
allocations.

Though one could note following points about memory allocations done
using dma_alloc_* APIs:
1) They generally happen during early setup of device drivers.
2) They should be relatively smaller in size compared to runtime
memory allocation done by dma_map_* APIs.

This change increases the SWIOTLB memory area by 30% based on the
above observations. Strategy here would be to take a safe enough
heuristic and let dynamic SWIOTLB allocations to handle any spillover.
