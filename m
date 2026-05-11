Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32D244DB9C
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517079; cv=pass; b=enxND97pOWzw3thMb6R9VL2EhT60Y7yDwzG+4xAsMXx31YA4na8hac00E/Gv/vwufznW3qHz4JP1QFPb48E67GULqbXl4Q40VxfLHdTASHS86rzdK1PahY2PKME0auJnG9nIUcK8hIICXZ5Amljc1T/xjEf3TvwiEgrXw7l4kR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517079; c=relaxed/simple;
	bh=had+1ZXn5IbhJQ+9hKZhfxqYkloaOsKefHmoCYR6dvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5JPnTwiUqW26ViQXr07nGHzZb0Lftyn92v9dTsbzl/to9YLb+hYS7NyzKUi1VCEJttBJl7ZOlsvjMge3fsfkHyYZUAF2gy3ud9Lkon4Nx1FiLu8rKALlxVRoeViKArDa0ZU7cHzJwjMWSZrdilBIih+iFh0MnBP3nqz0Jvwov8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nveDo39J; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nveDo39J"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-132830d8281so1541839c88.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 09:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778517077; cv=none;
        d=google.com; s=arc-20240605;
        b=KQqyw00i/7yClD6LgmfZhjo+KHoyePiY0X8HNSJVja6lNu0ClA5CfAt75jICoO8lKe
         F2umJvAlDtyx4qpARAXDK94lR6VN2kGaUSaG6q3VNeFUlpKeMEN6QJamPAVoLtF4cTki
         Bxzbn3tT3+3+W+QtRU1AzaFnnMsIGwTfnGU+wfDkRd5kNqWUUeM+VaiGar0y4NfmIwoW
         KgmonV3wioZLHLpQz7DTxmYfxYSP+5YrRnPyyj+ov1rpVQwYHuyE5Yfhdvmg+uGH29fv
         2jozDXr6mG9Ff1v76anzIlXtpAJ6o0FnQqwL++V9ibZBNSOwyqEVVfoC+iTx6s198mVL
         pc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HxYtWSwI/C6D0/BSATPHEBBU9xDG7QhHyYiVG3R9dR4=;
        fh=wziNohkvOkB2kMAx+8QyU7em3XMi6A4K7LMvB/x5fAk=;
        b=cqY1NLT9jYiWJSdUf9pZ0IrzEYH3vGNvwuYinrTIf6Mb5Fy33OVl2btRa5NsA0E3Mr
         nCXwUkSxrXrNbQJaouBMQIRES/E0e/H9CWlUvbJSQOLwZ0F8uhkECMXmusyLnuHRmjXK
         KEEWLae+lohMjPpsAC/I3FAvJI8Ftny43Oo57A++39Gvs90+UFGZceu4XdU1A/OTFx1N
         5wuYVarDM3Ig4vS7YAns6Doat6VGBht9LsIhIy2cRWZ6Nf9I1xFXCeW+b91FnqXD6rY1
         pH3EDUdcfmL//QEuxlHVQoQxBiAvrhv7P2Vra4lXizVah1G18mIpr9zLcdv0gYZXNER+
         g8KQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778517077; x=1779121877; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxYtWSwI/C6D0/BSATPHEBBU9xDG7QhHyYiVG3R9dR4=;
        b=nveDo39JKD/SSHAvoS+c0HDOcoTN/F1QZGAvq8/AYZRqcuaWwGo9RVHSdq59lybfS9
         ni10W/Ll0BHHR8n42c+1/96ZmQPXuj+mzUfQ09z0ZC3Bbiom9k1Ezjni8zQpJ17/rdHr
         SqVxXVr+7FNEFU5wAWytoWcG1FaNgM6E+FD4i2G+5oz2iV8eP6CNuHCcg5o6tra89voG
         GVs/jbUsAoVYcNvNThoiQ7cb3spxCOwpS9PssKUOggqa83Hirhs1dK4nS8kSxTPQQois
         h7/1X13L0AVmmzqL5Fy9HtYRrOFm89j7pHpxWx/BI0xd9Ns8K0WPm98unYtoiRdp6Z14
         UPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517077; x=1779121877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HxYtWSwI/C6D0/BSATPHEBBU9xDG7QhHyYiVG3R9dR4=;
        b=lsSuD5Dtt+DMMWT6XjmGKIhTWDh8uOdakM6Y0EwnNyOL+sf/xMIHw7xT8TDsaOAJfB
         qKBReW7DwzPsdG1cEWWH/U0CiN0zTBRLVgk+HPUWwyH2SX9yS6UEPs6j6P6d5r9hATbm
         48wSoLWE+Xnhje37gnls8/rv7GG61W+C4bR5Xb2n16u1a7x++rp7+k6HoOCHyKQjIi4Z
         Ex36EBmD2YK8ttqyyY8+VCBx5MJKSfCOFrcsEs0J++KewF6xmRv6o1tbCDhKU7rVmAMU
         pot1m5lGpRDKIYR6ND4dnxawfSq9BjAlQd2HHzDzIN9QbjqYI/tXdbG/0f/XheQRGimM
         BVvA==
X-Forwarded-Encrypted: i=1; AFNElJ89b8uP1ofpMBiFv0imCEi9B9aSJX0P5lAK/Ilq0ZjFcg0boae2QWLeaNLErBAGXshWjCOxnw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+lJ3oDrtn3LOt/9g2eCDeoLE273z/8uvAsuDOOzuzp8LzW0zn
	N6kPcBO1NzvK29PGSJab9Yzb5GVrtaNJrU1Yy0QF4OhK0jrZ2yKdxNl6Lx3sJks98Sssm4VhYr5
	iRQln+6oimKT6u3fbn70LiZqVRqHHDNDclCDi1+MZ
X-Gm-Gg: Acq92OGXH4UB3fMgtOMrOQZQ9A7yh8zPv1a2dzkBgLRRQO8rptdPccqmszp+LKpjksn
	gT3gCwn1tLUgQOitGGlqCOt8H0qGyaLCik/BuHEumHg5oK9HNQPgrDrMnTvW8dghQDbnY8FCbm3
	nKqhcEQu8r535qhIsCv70/VjN6lv8hhSSJpWIQDDmagaAsRAGDAqgbXQdJgMosxI8GyidwD6Fhz
	J5ZhkgVlxI2x80cMV/K/jg3GMRkCnsOllkaZ6btJcVN4dkw9OjLENWpLrf4Kb4s56jOOlFk5Knv
	nvCFbezcC40JxzoLgwE=
X-Received: by 2002:a05:7022:660d:b0:12b:f881:d8fb with SMTP id
 a92af1059eb24-1327124fafemr9120583c88.3.1778517076198; Mon, 11 May 2026
 09:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <afj0cyBZwkVLyIwK@google.com> <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpdm5lfIeWptxOh@google.com> <afpwCIjQXwfImPXm@google.com>
 <afsN9jrsfuigV+DM@ziepe.ca> <afu5Y55W5oj70b5v@google.com> <afu69hAtkRlI1GJd@google.com>
 <20260509171451.GG9285@ziepe.ca> <agHGaJfwPr7-F1z2@google.com>
 <20260511141607.GN9285@ziepe.ca> <agH-rkumGS1vX4dv@google.com>
In-Reply-To: <agH-rkumGS1vX4dv@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 11 May 2026 09:30:49 -0700
X-Gm-Features: AVHnY4LOJbzMyxIhRSawn4ckl5oJM7Ez40Ko5eBJSnKhq-YPlTgXIpJvP8_Le70
Message-ID: <CALzav=dVPBx-kVhZF2KbCkWCxoufr3eGU4Mtv10FFofW9jtsGg@mail.gmail.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state tracking
To: Pranjal Shrivastava <praan@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Mostafa Saleh <smostafa@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Daniel Mentz <danielmentz@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 9:07=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Mon, May 11, 2026 at 11:16:07AM -0300, Jason Gunthorpe wrote:
> > On Mon, May 11, 2026 at 12:07:04PM +0000, Pranjal Shrivastava wrote:
> > >
> > > > Thus the quirk should cover the VFs too and also disable ATS there.
> > >
> > > I observe the quirk does apply VFs but after the VF's iommu attach
> > > because of how the pci_iov_add_virtfn() is written:
> >
> > Ah, that seems to be the issue then :\
>
> Yea :/ we need something to ensure that quirk orders don't impact sanity

I haven't read through this whole thread, but I think this patch is
related to the issue you are discussing:

  https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@googl=
e.com/
