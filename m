Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46553803DB
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178913; cv=none; b=IYffx4mLglad1famC/5ZQ0yzSK8f7lpFtLUeC2O86IssMGJuyjpMOm/S5S/xdzpqY8OYGZ7NlFRKtz96PL8Jzlns4+ITm4WjfCS8aW0Oyfol4QUJmp9NIOvtNxxsSh3nOeBZ3QCU8xClzEjL3vFkhZct98jTObDGKCeKHZ3SnQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178913; c=relaxed/simple;
	bh=b8T/ubLHuLaCB4whaPYyYa1q8z2vcOAafgGggYdRfXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRJ6FfHMmNo1qNnLOaQVZFKPitZkhE5i3A2RXf1VBcigSMjpAj6wq4j9U7Iz5o8wn8oi7zNSDXs9ShojOPx8Q2nKYjfU842O9tej0T+rCVVYeflwBOJT5BgZiIo07rYHd7EYNU4mR08VIDXaCbbss2Y5aVNfkX0FY/ddOzg5fAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z2WoyxhQ; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z2WoyxhQ"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c8319dd4a5so523600e0c.1
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790178911; x=1790783711; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L2p6lfpmyK6oEUo0D1kSTcomcrX7eHQSl2rXfKoXoeA=;
        b=Z2WoyxhQCENBKMt9/W7B0cJEx0bnHr8DuEgZ16CGk1sfZifAbVz/hOSD2jY+zOYWE0
         luzitrLouQpnKIww/Lq39RLrbNTUV/HDD11DjwIGA/I9bfRktDe0pRjdbjgZkvVbLB/Z
         N02ul/wkwQnXnPX50qY94gYM9jSOaPFEKfk7tmjvGdby4F/uLOAMiAvlpPQOo2j2ZwnH
         fCcR2ToXvfVsGpIUW/ixl37xYHA5PEp3FMaavPpXh3p4uSvww3dJyne+lnpgZ8owoLm4
         cMFz6hxApp6Jl0U+JM+SB81r0Xiq0q7hiRhcBxbZAZI+oha0Wg8Y/HHb51jQh0IXePbK
         SPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178911; x=1790783711;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2p6lfpmyK6oEUo0D1kSTcomcrX7eHQSl2rXfKoXoeA=;
        b=gzbmuC/Rk1OHGjSrjLCpu1bClxKHesSbVOYrrAQF0GjwQFQnP/KzFg10G34VaBt7iF
         H3MXWJA5Tpy9uJbV8RXYVQrhxwpeyAyEP/LUE7GelqyN0QWunFcmUp7HpEibEdfknGbd
         gllGcUJmiERWqmYyygqgRdcjmj/pUjDE/uEFPS/umeT+PPGTOfPt7UGaDG2ybfjkqeK7
         vz8FZCIT9WGAJtjAqX8lyNDmui9UcUYOq33lnGA6WDdbjAl/CXKzmKxQYCM32SH1YQ0Z
         8mCdW+8jzhPN2+o0qpN1XMEjNajByz6MoucTVryeODdloQx+mztZo8weDxhjYmikVj7r
         WyBw==
X-Forwarded-Encrypted: i=1; AKwUvBwMiMUNix3Q29xzZ9GtNhpWJMPJfXPjWyFmJasoVtUBvqoX9DUFFXpOzxu6zIZrTfzmbWYkjg==@lists.linux.dev
X-Gm-Message-State: AFuF++mhuLhR8bTmjUYYnMLarswqCew4Fd9Eb6rhqxTCmN+/lvYtBAMN
	3CPe6xKdHBZI2I+jvNPPXdTIEBvjQBFQouvsNhtYgcA7sZFRAYudITIJDtOgrDArJGE=
X-Gm-Gg: AYBFou2h9pimFUiUlY91owSh2aHTEEVPbGiZhbXZY4MWf+vX+UEQHUyF8hX00vopLGw
	R1o/hFownR1ZRUvOAWKmYoLlZjznzyMNatEIos0wZkcZkQZcVoqe4tT8rxT3bsszWMxmnc5eDNH
	laKBtvTuam1YeHHUh3ttGonXG3Z24wGMXhghyWZjnXAryZtPiFvs6IkapbNWGCIM2IjHXggNRYt
	uIs++NOtOKGNWf8SySlkqN5W9yFdrluHgl0S1d6OxRJVmhO1zEO6LVifwy9DfIjCzkn1SA+s/v0
	bUCyzFF9jHEFp4SN7vQCwGdW3C0SAL26ylfVso+pmxgDT3k1pfwb/L+PKmQRD9zER5/ceZFQ37O
	6hXru47xd4uhxm73GNmd87zf1WF5OIOtyDDaIpkx03BZyppxnEPM6X7pHudrTLAjnIfM9p7bH34
	by3BaEtVsNXHa8xMws22namNB3jEsargS+nluXWUP16Z3582WrJ6XMAjw=
X-Received: by 2002:a05:6122:338f:b0:5c9:a60b:e5c8 with SMTP id 71dfb90a1353d-5c9f1666ee8mr3394069e0c.11.1790178910702;
        Wed, 23 Sep 2026 08:55:10 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9f0551688sm3382770e0c.15.2026.09.23.08.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:55:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9PJM-0000000DwH2-043G;
	Wed, 23 Sep 2026 12:55:08 -0300
Date: Wed, 23 Sep 2026 12:55:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com, vdonnefort@google.com,
	sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v8 11/25] iommu/arm-smmu-v3-kvm: Add the kernel driver
Message-ID: <20260923155507.GJ1540250@ziepe.ca>
References: <20260922131259.2975334-1-smostafa@google.com>
 <20260922131259.2975334-12-smostafa@google.com>
 <arMbxX+sqTS3gByB@nvidia.com>
 <arO9hGmEx7c9mZAj@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arO9hGmEx7c9mZAj@google.com>

On Wed, Sep 23, 2026 at 11:52:36AM +0000, Mostafa Saleh wrote:
> I can add more info in the cover letter about the code split. Mainly:
> - arm-smmu-v3-kvm.c: Is the kernel driver for KVM SMMUv3 (this runs in
>   EL1 and can use all the kernel functions).
>   The main job of this driver is for discovery, it doesn't do anything
>   else in the runtime.

Maybe call this el1 stub or something like that?

guest_pkvm_stub.c
pkvm/hyp.c

?

> > > +extern struct pkvm_iommu_ops kvm_nvhe_sym(smmu_ops);
> > > +
> > > +static size_t				kvm_arm_smmu_count;
> > > +static struct hyp_arm_smmu_v3_device	*kvm_arm_smmu_array;
> > > +static size_t				kvm_arm_smmu_cur;
> > 
> > That spaces/tabs in those two lines look a bit odd..
> > 
> 
> These are tabs to indent the variables, similar cases exist in the
> SMMUv3 driver, check arm_smmu_cmdq and friends for example.

Personally I hate this style, it is a huge PITA for maintenance and
makes diffs bigger than they need to do. I remove it whenever I have
the chance :)

> TBH, this is a bit of a hack. The hypervisor can not allocate memory
> at the runtime. All of the hypervisor memory comes from a carveout
> allocated at boot (see kvm_hyp_reserve())
> 
> So we allocate the worst case for memory mapping with leaf granule. But
> the hypervisor also need to allocate L2 pointers and the SID space can
> be massive making the upper limit for this too large.
> 
> However, smmu_hyp_pgt_pages() defines the minimum pages required,
> actual allocation comes from the command line, so it is possible to
> tune the system without re-compiling the kernel.
> 
> Thinking about it now, we can just drop the 500 as this is the lower
> bound, earlier versions of this series would allocate the carveout
> based on this size, but it is not needed anymore.

I see, and you can't scan the ACPI to figure out all the SIDs used at
this point to get an exact estimation?

Not being able to manage memory after boot is rather an extreme
limitation.. But a huge amount of RMM's API complexity comes from its
granular memory management so I can't really fault that..

Jason
