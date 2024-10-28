Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651F1E0B7C
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151206; cv=none; b=N4+GXmVpI1wfpR8a5GpI3WiRaHP3ucSe6q64CCdKzjm2br16RrAQTGvIxiGf6/xLsDMNVSCcGa1GwVsxJh6ilivmtMrL3c3Yw2Nf9NZFuTXvJlAQWwBeeKf24hIZpQYe2ZjxHzy2JSPrqhPpj5qGnon+RC6HCSOsRMVmIKruLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151206; c=relaxed/simple;
	bh=mWHqBO7ggUCFVDg3HGgCG/OeU8lRFkRHqMQJvFNQjcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UC66v2xxDfEG+OCW1NZ0rj3sHF2e2+hke/G+LhDWgeZEDTbRdKV3XRYu/LDREoPswmyS6agd9RAY6jZw4/VbUYfNxdcMLmYd/sj2+D7gsiBfyoO6BD2da69OQQuVY+K9pAxXkYqe/e2BxrklZFvGHYhTv0eFcobH41DoJy10ESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EtSkKPWC; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EtSkKPWC"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83ab694ebe5so183969239f.0
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730151203; x=1730756003; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFZKIzMwJccmjbRWz8hr4dF1BDbSPdCqeQ+MDKxNuD8=;
        b=EtSkKPWCZfA+sDz8o9F15r4pLz9g0/+8xQ7EAgS15POkx3LNMOkBZBZMOIYdIiJ/Sg
         K9KhaHHWMF9MXUCXlnBsE1we1FMtdDSh6o9XeWWpGw4sYH9fydQ5Ld8Kmz+zhthzvqHC
         q2bEjrboXUTkfVJPUO5qW+vACLCxjyuGzwntc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730151203; x=1730756003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFZKIzMwJccmjbRWz8hr4dF1BDbSPdCqeQ+MDKxNuD8=;
        b=fWv8ybiWnZuCNeo5x7lOqOCBrIllSMGsuApd7TGu0/hx8a4+zDWwH3ZwrIBruI7o42
         rd/gHHrDOYICKMq75daOvM43jCjde0gp4DKUd30opPz+UPrx0OuMvDQsfcl2+QzhWg96
         3FrwllRYu6o7oYgpTthSsT58YXPSFxdGc0SUdEQRCHiKVAXw/6aXF81NThfrsi7fUBES
         mQvhRxDh04vYDoOZI9QmOE/SUFukNESPOU9o8eScQ34Wwr+2punRVMkjZP5b0GrWAvcL
         71XCD938gmy+0AoEcBYd7DUxuYAxF+NffFjnl4O/sn1r8t8JleXf8jZW8MUOgmubViv8
         1VUg==
X-Forwarded-Encrypted: i=1; AJvYcCV1LECF8U4B3Wb4Ur8xd7up9le//GhrHbpto8cFabKKPPbaH23GR92o50mTecntANlS8/0e/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4ab3ui4fINSMj+FuPqhjPLtJvIpIrd8MHoG0uFvOzSfbeVK2U
	aFv58yCGPKussF5loTdYWlb0Z/XVmXov5uSuzsnisInCqjU7E13sgU5E9rQHuWp3w0V1KMXOTMK
	MPY2ZyOA00DTHCN4+jfbtvTAfuU8PznFbbVsE
X-Google-Smtp-Source: AGHT+IFRf7Qdfzoq2U9A+NIDwOGbIKY7nZWXffb09QD8AJkz3xy2j34ROShaH6Jj6HGBK3DfHA78bcGG4mf4sL65r5o=
X-Received: by 2002:a05:6602:1686:b0:82a:2a67:9429 with SMTP id
 ca18e2360f4ac-83b1c3e7abemr939673139f.5.1730151203568; Mon, 28 Oct 2024
 14:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240827181717.187245-1-robdclark@gmail.com> <Zx97PU7cUEVCnpPl@google.com>
In-Reply-To: <Zx97PU7cUEVCnpPl@google.com>
From: Rob Clark <robdclark@chromium.org>
Date: Mon, 28 Oct 2024 14:33:12 -0700
Message-ID: <CAJs_Fx6EB=0GMqe4cZVdxptFSV3b63HHybfTOgiYVBudgAafsA@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
To: Mostafa Saleh <smostafa@google.com>
Cc: Rob Clark <robdclark@gmail.com>, iommu@lists.linux.dev, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <dri-devel@lists.freedesktop.org>, 
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <freedreno@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joao Martins <joao.m.martins@oracle.com>, Kevin Tian <kevin.tian@intel.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sean Paul <sean@poorly.run>, Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 4:53=E2=80=AFAM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> Hi Rob,
>
> On Tue, Aug 27, 2024 at 11:17:08AM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > This series extends io-pgtable-arm with a method to retrieve the page
> > table entries traversed in the process of address translation, and then
> > beefs up drm/msm gpu devcore dump to include this (and additional info)
> > in the devcore dump.
> >
> > This is a respin of https://patchwork.freedesktop.org/series/94968/
> > (minus a patch that was already merged)
> >
> > v2: Fix an armv7/32b build error in the last patch
> > v3: Incorperate Will Deacon's suggestion to make the interface
> >     callback based.
> > v4: Actually wire up the callback
> > v5: Drop the callback approach
> > v6: Make walk-data struct pgtable specific and rename
> >     io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
> > v7: Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty()
> > v8: Pass pte pointer to callback so it can modify the actual pte
> > v9: Fix selftests_running case
> >
> > Rob Clark (4):
> >   iommu/io-pgtable-arm: Make pgtable walker more generic
> >   iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
> >   iommu/io-pgtable-arm: Add way to debug pgtable walk
> >   drm/msm: Extend gpu devcore dumps with pgtbl info
>
> Do you have plans to post another version of this series, as I am
> working on some patches, that would use some of the common page walk
> logic, so it would be more convenient to have them upstream.
> Otherwise, I can have your series as a dependency.

Sorry, this had dropped off my radar, I'll post an updated iteration
in a couple minutes.

BR,
-R

> Thanks,
> Mostafa
>
>
> >
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  10 ++
> >  drivers/gpu/drm/msm/msm_gpu.c           |   9 ++
> >  drivers/gpu/drm/msm/msm_gpu.h           |   8 ++
> >  drivers/gpu/drm/msm/msm_iommu.c         |  22 ++++
> >  drivers/gpu/drm/msm/msm_mmu.h           |   3 +-
> >  drivers/iommu/io-pgtable-arm.c          | 149 +++++++++++++++---------
> >  include/linux/io-pgtable.h              |  15 +++
> >  7 files changed, 160 insertions(+), 56 deletions(-)
> >
> > --
> > 2.46.0
> >
