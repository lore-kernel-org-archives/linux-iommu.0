Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E630437268D
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500431; cv=pass; b=S4bK1ye65g3hbL+ITjs+alyMHJAh4JIdts5jbSPovObucUnT5ICIDltxWdfbi04bohGeQa9f8rPosLZYZLuS9Hz0AlMlEavFCiNTvT7x4a5fe1W3clVgmpV7asomH7PoaZ+Cr5bLzLb+fIXZ8pZut4VVdV0OwVe0GFj1sp5RaGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500431; c=relaxed/simple;
	bh=EyEdGT/UwThY07rJVuH5QIYg5WfjYK/VMng0MYb/gWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SC4rPtuGCAOhPB1iB8OEq2HkXUpUU8MJVgluB1VDlP8vM322C0iBHveqhs/Jb8Gfce49fuO+4MKZPxV85YJnKUbEgEUHmIMKNjoLldx0j4CDBPjhuY6vhMVp+dDoXHpxuenlfUAKBQlhtSKG+0x1fvSZ1uQ4EjWsh7d5U1wVykA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/gMUyFo; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/gMUyFo"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d836552daso1281cf.0
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 04:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778500428; cv=none;
        d=google.com; s=arc-20240605;
        b=CAZvFEBqpv6/6/BFX4Ir/On/kEMqVXdC1A2gh4QkPQyyrOyGERtaH6jeOWGXUJE5yf
         p2+1Kr73NbSSq3yYg/18ttnaPvC+FJEX3p9oP3Mt2nGmKgkGlvTJO+/AtXuAmq2pnkXl
         ADCLX/jmtrfpIDKNh7d7ceVHZXTzQJkypVI39nGYjrsDWY43sTeDiKKSVrf6uObtLzTU
         rHgX4Wx34VQJGCz0kszyZX/SnYPt7Io/AiGG8CbIX5ISn9VNlk+8MPyoNH+bimAjnGOG
         I+v9hDPPEqt4ees50GI8lzVrTkxa0RIMEaKI5REm8uZmtPiu5ToYfe6yGd8SE48VTnzQ
         ZX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EyEdGT/UwThY07rJVuH5QIYg5WfjYK/VMng0MYb/gWQ=;
        fh=yoErLcXr3kFt79qYZSVmotl56z1DMfgw21PDf62f7KI=;
        b=M5EU7t6EV8kbUBBHM4qnCX8yMamm8yvkyPZHPSyNHvTbjjwDsQxOo561i//Q+cbRvE
         UnpycihsYQ/REoqG4Qo2E/QGEcD5N0toqPLZ/HzJCDzERrAGPtdKxGmmGBThSRT0Rg7l
         mUkQ3o2YCOuvhXBnUbP0CPrOA4J5q5ejTDVPyrW9LWLWtbvXQ+hJ2BRhLeUVuumEdg8m
         3+a2X0ggTAi9MDrlWi5FDJmwGA3I9ljUGblGqWxgRSEJhpH6LLZa/gnOQ9ip3t1e8nCt
         HAFucY8zyqGEqbIpQygQozI3qR0zxQewHK8QLXSJywbuuE8N5JHtHTZlgr828By+Iupp
         fDSA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778500428; x=1779105228; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyEdGT/UwThY07rJVuH5QIYg5WfjYK/VMng0MYb/gWQ=;
        b=C/gMUyFoCZOy89KAY9pOCMsw0hd09Lunov2FrgaSZMAcJnlZDEvy0AVkB97pkzuz3Q
         INwm10gxdhcVyzVoc0tG3YN//o5tKnN0SuU0LQRJk7WeuE5SZQBnJPXhzdXqkppx8raK
         bl1zl7bWhdAeZKm4y73CFkDcv1/ADGPIFadHsTjGSqUmYeAExtloCkssLo8cI2mRlmy0
         qOhJsbhVdW4DxYCcHBGxTkvCwdd8BvXirorjS65icg61hfDNrljwFNvDHXxOiQ0oRGsA
         6wUx38ymtG1UaLA8WDeVZl16V4i0axSlkhzd98t1xWB4l/ZDgm9m9fDA7ArDFBCiQCt6
         rJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778500428; x=1779105228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EyEdGT/UwThY07rJVuH5QIYg5WfjYK/VMng0MYb/gWQ=;
        b=rSNe2XfthRW4DO91l8a//6cGs1hPD0jtHJho1Vkr7JGaKx6Jz65vqEGFX/kW/pNE5O
         GWzEdWkPKnzapbgE/rkcCzZ3ssng9JYePxj/wqqfQKcnI7QfhA5hOuldR5iftKZOBS3J
         PalsC3oyUwmLsX64rKYLi2iESTsKjdAI3PcbAxe054nQX2aOZ8b0WH/K5M+Py6NMkQ3f
         oRlQksS+Iens03IPU1gjwx7b9SGuXSxIqwLeafQjmqdoIn3hJpuhE4nxs/0/0Zk2QY2Y
         JfOulKwqNNfPRqQBpQIODCmtkwZfC4SfxQJRPqFQtxiryPsSM7R7e02kuPyVG1FvXgVo
         Gygg==
X-Forwarded-Encrypted: i=1; AFNElJ/N6LeCRCb/GID8BQamTnh2zgdIbQRNJbl7j6E6C1m0jamHO5B7IO8Rqz8g8WMbovV7P+33Pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVKdDTo2Nhx9VZHqaJIqWg9H1SH+Z/gmmqH7he8XMn+R9zc4/w
	YSFIewjBT1/umB/4DwmHNWwINH2QnJDkwW9H1Osae09rm+U282isDdVvEZsJla77OzTVnv3Zxuo
	yr3WYExIgV1gVeO83Ify2q4A7aSvZRw4/vhsAhdhJ
X-Gm-Gg: Acq92OH2dceSEHd4dbV8uDpsxmoLF+PB0eqSsuJTGtWyQ5eYkLQiX2Yh8VHtTHc4HYF
	RlIPpUV2bV4mV4qEwvjktsGoPi9JjIusUvJlNS8QxhsDkdmeKDNgCEDhpXwRA6SGyUxgaQNcvRU
	qNz9rsfe/eZyf88+WkA5v9qAAK/XhdAxoA5IYsIElp8CDBc4rFk1qoFcsNOGApy68D/qxnrFd22
	u0ErlLZxnTwW/eHKAjYZCzp2jiVm+FRoP8RoIXrQyiLipDeLO+vpk+SRpL4NnGhnlQ8uHbzXHDk
	46JXehhX1uKZra00p3vq10BdKl6oo1FSAHYq29R97mbnBUTZFUOXJ43VmSYtDQ==
X-Received: by 2002:a05:622a:8d12:b0:50e:5c9d:49c7 with SMTP id
 d75a77b69052e-514a046fbc9mr19494131cf.7.1778500427992; Mon, 11 May 2026
 04:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260501111928.259252-1-smostafa@google.com> <20260501111928.259252-6-smostafa@google.com>
 <20260501124716.GD6912@ziepe.ca> <afiODW2sVMeOj3Ag@google.com>
 <afoagb/wVBJD1IX+@ziepe.ca> <afofSPQbepd_fpom@google.com> <afsQTwO3eW+Ks2fe@ziepe.ca>
 <afxlufh3t3hRe4-G@google.com> <20260509233443.GK9285@ziepe.ca>
In-Reply-To: <20260509233443.GK9285@ziepe.ca>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 11 May 2026 12:53:36 +0100
X-Gm-Features: AVHnY4Iy01SZKx6-ZKVz0uRzPgk9VsXyMheNVJnPIgQawwYuBaPqoPjvouiwCBk
Message-ID: <CAFgf54rJqq_bJONpx85p+uB68i1oVAGZW40aZA1ufid_5fqwQw@mail.gmail.com>
Subject: Re: [PATCH v6 05/25] iommu/arm-smmu-v3: Move IDR parsing to common functions
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, joro@8bytes.org, 
	jean-philippe@linaro.org, mark.rutland@arm.com, qperret@google.com, 
	tabba@google.com, vdonnefort@google.com, sebastianene@google.com, 
	keirf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 12:34=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Thu, May 07, 2026 at 10:13:13AM +0000, Mostafa Saleh wrote:
> > > I was thinking more like
> > >
> > > #define arm_smmu arm_pkvm_smmu
> > >
> > > Before the pkvm compile of the shared code.
> >
> > Oh, so we rely on arm_pkvm_smmu and arm_smmu having the same field
> > names and types?
>
> Just for the shared code, yes.
>
> For instance this patch would require the features field be present in
> both, and then all you do is directly copy all the smmu->features
> logic into the shared file and that's it.
>
> > I don=E2=80=99t think that=E2=80=99s better for maintainability, I can =
look into it
> > if Robin and Will are OK with that.
>
> I think maintainability here means pkvm minimizes how much it changes
> the code of the main driver.
>
> Copying a bunch of functions into a shared .c file exactly as it is,
> then compiling the shared file with some #ifdef'ery at is going to be
> long term better than trying to mangle the whole thing to avoid using
> any of the core types and not directly share the code, IMHO.
>

There isn't #ifdef'ery at the moment, that's what I was trying to
avoid by introducing shared code.
I believe that can be treated as a library as most of the shared code
is about HW description (commands, invalidation, IDR probing...)

> Like my tlbi point for instance, it is not a good idea to rip out a
> little bit of the invalidation logic then open code a pkvm
> version. Use the exact driver code. But to do this you need to pass an
> arm_smmu through to to the pkvm specific queue management functions.
>

What concerns me is how fragile that is, any change in the main struct
can easily break the hypervisor, unlike if we have a clear shared code
and defined API that is used by 2 entities.
I will think more about this before v7 and see how intrusive it is.

> > > How does pkvm compilation work anyhow? Is it all rolled into a unique
> > > link, or do you have to worry about symbol conflicts with the main
> > > kernel?
> >
> > All pkvm symbols are prefixed with __kvm_nvhe_ in the main kernel.
>
> So automatically with objcopy or something like that during the build?
>

Exactly: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/arch/arm64/kvm/hyp/nvhe/Makefile#n96

Thanks,
Mostafa

> Jason
