Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D802E7185
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879585; cv=none; b=FpuJ+NuinYcaBk3qJw14UbgyK5xqv+YE5K5pkDODCfl3JHe86uEilUXbs7fpKzuDstKkvfd0n/LKFT0/mZ59GvAwTCrZLETTYzHDUS3+1ZbyTEDZR/JLpTFTnCzxMarSve9ncuIAG4MxQniW1He3Xbh6h5NPgLQGjBKvxFv+/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879585; c=relaxed/simple;
	bh=pmkq2/Yjx493jWyFm9VY9aWkNpSU+yTuvMXC8BtlmPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQqVgZcpoLh0N3sGaHtqdqE1Hgk+JaL9JrI8S2+hzM90LSF2omy4a7CDruKURosSFMR+6L84w54cF8ZkOchJs1I7jCKAxem4a2798z14VX8rmCWPR6yLnzZSq0zPlg46JzEAzm2pO9727wbGXaLY7yIcAd5Jcy2VfI10dagmcy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL2s667C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL2s667C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E30E1F00898
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790879584;
	bh=fiwCd0p4aCZ5b37Gh6dfd7FU6o39KITfrw7vCvmWWKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cL2s667CiszUsk/C++Yl0msi5Rkwtm5mQ8+QGpEqf4ltZlEMFMl8j030BG28rdMJ4
	 auJ+/4sLY0lNJ7KBLRQX7IiT2i6c2G1mXVvW5iyeTZ1hqz8VuvQYJsM7yMjpgXarEd
	 +pOVKCU0rF6N+MEwo9OMnGQzqmuZAD3CS7r6BgJMsWGIw6EYKu64uJ/Rru1kd9YdFm
	 Uyj6TueBNFLCv0Rv8pUnn2BnVdX3KZDIDamUIfhSBobIP6uIRA5aGelSjM1IjCAl3F
	 PghATtoBaMfypCSAoKOEdxx9Q0dQnnx3S6HpEqZJ8+y92PFN6MGQ1AAluISt8VKNUJ
	 0KDWORQmrcVZw==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba379d8804so2963017e87.3
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 11:33:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzjxHU4Uk88GkrrPWXe0o7C/W4dybtyv6JQwFzS3e89Q36ZgONC1+bYtcLXI3whwcj+A3R4JQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKPm2F/FNH2eV5/cFXyy9+sjorNkNkfZRDlectB4hc7G79CsHcB
	nheEeO1B0uXRlT5mseyo2owaSp4v7GR9+hrYSYAmcTb1WiZSfbf0mIc0Da0zcKDKRqn+AygkXRJ
	r/6IdQd7uGX0xffNypCm5Kkb9jElk5sk=
X-Received: by 2002:a05:6512:ba5:b0:5b6:1a7c:aa1f with SMTP id
 2adb3069b0e04-5bb9bc3a37emr19121e87.55.1790879582937; Thu, 01 Oct 2026
 11:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <4766532.LvFx2qVVIh@rafael.j.wysocki> <ar6k1MMzNDTbdLvO@ashevche-desk.local>
In-Reply-To: <ar6k1MMzNDTbdLvO@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 1 Oct 2026 20:31:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iFtFMZSX4Cjaimh+9Ts2WHpPKuvB3ZpUoNY+2fXSnstA@mail.gmail.com>
X-Gm-Features: AclHuK8Htf1GRa2AjqjWVVR1Npiv1s0P0ru6iaKF_BXvR2_zIwXL67JNkM9Oy6c
Message-ID: <CAJZ5v0iFtFMZSX4Cjaimh+9Ts2WHpPKuvB3ZpUoNY+2fXSnstA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ACPI: Replace acpi_get_first_physical_node() with acpi_bus_get_primary_device()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, 
	Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
	Sen Wang <sen@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 8:22=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Sep 30, 2026 at 08:30:47PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This is a partial resend of
> >
> > https://lore.kernel.org/linux-acpi/7995179.EvYhyI6sBW@rafael.j.wysocki/
> >
> > that only includes patches that have not been ACKed and the last one th=
at
> > depends on all of the others.  It is based on linux-next.
> >
> > This series replaces acpi_get_first_physical_node(), which is inherentl=
y racy
> > and therefore generally unsafe to use, with acpi_bus_get_primary_device=
(), that
> > doesn't have this problem, everywhere in the code.
> >
> > I will appreciate ACKs from maintainers of the code updated by the patc=
hes, so
> > I can pick them up and get rid of the problematic interface in one go.
>
> The whole lot is straightforward,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Yes, it is, thank you!
