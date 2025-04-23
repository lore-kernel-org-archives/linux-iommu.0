Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD71862
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427435; cv=none; b=cVhrl57eIPPap7XmFv3tILSM1n0xtPdsC8F/iJZSIlDAy23U8vzHPU2jX10UgUPNuzDy2EvOIzlIDxGK8y4/qEg2jsk4/ch90+CCrzoDqOFzdajZbyWshyuilTFDKUgqw/y1SjfYHHedxWkImsvqNaTvjv44SRPPVEaG2kHkrDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427435; c=relaxed/simple;
	bh=dhi7YPbJDF5Sv4T9p4l00KsiFYnUvc1VHj5DJ29C/CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2iHUB2rhEGPsFuWNn3WMws/E7Evfi+dEhjYs6Zmhw2otZq1N+FlqNUAOzB5DQ72JSkAjNuDYqbsB+3N0hyM8XSfvtPYhhx9/atJBGorFSMbGlRHPCpHkkhG+Ru2Qm3p6fxdrrtG7rBtRytliJU6cJNyx7l+I0nMdg5sz+6vwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nsMNe8Qq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nsMNe8Qq"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c559b3eb0bso2768185a.1
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745427432; x=1746032232; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dhi7YPbJDF5Sv4T9p4l00KsiFYnUvc1VHj5DJ29C/CM=;
        b=nsMNe8QqwTrqK+cyvG6rzL9jVCTLI6/7qtczVtiBtSP+8bk/YZ0Sf1IsGZZ3eghZu6
         OqSFHy79E+jF27cbEZDwaVnXV5F+vIc4dCd25eJqd8ekG1yhjUXw8w76CqrKGiKD19YX
         K39VG5XoN+S5KLz9O5k5Q0XnunHR44kOT6PUW/LfgTt9lTpFrMSVn4NhGJyJeoYwcqZC
         wtsCSRwuOjGL8cRuYt1f31ctvuGSqDZ2Z4F3QQuZg5jCTeYPIVLx2MF/FSAjf4lxgfFn
         douwcP0IELQLDwDdqOddBRMlKb9i5iFjbNkWn5WaqMxF5q6Js/bsXgIxAqsTpeoW8xQN
         SwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427432; x=1746032232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhi7YPbJDF5Sv4T9p4l00KsiFYnUvc1VHj5DJ29C/CM=;
        b=gaPbReHl8nNqCgvCpgW6AUK0zd2gFFAjJkkuehS51/xPuVJRYlOoP88pSEYqRGbmNG
         N3vsJ3ZmC4sNSqZh4VJI89ZkpVYhP9NWX0knqZsV+ji/ANkQADazessKS1plxqawfGiT
         1OXfDhJg3aJP9WWHdZN/FRYnkZOODuG8N0NxAWb4OqfWj93O4rJWbJY8QrQK6TelidAp
         6X+DIrles0rGuFxM5w/0UQH47sVyn2NFlUm+VJtDtJozpjnq/NDzW2oiPKGDqvoX36WB
         3nHVAzB8FnjRsRLNFIKBQhpXZu7L+ZmX1mDhaYD+7dB6GuRo545QYBJcWeP4KgTur1WC
         Txcw==
X-Forwarded-Encrypted: i=1; AJvYcCVDkJuDjyenBy/w6E2oQFNHUQuorU7xqMfhk2qjYXLMEbiEJ+kRxwMYadW5BgCx6yYfKaWNow==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIusGbpNpkUtrSOw8ZK3S5s+76jjCLH7LP39nmbok3HIIaYaBG
	FDFHLUUjHdH0HEUTLeT2QEHbF66ifj0FN9B/c4jC+jHJTqy4PG0/ZxrM9ZYKFyA=
X-Gm-Gg: ASbGncvX3YTbR5pwFXwDfiDkasH+AEmzPeu8O4Lq7oRhKHHXAkPWvmKWMVxUVZ8QzUk
	tCRH2dqpPglsbvbctWyvPFRQlA8Bn6I+GRcxmoHXuOwCbptIJ2/4Z7Ws4s7JC/rey49I67BULfI
	VY732zm6XvTVA88di8bsReA2lCFo3gnzUyapg43CZKZnkwpSrab3aTiFxeT1g8/TWziFLB4myfv
	nQog21EXAYaicI9B3p0Bk9h4I3DQj73yDJdYjnOcBpG11q0y1QiJC1LsFP/hzPo5yJh1ngsfSve
	9RcPsWspWLrPA68lKrrWvXfF1clfw1pwhoLnTBESqFqCWGi620IojVRQ87VS2pYAjYGjjNLZJMs
	qXsUYWwvPcBbWflRrn7M=
X-Google-Smtp-Source: AGHT+IHShwd058je5yhrBHHtft+FaVd6aPfMpemsnKAJr8/FzC5ID/JRmyyXrev5e81NPUS4BdNFCg==
X-Received: by 2002:a05:620a:45aa:b0:7c5:61bc:70ee with SMTP id af79cd13be357-7c928049582mr3400940685a.52.1745427432602;
        Wed, 23 Apr 2025 09:57:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c937cdb14bsm487301185a.96.2025.04.23.09.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:57:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dPL-00000007LFu-2s3n;
	Wed, 23 Apr 2025 13:57:11 -0300
Date: Wed, 23 Apr 2025 13:57:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Will McVicker <willmcvicker@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
	iommu@lists.linux.dev, Saravana Kannan <saravanak@google.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform: Fix race condition during DMA configure at
 IOMMU probe time
Message-ID: <20250423165711.GG1213339@ziepe.ca>
References: <20250423150823.GA422889@bhelgaas>
 <4129dca9-07fa-4b9d-a7d8-de7561d509e7@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4129dca9-07fa-4b9d-a7d8-de7561d509e7@arm.com>

On Wed, Apr 23, 2025 at 04:50:29PM +0100, Robin Murphy wrote:

> Indeed in my half-written version of this patch I was leaning towards
> removing the drv variable altogether (just doing
> to_x_driver(dev->driver)->driver_managed_dma inline), or at least doing the
> same as Will's previous diff. I figure the one-liner replacing
> "!dev->driver" with "!&drv->driver" would be too disgustingly non-obvious
> for anyone else's tastes...

The READ_ONCE alerts the reader that something weird is going on here :\

> For consistency we should really fix all the buses the same way - sorry for
> the bother (I can write up the other patches if you'd like). FWIW this part
> really was the most temporary stopgap, as my planned next step is to propose
> moving driver_managed_dma and the use_default_domain() call up into the
> driver core and so removing all this bus-level code anyway, hence trying to
> minimise the effort spent churning it. Oh well.

It started out this way but Greg really didn't want it, so this was
the compromise. Perhaps you can convince Greg of the merit.

Jason
