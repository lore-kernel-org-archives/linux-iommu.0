Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B8251785
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199343; cv=none; b=IqPWgFqlADIWsyYWlQ81fuyVGPLIsxf4qFVSPcwo9Y6OTLjkLoykWZ7T2tzGRSs2Qg+fSlx9D+J7+gKEOT37YzCfZ+w476qL+CLUTDHk8r1d2Tul/SCqubm4j+JlLK95Sxen8XS7EBf2ycf3Cd3h8QwLHle59miVGlskBG7tIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199343; c=relaxed/simple;
	bh=m+xkMwoySrd0uSVjVDdxdBcJZDoeadqoxer/R/dsQu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/8NywYHzPvF9zcYiNF2rm4aC7mCc6+f/w/piNlc8RGjQi6t0d6NYTsLIGIZOHC0paBHgZFYck1LK6STXn0mC4i2lXyXRP4kQJIwpQ0QO1f8wHGkI5pKAMFNriPXI61WrvL2u45CUov6NcG2sEMBwLcJ3BucXHBunHN+AVhYu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zx6E03j6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zx6E03j6"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3d1664ed5so256632785a.2
        for <iommu@lists.linux.dev>; Wed, 05 Mar 2025 10:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741199340; x=1741804140; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qytsi8AsRvyusqMe3jOhTvgsVPTM08UZ5Jj8wi8LUdo=;
        b=Zx6E03j6oFUADR7JNP5fmnVvWy9oGLhnHCMmYf0eveD1Z/q5rHx55cB1ve/Os/VO6T
         1BFQrf4hBdqZwKK5wApNbc7xX1qTe/Myv0BWpoICu0NboK9jLzW9YNTxXud/xYn4tUnj
         Sg96N0xeQeX9yf0Rv6N1kLgS2seIUtWx7PrBYBHca7LkNkYoT+vDpbCWnjZITTFezo2w
         za+ZzgEJqZuvQCcthcQHEWGcwnx67RjZ/bFVcpKcxEfXz6rbv4JnzUSrUFpEYZxeeyL6
         BMdh2o5HRMHxzxnEb9AUGzV6NuDvpZIUO2L8G9pWpsBkF8vRrTqV0GbsC9LXld7R6EIl
         5Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741199340; x=1741804140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qytsi8AsRvyusqMe3jOhTvgsVPTM08UZ5Jj8wi8LUdo=;
        b=p8KLtIVP6xWYAH+2nW+t+hXSz2rXw3iZyC9MblSG+0b87berlQy3+tDzKfMzKNa/Y+
         vXyY9Bvp5308ooJiYrNrCwpHcKjn7KZIH76pxCuLvuWCXU2ZIYzhXI1Njjm/Z5c9DRzd
         wCHFlSOkT5cSyQyZm4fdLAuAyUjV8wQI2736JUf58+fmS176H1VL+ARl1A8JIpQTNPnt
         LJMfRhge4nhw2Wg6z8bD4jQkdFKRgE5oF1meg1QAh3rKhatVaIY+DFC9anbFB0UI4y60
         51JPQSp1FRKuCRIPUDAS7RhPMRLAC7yBbz+d82WqxzLOl0bXJbETlfFifejnKDPXMAKg
         zgtg==
X-Forwarded-Encrypted: i=1; AJvYcCUHREIab+3YfNAPFDoo6+KIdXxHpPJHzyuCRUuZbKqdC0GnJ1cgs5QM3SHDgLdhWcMHpewlag==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnzOqkzfjjNPDIQk4YpYPlQv/klW3CA1FJhf97vuzFHpjxiQgD
	NslOF34eA45St3h1aDwe3T2oj4ZKG7vKjG4iLLYatoDcKYOcdmZCUdFuJRrMVI4=
X-Gm-Gg: ASbGncs4dms+G0CmIpQHpM4bN9vxYuCIFEYqjSI5VuZ/ORlF8VsqlzgSg01okHrf3oH
	PkXLkTugOu+En9BwSzvGIIu9lPPAP+e1P6/ioK+IDX/HnmA9Nn2/2U3ZXrNH2n2J4ersCB9BFVf
	K3TSOJitz/m7gxzbDWaRV942Teeivc4WdvXAoaDt6KuChjhyA19dpXpmA+xPnItG0ACPz+RoTxY
	vrJRw3tah932DdcRvWALbKnolNUnl9W7tsIqgATPPn+5mqVf2qa9R4xxM9qr3MrA0/O4edjlp4L
	Yd7ImIrFa3C/+QaHTKc=
X-Google-Smtp-Source: AGHT+IFWMmT9cW2Ut5DYuDUpvyIFOmmiZcEpt4WPetA8yQdQkDPqbKkYQiVXDZwiZSFr/BdwTkrEVw==
X-Received: by 2002:a05:620a:8806:b0:7c3:bcb2:f440 with SMTP id af79cd13be357-7c3d8e703f8mr618694385a.33.1741199340112;
        Wed, 05 Mar 2025 10:29:00 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e90b8853sm44121231cf.65.2025.03.05.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:28:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tptUI-00000001UBj-3ss3;
	Wed, 05 Mar 2025 14:28:58 -0400
Date: Wed, 5 Mar 2025 14:28:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <20250305182858.GK5011@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>

On Fri, Feb 28, 2025 at 03:46:33PM +0000, Robin Murphy wrote:
> +	if (!dev->driver && dev->bus->dma_configure) {
> +		mutex_unlock(&iommu_probe_device_lock);
> +		dev->bus->dma_configure(dev);
> +		mutex_lock(&iommu_probe_device_lock);
> +	}

I think it would be very nice to get rid of the lock/unlock.. It makes
me nervous that we continue on assuming dev->iommu was freshly
allocated..

 setup the dev->iommu partially, then drop the lock.

There is only one other caller in:

static int really_probe(struct device *dev, const struct device_driver *drv)
{
	if (dev->bus->dma_configure) {
		ret = dev->bus->dma_configure(dev);
		if (ret)
			goto pinctrl_bind_failed;
	}

Is it feasible to make it so the caller has to hold the
iommu_probe_device_lock prior to calling the op?

That would require moving the locking inside of_dma_configure to less
inside, and using a new iommu_probe_device() wrapper.

However, if you plan to turn this inside out soonish then it would not
be worth the bother.

Anyhow:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
