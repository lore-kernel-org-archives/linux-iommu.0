Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF821C9E8
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589599; cv=none; b=DuBylEw8ZcsfUtRmMunHL5u6ZPFAp0l17YIR4TG9O9p4iv2cAt+PZDN4fxS8mPFiFh2VQIBAOdLNyKwnve+XZrgQo0ho4xTg+SYscSNGS4pgoSr0Z1k8Hfsoou0KFWO+80OHfc6ukRjwM7GBofIqIYB3RZOiT6diPk114HR3/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589599; c=relaxed/simple;
	bh=2R180IJ7APaALd1g+yyfkVhGYnf3hIvGDgk8lsKLG8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8TRhcxJ8E3aPz7bLSpfkPrnIcocCIott6ZVLDDO4z+gY8rni9T+BvmmjRIctFzF+QofmMWLcAbFzwExQjXQKv+VdbrC7nG5puN8Tlh/W1fTC0RneefW5rLhcyxMzR4OaDhIurtyCinpqBw8CK1ldNMHBnFs7mFA3Ih+1KSupnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE/EsJFb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE/EsJFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F46C4CEE9
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 17:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740589598;
	bh=2R180IJ7APaALd1g+yyfkVhGYnf3hIvGDgk8lsKLG8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LE/EsJFb2o+sN6h6c7yw0PHl5LhhPL9w8R/xJBOUGLGKDVwUw+DydCDSC471vysSD
	 LISAoC1I0aiD8HNK6hiavbFjTbfVfWIEA7L1eR8HxQRMg/ixQsSCjCxDSnpuH93a4L
	 GCYdnB4nMh2Uh3YepPtKutGEeO2DQhULDzCHc6Nmg97rhggPf9UGwulKmuba0a5e14
	 Fut9ocBXr94N7Mio3eJQCaAchxPD9Vb3fOa/QCj05mhi1rXU+hZPsAb4Rqgn+WDUss
	 WjKjp98yld7wOpGGXJkV0gW0zSbgW8vBFR+SvA0x4pwGWtiPCI/wGL2XwY5vCJxhqr
	 99NfBGQtHYXJA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fcd811d939so580376eaf.0
        for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 09:06:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXq8Ie0xi1psaSUENAg2n7NdgP6GuWXVm4yGr1HPC+ndPkDyyiFccDSIV2DE/2zrctO5qRYqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxMJcPtv7zMSGSt2VvefeedvrEg2eQsgeQtvPPbUeW1WqDl2o4
	Jr3K5py70P5o3iJgvEuQDfGUcAP8gkFJNspJXxoRTPL9SXpWjQN6ZjjrHscC8k4ApbAO9D3w0Xs
	u05BYx0EIFkgPYvcK3Nk1OjShl8A=
X-Google-Smtp-Source: AGHT+IHyPLVjXp7kw5kgInAMNb4jd7h5cWQZCWKEZs0yMGYHKslrekdKrqf86zX892n/fj3IchT6bMpb2Dem6Q8+U3o=
X-Received: by 2002:a05:6871:d20d:b0:2bd:286:d713 with SMTP id
 586e51a60fabf-2c155700434mr67466fac.11.1740589597661; Wed, 26 Feb 2025
 09:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com> <20250221-rmv_return-v1-14-cc8dff275827@quicinc.com>
In-Reply-To: <20250221-rmv_return-v1-14-cc8dff275827@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Feb 2025 18:06:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i-_08mhOpsecuU+XzS8rKbk9mtgr_Kwx-QGRPh9jumKw@mail.gmail.com>
X-Gm-Features: AQ5f1Jo18T3Py72uAV75_Jf5fdQvWu4rZ8JYWNQWcMOGXjnJR1QY3tpi4Yj9mbE
Message-ID: <CAJZ5v0i-_08mhOpsecuU+XzS8rKbk9mtgr_Kwx-QGRPh9jumKw@mail.gmail.com>
Subject: Re: [PATCH *-next 14/18] PM: wakeup: Remove needless return in three
 void APIs
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>, Thomas Graf <tgraf@suug.ch>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:03=E2=80=AFPM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:
>
> Remove needless 'return' in the following void APIs:
>
>  __pm_wakeup_event()
>  pm_wakeup_event()
>  pm_wakeup_hard_event()
>
> Since both the API and callee involved are void functions.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  include/linux/pm_wakeup.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index d501c09c60cd..51e0e8dd5f9e 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -205,17 +205,17 @@ static inline void device_set_awake_path(struct dev=
ice *dev)
>
>  static inline void __pm_wakeup_event(struct wakeup_source *ws, unsigned =
int msec)
>  {
> -       return pm_wakeup_ws_event(ws, msec, false);
> +       pm_wakeup_ws_event(ws, msec, false);
>  }
>
>  static inline void pm_wakeup_event(struct device *dev, unsigned int msec=
)
>  {
> -       return pm_wakeup_dev_event(dev, msec, false);
> +       pm_wakeup_dev_event(dev, msec, false);
>  }
>
>  static inline void pm_wakeup_hard_event(struct device *dev)
>  {
> -       return pm_wakeup_dev_event(dev, 0, true);
> +       pm_wakeup_dev_event(dev, 0, true);
>  }
>
>  /**
>
> --

Applied as 6.15 material, thanks!
