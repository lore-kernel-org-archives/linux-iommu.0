Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B855B152E0F
	for <iommu@lists.linux.dev>; Mon, 29 Jan 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540256; cv=none; b=tpl9M1ZQ9ZfYeIDK+Qpl43sLWc4oARtufmr3H0n9rub/JiwTZXa81IfHzxYieq0KOXFRrEnk0/QM5Msd7LkRSv4ZVshUxoDPs5pF2St3A8nbYB8FI/u4PuoTOYzqXpweTU0KNTB7fWkAiV6TbVH4Hixe4zxrEeUNuTvkBGvpTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540256; c=relaxed/simple;
	bh=YHpJANTxleXUQc7Etefu3WOAFvTm2NiP/au00SDkl2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVBqANrmaWGaaI5OLYr0iSbgmEKTUFXd545hYlcraprMqJCsISKANQS0Y0DgQN40C7Q8j4whFF3ck1krlxg2aJpUXzhPm698EopVLSi6djLyOdJ6okU6ZTwENK2MEPLIMYL74OGiDL/Hya2A14G7iVHMI2xqm0V38Rx24glAMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=njgsyWvp; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="njgsyWvp"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e11cd97960so890641a34.0
        for <iommu@lists.linux.dev>; Mon, 29 Jan 2024 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706540253; x=1707145053; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVF4k3bK1tmVpRSxaU3/SMcZMqTGWrDu+a1szTYxZBs=;
        b=njgsyWvpwaq2X00H+Y1v5GNxpKVb4cQQXRn71/KSmgoxBRx+3PNyLVpz6wjyDZWm6n
         CL6xnk9faqISC/ED/wQvDuGCTi1m0+AicXH7d25RzDX+laulKK5C3HwQ+9rfZ0oACTYU
         FV6VqVrkM7d6ltJzetfgSVnaAQiotkNNBF0Tcp/f3FvPzgImS33bB1I++M0JgTI4awsH
         99tyIgQ9S9GG+Me6zwpB90DWPRWI5de6fqzpR+CbBWCm0W+uRjDneYah9M8i59k193m6
         9ccQwQhRBsblGAiWNNL8kQsMGLPyMIJI6Yk9bOuSCiiGzp91e1IS4jN9beerrsRnh4C0
         Fapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540254; x=1707145054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVF4k3bK1tmVpRSxaU3/SMcZMqTGWrDu+a1szTYxZBs=;
        b=TN3owObxRf/kt1/LjMptJ7GC8CJu5+H/d7jv/eIzurxs6D9/7WIvG8+MoHl4de0b1G
         kAA0T//iM8MsI0Pt8DY8QG+DdqOoog+k0KMfR8NwFJFQAm6NCWYgG9jcGX1ffLTv+XdZ
         pcJ4FBvzgmVuD35Q9xnTRlvRjssU52X3klXrn02UNxYCDs2nQ6dES6PyCxgq5dGN3v1y
         PwPmqU6MHuBXsztCKPjdOAADC67hRtx/n1Dodd8G1LDQ3D7otHVYBeW4Kv4UACEa+mnI
         /4x5PNCiEiAUIBt5GIjkdvHwvVAkIKsD1c0Sueq/ARQE/WQvAU7tYCXmUcCfVpJw1N74
         Sibw==
X-Gm-Message-State: AOJu0Yx40+xLk+18AzyTvkeneJicsoUBrrexuYBkRqLZoxL7Uh0gP8GP
	FkV94aU4lNDBUfzOnm4+EvY6fHPf36CWzyBnB4Xkim0njUUijUErH+dxfAf9i+8=
X-Google-Smtp-Source: AGHT+IHM0UgiqzxE42+B8o1wd1JtnMkZnMEzc9DwbMI9lJHOkViPkWLsfI2IUYUXYItE3p/l6Rn1Ag==
X-Received: by 2002:a05:6870:d287:b0:210:a68b:7066 with SMTP id d7-20020a056870d28700b00210a68b7066mr4254363oae.43.1706540253754;
        Mon, 29 Jan 2024 06:57:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ry11-20020a056871208b00b002149bb5d09asm2064275oab.56.2024.01.29.06.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:57:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rUT4l-00A9ie-VM;
	Mon, 29 Jan 2024 10:57:31 -0400
Date: Mon, 29 Jan 2024 10:57:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iommu: Use mutex instead of spinlock for
 iommu_device_list
Message-ID: <20240129145731.GD50608@ziepe.ca>
References: <20240126105341.78086-1-baolu.lu@linux.intel.com>
 <20240126105341.78086-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E9618612DCF4DAE0CAE68C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E9618612DCF4DAE0CAE68C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, Jan 29, 2024 at 08:04:35AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Friday, January 26, 2024 6:54 PM
> > 
> > The iommu_device_lock spinlock was used to protect the iommu device
> > list. However, there is no requirement to access the iommu device
> > list in interrupt context. Therefore, a mutex is sufficient.
> 
> I don't think that interrupt is the reason for spinlock otherwise
> spin_lock_irqsave() should be used instead.

Right, there is no touch of this from an interrupt

I suspect it is following the the general kernel wisdom that a
spinlock is better if the critical sections are very small.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
