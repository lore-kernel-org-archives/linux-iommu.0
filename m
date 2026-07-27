Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF340A92F
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157187; cv=pass; b=RodE2mCH+nPK1B06zyNhORhOaz388gPasT44lwPOtaN+JNANSeeCq+u+8kN3wMNBONuUDmw7tcwtPjvyEA14f4N92KH1nRmFeH8yGyzkgmCnmR3sEvIKZvwSdoi1Fu6xlbftyfN8tWH7dQ7N1XFTUXc38KKEkxyeBzz39w1m4x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157187; c=relaxed/simple;
	bh=luUc9ZQFmCjynsr/029wplBmFfuONlqLQlNMir6ffmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJGhdhjnzBT4jotwlYa6iRYeP0FXFmD+YbGTBdkEzMszfzFWDpgOzp9GkROctnVWbhNGA7PIuRKcTIn8V4HRMm0MjsMMRRcq4yGb5B23mzSRsiF1tVimKc8Sn1HHnSxYR5qjkpQNcPERFiGgfM6rg0b0ulIpMkca64729tuuj+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SohbGuld; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SohbGuld"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80cebd41372so29046957b3.3
        for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 05:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785157182; cv=none;
        d=google.com; s=arc-20260327;
        b=m85V2Uheg1kSHxfrEGOEOreqLOabIhCgdhRb28Tq/p+LxGvCM7zKGLUqmYXojWxBQ3
         rZIajPJbR2P97s4YBqCKyjG90872defsjnsrP82YHKxuo5shwrJhHswA8SmyKisYahDn
         T9WuCxNDya+LRXITpd9dNd1MxbbAr/+4em25uY5SKO0PvPDvtG7oSjczQRdzqkWeNYwQ
         IR4Jol5V0+cpSEpuiH70uzxZ4B32BLayESUUv1LiT8Mvgi6BrGhF1wUXXs7W5nu+wWDx
         66hhObsixHNIqsu9S9bsx31TVuLHjzjrCnhOD4yzesnc6020JU8skglgOKAl035WZ7H2
         Lbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
        fh=bBYCeoKHzZphRj//OlJrQRP2DWDbcnf55wTe4HcpoHI=;
        b=Q8+gMopyeYuqm6OSnffFIaN6f+liM8kDV2ucDwdezocVUDk2MDdF+TTMZF4E3IIrAL
         Zjzp8Ov57LboJR01ikfjQi5TrfWvStFo0CHY9O5hseen4NpWjDX35im6BARdTnfINJgN
         foNZPTfR3SoWHHDsjzPkuf7Zo29OJYm186TYZkbJF8GP4JX/txi3RNqhFM43VXdJOLi7
         TPd26vvIs6+jDHNkP+VufRnyPtY0rA21TKnccDtfJFhOVdQVmMbxZ9LAiEVowGC6mhBM
         NNv+Q26dhizps5KUp2cTbRQWBaVN5IgD6z+ssFHooWMvnjATtGK0HgUyslbV/L2mcNMw
         LRBg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785157182; x=1785761982; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
        b=SohbGuldVOcIXS8S4RZUYg9FSVVYtv8qtE9QBL8gxG/B4YN0xypNZ/Lk95AnuoiY3Q
         mma0JfOBw1H5UslsIKM35ZT9L1nt7RKcrOZfeYAVGYc7RsJ1u6VTHumriOS2kyBHnom4
         5JUMz5mS+YAPcqJQ8FHxWKkbid7+Snr4c23NMU9GA9KpX3l+MhKi3JZzUTtrZ4UO9nqL
         aOtBz/e4Tm6u8EM4rW7F3ymbmvBGSG7Nj2uuI/og9Xt+GvWSq15Bk4WgYx6DYJWg47N7
         5HnUcjQ/fZ43MVy1OwfMtm9jO65p8TjLH9YVgl2rfI4Ufrjo+UnMO0pvykR/E4g6fYN7
         g2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157182; x=1785761982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
        b=FWO8Gc3IB9JzI5hqEuU85sv2SAa1pRWmggGe2XjgjNOnniCPTd89JUD7k6NCQrf1HW
         5Iu2NkevVlKrYzNmsl0ccGqV6OBL35hr6aR2hKswjaFamNFU9eoHtI6UJ0JCJ/uRQBbB
         NvQDNiGzKSDKHIWv3l/rgfUxJmwNpHw5OI9Nv4CwAOIEVKd8xqA4Al3ew3oANAah/WoP
         D34Ul+q8x31U+WlAkEOhEbwg1lgoXAd3VmckTHbAiKM15hZWmOOcLlxfwisRofxzU43o
         uOepMmH5lHff9fe9VDPQ0n7Wipe5zeRYzXMgrY2HtuzlOYk/hhdl0C+ZpimeaVLKOWCh
         /J8g==
X-Forwarded-Encrypted: i=1; AHgh+RobhdE41bl3G202IztLulHq4/4ZQeOBo6RNP1trqjO2uAVIoFxyCLlrN5XoyUjtZtLi+cZIPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPDgA2aACHphKALa7VirI8myARf2A2mi4sCDEtR5yqpgjquWdv
	eY7Q8VrOUczo3gGRQzDjYCdPMVAa5GOSdgyjPMCSsCoAE4AOxlvq1qhKfx4CUV+fJqWP4kavoWi
	XHHmZ3sf2CfgPtz7ksFC/zvplXDNjFJw=
X-Gm-Gg: AR+sD1252novAvuJKNY5EccExiSrWpZl9ZoRP9BX/LsVJXcTCNEO5Yk8isEPz7gNlvX
	qKCqFjP68Q00NXl8Q/bbmVujEVSP9wx+yie0A710SRrpN+xYOfn7t2rc/iJ5xdo/AnWpR15qdgE
	R+5nUXCtxa2Mq3pf9HAFLoyVbRuMjlN7pdfIyAtCcicXf9l6awTymMlxGKIJVcDSwZsha3lyMDD
	04PE6dZKnB2Sgsoz/uS7EBgqrz0WU5dYalBZZgxnI7ZWEm7MfHj19BnYDvjMdioJFTnmw==
X-Received: by 2002:a05:690c:6f02:b0:81e:97e2:2210 with SMTP id
 00721157ae682-81f69ebac17mr31274727b3.69.1785157182142; Mon, 27 Jul 2026
 05:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com> <adcfc6f2-3309-4496-8331-1ae31e85d363@sirena.org.uk>
In-Reply-To: <adcfc6f2-3309-4496-8331-1ae31e85d363@sirena.org.uk>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Mon, 27 Jul 2026 21:59:30 +0900
X-Gm-Features: AUfX_mxOitBR08KsPWHGWKTOhvBmlqBsOevQYdsbBN1kI3uyZROYcZJFQfRk1pk
Message-ID: <CABFDxMEmB=5UZx6RZgFNZyB5sg-+e2hgx_T1QjV0JzqP+auTFQ@mail.gmail.com>
Subject: Re: [PATCH 00/36] treewide: remove conditional returns with no effect
To: Mark Brown <broonie@kernel.org>
Cc: Julia.Lawall@inria.fr, Alex Deucher <alexander.deucher@amd.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Borislav Petkov <bp@alien8.de>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, David Airlie <airlied@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hansg@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jiri Pirko <jiri@resnulli.us>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Julian Anastasov <ja@ssi.bg>, 
	Leon Romanovsky <leon@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Sakai <msakai@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Mike Rapoport <rppt@kernel.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ping-Ke Shih <pkshih@realtek.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@verge.net.au>, Stephen Boyd <sboyd@kernel.org>, 
	Steve French <sfrench@samba.org>, Takashi Iwai <tiwai@suse.com>, Thomas Renninger <trenn@suse.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tony Luck <tony.luck@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>, 
	Yazen Ghannam <Yazen.Ghannam@amd.com>, cocci@inria.fr, amd-gfx@lists.freedesktop.org, 
	dmaengine@vger.kernel.org, dm-devel@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, lvs-devel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 9:12=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Jul 24, 2026 at 03:45:02AM +0900, Sang-Heon Jeon wrote:
>
> > All patches are independent and can be applied separately, but for
> > everyone's convenience, it would be nice if they were merged through
> > a single tree.
>
> Please don't do this, it does not make anything more convenient - it
> results in huge CC lists and makes it more difficult to work out who
> will actually apply things.  If there's no dependencies just send to
> each subsystem independently.

Thanks for letting me know. I'll keep that in mind. In v2, I will send
the cleanup patches to each subsystem independently.

Best Regards,
Sang-Heon Jeon
