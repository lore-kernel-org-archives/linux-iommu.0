Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B81C8639
	for <iommu@lists.linux.dev>; Tue,  1 Apr 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743516690; cv=none; b=o4dP6+CmptSdXNiJBkMHMhYgRUqcYD+/jH4nJkb689hAO0Wp27AYJ1FtdsV6wkGpaOS2K1NhRlew4g8PBgLd17oUwW+Wlziklqwv7ScaiBJyzLSDACQRXevMi1mK48BHpWbaWzbpgsvH1MpUkUyXVYE9sGEiP47TOEUDLEgBzB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743516690; c=relaxed/simple;
	bh=jQK3cLGftQIeziLsvTcI17ChCJ5qEloH80Od82SzFc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s37yppiOqwCTwteLpL2hVY7L6K5LDiF4tdFD/aECh28+1/G6FUsJDvcaS0h0c1ZZL0+Zo7K2j5x1qbvl7Z5BbrV7ORE8FD9hEathk0PsB14QAEBflGdhyNsa4fnMImZS4XlPNp+JIN8+t1FJyx8zeohjU52mk4zR0l1SumJ6GBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86715793b1fso2416268241.0
        for <iommu@lists.linux.dev>; Tue, 01 Apr 2025 07:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743516687; x=1744121487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dbXshCLizYzdzsg1zBJcHBo28K7Ezm6HNKb+QYxbz8=;
        b=IZ7NFM7NCpUxQUbwmpLNYmkXQrENvhcocH0K0G2mBuvLjf9mQfKq9TFE2dtoqAsaRa
         qYg6LetpW2N9M4zQ2xW8OSMHJfVAe9ZKDjroBt2HGROQDklJKNttZGWKHwMs8ri81G2H
         DH0OJHNDHIMYTmCgfPMrvvHijx94ARyxZYNALv1ZNkWaSKRvCvn0c8weFX+pCLQrpTLY
         vVLGjWkXtZ3LBfdWW+Ls24zNZ/NNx12tdlUfpZlj6LIqwYKf3zyh/4YtYSJXtmsGzFgM
         ZLNBRRMmmLlZ8WFz5dxr9uOgmqFUwvUtXXJneQtnSmgpVvZUPRoAbI1YHG/XYWxYohSl
         RylQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKEuoZJ1VhA0Ai/W9uyGfewX9SXPEaANW9L7AzDZHej5j2IxHnPUDfLXyCUuEZWO6M5/8BHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlIntJApzjmjGiX/vsdVKw3SAeBwmYCUEp2XbLGaUJ69Zj5L6K
	lqRf4VO8+F5CEqv5EtP8HQGhK8kaEtMYZtMJQYjp+lp0uthNmpTorHZLXED/
X-Gm-Gg: ASbGncu8WVV5Y5NGGSvf27hLugDsMMpxR2HxumJhUQlYyLohnTGClXc+pc132WoRX4T
	whddnWu6/8kuHQSAB/SA1IvUEWFnBxOmEX5UplgOSW7rFl+UWfODCk6Kz4chEaZ+DNQE3W5uD2s
	nJoJuoEdjbKwbaKTQvdiuKzx7K8dGotYdyPhfs4ljaejcXnC/Rheaaq2SyrnMoSZQOOifvdPdR+
	bZuCG49vH9OQ/ntJaXtnMPlFKHcjKS3eRcd7RgA2xp7sSJEgwK+pu31Rm5GJSCeJYI7iE0oxNEk
	SIPAqpxtfnjOR7V7wt1cviRMgqCTfvduToyf9qmu6kjeTAnJHcchdQrgCCvpYcc8RATU4ZGg0mi
	TKKhCeas=
X-Google-Smtp-Source: AGHT+IG/bikw/Suhmf7RK0R6GanHO0r8Bwf4nqw/UYETKtqnf0eMGGVNreW25Lk/87mohIh6AEAJ+w==
X-Received: by 2002:a05:6102:2b88:b0:4bb:e8c5:b172 with SMTP id ada2fe7eead31-4c6d3887c1emr8402538137.8.1743516686797;
        Tue, 01 Apr 2025 07:11:26 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c6bfe5bdc6sm1983916137.26.2025.04.01.07.11.26
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 07:11:26 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b9ea43955so2136656241.2
        for <iommu@lists.linux.dev>; Tue, 01 Apr 2025 07:11:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdTgV3WSbBCx8r1s4UKokw1CjtSbk5gPr7Ujxa4s1O0NJSTxOAhfKaLE1nUUlromLZ3CM7CA==@lists.linux.dev
X-Received: by 2002:a05:6102:2ad5:b0:4c4:dead:59a3 with SMTP id
 ada2fe7eead31-4c6d3837dfdmr9191881137.2.1743516686211; Tue, 01 Apr 2025
 07:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <53be6667544de65a15415b699e38a9a965692e45.1742481687.git.robin.murphy@arm.com>
 <CAMuHMdUtCqwzeWY8G+yHiu4biovymDVb_UtjfYPEQYyYr+dP4Q@mail.gmail.com> <f72bcfb2-e2a1-4dd4-bedf-241b75178958@arm.com>
In-Reply-To: <f72bcfb2-e2a1-4dd4-bedf-241b75178958@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 1 Apr 2025 16:11:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXYDLUZGxFf6fnsKXg=EA2YkoNwMe8Uv0+Bo3w+4h-dhA@mail.gmail.com>
X-Gm-Features: AQ5f1JobuqnYTkEVwZcXHOdw8llBj_Ln3GR8mFtvtzuLKH3AKUYuIBQ4wVFH8hQ
Message-ID: <CAMuHMdXYDLUZGxFf6fnsKXg=EA2YkoNwMe8Uv0+Bo3w+4h-dhA@mail.gmail.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Register in a sensible order
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Tue, 1 Apr 2025 at 15:53, Robin Murphy <robin.murphy@arm.com> wrote:
> On 2025-03-25 3:26 pm, Geert Uytterhoeven wrote:
> > On Thu, 20 Mar 2025 at 15:41, Robin Murphy <robin.murphy@arm.com> wrote:
> >> IPMMU registers almost-initialised instances, but misses assigning the
> >> drvdata to make them fully functional, so initial calls back into
> >> ipmmu_probe_device() are likely to fail unnecessarily. Reorder this to
> >> work as it should, also pruning the long-out-of-date comment and adding
> >> the missing sysfs cleanup on error for good measure.
> >>
> >> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >
> > Thanks for your patch!
> >
> > This fixes the
> >
> >      sata_rcar ee300000.sata: late IOMMU probe at driver bind,
> > something fishy here!
> >      WARNING: CPU: 1 PID: 13 at drivers/iommu/iommu.c:571
> > __iommu_probe_device+0x208/0x38c
> >
> > I saw on Salvator-XS with R-Car M3-N.
> >
> > It does not fix the second issue reported, so it is indeed too early for a
> > "Closes: https://lore.kernel.org/CAMuHMdWPFnHTFeeWL2-BU8tKOL-E5K2ROOz=LLBLTJJLCK9NgA@mail.gmail.com"
> > tag.
>
> You mean .of_xlate being called multiple times? That's not an issue,
> it's normal and expected. Every time an IOMMU instance registers, it
> triggers a probe of all relevant devices which do not yet have an IOMMU
> - this has never been selective, so if a device is associated with a
> different already-registered IOMMU instance, but does not have a group
> because that instance's .probe_device rejected it, that probe also gets
> tried (and rejected) again.
>
> The core code behaviour has been this way for a very long time, the only
> new thing is that the .of_xlate calls are now in sync with their
> corresponding .probe_device calls (and the latter are also now working
> properly again for fwspec-based ops).

Hmm, I started seeing the extra calls only after bcb81ac6ae3c,
i.e. not since a very long time?

> Was it just that, or is there still something functionally amiss?

That's all for now ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
