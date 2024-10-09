Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A50190462;
	Wed,  9 Oct 2024 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480886; cv=none; b=EcaAcIJROihmQPJK+4FGHuM+3ElyhPL9CJESrAP1/QYeadVANgQh8sk94sYBQzSlvatd3NQ+5crNCQLKjlZFnafdWlpzCVpllVEAby0F5rq9A/lDt9NrvnX4vefsyb0NHjbyxzTsr73o8LNJVWaao8hBejCpUS6OQmfcUm1FhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480886; c=relaxed/simple;
	bh=e0gqHlZkDT5WvXlJLxiiH51AUvpJH6OopoCW36UMFTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMoqq1TTZ8r2UKuWiDDWQ3nNiEVaP2gOONB9g2hzsgKRVUYUWmLFQxQIVTTsJ6NT2s1VP8Zd7IZY5Xl7PvqS0Yk8Umxe9jGZIEfUB+Yt5EhU3vjbImtmJSZC9QMK6Tvz529A5p406b1DyqPs5UAPVgigkOPSK+yGxtH7cEvkkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3neOl0y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3neOl0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A983C4CED6;
	Wed,  9 Oct 2024 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728480886;
	bh=e0gqHlZkDT5WvXlJLxiiH51AUvpJH6OopoCW36UMFTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U3neOl0ybb4Ab65jgWhp3xT7HcEy4YMuUgGV+fe0qorbYgOtJiVf4vdBC8aSbF+zk
	 VaSzmlKJr1Td+ZlEfUnqPwPvP3ItSIxZE3mhiSqTU0Y+ILn1z2LAcj5l0mNd964u9E
	 IJiiL6vn/nZ84NJqFn6bT+eDEGpN/zUWDJjiTS1Nw44OfqVQU1G+/BklpTTM5qjnQt
	 qFWcWXBTn592t1uwoUFl7fAOhoRDLvjep0N3/TGk+zJy9Qodx9ZM9pOn4mlQ+m1tjB
	 +zz3ljVHlk8StJ6aovxl3cW8GcQDcp3o2MYDG6IpoR0lwS4CMa0F2Pi7cYkeI0mOAq
	 BM9t8zEhFY8Sg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e7ff3c8bbcso751457eaf.0;
        Wed, 09 Oct 2024 06:34:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjAuIzth9STp94B5NN5SSdHbg3iXJHeOQgVy8H6sSWhxv9xjehryH6vorS4+Vu2qwgD1MYH2A=@lists.linux.dev, AJvYcCVIVLG27VoVwlRRlw92tUDMVBqHja9mZ97B8rGAgPG0tpba2LyVQG8/jNaKfJEtTNOuRaPy@lists.linux.dev, AJvYcCVrkpaUmYT34x90lXaEYIP730pdZoa/phwGl/gKMXgjJiGrB01G5GwGqlDVveqXuxJ054fP7HPypS414mJjKw==@lists.linux.dev, AJvYcCVuUgU6oQpeVqhZzpLqw2PgoVrQvAZvAp29PKTZEb0XtBzsWt5BKBdeT5R9F9y73WYkw3eQfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YybdBzRQmfTfmAHHxNnhJZAH/9UXKGkBgMm7bKSms3Ph7WQ4hAZ
	o3Ru6u9QeKOseoZBFhigv4RGIjd4lOHAsUzhBE5dPep7t99k3oVdH/kfiyCAyp+1faTaEsPtp8L
	G5/lPmhMgAbGHUeV/woBx41cJE5M=
X-Google-Smtp-Source: AGHT+IGPvjQmX3zbZk+/LQ5kxG4XslEJ8m7y5iETpKVOpmsBmOdZ4tET2kRXnqT/piSrFy5yYrBa2CfwSNatwWXgz3s=
X-Received: by 2002:a05:6820:270f:b0:5e5:c489:6f3c with SMTP id
 006d021491bc7-5e987bc9df9mr1249377eaf.5.1728480885551; Wed, 09 Oct 2024
 06:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <CAPDyKFp0N6UJhnHS164Tdf=xkWB0jzq65L9TdvYazeBQ-6WjeQ@mail.gmail.com>
 <20241007184924.GH14766@pendragon.ideasonboard.com> <CAPDyKFpQVnF7eQv3dup8k-3EijnMjuveCG9sZ=Rpey1Y6MBJEg@mail.gmail.com>
 <20241007222502.GG30699@pendragon.ideasonboard.com> <CAPDyKFrGNwna6Y2pqSRaBbRYHKRaD2ayqQHLtoqLPOu9Et7qTg@mail.gmail.com>
 <CAJZ5v0jvJyS7D5-wURi2kyWN-rmNa+YqupeQJ000pQRVd9VBcQ@mail.gmail.com> <41a0ad69-912b-4eb3-84f7-fb385433c056@opensource.cirrus.com>
In-Reply-To: <41a0ad69-912b-4eb3-84f7-fb385433c056@opensource.cirrus.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Oct 2024 15:34:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gbrhMpPT0fHYSC+ES5WS5kv7XkM2hj9M4vpNwFFs6xsQ@mail.gmail.com>
Message-ID: <CAJZ5v0gbrhMpPT0fHYSC+ES5WS5kv7XkM2hj9M4vpNwFFs6xsQ@mail.gmail.com>
Subject: Re: [PATCH 00/51] treewide: Switch to __pm_runtime_put_autosuspend()
To: Richard Fitzgerald <rf@opensource.cirrus.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, 
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
	asahi@lists.linux.dev, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:48=E2=80=AFPM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 08/10/2024 7:24 pm, Rafael J. Wysocki wrote:
> > On Tue, Oct 8, 2024 at 12:35=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> >>
> >> On Tue, 8 Oct 2024 at 00:25, Laurent Pinchart
> >> <laurent.pinchart@ideasonboard.com> wrote:
> >>>
> >>> Hi Ulf,
> >>>
> >>> On Tue, Oct 08, 2024 at 12:08:24AM +0200, Ulf Hansson wrote:
> >>>> On Mon, 7 Oct 2024 at 20:49, Laurent Pinchart wrote:
> >>>>> On Fri, Oct 04, 2024 at 04:38:36PM +0200, Ulf Hansson wrote:
> >>>>>> On Fri, 4 Oct 2024 at 11:41, Sakari Ailus wrote:
> >>>>>>>
> >>>>>>> Hello everyone,
> >>>>>>>
> >>>>>>> This set will switch the users of pm_runtime_put_autosuspend() to
> >>>>>>> __pm_runtime_put_autosuspend() while the former will soon be re-p=
urposed
> >>>>>>> to include a call to pm_runtime_mark_last_busy(). The two are alm=
ost
> >>>>>>> always used together, apart from bugs which are likely common. Go=
ing
> >>>>>>> forward, most new users should be using pm_runtime_put_autosuspen=
d().
> >>>>>>>
> >>>>>>> Once this conversion is done and pm_runtime_put_autosuspend() re-=
purposed,
> >>>>>>> I'll post another set to merge the calls to __pm_runtime_put_auto=
suspend()
> >>>>>>> and pm_runtime_mark_last_busy().
> >>>>>>
> >>>>>> That sounds like it could cause a lot of churns.
> >>>>>>
> >>>>>> Why not add a new helper function that does the
> >>>>>> pm_runtime_put_autosuspend() and the pm_runtime_mark_last_busy()
> >>>>>> things? Then we can start moving users over to this new interface,
> >>>>>> rather than having this intermediate step?
> >>>>>
> >>>>> I think the API would be nicer if we used the shortest and simplest
> >>>>> function names for the most common use cases. Following
> >>>>> pm_runtime_put_autosuspend() with pm_runtime_mark_last_busy() is th=
at
> >>>>> most common use case. That's why I like Sakari's approach of repurp=
osing
> >>>>> pm_runtime_put_autosuspend(), and introducing
> >>>>> __pm_runtime_put_autosuspend() for the odd cases where
> >>>>> pm_runtime_mark_last_busy() shouldn't be called.
> >>>>
> >>>> Okay, so the reason for this approach is because we couldn't find a
> >>>> short and descriptive name that could be used in favor of
> >>>> pm_runtime_put_autosuspend(). Let me throw some ideas at it and mayb=
e
> >>>> you like it - or not. :-)
> >>>
> >>> I like the idea at least :-)
> >>>
> >>>> I don't know what options you guys discussed, but to me the entire
> >>>> "autosuspend"-suffix isn't really that necessary in my opinion. Ther=
e
> >>>> are more ways than calling pm_runtime_put_autosuspend() that trigger=
s
> >>>> us to use the RPM_AUTO flag for rpm_suspend(). For example, just
> >>>> calling pm_runtime_put() has the similar effect.
> >>>
> >>> To be honest, I'm lost there. pm_runtime_put() calls
> >>> __pm_runtime_idle(RPM_GET_PUT | RPM_ASYNC), while
> >>> pm_runtime_put_autosuspend() calls __pm_runtime_suspend(RPM_GET_PUT |
> >>> RPM_ASYNC | RPM_AUTO).
> >>
> >> __pm_runtime_idle() ends up calling rpm_idle(), which may call
> >> rpm_suspend() - if it succeeds to idle the device. In that case, it
> >> tags on the RPM_AUTO flag in the call to rpm_suspend(). Quite similar
> >> to what is happening when calling pm_runtime_put_autosuspend().
> >
> > Right.
> >
> > For almost everybody, except for a small bunch of drivers that
> > actually have a .runtime_idle() callback, pm_runtime_put() is
> > literally equivalent to pm_runtime_put_autosuspend().
> >
> > So really the question is why anyone who doesn't provide a
> > .runtime_idle() callback bothers with using this special
> > pm_runtime_put_autosuspend() thing,
>
> Because they are following the documentation? It says:
>
> "Drivers should call pm_runtime_mark_last_busy() to update this field
> after carrying out I/O, typically just before calling
> pm_runtime_put_autosuspend()."
>
> and
>
> "In order to use autosuspend, subsystems or drivers must call
> pm_runtime_use_autosuspend() (...), and thereafter they should use the
> various `*_autosuspend()` helper functions instead of the non#
> autosuspend counterparts"
>
> So the documentation says I should be using pm_runtime_put_autosuspend()
> instead of pm_runtime_put().
>
> Seems unfair to criticise people for following the documentation.

I'm not criticising anyone, just wondering why they do what they do.

"Because it is documented this way" is a fair answer, but it doesn't
invalidate the observation that the difference between
pm_runtime_put_autosuspend() and pm_runtime_put() boils down to the
cases when the .runtime_idle() callback is present (which are few and
far between so to speak).  Moreover, there are call sites using
pm_runtime_*() functions even though they may not know whether or not
autosuspend is enabled for the target devices, so the advice given in
the documentation cannot be universally followed regardless.

This thread is about the way to go, generally speaking, and what I'm
saying is effectively that replacing pm_runtime_put_autosuspend() with
pm_runtime_put() almost everywhere (if not just everywhere) would be
fine with me.

I also think that the current users of pm_runtime_put_autosuspend()
that is not immediately preceded by pm_runtime_mark_last_busy() can be
readily switched over to using pm_runtime_put() instead of it and then
pm_runtime_put_autosuspend() can be made call
pm_runtime_mark_last_busy(), so the latter can be removed from the
code using the former.  Note that this last step does not require
tree-wide changes, because calling pm_runtime_mark_last_busy() twice
in a row for the same device is not a problem.

Of course, the documentation needs to be updated in accordance with
the code changes, which didn't happen when previous changes were made
to pm_runtime_put() and that likely is why it does not reflect the
current code.
