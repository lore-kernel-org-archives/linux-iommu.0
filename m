Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93D85931
	for <iommu@lists.linux.dev>; Fri, 29 Mar 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714952; cv=none; b=QsGd5vBc71GyuQsBqT8rIaVIupUP+wJZPJlrjh2UbaqXcKKubqAYkNCmmmACl+Zkw8cLXmpTWbg3cXiXZ99nNHUA9JyPE2DYQ7FI//CDguJ5rK7pT7B0oAZY29UY672gSlcYvNyvU5uF0utimAY8cmG4bpzlkpt98GuGrGyP6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714952; c=relaxed/simple;
	bh=leo+Yi4AfSnMVg8mcM4Xju1MFqd5FSUEovb4t8XjI+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWIUGVHG8OunCH33f50ULnGpead17kSygIXl56UrGw2bxg8a5TVhkFPsgtQpmgRyx4CKyfmlVohSdS0NFAU9vZQ6R4pVSQQYleKgOhcceNK9C9R3AalW1eJs3ggctl168+uUT7u1MDLpW6UgIaOnNqR2NvFH6FbktQ/Jf9q74Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XM3lidnS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XM3lidnS"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d6eedf3e99so28317211fa.1
        for <iommu@lists.linux.dev>; Fri, 29 Mar 2024 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711714946; x=1712319746; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdH2/uZDyLmBSFlZ529ZdmMTMc2xJjXR5We9XRvPLc8=;
        b=XM3lidnS4a4l5xGyYtHqeQ+nmPl/tGJxP7T5EY4iT2xBdC4Av7bTKqQ45DuryKFxTT
         7SOcuUOH8HLHJ+vwCj8sUl9rDb0AAkvr9eiaxPTtwXddqOYDQwGeBPnwFdvQgP2q/5oL
         EnT6MF2C8J2qtI6J6X/sYGueF2zFLBbBjfXH8NzS3pyP6V0+Ptkx4n3Uaq6mlsYTRla7
         olJNmR/oy0qJqXQfZLHZeLaYH25x6LmXCQrbo++TTrzBBLpMKZDt1gbVBl0l71YjD8BC
         hnbaGsQeZg7V83kNC9iHkesUj4PWLbzY9BxPevFSUNoAGR7Y3OgitTM5qqr0VMJ+mT8C
         7Jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711714946; x=1712319746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdH2/uZDyLmBSFlZ529ZdmMTMc2xJjXR5We9XRvPLc8=;
        b=nMXbMpIApOAz4JyewfceNo5dMqJjQJfj9dP2F5/WAMYdgGiMUWUa6JT3MXb2zg5ldj
         wD8+20Gq8ImPudgV4KdIYv4KmTiOI9gqpbeYjkRxP9n+PNYq4yJRsC0vseFx4H5oJ6ii
         t8uCY/iG1xfu3ZMT7IUNR4lWFR5CbVgOPq5OzuTjsVNzID6uW5t8a3FYzLZjhk5TEecu
         GHJHNVL2O8GQwzKAklD2O/aDVbpgn/qotXKzLEgM9gShTrlZBtruS2aytGoqDlu2UjHn
         rlFHP38BxpzGOW+fLpHdzLCKeUTnk8VMgdyKJBVUO0yJebjJyShWa30iLEKPD2wSqBsn
         0QpA==
X-Forwarded-Encrypted: i=1; AJvYcCVoEwK8FLpUG40U36Dyhtm0c5j3ws7VcBVLYAan0SKQxx9CywrzP6xqJH73FRqz5dAqHi0YVD4Lj3WnAXSs/QCK4B5BQ3A=
X-Gm-Message-State: AOJu0YyZG12cF4yGUn0CFo0xFtkrHl3ps3JpJoJUP2xAmhPE4QLbiMj/
	QUKnzpcgpzIMV+DnqIWQ5q0LOiPGz/HUcasx+g31gJa+1gFtDDnnQj0U1Ui0RX6tebTHELVjpEj
	kEfjmJ6WkquDT/AKpLZ+lBuA7zXBHDPBbFvFcYQ==
X-Google-Smtp-Source: AGHT+IE+HnSCJL2quawa1K1lMrp38Nm79TgJqcEd/z4x+7H7IfVDrdpUOVuBJN0I2Fw0lOyMRLNfqEQZZUdPpNwT2ZM=
X-Received: by 2002:a2e:8350:0:b0:2d3:5480:92aa with SMTP id
 l16-20020a2e8350000000b002d3548092aamr644831ljh.25.1711714946358; Fri, 29 Mar
 2024 05:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
 <20240327-module-owner-virtio-v1-9-0feffab77d99@linaro.org>
 <CAMRc=McY6PJj7fmLkNv07ogcYq=8fUb2o6w2uA1=D9cbzyoRoA@mail.gmail.com> <1303b572-719e-410d-a11a-3f17a5bb3b63@linaro.org>
In-Reply-To: <1303b572-719e-410d-a11a-3f17a5bb3b63@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 29 Mar 2024 13:22:15 +0100
Message-ID: <CAMRc=Mfeez9kXkkVxdmUk5dy=L=rbnYkYujO6jSCT5WAyUw2HA@mail.gmail.com>
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

On Fri, Mar 29, 2024 at 12:35=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/03/2024 11:27, Bartosz Golaszewski wrote:
> > On Wed, Mar 27, 2024 at 1:45=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> virtio core already sets the .owner, so driver does not need to.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Depends on the first patch.
> >> ---
> >>  drivers/gpio/gpio-virtio.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> >> index fcc5e8c08973..9fae8e396c58 100644
> >> --- a/drivers/gpio/gpio-virtio.c
> >> +++ b/drivers/gpio/gpio-virtio.c
> >> @@ -653,7 +653,6 @@ static struct virtio_driver virtio_gpio_driver =3D=
 {
> >>         .remove                 =3D virtio_gpio_remove,
> >>         .driver                 =3D {
> >>                 .name           =3D KBUILD_MODNAME,
> >> -               .owner          =3D THIS_MODULE,
> >>         },
> >>  };
> >>  module_virtio_driver(virtio_gpio_driver);
> >>
> >> --
> >> 2.34.1
> >>
> >
> > Applied, thanks!
>
> I expressed dependency in two places: cover letter and this patch.
> Please drop it, because without dependency this won't work. Patch could
> go with the dependency and with your ack or next cycle.
>
> Best regards,
> Krzysztof
>

Dropped, and:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
