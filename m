Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEB14A611
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257838; cv=none; b=TRmXl3CKvtfoul/WuEH7VxsPZlduRwlxvVU0VINHtG31EAUrtJC/J5WaoWj+Je3IuKI1s4n0sFDDjH4aXqy6B1fHVAwYFHaB8cuZyBCl00pnug6YGFDeXnYbdkGzPLcarQScNYVcvoOi01tT/tb4vOtHautYO3hB0pNV4epAdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257838; c=relaxed/simple;
	bh=baCX1MPF/4BgGnjF3EVpOqVJcObJ/nlrrBIjMmp8wyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKkDvASP1xUMaHyDL476Yxyo4QPpkY5H6+wxEb7B7Ox6IDLAUs7MCnf9oBjVHFsrpbY4RfNdlQuv3afKYtmcETaNczKavgQ+2dbnJqljLSrm6vV99i38+Nnn8fPqyp63DNa6Dgvn4k17cQ4Z3ku2hs/zZtZ3v+YMjKMBDa+rmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZYC4Y2i; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZYC4Y2i"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53345604960so4255250e87.3
        for <iommu@lists.linux.dev>; Sun, 01 Sep 2024 23:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725257835; x=1725862635; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL4q+3BknQF/110uoiRGGVb9lWKaIF7svW7iIAJ6GMo=;
        b=aZYC4Y2iaBFYZ2PTHyJnNbZBV0zPdL+WMo7u5lHP84pOywO7p+WbKfKPPW1eniXJYX
         z5jg9DCDv5tNmt0gksWg2gJXuIevmLOOuZwlBpcpozCTarJMsQnYpUQoMkPIK809Kg+d
         abxL2nzrU9Dl7pdk2LXpPpg5VUWVBXHrKttW0waUOdZ61vgGcB99RUU+vpDloqdRkesT
         DlJl4i3Pv3ElpXRVjywfdtlkEJuBpoEVfQRBQ1G9vBODwim38IvuZHeft5VOb7P/OSgO
         4EDON/YT7HBz7zY7Gi/etMjIvbchuclpH0sKZvwHF2ARgBRaRd8DbIrNmLp1vao+VTqN
         JEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725257835; x=1725862635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL4q+3BknQF/110uoiRGGVb9lWKaIF7svW7iIAJ6GMo=;
        b=A7dz7N7U2PWN2V2YRqxUyyaNPvVA5S1APRlsPOYBrFc/ha1VKQzsZdLvyGPmtGtpTS
         xn7/ikz4+jZiQls8XETc9wW876rs3LF8lP0sSHiwoS4r48AR8ZISlFsunhR8npIXEmhF
         RkreRClQe9/w8G28+QrLGDwtPib3nE1uTCRni1Rtl0PtisC3Ll7C2bshDGluKlhnJgcI
         D81bSkzKxGTt3m6MagmFEjTjJ5n9SaR8acVF/jS9ipsojW+0dJB0WJi7yTvuTEK8f5+L
         t3aMHz+7x6WNOeqxc2SzGTReeNqzwCxzghiqKyqJ5r0cjoevLHlkoCedFTDZP8nBUmzi
         nF2g==
X-Forwarded-Encrypted: i=1; AJvYcCUHAOGUkMsRZs9iVpEi4V2jfxIZUvVi4hO5Z84qyUOgSh1y6BhCcuwe3WvoRbSfnX5pfKm2rQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLKFEwDuUcPiA5OaVEgBaLl+Ey0eWlRs7onHMTsoOYs1TQr8cN
	MxG0mixNVWMdt7ogJjyKIe0o2KW1qvM1eHZ5883+GxGfhHVbcGfk4setYWXJMIgDYJpX0PqQfLK
	mO+YnGdQhv7Fnn+yjclL/Z/2+CEbFNMPuaqF2
X-Google-Smtp-Source: AGHT+IEbBITume0dWKu89jJ/2Yb30U0ruu03X8UrKO5gPC9Y4Z9AcvlzOsu5BI+GMZD9wKi9n1eSprT5dMlhZ33lcbY=
X-Received: by 2002:a05:6512:2309:b0:52e:9b68:d2d4 with SMTP id
 2adb3069b0e04-53546bb8200mr5393539e87.56.1725257834075; Sun, 01 Sep 2024
 23:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240829120504.2976612-1-sachinparekh@google.com> <ecf53bd6-6047-4ce5-92e9-41651e7ade15@arm.com>
In-Reply-To: <ecf53bd6-6047-4ce5-92e9-41651e7ade15@arm.com>
From: Sachin Parekh <sachinparekh@google.com>
Date: Mon, 2 Sep 2024 11:47:00 +0530
Message-ID: <CAHH62Bqm57DECYakBWCyWbKHQTs9jnvxMBjJsrnEhnumj+VsEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] driver core: platform: Call iommu_release_device in dma_cleanup
To: Robin Murphy <robin.murphy@arm.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, will@kernel.org, 
	lokeshvutla@google.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 7:28=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2024-08-29 1:05 pm, Sachin Parekh wrote:
> > Installing a kernel module that has an iommu node in its
> > device tree increments corresponding iommu kernel module
> > reference count during driver_register.
> > Removing the same kernel module doesn't decrement the
> > iommu reference count resulting in error while
> > removing the iommu kernel module
> >
> >      $ modprobe arm-smmu-v3
> >      $ modprobe test_module
> >      $ modprobe -r test_module
> >      $ modprobe -r arm-smmu-v3
> >      modprobe: can't unload module arm_smmu_v3: Resource temporarily un=
available
> >
> > Cause:
> >      platform_driver_register
> >          ...
> >          -> platform_dma_configure
> >              ...
> >              -> iommu_probe_device (Increments reference count)
> >
> >      platform_driver_unregister
> >          ...
> >          -> platform_dma_cleanup
> >              ...
> >              -> No corresponding iommu_release_device call
> >
> > Fix:
> >      Call iommu_release_device in platform_dma_cleanup to remove the
> >      iommu from the corresponding kernel module
>
> There is nothing to fix here, the current behaviour is correct and
> expected. It appears the comment in of_iommu_configure() got lost, but
> the equivalent in acpi_iommu_configure_id() is still there - the dodgy
> iommu_probe_device() calls at those points still logically represent the
> same operation which should have happened via iommu_bus_notifier() or
> iommu_device_register(), it's just being replayed later for hacky reasons=
.
>
> IOMMU groups are supposed to be tied to the lifetime of the struct
> device, and unbinding a driver does not make the device itself go away -
> if the devicetree says it exists, then the IOMMU layer knows that.
> Modular IOMMU drivers are still not really intended to be removable,
> unless all their client devices can actually be removed form the system
> (and/or the IOMMU driver is being tested without any clients present).
>

Thanks Robin for explaining the intended behaviour and the context.

Does this mean that the iommu reference count should not be decremented
when we call platform_driver_unregister ?
In my scenario, platform_driver_register is incrementing the reference
count so I expected platform_driver_unregister to decrement the reference c=
ount

Even if the IOMMU drivers are not intended to be removed, the reference cou=
nt
should be in accordance with the drivers that register the iommu group ?

Thanks,
Sachin
