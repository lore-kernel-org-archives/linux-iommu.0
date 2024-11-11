Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4742A8A
	for <iommu@lists.linux.dev>; Mon, 11 Nov 2024 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731307402; cv=none; b=VtzXorISjj1Dl2kgDBevp7OQ493kUWKrugYi8qEBgc5pn/5GJGNivJgGQ5g4bsv+BiyGbfwUGxcrefXs2xX2IM3S9piRIQ8kG2mKWqZNCQZ8/MXTeK5+RptFug2qIUf8aFKyvMPCwn0l1ygEV6lSudxAAAWUtGHGBfPu6mt4iKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731307402; c=relaxed/simple;
	bh=OSWugjKTomfPMjmF51CbHUYzDzMD4jhQH03P9Uh6PXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpY53/NFBAkS3CZyHYMI70xmmlhMSdiVLFsiHkHQNnRpvT5PLfXj49N33kDS7vKSDxz3Ja97LwwXVPG6qyrhAGIIHZhBAfGe23fFwhUYS4DgiV+1vFey5K8TlaiKvY4VniJISJb5ezAe24UsE4r/HIwrPghT5j2JER6Oxf54DxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmYqEsfp; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmYqEsfp"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so4567244e87.1
        for <iommu@lists.linux.dev>; Sun, 10 Nov 2024 22:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731307397; x=1731912197; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qv7O8dew7I+B9eEJJt0qBNM8IZdD1sLJueFsW4bvsc=;
        b=nmYqEsfpokIiKiK5RpsIPTW3+zXAWeW0ng9K6mGTaKXoGVm4XHtKj7Ttpu+pR1ahIh
         3bO2jq4p8wiVkFEB1xijfKWLObWJLYMSxNLCUrFGZbwrXBSFJ7NoOS32igWiHj7zxN9g
         9ud2EJkXkd62zE3g6bkgldfQ9j+LMqntTx4QAfZTvjh/MfhN9aNQoZxkwW7V3bmbCR2z
         geLF3nGPfR9ojjyBFMbOxHmuKe2+8fpHy9cHjSbpNZYcFmZcFE8CEgrfqhU6wZbQlPIE
         GabX1kR7EQYImcoxedwyClyK0GpIBAvidiMUMe1qZJRkdiRxHYh2rIY7RI5ql5LntIzD
         2uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731307397; x=1731912197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qv7O8dew7I+B9eEJJt0qBNM8IZdD1sLJueFsW4bvsc=;
        b=fC2GiTQV16pvoSiotbYD3Ru4PKO07HhDNuuq1QW3jyYKXGKEx2/apZN/XZo54BdT4T
         tTQz27X6Px1Fr0eZew4kW8O+hyihohFSoqcue7IeB3z+X++bjDDgeXmL3j10aVmI2F0q
         uHmRoqFMR7lhGOClZiuXwGVwhoywBkEtirQexqo1J6xiy3CS+nN+4nDYNl4XOHI/K3xg
         CqQorpE8bm+hRsQG1j1jVRcMKz//tGomXs1iuw+SyzW6RRqzGJZXRCavpk0SxjwvDlir
         JtGp52v1ZW+Z+54g0YG46IWFNk/P5McThY1AsQXybqB2AkciudCRnsSaIL5DdMMu7yIl
         hrUg==
X-Forwarded-Encrypted: i=1; AJvYcCWQA3x2YcFpPJavyxEJ6yXmWdBYcsCsPMLgZEKUQ5pN/rkyZm2Q1CPKU8lk83imTgqgWUaDRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YztQ5/xx13vmVFGooVeAH4mzgxOxfLUJo0Zwaqcfw0KIQc8pqvl
	58l6c8W3AxHTLOsLKYLkGgzuYCoS+UynmojPMYvcfjKwWaICLmt5uQZINiXJxDsKCH1eatpVeGj
	hw0ihshqyFXX3Sj9mI58hGjqqQe8=
X-Google-Smtp-Source: AGHT+IHutgQAlXklRgMYNRidcA41kXnbJbGiEJGtaB5sYolGWbh343PWRuG4ZkC83mQMH8VsiDxXBWb3iwvgsLPw2Uo=
X-Received: by 2002:a2e:a813:0:b0:2fe:fec7:8adf with SMTP id
 38308e7fff4ca-2ff2029fed5mr47426781fa.38.1731307396466; Sun, 10 Nov 2024
 22:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1730298502.git.leon@kernel.org> <881ef0bcf9aa971e995fbdd00776c5140a7b5b3d.1730298502.git.leon@kernel.org>
 <87ttchwmde.fsf@trenco.lwn.net> <20241108200355.GC189042@unreal>
 <87h68hwkk8.fsf@trenco.lwn.net> <20241108202736.GD189042@unreal>
 <20241110104130.GA19265@unreal> <20241111063847.GB23992@lst.de>
In-Reply-To: <20241111063847.GB23992@lst.de>
From: anish kumar <yesanishhere@gmail.com>
Date: Sun, 10 Nov 2024 22:43:05 -0800
Message-ID: <CABCoZhBVWY=aUQtQ5b=mF8hXqpgJw21_jAPf9YvEvdgPf_GALA@mail.gmail.com>
Subject: Re: [PATCH v1 09/17] docs: core-api: document the IOVA-based API
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 10:39=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Sun, Nov 10, 2024 at 12:41:30PM +0200, Leon Romanovsky wrote:
> > I tried this today and the output (HTML) in the new section looks
> > so different from the rest of dma-api.rst that I lean to leave
> > the current doc implementation as is.
>
> Yeah.  The whole DMA API documentation shows it's age and could use
> a major revamp, but for now I'd prefer to stick to the way it is done.
>
> If we have any volunteers for bringing it up to standards I'd be glad
> to help with input and review.

Jonathan, if you agree, I can take this up?
>
>
