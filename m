Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF02102
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 12:06:32 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-965f7bdab6bso1387279766b.3
        for <iommu@lists.linux.dev>; Thu, 11 May 2023 05:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683806791; x=1686398791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tDfXQ17FO7BOQj7+ESY06ETyUTlemE288YQq2nrYcU=;
        b=jbI88sNpPdUELvvFxsUTjkocAebLsvf95+U/8NHHX/pJvUND+kMggu0ip00C9fLHW3
         Sr00b7xjjhTkvvT16eK9VLhjAc2/n5gSxn1ZBsc2D9snJt/WMj3vv7/e0h7/7LGTarfq
         rzKcRql09iF6sqmFS6xDgNR8RclAqTpY7WQdZDQcqBooYjV4ijtzGTvpDcsWbe4/7yeI
         Ygcbswr7MJAm2agnKxHM3GxOf1IG0++tStjs7U/EHFTQN6nLOIru+hGV/143e4J5a1Kt
         MUQ+ILA696hZm94i+PaymfHWPSvY0e3Oi1cn9Q4WMlgyTOfbp9D7m5cJjY+7DuquofJW
         OAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806791; x=1686398791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tDfXQ17FO7BOQj7+ESY06ETyUTlemE288YQq2nrYcU=;
        b=jGtm35ctfFLEEtnbZuIRKhDLT6nqpp04JWTTmg0n1QPx+wntQ8D4Fuekbcye6lfOiN
         nrUw6dNquQujj4DwBQKjMNISq7MGLB9OeB1L0HZb3pWOqDslkCaS6LL3VgLGtalNS7+H
         ON/qzELsYYcw0FajWZOOKKhSl7At/D7QzNmjs8bl9NuvlCRqnmH3oqHMoRukfx0iFTyX
         8Wdk/gzDJghscb0uvguPda1pyDldtQADEkD0QumWC1/9oa5tzF3zS9xyawQA1Zme+J6C
         VoBpqN204nPYMzK8EVXfNrP4Sal+pG+5i3tbiSJYr/1nY6uFzouantuvGvokH5celctW
         pAMA==
X-Gm-Message-State: AC+VfDzL8LJTBxCMDGPtEJZ8aTWqgEMctZrj2iXs4bltkk4a4nMCUwWE
	T/zltNcGbAginVlyv2ZThOLpwAubF19bfv9iJtw=
X-Google-Smtp-Source: ACHHUZ60+xojJ+RF7byu2Sar29A3i4lAnC4JlYOPqe+rUOFHFfM22cKd8y41fY8EeH1nbgJXNHR16+LwNdR9w90VWHw=
X-Received: by 2002:a17:907:2d09:b0:966:4d75:4a44 with SMTP id
 gs9-20020a1709072d0900b009664d754a44mr14333819ejc.24.1683806790925; Thu, 11
 May 2023 05:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230421080800.18837-1-adrianhuang0701@gmail.com>
 <20230503161759.GA1614@lst.de> <ZFvgz5VgVGEmyAuj@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZFvgz5VgVGEmyAuj@kbusch-mbp.dhcp.thefacebook.com>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Thu, 11 May 2023 20:06:19 +0800
Message-ID: <CAHKZfL3Pbv76fqF6Dn8NHbMn7oQ=G02azU-=meLwAKMFPi+jbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] nvme-pci: clamp max_hw_sectors based on DMA
 optimized limitation
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>, 
	Sagi Grimberg <sagi@grimberg.me>, iommu@lists.linux.dev, Jiwei Sun <sunjw10@lenovo.com>, 
	Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 2:22=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, May 03, 2023 at 06:17:59PM +0200, Christoph Hellwig wrote:
> > dma_opt_mapping_size falls back to and is bound by dma_max_mapping_size=
.
> > So I think we could just do this:
>
> Thanks for discoverying this even futher simplifaction. This looks good
> to me.
>
> Adrian, are you okay with the suggestion?

Yes. This looks good to me. I like this simplicity.

Thanks for Christoph's changes.

> > @@ -2956,7 +2956,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct=
 pci_dev *pdev,
> >        * over a single page.
> >        */
> >       dev->ctrl.max_hw_sectors =3D min_t(u32,
> > -             NVME_MAX_KB_SZ << 1, dma_max_mapping_size(&pdev->dev) >> =
9);
> > +             NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> =
9);
> >       dev->ctrl.max_segments =3D NVME_MAX_SEGS;
> >
> >       /*
