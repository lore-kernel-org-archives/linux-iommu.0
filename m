Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CA207A27
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480069; cv=none; b=il/3xiaW0lTAxL1rVsFBS33MY7MIN/1grtkCBnHHLYJO7g90eT02BnXZjHWzRXl8lW+1uepe/vvUg7puPmNoYF+XR94t4N8y72zls7ZTTTBpq6iP7vpBYKq7hCr98lhguSKnkpVykID3bEd3SXsbVaW9MRufoG+CmOqR+mkd3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480069; c=relaxed/simple;
	bh=u2Nrcgw7jkwsuXcOLlFIjL5vyZPM1WYAtiGtFnUjhwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsI/H4ZyYcHlrjbP2wHGbYCONOl3fSkEeFJBwr/uqZyb0k6UQZcroJ1/v5VBE7cwNwyc1dCyWclPx61bVaxWIZSq5brgzyHf6+GqKxszj6UJnWJgNyvXq1CCBh3mnj5oFwauPLp9aXsoXtgMdWIe8zpniuId6x3uO+HO62sZJ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86d3ac0fec0so756119241.1
        for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 00:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745480066; x=1746084866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTjQn1pRO29n/BIx3/Uvj8AT+NnaG1jO3iBKpZy4Wb8=;
        b=O1URrGexDzUuUfXkZVn8YbKT4xOPNcMYQyKMhTXfipWz7lFR1TcCEAKjhwWEqoSFqE
         1jIwkfJ2C2hvQrSLvNdUP9vocaTcr0ta6Hgwm6cL4R8HtVxVivb4NQqRWv6S3dGKu3zP
         93PS/mzuA4ftOFs53QOAYfQOwvpMWsptIdOBb6P90zYilTgdFOQJc1J1HJXh9Q95uajZ
         i+Jh4q132b61rm7wVFPLLi2pWjZc/aPfeeVNgpViXeyoH40GLHgjdDkr0LHCxE0VFIh7
         40daAOh3s7x0gQL6xLXCz2cgnULNRuWnctAulIqr8esG45jUey8oN9eKyNHsel03n0SU
         iOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU14QP9Ti2YfsY/PocLwBxUQPjiPGdfJq1hnN1L/Y7yPsB/mZDlZ0RIFKWJEVSF2fQmyNEVyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlJP++gJSXul0b+CbMHRJbpIezRgk8jXr0Vtyzbx5lFnTA+/Fd
	8kOM/Kkd6VZKEC997L5IdGD5B8F612RCB7h9gR11sy4j4WULUbYDIqPWwYH6
X-Gm-Gg: ASbGnctSSzUfxjHkE29eluxzu68IVVPbl0ELghvV9j0ZiqwsSBUe9Wq1hvqWGrmgxkW
	azTJUhGALRsoIsVpCZ8dc9TNmVvOSNn7prBgwofp1O8xQdbTLysSeP9rtAdxTtr72Wf5+bZ30Xc
	uBgMOWILOSv9ItjCxfiFAYxfsAxGmzxkeliWwVou892Jg9nSd9TAwjWsN15/M/jNdGjCtIfGMbX
	p+zP2N/2m9ouMW4quco+RpOXbtuWfb60h0Sm53DIfccBxl6qZxaTHp7BeOuS3UWgSjeF5DpTGXY
	zoRQE2KgWIFbCLXzl4LsgPYneq5c65IxrP1Zl4l8QTE4EN8JL/X1/N3OUdHsXH2oY1QQ69h/kpF
	PYy5n3qpiCn80IRdcJQ==
X-Google-Smtp-Source: AGHT+IGydV+/0i8l+cswo7p4gmhsmzRHL8/kCg94cqg3C1FOB7mq5eBC5PfHM/+al/tPRgaGAZYP/w==
X-Received: by 2002:a05:6102:3f90:b0:4c1:71b6:6c with SMTP id ada2fe7eead31-4d38d125323mr1440733137.7.1745480066199;
        Thu, 24 Apr 2025 00:34:26 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-877aef2f37dsm188343241.22.2025.04.24.00.34.25
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 00:34:25 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-524125f6cadso671874e0c.2
        for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 00:34:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJu3hku4q3SKs4pTFX2a6b+eHmR8gzawPZRj1pTcjbf4aSb4X7DI2qimwsdjf3ayMstnBXQw==@lists.linux.dev
X-Received: by 2002:a05:6102:292b:b0:4c1:a15c:ab5c with SMTP id
 ada2fe7eead31-4d38ebe8f73mr1154262137.20.1745480065531; Thu, 24 Apr 2025
 00:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250423164006.2661372-1-arnd@kernel.org>
In-Reply-To: <20250423164006.2661372-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Apr 2025 09:34:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWzLuVjA=8PMm3UPXXPUEwBQjnTmp_W9oi_KHCx=m-QZA@mail.gmail.com>
X-Gm-Features: ATxdqUGQnUlzm5W2tVtEkcCP0cHDrWqBr1nsmTcSEp-9WZNmnHDiuaEyg8EZoF4
Message-ID: <CAMuHMdWzLuVjA=8PMm3UPXXPUEwBQjnTmp_W9oi_KHCx=m-QZA@mail.gmail.com>
Subject: Re: [PATCH] iommu: ipmmu-vmsa: avoid Wformat-security warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Magnus Damm <damm+renesas@opensource.se>, Arnd Bergmann <arnd@arndb.de>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 18:43, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> iommu_device_sysfs_add() requires a constant format string, otherwise
> a W=1 build produces a warning:
>
> drivers/iommu/ipmmu-vmsa.c:1093:62: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>  1093 |         ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, dev_name(&pdev->dev));
>       |                                                                     ^~~~~~~~~~~~~~~~~~~~
> drivers/iommu/ipmmu-vmsa.c:1093:62: note: treat the string as an argument to avoid this
>  1093 |         ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, dev_name(&pdev->dev));
>       |                                                                     ^
>       |                                                                     "%s",
>
> This was an old bug but I saw it now because the code was changed as part
> of commit d9d3cede4167 ("iommu/ipmmu-vmsa: Register in a sensible order").
>
> Fixes: 7af9a5fdb9e0 ("iommu/ipmmu-vmsa: Use iommu_device_sysfs_add()/remove()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
