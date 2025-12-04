Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E90235F8D7
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870442; cv=none; b=DiW+/ruV7Hg/pLonZ38cc0RibZHFljOVzuPQmidd/s5kxxaECc8tqTP/QuhzwcwZX1jUQwlfXV2A2ycFgnyEA1K9dGozc92xRGdDi8f0rIeCm1nrds3DjH4TC5HOXmeMvImxhUlkAvFNE2UmwzTqNsJN6p7US4jQT+qipK6t8OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870442; c=relaxed/simple;
	bh=FlniMQLwJFnqQGUgDm+tU2QcEYTEcAIURZlgd8iTATE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1pdpNrhaLHYUSVrxlPXIb2jAJC1uKagQv0jAYoBER6Jbn0GI3gAuEURYjQAhrTcB6ciXP3/s2ouiHNGU+8AixQoto+ubkfejlZarGoF8Ghp1ciN/kEMVswACZqZzcX8tlWJeZ9eT/y5a2QBjt/8MlD48r30hWFzXPJPXf4kn34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LcOGNYJ4; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LcOGNYJ4"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4edb8d6e98aso7751cf.0
        for <iommu@lists.linux.dev>; Thu, 04 Dec 2025 09:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764870439; x=1765475239; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkbYDerKvxcvyfhz5hzCJmkRFHEfNtvZpLABvhCCdHc=;
        b=LcOGNYJ4838xnZmOc/jybQLrjh6EwBKCSDQGTS69SmhhD7O6MTv144VZ5LoHPjtVvq
         glwyRprvnSTzUc7R7Tlen3ABkVqktifVL/TwmH8wz4ETUhlec25RxkfyTR1SMK1VlFDT
         F3gpI80u3cNsajryw7txK2jx3cCUwyTzCszcgTtsxYLCSc7HTejTc2o4uSMY/nXXnAs5
         poz+PRZyVa73/r948R9yX9NBvQJIb0xj9PfbTqfUiecg3z4X3PSF5IYnv8FkT4e3dl8n
         x9J9d9vwZIFhQF4xMsrW6mH0B8Y13yYeR6dDcV5mLsLmYMKN/4KIY7Y8CbDvszI95l5f
         5/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764870439; x=1765475239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DkbYDerKvxcvyfhz5hzCJmkRFHEfNtvZpLABvhCCdHc=;
        b=t4QA0yLXsSBSeN8a0o4fgLqtGHRrtHAQWRjslX9VYE2st9vBXr7bMsUvzSthIB6zOR
         Z7u5vGKoahvtaZwYDpuTDHu++TABY9hCVXSN9aw8i4tjJhekoDNYJXkdmux5Rz5UBmkL
         RKYRQOlHfZFxxRIOa1uCbHqcwrhHxQXlzuRNhUeKmWOQ4nH35WyDFIUVu5Q3b+RFKp0C
         euBW38vQiIQwpiHOacQ8XMTD7pCFo1HLEIN5FSQ0EkksgnwJGoqCmS3BFQdUd7X0/L8y
         PXx2OZJ/CiSSkXT7ao3KtZ4e1L7Sdb7fn4JRpf4ZIsrWcrHivfRzKgRZYMarnygYTvX9
         Clpw==
X-Forwarded-Encrypted: i=1; AJvYcCXJfTD08jcCy+G0jITRGZ1UWt92kva6dkoBSbY04lRnBRCUTilSc9k/PuXqQ9oX7NpYoHGDxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCTXcIzsPI4mYs8Xq75OiYMbncRCx72De8bL2VbvrzuAMkl4F2
	5q/lV3WfUkdoAW7mQaWs+9YhOKCOiZu+ie3rE4MZxr4Hc0k4scnM6NKFYQwwbVuC0bKGY9Pg2uK
	TLjVS9C6pAcFIo/pOtWUqkseFXnWXBgj6k+M2FLQD
X-Gm-Gg: ASbGncsxGFU6W4ui1+T01GfwSPBJBaIQmj7zX9doHkIZftdJD+Ac8iXq/2SL0VATJri
	Q7G1LfXGaGEUp3XAo2yVt7owHz9jCO6fJrhbqFHIsNhySVgVUPsBoNcXL9E0a/If1l6YtAf0lEy
	YhfJZK0PLWV7JSe1LfIBVUVKAyovaivgOhlKV6122RK3RMYgWC4s8GkKnJfWt46MbduWZQV3Y8j
	MMR9paiPR6MPKOxeSqx+dI8myJFeAk4LU01THW4+l7feGktUvw14P1LxLzU4IbD3GAzE4bPyP44
	uODBApQ9JLAfIRnv2ExesXG3Z5T4GkZvfKkhsQ==
X-Google-Smtp-Source: AGHT+IHhyoFXZC1XjqQA80KNSD27EUcpK/2++HyHQMGudSNlrZdpTPVDR+1A+9xVeFCtw+DuXBvvonPHlGSgfT3ET0s=
X-Received: by 2002:a05:622a:11d4:b0:4ed:2f7d:bd46 with SMTP id
 d75a77b69052e-4f02cc42795mr3893081cf.13.1764870437709; Thu, 04 Dec 2025
 09:47:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com> <20251202230303.1017519-17-skhawaja@google.com>
 <299dd94a-2cc8-4e5b-984a-4ffef0f05e8b@linux.intel.com>
In-Reply-To: <299dd94a-2cc8-4e5b-984a-4ffef0f05e8b@linux.intel.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 4 Dec 2025 09:47:06 -0800
X-Gm-Features: AWmQ_bkwSdLRYOi6ORo-bZMRE8NNbyjv64aIf95WrJZ_jOyl-rup0QJbgMJ-uOw
Message-ID: <CAAywjhQeL+fbyHQnmc0QKQ7OCi9pHLN5B-vu41Kxi25RLXpypA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 16/32] iommu: Add API to preserve/unpreserve a device
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 9:51=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com> =
wrote:
>
> On 12/3/25 07:02, Samiullah Khawaja wrote:
> > iommu_preserve_device/iommu_unpreserve_device can be used to
> > preserve/unpreserve a device for liveupdate. During device preservation
> > the state of the associated IOMMU is also preserved. The device can onl=
y
> > be preseved if the attached iommu domain is preserved and the assocated
> > iommu supports preservation.
>
> If the device supports PASID, multiple domains might be attached to it.
>
> ...
>
> >
> > Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> > ---
> >   drivers/iommu/iommu.c      |   3 +
> >   drivers/iommu/liveupdate.c | 115 ++++++++++++++++++++++++++++++++++++=
+
> >   include/linux/iommu-lu.h   |   2 +
> >   include/linux/iommu.h      |  18 ++++++
> >   4 files changed, 138 insertions(+)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index a70898d11959..3feb440de40a 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -382,6 +382,9 @@ static struct dev_iommu *dev_iommu_get(struct devic=
e *dev)
> >
> >       mutex_init(&param->lock);
> >       dev->iommu =3D param;
> > +#ifdef CONFIG_LIVEUPDATE
> > +     dev->iommu->device_ser =3D NULL;
> > +#endif
> >       return param;
> >   }
> >
> > diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> > index 25a943e5e1e3..5780761a7024 100644
> > --- a/drivers/iommu/liveupdate.c
> > +++ b/drivers/iommu/liveupdate.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/liveupdate.h>
> >   #include <linux/iommu-lu.h>
> >   #include <linux/iommu.h>
> > +#include <linux/pci.h>
> >   #include <linux/errno.h>
> >
> >   static void iommu_liveupdate_free_objs(u64 next, bool incoming)
> > @@ -209,3 +210,117 @@ int iommu_domain_unpreserve(struct iommu_domain *=
domain)
> >       return 0;
> >   }
> >   EXPORT_SYMBOL_GPL(iommu_domain_unpreserve);
> > +
> > +static int iommu_preserve_locked(struct iommu_device *iommu)
> > +{
> > +     struct iommu_lu_flb_obj *flb_obj;
> > +     struct iommu_ser *iommu_ser;
> > +     int idx, ret;
> > +
> > +     if (!iommu->ops->preserve)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (iommu->outgoing_preserved_state) {
> > +             iommu->outgoing_preserved_state->obj.ref_count++;
> > +             return 0;
> > +     }
> > +
> > +     ret =3D liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj=
);
> > +     if (ret)
> > +             return ret;
> > +
> > +     idx =3D reserve_obj_ser((struct iommu_objs_ser **)&flb_obj->iommu=
s, MAX_IOMMU_SERS);
> > +     if (idx < 0)
> > +             return idx;
> > +
> > +     iommu_ser =3D &flb_obj->iommus->iommus[idx];
> > +     idx =3D flb_obj->ser->nr_iommus++;
> > +     iommu_ser->obj.idx =3D idx;
> > +     iommu_ser->obj.ref_count =3D 1;
> > +
> > +     ret =3D iommu->ops->preserve(iommu, iommu_ser);
> > +     if (ret)
> > +             iommu_ser->obj.deleted =3D true;
> > +
> > +     iommu->outgoing_preserved_state =3D iommu_ser;
> > +     return ret;
> > +}
> > +
> > +static void iommu_unpreserve_locked(struct iommu_device *iommu)
> > +{
> > +     struct iommu_ser *iommu_ser =3D iommu->outgoing_preserved_state;
> > +
> > +     iommu_ser->obj.ref_count--;
> > +     if (iommu_ser->obj.ref_count)
> > +             return;
> > +
> > +     iommu->outgoing_preserved_state =3D NULL;
> > +     iommu->ops->unpreserve(iommu, iommu_ser);
> > +     iommu_ser->obj.deleted =3D true;
> > +}
> > +
> > +int iommu_preserve_device(struct iommu_domain *domain, struct device *=
dev)
> > +{
>
> ... but this helper only cares about a single domain.

Thanks

Yes, PASID support is unimplemented in this RFC and I will be adding
PASID support when I send a non-RFC patch series. I have mentioned
this as future work in the cover letter.
Also for PASID, the PASID table also need to be preserved.

>
> > +     struct iommu_lu_flb_obj *flb_obj;
> > +     struct device_ser *device_ser;
> > +     struct dev_iommu *iommu;
> > +     struct pci_dev *pdev;
> > +     int ret, idx;
>
> Thanks,
> baolu
