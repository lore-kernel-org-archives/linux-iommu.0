Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE634B662;
	Wed, 21 Jan 2026 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994354; cv=none; b=fcmBfZccyCR+nme2UYWsWuA4yrl9SRe3qsSWk+HGITV9p7flnx0IYEW9CQF4T4bod1NtUsvJf+CHiqc/eTGEB69LUxLvThxt6ctRRPHWZjQZ9J8t67KpXF7QyjuPGAc18D6IPx/o7+Kq0jRer+CX/QsmMU4b+okYWJQyxw+DkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994354; c=relaxed/simple;
	bh=hWrI1DP0RUDS27j82ybiJC6dSErOe9ILfvmcIn/CEIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT/QUa9Doqr9iGro2Mj3hVj0lyClVZXDHog1ma0Dzc4Z1T+rx7tObeOE+JCtqOD5Cj8U9Z6C8AspEWsIO4lJEv7y1bn5MeVzIZ4HrRgvokR7ce4mGxCuBSIWxSX4P/juuC16DF3r865+zLvOZF5+yVgBY/wtMa+7PLpr9kX5Agc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aYqwuRkZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aYqwuRkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FFFC116D0;
	Wed, 21 Jan 2026 11:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768994353;
	bh=hWrI1DP0RUDS27j82ybiJC6dSErOe9ILfvmcIn/CEIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYqwuRkZ7d9J9WRPz5abrCKiuEf177Ofy9SDA3FMVjt2S/eXIhTlSR9Xs+7/Lf4eW
	 958ZpZ3RB1eKpyiEMMH+E3jOFspyRbKZmaB48WPHT4Gtdzp9qsS3ru/dSctLJchy64
	 69CqmeS7cPWYrz3dEVFr7oJLgXiBgOhsBMQw/IxQ=
Date: Wed, 21 Jan 2026 12:19:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Wang Jiayue <akaieurus@gmail.com>, hanguidong02@gmail.com,
	rafael@kernel.org, Aishwarya.TCV@arm.com, broonie@kernel.org,
	chenqiuji666@gmail.com, linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com, robin.clark@oss.qualcomm.com,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v5] driver core: enforce device_lock for
 driver_match_device()
Message-ID: <2026012126-coke-lash-dd99@gregkh>
References: <CALbr=LYt-MqGM0ua78Rt7M679WR9hNnk0Or-WrB2myZ=KhaN0w@mail.gmail.com>
 <20260121085549.165428-1-akaieurus@gmail.com>
 <DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org>
 <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org>

On Wed, Jan 21, 2026 at 12:02:15PM +0100, Danilo Krummrich wrote:
> On Wed Jan 21, 2026 at 11:40 AM CET, Danilo Krummrich wrote:
> > So, the problem is that in the callstack of the arm-smmu driver's (a platform
> > driver) probe() function, the QCOM specific code (through arm_smmu_impl_init())
> > registers another platform driver. Since we are still in probe() of arm-smmu the
> > call to platform_driver_register() happens with the device lock of the arm-smmu
> > platform device held.
> >
> > platform_driver_register() eventually results in driver_attach() which iterates
> > over all the devices of a bus. Since the device we are probing and the driver we
> > are registering are for the same bus (i.e. the platform bus) it can now happen
> > that by chance that we also match the exact same device that is currently probed
> > again. And since we take the device lock for matching now, we actually take the
> > same lock twice.
> >
> > Now, we could avoid this by not matching bound devices, but we check this
> > through dev->driver while holding the device lock, so that doesn't help.
> >
> > But on the other hand, I don't see any reason why a driver would call
> > platform_driver_register() from probe() in the first place. I think drivers
> > should not do that and instead just register the driver through a normal
> > initcall.
> >
> > (If, however, it turns out that registering drivers from probe() is something we
> > really need for some reason, it is probably best to drop the patch and don't
> > make any guarantees about whether match() is called with the device lock held or
> > not.
> >
> > Consequently, driver_override must be protected with a separate lock (which
> > would be the cleaner solution in any case).)
> 
> I assume that this should resolve the problem (unless there are more drivers
> that register drivers in probe()):
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 573085349df3..9bb793efc35f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -774,10 +774,6 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>  {
>         const struct device_node *np = smmu->dev->of_node;
>         const struct of_device_id *match;
> -       static u8 tbu_registered;
> -
> -       if (!tbu_registered++)
> -               platform_driver_register(&qcom_smmu_tbu_driver);

Ick, yeah, that should not be happening.  We should deadlock on that no
matter what.

> 
>  #ifdef CONFIG_ACPI
>         if (np == NULL) {
> @@ -802,3 +798,5 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
> 
>         return smmu;
>  }
> +
> +builtin_platform_driver(qcom_smmu_tbu_driver);

change makes sense to me.

thanks,

greg k-h
