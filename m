Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7952E7C6C4
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809426; cv=none; b=DHpGQu+NO9Sr0kAyIM/hRDTw1zdBnyYspIBwY4P7ZgufDK0n5OkNz1EdBLrAX7BtWD5d8Pa2fXYjz8MRzwTn3v0vTvJN6QBPxl9e9fDQdo2BfxyfRUzsFBCz8RZ4j0Hgell0sd6qNQoA+QuNVMN9YZ5HjooOLkit3ncIkidUVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809426; c=relaxed/simple;
	bh=7Ax3aP6K0VrT1fv35JnIH4PZDxeQSm/pQ33DcnoEYHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTx/5qaKusYgHp03znlB6JtiMyA6lAM/IlTC7pv4tOSziKCxBqFQDg7AuVxpKUQRMgIj3lJ0cNUEJE4zWhFzl2LpJw3vShKVEjfVF5UVOTN5o/Ab2jnsmyJ2u493xDUb1hXxF8C+4wIaUWd2noWcMs7WEOm8aqbdm16UxYrkwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ciNZnZ5V; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ciNZnZ5V"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42bfd27f586so2297801cf.0
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 09:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706809423; x=1707414223; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGobVVGs09BVeCSm1oDynqhuSevjC6eHwJxXXnCexLY=;
        b=ciNZnZ5V/wc7cSWRHalFv8vCPfU9ZwYhPHemMSuhDpR6eCJe6ZCTd6kVYsxAnTsAJ5
         N4eEJ4KWBGpywdPnuHpRVVnA7iJ5yVqJ51PCjsMpQ7DRrmFIIaD02aMT7w/aofa/skcL
         oyZvWyI+bcGsJYMvmNVbneluxB4cUxKw2VbxWBixiTmHK3CWZFoQwyGWmObQvv5FKw7R
         NVnaPR0wZQqfNzDLH7jhhYDtkYB0b9Lwj3YtlfSP7xVlcVLk1pkxtBAsGtsJ98r9/G+S
         Yp4b7OJSOJ3nYm5ZergSib8rXxSIHyKvFSJ4jxYG9zFeEG3NCxZtuAEDM/WU0xGHO9n9
         71DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706809423; x=1707414223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGobVVGs09BVeCSm1oDynqhuSevjC6eHwJxXXnCexLY=;
        b=q8omgBSJlNrKNWmzUcBO44CoPSBOf201drXbGq17wNVgWzj7LNCZoqWSCiSqIqI0cS
         3VwQUJClGtf1ie3PFDia7cwoSnhuvHi53YRIh3V1Yf4TCnO2632TiwVrrkq7+2/or+C6
         49upJ1QNECGbcYkj+4tJ4HbYD9BRC6SRU/5t9tL2KrHontJZ1e/Erw26zO5etaQGH/e3
         StT7zbGikWBmAngC2PPrt/kfIEYwkEk734B3iAOS+s/JYTSeBLvOuoaXngwfke021vcl
         uEAwjGMSiGRhitKC8bqDWkJlIAkP6TRngrYicxwTT9JFAjqyLdkteoXNwcF/una3naFX
         IPYg==
X-Gm-Message-State: AOJu0YyLwQ2pmJFiZl0kqXCf6cBnExtk7qZlNQavZBPafmn8Ft7qwQTP
	7ErLEt4NXquG11R1wSxd9CyU3pJ3C1eT1GwDIH3srLFwUIiyrxrX2Q6YAcxfOYBgtrdn10uz4vC
	W
X-Google-Smtp-Source: AGHT+IHWQYgu5uWqc0TWYC3oGdp3426gd2ANJGp1IqL+GyKaj3cOFsXjGy23WGsf3TaWWFyFvKyRYg==
X-Received: by 2002:ac8:574a:0:b0:42b:f341:f8aa with SMTP id 10-20020ac8574a000000b0042bf341f8aamr3226450qtx.21.1706809423122;
        Thu, 01 Feb 2024 09:43:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUEF4DCyIE4QYo/7s1MRDZpELXmaolPsKUTvpAOruG6en/VXAr6VlcU7UOtRaqtf/k3/OELxMIJjMCRMeDHQaHM/NJi/q+BRQysdngDgJmOcIOInuGeL6UfoiLB3yaHaw86Gobw5Tmn6cQ6qSvWWPKa3wzwxYK4R9lJ5TV9h6iJ5IbiKU1PZr0=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id qp16-20020a05620a389000b00783e70cf38asm2175qkn.130.2024.02.01.09.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:43:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVb6E-00AnIt-6p;
	Thu, 01 Feb 2024 13:43:42 -0400
Date: Thu, 1 Feb 2024 13:43:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 11/17] iommu/amd: Refactor attaching / detaching
 device functions
Message-ID: <20240201174342.GM50608@ziepe.ca>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
 <20240125121135.8217-12-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125121135.8217-12-vasant.hegde@amd.com>

On Thu, Jan 25, 2024 at 12:11:29PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> If default domain is configured with V2 page table then setup default GCR3
> with domain GCR3 pointer. So that all devices in the domain uses same page
> table for translation. Also return page table setup status from do_attach()
> function.

"default domain" is a bit confusing, perhaps:

If a paging domain is configured with the V2 page table then install
it into a per-device GCR3 table instead of a per-domain GCR3 table.

This is preparation for moving the domain ID to be per-GCR3 table
instead of per-domain.

Otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
