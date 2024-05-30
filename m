Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64E14374A
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055936; cv=none; b=RcMEhX7nhJrsIlX0MrkfnH8WyrCpJ0RdmDGV4iZ6Y3gnGi7COsWEIeS/NUTDFgJZp9eSrDKdS0tPO7Trd6NfjeyzpVYHLCsx5FHPftqeGptmWLleRAP0RA6t0VACHD6igZ4KKNnqbnXPKWd3D+YjrWP3TA8o58nm2S/15Wc89PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055936; c=relaxed/simple;
	bh=lmnS+uhE1B+Xtb3Jn2lTEbYhgqdcwEtClUTNalj/uSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rsb+y9HMy3ewh7N0/Yqzvw/dJKOK6DUuqGGNWGKMcJHihXkmyRDdB/JCsf2LpvUos/8GnfN+5QzUpZSlxT3g+8zngUdRq562zUlQQTI0FDjd7g5TGOP8xJ3mTOcL0IlNFI3TBdmuwwzOeRpZNJf8J8e8u3DspH+kY4d35LU+E/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HmKlWXXN; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmKlWXXN"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfa682a4025so45011276.2
        for <iommu@lists.linux.dev>; Thu, 30 May 2024 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717055934; x=1717660734; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B+oJ9AQU1WwAFE3BTuASvQX6ynujHPOOLDvZ4IBH4iY=;
        b=HmKlWXXNuoRbCQHkGH5vQVK7DL/qiHvblRXpp0KUnpcqV1K9cAhLjonogJImbHJMMW
         giImgq3FbETcwbtPbk0RiiMgbso/R/eUg7P6Oip4EDkfSlQyYb/PlKW4T1vyqilBqk+C
         nfZF6tG3qbYKhF+43UE57q/H/Bs50N8dfbmHJLnm2YEv5XFBPkYqLsjVCOIezNUkE7dA
         TlzUSUMmVWh/Wc0icfUKm2ZS3CQ03x+5rxVxQkQCCUbKzDVaoHoOHZpyXvOMJPgEE9mb
         WSV8YkX+jWmKlNNBYQcB4Xg5rihbQod8mAAS8SVc71edmzbLUaTmWTJRY2LqKjAkkNTn
         F5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717055934; x=1717660734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+oJ9AQU1WwAFE3BTuASvQX6ynujHPOOLDvZ4IBH4iY=;
        b=ppA3MKaUDVxE7ZZVQjIHduUp2gNYcgvm2sGwHVZcInD9dPc4YKFwF72SxRwC+PJQ6y
         JvmNqV1FAub0KljKTnOXoPUe6dxEy4NpIjX1coHcXSMunj9TS/5S5JjP7TiINjpzGFFQ
         wlXQ2/Bbf+j9AoEsoQh0ui4V1Bsbcy7S55gSf8Df6QwZEkXGOPwaKioEybCXln5Cd5t8
         6rg03Mpa61hxGfYw1YuZvI1fyaHwUcDQQRENlT0jsDC8WP5G9uUR2YwskjZUhljrZOKO
         5tAbaxZ6RJLA6zaEix5Mv3IKNTLT3AbD0jkn/mR72UuM5o/hC7UxJpxchKrxx24mqMZZ
         Xf4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7RApfjfOq+UhfBuXT3SG9cfOgKu+Cxvyh5clFkriQPIUuIEGS9HP7/dYNLzqxYct4dunbty9qa0/knC1tdKZgXxLNJP0=
X-Gm-Message-State: AOJu0YwRYDX7Vn6U7AcMmRIiCMxlUtioe5QystViGW4+4/I1yQ1daoEs
	JHhLUK/jvRkTTyvrDwxaOHAgjmwTSnDL8V9rrI4pyvysEhwfeK8NAikKLytr7lvZPcdsRZz+OT8
	EhlTMPEbU9C1bcRPyd0nL6QtPJuZqd3JXwStwtw==
X-Google-Smtp-Source: AGHT+IHWn8jqCUpUtwn4GZB8DSUWhC0pqZv08o7PmbgCc14pEd89tke9BgPzyPGi5xXBW4hatiPVYSqRFMZI/ea2rj8=
X-Received: by 2002:a25:2e07:0:b0:de5:558c:e9b9 with SMTP id
 3f1490d57ef6-dfa5a5bb588mr1579742276.11.1717055933851; Thu, 30 May 2024
 00:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
 <20240529053250.91284-7-baolu.lu@linux.intel.com> <jd7df7jshswukstxwbfoxuswyltyemdmkx272i5mpldlfsk4t7@ad36olyvmw27>
 <960bfc23-22b3-48d1-baa6-2707767875c5@linux.intel.com>
In-Reply-To: <960bfc23-22b3-48d1-baa6-2707767875c5@linux.intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 30 May 2024 10:58:42 +0300
Message-ID: <CAA8EJppZU5yy4g85oMWzV_O9Qo91-Cr6d+W9Rz+K+mS6tfU8kw@mail.gmail.com>
Subject: Re: [PATCH 06/20] drm/msm: Use iommu_paging_domain_alloc()
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Yi Liu <yi.l.liu@intel.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com, 
	Jason Wang <jasowang@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 04:59, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 5/29/24 4:21 PM, Dmitry Baryshkov wrote:
> > On Wed, May 29, 2024 at 01:32:36PM +0800, Lu Baolu wrote:
> >> The domain allocated in msm_iommu_new() is for the @dev. Replace
> >> iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.
> >>
> >> Update msm_iommu_new() to always return ERR_PTR in failure cases instead
> >> of NULL.
> > Please don't mix unrelated changes, because ...
> >
> >> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/gpu/drm/msm/msm_iommu.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> >> index d5512037c38b..f7e28d4b5f62 100644
> >> --- a/drivers/gpu/drm/msm/msm_iommu.c
> >> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> >> @@ -407,9 +407,9 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
> >>      struct msm_iommu *iommu;
> >>      int ret;
> >>
> >> -    domain = iommu_domain_alloc(dev->bus);
> >> -    if (!domain)
> >> -            return NULL;
> >> +    domain = iommu_paging_domain_alloc(dev);
> >> +    if (IS_ERR(domain))
> >> +            return ERR_CAST(domain);
> >>
> >>      iommu_set_pgtable_quirks(domain, quirks);
> >>
> >> @@ -441,7 +441,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
> >>      struct msm_mmu *mmu;
> >>
> >>      mmu = msm_iommu_new(dev, quirks);
> >> -    if (IS_ERR_OR_NULL(mmu))
> >> +    if (IS_ERR(mmu))
> >>              return mmu;
> > NAK, not having an IOMMU is a poor but legit usecase for some of devices
> > which don't have IOMMU support yet (for example because of the buggy
> > implementation for which we were not able to get all the hooks in).
> >
> > Please don't break compatibility for existing platforms.
>
> Sure. I will remove this line of change. Though I have no idea in which
> case msm_iommu_new() could return NULL after this patch.

So, even without this chunk you are going to break the no-IOMMU case.
Please don't. This will result in a regression report and a revert.

Instead please provide a way for the existing drivers to continue
working. For example, something like:

if (IS_ERR(mmu) && ERR_PTR(mmu) == -ENODEV))
    return NULL;



-- 
With best wishes
Dmitry
