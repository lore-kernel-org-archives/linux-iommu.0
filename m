Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605391;
	b=x6+11oLufx+WKsvj4GKARzd3wGm01I3xR+eSwGl13/jxfQPTiJyFI0A7hwk+MWr6wVEt
	 LZTDqs7E42tYag1K0rior8yj+Gx63rXcBcjtLYMoUwyrn9ekB+PrAdgpy2+7YpmQ9Fiim
	 lQaSQiRRSpk1ji/DagADk2GYozScF4/Z7hn0deSklmu6uNMWFI4B0+fMFP+MyunXZ+RX9
	 +P27QzN87uuF8SkZObHF5yMAVI4+8vO40sbzupA58qeL3o6Mib3u9ZU/0DzzeevbVFv0G
	 czMoZQ0clUnYjYwIYp3tSWsJSFKkIPn/0Wa1466CDtRZdlUt2c6/3aWHI5+zIvLV4ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
	b=CpQqB09/GN3b0SFFJDLUnVCj/HtGpvFESy7Y1DbAg8NuB33ayEXByWw48Wq0gh/1rNej
	 GPnuzmdqAXe/4XaOkSwOoWknWBXLuV3FESJqpi1caxsEPd+xLJvXJARBBTs3jOcNycdM2
	 z86lss0EJnvw7TL3bbrtXsQjWROvMpmhyMLtezGtxi0S7G9z4uvZUapKCrVZYYO0QTvF0
	 BTqWiX02YwL7TaUNPbtbqf0a0/K2UBDdcdOqvd9Ny/oUPUAZmcgJtpubjpiMge2R9hXIF
	 DyYln+kieTRP/QYQqtDpfmjmv4/3TvCkIhKtejGuVaQQC83jm8Q1lJby0LheAJk1zuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=EoYq0cHw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0FE606A31F
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 17:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D0FE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=EoYq0cHw
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so1702758a12.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 10:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792605389; cv=none;
        d=google.com; s=arc-20260327;
        b=ZgkPNdqR04OwmnnZmoffRBTN3X9PqkBNuKffjvuBqAKTaHFkLbc9tBAObpka/Mfirn
         nFFw+7LF7KRzrACFtnf5K3XFVJYGQT04O4Gnlp0Adkg0TV4t8SdMnwkJfK4StrBSKjFM
         pIl1pRzqJlaL5UJSXV47bbTBzuirLOALpeqvKYA28ulwqlS9SUGZivzWWg5MHZQpICtq
         2yo8i0zW6Wx7Gc/t7n41m60eG10BRz6HxGzhQvGWVm1hD6yGokCAjokFLGRITzEO5x5O
         MZ8jb3eHiKRODaJw6gA4Vxc/ZDK8wRYj/L0wIJv8g+5ir/JSbwqVdwecgbxYcGd0M+w1
         WUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        fh=Bv7oiFjnd2g56R5GLt2Go0Vg+RhtsMEa5h30lElxke8=;
        b=Z6fXr28Vi9EqXn3XvBiqRqJ+sFU6Vka+CpUdBpwlCTxAooCsVwyDt0iOZLmo94uWFP
         2CbpOZPJOjyv20gQA/B6JdwUnT0g1C6mgRmiqgGhpUjAAA5CAT8F+wemBYz5BWP1NABO
         csLicsYEiG5WXqSK5me4sfEdcQGtUdCYUF/d25rJmLrx9yCQ5XzglufrCLLEsgm71Tbi
         lIV0doavJDfgN12LzynrfSp2Nvu/kkSe09FIKDjRNUBdQqinV5EehSYSTfObR+DjzQ2n
         mnKR0M3ZbdcLoxhyOCpQSMwa4bEXyfdqD7n2RylwS0ig/YaVmv/D9yzuHfQ18Ly/AHa+
         LJ5g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792605389; x=1793210189; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        b=EoYq0cHwrrywoSQhFH/3j1jMjJk7Uk14uTMReh+5LLX9X55/TA+FZctHD3EjrHFy4o
         +HS56mdn1VUiJIEEgNPIxpFYZpz3CZiPKlPyhe3/M2PE8SmhI65EMoee5nNXBme6Uc1H
         0skAmL1piBWcirj/MMj9TzVMSAf1BlH+GTfLg3qYAJh+MpQyvXtTUgH6E3wnk1tMode2
         BPcYUQsmsrFv8njxXSWJoyvfukZ69Xbw1262fBTnmfpy2+cWSMc8ekcE2X2Xb2k/Jzrm
         /CkwlIL30EAuZCNOXD8B41hialtGS1V5eoNZVjSuXDdSh4FrZYkYGWGR1314sLu0vV9K
         i5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605389; x=1793210189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        b=ioJKkMFkNcnFu2JfYYlNVFoRgbQfm47e/4e5ViWYbCU/QHzGuC1eR4Y6mXQVds5GDJ
         RJsy+DscoPrN4XfBhZKI8ctFvtOWU0jJqeWHr9eif56w4QzlgiPsdP1lkjIkeRPsFdVk
         +pTNZSTQZYdhTvYt2ycEYuFvMpAQbJsYmWSwjr5VkvXNc1oqRxKNUwvnN/I1aet6yWso
         DkvdF1l560PResAcnNeKNpyFsJK1g8JaCbj4REQLtol2yf1/OQk5KtquGfAjaXc7pGPT
         OAcI8nP2HjROlWZ7cJbT0g6GjupE3cnlpzT3cDZkEqHXrjqHHTGpZkEg7E8fWm0Nm8WA
         6J8Q==
X-Forwarded-Encrypted: i=1; AKwUvBx39iMaNT6NJFoeeRKo8gpLGpNQHF1bnOJ0YPvTb22Fry0nJLot4Z6aDHRgI8xe1Tq+TDTVlQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYICs8lLzMuonCF1A1epkN/DUES2xFEvCvRMHF5BEqsFHF6MI+jd
	sfBf8ZBzICoDYhfIOdjZ/H70oi7OWUrOcvzMt+ENwlhMuNMgsFvOpwFcqoZm5EaxM6ex5wYXWqt
	V+4dpPYyXR9Fuh46mhN3O0tDOkF325ZgmxOxtvkBcIA==
X-Gm-Gg: AYBFou3l6XthDuYcXFdXftUBvEAN08Y0ud1/TcRlt/O9tmYCQ/oYujA7zd7yFYkW3gE
	WmCY17Xg1xXxZOd9wLD8/T42rBJhdsQvx8NW+I8y9o9FJiha2y5YfhvgbLIIQclFMLVD52mN3Bb
	SwmcqkWvyFKMMdra0qnJ09pCXkiePdyf+5wrldiKzrgWdn29TWZqf47RL9P9q0Qy9kZCkrZZ/Yh
	ywi0TtXMhfwT3riIfHl4OQWzS/VcHm/GNLOFfP7MNZPZ5eONRWZvPIJqF6qmjAQYjRu28vuPc/+
	1qfxpdv+GjhQUFt9gq0uC8BFSqn5D2yyQ5nEXDiWEkQSZs590Qxz/lEAu1syKvx1qk83lbl7FsI
	yItmNCcdYYAxZVB2dZB3BsOa88k6PGvVhr6L5gpjQyWAq79+0LhD63U41rYAIKZRrf/4=
X-Received: by 2002:a05:6402:458e:b0:6ac:686f:91db with SMTP id
 4fb4d7f45d1cf-6b408e9f045mr1964734a12.11.1792605389455; Wed, 21 Oct 2026
 10:56:29 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com> <20261021174006.GU3008132@nvidia.com>
In-Reply-To: <20261021174006.GU3008132@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 13:55:52 -0400
X-Gm-Features: AclHuK-Q6MQhxMIMUURzzci_OOwzGik9EFivN3YqqlGA_5OHu0xT6GsF67-BzDw
Message-ID: <CA+CK2bDJzo44K0X-+5F77E9g2dmqKdwZvrUf-1SkC7ewrgEgzA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:40=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Oct 21, 2026 at 01:27:22PM -0400, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> > >
> > > LUO and its file handlers validate handed-over state with monolithic
> > > compatibility strings ("luo-v5", "memfd-v2"). Any change to a seriali=
zed
> > > structure, even an optional additive one, must bump the string, which
> > > breaks live update between adjacent kernels. Replace the string in
> > > struct luo_ser with a feature header, so that the target kernel can
> > > accept or reject the source kernel state per feature.
> > >
> > > struct luo_feature_hdr is a fixed 128-byte header: the serialized
> >
> > This patch is all wrong; 128 bytes is far too large. For every _ser
> > struct, we only need 8 bytes instead.
> >
> > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > 30 feature flags + 2 reserved bits for flags extension). The last two
> > bits of the flags indicate whether an extended flags field is present.
> > Each extended flags field is 8 bytes, and its last two bits indicate
> > that yet another extended flags field follows.
>
> I thought we agreed not to loose the string too, it was a tree
>  string -> feature flags -> individual values
>
> The string is the emergency if we really badly mess it up.

Yes, we'll still have the file-handlers/flbs compatibility strings.

>
> Jason
