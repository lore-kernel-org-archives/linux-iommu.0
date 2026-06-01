Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7061937BE72
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341995; cv=pass; b=C8U7D+XfTAiNR42gbR8S4kjHpkO+SOPq6Sfl0lUbBtZ1cMY0g1QxyBHbkYe0oe2bXuORmAHAIHYuiVkh7DVUM4oBD9tqme8bj6M6nr0cphHHE1qMuy3Aax0ufsC6yPfw73R0O9+0P50VwX0jP3gq6Bf280P5y6x2X09o2r5sd6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341995; c=relaxed/simple;
	bh=hpACHX8gpPgUdVyv1/sEpHCxZ58roJACIEZKoxqYnKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRNF3dehuHJGR//ABC3eg9w4uK2vn3YmM8n17oQGeJnJR7KQHTaET5cK/kUSePtksWbm9VvIlJ72WXKZ1k6dW4p85VFUVrJsWaf25Sl4GTH9pkOXJk9Hscmr5BL6oLxidUldg6ZseHMXqYJi58yUBz3k7DajGVq2YCoRt55fjRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLu0uF2Y; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLu0uF2Y"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa67ddcf56so162e87.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 12:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780341993; cv=none;
        d=google.com; s=arc-20240605;
        b=fkMK8j+fUTWeBA2LMirh/g+9ygEkbJCWHqmk3X4/+C8cEeU8Y8qilOUYyKv0ev88aq
         DM7JHDXds+2kG72CBGx1wJ98bNYdIA2mFXxywQ8mKLZOQZs9xPKH9AOkVqTgXqoPo/Mv
         D31yfKVLe1dlsc2/GX071U1l6CXsep5FOqwzbA/o1jIXyRQ8UsTmzgA9XRtRhmYfkODJ
         ciCtCWE8+cvybadJwNiAigQV3PHc/9GRjukTJjeqnHzTITS6JZaodVbuGFZEeXx60thG
         tPyBWQOHFIlTjSIoi9FYZM0V88gMMG1iwnEd8QOcMfDBnuC+rNSodtweYpUaFeStGIs+
         b9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RUETtszvlgjxvwcIcmAnMCzPRiN6e9NnLidclBHMCNQ=;
        fh=vLCOWOTLRScN/2nnEhfMZp1gYHExq/E/6g0dJFwrjI0=;
        b=PmLrOwEeYUvFu67hSxryeriSIz4EyPoKjmHVdhjPB66SZoTjpQUBO6XjccMwgCuNaM
         twL/1DZDUkmelVVllfE2CfNtyvQJXVSwJn1PoHnfYUMsh2VfA1vwhmH1nHt4sYUGZL1R
         Q5xTwxEJo7ilq0vBFMaPKqA5FYh820+hqws4muHQTVZGeoHB1nfmUE7OVAozdQ7g39Dt
         kMEE7kL/JxUnCv7asng1NOcmzvCFsNw8eXPOOUeSPf4+1EqQPKTN09MyUoetKQwNEmV5
         VjO3F8GCc7AAaDcvNqTe0zLivdGF1L7GMUd+VVgy18URrdVMXbwoG03EgdEzGo1xoZms
         fc0w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780341993; x=1780946793; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUETtszvlgjxvwcIcmAnMCzPRiN6e9NnLidclBHMCNQ=;
        b=pLu0uF2YT0pHja0aLuJq2fGnDwDpBTPpiY1YInL5489Pol6Qbl0iDVvxc2Z3+2HtQa
         Ldo41Wg1gOnGTF+LRQduqjZFwfF7XeEABUQJvfacdmDo7boAdy0MJ8j7w3YzKbwMUmAf
         ITWEmu6YNkRmpj5MeoJuWO+KExS19vy2R7SSFPv+D8rblehrw91PheZppMF/q+OgjE43
         vWDm87yo41yTNwpUQmtqaQgTCh9cf0GL5AO791y7KrXGt/GbKO9djAZ1GTE9q202UNeP
         TziRkoUG7r0Rh11Q32TNSHypYYGdSPZ6PY21TFTgBzGpBKdIPkqUK3PqAM0+Ajk1S4Fx
         6DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341993; x=1780946793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RUETtszvlgjxvwcIcmAnMCzPRiN6e9NnLidclBHMCNQ=;
        b=jo6VMxQU5B6m7tjZKG8oEMQeMT+MX6XlgNvuE9CGWnvjZ0BtjMYCGyLQrNNu6BYiTp
         NnmR/vfah5FMMWrNJi8lTohSEhUJkDtNP3YxdHzvHyZPIHZXGs0xs6RPhxGRG9TQIpA0
         qFcg/+2gE0Et74ii8harbw1t4Lkjhraun2N33VS9ZBuRlQm22/CCkWswPF9puMtV5SzI
         EBfW9F366p2Owk3tu6kwq3xhW+a7CtTJz4tlRsnI8vZvpImU2FQSdvYH0ZkUXC0OH8w3
         7GetnbLQ7pgEKt/B/HEgIXLofhlFgw0rb+186nMvATWgIhdHc+i86fvALJTcm7ZNi1Df
         t+Gw==
X-Forwarded-Encrypted: i=1; AFNElJ9X0+r8NC+O5Ryozgl5bwgvPq5pwWw7focMEsriNX0OppBisOpmZ9UjgrcVC7h8GMn62w7HuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEARgxoYKOQRDKb757e4wz1zU7XVH3HJ5v1ZRfeEkU2fhNWTy/
	W/b/fhf3Ans0UDhY9SrmjlKS0LOceRNSasbhRsN5IQhaomIiwcLtURyqcg3sE2gm9fAIqorEl7f
	1z/QsQPhTGb7FlOv58MxPr0dS6wi0GGUhp9D1SKk=
X-Gm-Gg: Acq92OFns9kDEd7RQvw1sqiktPLb6LW3Yvgr5KjfyQViEFAxRFblxfdmjs/xzCqIgxA
	132MnpiD9XC2JGsRkGCtlmpDMpcW4UgzfeBNtHbcHx6Llv4/KFu2cKyx3jXbjEIyupiN47XfEel
	aU0PjDxuqN3QkR3wULe2ssaXJL1rGDBpIZCnVNPxwEi7L0lX8+wRYiIz9h2wcTOJZ+WLt0smjWc
	ULLgAXEH8ePhhZTXRJ3UiNxGe8nLNc8+LA6DjxkjPRL7QjUsVpW169LVrKFqtKOhRr4BwCcS8uP
	ON7rhO5VA9MUQRrUgf2HsDTSfgu/lb+SgyZnD4doSO7nEoQ=
X-Received: by 2002:a05:6512:3a8d:b0:5a2:9b28:d64a with SMTP id
 2adb3069b0e04-5aa75b3495amr52247e87.8.1780341992156; Mon, 01 Jun 2026
 12:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260528191658.2506362-1-xuehaohu@google.com> <20260601175252.GD2487554@ziepe.ca>
In-Reply-To: <20260601175252.GD2487554@ziepe.ca>
From: David Hu <xuehaohu@google.com>
Date: Mon, 1 Jun 2026 15:26:19 -0400
X-Gm-Features: AVHnY4KmXOz7naPVQt3RnYf5-sps0yuGM1iGSV6Zi0v2ewCpGm4R4O7z_6CO-gk
Message-ID: <CAPd9Lg8Um=0LJWB-QCqLyFksX=dTsu3hwuVXK9_CGRWTVBJppQ@mail.gmail.com>
Subject: Re: [PATCH v4] dma-buf: Fix silent overflow for phys vec to sgt
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, jmoroni@google.com, praan@google.com, 
	stable@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 1:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, May 28, 2026 at 07:16:58PM +0000, David Hu wrote:
> > diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-bu=
f-mapping.c
> > index 794acff2546a..1aabc0ee70bb 100644
> > --- a/drivers/dma-buf/dma-buf-mapping.c
> > +++ b/drivers/dma-buf/dma-buf-mapping.c
> > @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_sta=
te *state,
> >               nents =3D DIV_ROUND_UP(size, UINT_MAX);
> >       }
> >
> > +     if (WARN_ON_ONCE(nents > UINT_MAX))
> > +             return 0;
>
> The WARN seems a bit much, but if you have it then it should be
> arranged so the caller ultimately fails.
>
> But otherwise I think correcting the types is a good idea
>
> Jason
Hi Jason,

Thank you for the feedback. That makes complete sense. I will remove
WARN_ON_ONCE() to avoid dmesg noise, and instead add an explicit check
in dma_buf_phys_vec_to_sgt() to fail with -EINVAL if calc_sg_nents()
returns 0 (on overflow).

I will send out v5 with these changes shortly.

Regards,
David
