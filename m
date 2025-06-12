Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856019B3CB
	for <iommu@lists.linux.dev>; Thu, 12 Jun 2025 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749749210; cv=none; b=T8HpKt11MsvAZYYXG68WQWW+NH02cPz2gMl+3XUBKxaDz1gp4glHuT1glpvVinu8lrxu8pAMawG9yQtVpxp3QOrhSORAYiojtogntCnCJC6ejbV4rHqBstYqJEzm9ZuHp+keTeXiJFvz7CqVONoaLbsvr6GLOltlkFKi4xhgsyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749749210; c=relaxed/simple;
	bh=dz2SWO/qjquiwy0PGFDKRs579mkESAbU2M9tXv9NTak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7iopIO3B+BEkP8LeMOub0zHhCMYMIv612SHAQQP4kzT1iIgi0VMmn8zGCP/J41vqzBl5ivgF+llNR4NAeC57iF16YG4VERjBLnt1OSB412/5TH3RLSGcpSkYs0ZjOzEXaZEaocOiYLnS5+hbbK1KNMqmwfmalz+VQFPd8jPvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QgpXmxmy; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QgpXmxmy"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c59e7039eeso167359585a.2
        for <iommu@lists.linux.dev>; Thu, 12 Jun 2025 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1749749207; x=1750354007; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GuFH7G0Hkg76CbNkjUTmYOvrBIu7sqIQnC0f9hQ2KpM=;
        b=QgpXmxmyjXe4iX0nKNMKB/qGL4Rc+rzIlYrHomf8i5UZ+TiQS0te/q9mfDCozYbaqm
         REINCwssN38jCVBzhLbGa238MZnB2gFXiBaZ+WKoAgYI582NYBMIHABkWX617C1RMirF
         ywstTs2QIy3ydfz0t6xJwIT47EnQt8Q9mW5HX3u7xyVkCW1hST3n9SzCM9/gaYqaGej1
         mQj/k3h28Apzx5F58xx/5AcAP2xvpx00F6qowhxhikkZnhX91m9FaiEVQIh5aXbQ3k/e
         mb9q4FH3HyV234gtQ9WnqkuNIMcP9zrgbK8TxYxA5HyM+fY67n8p0hahIamndVbhwbzo
         SI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749749207; x=1750354007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuFH7G0Hkg76CbNkjUTmYOvrBIu7sqIQnC0f9hQ2KpM=;
        b=ro+wISTodDEDQLFtNquzFb9wAzuvKFaD7ZskoMjDPsSWmYCv6Cknx+frlyxVX9pm1l
         UKwlOHGXup3VOMf/4olg0goHRE61SRBVXZu1N5/xMbIPvGt18T+TA0OGRYcCR838k/Pa
         80knXXP4cTknomDlCJdS3YUUvNzc+/nmbg7na42HlHJrgAZ0utTJAui9SnB5Y3O6uDYa
         k1fuHbmLJxHUq6WqEctJ8R444+dJ/Mo3l6P0uiopIK6AYWMyf2Iy2AbVhOZi2aMFy4FF
         BxQ0CuTEJm8FzokyHROTVhO8Rrk1z+4vPqt8uKgjOEmy2RNNvwuIEfLt7C8DwIVtx0iP
         kycQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8iMPuWHhtfxgFOfLo77EGFSMMoyWWA9hVqiprICy+Js+35IiR0SCBqTS2I99tmj/iV2IMZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0vf8IX/2lgfe8QuD4xN2pkSXnVWpYOnXL3DbG203IxsKVIwAM
	17W39Vxb1+XlArpbI7BVC94YuR1DN7WVIFKdDMCNM6dg18rkEeT3hxR7FHsFRWHhGl6TxR/gm46
	YPaLH
X-Gm-Gg: ASbGncs/Dlp3DItdOlXC7ABEhNaS9x23GQimPNJQn9hqxi/nYvx2Mwf4nAvYc076End
	LUeh+H29b5OhTIPYO2t3R6LcYcAnfZaMOYqFDiN0jgfBpjNQxZt0SeYPSfPBGnfbc9roZKNUWOb
	UyT4UW9V1JMzkd56oLZZqE+W3E+MA6pISdyjzeAe5wWulKPI5ul2SM7v9Ibq67A+Jwa9zN+wYAX
	7meNCBOWy/o4wZKtKvti1pBzNDqYt6Yr+mt8KYYoXqRS1CneWvLahwjm12viAE4jVc6R7LKWoaD
	hyRQw2yYObd2v8RBLRC/dLgra+xPZMDM/xL2f1JQ6o3IGslKMiKT9wAZ1pQAMqiQRVESinZ3QuG
	tqRYJI0FmMnyZXzU4hXH1uke4b4q5ejJ/p4CuHA==
X-Google-Smtp-Source: AGHT+IHVaXV9q1/g3bfVZTOIUWaYAAdnUAw+rE/fgRBDKnHHDj1/DxZByJn2xG4v2ktw08xsfrlTOw==
X-Received: by 2002:a05:620a:24d6:b0:7ca:f40b:f44b with SMTP id af79cd13be357-7d3bc48bf32mr17454185a.50.1749749207028;
        Thu, 12 Jun 2025 10:26:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eaca67sm63213985a.59.2025.06.12.10.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 10:26:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uPlhN-00000004kAV-2fRR;
	Thu, 12 Jun 2025 14:26:45 -0300
Date: Thu, 12 Jun 2025 14:26:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Message-ID: <20250612172645.GA1011960@ziepe.ca>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Jun 12, 2025 at 08:05:37AM +0000, Tian, Kevin wrote:
> The initial v5 patch [1] from Nicolin was similar to what this
> patch does. Jason explained [2] why it's unsafe to destroy "userspace
> created" objects behind the scene. And a general rule in iommufd is
> to not take long term references on kernel owned objects.
> 
> [1] https://lore.kernel.org/all/53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com/
> [2] https://lore.kernel.org/all/20241029184801.GW6956@nvidia.com/

Yes, we have a problem here where we both can't let VFIO go away while
the vdevice is present nor can we let the vdevice be fully deleted.

At that point it wasn't such a big deal, but the new stuff seems to
make vdevice more complicated that it cannot out live the idevice.

Probably the answer is to tombstone the vdevice in the xarray so the
ID is still there and userspace can still destroy it while destroying
everything linked to it?

Jason
