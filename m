Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1AE1F37A6
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262991; cv=none; b=U4JK/WoFDQLZcsQrzRxrliWPV9uPnhADMFScMQjFOiqQFw7FWJNDaad9dPGUnK9svypN5rBWwzVtpdC/O9jWZn2BEA2WdYT5S16ZmYuBzRsi4PehSlLDF47sWepYIsyV+UXBQXEVWL3Li5DvhdatdY3r80cMVpRwBU0o3MQwMmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262991; c=relaxed/simple;
	bh=sJzvWCCziUNdC/Z50YeioK8brZ/gDsfnrfrUwZ2h6E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tA3RiHIvrme+Lthu8dC9XPnxEujPU5BY/j2xe2BwlquZD9EKz3NpIK8RVlyA5exYZ8yDhCV7tYYddraSd+o9UtDacOL3XjIYtb1A9GpxKOLwY71ya6gFNRL7zhBhD1l0bwxUJccd05REdNf7nNoNSC0B47g/K180Ek9UPqUypdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg5fpiH2; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg5fpiH2"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cddfa9a331so14328805ab.3
        for <iommu@lists.linux.dev>; Tue, 07 Jan 2025 07:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736262985; x=1736867785; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEpmGsnYD20KF98YPxRoScx17fqF75iFjcKl5Un5Rwc=;
        b=dg5fpiH2gXTfiTcUz56js4SFkNa+T+EvBwI+eTxcnGYjnnikXPO2Lgyy2Gnxc/3ZGI
         vbZ8jRz+QeYqpXdVkF3ypHyDqCc/lo0xDwD7PAkkNCnwdTVKZL/yG6vuveb7G/r9fyhI
         tJsMkUbHQ8LYKDsfBiO+QPSBxfPBF7CZaXJTEE3bU1QwJQezKQNV7epqMzTobR5nnz11
         JzStw/GqIvuN9mP+Cdb2ylHr8izLZ4zAtdtQKJ56dlvpVNUnLt2q/eHjvBr3WO5vOEHs
         qLvFsszne5Q/mUszLvXQ15YV//44ei10Z7Ke5k3sYjihgtOQYLv4FjGqvP48ZNB61u9I
         Cvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736262985; x=1736867785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEpmGsnYD20KF98YPxRoScx17fqF75iFjcKl5Un5Rwc=;
        b=vdao0GJIELazER/AYspNLbappxF26dQn1IMhQx6rM4eduLCXCaaHZZJnE/ONlg5qfj
         E/QO9ytQD2FIEEJDotqULoMWoihkacT1Zp/n32uXa/17wNwFiU9l5Tr1J0S5ssMVgmuk
         BwTae+LWPZ4V4qDkZkd4u31x7D4qQlN4ZEONZ9Z0F9dnYuQ2LhImhyNxXXOmXBKgqQ6e
         UmsDIji0XJ2uqYqAzHMsVIcW+V0vamuSdn1q09ShwYZEQRRsoLdf1XPl6eVf/IbS3spf
         cYJBbOTdf6D3rb+6oCcNDgqvcUxQ8+JQzxy7XL4qCHkBQCg8q/R9X1N/YXWPJFw9Zb7x
         jiTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI31IsZWWYOf3SLtHMb8U6cyBAOqV9nMUy6sb4yzQW3lrin8SmxkOfy1eLRoyrrjs6DXKveA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGOAGXGK9wt/34fVV7LrufVAWDqT5uT6uNsM2H52uueENfiNdh
	uTSGEdZlg9gE3Y4UP4ZSIyAAYOHbIwQV04Hvc/1tCTwNPnv3RrP0BaqW09wN6UnHpKkeLFh/qL6
	bT40OAGlfTQ4B+v5cjNxpDY91Moc=
X-Gm-Gg: ASbGncsnbFAeL/wPtFBmmg5RHN6iUbDVc9u6gmeEwfpkjE8X3vxhG8v8y1JzGeRiGab
	pyKWZXfwM9nJlS5Adyc6+oBJw4zRSRBoZeT3k6FmlXb15JkSTJt/TEvFqjdoGQ2nDk4R7
X-Google-Smtp-Source: AGHT+IHlytIOa8SLJD6ilASbLpCUQevKgStkuVESsGuRpq4383tKFP0QuXLkBBL6bO1X1rxhpJ3kjld29+v9vpnSuz8=
X-Received: by 2002:a05:6e02:2384:b0:3a7:fe8c:b014 with SMTP id
 e9e14a558f8ab-3c2d5917533mr523633585ab.21.1736262984845; Tue, 07 Jan 2025
 07:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210165127.600817-1-robdclark@gmail.com> <Z30kWxVxwJXO_z2_@google.com>
 <20250107125840.GB6991@willie-the-truck>
In-Reply-To: <20250107125840.GB6991@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 7 Jan 2025 07:16:13 -0800
Message-ID: <CAF6AEGuXD6rCx8yABH338XSr0Wq6fyFe9Z6fWCh1KPNMbJgiOg@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	Rob Clark <robdclark@chromium.org>, 
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <dri-devel@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joao Martins <joao.m.martins@oracle.com>, Kevin Tian <kevin.tian@intel.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:58=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jan 07, 2025 at 12:55:55PM +0000, Mostafa Saleh wrote:
> > On Tue, Dec 10, 2024 at 08:51:18AM -0800, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > This series extends io-pgtable-arm with a method to retrieve the page
> > > table entries traversed in the process of address translation, and th=
en
> > > beefs up drm/msm gpu devcore dump to include this (and additional inf=
o)
> > > in the devcore dump.
> > >
> > > This is a respin of https://patchwork.freedesktop.org/series/94968/
> > > (minus a patch that was already merged)
> > >
> > > v2:  Fix an armv7/32b build error in the last patch
> > > v3:  Incorperate Will Deacon's suggestion to make the interface
> > >      callback based.
> > > v4:  Actually wire up the callback
> > > v5:  Drop the callback approach
> > > v6:  Make walk-data struct pgtable specific and rename
> > >      io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
> > > v7:  Re-use the pgtable walker added for arm_lpae_read_and_clear_dirt=
y()
> > > v8:  Pass pte pointer to callback so it can modify the actual pte
> > > v9:  Fix selftests_running case
> > > v10: Call visit cb for all nodes traversed, leave the decision about
> > >      whether to care about non-leaf nodes to the callback
> > > v11: Adjust logic in 3/4 [smostafa@]
> >
> > I see the level initialization was not removed as it was in the diff[1]=
, so it
> > seems to me that=E2=80=99s redundant as the level is set anyway in the =
callback, and
> > actually looking at that I see it=E2=80=99s not used or printed from th=
e driver,
> > so may it can be removed all together, anyway that=E2=80=99s nit that m=
ay be Will can
> > fix it up while merging.
> >
> > Otherwise, For the whole series
> > Reviewed-by: Mostafa Saleh <smostafa@google.com>
>
> I'm happy to drop the 'level' field if it's not used. We can add it back
> if/when it's needed. Rob?

That works for me, thx

BR,
-R
