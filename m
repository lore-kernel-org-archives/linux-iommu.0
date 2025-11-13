Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5283321C2
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024223; cv=none; b=pWWERu0Fj5AZJHiVRAmJg5A1q8qt51jnkFAJlcpFMKLnu3ef0k82qyRRvEU3HY3wILzA2XS75wh2TK3v/RhQ7y8/QSrLlok6gtR+HjvSxt4gCAeZNVzGTm3HSoZ0y7eo4YDAq9xh4eXz8NuHOeDopLOr/OnLRefTnjRyhvBzyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024223; c=relaxed/simple;
	bh=as2Wl3WHy5m/K3oRgwuzwjXnWFg0R2hmfkUngFuxVnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SM+uyNR1eONkUrmybWo8k0pDmtjS6tOXaX5G2pVrZEc5qilH3MqUHtxaAcsBcYrRmLnvjf8gTOdpTPNZkpwQ5OTlC5/dy4bezsVFnSW+hwkzTxIpkC4N8iJ/oMItEH1SfVxOkpL3f+Xeh63WYiEH5CJ6T5zXKSmjTYhInCB+u68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5597a426807so364242e0c.2
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 00:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024221; x=1763629021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNPad0IM0QP877Z/XWUvdL3MC286xcTm4p5JIGRP0vI=;
        b=v+dh1+4FNVuipBdUlaz4hAuRZ7YeyppGN5LKhfvy8aLXouVTolD/eopHnh3BWwwYgt
         XAXgPJ9BxNeBAjyOnm8e60ysdDLzC2PMpygZ8gyJb24sspCC0xCKOBFZGxTgtj7fN8Rz
         bJlMp2p3Ll6C7Dt4u3P2mjIRYpIPS/A6N07x47FOE9jgnGMRP63ODBVZypuXABiK7qCM
         83o/tbSwLHCilRErqxLnVUxFLUHbhrc+UuognM4pPwSLopNS5GUGLFYA+MhmoN8wzY50
         6ghorrEgGek3Dh1gPg0A3VLk1hLc+MwfC1NgXuV0xA/6G9peekfKZWa8cG0NnKzKWDZc
         c/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+WkjJvLfoWlDVIvbtJs8vkQi+WKWQO1Y5tet3rtjROhDo/PuyPqKS85VZy9B9zflk067mAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiHKcZczpBGywmufztgXNorVkBfeYtvMARBDLJju5ixShigyN+
	6eyxWQ+w/Q6Tbf47BBixv1vFAnKqma0zIs+18Fr3aK3WA95KxI6/rGXrRwx2kez/S6E=
X-Gm-Gg: ASbGnctheeHO5BwDnrUyBKsUmmdAIiZpSY7HSM/S0YRm8WCQTCA2VOCanbEy2zt5t7f
	NjmGww4dVjKLq0ogtFa4jG5VYj304T3GlgXXOwAaMc9pB0oCkMRfGqpJVKc4o6Bjh8HYEppM4Uu
	frkv84QBUCCxFJD1a0isJOh5qCMmLoVapo9QMbUbN74zIVibsgXL2lLqWubtnDN3NF4WmI+9lQe
	VibjW8+uVDbJslqD+8nE3ANsztVey2+SyL8eGpKjFV/8IBnlu7TFbLSiug1O8L6EAuDyOUAAF1f
	M8G5r5dTCSyzbLAhaB9HY7/Cs4GFPtdKMLSUvYINqhMb9bVdllk1Sx25q60gQ+FaCBhKYuf/zZ5
	HK6VYmTa3Bi6DLgAJ4v7SBABIMHDxBf0QUIDaRRYQEWxOUPDGq5IJnW3eHHPE1ys6AnzBMDRSju
	fUjM4kNqLGi6BfqdIep8RDPH1z336pDNakMPs1BQ==
X-Google-Smtp-Source: AGHT+IE/cYQqKpVk96JisrZ7jSWZmovHH0w2kvuXDdG3cty57PZHbkPtsVu+UARHmpzCAXS4+8PIKQ==
X-Received: by 2002:a05:6122:4b85:b0:559:6960:be0d with SMTP id 71dfb90a1353d-559e7d62252mr2546017e0c.13.1763024220871;
        Thu, 13 Nov 2025 00:57:00 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f46234fsm497422e0c.18.2025.11.13.00.56.59
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 00:56:59 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5dfa9bfa9c7so368738137.1
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 00:56:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmVatxsWzuiy2IYZxatHT5kZWYN8IuJFF+89Hw9s/d5iqyuyQIrntgIJ7KFKXcK7Epgs5dlA==@lists.linux.dev
X-Received: by 2002:a05:6102:374e:b0:5d5:f766:75f1 with SMTP id
 ada2fe7eead31-5de07d598c3mr2559230137.11.1763024219221; Thu, 13 Nov 2025
 00:56:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>
 <aRULf65eNaRIVEHN@ziepe.ca>
In-Reply-To: <aRULf65eNaRIVEHN@ziepe.ca>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 09:56:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU3rY8iyxJWdNFA0whOFv6WV-AgndnoA-QPjNLrLOjw2A@mail.gmail.com>
X-Gm-Features: AWmQ_bkeganA7aM_P2ei0wcLl7_i_OWoRrr5SIFHNN0iTfxFCurm_-NlINuIdn0
Message-ID: <CAMuHMdU3rY8iyxJWdNFA0whOFv6WV-AgndnoA-QPjNLrLOjw2A@mail.gmail.com>
Subject: Re: [PATCH] genpt: Make GENERIC_PT invisible
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

On Wed, 12 Nov 2025 at 23:34, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Nov 12, 2025 at 03:08:05PM +0100, Geert Uytterhoeven wrote:
> > There is no point in asking the user about the Generic Radix Page
> > Table API:
> >   - All IOMMU drivers that use this API already select GENERIC_PT when
> >     needed,
> >   - Most users probably do not know what to answer anyway.
> >
> > Fixes: 7c5b184db7145fd4 ("genpt: Generic Page Table base API")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/iommu/generic_pt/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I can't check this right now but I do recall trying to do this from
> the start and it was not working out, it ended up not being
> automatically turned on?
>
> Did you test something like menuconfig and the IOMMU drivers are still
> presented starting from an allnoconfig?

Yes, that still works.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
