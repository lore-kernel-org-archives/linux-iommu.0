Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6D147C86
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041453; cv=none; b=oKemj2FjN5GqeRBTxDlA18nknQteFQ6AdQ9LwTFBijJZDTd1cu96tvy3s14z7h9nfr/l+U5NBQir/vvX81gjO4viSGJKmW7eQQJRdRp7HecZo+15UA711Ya9LI6tv16H/gwdgvY1GW5UCnfjmF70dUQEO1NS/L3nEgwO4DgOHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041453; c=relaxed/simple;
	bh=tMsaL+gngbDqSGpVyjBaLFxBk/tAAdDM/3WNrKNCV7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjEhGCksm5EQifkTSBHoz+9aMPqruo3sRZJnZI4jNgEEe8EwuofSsUbykLAPT0MTTabaKOz/WbWNCNeXQPvEIjVzw7xaRndaxFu/VnRwFQm8ursQd3Y5neEzLiDjihYKhWW1EqMglQPgGMRvZHShRopcGOFmvwcPVhynMxrP/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LpJez6qS; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LpJez6qS"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4405743ac19so17374111cf.0
        for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718041450; x=1718646250; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GrdEb8M/+pvGUUH5WED2UUEkTBIRq7/wi9HUoKcIHzU=;
        b=LpJez6qSc2rFkjOlT3rbCQ4jj1jMOwelEM0qzz8A1B916cNt8ELQHZ94CjiRTfPsnI
         urIUX1UcVUljcIyRrAsjOZk6bttgWebH1ANBSy9tZvWmrREhIx2qzCF4oZavSZ/BkxhW
         V158yHYuXmL2QPSXfGtN9SsiaXjczf0eUwcCMMXrB6toojlbm0x1Gak1TYnVq9uEWtqM
         RyUDZdtn4X2iZjGdcwkPeEH3GG5Hd93jG0E9x9itEIbuGSMVpOzu9iam76ZdJWnrMYHX
         BD4TT7YfEQ4UaRjrqSfGb9iJi51zDrwbJnUm58Dg4xe4ghOImyq2C4BuTkhIpbz6V/FN
         5M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718041450; x=1718646250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrdEb8M/+pvGUUH5WED2UUEkTBIRq7/wi9HUoKcIHzU=;
        b=XrlzVV0zOoKmbredpuTyIiXBqLwJlpRb8t1ky64TfQS24spZ9nE6NBIc01Hq0f3Hls
         DNJk5SptBPMsyn45OF2oEfHtk9n68K2Lfpx+9mpZWuj2GWJ3IbwMQIgOuirSmwnOvRxB
         v5bOkleRtEaEXwwg58dcHaI077/dzgK6aoF+WLHtXZyC2fX75L3L8kXLSh3OEHjSPs6Q
         7V0L+bjVwQQtDY7q+V42pG8mqQCgXApGVU9NEnfhZFWwqsAz6d4GLX4JTWFBVK+zwiKe
         FL7BN0D96VirtotnNIH6mqTUv4Z8fC4xRg2axVp2y/s+nC7ENlijnTd5GIcDnDKc03vI
         IuOg==
X-Forwarded-Encrypted: i=1; AJvYcCWnHuVZaym7kgYaibHYneY/cMgpBTrpC0gpFuZAwdcIPx26ZNQrA6XdlzVKHvyanrwIfRiu9JZyXSdMslJj9yzk/O0ic1o=
X-Gm-Message-State: AOJu0Yx9oct+j18yStVY05ZT1kqV+p8aMnIirJUe0zsHVVChhI1UACl0
	mcUFispFx439YoOldMZ4jF6pAY2x/z7ZGiScsdJ/3rtxF5Y1jr3ObO8xjlqDp6s=
X-Google-Smtp-Source: AGHT+IEU+eIpDc2Ju4a+mv1XLikwT5bqPQaRg8dc1emWU84CDhhamjYTFdJzbYGUUQwAPo6k+NQAmg==
X-Received: by 2002:a05:622a:15d0:b0:440:b388:97b4 with SMTP id d75a77b69052e-4413ab8f4b6mr5994771cf.12.1718041450207;
        Mon, 10 Jun 2024 10:44:10 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038b37f9fsm38713531cf.65.2024.06.10.10.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:44:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sGj3v-00Eskm-Pk;
	Mon, 10 Jun 2024 14:44:07 -0300
Date: Mon, 10 Jun 2024 14:44:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH 1/2] iommu: Take group lock before attaching device in
 iommu_deferred_attach()
Message-ID: <20240610174407.GL791043@ziepe.ca>
References: <20240528163940.48789-1-vasant.hegde@amd.com>
 <aaf7b619-1826-4db2-aaa6-235a25f46299@arm.com>
 <029a1733-4e7e-4deb-92d2-874040679bd2@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029a1733-4e7e-4deb-92d2-874040679bd2@amd.com>

On Wed, May 29, 2024 at 12:54:14PM +0530, Vasant Hegde wrote:
> Hi Robin,
> 
> 
> On 5/28/2024 11:36 PM, Robin Murphy wrote:
> > On 2024-05-28 5:39 pm, Vasant Hegde wrote:
> >> Commit 3ab657291638 ("iommu: use the __iommu_attach_device() directly for
> >> deferred attach")
> >> replaced iommu_attach_device() call with __iommu_attach_device(). But
> >> missed to take group lock. Take lock before attaching device to domain.
> > 
> > Why? Nothing here is even touching the group. If we've reached a deferred attach
> > then we know the domain is the default domain already initialised and set as the
> > current of the device's group, and the device is already otherwise added and
> > holding a reference to that group, and a driver is bound to the device in order
> > to make the DMA API call we're inside, so nothing should be at risk of
> > disappearing under our feet. Please clarify what purpose this locking actually
> > serves.
> 
> I am sorry. I should have written better description. I was trying to see if its
> safe to use  iommu_group_mutex_assert() in our driver. 

The core code guarentees that the dev will not have racing
attach_dev() ops, and we added the iommu_group_mutex_assert() as a way
for drivers to document they are making use of that assumption.

I'm guessing the purpose of this patch is to allow the AMD driver to
use iommu_group_mutex_assert() as it will fail in the deferred attach
path.

> > But then there's also the fact that the initial DMA mapping operation which
> > triggers deferred attach could legitimately be called under a spinlock or in an
> > IRQ handler, so if anything it was a bug in 795bbbb9b6f8 ("iommu/dma-iommu:
> > Handle deferred devices") to ever use iommu_attach_device() (and thus involve
> > the mutex) in the first place :/

ops->attach_dev() must be called in a sleepable context, even
the Intel driver will hit a GFP_KERNEL allocation in its attach_dev()
op. It seems to be an issue in 795bbbb9b6f8 that it did not consider
this.

I suppose in practice kdump using drivers are setting up DMA during
their probe functions and don't get into this problem.

IMHO adding the mutex here is an appropriate thing, it should not be
closing any race, but it is the right locking documentation to make
iommu_group_mutex_assert() work.

Jason
