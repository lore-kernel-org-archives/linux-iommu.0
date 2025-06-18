Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801C2EE601
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258823; cv=none; b=cyK45qoPYyjmBDGEkDbYnDrtJWptoZ/++dpT/5vh2AW6v+AgKn4lQv6EjYV5cqyuET8bMG4l6XQ2gnkzNoR7ke4B4keMvNOYYIp/GDFooqwCOitDyY0fDetKO9q5FABATROzehMj44ATBOR6HMTkgnVczOwAd3sS/IL8jhcVGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258823; c=relaxed/simple;
	bh=1XEQ/vx/9M/0Z/ONOs4n2AjYGm4cFrrb8VsMsNtcnFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6LGi60ZI6h2k84L277PeVvKDwyDYwn2Rdqp8f6Li98AULYZi+wjgmrJ/qSA7aL9h5n4SeKu6avEWzqzLE+Op/+JMwSoRpvAVrvWq74PFhAHInX6CW+garvUyg4bmxhGCi3BgMPuAl/w9tNeIkdaPrlrvJv3s8kJlNNQkMWXXxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ozpwihvc; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ozpwihvc"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7caeeef95d4so781674385a.2
        for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750258820; x=1750863620; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vgoqcy77dCbehp2iwR94a5PWkF4ktryddedGtroeuu8=;
        b=Ozpwihvcf/SBjE3iUSJf1IkLTGxnq78fKAZSj72wY83AV7etviIaaPv+6r4LdE9yY7
         MyWeNI6WARvi8p44S5nAh22qWde+vmBdyLvP1cd+WEC4mkKk5q+Y2MSvsl8XN2WL8N6o
         2ZVWXjAZfMqlOqXmpLwChduoU3VpJBSIgbZguNaV6Otd5cXzBRMFY57v6O73/wvLrmxl
         2Vn9j/NZj1hk/r2fFtCh6G45wMGfbGN5k6uVKhQy0+UtUrTAfrBwE/gollHjdCXdRtUF
         aBkMntIf/FNxFPluMih9fPiWnz1pP9kXtceOMVKOTucGinSx8FGBTiI4AW8m6XIHfzPw
         J5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750258820; x=1750863620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vgoqcy77dCbehp2iwR94a5PWkF4ktryddedGtroeuu8=;
        b=A2mC8JSzr55cgqCNO9PdBLMmOlVP/7XaPjhFxfJRTnUAXQRQtlu9nsh0D63Uf6bQjU
         94b/SHEfoc7VIMUQEdiO+vit6AoqzQYt9NjQdKw2ppua9aZJYpDtla+FNhrKEnV/2tmU
         STfoyt3t/el5xab4pfztk1sVQH7ULDi90Gl+hKjk0d9qfD4tHewXFQGlGpDdPUQNIFI5
         0oQ0XS6W6AOf194VX6P3pPeLaUIWwHrjyScUv17uApB6XL3P09roo3MrRuF9VfEsIsU7
         0JNRriwy3CpXrla8Ukag1PRIhyntSxpjgZWUv3Ftakq4DiMRAy3tEhaDxU6pFfMF4j/C
         +s2A==
X-Forwarded-Encrypted: i=1; AJvYcCUZOMvRDdsjsZdGXf0LdymDUrlUXvYJUJgX3WNCYumy7bKnVnzuPsrFPubkBpzzxGNB5Ohy+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/Ojfj6nCfUcswuw05BIOO+F0FLaKEuqI1/a5NPkhBiqDGIlmc
	90rRzBAhuJyWAGjG+axuK8t1ONzdfalCqmVqUiSk6dLXkB/NYU9FlHFl5/c61dPOv5o=
X-Gm-Gg: ASbGncvcPL2dlFFJY7m0olHmuefaH/REOZXvxueowE+tGc1zl018ghQm8CVPuBpi2bD
	CmYwTjL6HeG2tJ2x5WlUTJqBquVNohLWlaoaubhUqMwtS4cGdEB5eJrCQRsPUfhpxbGLyP8Rmb3
	7aPjRg32oSTQAuSwIfS0OQF6kUNf8tWl5EsU4vyEE4RTNmfjSRsSQXXjkU7nwjE+/Nqqj5SYMCo
	sG5ZHtZ2UdDyMrCnlhD74r8qKqYCTB8Ednoi9f9rBnWsKWQRtXHjungN2cXTUELGpeOkUHeoXZc
	2XHLPQBPZXEUJBLP4U9qCvBwv/Oz20sYaJhj25/Aspk2ts3gLyOuvkJuF2K/9RSEtyRYeuYvsEf
	TWRTT3tmIEIpY80IH056IDIwetlIl04BR6gBWsQ==
X-Google-Smtp-Source: AGHT+IEmXnt3uIyq+wbp3haWWpVf5H5IK0A8maNryrSJ2ysQfTpYtx8UqGj3mP+8PAcrc8mbSZcjjw==
X-Received: by 2002:a05:6214:29e7:b0:6fb:15d2:494a with SMTP id 6a1803df08f44-6fb477a51f7mr239650176d6.41.1750258819801;
        Wed, 18 Jun 2025 08:00:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb525553c3sm38390486d6.104.2025.06.18.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:00:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRuGw-00000006oub-19lH;
	Wed, 18 Jun 2025 12:00:18 -0300
Date: Wed, 18 Jun 2025 12:00:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Message-ID: <20250618150018.GS1376515@ziepe.ca>
References: <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca>
 <yq5abjqotim7.fsf@kernel.org>
 <BN9PR11MB527633CA2F698E83E12BFBD68C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250616164941.GA1373692@ziepe.ca>
 <yq5azfe6ssev.fsf@kernel.org>
 <20250617183452.GG1376515@ziepe.ca>
 <yq5awm99sjmr.fsf@kernel.org>
 <20250618133527.GQ1376515@ziepe.ca>
 <yq5att4drtj7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5att4drtj7.fsf@kernel.org>

On Wed, Jun 18, 2025 at 08:22:44PM +0530, Aneesh Kumar K.V wrote:
> > The full sequence I would expect a sane userspace to do is:
> >
> > open(vfio_cdev)
> > ioctl(vfio_cdev, VFIO_DEVICE_BIND_IOMMUFD, iommufd)
> > ioctl(iommufd, IOMMUFD_CMD_VIOMMU_ALLOC)
> > ioctl(iommufd, IOMMUFD_CMD_VDEVICE_ALLOC)
> > ioctl(iommufd, IOMMUFD_CMD_VDEVICE_DEALLOC)
> > ioctl(iommufd, IOMMUFD_CMD_VIOMMU_DEALLOC)
> > close(vfio_cdev);
> >
> 
> And if the user does
> 
> open(vfio_cdev)
> ioctl(vfio_cdev, VFIO_DEVICE_BIND_IOMMUFD, iommufd)
> ioctl(iommufd, IOMMUFD_CMD_VIOMMU_ALLOC)
> ioctl(iommufd, IOMMUFD_CMD_VDEVICE_ALLOC)
> close(vfio_cdev);   -> this should call vdevice_destroy because idevice is getting destroyed here (we will put XA_ZERO_ENTRY here).

Yes, we have to destroy the vdevice internally here

> ioctl(iommufd, IOMMUFD_CMD_VDEVICE_DEALLOC) -> No error, we convert the XA_ZERO_ENTRY to NULL here?

This should probably fail since the user has done something wrong and
it would be the only way to realize it. The failure could clean up the
tombstone, or it could just leak I don't have a strong feeling.

If you leak then using XA_ZERO_ENTRY is easy, if you want to clean up
then you'd have to have a global static 'tombstone object' that sits
in the xarray.

Jason
