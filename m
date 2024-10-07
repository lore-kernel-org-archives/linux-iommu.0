Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383D18C92B
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338944; cv=none; b=GcX3sQb0/BDxuqFCSTURx8KCB29TRoqCTz3UT++dPDmTrej2FN/fRrMw2ANOk0ijlI/iIUioDQ35jFTFA0/GRbsIr1dka9McUJMJpS2w8cTA2vbX6F8attUA3ocl2DAhVsgCDCSUggdmDQgmWq+oN22kp/bu1hUB7Ad6LxyvXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338944; c=relaxed/simple;
	bh=CqX9Y0dEmHgiIN61I3/zW08Bfod5n7pFQiGUVIMbBVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3pVDBddEVysFlv9O4sTeul2Rdh5UWwkfPG4D5SmgwemQbdNrURA8RxQoHbYyOh2FeauYZdeOHNgOrK99NFgLikfjD7RleeKz0Lt4WzzfIYl5/BOTGITx7zbzHAsiwbSQlwDj+dvGhxPWAKDYbLCF2BRW0zbdw8N50Z6lumUdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cW0Pl5Yo; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cW0Pl5Yo"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e25d11cc9f0so4024396276.3
        for <iommu@lists.linux.dev>; Mon, 07 Oct 2024 15:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728338941; x=1728943741; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CqX9Y0dEmHgiIN61I3/zW08Bfod5n7pFQiGUVIMbBVk=;
        b=cW0Pl5YotoWq4o6P3Oc7c5nafP9DMamGwR2drrNamSkJcjGNvzAq8I1KnJ5H+1E6jB
         vwW/gfXUSYtHvfSR0uYKHqVnyHXMOoCZg5W3efrfIgd08hdihZAxSZ7XQFU8t6r6eChM
         VPNXq8b+SB9qJvZiCy/ZNOxU+E4OX6e6PuQoO95PPMQfIozgSxgRjOe/LwxqvaPAmemN
         uER0Z19m2H/fLNfGJCICvZfvxFujXQ5VOsTFef8mjto9TYUjtrlXCgvc0NPEkHXC7VuS
         227XUMDHRid1/KyH7Y9Tdfz2Z9TSMhcGWCO9Ar3mm4sgxkQ8iMl1m2gG6DxnKw+zTACq
         yXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728338941; x=1728943741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqX9Y0dEmHgiIN61I3/zW08Bfod5n7pFQiGUVIMbBVk=;
        b=oIT7iUWx44uBRSmbOo9BfY++bSyJil33UqxG4jVHswQ2WuC+9dE4JQPVqppYRGFWba
         HiXMRztBH66aeh05p1ePK/t/UoJa+Ty6gvYD6i1tee8ppSDuGVugfCPRSrIPrZ8z0YcJ
         nM8NuzFZ3NjsHi2qoL3niAW8uyABxJxOXiStEFDBiUDtntH1HCmPzy+aAr0taf3wN3XH
         5+lDVIwKtV0w7m/AX2Pc3hx54nVU5KYjRLWWc030n4QFt3ywTcUfzThGC1NOmGRveVvH
         wJYkxgjIt6AnZDwg/7z+1FfTIvh/iKYsKW1BGyHBWmHgY3Qrld9ZrsI6LqmHJufZ4cse
         EQSg==
X-Forwarded-Encrypted: i=1; AJvYcCXZfl8oZsb8C/4Ibm4K0K/zyyXyLhCmOTn1KX5ucI1WrNrYMnJ0DRVHkXMYgqjYJXLAGRYS+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YypyGLTSRE76AMJnfmnw26j+X0ZCN3rxyY2tCdVJDSHXNU03mN6
	38lbJCIMdz+/JJRryfC9yBOEK0POXyxt554FqYlpXfzqxm/YqHU28DL2EQw+XGU8vPL46rdGc3V
	oabBjd9Jso5WDpJZDijxAVkL6ptSgkrNfUrEyuQ==
X-Google-Smtp-Source: AGHT+IE2nJVabbXdwibt1H0pVBms5dYTsG8RkBKKAzfdsgMhYsZ8VyWIk7HanuWHiQPQxXFBk2ezA08qlljJFN0QQR4=
X-Received: by 2002:a05:6902:848:b0:e28:edbd:765f with SMTP id
 3f1490d57ef6-e28edbd7f75mr206026276.2.1728338940867; Mon, 07 Oct 2024
 15:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <CAPDyKFp0N6UJhnHS164Tdf=xkWB0jzq65L9TdvYazeBQ-6WjeQ@mail.gmail.com> <20241007184924.GH14766@pendragon.ideasonboard.com>
In-Reply-To: <20241007184924.GH14766@pendragon.ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 00:08:24 +0200
Message-ID: <CAPDyKFpQVnF7eQv3dup8k-3EijnMjuveCG9sZ=Rpey1Y6MBJEg@mail.gmail.com>
Subject: Re: [PATCH 00/51] treewide: Switch to __pm_runtime_put_autosuspend()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, patches@opensource.cirrus.com, 
	iommu@lists.linux.dev, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org, 
	asahi@lists.linux.dev, rafael@kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 20:49, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ulf,
>
> On Fri, Oct 04, 2024 at 04:38:36PM +0200, Ulf Hansson wrote:
> > On Fri, 4 Oct 2024 at 11:41, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hello everyone,
> > >
> > > This set will switch the users of pm_runtime_put_autosuspend() to
> > > __pm_runtime_put_autosuspend() while the former will soon be re-purposed
> > > to include a call to pm_runtime_mark_last_busy(). The two are almost
> > > always used together, apart from bugs which are likely common. Going
> > > forward, most new users should be using pm_runtime_put_autosuspend().
> > >
> > > Once this conversion is done and pm_runtime_put_autosuspend() re-purposed,
> > > I'll post another set to merge the calls to __pm_runtime_put_autosuspend()
> > > and pm_runtime_mark_last_busy().
> >
> > That sounds like it could cause a lot of churns.
> >
> > Why not add a new helper function that does the
> > pm_runtime_put_autosuspend() and the pm_runtime_mark_last_busy()
> > things? Then we can start moving users over to this new interface,
> > rather than having this intermediate step?
>
> I think the API would be nicer if we used the shortest and simplest
> function names for the most common use cases. Following
> pm_runtime_put_autosuspend() with pm_runtime_mark_last_busy() is that
> most common use case. That's why I like Sakari's approach of repurposing
> pm_runtime_put_autosuspend(), and introducing
> __pm_runtime_put_autosuspend() for the odd cases where
> pm_runtime_mark_last_busy() shouldn't be called.

Okay, so the reason for this approach is because we couldn't find a
short and descriptive name that could be used in favor of
pm_runtime_put_autosuspend(). Let me throw some ideas at it and maybe
you like it - or not. :-)

I don't know what options you guys discussed, but to me the entire
"autosuspend"-suffix isn't really that necessary in my opinion. There
are more ways than calling pm_runtime_put_autosuspend() that triggers
us to use the RPM_AUTO flag for rpm_suspend(). For example, just
calling pm_runtime_put() has the similar effect.

Moreover, it's similar for pm_runtime_mark_last_busy(), it's called
during rpm_resume() too, for example. So why bother about having
"mark_last_busy" in the new name too.

That said, my suggestion is simply "pm_runtime_put_suspend".

If you don't like it, I will certainly not object to your current
approach, even if I think it leads to unnecessary churns.

[...]

Kind regards
Uffe
