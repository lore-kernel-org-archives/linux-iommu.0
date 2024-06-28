Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E61DA3D
	for <iommu@lists.linux.dev>; Sat, 29 Jun 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623517; cv=none; b=hfx3PxgxGzq30NgkfcpWWx8Ldf9de2SOKB8f6dF2iKeXvcCdFoz4GoMXL+zhLSgTDWhEyL6gzzec0MUve7Eovo6qcb/3QS6f7Ophc2xbiAVyo4B/TA0fJIAG/caTgHgqqWXs4zLalXWyt8PqPIGbxQhQOGaBZi96U7+SS06gUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623517; c=relaxed/simple;
	bh=owo+cNn/TUw6Wew2s0YPnRqOgIVxnweK7ckD+KeIf3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyMH7UIatXB0wUrMevEqWyDJCgvi6f10Jzj5+g++Q758iH6snWlZD2pHzpKehn3OHkSUDz3Id6BEUxvISpHFidj5Xr+SlDubzXH8BNdAJGvcWBVtlgasty1oBzZ7vx6OmqupXehQQmpbkyNqMa76uDsAXEJltt6jhZQ55xiGqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lMy8gJGB; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lMy8gJGB"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3737dc4a669so5098785ab.0
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623515; x=1720228315; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rdZPgDV7aIl0J73xlRHxxXH5BwM06TOu62VfOoYuq0w=;
        b=lMy8gJGBRUvHI59MQTHomLpHCZnidG+TieLKIjcENThv0beoKpOVoFPLIyVh0oPNjd
         nyA64ESk6v606pUaeTukRjQVVvGtT++SgmPEXfHMWhF6C4sNC0pSoa2x/ZLBRM6psMKL
         UNj9W8SCKRUPzcG8FEYIV3UxZDgdF+8zW26RUU3/g78WjNWHMUMrj3XMGozvYBUAK6xr
         AIuhACerI0BiQH56kS4ZlkzyLkr29I3qrg99qK5OmQ1hUMH2BksUqQAQQ5QrfPEjKXc1
         K9WS0nkJeWBHKmNHJ6WCOo8ORmJCVZdwFSoDzif7ylFKwJ9yG2CqLbay58ZN9RpxlPpz
         neuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623515; x=1720228315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdZPgDV7aIl0J73xlRHxxXH5BwM06TOu62VfOoYuq0w=;
        b=LnHUvw4knU3UNh0yT+MYqPdFmyf6ISHK/Ug0uIYV+HSRZjilYSZbKa/NpLfkpZDUyq
         TWWtW+nf2Btzh5IE+9Zl3EYVMoBbiLbZqRb5LaQgBGq6w6EGeeKg7SUU6tAZSV7igkJx
         y3oLvMSESy9dU7se7DLzmNBQI3x9TPTnIwfKt/jJQwR1d7E7Yi6Nl9raHidMNCHu3SRF
         X5ziUJ/4PQIk4VyVpZ21VK8JDj9qZpcrQFOFZ048cC03/s2qUz/sr4hL9ssrxgmdhLC2
         qrFX5BdGuP4x4/N2r1i2fNl2Vd5MbzazW+XgiKDEYnCXh8k/CwqC+ST7+cSng5lL9xFA
         bdog==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0Xns4ij7oux1SlMB9bN3OGXUtAiRAKDzYNdj9tYQZxXO1//hDDeMhT+JYRXkzcBxArKE8tYAgc+cpFklV14ZgEGl788=
X-Gm-Message-State: AOJu0YxFHayvJm24p6SbmWI62hVUQqSpDd5do+++MedFaRF3Fi/dpKl8
	lf7GSJOnQhn4AhdNyqnx5IK3yhF4/edLc9mGi5ebXeqVJ5tzg+YHH6V3CSTDk3g=
X-Google-Smtp-Source: AGHT+IHX2JUaclIoPrHTyWd3NWpAL4bg4r61iFuy9mfBP9il15TCI+aZkWxWAJEJRM9M8Gi0RE+u5w==
X-Received: by 2002:a92:c24d:0:b0:374:97b4:dbd1 with SMTP id e9e14a558f8ab-3763f633817mr217872295ab.18.1719623515458;
        Fri, 28 Jun 2024 18:11:55 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:54 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNJr9-0004o0-Ot;
	Fri, 28 Jun 2024 19:14:11 -0300
Date: Fri, 28 Jun 2024 19:14:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/10] iommufd: Add iommufd fault object
Message-ID: <Zn81szS0G27keAwB@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-7-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:51PM +0800, Lu Baolu wrote:
> @@ -6,6 +6,7 @@ iommufd-y := \
>  	ioas.o \
>  	main.o \
>  	pages.o \
> +	fault.o \
>  	vfio_compat.o

Keep sorted

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
