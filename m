Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68C431487
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896442; cv=none; b=k0iIRqgtG7b1lrw41T0UBhQEg+rlCGoxfnu3un71kHmU0CIftSbwW9/R34KWED80Nn3jF+MBNPUVJ6ZHcNLhoC2hbRPmNBI9+SbL868DFtM2X1R6rsfioXrxjnWC/YlS8OlnoPwrkd+iNw3YxpTYfxZrCsK0XCZgQq8f24pKjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896442; c=relaxed/simple;
	bh=KvhnGf7O3qCD2gIeCzPFrLZG2dP0DjJjml99qmS3Bng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2S+KmY5Tp2Vni/Qg2zDZOupWz4RfLwZGlG/kemF/QiNByVC07wBrW+POne4B3lkYIxvO4ngdVF1ryRiUcbbyDrvoY/Rib9pJvLj71JOo891n5jFeM/QSQ8WeQ6NEGZPkSl1GC7tJ5wQ3uAT1HG5rs5ox+0CbghVclpvr8ozdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnEiopu3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnEiopu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3070A1F000E9;
	Fri, 24 Jul 2026 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784896436;
	bh=aOOtZPbnRRw5WhTRcVTlbWz0D8srzvHTjn1egAss8Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SnEiopu3phW14Bx4uL1qRNQsRAZOoK0+7oAoQb5Sh9Ly1Ruc5D+/ip4rYG39/OzTr
	 3CsK6ao5/+/jFVRpptMJNrOjLQmEguuP3zrbjfd+gqpsQIBcAv9HWnLvl/7goe4/Z2
	 jTtRysM31lvmmhqwMdqMWtGzx5bgyLfuH4v6NTqvS9MrlM8BAAES3pb3ftXC6bMukN
	 Y+axuEKUNMvfQVDdZl6nsMDo/zIbOFd4T9BISg8z5E38tvsWbEYFhN578PMmcpnoBR
	 cj8iKHwYtUTbP/fqCO9B0LmIgVk/RxDcPwHTeQtcudiXyTiCEuEMDzSm6GWTKTNJky
	 o02LbZK5RHqIQ==
Date: Fri, 24 Jul 2026 13:33:52 +0100
From: Will Deacon <will@kernel.org>
To: Xiong Weimin <xiongwm2026@163.com>
Cc: iommu@lists.linux.dev, robin.murphy@arm.com, joro@8bytes.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 0/2] iommu/virtio: Probe fixes for proper driver state
Message-ID: <amNbsGS9MNCENBBk@willie-the-truck>
References: <20260714025913.2042-1-xiongweimin@kylinos.cn>
 <6A62CEFD.2C7C40.17686@m16.mail.163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A62CEFD.2C7C40.17686@m16.mail.163.com>

On Fri, Jul 24, 2026 at 10:33:33AM +0800, Xiong Weimin wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> Subject: [PATCH v3 0/2] iommu/virtio: Probe fixes for proper driver state
> To: iommu@lists.linux.dev
> Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
> In-Reply-To: <20260714025913.2042-1-xiongweimin@kylinos.cn>
> References: <20260714025913.2042-1-xiongweimin@kylinos.cn>
> 
> This is v3 of the patch series. v2 is now obsolete.
> 
> Changes since v2:
> - Rebased onto latest upstream
> - Patch 3 ("Reject short event buffers") has been dropped as it was
>   independently submitted by Xu Rao
> - As suggested by Will Deacon, modified viommu_init_vqs() to take vdev
>   instead of viommu, since they are now linked via vdev->priv

Two more things here:

1. Please don't send patches as attachments. Go and read
   Documentation/process/submitting-patches.rst to understand how this
   it supposed to work.

2. You shouldn't add random Reviewed-by tags if they haven't been
   explicitly provided by the individual. For example:

> From fda59717330fd907f1cd3fdbba7e0b0888b54524 Mon Sep 17 00:00:00 2001
> From: xiongweimin <xiongweimin@kylinos.cn>
> Date: Thu, 23 Jul 2026 11:18:50 +0800
> Subject: [PATCH v3 1/2] iommu/virtio: Set driver data before enabling
>  virtqueues
> To: iommu@lists.linux.dev
> Cc: will@kernel.org,
>     robin.murphy@arm.com,
>     joro@8bytes.org
> 
> The event virtqueue callback retrieves the driver state through
> vq->vdev->priv. viommu_probe() currently initializes that pointer only
> after virtio_device_ready() and after the event queue is populated.
> 
> Store the driver data before creating the virtqueues so callbacks always
> see initialized driver state once the device is made ready. Clear the
> pointer again on probe failure.
> 
> As suggested by Will Deacon, pass vdev instead of viommu to
> viommu_init_vqs(), since we already linked them together.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> Reviewed-by: Will Deacon <will@kernel.org>

I did not provide this tag ^^^.

> From 3f94f2266bc35c31234b19c1e9acb847ff7e445c Mon Sep 17 00:00:00 2001
> From: xiongweimin <xiongweimin@kylinos.cn>
> Date: Thu, 23 Jul 2026 11:19:07 +0800
> Subject: [PATCH v3 2/2] iommu/virtio: Handle iommu_device_register() failures
> To: iommu@lists.linux.dev
> Cc: will@kernel.org,
>     robin.murphy@arm.com,
>     joro@8bytes.org
> 
> Check the return value of iommu_device_register() and properly clean up
> sysfs entries on failure. This ensures that the device sysfs directory
> is removed if registration fails.
> 
> Reviewed-by: Will Deacon <will@kernel.org>

^^^ or this one.

Will
