Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE05D1859
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045444; cv=none; b=gJsmXEkde7Ca9OPYLNm9z1+SUNxP+PbBJ6xmz6FD7cO8U4xtIlWFTR/fyodaT3NGJHF8qIv/plOV5JvisswZxmor4g+eRnAG2EvUZN7aLKkLN9zQldiYSgFpXZ5hEmfrThPQxgHjhnwLIXrdwcxSP7GYz6LBepzuVY7YMj3ADtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045444; c=relaxed/simple;
	bh=+GF1oCaa4XIdm2rCPBWvV+uTROdOd1KyxDhkbhawAvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeCO0FH3KwngCS4fK8StQ9qizt400EoxiQng93gfu7mlBvxaM+N7R5BL3/ZQrB61o9992Z/11Tz564/iw3L2s8RMgX+I3CfGBFaK/p5Ur5V/I/rcl9v6m4Lo/prsY64WITJMi63NtryK81q7N+CfG75ciAtJGroVHeQEKaTYC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nofvZaOf; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nofvZaOf"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so3931770e87.1
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729045441; x=1729650241; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qiWvrpKzeq83YnQqOE7ISPaRFxYtddrp60dv+zolb9U=;
        b=nofvZaOfyWsBjfzInq6Nt5348snRx1WfxC8/qUyceii+muEi+UPrZLzPtbO35vJmzY
         WoOnUDYgUY7NS935HNxhPMqa738rDPNZJl9/t//bhdwBox68qoOzfS/Fb8ImybKAtmwc
         811UEjfXwKpbEJxjuTTO8k3i7bAgDdimRnn7yfZpZR22aEqHFGQ8zRn9wSyff4DH8smz
         6rI8kXlZL4ExKYnY1uvWSvhwdzMJnBP+E7ZBq20Z2hLPgjE0VDZ8M1lyFwtzYWnUatrt
         LE1Dmd6TCcljMgkSHq9Mk1us+qHMezNwxA2vfDMRJmbTJmCXu6oCpP10d4iWxNYPXkYp
         bCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729045441; x=1729650241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiWvrpKzeq83YnQqOE7ISPaRFxYtddrp60dv+zolb9U=;
        b=UQ/m0LXKgYhyMbfewJexkbqADksqm1dFUSeT0mjaQBFseEWrFsabDs+XcDHORKLrvR
         OGzfFKN7/mWIQUU2K5UekC+5crm+rugMQTjaoYG8sqy1WFlb2ITXp+fhSs9dRKUIuCZ2
         w5qekt/KVGnZyrX+kutHLogFbBTJpyj9V4N5+++sXL8BPwa9H+QUJJ+rXb86U86aHTBN
         2aUNL28pH1nc11shGcLHhVZGXNZgBfvXjP+z6j8RBcbKyp9M/4kJpERs0uVDGuMt86Vr
         I8dd858PD7DTVqga+kNxpmqBPh9MfzlwxqNcSd2xTTXkcA7Obdf5tLdHP/AQEaM2Wz1Z
         XloQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdcCkaBcynZkIEPvL/4+MaFKsg8M4TwcRgNH+Jwd4Z9sye8aif0SlZ7695PzqusgE3J/OTTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaaCJmBmnznsxg52OQi9RvYY6kxQOky1AJ6K7QPAywlW1IYcS6
	ZtzzZhuI9dH6g1lcv3m7pcjhurYjEq779F00OT0mx5RaIwTDb5Zhym9+EpL7lXgIMVxVWup6++Y
	gdzDWlXVURDRS4TwsJsIi6p37IJKiKHmlquSTlw==
X-Google-Smtp-Source: AGHT+IEV/byr5lu2UsUC2RRVM2gDVA1eLiMxNLS7gT854PVdY6PhxgM/HLAZnNXx36HxSizxkKPg933nd9PyJjzpqHw=
X-Received: by 2002:a05:6512:3094:b0:539:da76:c77e with SMTP id
 2adb3069b0e04-53a03f045ecmr1718387e87.5.1729045440632; Tue, 15 Oct 2024
 19:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
In-Reply-To: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 16 Oct 2024 10:23:49 +0800
Message-ID: <CABQgh9E32c5inrn=Q5HWThuJQ4xV=EFWLGwbyxVLHQVUZ_uYCA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Initial support for SMMUv3 nested translation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>, 
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Jason

On Tue, 27 Aug 2024 at 23:51, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> This brings support for the IOMMFD ioctls:
>
>  - IOMMU_GET_HW_INFO
>  - IOMMU_HWPT_ALLOC_NEST_PARENT
>  - IOMMU_DOMAIN_NESTED
>  - ops->enforce_cache_coherency()
>
> This is quite straightforward as the nested STE can just be built in the
> special NESTED domain op and fed through the generic update machinery.
>
> The design allows the user provided STE fragment to control several
> aspects of the translation, including putting the STE into a "virtual
> bypass" or a aborting state. This duplicates functionality available by
> other means, but it allows trivially preserving the VMID in the STE as we
> eventually move towards the VIOMMU owning the VMID.
>
> Nesting support requires the system to either support S2FWB or the
> stronger CANWBS ACPI flag. This is to ensure the VM cannot bypass the
> cache and view incoherent data, currently VFIO lacks any cache flushing
> that would make this safe.

What if the system does not support S2FWB or CANWBS, any workaround to
passthrough?
Currently I am testing nesting by ignoring this check.

Thanks
