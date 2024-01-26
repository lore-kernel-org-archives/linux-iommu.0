Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E331C695
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283490; cv=none; b=jeIomVq+6dy+lamSQYKBJsfwYBy1/xMBjr4WI1TtUrVuYsy60gSGOcnI3SQuUtGikKZR8/aSE1B0yzlhyzzCwbygxlWdii2yEL2+nCqY+VuaIEBBBvSjw0zrdRIYeGZ84zXmr1XreANSL3YDvLyjV0La3QRko29BhIPuwo1jGwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283490; c=relaxed/simple;
	bh=NE4Sjf8Dg7SqoLejQ6feujTkrFV2RmwRB6VtZjUDVtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeSfS8s6oFi1TlPB2NLg9faaMYNybADGS1RNssJ567ZJdW0VK35NVmw28MN3AdYL4UtNAvv/m0ikzPUvI8h0xMTPCC95Qi8iL1/4Blk6kzgbtxeZB2uSZfwsyq13JpJNWR7VLA1oieammp//YDcGoi9lup/9H8lF5IDn2mFOIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ey0ZKIsG; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ey0ZKIsG"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bded20a30eso343563b6e.2
        for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 07:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706283488; x=1706888288; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHXnx8afQv16BuE8CvDhlcpu6wVrXL3+T1JQxNtzp2I=;
        b=ey0ZKIsGIj7zK5D34v2+ud8gzVwf5+t5XM0JWKzc/faxroaI6NP4cK3GXBlf+miFKP
         T6ZZH3fgicUiLOWS6Tk8GYuIQVIyDu5o6ikaJQg+beO+CAQ1xUOgfYnbydU/sY9XJMN/
         Bt5nKsjuVjoTe5BvObhRP+5cH77YUBPivs/3I+16S8ARXWC/ezHpOkzeiZZVFnuQM+BW
         Clntt9KboVjK4pTE1xFJVHT4aWgQ7TknJkiU7f+zcu0Elo9D7TGFc5jqstuz/jAAnWow
         XkbGNW+4mIoUY1dQtfxSTeYCGZ2oZrX6mr2cb24GV5tTyTWXGwsSZPeXKET9ARtOSyEq
         oVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283488; x=1706888288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHXnx8afQv16BuE8CvDhlcpu6wVrXL3+T1JQxNtzp2I=;
        b=SvLP68zzX7hsjHSRev1HxSFbJkeZb/OQpO2QFHASsF8V5glUI2rZSrCuVN9w3sJbXX
         4f9Tp+jbCKqlHYlYx8hen+hYcGM7HfZphSONbugRJGLzgEtOXvvWUq7qQ99F04QyD4qP
         HeHdvWbFL4JTfFW37ueN9CPZU7l1plbOymvgiVp7BF8KP7eEMu1p1XUvHYSL/6nCUVqc
         F4AVQs5uJKl5lB41t4/WDA5fzqHEHsOi0YOfEDCCUK+bdETZAi9EnDPCMP340WYlJUlQ
         X8G1SDRltWiZL//VPCL8fycSw/HHAoZibw4V8pSXzvLAUqWq3NMptl53tX4d2iIpsNPE
         Bu9g==
X-Gm-Message-State: AOJu0Yz09FGKat6LpkqoGGhLlzRoao8bxc4cjO7Ed+AZs4FvMxR5gc2f
	yVS8/vB81U6k0fk20nzlU2qE+s9wrWog8kvtcvqmEpBk86hGqxO3EuzwelbNR8Q=
X-Google-Smtp-Source: AGHT+IEVGCeD2tM9LcGFGHmBJ+r7/F8U5I6RxMP8MFLTO92PxPlyG1PzNUzs0fbA+dDD2wknC9vMZg==
X-Received: by 2002:a05:6808:169f:b0:3bd:727f:9624 with SMTP id bb31-20020a056808169f00b003bd727f9624mr1825667oib.2.1706283487883;
        Fri, 26 Jan 2024 07:38:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id u19-20020a056808151300b003be012c9e19sm71884oiw.17.2024.01.26.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:38:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rTOHO-009S9B-F8;
	Fri, 26 Jan 2024 11:38:06 -0400
Date: Fri, 26 Jan 2024 11:38:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>, iommu@lists.linux.dev,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>, npiggin <npiggin@gmail.com>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	aneesh kumar <aneesh.kumar@kernel.org>,
	naveen n rao <naveen.n.rao@linux.ibm.com>, jroedel@suse.de,
	aik@amd.com, bgray@linux.ibm.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	gbatra@linux.vnet.ibm.com, vaibhav@linux.ibm.com
Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group
 release_ownership() call
Message-ID: <20240126153806.GA50608@ziepe.ca>
References: <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <20240125155017.GW50608@ziepe.ca>
 <b825dd04-3d32-4fbd-91e3-523ddf96fc7a@linux.ibm.com>
 <20240126151701.GZ50608@ziepe.ca>
 <392247278.10124607.1706282995795.JavaMail.zimbra@raptorengineeringinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <392247278.10124607.1706282995795.JavaMail.zimbra@raptorengineeringinc.com>

On Fri, Jan 26, 2024 at 09:29:55AM -0600, Timothy Pearson wrote:
> > On Fri, Jan 26, 2024 at 08:43:12PM +0530, Shivaprasad G Bhat wrote:
> >> > Also, is there any chance someone can work on actually fixing this to
> >> > be a proper iommu driver? I think that will become important for power
> >> > to use the common dma_iommu code in the next year...
> >> We are looking into it.
> > 
> > Okay, let me know, I can possibly help make parts of this happen
> > 
> > power is the last still-current architecture to be outside the modern
> > IOMMU and DMA API design and I'm going to start proposing things that
> > will not be efficient on power because of this.
> 
> I can get development resources on this fairly rapidly, including
> testing.  We should figure out the best way forward and how to deal
> with the VFIO side of things, even if that's a rewrite at the end of
> the day the machine-specific codebase isn't *that* large for our two
> target flavors (64-bit PowerNV and 64-bit pSeries).

I have a feeling the way forward is to just start a power driver under
drivers/iommu/ and use kconfig to make the user exclusively select
either the legacy arch or the modern iommu.

Get that working to a level where dma_iommu is happy.

Get iommufd support in the new driver good enough to run your
application.

Just forget about the weird KVM and SPAPR stuff, leave it under the
kconfig of the old code and nobody will run it. Almost nobody already
runs it, apparently.

Remove it in a few years

From what I remember the code under the arch directory is already very
nearly almost an iommu driver. I think someone could fairly quickly
get to something working and using dma_iommu.c. If s390 is any
experience there is some benchmarking and tweaking to get performance
equal to the arch's tweaked dma_iommu copy.

Jason
