Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C903BB24
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065349; cv=none; b=LqXm4nVlG/coyZRmcpmbVTNvmHC6cJI89THAXFEY/hUngDgTsE+86lXriQF7JChyx/LYLf4eCCXQr0rS4n6+UwcDIvWqcG0MrG2SZCOgKrbTr8Rw/vMz/vVqzGmA567Ak2klMiQIhZZ0fWRFdqE1OQ+y+ISTrdswC+0yZPIjMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065349; c=relaxed/simple;
	bh=I/HHwhWcZZ3n0YAUMPWUUpZcgRRmPLWBeTsa9/RgEMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2W95q6UQuHgHu5aTuiXCAMSOD1SjT5vQ5KaAUnmDmHoxYaPn0zzSuFzYIiGj/wAjZl0UNHN2Je/eiSSBNETPVVcoYmWiKl/Y8R+F7lt7XP0DdR9Bq6V/fDhokZDViGu+hFdagfzvvDLINNaj9E3+Usfdja8aUFC20jUzy/vDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CzLnObhW; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CzLnObhW"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-268eec6c7c1so248984fac.3
        for <iommu@lists.linux.dev>; Wed, 07 Aug 2024 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723065347; x=1723670147; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/HHwhWcZZ3n0YAUMPWUUpZcgRRmPLWBeTsa9/RgEMM=;
        b=CzLnObhWJk8TL2KrjpNjPsSpDbJVp8xNUdE0dyA391q5cFTByI42beLu5fhAJqEoIx
         rw3wZ7SBu9jVnUYiusI37IhDaX1YQHFwdIHQ/e0K6GTjoA/Cpwu6KsGFqENr174g2SnR
         6vcCYzIRXlIz+loJX7rsluu31vB+cgl5PQdEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065347; x=1723670147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/HHwhWcZZ3n0YAUMPWUUpZcgRRmPLWBeTsa9/RgEMM=;
        b=YFf2TEOLt3B94WJ37nHIFMNVY5Kfq+cI07QCAR2ZKa3pw+URmwQDKMRnbvjTKampCl
         A2HI4SvpEB54uoWoGdBhfkItbvu3le1Lqjz55M5Mopsdcm8rEy3tHw5jcR1Lb4klqHRd
         R58hLhNAdsiXu/f5ypvvYoIhXX8Y5M09A8Gi3QEsDOSbQPUqoTvasaMlCSzSSnYNDyd0
         SW3HzmN0y/0MGJLgOtwsiDrY8ZYvZiKnTjkqz67NICy/zWwWZZJCLd9nPlQRn9MxG3r5
         VuEnO+Lo2Z/ESkoYc6rYRwnQRiT/a8JiSByfzSxKGm723bwH85U+vfd3ANhKOjnLaFNg
         u50w==
X-Forwarded-Encrypted: i=1; AJvYcCUUO77oGXb40acXAFAJKa0KmKGFHSn5LySmiLh5yQjdgcerLuG5v/Z8cGOssdZxR3UIX1dewA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1pCI2PDSD+VUwryFPXAgCmF0TNkIdO3i6gXVwbSR3ehSTKlnj
	VWHcfgk4VU6VhM5/iiRBcmBg95aejkrm9qWlmZm3ep5sm368femZg3pZJqtDFS/CwhkspNPuz3E
	/6LyMVrKaf/Y5B5eYK7kndfb0ACVUE//Tz4Ob
X-Google-Smtp-Source: AGHT+IFdG0BWwdv7/XaDKrxEwS0DUTDT/gdv5ciTviaWNvE2T0bsvZHSOHevFbbDDv67gzv6SOrrHeLTm/T79qtdatg=
X-Received: by 2002:a05:6871:3422:b0:261:13c6:e843 with SMTP id
 586e51a60fabf-26891d3ce49mr24267160fac.15.1723065347097; Wed, 07 Aug 2024
 14:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org> <20240807071740.GF1532424@black.fi.intel.com>
In-Reply-To: <20240807071740.GF1532424@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 7 Aug 2024 17:15:36 -0400
Message-ID: <CA+Y6NJE0QB-W7hBOD_S1XwoSosg3Hh1FH0a8Um16g3Ex_1V9=w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Detect and trust built-in TBT chips
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 3:17=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> I suggest opening the heuristic here a bit more.

Could you clarify what you mean by "opening the heuristic"?
What details should I remove?

And add the links to
> the Microsoft firmware document somewhere. These:
>
> https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pc=
ie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-us=
b4-to-usb4-host-routers
> https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pc=
ie-root-ports#identifying-externally-exposed-pcie-root-ports

Is it good enough to have them in the commit message? Or should they
be linked in probe.c?
