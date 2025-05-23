Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468131EE007
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748044372; cv=none; b=ikR3B6/DdQw/2pFhmzRnF2gBHCZnZbp5Ixm8OKdqRD5OOF+U7oF5g1CoPEnW4sG0z6cdMnMf5BIhe4nxzjxrRZ74Wanh7ZFq5rkaJzkz5dzBdspz673ZSM1kV1yBer9V9+C/2D7upCG/+fNQrZrJWnt5E7bfhOpsuF4ehm4vWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748044372; c=relaxed/simple;
	bh=M9hXUG12dQEzCbLn0FttmzohKmhmYluNMb8mwDu8KaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvMCEn2PcLYCtmw6lNsbtu46NGVbJJDteYjZihS1BXjIO0CjudWAuU0PkhMOj+1//atp6JhS3KdRczyRTqerbI36hnxtZ5X/Nqtd1fMase0GzgMakNTXQ6v/+UqwW+j1TD1rMDfO9tY0ZV77OrzwLSuNpXsuja+OMcctbkrXKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQp+5UqL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQp+5UqL"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54b166fa41bso582080e87.0
        for <iommu@lists.linux.dev>; Fri, 23 May 2025 16:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748044368; x=1748649168; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0Fs7pz/z0EIB4gIzQ5oUac1XgvPmbJA7QXLi0jslE0=;
        b=eQp+5UqLcyphHDdCKT+Mzr2dKYyLqORF66sDh5z+bBdcIMCDdkP6HwGZPiqJUV3AYO
         KhuDK80twNFw4ntSMR3/IzVRRVIOSbpn6Q9/VDwhHsA3LeB465rqc/Y3bd9+UilA7zEW
         elsymXQtFI/PnME8BdxAUaoeVzC0vPzMSv9U58JTz/KfYagrRLfiGWzRNLfrINE3lf4X
         3zu33wLbfa+rq1gC2C+6fta1Gp/jDqLnA906sXce9pxEqoVaBnId/Pt1iPlpRGgeyJWv
         HP6TF+OVfP2x3X0nkawLE/y38nLSv9pVCqxhFG00oZz81yFVdg8DVNsOKqrRWUMziU4w
         ee/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748044368; x=1748649168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0Fs7pz/z0EIB4gIzQ5oUac1XgvPmbJA7QXLi0jslE0=;
        b=hyW2QNztJVqbOxwcrwvlx2Bta1RtIl2LHL5E1JVGfDciEnyt8c0bAB4Q8+YC/WPFbI
         mj7pM9WPbhXwgB5O9FVlKYQDnijBRfM8G/Z3/3bByzNXCSJ8gj7yfRib1bBsN7Gqv8w2
         HUUMI1B/xynn+8/pFf2t1ZFPG1QMqmqTe5XK+00tmnhA7T6KZrRz2ifhzmQvPWzJM085
         OTXoVAlu+eYJ07AB30qNkp6zEuhYblZW6PDIqsqABLH1eQm8Iks2TFkrZopCrMhRZet1
         h1Sd2tP8+277ET1fdFIbZFeNRxguxK4GSXL/2GIzFBAFK2tfR5Ma1Nno7AXt/r3a/thL
         +lBQ==
X-Forwarded-Encrypted: i=1; AJvYcCULlwKMscqp8FeWdfscVCZ83O3RFGbv1wyekNdSVQ5DlVqsznvqmyYyZe63ce0CzUf8+b+xRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyA40r+RZu7g1/1W40UIn1odD6LfPZOAptdk6jcuZbcn273y9s0
	cb2MJZoy3tQi1yB+txxA19Evt/3T1dgXKO860aIV7Qm1rQfvoFC1saWT4CQVriRtj6dfMfnJAV6
	F6Ub6pBb0DWVh8B/ycPMn6qxHHENwnN4leR99i2mQ
X-Gm-Gg: ASbGnctK3MbUX8dooe08dR+xySjBUmRamh83fA26U69vus3pCiGSuoTJeC1uaxUIjY2
	iAlbcNAPLyBdpa14eb+svrhXiYmUkWCY8AKNFma9cjdYVDAWVpqedlS4uGbl8Eol3RXN3WsdtEo
	U36u8AKWuW1ecld4JwnjPTl6hSjH8GLc8rSSuv+Ci7T1k=
X-Google-Smtp-Source: AGHT+IH8NaXciis2Ap4OiAGLGhnQ9Gb49M8mILiHND/efN8rg1+lP6OwzfG1AqHxHePd1mY4UTi2wwWCDeKWqQoTLAs=
X-Received: by 2002:a05:651c:2109:b0:30c:1358:6400 with SMTP id
 38308e7fff4ca-3295b9aaa59mr2604071fa.5.1748044368078; Fri, 23 May 2025
 16:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <CALzav=dMSLy7kt6sJtRqAK8tOZwFz9Ktp3vzqggdD+J_aPVycg@mail.gmail.com>
In-Reply-To: <CALzav=dMSLy7kt6sJtRqAK8tOZwFz9Ktp3vzqggdD+J_aPVycg@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 23 May 2025 16:52:20 -0700
X-Gm-Features: AX0GCFuV-LnW4e9goCqhdbKeeGQfbApHZTPlR-dVtjKEnQHhsOcPMKn8qNDcilc
Message-ID: <CALzav=d22zi4zzebPJthKGF-uiD3qRTeTJM3Q-LB6UVBiwaAvg@mail.gmail.com>
Subject: Re: [PATCH 00/67] KVM: iommu: Overhaul device posted IRQs support
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 10:13=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Fri, Apr 4, 2025 at 12:39=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > This series is well tested except for one notable gap: I was not able t=
o
> > fully test the AMD IOMMU changes.  Long story short, getting upstream
> > kernels into our full test environments is practically infeasible.  And
> > exposing a device or VF on systems that are available to developers is =
a
> > bit of a mess.
> >
> > The device the selftest (see the last patch) uses is an internel test V=
F
> > that's hosted on a smart NIC using non-production (test-only) firmware.
> > Unfortunately, only some of our developer systems have the right NIC, a=
nd
> > for unknown reasons I couldn't get the test firmware to install cleanly=
 on
> > Rome systems.  I was able to get it functional on Milan (and Intel CPUs=
),
> > but APIC virtualization is disabled on Milan.  Thanks to KVM's force_av=
ic
> > I could test the KVM flows, but the IOMMU was having none of my attempt=
s
> > to force enable APIC virtualization against its will.
>
> (Sean already knows this but just sharing for the broader visibility.)
>
> I am working on a VFIO selftests framework and helper library that we
> can link into the KVM selftests to make this kind of testing much
> easier. It will support a driver framework so we can support testing
> against different devices in a common way. Developers/companies can
> carry their own out-of-tree drivers for non-standard/custom test
> devices, e.g. the "Mercury device" used in this series.
>
> I will send an RFC in the coming weeks. If/when my proposal is merged,
> then I think we'll have a clean way to get the vfio_irq_test merged
> upstream as well.

This RFC can be found here:
https://lore.kernel.org/kvm/20250523233018.1702151-1-dmatlack@google.com/
