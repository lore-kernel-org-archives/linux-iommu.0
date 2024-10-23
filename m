Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4341E51D
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702121; cv=none; b=fEL+i7ikGauj3rBwVLIdFZF5mTdubRa2BrBnSDIq+O7uwpSf5vWEtX4aEbZBP3F2KMIsJh9vO+9etNnrfE3cXZKWThZqwSwt+bX7vvqTO33qtfKKqhOxOacjlR9jRiLCfx+k68Ux+sDu3KzPop9HkSfLMnAhINvGXZS4ES4AwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702121; c=relaxed/simple;
	bh=iy3H7Y8wiH+9W2VzDb6agrLlBF3HQPtyn601x1v6ENU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8pG9tzhBqENqj2GkFbhzCX34tW8X3tD3rMtsdqU+2fMu2ZpsZQfJDmNvDJgXQleDMuv4Vx9zCR/G17v7swlX2OHq3reYVcXdYQcW6stPW97BDGff3haxfd4QwYbtFOsup60fQpCifzIOiirOW8eTd9hBQ7Xwo9ldiHOxCO1Afo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+ZUYXE0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+ZUYXE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909A0C4CEC6;
	Wed, 23 Oct 2024 16:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729702121;
	bh=iy3H7Y8wiH+9W2VzDb6agrLlBF3HQPtyn601x1v6ENU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+ZUYXE0fYPevqho+CIKbcmZtnPZ5hTZsTs5XEjG6K3sZTrhQG8V6a+KGyeQ4BKbS
	 aBrgoXumVBwB5kFn5743hjxONFfrgNhKOG8zOvWzbrBU/Qxj6gChxqTn4A9N+96JTd
	 WAr/2ZJkQF8YuFM9sI51LNL/5SzY66Q10qvw293+xuD014TlR7rhdRm1Z2DPlJ2CGX
	 0QA84jUgazRzp/c02v3Gc2QAYG754C5mNKpJMjI/Q4mZsuuhqQPnd/ZXEeRhpBtUpp
	 Rna07CAUAmFXIzD97ePjlud8ArPs7X14q65KHf7QI42w3ZUx461TodATgO6s01hivT
	 kFKUW6LzFnUFQ==
Date: Wed, 23 Oct 2024 17:48:36 +0100
From: Will Deacon <will@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Rob Clark <robdclark@chromium.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH 22/51] iommu/arm-smmu: Switch to
 __pm_runtime_put_autosuspend()
Message-ID: <20241023164835.GF29251@willie-the-truck>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <20241004094123.113725-1-sakari.ailus@linux.intel.com>
 <ZwfztwoGAcvyvlWL@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwfztwoGAcvyvlWL@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 10, 2024 at 03:33:11PM +0000, Pranjal Shrivastava wrote:
> On Fri, Oct 04, 2024 at 12:41:23PM +0300, Sakari Ailus wrote:
> > pm_runtime_put_autosuspend() will soon be changed to include a call to
> > pm_runtime_mark_last_busy(). This patch switches the current users to
> > __pm_runtime_put_autosuspend() which will continue to have the
> > functionality of old pm_runtime_put_autosuspend().
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index 8321962b3714..cad02d5dc6d2 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -79,7 +79,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> >  static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> >  {
> >  	if (pm_runtime_enabled(smmu->dev))
> > -		pm_runtime_put_autosuspend(smmu->dev);
> > +		__pm_runtime_put_autosuspend(smmu->dev);
> >  }
> 
> Seems like a straightforward change as a result of [1].
> Although, I had a few things to discuss:
> 
> 1. The `rpm_resume` in drivers/base/power/runtime.c seems to call
> `pm_runtime_mark_last_busy` in case the ->runtime_resume callback
> returned successfully. In such a case, why would we want to move
> `pm_runtime_mark_last_busy` within `pm_runtime_put_autosuspend` ?
> 
> 2. In the arm-smmu driver, we seem to rely on the rpm_resume to call
> `pm_runtime_mark_last_busy` as a part of the ->runtime_resume callback.
> The only other case, where we might wanna `*mark_last_busy` is if we
> want the autosuspend timer to be re-started in case of a failed suspend.
> However, the `arm_smmu_runtime_suspend` doesn't return errno in any case
> hence, I don't see any other case where we'd benefit from using
> `mark_last_busy` in the arm-smmu driver. 
> 
> On the other hand, I don't see a problem with using it either :)
> Any thoughts Will/Rob/Robin?

To be honest, I think the current driver code is pretty weird. We're
calling arm_smmu_rpm_use_autosuspend() during device attach and that
does:

	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
	pm_runtime_use_autosuspend(smmu->dev);

whereas I would've expected these autosuspend parameters to be configured
once during SMMU probe and then for attach to do something like:

	pm_runtime_mark_last_busy();
	__pm_runtime_put_autosuspend();

So I think we should probably rework the code we have slightly, which
will hopefully make this giant refactoring series a little more
straightforward.

Will
