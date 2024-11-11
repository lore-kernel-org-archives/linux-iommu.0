Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5B13D62B
	for <iommu@lists.linux.dev>; Mon, 11 Nov 2024 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731294840; cv=none; b=e5l2ZbWYWruKv58BnuzeqqyPjfCpPLrW6K/oU+0OQIISG3J+bAnHblqfcTkZJmso66x7iZKVl6KH5eCwYn9lGCaBjfz89RomMpFPi7iOP1oOCfibr+y/Fv84Sd3fL3lb/gxzB07QyCuzYIFgAjFYHVber0qs58lnbbknIt5H4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731294840; c=relaxed/simple;
	bh=QwxtcQnSjGzd8NANYWxEDGJdZi4pTtnLGIQe9sj9+lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPgQ7SRpqzi5lrhf+4BjFz1BHIJ4WedSBZhFqcqKgciRBdoo8VW+jl0CRyMd2882G5q3sKzk4/oHJro01+5sWxaQgMfB5nY4/2bnesEdYTaPwKxpPfgluepFy/0en6iCrE4AC2ku23nNCvpcDDI5zoK248PM3yFe8SQUuwYm7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFAIGLc2; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFAIGLc2"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso32675961fa.1
        for <iommu@lists.linux.dev>; Sun, 10 Nov 2024 19:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731294837; x=1731899637; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AszquRm3rEcjTNQTd7uRs0tgE9n1Q/miIDo52S90X0w=;
        b=aFAIGLc2yIBIo4P3xACVwVqEsksySSJ4nmbLj9rGHYUCq9Ba8mzvIjmZABNZEuODg2
         9EInCeBZGBEh9ZBpgx+hV4Pb4uTm2mBmaTJJ+YRksZrpTr1uRa0SukIr20IzzrVVaZoh
         ia5sEBrnAfFFqI5hsi8SqWc/XpgJuP7qAqMU7i+GLFUz6jektHjmG5hxAEPrfnb8MA9C
         T8v48++cOvzc7ei7o+fkVsgw/jnbI9wfA/g4Ftmvf6/GlUsoCYRmfPM1DMP3TAsh8+vP
         OqS5VjN+vA6tFxJ4498O/Djp7T1VIORe0wYkchKRjqGBTtCfTLcNS/n7VoOw85I1vxaX
         Fx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731294837; x=1731899637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AszquRm3rEcjTNQTd7uRs0tgE9n1Q/miIDo52S90X0w=;
        b=xRSczSHHWt8OWnwkd/GVZjZd0QWl/g4xuLfnblIhYYvMi1Go1BwHkV3XgUNl+9hB2e
         MMmAYbNZDJAwDQ+bY6t+8RxYMfu59hCMAm0E47ypzf1+XQTS9ekqIqVW7bH9Nmu4A/cK
         YanJO2gtpm19+RsoQ8xaO1Roo7sRDSMSf9a1Au0N4xUPWBdApVE6AQTIDX0sfeIE7VgO
         Gtw1eb9uNNGK/CQBCm+iE8EQfVyceFfK24lleV+psA50QcTtjWJTpRkGr9HXmbE/PGZI
         cX6NmywdXiJaocFFojE6DWRsm/WSODQ5tzfEKO43LJz809fFtZSW6FlxWxCua9YbbHxX
         7D4g==
X-Forwarded-Encrypted: i=1; AJvYcCXZCgtahASx5ofkVpORVaowzalHv6IgY1FDcAolfIGtT45/qUHKls6ZtS3OZEn2aQG3uT7UJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzWuf9d39G+vL9rbsysFPhZyBTpZ9zMEOSHCdwM3dZYs1yBtcE
	HZd146JWHtEYxzGs5f/I5125xb24hhHBUPIGvGr7Sr4NCwP8pmpuX9mBq9WQI3wORbVm9+9cYOB
	7xX8MvDfQHZVM7gMG14jaW1BPU2E=
X-Google-Smtp-Source: AGHT+IGCJWVGSDxh88mmV8TfpUkds1GTcb/SQfLMvdY+xjmMgOtiWhJjm3URTLzGgKvmaZLyg2QvEHBS9bNI0FtRaqQ=
X-Received: by 2002:a05:651c:881:b0:2fb:6465:3183 with SMTP id
 38308e7fff4ca-2ff201e7398mr46022501fa.3.1731294836895; Sun, 10 Nov 2024
 19:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1731244445.git.leon@kernel.org> <dca3aecdeeaa962c7842bc488378cdf069201d65.1731244445.git.leon@kernel.org>
 <CABCoZhAN-eeu=E5r+ZbZGTNwQta5yUw86sy8e_Je+Yri-+iuoQ@mail.gmail.com> <875xouv5lt.fsf@trenco.lwn.net>
In-Reply-To: <875xouv5lt.fsf@trenco.lwn.net>
From: anish kumar <yesanishhere@gmail.com>
Date: Sun, 10 Nov 2024 19:13:45 -0800
Message-ID: <CABCoZhDpdU0cGu8Ru5Jj+YmnS07cO4k_nbOFT+HkdFkpVo1NYQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] docs: core-api: document the IOVA-based API
To: Jonathan Corbet <corbet@lwn.net>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 6:58=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> anish kumar <yesanishhere@gmail.com> writes:
>
> > On Sun, Nov 10, 2024 at 5:50=E2=80=AFAM Leon Romanovsky <leon@kernel.or=
g> wrote:
> >>
> >> From: Christoph Hellwig <hch@lst.de>
> >>
> >> Add an explanation of the newly added IOVA-based mapping API.
> >>
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >> ---
> >>  Documentation/core-api/dma-api.rst | 70 +++++++++++++++++++++++++++++=
+
> >>  1 file changed, 70 insertions(+)
> >>
> >> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-a=
pi/dma-api.rst
> >> index 8e3cce3d0a23..61d6f4fe3d88 100644
> >> --- a/Documentation/core-api/dma-api.rst
> >> +++ b/Documentation/core-api/dma-api.rst
> >> @@ -530,6 +530,76 @@ routines, e.g.:::
> >>                 ....
> >>         }
> >>
> >> +Part Ie - IOVA-based DMA mappings
> >> +---------------------------------
> >> +
> >> +These APIs allow a very efficient mapping when using an IOMMU.  They =
are an
> >
> > "They" doesn't sound nice.
> >> +optional path that requires extra code and are only recommended for d=
rivers
> >> +where DMA mapping performance, or the space usage for storing the DMA=
 addresses
> >> +matter.  All the considerations from the previous section apply here =
as well.
> >
> > These APIs provide an efficient mapping when using an IOMMU. However, t=
hey
> > are optional and require additional code. They are recommended primaril=
y for
> > drivers where performance in DMA mapping or the storage space for DMA
> > addresses are critical. All the considerations discussed in the previou=
s section
> > also apply in this case.
> >
> > You can disregard this comment, as anyone reading this paragraph will
> > understand the intended message.
>
> I don't understand the comment, honestly.  You say "they" doesn't "sound
> nice", whatever that means, but your suggestion retains the "they"...?
>
> I'm all for reviews that improve our documentation, but it is
> *incredibly* easy to fall into the trivial bikeshed mode.  I've
> certainly done it myself.  The end result is less documentation as
> people decide, understandably, that it's not worth the pain.  Hopefully
> we can all try to do a bit less of that.
>
> FWIW, I think the paragraph is fine as written.

I completely agree, and that's why I suggested feeling free to disregard
the comment. When I read it, I felt it could be improved, but I
agree=E2=80=94there's no point in overanalyzing it.
>
> Thanks,
>
> jon
