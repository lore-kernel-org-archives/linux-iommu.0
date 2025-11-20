Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8230F801
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763663487; cv=none; b=SdqPmunTifVcIQKP93L53/1+4ukCSEq5xBUzdXFwbNcUoOb4Gd0eAw6DgG5dsGct+/6WPr4UYltNy27+6eyn/K1Klx6Fe9eTaCWSV53teKQksvEMsIzn68EL+r0GKRNWwRwcwYh4JgC5FSNwDJUfV/T5AnUtiF5BfHa/V0u9U44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763663487; c=relaxed/simple;
	bh=RJWdSMJFkKKpmT8nR8qTiYD6gXE6h7WjUQL4kfxvCDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3KcyOmkUgbVi4/ELxQTWcko6Oa0GZSl7hnjSyhHR6OROZlXc99OhOouIu3uLUZVwsD/qwIbF7Jev65QXdqDxfxUXJCxLDx27qohAS5GtHIF7LhVQvGAYEHg5jRNr9KL8bAXbEH4rK19S36sMOk4qdfCWpcjy4/Puai8Dk11KCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-55b265f5122so310888e0c.1
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 10:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763663484; x=1764268284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6Pbbkcq4vJY4dhlOt9k4VzFX7B2ssH1NKcQYU3Egds=;
        b=AeQgCn4i+CjWtjAEnxkL7CdvIo36CJd02ZPNgPdj5RBgzVSeAuvSalwPrEe6VwvooR
         WoNDJaAqQWRSFGud/jJKldNW9Gtdd+Ep/BiLebdE29N+LmRP3C6jMiTj3Fgm0VR9zaWe
         emF2vpNGc/+8tuUyOQ/bZm9273DKrULmLI9Qd3ld5oj19xUzuWdR33sVycnMj0BSGHtL
         6DA3id9dCOK1LXEiNqVnsaX1FCTRUb6Q+b+vyy+krBHVUbpHJ86pkCjqZD3PbIU/agLj
         2ZznHsRcr3LuISUKAnPsDkwa7PjtA2V+KM2YNOFuX1oxhgwMpRvK97VZahnIQR94Wbwu
         Wf8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiPRm12RTlTWg8XewQJb71F1dqbBvzdrjfn26fLzhtDQBtRhnB6K8OUfOrUlMArbqS6XjrbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSCorA3WSU1HVQ95lAcZegYZRRdiVaEC0C+RLiiUSC6qbczsWs
	deYJCu/2uHJW9rDuo6br3XR5EgteQNVv4k0IJKIzIuoEjydG5PdU5eELlqbE2ipg
X-Gm-Gg: ASbGncuqYQ4+GZTFQ1B9fLT4EhVgD0H8/+po5s9i74EbAqY7W+DKsTkxJJaR0f7nq4z
	w4z7k5jyHEYMsA0QE752hJLCrLygIF9B7o45X2SKKr0AwNnSoRocSmVolBNs09lWQ8P+DuN1XgW
	DeiOMRmo4WUWwnmwiy9M5SDRoIIP4nwTzLnGF21jtkgKuPh/DOqExHRsnvrQ8n32PNcr5e8G9NP
	hyOlGRu5gu2DUcwTiYZV0siWMCPDen0C0kUpVSDyut/UwBO++5QwGBXMz2Ki3q4Wg/dIdvwxNzA
	TTy3JeL+mSp/4zd4LaKwHtx9GMUUuV5+Ko8Xq/N9vjLCPk6WIq1c726ulNepmv90oxCHHggIqzn
	a6esF+EmrfTwCaOwqtHmz5bAF3qpCtqQZm/gMmiScHYwGOP7RLyNBOnILVjz94BQ7lFs5/o1XuV
	/hsLai/OB1pcBrUyAJ2DM+3OiO+1Z8KmOdSps4Fe9t5/cNgc9qz4UUtEqXrH4tkI0=
X-Google-Smtp-Source: AGHT+IF9luWQv9gcjUIsIDnAeKlThALRhiCWEcY9D4VhwGvUWgEWRx+Fgce/Ufd3K87d43RIBicMvA==
X-Received: by 2002:a05:6122:2013:b0:559:65d6:1666 with SMTP id 71dfb90a1353d-55b8b6916d4mr269542e0c.1.1763663483568;
        Thu, 20 Nov 2025 10:31:23 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f7a06b7sm1330036e0c.17.2025.11.20.10.31.22
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 10:31:22 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dbd150efe8so460474137.0
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 10:31:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXVHj7JSS55ZMCWliO5tYpGFB9eMT5MZqoAZm/iIIJuqYNlNUJu/kO4xbEVlC9npbV+adBWZw==@lists.linux.dev
X-Received: by 2002:a05:6102:5705:b0:5db:da81:2541 with SMTP id
 ada2fe7eead31-5e1d851b50cmr75313137.12.1763663481782; Thu, 20 Nov 2025
 10:31:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>
 <20251120164933.GV17968@ziepe.ca> <20251120170744.GA236839@ziepe.ca>
In-Reply-To: <20251120170744.GA236839@ziepe.ca>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Nov 2025 19:31:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVsyu_vnYiV7EcChd3a6czUCh4Gis3hL8uDVmbDcGo06w@mail.gmail.com>
X-Gm-Features: AWmQ_bnRxfo1Tg8SkmQbZPhLq64ESeWKE0re-uwHoKs8zI4GSfe8l_ubdewUL4Q
Message-ID: <CAMuHMdVsyu_vnYiV7EcChd3a6czUCh4Gis3hL8uDVmbDcGo06w@mail.gmail.com>
Subject: Re: [PATCH] genpt: Make GENERIC_PT invisible
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	KUnit Development <kunit-dev@googlegroups.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

CC kunit

On Thu, 20 Nov 2025 at 18:07, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Thu, Nov 20, 2025 at 12:49:33PM -0400, Jason Gunthorpe wrote:
> > On Wed, Nov 12, 2025 at 03:08:05PM +0100, Geert Uytterhoeven wrote:
> > > There is no point in asking the user about the Generic Radix Page
> > > Table API:
> > >   - All IOMMU drivers that use this API already select GENERIC_PT when
> > >     needed,
> > >   - Most users probably do not know what to answer anyway.
> > >
> > > Fixes: 7c5b184db7145fd4 ("genpt: Generic Page Table base API")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  drivers/iommu/generic_pt/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Actually, it doesn't work :\
>
> $ tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> [13:01:26] Configuring KUnit Kernel ...
> [13:01:26] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=x86_64 O=build_kunit_x86_64 olddefconfig
> Building with:
> $ make all compile_commands.json scripts_gdb ARCH=x86_64 O=build_kunit_x86_64 --jobs=20
> ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> This is probably due to unsatisfied dependencies.
> Missing: CONFIG_IOMMUFD_TEST=y, CONFIG_DEBUG_GENERIC_PT=y, CONFIG_IOMMU_PT_VTDSS=y, CONFIG_IOMMU_PT=y, CONFIG_IOMMU_PT_AMDV1=y, CONFIG_IOMMU_PT_X86_64=y, CONFIG_GENERIC_PT=y, CONFIG_IOMMU_PT_KUNIT_TEST=y
>
> Can you add this hunk and send a v2?
>
> --- a/drivers/iommu/generic_pt/.kunitconfig
> +++ b/drivers/iommu/generic_pt/.kunitconfig
> @@ -1,4 +1,5 @@
>  CONFIG_KUNIT=y
> +CONFIG_COMPILE_TEST=y
>  CONFIG_GENERIC_PT=y
>  CONFIG_DEBUG_GENERIC_PT=y
>  CONFIG_IOMMU_PT=y

Do you really want to enable CONFIG_COMPILE_TEST in a .kunitconfig?

Hm, that .kunitconfig already enables IOMMUFD_TEST, which is
documented to be dangerous (why?), and already enabled by allyesconfig
(except on GENERIC_ATOMIC64 architectures).
IOMMUFD_TEST cannot select GENERIC_PT, as that would lead to
a recursive dependency (and I am not a huge fan of test code auto-enabling
extra attack surfaces^W^W functionality).

Or perhaps:

-       bool "Generic Radix Page Table"
+       bool "Generic Radix Page Table" if COMPILE_TEST || KUNIT

?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
