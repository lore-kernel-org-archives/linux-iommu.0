Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A01288CAF;
	Wed, 23 Apr 2025 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420906; cv=none; b=s4yTZa9cxF7sJ3R7CWf0fdtwsM+r9w5qPHiB1dUXvSgghxJuO3M0fZDM/tr7tFeYaOJ6a/cGtnaU0fmvpbfhxhbRoXrPRgleN9NS7xVAQXTFjL7v9/Skbum6aqC5z29cLE8yAR1bibQzPHOEcB0znjvljf2aUrGljWXDpBvcLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420906; c=relaxed/simple;
	bh=YC2qgnmmCkhuux3qHYJ3SWVnmxx4OSbWLFxwEpHWl5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jFje9Hl/OpyjFuWFjvA9IWASabQxNwefiQUwaWqX6x1piJ+2nWLPCyHk/Z3ewthPYumoUhxEiLYJqMZpvii9okShJ8gcQwvdsEyHr/qtfqtHLjL5QZrTFx8R1WB+yiZK28oQB93AVKx5gOmmBd1wV8MIo3gBRKtp/M3PkjdN+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dojNHCKV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dojNHCKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503B3C4CEE3;
	Wed, 23 Apr 2025 15:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745420905;
	bh=YC2qgnmmCkhuux3qHYJ3SWVnmxx4OSbWLFxwEpHWl5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dojNHCKV9SAysXUyhOXQcSdlbKFRWDQAbFKG2q14euhfJUoIaQ293q8VSpqlYvam3
	 fcVY77noSJwlPuDOLfLnoxXMR+95ShTfAm7HtcEajZWwdjbt+AHV4ct6rvwNweS2rO
	 tFl4Q0b9hrFAvP7iqOA26aIgFLt1ZsTjDWULjIKemKJ22pim3V2838Px8u6TSj3uFz
	 mQFWOILhu90F440Fx2JldGtBxD7SDPDOflqE1Lum+VBvBpw8ivotcNdLgd49XyPbqR
	 B+VCm7WZKalAzhq2B/2+5llP//KtUyvQh6H7Mes2Rh1i1KCvsCwp/AjdtZxHs8mjEE
	 nUDzBDsnqAwCw==
Date: Wed, 23 Apr 2025 10:08:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Will McVicker <willmcvicker@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform: Fix race condition during DMA configure at
 IOMMU probe time
Message-ID: <20250423150823.GA422889@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422232650.2737369-1-willmcvicker@google.com>

On Tue, Apr 22, 2025 at 04:26:49PM -0700, Will McVicker wrote:
> If devices are probed asynchronously, then there is a chance that during
> the IOMMU probe the driver is bound to the device in parallel. If this
> happens after getting the platform_driver pointer while in the function
> `platform_dma_configure()`, then the invalid `drv` pointer
> (drv==0xf...ffd8) will be de-referenced since `dev->driver != NULL`.

I need a little more hand-holding to make sense out of this.

After digging out
https://lore.kernel.org/all/aAa2Zx86yUfayPSG@google.com/, I see that
drv==0xf...ffd8 must be a result of applying to_platform_driver() to a
NULL pointer.  This patch still applies to_platform_driver(NULL), but
avoids using the result by testing drv for NULL later, which seems
prone to error.

I think this would all be clearer if we tested for the NULL pointer
explicitly before applying to_platform_driver().  I don't like setting
a pointer to an invalid value.  I think it's better if the pointer is
either valid or uninitialized because the compiler can help find uses
of uninitialized pointers.

> To avoid a kernel panic and eliminate the race condition, we should
> guard the usage of `dev->driver` by only reading it once at the
> beginning of the function.
> 
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  drivers/base/platform.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1813cfd0c4bd..b948c6e8e939 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1440,7 +1440,8 @@ static void platform_shutdown(struct device *_dev)
>  
>  static int platform_dma_configure(struct device *dev)
>  {
> -	struct platform_driver *drv = to_platform_driver(dev->driver);
> +	struct device_driver *drv = READ_ONCE(dev->driver);
> +	struct platform_driver *pdrv = to_platform_driver(drv);
>  	struct fwnode_handle *fwnode = dev_fwnode(dev);
>  	enum dev_dma_attr attr;
>  	int ret = 0;
> @@ -1451,8 +1452,8 @@ static int platform_dma_configure(struct device *dev)
>  		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
>  		ret = acpi_dma_configure(dev, attr);
>  	}
> -	/* @drv may not be valid when we're called from the IOMMU layer */
> -	if (ret || !dev->driver || drv->driver_managed_dma)
> +	/* @dev->driver may not be valid when we're called from the IOMMU layer */
> +	if (ret || !drv || pdrv->driver_managed_dma)
>  		return ret;
>  
>  	ret = iommu_device_use_default_domain(dev);
> -- 
> 2.49.0.805.g082f7c87e0-goog
> 
