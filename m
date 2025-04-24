Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C2E1A3BA1
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501883; cv=none; b=hPDNF7j4E83JOR+fgxuBmBuVWgG5vKaXcbdbKh0qSGlHMgcDEk4gsufZuTJLOQnxcnzEyhOJi0X1IaGlYxuNI2YQMAvOWnlZoizsxMXz070vWA5g3uTJzeYectL6POHbY4zFZszq8imdIEupTGcHE9usCEIHJNCMsres8dn4nlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501883; c=relaxed/simple;
	bh=D/eBCecqGJOsPMhoyOTAom8n4mwMCJ8cEqE7fC+WqRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdzet4XxgNMLRd7R+UFSx58ENO0/nXHq/uNqnXZIiZlJ42NHI0OPPtBisN73Gq5DlHoaQ23EN90I66r9msWRudBUUBDxut475gZ0eI97nf+XfhiPr9Ats2MWp1tUP7cHCHNF8PHW4amkNJss6QAxcW0mc3SZlIQC9Qk9UPtyNKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cRKI84VO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cRKI84VO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8f6970326so11675136d6.0
        for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745501880; x=1746106680; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/W3GC3oatAl2njW4tqC6hVInIU5fJ/grm/o1CEX900=;
        b=cRKI84VOXjZOHuPiNhR+AQpsmAg9SpX+b7gRG4grYDXmHiZhGAWbkai5pW00FfSV5T
         cAH6ghPD8qVZSYAx0WKn7YPALOzIFJpXjwUTuHC4x0zz8T2MW3VsSKxT3i9j7PiOYeBQ
         JveENn8lwSw2M9O98Bwn8VIlOiiVPUFeaYt84Ptem4jgT5/K0UqyUJPjxSQGCS4Yn8QY
         3x8OiqTraqPbNUPnRayZ+kyd07lDuiapANpm8mys48UcMjIkTJ6lbBnwNyeLFhtiUqlU
         6+49U7VqRSLZl+WMkn+7/RITOdvkrNMRnqKzLf1Vh9dx5HJn3F2+3j7JKwBtiledg8Iq
         hiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745501880; x=1746106680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/W3GC3oatAl2njW4tqC6hVInIU5fJ/grm/o1CEX900=;
        b=HZlNLcuLm4g6BaguTH0pET+SfNGz0NlGnrubZW+BIYDQ0C2cG9LmFKtlQE0dYbIhjS
         ksSWR5mXl0A1c+i/dqhihREfXioL8KSH9nq74rOcp/pq5Y+StwblEOXLmjNe8u2+AfGp
         Esp1FXqyzs/1LT6UP8WHN1pwbqkQ9P8+fn58vgybXeoQ8mAzafAFGZSPHglXRFP1ZFFu
         iNehpzP4/XySA5T4M5Ejl4fKCne1sDTBC71uN0BBljXtKTHy4i5OMpL8XQS417kbG8uh
         Nul+vvh+t+rI3ZrO6rz0aXSLPDx2zBPO3LdkUiifU591V0gs3kvVgudsHHb3zchiY9F1
         8hsg==
X-Forwarded-Encrypted: i=1; AJvYcCUpDhd3uw5M1HnT1UEwYRlhDpZiTZXtQfXkHkH7dpD0ps34YHg2XyaaZXDnbjqTSpgYmNZmgw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8R+lRFT1dWdalmIkVG8x7xCKp/oAMpcffrJBMQFEaxCztaKQX
	898b5cg4Tza6n/OJg4QtQRSZtAGx51zijcBnGU6wiHkE1hLfAx1k6qkWt1rZz70=
X-Gm-Gg: ASbGncsB/tjygNXNGGdJCoMGLrfbhBGMlgjJu268BF/oYxneAItaHZAATTv+NTTe0/C
	n1p6PCEGBONhfiG9lubA49d8G9vg6b95BzkCccyR7FRyI9KbI2RYgh8roNy1QvCUgycK1JmeYZL
	JycmUB1pB+smBAkH27BE9h4myf90kd7SkXjvuTofSmR0d8g+Qrf/YMX2T/IMVyMKPNHGi1FS+yW
	v+jtJoP07cYN/yVelQyiBOH/Lub2HDENl2ojrxUzUFD00cs3By3M35kl1RlU+/j0lYUCD7EPKfx
	ytwYCNYvg9/KKUnFZkMvnqSLfBpOMEK8LMYB6oOXk3sb3fMVfE4XBD4fdMSnooxZTHPh4/v6Pi1
	stwSZ7YgwaUfd1K4fY44=
X-Google-Smtp-Source: AGHT+IE64NqIpTP8d6nXJqLNWT3jPXbllYrtohUGLpe1Dgn/vUIkQeRm20MtXG4dpykW621IkSP7/A==
X-Received: by 2002:a05:6214:2aae:b0:6e6:6599:edf6 with SMTP id 6a1803df08f44-6f4bfc742a1mr45162376d6.34.1745501880600;
        Thu, 24 Apr 2025 06:38:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c093452fsm9500826d6.44.2025.04.24.06.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 06:38:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7wm7-00000007UU5-2Apr;
	Thu, 24 Apr 2025 10:37:59 -0300
Date: Thu, 24 Apr 2025 10:37:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iommu/vt-d: Simplify domain_attach_iommu()
Message-ID: <20250424133759.GA1213339@ziepe.ca>
References: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
 <20250423031020.2189546-4-baolu.lu@linux.intel.com>
 <BN9PR11MB527619613B8615A94A01FF598C852@BN9PR11MB5276.namprd11.prod.outlook.com>
 <42e8c668-e72d-490a-8a5e-8e94af90fda4@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e8c668-e72d-490a-8a5e-8e94af90fda4@linux.intel.com>

On Thu, Apr 24, 2025 at 05:22:48PM +0800, Baolu Lu wrote:

> > > -err_clear:
> > > -	ida_free(&iommu->domain_ida, info->did);
> > > -err_unlock:
> > > -	kfree(info);
> > > -	return ret;
> > > +	return xa_err(xa_store(&domain->iommu_array, iommu->seq_id,
> > > +			       no_free_ptr(info), GFP_KERNEL));
> > >   }
> > 
> > no_free_ptr() should be used before successful return. Here xa_store()
> > could return error but at that point no auto free as no_free_ptr() already
> > changes 'info' to NULL. then memory leak.
>
> Hmm, I've considered this. My thought was that xa_store() failure only
> occurs due to the system running out of memory, and the Linux kernel
> can't recover from it. In that case, the system is already broken;
> hence, handling the failure case here doesn't make things better.

That's not the kernel pattern, you are supposed to unwind correctly in
those failures

I think you should not use cleanup.h for something complicated like
this..

Jason
