Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184B5A0FB
	for <iommu@lists.linux.dev>; Fri, 29 Mar 2024 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708054; cv=none; b=hWuT4uYUt34BkXpOAnuLA8UfF8vZCrjMp3PF6yzM7e5Ov0AqL7ylKlXGrAUnqcGXpbJhZyoHqugq63dVZM31wkxXtBGF0V4f1gwNMVYEBF/9tF1lMTOozcyOTTAXbBTa3WgG9nKJJSQUA8huyhoAUjPq4Lll3lccQI2+ww1SoqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708054; c=relaxed/simple;
	bh=n8h0843dN8D5vA/PkugrZHKUYOVTJ3ipk22+mvTL/rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pL+YimuJiafnXb0ZoV21NmGcn8ACA9nrq9ymWQXVeiElrUg+cfqZaYsjKxqUhGdpoaHrxGIdpOd4Qd3iQzYR/Ov2kn475IQPVU3NkRLniRao+AzXXVizzDXGCMozdlpuyuOZCJLEhphtBc2Zkyl5aPIfGB8O4m4PibLsCgSKrOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MZPe/cIV; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MZPe/cIV"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513d717269fso2122519e87.0
        for <iommu@lists.linux.dev>; Fri, 29 Mar 2024 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711708050; x=1712312850; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPUqPHiAYDsvF7c6mpbUarOnTLvyyWG07eUiOIJt2gQ=;
        b=MZPe/cIVzKYO3C3uyrjk6Upts87wihSe9gIgurpHZ681bT+Cv9XJwd7bPftohQw8mf
         ROEWq+b7ZaDH29azPnJjiF7rkj+liraXz2v5FAeMbY8aLeKlUhARQb2myqgxlO4XkBeE
         Dg/SzyLWImPyULXArO91lozpFmcIPj7JVVifFfl1WeusEmY7Q0Hfq50dym15xLLz+HEg
         CGOtKZWCd/R8YhRJq9XBbL+zX/T1j30eIJwHFq9q0IeHcsTL3GV3n/jBR8sYOAbVf7wy
         krfRmaDMIuQzblp2u3jmt9N9kK+zOhfR3TQ8K6R2JqmBdWQSmWRjH7blDjw+6lbRyd8y
         7Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708050; x=1712312850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPUqPHiAYDsvF7c6mpbUarOnTLvyyWG07eUiOIJt2gQ=;
        b=rYlP4JllzINWTPeZIszy8xrJ+3GcFRjtZEP3TEaNmlAayYTzxsfUp8rpOPPPw9SBZF
         JZe3jTdVvYY7cBxp58fz53sdpANr/ld8w47tgxAE94QX5rZmuIVV4rdnwQBWOyFQjc2p
         AEetG3qFZczUpasazBeNuGYpjXreR+abZF38mOJs7bL8IYdjNLeW7nmqE/IJQyig+Az2
         k5vfq66C3TZzXAcJ+dTBsn+jX0lMWj9AbXgbsvlu0G1L1LidxNExsZXvI6T/Phy57XET
         h0qlEsis2MRJay5hw7xZRJl4MB5N5RtnPqWK5Cns3Wmqrr4GRe9mbncy9lzhQK8buz8e
         +o7w==
X-Forwarded-Encrypted: i=1; AJvYcCXL3OwjE8P3Md21TVgqmbMAa/dBFVCnPYUduKgL+X64/DRWE6HWUp0HVliKqvcpVHusZpmusTxGAHD5as5bAYuWcQK9yw0=
X-Gm-Message-State: AOJu0YwVKuDaJZgTDsAp+N5TOsloxEkJrjHIjulcoK/Df9KuCRhe7oMv
	U725YXqmJhMCTgIH3nxOXw2dgevUwfrryMOCneALcyyALmGJBpVO0l9DNdAIaUM9ZcyNqN1ZZwK
	Uz2t+bmgvePUuUgLZiN3MbegYpd1OHKamu2WQSQ==
X-Google-Smtp-Source: AGHT+IGkJetMoIDH9w2TQurNFFXLK7XsHfl+lPbtCC+0MeMFYTkyF7Alb8el7pzIkiwo9JvBX9h3ULKBGoxrg4XKpUU=
X-Received: by 2002:a05:6512:33ce:b0:513:af27:df1c with SMTP id
 d14-20020a05651233ce00b00513af27df1cmr1559870lfg.11.1711708050041; Fri, 29
 Mar 2024 03:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org> <20240327-module-owner-virtio-v1-9-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-9-0feffab77d99@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 29 Mar 2024 11:27:19 +0100
Message-ID: <CAMRc=McY6PJj7fmLkNv07ogcYq=8fUb2o6w2uA1=D9cbzyoRoA@mail.gmail.com>
Subject: Re: [PATCH 09/22] gpio: virtio: drop owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, virtualization@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	netdev@vger.kernel.org, v9fs@lists.linux.dev, kvm@vger.kernel.org, 
	linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 1:45=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> virtio core already sets the .owner, so driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Depends on the first patch.
> ---
>  drivers/gpio/gpio-virtio.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index fcc5e8c08973..9fae8e396c58 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -653,7 +653,6 @@ static struct virtio_driver virtio_gpio_driver =3D {
>         .remove                 =3D virtio_gpio_remove,
>         .driver                 =3D {
>                 .name           =3D KBUILD_MODNAME,
> -               .owner          =3D THIS_MODULE,
>         },
>  };
>  module_virtio_driver(virtio_gpio_driver);
>
> --
> 2.34.1
>

Applied, thanks!

Bart
