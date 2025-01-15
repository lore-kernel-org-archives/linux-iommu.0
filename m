Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF41D54E3
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736968813; cv=none; b=gQZNJQN+GX4nNbr4kFQC+BgbWhn7BLI4H69vsDelM6gfSMLSwhaLouGDpPYT9XR28fjwgTqtP5mEC94PCETEWQls6RMB5iyf2TeQEZe916XCbWGDLAKBXMHnEZUMSeD8S1pzt/Gc1RVfO9U5blaT2lGOr+5s4nYIRlL6M04vC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736968813; c=relaxed/simple;
	bh=FfdfdoVOmnHCEP6olqKJcwvaVKKmlmjCha6T3kGRyYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qb/XRu6cJKHYvML9FR4f+hhfdPk/6ftpni/nmvph2Lx74t+RPyDobrJ36ZQX/QcFCp5c81kxElrAOTsaTl5LzpOXoyLmdWFb2TI7SEsNa4E/HQt2JBhyHcv6EQ8MIiBpWBUpTMUOHrNpCFvKwqdi8YDIB5fbaFMzTCHG7b72fBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emBj9cVC; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emBj9cVC"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dcf63155b0so1281286d6.1
        for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 11:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736968810; x=1737573610; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxOLisM/r2vqci17iimcnJ3+oT6PlH7eXAcAxS9wH8I=;
        b=emBj9cVClIAJ8JdHaJEU0qRC5L78kEChM0md+158mE0dvUYE0cQY+ZSoSmuWNfT01F
         Sh2HThIA2URdCKlMr48LfBV8M8GRh3TFmF/YkiXtH5Q9gRittc6c6TLD2QcYK12gu/rw
         dHeh4PZlQHyza876iUti99BVDC/lk+rBohdZ2ldiWaYcJvNDVtUGpM7bu1vWSK84YqHZ
         RKzIvpHvYqwz+Bj9px4RPCi2BuBWOntBJfCtQXvm5BKL4wfTjHQc3tKynSMgfFAnWh1v
         ONR7lCZk2bEHXAv89PunQC0TeP6P8WedoaMbUNsoPp46CADadFRjHhuwsKbZEPg9zx4r
         4fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736968810; x=1737573610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxOLisM/r2vqci17iimcnJ3+oT6PlH7eXAcAxS9wH8I=;
        b=CPhcPdRWuK4Uii17WjxvYsxrBcMjFd+5kniADnyUeet8Qkv0KghREz8M2q5OiAGb1/
         svQ7R/PXDwABzbTqilS4oZpy8vTtV4pXjVoNSoA5HVekzTkR2Ks1GpbvJfQkMwWvwwTy
         ZFYKWb8cLd4SPYKxJ2gcTdUSIpnHCfUutOqHpEKw7AiVWqatzZZkBoRdFEEtXUt+emM/
         wKg0JFmEoYXkw9wrmPbFfOpJ7gW6f7PbGjq0lOtHWO8NB7KfdyJanWqzwr0YmG6owCdr
         PsEvgB1WMmtEPgm2QV3DNmpf7zx0vEbOlDP+Ptyl6KoZs0+a3rJndCurFlircm9DrcPJ
         /U+A==
X-Forwarded-Encrypted: i=1; AJvYcCVjbfT+cQxDwcFdIoiqj6vxOxf48ZJFyIozZ1FCQSrLQfQquq3qu3kCXDih5WTyZvSxeDuIcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVN/GIn5CZ+m26kJ1AxZ+DLlDbW9EcaRak8pKo8hwijBUdvGVX
	Y4c6/XVfG5KbB/TNA0Yv7HOcCjAGsjnVs8Wux5TF0oi2INMQ3oxjbDctBrMj86KkrpEHMPfcaQz
	pcA+LHfR3Kwp13YJt8OHLdxRs0p0=
X-Gm-Gg: ASbGncvj/I9q5RQWEuA4HR5oCuiuDlmW7eywLG8UBWw1aTCUY0rUzIYHmqOYAuFrS/U
	f91c7dEmb1PFCAf3PuPk3zN0xBk2OunAfcMkV6g==
X-Google-Smtp-Source: AGHT+IGcOD+cwuWLZQkHOERr/i/5IgCk1JWHnGSSNWX5DKVOVQdU9aSL/egf0MIChEkPIlmVmG4Q/k0vSx6KgLYio+A=
X-Received: by 2002:a05:6214:3c8c:b0:6df:8c25:2c81 with SMTP id
 6a1803df08f44-6df9b1d0b5emr530159576d6.5.1736968810243; Wed, 15 Jan 2025
 11:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <e4a649a7fdfc8fcf5f48a0bc4e76e5d546078083.1736868605.git.Slavisa.Petrovic@rt-rk.com>
 <alpine.DEB.2.22.394.2501141554170.2684657@ubuntu-linux-20-04-desktop> <2f1432e6-0d27-48fd-b034-475284f14233@gmail.com>
In-Reply-To: <2f1432e6-0d27-48fd-b034-475284f14233@gmail.com>
From: =?UTF-8?B?TWlsYW4gxJBva2nEhw==?= <milandjokic1995@gmail.com>
Date: Wed, 15 Jan 2025 20:20:00 +0100
X-Gm-Features: AbW1kvYPm3yU6yFTdo5RO9-y77hSL0M_d4qB1E2QaVvMAqTHQihGuVHlucVKfps
Message-ID: <CAKp59VEOiXo+OKwPNiomtXNCsfDURCXaDktooi5JSoTSdhc90w@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add initial Xen guest support for RISC-V
To: Oleksii Kurochko <oleksii.kurochko@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, 
	oleksandr_tyshchenko@epam.com, Slavisa.Petrovic@rt-rk.com, 
	Milan.Djokic@rt-rk.com, rafael.j.wysocki@intel.com, sunilvl@ventanamicro.com, 
	takakura@valinux.co.jp, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Stefano, Oleksii

On Wed, Jan 15, 2025 at 5:30=E2=80=AFPM Oleksii Kurochko
<oleksii.kurochko@gmail.com> wrote:
>
> Hi Stefano,
>
> On 1/15/25 1:01 AM, Stefano Stabellini wrote:
>
> +Oleksii
>
> On Tue, 14 Jan 2025, Milan Djokic wrote:
>
> From: Slavisa Petrovic <Slavisa.Petrovic@rt-rk.com>
>
> This patch introduces initial support for running RISC-V as a Xen guest.
> It provides the necessary infrastructure and stubs for Xen-specific
> operations. Key changes include:
>
> - Modifications to the RISC-V kernel to integrate Xen-specific hypercalls
>   and interfaces, with function implementations stubbed for future work.
> - Introduction of Xen-specific headers for RISC-V, including event
>   handling, hypervisor interaction, and page management. Functions are
>   defined but not yet implemented.
> - Stub implementations for memory management, grant tables, and context
>   switching in the Xen environment, allowing further development and
>   integration.
>
> Signed-off-by: Milan Djokic <Milan.Djokic@rt-rk.com>
> Signed-off-by: Slavisa Petrovic <Slavisa.Petrovic@rt-rk.com>
>
> Hi Milan, Slavisa,
>
> Thank you very much for your contribution! Which Xen tree are you using
> for development?
>
> They are using [1] and have separate branches on top of latest. So we are=
 in
> sync. Also, if you are interested we have created a task/epics for this f=
eature in
> [1] so you could also check there some details:
> 1. https://gitlab.com/groups/xen-project/people/olkur/-/epics/5
> 2. https://gitlab.com/xen-project/people/olkur/xen/-/issues/12
>
>  I am asking because RISC-V support in Xen is still in
> the process of being upstreamed, and [1] is the tree that consolidates
> all patches currently on the to-be-upstreamed list.
>
> While the specific Xen tree you are using is not particularly important
> at this stage, and using [1] is not a requirement, I am asking because
> it is essential to align on the hypervisor ABI, especially regarding any
> details that have not yet been upstreamed. Specifically, is there
> anything in this patch series that relies on features not yet upstream
> in Xen?
>
> There are few features but some things which are Rt-Tk's branch in [1] co=
uld go
> without waiting for these features to be upstreamed.
>
> Thanks.
>
> ~ Oleksii
>
> [1] https://gitlab.com/xen-project/people/olkur/xen/-/tree/latest?ref_typ=
e=3Dheads

As Oleksii already explained, we are working in sync with his latest
branch where most of the risc port is done.
I would just add that this patch introduces kernel risc-v hypercall
support on which only our branch on xen tree depends on. Therefore, it
won't disrupt any functionality with current upstream Xen, it will
just introduce kernel functionality which is not used from Xen side
until our branch is merged upstream.

Best regards,
Milan
