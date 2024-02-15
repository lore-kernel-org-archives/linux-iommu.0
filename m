Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F15611B
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 03:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707968030; cv=none; b=pUx3sIxd2nqCxCqK1mBjUsZZrukNIo7RXRKlztiZAgXrb8ncBtPzh0mCjhc2T5XJNTHOFCTdTKge1aYKbaOL6tzDmA7GjTykGjvVJ1ZwFUrVqNb599u1jhMR2KSwWBoeuzkvnI7JuDQp5v0x2uraNNHq5q/7EwRErHfyPeSdJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707968030; c=relaxed/simple;
	bh=TCZSJ/XNJaPFnnPAuJVmZMNZx3dUX1ubTXjBc6BND2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulKdOIUNIPW2RS9cWg+TtfPE6w27TvzQ+MLj6GQct+1nH4HDaf1X1Eb+8vJI6vl1If45XUuvjTrsMvddsOdHhGMW488/jPR9wzgyQIq5TOSPLK8Eh1cKR1Ll3O8lyEpH2IFNt+2p+UgyvyDMuwGixVNrehCzpl8s/4eafNT4VWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pt4gQ5rp; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pt4gQ5rp"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4c01076b9faso231526e0c.2
        for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 19:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707968027; x=1708572827; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVf6gZc4QGYJ3h+idoxj2vV7qjkpHx1O2OfEs7P0+bE=;
        b=Pt4gQ5rphbJA3R6cWqdSk1u3KCGN3HNTG7k8K5/yl3fITf8u6L091pB3nMic91ngS9
         wxBB7y7O8tJrrpSAohqpzrsj6NHuhCwTlkiJKeDNW0ceJSvlL32QEBmn7N5QP0ow+BlW
         /9ggDZ/W3VfvKJNm94byfURDn3e7utv/G8vZObZ19o5mbjimo8sdPhJ6sjxrtvX1EpJy
         3+0FBBfiaT3A9iQBmL92jJdAoOEb7ApRqfKW/btL14Rke+QFmGW4fcnEQFOMRwXLq+xY
         gpZ2HaGS94aKsL55kNWj+qnAo1jhQwPI1gAj65hCjOtS/jdL4Gl2UK3Nio3Ng9FgI2at
         ewmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707968027; x=1708572827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVf6gZc4QGYJ3h+idoxj2vV7qjkpHx1O2OfEs7P0+bE=;
        b=Gs41vTfN9qOoSdW7EihT29nfY1235pfQxRZSvHSRF6n6AClkJVhrQpUh4sZFKbkGIw
         eB1I3A0m+aC0aayixgfnIul8MZRi63sqVoGfjzwQ5/kuITJoFY/jJijWK3j1l7fPuDSN
         gRMoQRLuzuZxICgNu0dPOOrkbVHi2/MCI1iPtwWVi352wSD+okbq1rDEcN8SwVtIqx0s
         UpnlBJ+sLLPsBPYWY4Clpkm4kbMzlBLBo2aH0IlG5m/zuC3nW7D5vngsot6UvgQ+lbaI
         YUh7wJTwPqOC7M5LkkISlanyjlk5G0lgAoFOZ9nxgsAPrC29pIwr2aOdANNbvx7g02S5
         T1iA==
X-Forwarded-Encrypted: i=1; AJvYcCVoYORWHtOgKHpp+vG4lrT8AK8hcdRoqH70mfMT7639X8Pdg1T/5Kikk5AhS6Sh2OWwaiT9vtFx0GtOPkHM5ivijhIpw1E=
X-Gm-Message-State: AOJu0YxrLmnxwkyJoA1s+6rcqSoeCQxX7ythjGmK5As2LNUS6ZiT3tXi
	GLxPlVBv9OEoO147FarfqMDZaDcpz3uMsT1S8ZU4EsH3EKn4aQKVhlBRBq7RU4+42DdBZ+wv2m4
	0Xhm+UUtUZ9ASGpQCMJWXRD9do2jwENNPY8Ei
X-Google-Smtp-Source: AGHT+IFRu6qWXK6iKFa30lwovzXRFsLYhJ1iV7RGR1j8fU1/0lchFPKaCqnUKJtNUxrh1UZmYKHIncUqE3mKqQUY+K8=
X-Received: by 2002:a1f:db01:0:b0:4c0:8ec:2331 with SMTP id
 s1-20020a1fdb01000000b004c008ec2331mr423435vkg.2.1707968027271; Wed, 14 Feb
 2024 19:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-2-vannapurve@google.com>
 <etvf2mon464whscbxqktdd7bputnqmmwmoeg7ssixsk4kljfek@4wngbgzbbmck>
In-Reply-To: <etvf2mon464whscbxqktdd7bputnqmmwmoeg7ssixsk4kljfek@4wngbgzbbmck>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 15 Feb 2024 09:03:33 +0530
Message-ID: <CAGtprH-95FEUzpc-yxQMo87gpqgMxyz9W8tiWtu_ZHhMW-jjuA@mail.gmail.com>
Subject: Re: [RFC V1 1/5] swiotlb: Support allocating DMA memory from SWIOTLB
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rientjes@google.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com, 
	pgonda@google.com, michael.roth@amd.com, thomas.lendacky@amd.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, andrew.jones@linux.dev, 
	corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com, rostedt@goodmis.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 8:20=E2=80=AFPM Kirill A. Shutemov <kirill@shutemov=
.name> wrote:
>
> On Fri, Jan 12, 2024 at 05:52:47AM +0000, Vishal Annapurve wrote:
> > Modify SWIOTLB framework to allocate DMA memory always from SWIOTLB.
> >
> > CVMs use SWIOTLB buffers for bouncing memory when using dma_map_* APIs
> > to setup memory for IO operations. SWIOTLB buffers are marked as shared
> > once during early boot.
> >
> > Buffers allocated using dma_alloc_* APIs are allocated from kernel memo=
ry
> > and then converted to shared during each API invocation. This patch ens=
ures
> > that such buffers are also allocated from already shared SWIOTLB
> > regions. This allows enforcing alignment requirements on regions marked
> > as shared.
>
> But does it work in practice?
>
> Some devices (like GPUs) require a lot of DMA memory. So with this approa=
ch
> we would need to have huge SWIOTLB buffer that is unused in most VMs.
>

Current implementation limits the size of statically allocated SWIOTLB
memory pool to 1G. I was proposing to enable dynamic SWIOTLB for CVMs
in addition to aligning the memory allocations to hugepage sizes, so
that the SWIOTLB pool can be scaled up on demand.

The issue with aligning the pool areas to hugepages is that hugepage
allocation at runtime is not guaranteed. Guaranteeing the hugepage
allocation might need calculating the upper bound in advance, which
defeats the purpose of enabling dynamic SWIOTLB. I am open to
suggestions here.

> --
>   Kiryl Shutsemau / Kirill A. Shutemov
