Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924AC1714A1
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962049; cv=none; b=rOUE+cNQYQsW4j/REeeuh2IEDeyqZ3avTP8MJRQpFtA2nNsqa5nr56Da+f9Y5j3KB8HlHyy90pY8bbncYMumLrviv01VOdGybeyFSBqxnc/soj3D79O/2tZs0zEHpG3lSLLgxxdzInIbIi+azu5bY0mXYYuFQxi2ZQaLcCoBYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962049; c=relaxed/simple;
	bh=bQDBIqvjgHLFGYT9bOVK3nBw3OiQmakouIHTBhyKrVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jgm0lIPRSevvlr5ilX6BCe2oScHjn/4veZssCgSrCAvqO8Tu7WBn196sxa+ejVpH/+r41IpYs2SYqRntYa6gz9HvjqRZkVVRNLcDRpJr/5wmTGdJ9wPnuDpVKU6Q4o74/w3OPcLoEE1N9D9aVp6gEdiHN1yiCse+ptRe7lnbI68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J/NApcgM; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J/NApcgM"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45830ff5b70so7137481cf.1
        for <iommu@lists.linux.dev>; Thu, 03 Oct 2024 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727962046; x=1728566846; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cc2GtirUmQ6kR3TGzhvl/zPuGFrMGbjNkhjuKGHEBZE=;
        b=J/NApcgMI6yqRyLe/RsBkvDaUzbMp1gAKznv1bDMwewy1MBMWrwf33erRiUGLAaVwM
         2lIxzLVNoFfgcX7BsNtUpJBg7EqY6/vNWSrIhWyV6hzJVBNjEZKcmrMHgjb3I7QyB2Lc
         J508kSHy2wFnYiNYzR+16QPq4kqvdWzD2WHeMDvnvA+XwR5LqMIiWhlR61I5M1L6aFtz
         KM6Q6o9pUuFE5urprPOHbXJ9+/MT33GCSSoQ6JsJfwjDmtmpCFpOxtMd0Mcxbh4HEvjf
         TpcesRnt9Dvp/hx/EWYllhdYvacQ70OAmp8O3syqspA729WItQXticB79nls7+psBxG7
         AX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727962046; x=1728566846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cc2GtirUmQ6kR3TGzhvl/zPuGFrMGbjNkhjuKGHEBZE=;
        b=SNPuqe4wKVWKya08TRDjL1EXopPW50axZs3KE7DbVVbzVj0hyrMDw87ZbiQVMV95Ir
         GD3W+7xnwxJHAnaHWk4Hj3AnduoBLvaxypZ803y3VOP5NCO+nZVBnmd3qpAKx2i5c8LJ
         fqLDBYycGKPqBwcKRV3twbTpWRjUCEGDpHwjebq64gzvKHIg2Csk4BPod1QyEFVMo98B
         naCDKxJDQ4NIre+tagreVC6Ns2Ymd/AsFXU1j0pWY3Y/9a0eA3JT986P7wbCCnxoX6BK
         2V6I2Vz4lexDzSOCY8qdIOUKsRhutqN/thasUkjH6nyO+ohmPXqgOraUE9RLF1pxx+gi
         2Xgg==
X-Forwarded-Encrypted: i=1; AJvYcCVe8wXe2YEjIzKT3eGBHcDbELFvxNd/BOFWtcwpXr+O7MbBN49HOkKzqA1amgOTrR1pgw2SBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUp9d/8SqwxU4jxiXnEGhQnhphZhO7liCJcXzpKYsGEz6fDnZ0
	sOjRWKa8D+QF91Fjqc7KULWGgPE6YlJ8mwyhp3Fl3eIkpHvhDCt90kEUuveUx9w=
X-Google-Smtp-Source: AGHT+IHdsqmMnAikLaL30SlmXTNHCfwHdVdF6V4bu8a+VKbWoQ7V+K/jqGWmGx8IKfbi50OEOlxglA==
X-Received: by 2002:ac8:5746:0:b0:45d:7ebd:76e0 with SMTP id d75a77b69052e-45d8054de1emr92224521cf.44.1727962046402;
        Thu, 03 Oct 2024 06:27:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d92e30a82sm5511161cf.57.2024.10.03.06.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:27:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swLrZ-00ASSm-2s;
	Thu, 03 Oct 2024 10:27:25 -0300
Date: Thu, 3 Oct 2024 10:27:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	iommu@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Alexander Graf <graf@amazon.de>, anthony.yznaga@oracle.com,
	steven.sistare@oracle.com, nh-open-source@amazon.com,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>
Subject: Re: [RFC PATCH 03/13] iommu/intel: zap context table entries on kexec
Message-ID: <20241003132725.GA2456194@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-4-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916113102.710522-4-jgowans@amazon.com>

On Mon, Sep 16, 2024 at 01:30:52PM +0200, James Gowans wrote:
> Instead of fully shutting down the IOMMU on kexec, rather zap context
> table entries for devices. This is the initial step to be able to
> persist some domains. Once a struct iommu_domain can be marked
> persistent then those persistent domains will be skipped when doing the
> IOMMU shut down.
> ---
>  drivers/iommu/intel/dmar.c  |  1 +
>  drivers/iommu/intel/iommu.c | 34 ++++++++++++++++++++++++++++++----
>  drivers/iommu/intel/iommu.h |  2 ++
>  3 files changed, 33 insertions(+), 4 deletions(-)

We should probably try to avoid doing this kind of stuff in
drivers. The core code can generically ask drivers to attach a
BLOCKING domain as part of the kexec sequence and the core code can
then decide which devices should be held over.

There is also some complexity here around RMRs, we can't always apply
a blocking domain... Not sure what you'd do in those cases.

IIRC we already do something like this with the bus master enable on
the PCI side?? At least, if the kernel is deciding to block DMA when
the IOMMU is on it should do it consistently and inhibit the PCI
device as well.

Jason
