Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D80208D4
	for <iommu@lists.linux.dev>; Tue, 19 Mar 2024 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870867; cv=none; b=FvUgHKhHYM/e62sja4f/0fsMgq0ZYTvqUlD3R3kTJ5M4bNQo/RvwVh+cuG7Yve6zKvzb5gz4N1UjEDj71mM/UfwJdi5FbYTS/5yGxd8g2CSGRzoK9MVUl5naHN7Hp/rlK2DmS2NzY8ZEC7LT9NYRt2Z6FSUWNvTpMR6doo7B2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870867; c=relaxed/simple;
	bh=WgYZaAh/an5kM2/Qd17c2BLNi+637XYmtAq1XWvhQWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGn+rT68rp1lOEXH3xce1gCoZ8c5ZB/EZwx/WwoYJzCxZDfiN5gld2G3+dfjc+5/2+bHgz6jLfqMAhPS1h0ftaBkzvmFoZgMihLF05SEggmj45GYJpPgugfIYIN4N0JPmED+M88o9R7G7zNglgMsqnk9BTo/r2S04+U0CTicJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MP6vvL9K; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MP6vvL9K"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-367d6dbeed2so6336705ab.2
        for <iommu@lists.linux.dev>; Tue, 19 Mar 2024 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1710870865; x=1711475665; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BAs48D+Y1lc4NqcdaLZCa426XdrD2SaO6kILaPcQ53Y=;
        b=MP6vvL9KSohNKl+45rwLZKE6r9QQf9BrwalmNlXA5quRVv5jbCTW2iJtLeGWqUvXQI
         q9glY45NQKP0oVab3C75mWKIpzsxMsqSTZU3w8CS/zEY6XXob3P6K2CPiALnHo+UVegB
         9/yDr0e5EnkQcMWRPXZ/ucM/MBLssfDpbBFXoXo1Vlur3T2N8fzR7AmB6dYWdHFU5b44
         0zXNJqoTyLXxMdMCzRiVbvL1deuZNbwhBc7If4t/19Tjz96jzgVK7MI2BF4a9p8K2TTo
         tqm/5GK6SoAYECXUXewFGIbzJ1uGYV1GF+0qQ9FwZWKTaVYXILSY1SdAcN9uZi1quwxC
         hkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870865; x=1711475665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAs48D+Y1lc4NqcdaLZCa426XdrD2SaO6kILaPcQ53Y=;
        b=wHcM9Vghx0tPsYDRUoMBR9304+quNpA5fqqgS3LWhroP2LAiXg8ZRyTmK5rzfZ29vO
         bzj3NuUPIHhEChbSgyOgbdJFIl86DGMie5INoid7Squcnvx/BS9TfyVY08k20lkkn58K
         jTZyziI77XzpOrfPf1Qowi7Qhp7ZZMx1dijUtGPYlInS8p22sJzV1NOEOJhHHpAO64Um
         4yHVse41cPnVKfXAGJA2jXurCemg/qlywrHCg7x2IrQvAGTURqLAV+wGS1GIlYZ6d0pk
         AwSEAHnipKpzM/7aSzO7Lhozjuoagd5SRBvYlTXw9S7zLMYfcECSsitXOoUsNDE1CqBk
         4Kgw==
X-Gm-Message-State: AOJu0YwPVWnLf1+CgKxeISlLTynckwWGlgz17w/3ng9NsBoc+CNDqnlE
	PdGUrBkz4fD2U81Em3yXyN+YSNq4QQNAp2LtMyETNVt+W6GM6JA+gqBpXNbRLz4=
X-Google-Smtp-Source: AGHT+IH2H/de6WGasPgOKBZZyKNNNt5pIRVXC0bR+NeZhqo5c9CDUTe+REPsKB+OX0BsBFULYqpM6w==
X-Received: by 2002:a05:6e02:12b1:b0:363:812d:d6a3 with SMTP id f17-20020a056e0212b100b00363812dd6a3mr13898574ilr.20.1710870864855;
        Tue, 19 Mar 2024 10:54:24 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id gh11-20020a056638698b00b00477716fcbb8sm2429986jab.40.2024.03.19.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:54:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rmdfJ-001l0s-I3;
	Tue, 19 Mar 2024 14:54:21 -0300
Date: Tue, 19 Mar 2024 14:54:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 11/15] iommu/amd: Add IO page fault notifier handler
Message-ID: <20240319175421.GD66976@ziepe.ca>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-12-vasant.hegde@amd.com>
 <20240305004001.GF9225@ziepe.ca>
 <4007d5e6-c76d-d869-9e0d-5a25251db98f@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4007d5e6-c76d-d869-9e0d-5a25251db98f@amd.com>

On Mon, Mar 11, 2024 at 04:30:14PM +0530, Vasant Hegde wrote:
> >> +	/*
> >> +	 * PASID zero is used for requests from the I/O device without
> >> +	 * a PASID
> >> +	 */
> >> +	dev_data = dev_iommu_priv_get(&pdev->dev);
> >> +	if (event.fault.prm.pasid == 0 ||
> >> +	    event.fault.prm.pasid >= dev_data->max_pasids) {
> >> +		pr_info_ratelimited("Invalid PASID : 0x%x, device : 0x%x\n",
> >> +				    event.fault.prm.pasid, pdev->dev.id);
> >> +		goto out;
> >> +	}
> > 
> > Why even do this check? The core code is perfectly fine to take in a
> > big pasid value, it will not match anything in the xarray and just be
> > completed with error anyhow.
> 
> We just wanted to make sure device/IOMMU can handle PASID or not before passing
> it to iommu_report_device_fault().

If it can't handle PASID then the pasid xarray will be empty and it
will be fine.

Jason
