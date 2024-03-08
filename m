Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3885D900
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930239; cv=none; b=ofj9zn2i16EjTWay7JsXlGHZ+7+8yDYpmYQl0NT6FaG4Vq1PD2kGskuo+MThgrX7njjJrZJCOf/suNU3tBTRfPPuKn0xEFd3tlopyKbTb7rJBpxsX0JQdaL4Hk8tDMWqGk6dz/l5KVrKz3JbaGtvBV6n3BFNkVHi5B71rFqTJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930239; c=relaxed/simple;
	bh=Bi3P4E1LMVNI9ICHZizJgPWFi1cAG6MJcwmbCUE+tB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DN/wjz0x2wGkcFHuiskkrK6rcFxul0cFgO5x0a2ROd0OLraN0tEKQLgCERytDmqUvzXdYXp1+oi65AO+TYoQT3sgLpZ2iUiHH+0BDuCAdVCzTIidsyj3zMIQcoNfgamYGKZ0A144Yw6Q2LKnkU4m7ABkCz9v/fdqhTLk8ZKzEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gHbAOme3; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gHbAOme3"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a105e55bccso1222248eaf.1
        for <iommu@lists.linux.dev>; Fri, 08 Mar 2024 12:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709930237; x=1710535037; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjWpdrEe1CBSB6fUsA969odLMNfAGSgF6jvNlFE06WQ=;
        b=gHbAOme37lpL55fqrEjCieY/2qWM3OjPHkmnquaMIeqsrTevO3bt/hXQqlIycKtoDG
         lPRjx39KKs/sddQcTL5AEoCuLgSMGMZPmCGveCblUrqoaIk6b1GN0aC80KDeEkJcuH5T
         VoN8/8vcC2OzYAdrCxKK2LEv2wjKlK615iUgZ5PLMPndB0tDOxp/hxxDasNOFsTSo8XC
         PZdX+AC06MyBTgXrVEyrkVFCXDsgEs7jQDpl2BZlvUimssHErE6EHISTvPDWIYY9eZyU
         xTjTPXxyDsI8K1knX0/Hu/yBt8gviYZaKgORc30a8tRetea9EsA4et0zb5qTfpp9Kvd+
         y66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709930237; x=1710535037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjWpdrEe1CBSB6fUsA969odLMNfAGSgF6jvNlFE06WQ=;
        b=kftZeiachlZ7+Iru3EGAMjRvDPtTMsL/aT8xvnNMHMAbft68eRYX1L+7K3LYCLZRlM
         WkK4rLDWk//V2JwTTbDZ9ysmKEJuPGq6zMOWpAwNcKkA4SVUK+Impz4j+8Y9sYPduvPI
         LjIue5VAqtkm3XEbih9MZD/J0tqjfZdmm4Hv/Ggyitsdb4fsEXv3WSNUGknHadLUWBjd
         +5UM7zX1xxz0y3DPmS3qAmd7sHh6umUjvjFagtpXmWsyZYiVAwLPAXhmdC8BHuiBjSOJ
         +mtKJMnfViGGGHfAxuGc/ykYz3V1zmG/i7M4sLo4MVJTH80Sijp9V3tkAKWmy8thPC/6
         gn0g==
X-Forwarded-Encrypted: i=1; AJvYcCVKA2AwQdP6jEBYVNNXemOxWtg763g0YgMq1Kx4iuatdie+Kf0tTOvAIfIjRq5q6GW7kjiPMX1uAHKm1JVWO2CYdw1T7Zo=
X-Gm-Message-State: AOJu0YzVWSAO53cmiYiYvY47iL3NEH5bYNBaWnKTZbSkIhvvwjBQ0pHK
	VBa1Va4/g+jnvtxhweCg4EteoUddmd55m+iqk81tpWM+Q2yoLW+YFaLojBnkhdg=
X-Google-Smtp-Source: AGHT+IEqmZ/bPScFDErmd2Bdge5ElcWmdcXhPkDOr+1siQATWKStEMzgbLHSA9vyfoc0LpJeGpIgyw==
X-Received: by 2002:a4a:2b11:0:b0:5a1:25fc:7be0 with SMTP id i17-20020a4a2b11000000b005a125fc7be0mr413338ooa.3.1709930236902;
        Fri, 08 Mar 2024 12:37:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bi3-20020a05682008c300b005a0859a4a01sm19059oob.36.2024.03.08.12.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:37:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rigxv-007xzf-Er;
	Fri, 08 Mar 2024 16:37:15 -0400
Date: Fri, 8 Mar 2024 16:37:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Message-ID: <20240308203715.GA9225@ziepe.ca>
References: <cover.1707493264.git.robin.murphy@arm.com>
 <202fcca3269201bc9c4a8198253f195433d0c4ff.1707493264.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202fcca3269201bc9c4a8198253f195433d0c4ff.1707493264.git.robin.murphy@arm.com>

On Fri, Feb 09, 2024 at 04:50:03PM +0000, Robin Murphy wrote:
> It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
> ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
> which means there should be no harm in achieving the same order of
> operations by running it off the back of iommu_probe_device() itself.
> This then puts it in line with the x86 and s390 .probe_finalize bodges,
> letting us pull it all into the main flow properly. As a bonus this lets
> us fold in and de-scope the PCI workaround setup as well.
> 
> At this point we can also then pull the call up inside the group mutex,
> and avoid having to think about whether iommu_group_store_type() could
> theoretically race and free the domain if iommu_setup_dma_ops() ran just
> *before* iommu_device_use_default_domain() claims it... Furthermore we
> replace one .probe_finalize call completely, since the only remaining
> implementations are now one which only needs to run once for the initial
> boot-time probe, and two which themselves render that path unreachable.
> 
> This leaves us a big step closer to realistically being able to unpick
> the variety of different things that iommu_setup_dma_ops() has been
> muddling together, and further streamline iommu-dma into core API flows
> in future.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2: Shuffle around to make sure the iommu_group_do_probe_finalize() case
>     is covered as well, with bonus side-effects as above.
> v3: *Really* do that, remembering the other two probe_finalize sites too.
> ---
>  arch/arm64/mm/dma-mapping.c  |  2 --
>  drivers/iommu/amd/iommu.c    |  8 --------
>  drivers/iommu/dma-iommu.c    | 18 ++++++------------
>  drivers/iommu/dma-iommu.h    | 14 ++++++--------
>  drivers/iommu/intel/iommu.c  |  7 -------
>  drivers/iommu/iommu.c        | 20 +++++++-------------
>  drivers/iommu/s390-iommu.c   |  6 ------
>  drivers/iommu/virtio-iommu.c | 10 ----------
>  include/linux/iommu.h        |  7 -------
>  9 files changed, 19 insertions(+), 73 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
