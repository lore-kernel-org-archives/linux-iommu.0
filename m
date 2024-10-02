Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B501D04A8
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879015; cv=none; b=GA3B3WjFgB8dkp1STeXICkR8IQ9N3LDeanLjMF5tKz1iBj5C3M+qlprCXCLCLZG9o37wRoH44eC03dlc6VAeDP/JgGr1GdZZBJAmTXxE2PzOZsoadVN4HmK3h5IABQ8X+Noer3KWB058ucQ6S8j/jxTgfbOCm5kIdYwyFsvP8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879015; c=relaxed/simple;
	bh=5iOjjDGJbSB0ND8/Lb2DpmvwPmKPyJlfdUJ7Aw+QDss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC5Wv+nInncN+d9zLVvFKTlW3h/dplHN/QVDNRb7zRYoR/DNMyh6W0tMBdkTVGnHG2KJvoCPgDFrUnc4y/XzOes65dyHaLfBOnezeoC6E+0FJkaPGoc5Qh8sf8TFUz72a8niTTMETN0wOwdZceU7kC/ZWwMUmilV207gqv31SIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QnXsMco7; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QnXsMco7"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e1b72fc5f3so3486993eaf.2
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727879012; x=1728483812; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FeQBlHJO+xNA/cG1ZbtAdytxRVst5Nwj1AyuYPZMQDA=;
        b=QnXsMco7K7nwRh7LXeVTwM2U8sH34ps5Q4PvIHm+Usyd1sdm2xc96qFpWoyNWaHDni
         nael4kc3fiGnb/Q0oPovRQ6W8EcQe44TqBIP93q8sPI7LFlK4wbOFUo6KWDiUzLCwrJd
         2+LyUUNXADQUw6P4D0owvspaFiBWSweGHOZaGTk/ywuFDmO3Ij8LoYt3MfKWomyPqFNd
         6PBodmSI/CgZlWZKFJb4zlgfU2lg+z8w8WYqKf3fyYpYWYsq1siZpRhJ+23/jCjN6Xee
         Cp9iitY8ARlTxyQBVher3cTCr0UBSo3HNJlwrNWw5CvSPyOqScmofH1qWtXRIOtahgJw
         JVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879012; x=1728483812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeQBlHJO+xNA/cG1ZbtAdytxRVst5Nwj1AyuYPZMQDA=;
        b=IkIODGfa+zEgGdVmPGFMDJDMqE74mVVuKmKY3hhPrEr94D7mY1n11NHNTT2JZ2uiaA
         2TKZu38snGCUDGeoxENEeGBR8LRGjaNr4w4hT5la+FLMh+JZC83Ov7+fI2evY53WMH+Q
         4TPjt5qtMvGJykcXBEhHivFafgdBWZWollKbwqnwx8BW8fEC4sfzfUmCCcgtNWCa41VN
         32/60/hTf1NCsnh+s1I44SqayJlyOBQlJGoENG9gVSORH6Jc6o7rPFcIQ5leUPUOVSY0
         7b4Nf8CnmuL8wzBblwro+ZUWR1jsIJAkoTE1gE8Vzcsg2FAj3XSenjmZk5rUUSl1y9hc
         6BAg==
X-Forwarded-Encrypted: i=1; AJvYcCW8hlG4SY2de919dJFcuRopF72lwQJxOm+TgM8vZHf63v5Em1J9Su0Dej5wcYGxLM2vGmQ4Kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQC+IXnAznr92iV7FcyVqvRFOnT9YMVsdmGcP6FKM5dEQ/bIr0
	NU/hUpr9r+bOwLz9yfeYPI6Rlg4iLOL3ZA7U9KMZmP3dI8+R8uYOlPmdiVxPPTc=
X-Google-Smtp-Source: AGHT+IGWJ1+QLfLfdYLR2FAHS/JGQV96Av2rARN80IWmS/Tx+iHGWXWK9IQKo67mwAgdOxf6r6MxVA==
X-Received: by 2002:a05:6358:430d:b0:1bc:45bc:81f0 with SMTP id e5c5f4694b2df-1c0ced2b5e2mr237306655d.11.1727879012391;
        Wed, 02 Oct 2024 07:23:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b68311dsm61858266d6.122.2024.10.02.07.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:23:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw0GJ-009ZSn-Gi;
	Wed, 02 Oct 2024 11:23:31 -0300
Date: Wed, 2 Oct 2024 11:23:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	kevin.tian@intel.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID
 capable domain
Message-ID: <20241002142331.GG1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-4-vasant.hegde@amd.com>
 <a3e09a90-0b63-4332-9e25-a5832d5ec8b2@linux.intel.com>
 <dc29a3e4-04ba-4bfe-b06b-67c4d5bdb5a1@amd.com>
 <c6a29fc4-f08d-4601-a0f2-ef1b5d26a87a@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a29fc4-f08d-4601-a0f2-ef1b5d26a87a@amd.com>

On Thu, Sep 26, 2024 at 04:31:52PM +0530, Vasant Hegde wrote:
> >> Previously, the default domain was allocated by domain_alloc_paging or
> >> domain_alloc. Now, it will be allocated through domain_alloc_user,
> >> which, based on my understanding, is intended for user domain
> >> allocation.
> > 
> > Right. This was discussed in during v1 [1] and Jason suggested to rename this
> > API to domain_alloc_paging_extended() after everything settles.
> 
> Sorry. Missed to add the link
> 
> [1] https://lore.kernel.org/linux-iommu/20240821163147.GZ3468552@ziepe.ca/

Yeah, I think this is the right way to go. We just misnamed the _user
op, lets correct it.

We end up with a simple op that most drivers use and then the more
complex op that iommufd capable drivers will implement.

We work to merge things so drivers only implement one of the two ops.

Jason
