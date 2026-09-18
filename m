Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0844B7A53
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737210; cv=none; b=GejqA/BQMh2exR3UWtvvyTI6QQXQowhw4wq0+RSkostOJqhmAQZy4qASRCgvMQ4cO9LZ6AaWzfSOr3n1ssy+1rreV3szwc5Gy9DDhqgZc1xEf2ijik/vlPZnAlcO76ZvyDsfibLjSEcOP//tuXBTqDMknhmw9Yb2cou5E5/u8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737210; c=relaxed/simple;
	bh=0e/Us3WlYuqZCrvqyucnYIvOewYG6+iESgxv213CRfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ra+QAl1uRJWWC6v9S+hOJ7oByISUZ5kqNUElkeElDYcm8WXgEsccS1VT4ssQMFPuV2LgxUglRtwc1zhtIM0vw0iwHqg5m6kl1CMF8UwMqPX5wLuaLJ9D4te3uj3aicL3nwYJyjZHYEVuR77xi0HucRIpjx5oF07f8xhHOvvK8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FZaeWuIv; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FZaeWuIv"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb767cc97so6789631cf.3
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789737208; x=1790342008; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RgJgP9V+TanXYXiwf33sE6+6RN244WVmbEbqLcX7cFg=;
        b=FZaeWuIv+zD2IPphoYfg+Jtgm04i5wDJ4IAwb1zgQREw01jwseZblsufvSSw/JR5F0
         MHfnH18Z5NXlsmjBj0V2QFsRDFyYx/4qi37d+gJFmvPDyvkiP2GUleqgddwTYTXj2BVQ
         xFG6fqbLBOIJoAwgJ7lk/NzIuzRByOAOMDpVGGveQsNPiCBmhgXlIuj20kD3b3yitxwT
         tDUdZL01WV05XYMrsbOtNO7mQTafUwsgEcPcW4vEoyHEIVZqzVZG+IdiDzrJDMCPUY6G
         5Jrg/Q065sdtz2B+1jLuwdMgxR+9ZH6bMkAtbl8tk9ClP21yb+E/eDF4+SNqxd9G3jZv
         +2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737208; x=1790342008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RgJgP9V+TanXYXiwf33sE6+6RN244WVmbEbqLcX7cFg=;
        b=mAbuBOWt1+4QMjMedoztFo/uNPfmiid1DZM+z6cx3nJafO7D/MXnhXHtiyw2fvHMj2
         pqbIYVNd+5R0pHQ6ZJ3mOzGPXsIYbs9BPjqBt0/cqZhxtxf1zJBXnGk5Iu3mdG0m8VG7
         KzThuchkiVjy5FMAmqMXVvc7YviI7zPW5mwgc+Z6bulUDkezlMzw6ZKa8u1eWYcDWhDW
         z4l7t9sZWvdFOTffkn2slUvDax3mces57M/K+S/B0XdnxLCCxXEEYZzwmnvu4e19xpC1
         +LKX3C+w+KdqwdT96mEewDhOHbZTPf+X1775YPeZAMOxRA04Yw1x9J7s7uHqBafPCbn0
         IFvw==
X-Forwarded-Encrypted: i=1; AKwUvBzF8+n5fdWhmHw01BconaaaCeYYFqSioQSHt+RsrAZJiwfJc68tqrd3klw5DS9/Qjg6hbDWhA==@lists.linux.dev
X-Gm-Message-State: AFuF++ntsUIbqf2nI0g3bWUWYh+SbuDb5RuPcEDBy4om3hhVuAJLyhcI
	QivTyDCp+6SakFAyAKAJMD0X34nz+6yq73vPN7ydvcPyRcqDiHcAiiKgRqHgLP58dBc=
X-Gm-Gg: AYBFou0KUU2sCGzBACPD+DFb4YycoepXxbQmLCzFzPflLlJqFi47C1ZyolBeJ8TDoHt
	0fHVagoU0ZhCcPnur7bc7D0UDdc0Ncbso/JROTeAFHXbQtKrXqoD7b6rPZzRakiImj0KLPj40On
	uCdWj6TAiOL2TYlLnj5CNJmICn2pP6dQdODsLmj1NjQYkL74LjzrnIUClmJ19mgg8aVPr36csQm
	XRtjEr5yYMIY7Z91CZW6JxC061o1QyreKGs2FRd2xVqaVT6O/Tq9xAg7Vw4SDOT97flpVgahLcX
	D/Ew8TAxeM/6N5eSB/HIIE3XtGMG5uuGNq55q84mVCwNFZn/9WDvLxjrFEHJgEr9CxZg2w8OAAJ
	1gdvka+zwWPdjT2vhYlncrNvgkzKkGhlsp6Z4mupVuPkBjFbJUf9XTMHeHjtDcwVvtw3C7jg+mY
	fe0uDth8PLfsEz9Z+sldAstJTqkbOtjIbe5yGlwEmBWSZOMsQVkiN+wGZKe6+Tln5lJbRCbdoHr
	sN85GeCyd04VxVVlSSGKlPvpQGfaIvaXkARYbBrWuPV4OPGyG8/pHZB
X-Received: by 2002:a05:622a:550:b0:532:a5a2:e652 with SMTP id d75a77b69052e-532a5a2f397mr15646941cf.79.1789737208228;
        Fri, 18 Sep 2026 06:13:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532aac41140sm3599291cf.5.2026.09.18.06.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:13:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7YP9-00000001CUD-0PCN;
	Fri, 18 Sep 2026 10:13:27 -0300
Date: Fri, 18 Sep 2026 10:13:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 09/11] iommufd: Add the vdevice TSM request ioctl
Message-ID: <20260918131327.GB11599@ziepe.ca>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-10-aneesh.kumar@kernel.org>
 <f6fb7f1e-a296-4142-9b77-64420edabe64@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6fb7f1e-a296-4142-9b77-64420edabe64@amd.com>

On Fri, Sep 18, 2026 at 11:09:29PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 18/9/26 00:01, Aneesh Kumar K.V (Arm) wrote:
> > A VMM needs to forward guest-originated TSM commands to the TSM
> > implementation managing an assigned device. The IOMMUFD vdevice
> > identifies that device within its vIOMMU and provides the appropriate
> > dispatch point.
> > 
> > Add IOMMU_VDEVICE_TSM_REQ to send an opaque request to a vdevice and
> > optionally return a response. Define common operation and guest
> > architecture identifiers for CCA, SEV and TDX requests.
> 
> iommufd_viommu_provider_ops already knows what architecture it is,
> why bother with these identifiers? Thanks,

At the uAPI boundary we want something like a strace to be able to
dump and inspect the system call without having to inspect hidden
knowledge of what is inside the FD. That's a huge PITA.

So saything 'this is an x86 format request that uses this coding' is
the right thing.

Jason
