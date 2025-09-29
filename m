Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19EF3064A4
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164647; cv=none; b=mWIl6xZiV81+nStiIYGah0jLLMM0N68DjbQ41MwpB1VRUlu+ZWb0piTNocRsIV33Xl0ADVfPGsVA6TEmZNKkLOacNirdP9cYDOGjj1iWRhhyuxFh256CCbG01jL26Yfg+7nTMhNiwmI2+c2h+yANt/ypxehxxt1xQOwYvZyeSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164647; c=relaxed/simple;
	bh=58/qHynbJ4KPMwfA94nS5LugvxXvcatLKednOaZ7gxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6p0+8KYmxUUw9C4MopL355u7myml+6kSunJKA+bZeHyQJIVxc65brxygN3ZMDoWSfamT486fsVsXIJBOrTZicUCIcW38nyzujp4J3tP/4KsUp+Kg4T62pNBPXZTSSk1E3OouvwKSob0BfNnNiheSEKnYPFxlndJivlaf0Tqf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ZFMKg0Uh; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZFMKg0Uh"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4dfe74ed2e1so22082801cf.2
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759164645; x=1759769445; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7gI1D223HLxcIxgZm6OvXUfKzGjchEMVkrQhqdo1hY=;
        b=ZFMKg0UhhFhLHfzbjulx2QTzfsTPF7CfC9Hb5Tbl9n6yOkIyMmFIWRX0bsZ+ichyP8
         OaTUgczetTcyj7EWdRv0/dVWJzrobqAS34WHrRTscE9CU/Tj2MlsIAqQX8YsC7Wecx/D
         4OmNFpF4LwUUwsqlBM8o8YR85TlwIYNvJ9Kpdw9F7nnFBPlPIZBb44iYx+S4KRazQrLe
         lXleg5Ku2/7e2oZCtg+8XEfUj9hFamljwpIsD8d1H3z8CJ0/ifIlsVkLhzTi+8yY938P
         PAw6hSotexIbSlNhavkTHdKkSb8tdr323uyBZiodIL6girpSfGlKxhHUEblNVZ3ixgbK
         dtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759164645; x=1759769445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7gI1D223HLxcIxgZm6OvXUfKzGjchEMVkrQhqdo1hY=;
        b=n1rK12B1qbNacuLp99zBRMJKwVIlBgG/xHiWgP/2Bo89JYv3QClUkmBIM5y6qTAIot
         H61hunnGPmaNYZ5SS8kA/rut187nIlEjU23OGzh1Q144ju0x78f5KrJiua8pu79dNiGh
         fH58cPYv9PvWtxid9ZigBkXqSEMLPSztsQZq0j1L7axK6Fzm1ktrBYii6HkcpObsnYCT
         P1DEt+D69lHoSIxXS3CrQO4n4JvKQNOypjdwllrj4KetMaqECIppqPdcmgV9KqCeUjOB
         A8n+b7BYpglH5y4ZEMcTLOaakuUWxy/8YUMGvnv40aVSEsZ2xhg7y0wEMhEuhN6wOUD3
         Eoeg==
X-Forwarded-Encrypted: i=1; AJvYcCUdnRjH7C31xi5my3iRhOa3V1amdlDnh23koLtfdVEf+rtEcjMEOktedLyxWfAhVxjqLQcSew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7db0KBl/87uyzWJLb6JwWmWLBSR4YfyK5UAhw1nREbmJnJBMj
	OEPAyWu1IJjbJ++u2vAxnA8kAUjU7x4F/qbZ7nFovh+RHcoGxxt03nppGz/PVyrCaFg/wJbq0w4
	oOxZPvGA1PdvMrGHrLZzORQT3HykhC085mDzv3qhfqg==
X-Gm-Gg: ASbGncvteZohDHwK0hwz0qyNynCbNOoxzsgLkM1oI+Da3G5DUWSBWM7Ic05FGHY2cyW
	lPAVdhvrrfnkJEnoDY/7tfDuTlPvEW2sqCXpW3UBNGfu9GCnhgWRQjJw5mCEstspkBzr2FjO21y
	t/3tgU2cS1sWk69xSS8TP6VWB7tJ3+k1surLft22/R32XJ4peJVsOTvbRoLlAsHNeibTwELA3/w
	zw+Iv0Le+SD1Ac=
X-Google-Smtp-Source: AGHT+IHgUzM/EXrUxROfKIF2cWvTDNuiGT8lJQeSEkEeRI5k1+IecbiWt3TnKhFMPXUH2+PKuVUlPqPVEXI2ECbgRBw=
X-Received: by 2002:ac8:7dce:0:b0:4d0:ac40:faac with SMTP id
 d75a77b69052e-4da4bfc063fmr225146201cf.53.1759164644679; Mon, 29 Sep 2025
 09:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-4-skhawaja@google.com>
 <20250929155123.GC2695987@ziepe.ca>
In-Reply-To: <20250929155123.GC2695987@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 29 Sep 2025 12:50:07 -0400
X-Gm-Features: AS18NWCx5jBmL63GoATW04OdTxV3QHh9MjTQAXnbdttnUQiouCPiZpEnod1LS6U
Message-ID: <CA+CK2bA3dcc8320C481zgihW9VrcW4+saU3uCxhgfH-THt8X+w@mail.gmail.com>
Subject: Re: [RFC PATCH 03/15] iommu/vt-d: Prevent hotplugs when live update
 state is not normal
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:51=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Sun, Sep 28, 2025 at 07:06:11PM +0000, Samiullah Khawaja wrote:
> > Hotplugs should not be allowed when the live update state is not normal=
.
> > This means either we have preserved the state of IOMMU hardware units o=
r
> > restoring the preserved state.
> >
> > The live update semaphore read lock should be taken before checking the
> > live update state.
> >
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > ---
> >  drivers/iommu/intel/dmar.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> > index ec975c73cfe6..248bc7e9b035 100644
> > --- a/drivers/iommu/intel/dmar.c
> > +++ b/drivers/iommu/intel/dmar.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/dmi.h>
> >  #include <linux/slab.h>
> >  #include <linux/iommu.h>
> > +#include <linux/liveupdate.h>
> >  #include <linux/numa.h>
> >  #include <linux/limits.h>
> >  #include <asm/irq_remapping.h>
> > @@ -2357,6 +2358,10 @@ static int dmar_device_hotplug(acpi_handle handl=
e, bool insert)
> >       if (tmp =3D=3D NULL)
> >               return 0;
> >
> > +     guard_liveupdate_state_read();
> > +     if (!liveupdate_state_normal())
> > +             return -EBUSY;
>
> Pasha, this is madness!
>
> Exactly why I said we should not have these crazy globals, people are
> just going to sprinkle them randomly everywhere with no possible way

We now have per session "state", so presumably, LUO should provide an inter=
face:
"struct file" -> session LUO state.

We should probably add interfaces like these:

liveupdate_is_preserved(struct file *) -> return true if file is preserved.
liveupdate_state(struct file *) -> returns the current state (or
LIVEUPDATE_STATE_UNDEFINED if unpreserved) for the session to which
this FD belongs (or  (in the future we could improve to per FD
granularity, if needed, but I think per-session is going to be
scalable enought).
liveupdate_state_read_enter(struct file *) -> to protect state
transition for the session to which this file belongs.

> of ever understanding why or what they even are supposed to protect!
>
> There is no reason to block hotplug. Do the locking and state tracking

This makes sense, adding a new device should be fine.

> properly so you only manage the instances that need to participate in
> luo because they are linked to already plugged devices that are also
> participating in luo.

Pasha
