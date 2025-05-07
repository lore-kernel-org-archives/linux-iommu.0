Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617CB156C6A
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 02:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583700; cv=none; b=LTkibh7m8Fn3fvX4LKLxgSIxUbXTvuF5djTP1EA0Teoid453dGTSHSWDMV4n8tMsFsKresNVNFeHjOVzIzzWN2C5xrOAGhi5EB7U/aWnz8m6R7VOHCskeYw/WxOPfC85FWil4mSBnxj13GK52D25lZFUStEHumME+1w075mSHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583700; c=relaxed/simple;
	bh=qSMkAw1f8q81qejiBhHJHWaRJ9DONSFXrsMIQ0Kcuag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noZZxl1guVCBQlSiWpLd9erEwTxniujIPsBvFaMlSCKR+fCkunr4ro8IaFOL67OCcnm93HWy+0iQ+vOVOZf85nQCrzBSGTpWmFRxDmQCXqPnrEWzpUKc2OFaFXuZWIFKI0SWjRxKfxTzwq5ZvGYNIAuAIjTDmSK1ljkpeICZJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+vui1u+; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+vui1u+"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4c32d6ddd50so1815763137.0
        for <iommu@lists.linux.dev>; Tue, 06 May 2025 19:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746583695; x=1747188495; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+qrFXkta/PnXyYE9c+0VrJXrgpjBrI7s8joN+UR3x8=;
        b=G+vui1u+fNzozTMa3jnHXD97Z3jff43XmpTteiF/u54OzsUpXk3GnFpUkwrTcoiqOG
         3s+Ykl+Wk5R1ap9Vvr95wSbH1R07E/cdNSoDakUcKtsmv/948ZviyNv+LaWj3n9RQaAa
         IBtmVcXSu75ld6TAj5oheRSkHWkzM2CgqKRQXhxC2ch0Da2d8BibvoDmMAJt83glfpdq
         xWemTINRTQrYLjM6fqxZCTSpSh6vSunkuBX+Q3YO36RZ3pA3fJoyl5kTlqhiP6GNrq6Q
         2003gZee2PvubSPyIpMz+oQaoun+bxom642Tg9UWNYj1z7hPfiEODtEnPYFuAGDneOlf
         B1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746583695; x=1747188495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+qrFXkta/PnXyYE9c+0VrJXrgpjBrI7s8joN+UR3x8=;
        b=tOgXbd4MR9HJ3Xvteu3htf8rf+qVN8L5D1iMs6v2yIha136RxEA/wWn+r2MsOIxPRI
         UMArDYYgAW/7ck8NxOdR4GnN5U/LEBu8LSpVncHBWVjkjI2kiR9Hf/WM2WRPsaRmvA9a
         XegWeJlrTr0RuFcZBWUJhqidh8mkxnSnOmKwv7vnXjTRxAp8doWgkEiknQ0/7DSL/VTJ
         Bx7S0a/kLq22yvO2zK/dwjqWYeYN8zrjakCSgLnqilOWwndUf4s1m6/2JCY87NHsNL/R
         GKNPWIgpqFFIAKltpZhDF+pArLUeZM8ew1oDBoOeWemprEEe25FH8J+p+9VpdBXt3T8r
         pOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRwOGi5ZswZPtOZ7V7NtUEWiFcE7YtLrBE16Wph5uOXfwoLTCi014V0DrhPLlEEFlXRR6a3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxY0EFGmf9PJn9jXop83IagR4UYpFb3RSczuPr8E9ey8cnapvB
	0OawtxobWr2Oi6vHpdlRP53NPnZ7SaYFxSIiMeOKfA0oWTKSH4USsiY1t3ILFUEh/H/j5EDS40p
	KZfNLMQrIZAJ6IrKK9pZkOrVxfr8=
X-Gm-Gg: ASbGnct+XFaiqTio6MHoljwWSeCHjmxuucAvj6a0Ff6bYYWWkZU0w7JgyobJTj3XaKt
	MGEv4ivesN2q3QnWQJVxMYgGH2J2jr8vCayUN56peB0tE3ilIzil9wnS4d+YD+3I33cwghZlf8h
	XKxC3LEh9mHxd9z76yh9ZvjA==
X-Google-Smtp-Source: AGHT+IFGG/EFE44jHQPco6sg4x6ua9hc7r7AEXYdg1rXn7toxfyhfCDLkSX/VWAeKMgeiBIJEhaIgcho8CEMgZGeh4s=
X-Received: by 2002:a67:e708:0:b0:4d5:cbbf:456f with SMTP id
 ada2fe7eead31-4dc737d1739mr1634787137.10.1746583695176; Tue, 06 May 2025
 19:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250506030100.394376-1-xiaqinxin@huawei.com> <20250506030100.394376-2-xiaqinxin@huawei.com>
 <CAGsJ_4zBz0oZGpP3dTzsjmw0oJbWm=vkKRS_kjBso7cvKJGjuQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zBz0oZGpP3dTzsjmw0oJbWm=vkKRS_kjBso7cvKJGjuQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 May 2025 14:08:04 +1200
X-Gm-Features: ATxdqUFB9KwDvzR69E_IJlSczMXQzzrRWd2WU62tnUQyjqIE1rn7qXrRg5eqsAI
Message-ID: <CAGsJ_4yEmSGGKFxCT_wioEOaLxAzxNiryR42_hW9-vbu8WgBUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 1:52=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Tue, May 6, 2025 at 3:01=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> =
wrote:
> >
> > Fix a problem about commit (8ddde07a3d285a0f3cec, "dma-mapping:benchmar=
k:
> > extract a common header file for map_benchmark definition") accidentall=
y
> > removed that padding, which has completely broken the ABIs.
> >
> > Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>
> Please add Fixes tags and cc stable.

We are *NOT* adding any field.

Also, the subject and changelog are not appropriate. They should be somethi=
ng
like the following:

Previously, we had a padding field in this structure to allow for future
extension without breaking compatibility with user-space shared data
structures. In other words, the padding was reserved to maintain a stable
interface for potential new fields.

However, in one of the commits, tiantao accidentally removed this padding,
which could lead to incompatibility issues between user space and the
kernel.

This patch restores the padding to bring back the original structure layout
and ensure compatibility is preserved.

>
> > ---
> >  include/linux/map_benchmark.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmar=
k.h
> > index 62674c83bde4..2ac2fe52f248 100644
> > --- a/include/linux/map_benchmark.h
> > +++ b/include/linux/map_benchmark.h
> > @@ -27,5 +27,6 @@ struct map_benchmark {
> >         __u32 dma_dir; /* DMA data direction */
> >         __u32 dma_trans_ns; /* time for DMA transmission in ns */
> >         __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a =
time */
> > +       __u8 expansion[76];     /* For future use */
> >  };
> >  #endif /* _KERNEL_DMA_BENCHMARK_H */
> > --
> > 2.33.0
> >
>
Thanks
Barry
