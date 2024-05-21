Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750D768EE
	for <iommu@lists.linux.dev>; Tue, 21 May 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313770; cv=none; b=Du/EUOOIrpMrIul6PeqJjfIc2ZWcuwvO7gJWBIjQfqfqZCjv9YGzM/YDNA0Ohq/WVUX3e4y+bi3Q0a9/cVDRaimZRsfGT88zU9ZJ8bGeVyE6E5iXvGAHq3mkSA7ONCdIM8WKpD42BGin6JP0ogoxLyR2WCIl/wittIsw4vbAEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313770; c=relaxed/simple;
	bh=jG69YEZTLS0kEouTnxWMB7g2YrmQQ37UTLR3HYFUyOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0g4sYy/ZEPcH+HVxlmS6aJ4W3xFr9e+VUpsVnyS7diRcVajjowBej4jVAqXfb9vdbw9XP1QQjvghppDv3hWAwGvADKIoixiDmBjvxNeXq2R6fbQa7gu3RDvHUj1BSHMpvZmqeTWsSl2hYgWis/9BCYgVpdUhSRlamQGOR3I61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YM+rNPsq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YM+rNPsq"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso1642a12.0
        for <iommu@lists.linux.dev>; Tue, 21 May 2024 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716313767; x=1716918567; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zrgLEcrrAgn3qyDl+eK4uvW3ZsNRNmfWQiH2j2PqpE=;
        b=YM+rNPsqTA/stHVykhS/uhmBWCT/z9dPkRHbN1sO5BDxAi/ivQoMnwCmU38uxokoQK
         oIg9DacLXAlUVIKqMro8kRazueg6huLAbclLELQuXW9LA1OqauhDg6QkyTUjfgxGgE5d
         W3Pd8wmYkYeHmc6+V7aQrucZx6eJhNdLP7wMObfoXoAc/uUtser7RfXWqEDP7gew+Mh/
         32XsLf9Dosq2gyihmaUC+lVbXn1GttTNbooAgWHTlA1CavvwYMxkaaROFe7jZy1DMrrv
         3bY6yHVHbd2yj1F5BwcL1aNTev80w1GNNU10UZjxDA8yzbZbhvWZshn+G/Hq4I8lWJtB
         9tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716313767; x=1716918567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zrgLEcrrAgn3qyDl+eK4uvW3ZsNRNmfWQiH2j2PqpE=;
        b=FZOTIi4NoZ8mAK52FNQHvFZOeztSix3dWJIklCYGwZT1bzpH2GS2nT1lArozlb0+OD
         2U4CIr0UxzEgaI2PPDPJeSFRFhhicdQGDouTglp4ySpgsoGuU5E1HKjCOJxr0sDjAAYq
         lYQ3zUfD6xbAeRBJ5eGSbW2LgBljHLs4cTXjFebDacQrPfUzImdysPdJ/LZRt27ty4tH
         MyLPfmscrHZ3YYiH9w0ioFwaQmxrBLinsM+skpRNtnEEep8Hxs5lyHKxDgqci38a8LsH
         PRXYRKXneRqYKbIv9/aMG2ST+hD9oVIgHdiGN+VqRQ4XkX4pvJodqn3+dY8C+1yqkKOS
         3aEA==
X-Gm-Message-State: AOJu0YxBT8r6+1ewyQHV6UXm5gYGHa2AN5/6mN3RafEFKhM8gZX9bmWj
	vV7vCkGJ1qbnvJj/8XRXAZxmSiWHsccEDB7ghBfYZMGAFwxX0tlbUuR2ebQTkZHLeFFnmo0VR3V
	tZ2ZuI9bJKeyLTgmb2vioMrKIWqZuERvv4X1M
X-Google-Smtp-Source: AGHT+IGKexmPjJaYvIPiljhECv2Bg9KTvh2Ev1X3U5TzRsdBdK+cKLISCAz69dIjjuv9Pfe9NO/aKaFLSiVl1RkpDJ4=
X-Received: by 2002:a05:6402:74c:b0:572:7c06:9c0 with SMTP id
 4fb4d7f45d1cf-5782cd38dcfmr7457a12.0.1716313766477; Tue, 21 May 2024 10:49:26
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240513215420.408374-1-danielmentz@google.com> <b348ee57-c461-4546-94dc-1cbdbaf33145@arm.com>
In-Reply-To: <b348ee57-c461-4546-94dc-1cbdbaf33145@arm.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 21 May 2024 10:49:11 -0700
Message-ID: <CAE2F3rBjpvH-ghzYQnd_-Kx-F-Ydx+=U-nPikjLmUvZCSKxi4w@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Skip prefetch cmd for MMU-600, MMU-700
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Nicolin Chen <nicolinc@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 8:29=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> Hi Daniel,
>
> On 2024-05-13 10:54 pm, Daniel Mentz wrote:
> > Arm CoreLink MMU-600 and MMU-700 both silently ignore the
> > CMD_PREFETCH_CONFIG command. Let's not waste cycles adding this command=
 to
> > the command queue if it is ignored anyway.
>
> It is true that our implementations don't do anything with prefetch
> commands so far, however this is a valid architectural behaviour, and
> the intent of the quirk is really for buggy implementations where the
> commands erroneously fault.
>
> TBH if saving cycles in arm_smmu_attach_dev() matters to you, then
> you're probably not going to like what's now queued in next that makes
> it absurdly overcomplicated with loads of indirect function calls...

Hi Robin,

That's fair. Given the low frequency with which arm_smmu_attach_dev()
is called, it might not be worth the added complexity. Thanks for the
feedback, though.

>
> Thanks,
> Robin.
>
> > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iomm=
u/arm/arm-smmu-v3/arm-smmu-v3.c
> > index aa62f0ecd053..98f1c4b44ef3 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -3684,6 +3684,8 @@ static void arm_smmu_device_iidr_probe(struct arm=
_smmu_device *smmu)
> >       case IIDR_IMPLEMENTER_ARM:
> >               switch (productid) {
> >               case IIDR_PRODUCTID_ARM_MMU_600:
> > +                     /* MMU-600 silently ignores CMD_PREFETCH_CONFIG *=
/
> > +                     smmu->options |=3D ARM_SMMU_OPT_SKIP_PREFETCH;
> >                       /* Arm erratum 1076982 */
> >                       if (variant =3D=3D 0 && revision <=3D 2)
> >                               smmu->features &=3D ~ARM_SMMU_FEAT_SEV;
> > @@ -3692,6 +3694,8 @@ static void arm_smmu_device_iidr_probe(struct arm=
_smmu_device *smmu)
> >                               smmu->features &=3D ~ARM_SMMU_FEAT_NESTIN=
G;
> >                       break;
> >               case IIDR_PRODUCTID_ARM_MMU_700:
> > +                     /* MMU-700 silently ignores CMD_PREFETCH_CONFIG *=
/
> > +                     smmu->options |=3D ARM_SMMU_OPT_SKIP_PREFETCH;
> >                       /* Arm erratum 2812531 */
> >                       smmu->features &=3D ~ARM_SMMU_FEAT_BTM;
> >                       smmu->options |=3D ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
