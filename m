Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935A27C153
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744343725; cv=none; b=FpfQZIft7wPDUssegsGjgZKoC10RgFJfAJxMr1KhdE+cs6Akr38MyoJpG26AkugHwrANHt/VLaWwwVnBD7G0ew3/vkDqheAKXC5wDpa0uCcq0u9VyM8uXWL/nvlajShRlQlpH74UD7rJwRzuHh5rVJR8kkOEZNX496YCAvXov6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744343725; c=relaxed/simple;
	bh=7scZtjfdkHQl58bOfY5LOVON22T34d3o6bVcYyyKkjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lm11Kn4TtUQMfDAfpxa+blHlfnzuVCDGS6h/A8hT9YkcAukbw7ZQyMd04V+bm/GtOX9rNkaHUvv5Sb56L2beZQ6IHbGJZzPbBlwF2p8psQsgSv9Nv//Wa9nBAs+xttK42FlWaxlFIfOFA/iZgwnYSK3VcFKaYNSvqpmRzCF7M9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bSRcAorA; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bSRcAorA"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54ac9d57173so2854233e87.0
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 20:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744343721; x=1744948521; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L24yBt+u1d+twFNLziQnDE2J7d+Rot77UD9S9Uo4aPw=;
        b=bSRcAorAktYFL4c6h/wkqmPM5a7ksoGAmWkxfa6911leNgRwohctX7USW9zjHXwfUS
         78WXjydbINS1I+2b1aLCKE+skjZ7yuNUqMWM8fzOBCNy9w451AB+aC3ukds3HMBYpKB+
         m7r33yCrH89wreftBQTUJHcu6hntpvAiR92A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744343721; x=1744948521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L24yBt+u1d+twFNLziQnDE2J7d+Rot77UD9S9Uo4aPw=;
        b=KneKXy2AVm7Ghk2aR+9rDv/vBXb9kJI4Xe6MyQpmG0eyK51XkUalCcLtzEh4dfuZNq
         Gm0vvGC2cY2MgxbguUdM7gTXy9pQtmJtEKzr89YYSM9aG3m7B8jIpkbIIqfZzjtQ/pcP
         4yqWeS14ZmP6Ye4jCI2eWScTp5Gzaphdug04o6pvccm9UHUdGVxeMbueVrGhyiydVVVK
         XI1zNzouckC/PO4Ge6XVL5m2ds67lBr+U84lrK94yQG+AjckJNgvvkYl6eUd+wEtbVua
         vpDZT7WRy6n8+MeQpcbIrzo4kEbGpDzZWXADUWRQmbVmuuevTXV/E/W43opClG7MFns5
         oarg==
X-Forwarded-Encrypted: i=1; AJvYcCWbaDIE+XxPwhyluBzuZK6l/O5AWfroS8is2dVjy7xxFHn8jIpMFWzXKtYDwK5fNrEgxCFiqg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyqz8EUGgG0WTugGXWYTan+9oLZqk/xmxty8uFw3/wxYqjlD43d
	u6I4Rv90InXaHNz2sYcDHUxmoNOFqxpEnHPehgIcJ/MwTgRQH0mRVmb4NDyYm+0aTgy24XDjEeN
	u1CTWFHe2XHnAm1ttNceG2QJxOuOkcrC258rw
X-Gm-Gg: ASbGncvyHEqn7YTkToqoP3hNrsbsJoFIdC1T9Z3g2EwW+EbvkoMjEY5Y+uVBGINagoL
	eZNsAcfnp2cjYZTRF9K22mHGHJ18zA+Y2c2yP/vKKJJqGTrfBUvNBFYqn9fyOFPrEQeMg5C7PtW
	ty/rKGxyStq6IyPmynIZQd0mk0FzLFnyRO5TyFc5d/4hTtfNU2aA==
X-Google-Smtp-Source: AGHT+IGST93Mdnl/SJ3+PvqUapn6w0OPuBcimtucgzR0X13Tco1xI5XdA8X9bFlkWHqnnRmz2FJbgZU3TWmcKbz320s=
X-Received: by 2002:a05:6512:3f0e:b0:545:6a2:e59 with SMTP id
 2adb3069b0e04-54d44d53070mr366196e87.18.1744343720614; Thu, 10 Apr 2025
 20:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <e788aa927f6d827dd4ea1ed608fada79f2bab030.1744284228.git.robin.murphy@arm.com>
In-Reply-To: <e788aa927f6d827dd4ea1ed608fada79f2bab030.1744284228.git.robin.murphy@arm.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 11 Apr 2025 11:55:09 +0800
X-Gm-Features: ATxdqUFxZ6XZ0rU2qM_6yVtCZ604t5ctPfjhoKZ6ymLWiIDdpb-O4LgRH2q1G88
Message-ID: <CAGXv+5HpF3f67unRtr483kwMDvQKB=C9PrATFG1+NPXZNzWUSw@mail.gmail.com>
Subject: Re: [PATCH] iommu: Clear iommu-dma ops on cleanup
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 7:24=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> If iommu_device_register() encounters an error, it can end up tearing
> down already-configured groups and default domains, however this
> currently still leaves devices hooked up to iommu-dma (and even
> historically the behaviour in this area was at best inconsistent across
> architectures/drivers...) Although in the case that an IOMMU is present
> whose driver has failed to probe, users cannot necessarily expect DMA to
> work anyway, it's still arguable that we should do our best to put
> things back as if the IOMMU driver was never there at all, and certainly
> the potential for crashing in iommu-dma itself is undesirable. Make sure
> we clean up the dev->dma_iommu flag along with everything else.
>
> Reported-by: Chen-Yu Tsai <wenst@chromium.org>

Closes: https://lore.kernel.org/all/CAGXv+5HJpTYmQ2h-GD7GjyeYT7bL9EBCvu0mz5=
LgpzJZtzfW0w@mail.gmail.com/

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c8033ca66377..095f9e9afe8c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -538,6 +538,9 @@ static void iommu_deinit_device(struct device *dev)
>         dev->iommu_group =3D NULL;
>         module_put(ops->owner);
>         dev_iommu_free(dev);
> +#ifdef CONFIG_IOMMU_DMA
> +       dev->dma_iommu =3D false;
> +#endif
>  }
>
>  static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
> --
> 2.39.2.101.g768bb238c484.dirty
>
