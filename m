Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F503BCD1C
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022010; cv=pass; b=MHkB29eYPZtaAGSRPLmY0uPJVBj08dtkQp3wsNeQG1w1W7+OJXc838POAwVQ+mEk2W8jiTeW4d2r5xjkQ9zBeTbL7kLH4lZrYr6FjrUsOdKm4S7L8VhfnT9mvLVKC3mWQ3BqwYnTHhXMqYdslqWzttXUtyLenfDD1cdeKWpKiIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022010; c=relaxed/simple;
	bh=/HJPWGicY5u/dlbgFk0C5NmIj+GOioj715oLeRqp58E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtzH0w0Ic1E4c+m1BdmbZTnSlDiV1xbi76ajeKnM5n1ySFn9OjoKz5hOAgEz+tUc+yIddBbrhb0tm9oaieMrbaJp6kDXoxe0mzudOfHEP529I/VT99HgInhfdZBYvhWl+pmMM+nKx20RNiyUnQC4eiEB+W5YgsBmbNPdGMIbY3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQ0tuFZb; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQ0tuFZb"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa64afcfdfso28418e87.1
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 09:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781022007; cv=none;
        d=google.com; s=arc-20240605;
        b=Dyiela1Roq7KUIuyTyQRdM87pcnm88MOk8bDRsaO1bmofeNPQhs6SvUEP92NID9L+5
         5LxUqITvu7ygIqpcFy6MmSIPN68qgBw95fJiN7tvdLdTAdooiiXrKgYvO03JSxmlljZj
         YgZOsOFpYjKMhazCF5eUmy1lSsdSphtsQ92S7Zb/uYDLUFEhP5VMAvJDTNdro6gIoVDK
         Dr1Tukki+F6EHzLriAd8KQO+aD/Q0kwlInK27VJNSJDowuSwy1vJ0X3D4Rxwiep/FXY+
         T9+U7R9jQ+Xjffz1DqnUGjCfLG/ouvNuOozS6GXpZQVRiC7wXuq0FFV8MCmdlYgveJ1d
         C1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pFgomi7XLhEYHICeogk3tk52w0iSafmEFBcU9HzZqyE=;
        fh=Jpx5dGpe84D5f4EBDx5YCDMG/t+gQ/rdyvuO5vH30js=;
        b=Pu2nM+Ms/wTmZuYXitrUGcoT2XT71XhucFFQWaor6uGUhM5Tvp0x0ZPtUBOlIOT1oT
         sk3aJqAXyQWkeDMFsJoGGpRUEYUlNzgiGnCGA2yI6+q52P2HWeI4vVqS7Ee+D7Zx5lIq
         K+Al4L9gLKJCOroaHd/apZBtBOGSCm8pwEGiXuQT34Mk+6RERRrBPFWYxL/7UAwCPuXr
         ppX/SqKdLW9PitOfx9sxMYk8OhGDd1Oe3+MIG7UsC3XcGapRHmIhcQ5RDV+OXqddBOKE
         aRZ3n8Ndfp2dopUA7j2J+cwMVm3vEBQXqTv1iI9UbdWjieu9lSp4wzOg1KkM86dN2us9
         5EEA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781022007; x=1781626807; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFgomi7XLhEYHICeogk3tk52w0iSafmEFBcU9HzZqyE=;
        b=EQ0tuFZbr/eX1GYCqg+vBgkQzXgbDKaFcKoKD9yHxye/Eq/WMuci51OfJ5ImTCaiU2
         SmNT1At/BcrXl0TROv+dcUndLO1tjkzRhJi1pAhvo7ZEjDwEMzb+86GP53z8eRgZUfQ9
         cZ3OMyTosic414pKbG3eF512zQBhZPD7HTStc8Ek2AcIp/GEAtjvN+nWFvDI+x9ePlN3
         gc8bxnR03rxlaBZBqihfhuxmTVAKD2bOB18RDZ311evtv6OtySL5gAoLbLOaZDAOJiWw
         4tFKLPKyfGM5jqA5yvts+v+iNgtuU75elvuCfij1DU0hBAHYXf1AFv6IEhq1vy55x+q9
         um2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022007; x=1781626807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFgomi7XLhEYHICeogk3tk52w0iSafmEFBcU9HzZqyE=;
        b=FGTiRmNuwiQpExKDHW+XTMRPiUAwzU+PO9IJLM7s7fraOX0YXdtR2BfJl6ZL8FqjDj
         MjdSWyltuOeadmfhVIfSgrmuaHBT02wEBFNkAn3Jn/zXwizMidb1Y3oqvy3wAU2w/qoW
         m/aT4tBvRy+TlAEuEOskepg2DqMhxIpKddMUcjPObMbuXK6EuudZi7CdlbYyr/3Y7KF8
         K/5zr84YAUPdvXv0U5rEN4Hh+xFR1ie3WqvIdJEy1HubUYI1eUt97ZMucXeJLv1LV4QJ
         IFzSbeZIKvhEptq26trQmKPUTEkl0xr8lKony5ENG3/AX6IbKE7gTiXPWe+Rnn2LXLjK
         UxAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jEEEHDPyKj1aHrZ4Kq+xZaVXJORyQmuqLORyERHFetvpmK6LpoGdVo2LXf+5Jk84jUS65mQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCHVPdWDaqcNdaUUPqjBows4AsEUnBDRoAUReWxQv8gpYXWW7v
	1AB3iifZQdWyZq02iKYOLLo+AYacObkr55FXaEz2hhWs8UIaaaKxVy2FZ23jdfwJ36YZr9rBkxI
	PzExUx+y3Nz7tRumhvhwsuy1qrOCKgkMD/5mxTx8=
X-Gm-Gg: Acq92OEEGpK/ViFbp3zL3yDzwGSvmMe0Rp3C5LsM3OIArod9EwVHmFoBJlhJDbwQkvo
	vFTb0hO3P5nIBLe5tQew8y2AuAeYoo6j0JrhjvcQHMk23I10yAIMFopOi58HkXYMvQyuzyDJS42
	wsXICRtGEaAZk+BeWlfU/+pZCymVqXt7SHh2sWezLYW6DRVd93ibGueV/9IXm5Hmy5fIqLpwsNu
	7K76ubfgHHJgOZVAV9YVH876V6L3PvuHVugUgmrFp5vme2pvVD2yRNPy7cqVpDvH+QXq/xt5Aqe
	MILCO1+f/51k9SAOQHxzu0SXG1Be34YSl31wC9jPGNGkFtVeBcsDx8FMxQ==
X-Received: by 2002:a05:6512:33ce:b0:5aa:883f:5da6 with SMTP id
 2adb3069b0e04-5aa8864f3c8mr624107e87.13.1781022006976; Tue, 09 Jun 2026
 09:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260608194321.150838-1-xuehaohu@google.com> <20260609072234.GB327369@unreal>
In-Reply-To: <20260609072234.GB327369@unreal>
From: David Hu <xuehaohu@google.com>
Date: Tue, 9 Jun 2026 12:19:54 -0400
X-Gm-Features: AVVi8CfbRleRRxp7xUhMkzyUOKJRPcnke7OqLp1gc287gSv21XbS3wDiRLvDI1I
Message-ID: <CAPd9Lg8OtW+qekntqcuL_Yz97=e9bD1gacbyB5uQijL6FpFqYw@mail.gmail.com>
Subject: Re: [PATCH v6] dma-buf: Fix silent overflow for phys vec to sgt
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 3:22=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Mon, Jun 08, 2026 at 07:43:21PM +0000, David Hu wrote:
> > diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-bu=
f-mapping.c
> > index 794acff2546a..67a8ff52fb8f 100644
> > --- a/drivers/dma-buf/dma-buf-mapping.c
> > +++ b/drivers/dma-buf/dma-buf-mapping.c
> > @@ -40,8 +41,11 @@ static unsigned int calc_sg_nents(struct dma_iova_st=
ate *state,
> >       size_t i;
> >
> >       if (!state || !dma_use_iova(state)) {
> > -             for (i =3D 0; i < nr_ranges; i++)
> > -                     nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX=
);
> > +             for (i =3D 0; i < nr_ranges; i++) {
> > +                     unsigned int added =3D DIV_ROUND_UP(phys_vec[i].l=
en, UINT_MAX);
> > +                     if (check_add_overflow(nents, added, &nents))
>
> An additional blank line should be inserted between variable initializati=
on
> and the subsequent code block.
>
> Aside from that,
> Reviewed-by: Leon Romanovsky <leon@kernel.org>

Thank you, Leon, for the review and for catching the formatting
detail. I'll add a blank line, include your Reviewed-by tag, and send
out v7 shortly.

Regards,
David
