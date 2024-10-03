Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88219C56A
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963929; cv=none; b=m7u5Nj4RcXR98v3mV1eiMLy8wD6zssELFkfJazWMKtalRQ/AL0qeceplFu+KqPW+FsYIkiqMWffTfVOshWq5K8HfkyJi5T5TBNWjIVsbZS9efA4IoqNOm5lwj+TdK8GGFGWe3OyWcEGyJUhmPeMKY1wl4VE7peDh33iWAt1FOTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963929; c=relaxed/simple;
	bh=hH98li1flmtmsrcyn5hXWF3rH2qxp5zxvrFxRxvO21U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gncK0M/Tnw+Lo7IXEgmziiIC5+B3VKi+ls7tFXglkhYVvRZHJlYTUXw8KxGZC2GQmbf2M1OggOE856goF8KO/OytHmE4owzA1cjzUlFRaM1X9yo020I4HCgYrzPykCrCe5SDIeqjMxESERfihCmKfYNruTS7jVZOKRnmwoaQf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h0nitdIo; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0nitdIo"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2facf48157dso12141911fa.2
        for <iommu@lists.linux.dev>; Thu, 03 Oct 2024 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727963925; x=1728568725; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urLJW6NECL1ucqye5UhOxKoHxkMcZO/OrugWN1Z1yvE=;
        b=h0nitdIoKm3+/KTXs4vXUuMJOm33dV+vWy2qkMVezc4qy3Qd89tupieRMOplcscrBj
         8HtMozfulkICBly4P8hgT95a11iGXhAyTfSu0v7slRTU4/ZAYamD57DZUHkw5m0SFFV7
         u0C69Lk/7s+nQFM0KVhk0wEnUmRv/Y8yiQ4hjhf6ZLEz7d5n++NbOkSEtv/MYWwHls7z
         7DhlDTkR0EtwGFdp2+4sGoNk8JLu7qeLzwsFRMEGsHT3q0t8l3qqBxz9Na42pc0Z31VR
         46MbzRTYUN95aJbmyvrk7Thbw6P1L4akjsDLQ32nRZg1Sb7e2tROt6gVxRJ1xe7AzteW
         20uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727963925; x=1728568725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urLJW6NECL1ucqye5UhOxKoHxkMcZO/OrugWN1Z1yvE=;
        b=fiCxN/TtiESWES/SWOsAMKUptMvN1PbL/WT+2QxXvYGmvNpaJ3uMJYzYrGj/j+LuwV
         IA5vZal626E59TPQeC3K1ufWl8bE/sk76Fd8BfTwIm4qM1B7J/hwcOrSEDlsp6gAJTWj
         9QukrCAi2jRQsYYbmyjSrrn+MYf3Z5iRJflfvM/2htUpZB59E/RrRWKJoxVGSXDfkvre
         3ry2FkFBvR351qrBa0SLNDovbc/edOhAJS+8aHWQ82WFbghBXaKP45gjFOVaLj+Qeh9/
         l1X4b664JZ8j5d4T/9dqPNC3Ow++yZtXuuBLZ8fW7APMwBNvRRqxAXdEXbUGVrvNYVYB
         jTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs14/uVXKIKdvneEXvRJv8ZJSC5hC/tY3G9/caR68xx2qGoWoeOebsWfi5kc8cXJhOcgJFtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrLNYM+i7WCN6/OgsRTbKWuL3KkrP2ODSc7YeW/a6zvdKv+KM+
	X19BPV7F//+g2gGlg+dmS0oXRDHFyudWb60sdW8l4r0E1fXFfBDiIS6vY4JA+50l4LbeHLX6dUM
	FDYXflUcu+JOicNzi/72/bnXdToD52Eb86Q0Yqw==
X-Google-Smtp-Source: AGHT+IGblBPy6kBOpO3xGMhQweMvM2XpmVtiWZNUxokmfJKJqKLFp3SSOen5N/4deNadbfpJumzlOeeP0tfYdvrs/WM=
X-Received: by 2002:a2e:9215:0:b0:2f3:f358:8657 with SMTP id
 38308e7fff4ca-2fae10a6b58mr37979671fa.44.1727963925258; Thu, 03 Oct 2024
 06:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240812072811.9737-1-baolu.lu@linux.intel.com>
 <ZvrUfoTM6s/jv9Nv@p14s> <20241001133510.GD1365916@nvidia.com>
In-Reply-To: <20241001133510.GD1365916@nvidia.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 3 Oct 2024 07:58:33 -0600
Message-ID: <CANLsYkyUMrLmPMaKH8sGHrB1zXCjXbyCje0zrsqFs68JT+NGKg@mail.gmail.com>
Subject: Re: [PATCH 1/1] remoteproc: Use iommu_paging_domain_alloc()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-remoteproc@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 07:35, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Sep 30, 2024 at 10:40:30AM -0600, Mathieu Poirier wrote:
> > On Mon, Aug 12, 2024 at 03:28:11PM +0800, Lu Baolu wrote:
> > > An iommu domain is allocated in rproc_enable_iommu() and is attached to
> > > rproc->dev.parent in the same function.
> > >
> > > Use iommu_paging_domain_alloc() to make it explicit.
> > >
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Link: https://lore.kernel.org/r/20240610085555.88197-13-baolu.lu@linux.intel.com
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> >
> > I have applied this patch.
>
> It is a bit late now. Can we run the stragglers through the iommu
> tree? We want to put dependent patches on top of this.
>

Sure, we can do that:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Please send me a pull request so that I can also carry the patch in my tree.
