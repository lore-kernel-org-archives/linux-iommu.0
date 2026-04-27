Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45672DB78B
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325504; cv=pass; b=WNx+qr++/vZI6n1ohmZPWYFrxhMkMS2MioUfKgq1fr2/Gn8TxNRV1+hVSxTnKmwJVS2NF3bupp+HMW7UVtYfhMxiNP9ffHsGOxhxys/SiNewrH9d+TSoQgRop7UxtW3WC8/sHmcHyYvQMUMg1nY4nqhJ6DAjrGTKeTW3cZNctNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325504; c=relaxed/simple;
	bh=XxyXGFehDCe0pfONU0BVHIsiW5Y6i0tO8AG04f++XSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5YmzrzpZzx0uelnNqPjXIDXK1oJd4e359H84XOLFO63ANqe25/4cKqMwiStTU6CW+0mLcdy2KWhH6UUJdvo57K4ppu/EL6hEIXOr1YZy2uHD3jGZf2p19P14Gfv1UV1IOATY+ui+JeNvqz6vCFC+7MdLouyxA2f3HOLyADelRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OoNJzY69; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoNJzY69"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38ce0ab821cso91529551fa.0
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 14:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777325501; cv=none;
        d=google.com; s=arc-20240605;
        b=NOZQPcRt7fR2dn564Bik2RpLuMWd4LfhcnxPFf73Iy9WlyuG4He6Kt9kAZOsJxLFwZ
         owj91Sz3NApF8G3j7B32ghm3SdWTkrwX8z67dYRQ07U4vWEd/uqnoQOXa+bHubmJSj0t
         hz98vB1jh3TcZx/FNAxyhpAoPK4h2o8J3J6gTrOlT2mDOMGoBU/sydK1isnHMwI5OWTC
         JJx9S+sP1NzS0noEGOTi4ddit1WRN9R9vIMnVo+aLzdNjdJmz8M41sOVt0URZswPGrzU
         hHqo1H2+BQ+PLpLpZBXgGCjD13AMVebjMMIVUTOPrG4LeplhbCF0Dmn9Bqwzz2bKzKTZ
         pA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4fbSZrcbEX7pFS60K+snXC2z4cFQZ67H6ZAP0NTDTDM=;
        fh=bxtuj4IX+oyroDsd7zxiyyPTxE7E/X1k/UO56zBtQns=;
        b=iynnH9a9GFhPgUKAchwt/rEI0KbaqWk4+X5ZEbOyDpe0iR9YP6CJQDqu0HR1M40i4s
         2/Qga/FNT57egoB2sb5s8Sma+aFDQBGdfUDMFmfC1rkO6AL51ZW07cKfPCPwxYun8TGz
         6/6HQmTTjXggad6+o770jRMFxsyBb70B032CU9n57lPJO8TatZRaT9U5K9XP2gcJevr8
         0+VaiIsMH8w0PyydzIWGWFi0ipJtjfEP6JnpT8NGFGq6SSnroGRBM+0sgHdmFvXF+q0p
         OGfwjElFmWFfGUxP3WnDwoxzdordvAU32yp2lQ0FySnRaKJswRMZgKF/eFo1fNKv27Qw
         52tw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777325501; x=1777930301; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fbSZrcbEX7pFS60K+snXC2z4cFQZ67H6ZAP0NTDTDM=;
        b=OoNJzY69FWlY85Nu3J8mS73bwoJsIDYGffcMdW23nLsr/KSe6nS9dC6ZyUGNhEtB2h
         zlcJmtoTOGQzx0aWfYvMdupJ/YM09JDelQ5ZGJcVxkVPaN2vBKO+xVKcBC7VIE2ClQWE
         ow8zGDfeA9FCwqcY8nj2dOmytV6dsq+i79FuoQISwwxIx2kfY1wCC+sjDck5O3U6cn3h
         /DNkFgn52/Qddo4domN8YwqgCWzgObtf+r31fXlED1pnPF4JcvzX70n1a4frEeWmJO1s
         vsWnOe/FLD+h5gdd0OV5FouGFQPQ7jH3a8u+GchCCmB9XT7+OSVGYG2AL2cEt+L+B9ur
         ORvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325501; x=1777930301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fbSZrcbEX7pFS60K+snXC2z4cFQZ67H6ZAP0NTDTDM=;
        b=WoboHvGe9wOoqc6Je3P8HIggCEtdsEi2EH/3oXBaw5aRYFmMs89iNUHMpLvcQzzITR
         HIF+2QPlpQeld9P2HglMUoQHI5+UFTUbzgDHr/feiALJEYjJ3YwefiF/pD5k1XbyS6+r
         BJlPzjbKaPy68pN59Cjb7q51vsFv6EyllMzz8UAFRJB6Bh9X8XNpaAMBHqsu9KygfBUu
         3TbBsFb8XBOfJWDzevZ3KXwShfc+Rg4g/OHAmIb7TqzY1TQ99fWEW77cxLDRghcPSyjn
         zuPIhciRyXJBjtamliLgxbhJuqo3IVtkJRVcGalm8SnMPzQvVPSuZdORTDXHw6XSQeP9
         gWMw==
X-Gm-Message-State: AOJu0YxlJLHOXhiUALEyW1B+ZZvisPF56minjDRM0AUrC80SARUYJRIg
	nft4MjPbbqX5m33N9ZL4d+tNCzGKFSzOXPS0elgAuc1VZktRdywG3jp+Y7e0PKwm8+fSTIjtjgQ
	Hn2vFlW1TfvsIgLrweT5UI6gt0y5TdWFaLUaIxUWk
X-Gm-Gg: AeBDieuIwTpPhzxcisEBbtM0sXLIFkJPPWxsOMBYfiZ7xuyZDnrbEaFT8iyYSa95oXK
	P5l4KqO4MmL0pca3LKlaJp/nL0fz/AlRPWYcR25ur7d10u+43mM/Bqnc4TzSssVOBGFJzwmiwty
	/oXX9EmhyuPRENAhzEoXw9b09PF6RWrEpjCreI/gMsW/tEglY7ujWSQAruslxjdMPPcXxNJyicx
	inqPYfoznCBF8uNPZe4mqq/Q0mWYr2l8VKcKjsGYvxHWPNkOBVKgFcnoxscVz1p+r4Kvx8U36Va
	MWPaqw+wcsDmm7c4jtcPu19doHUhNg==
X-Received: by 2002:a05:6512:3c8f:b0:5a4:505:f62f with SMTP id
 2adb3069b0e04-5a746411871mr173644e87.6.1777325500555; Mon, 27 Apr 2026
 14:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260423212316.3431746-2-dmatlack@google.com> <20260427210529.GA186381@bhelgaas>
In-Reply-To: <20260427210529.GA186381@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Apr 2026 14:31:11 -0700
X-Gm-Features: AVHnY4K95rEzKgWcXKT0jFnCdsBpr0VFFFUI48Oher6g49BqIzQIKoHjNP8bc8M
Message-ID: <CALzav=c=99653vuRa0S6cyAuTfP-PWFpOdopYArihOBLor6eQA@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI core
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 2:05=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:

> > +++ b/MAINTAINERS
> > @@ -20555,6 +20555,18 @@ L:   linux-pci@vger.kernel.org
> >  S:   Supported
> >  F:   Documentation/PCI/pci-error-recovery.rst
> >
> > +PCI LIVE UPDATE
> > +M:   Bjorn Helgaas <bhelgaas@google.com>
>
> I don't think I want to be the primary contact here.  I'll see patches
> regardless since they're on linux-pci.

Ack, I will drop this line from v5.
