Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A5C31814A
	for <iommu@lists.linux.dev>; Sat, 31 Jan 2026 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822898; cv=pass; b=oOj0ynADEdXpDmNfk4EAfs6tJI+7HR3tfG1HjKaxSlG7a+AqXPwbiopzL8cgUmUWUI5xKTmZoAg07oRZKnHDbXQSY5E+lCWN8xTcaCRUQNXb3wYEVJhZRdFA8N0lI1/SfH/Tc+tpGSBJz/0TvYtMncucCpbTcFvbt4+Ur5OPWOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822898; c=relaxed/simple;
	bh=xdF1VHSvk5HtQPQo93L5tHmtzKUQ+pGnABByZHwLB/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aga6pViuKYmGJmxF+hIOxFmaOQrriOkPP4y+TG4XgfTshDKYI8KFiFIAaelZbE7w0jiWybD9JJLxt8ILJRrcktZjn1/Cvp/qCFg0Of/hp6Ls/k+fJvZ0iCY3H4O5qdA0ozM9i/zmK+FlCNrwrPOfLNgk5pkbb0HOUNmfa8JSuhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NS+RGObc; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NS+RGObc"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6610b05b37dso2158410eaf.2
        for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 17:28:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769822895; cv=none;
        d=google.com; s=arc-20240605;
        b=QNeqxfhdmzp6IKu5gQXPkoSWCk6U/jRgrcU+pSeuFrUHY1glhOOXf9apvNPTkEsIAI
         wG4sm1bYVZqsGW3nGl84ZaYJezXC7JPuwk9lbVKH9QlU8axIP09TI4OMNDy5sz97uqpq
         p5TQE2R09hUFJs1GD2RotPCCLxrbrNyWSxXB05vaS0hiGy01bmscaIdTTNvXXLyNvwXE
         6ofMUEQ4Xzwcp5qRj071b+u2RRUnC/Eb7akcZ9Oeigze9Y6uWjXO4y7TFsD78Zr2CAYV
         Rapm9rpLNjJqM72srYix5egZteT+hGlIhNT+XalJNZGhSh7YwqQ2rVbu2I33h9bkjDw8
         zyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hAdK8PSPpbAG4ZF3DDf9iwcQO/z7KVY0C1nZwOLHMfE=;
        fh=RyWW/5tHDzIll4zvkIifTdfihUI9kMDvbNUPUo6JBmA=;
        b=P9n6NJ24I7jpk2GvkadikVfiPqi4/OqGId7I8G/+kMF3YCuSmefK3bFKVihchMyqja
         4ZFaDWzFHNL1l2puErphW7IFkPOo9bWiv2Rw/8gp09sBMlM5n7ic/l9EPtC6xtPktd/I
         HCDrGY1OJhmen4QLySIv7+NO+2Ks1p5Yiax50dT57VgAgzR0DYuqefjfQBRn8Y4QrOk3
         5uWRkMZDlC6sjJTpgRZngXXsIqfW9fT0TjRgYQAsNG8h3R+VfPK+A7LEks77++Fiflks
         9EAeb1LUIAQchX5xEtV0gJltE13dzAgUXEvAxKhn1GTNdE5y50NOBbROByddAOmhfqUd
         vSYA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1769822895; x=1770427695; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAdK8PSPpbAG4ZF3DDf9iwcQO/z7KVY0C1nZwOLHMfE=;
        b=NS+RGObcCq6a68s9lz8DD3702YTOoX1zmm1bEgNIqdXW+NwqMdo+XHiTjc7T1hrs6x
         BYjMTeLKtQUTx9p4CYgCtnETNM0P0B0xSvKNJFl5/2PBMl2KpdUVMCEJ83wfsjeyyeb0
         nfp8ZGT6viDZJinCvoRLNf82umyG3IGdV95K2Ps4Quage1mQPtfvqAV0MplI2ZmwL7eO
         7fnVAHICnxLgdChGBIhuFDcungjDzzCNJ34e7jy6tfS7oOTFEYYDcKDOAECpyGYRwWX9
         YydXa8AX3oLKLfsNc752tTFHGyAu/jXTUxNLrwITAa9w6u8PkdPBy1/OxBVcDzoHsnJh
         W6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769822895; x=1770427695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hAdK8PSPpbAG4ZF3DDf9iwcQO/z7KVY0C1nZwOLHMfE=;
        b=HpQN5eQfbtABSohcGjsIH9ldsC0AixppmOopiTWAUkCVuaxmKpe1DKUdk7C7rGdrtB
         4XYcx5sYXiwyebzbd5ifxRb39+D/iCoeuPC6UUuvUOuVR0qC9EMchoL3gknnSN8aBH8l
         QOezyaEVlDrjju3o4x/UzHA6k/o6G6z+zHbDnQd2YVHW7bXBFrj8uJydOm7lNXn2H0C7
         REiGwpHiUrkgAL3jPyPaq2fRjFyNfITI6ljpX4odfMb03a/ioP6WIUi5mAzrA4M4DmFr
         +m6XTX1xvUukzwPBrgfFATTbZ77o7dOOl6IaBW7QfPz4HX4DZMDy7yQtBSMAmPc9GL5+
         /S8w==
X-Forwarded-Encrypted: i=1; AJvYcCVPlAkzfMsjDnq17GvI4RKGFP9eJ8GbJfACFvvZ55q1B8Q30vcSp/a/cljoIFOMa6f9lZGK0g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0lfK0mdEfoq32ZpslfcBi+KgmCaL2ti1S7Pbz7NfJfxCVKaUQ
	lDxBitfHpzXiBhG7NKNLrMCrqKQVMDgJnIEBUCI2LUnzbo4Mzx50jS7qS6POjmTB0d6XtVmRBCJ
	JuONgjkS9er9V/hd75p2hoAI7+kTlonlVauDPF4hHvA==
X-Gm-Gg: AZuq6aLtXArFYNx1+V41gA9p26YymXRrX8Vc35RTzOzHqnWWOgMob0L66nEsmoc/178
	ZtWlErrkmi3zgnBT18SwqXjpnqYm/rUoDcC+y6xNc1BIfMC5W330/hcvg5HqA5qf0BuRvvj/tR8
	Q7pSHXjMsQJgW5cCKUE8xwZQq2gTtC2+ykvNd60rtDoOZyy7DXxmm56gq6kUP38YSqKJjQnzVHm
	xXaoNzj1ti8uHehunCAn3aW4g0Oxb9/0hLa+Jrmn6UevQsiGxA9hE0FEXlzY8lT8E2DFXmI4UzP
	BPP1eA==
X-Received: by 2002:a05:6820:22a9:b0:65b:257b:a898 with SMTP id
 006d021491bc7-6630f0507ffmr2047585eaf.29.1769822894013; Fri, 30 Jan 2026
 17:28:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
 <72olk767l4goaqsrkyelhtnzg33nxbtwnammy4asnqxukbolnh@gwypmg6n5t3e>
 <20260129004640.GB1641016@ziepe.ca> <63c38161-762f-bff5-0b9c-0148140c695b@kernel.org>
In-Reply-To: <63c38161-762f-bff5-0b9c-0148140c695b@kernel.org>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Fri, 30 Jan 2026 17:28:03 -0800
X-Gm-Features: AZwV_Qj0tZjKAecspcSVxodkCX0io_Vn0UvzOmM88WNtFjCfrWhK6JNivTo3BO4
Message-ID: <CAH2o1u4_bieYiNUwCvhheKeRg6wvjH3Y4hZY9AGLcMbH5A-rDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Convert riscv to use the generic iommu page table
To: tjeznach@fb.com, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	lihangjing@bytedance.com, Xu Lu <luxu.kernel@bytedance.com>, 
	patches@lists.linux.dev, xieyongji@bytedance.com, 
	Paul Walmsley <pjw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Sorry for the very long radio silence. I'm back online. I'll update my
email in the MAINTAINERS file soon, for now adding my new address to
the recipients.

Thanks Jason for this change, I've looked at the v1, looks good. It
passed my initial testing at the time. Unfortunately I had to hold off
on testing for a while...

I've revived RISC-V test flows based on v6.19-rc7 + this patchset and
hit translation failures on DMAs from/to NVMe SSD. Hopefully
unrelated, still investigating.

Best,
- Tomasz


On Fri, Jan 30, 2026 at 3:14=E2=80=AFPM Paul Walmsley <pjw@kernel.org> wrot=
e:
>
> On Wed, 28 Jan 2026, Jason Gunthorpe wrote:
>
> > On Thu, Jan 22, 2026 at 08:56:12AM +0100, Joerg Roedel wrote:
> > > Tomasz,
> > >
> > > On Tue, Jan 06, 2026 at 11:06:44AM -0400, Jason Gunthorpe wrote:
> > > > Jason Gunthorpe (5):
> > > >   iommupt: Add the RISC-V page table format
> > > >   iommu/riscv: Disable SADE
> > > >   iommu/riscv: Use the generic iommu page table
> > > >   iommu/riscv: Enable SVNAPOT support for contiguous ptes
> > > >   iommu/riscv: Allow RISC_VIOMMU to COMPILE_TEST
> > >
> > > Any opinion on that series?
> >
> > Let's take it if we don't hear from Tomasz this week? It brings
> > the contiguous page feature people wanted and now that it is tested
> > I'm not especially worried about it.
>
> In the event that you don't hear from Tomasz:
>
> Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv
>
>
> - Paul
