Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120F1E1A18
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972121; cv=none; b=RrH2tYPddxzDPtdwis5MJL/USmDzjO7ZDaFc6iPI5nMBYuoi9zvw5axKhjn6EHFUtCqMeY6417rOYdpiE5b6xrzoLTwU28IBLuqDT0u+mPdRZGE2Hxmymj4sJf0chkrvOrEQXm8zGedw21hxDg6T113wGBsB2FROHK2uOSW6zJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972121; c=relaxed/simple;
	bh=kwuC7LMCmQ78MDZA4UVL8LfwL1KaSncs8M3Y3if2YfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljki/tMQKuqZ6LpJizqVKRPMr6snewwmfPwhqg+1EGHlN3iAIOwZjBmkUtnN+mNtsjjxU9JpVpFu2F+hPIL6WY4oqpQIxxWXbKS3kuWiupTZhY8b8dcP6XuRvVcAhQbWfl9Ppp6dZcfAWkSHnGAExHPkrQMag+BTAsDdpvHbLlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ah3YBNOs; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ah3YBNOs"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd049b5428so58853816d6.2
        for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 05:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739972118; x=1740576918; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u0TYJ7fM/SXqqc8EBI871wMY2GiJMGDqWwXqUj2bdTg=;
        b=ah3YBNOsuxOdnIkUQqhNRya4+1Qf2eNO1J1xTjvw4WVJlIxG/f2baK1urBxaSHMYbR
         Rn3WayRRBs1e/5PrHt83UzdtSKhvdPxWtj1kJv6bQ/ygviIRIM1SfMlTeErZtKSPBGGT
         7n3NFCgasMGAb1H4TrX44nc2svO9d33xyp8hOTtjSK4cgZ94CA4uFnICK20que+j7loO
         lrK5ZoFwYgWlZR1/XFcGgU9bp7evNSx2hSpoqq+oIIm9aH8oeL7029QXRu+tS8nxbVYH
         92sk7HsnrvIVq6gf9wKKWOT4373DTqLTI80LKZe3/G/gg+rKe+DR6dnBriIpjI7bfBBE
         fLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972118; x=1740576918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0TYJ7fM/SXqqc8EBI871wMY2GiJMGDqWwXqUj2bdTg=;
        b=XyNboSLHB2vQB4WbTPh5DFtZCZrgA7dSkftp3VRELHUK5fVazwPqZxT7qWd+Dv66b3
         ibu/r6zN4Q187rop66aWOopWpr7tqydBpS6mDXyDi1K2TGl7uSyDViZj//8YFhHystTV
         /mDccbUYb8jGs7WrDNbMPJbT3tuhq0hf+spfcttEjPYrNJjXe3J1U7+P4TLX7R7jkUO4
         udjUni7+QdSVYNDF9k1Ak9AKV+wmP74vZv6pgtjqnlpkvSnJezh6gJFLgblR9z2DWdEy
         +H7ECBjwCdSuFFt/JamENJ5UVuvh/F4oVLshRRqiPxy7i+yq41lG71sIO1+OKnh3UoTL
         QcMg==
X-Forwarded-Encrypted: i=1; AJvYcCWn9zlFM6oNXBersoqJbUrMUhzp3G6x9FzIqa6J0I93Y8Vj9p/+bZQhu6Yd9VvNk08P/5UH1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLMSmzrzALhNyhtAkFjYNAGAxmcTFLx07XE71xRO0CStN6bcWn
	IgLsRN8jkqnvtLbHVbrBNYHW64TtNSrqYwub92DkzGVJWPJG3qhhHD9a+LsdZyE=
X-Gm-Gg: ASbGncu8WD/oIPnagfKSy3rOLlsCzhrINHosU9vboxMhMZT5+wPWUbsXCU+UmTu8LEQ
	x8GiYEJwzydt2hfVUQ01bBWmNkpaW0KU4m4jLANJwFGpHZwVTe6so+kQaS/bjW7w1vssHpESQM7
	4DAe6FRazd51rqQln9kmMiGf9atu6WTqmSDWLEzIRo3bMwp/2q5xwUjE1jbpPm9z2FHA/3vgRZi
	I5ZWpyVdoppJU0VSk/TL97JSnBIcAWawPJVvEVRHR18Gui1VLyBxv2SA4PP2JyFSDqXjpMD6JRr
	kC9Ya+8clMfWFXPFp25ZwCFdVix8wD1gyzZj4S7IDKUhvv8gpAK1v765knG62PLS
X-Google-Smtp-Source: AGHT+IEztxOuEVoB32w5goUsqWZrTGGQfC8OhdWXN67VQGqwlVLEaJp8Xn8cLar0Y8Ac8adbEPAFWw==
X-Received: by 2002:a05:6214:c4b:b0:6e6:5a8a:aba with SMTP id 6a1803df08f44-6e6974f98ebmr57605336d6.21.1739972117896;
        Wed, 19 Feb 2025 05:35:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785cf1sm74757816d6.42.2025.02.19.05.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:35:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkkEO-0000000065j-2JVM;
	Wed, 19 Feb 2025 09:35:16 -0400
Date: Wed, 19 Feb 2025 09:35:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 12/22] iommufd: Allow mapping from guest_memfd
Message-ID: <20250219133516.GL3696814@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-13-aik@amd.com>
 <20250218141634.GI3696814@ziepe.ca>
 <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>
 <20250218235105.GK3696814@ziepe.ca>
 <06b850ab-5321-4134-9b24-a83aaab704bf@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06b850ab-5321-4134-9b24-a83aaab704bf@amd.com>

On Wed, Feb 19, 2025 at 11:43:46AM +1100, Alexey Kardashevskiy wrote:
> On 19/2/25 10:51, Jason Gunthorpe wrote:
> > On Wed, Feb 19, 2025 at 10:35:28AM +1100, Alexey Kardashevskiy wrote:
> > 
> > > With in-place conversion, we could map the entire guest once in the HV IOMMU
> > > and control the Cbit via the guest's IOMMU table (when available). Thanks,
> > 
> > Isn't it more complicated than that? I understood you need to have a
> > IOPTE boundary in the hypervisor at any point where the guest Cbit
> > changes - so you can't just dump 1G hypervisor pages to cover the
> > whole VM, you have to actively resize ioptes?
> 
> When the guest Cbit changes, only AMD RMP table requires update but not
> necessaryly NPT or IOPTEs.
> (I may have misunderstood the question, what meaning does "dump 1G pages"
> have?).

AFAIK that is not true, if there are mismatches in page size, ie the
RMP is 2M and the IOPTE is 1G then things do not work properly.

It is why we had to do this:

> > This was the whole motivation to adding the page size override kernel
> > command line.

commit f0295913c4b4f377c454e06f50c1a04f2f80d9df
Author: Joerg Roedel <jroedel@suse.de>
Date:   Thu Sep 5 09:22:40 2024 +0200

    iommu/amd: Add kernel parameters to limit V1 page-sizes
    
    Add two new kernel command line parameters to limit the page-sizes
    used for v1 page-tables:
    
            nohugepages     - Limits page-sizes to 4KiB
    
            v2_pgsizes_only - Limits page-sizes to 4Kib/2Mib/1GiB; The
                              same as the sizes used with v2 page-tables
    
    This is needed for multiple scenarios. When assigning devices to
    SEV-SNP guests the IOMMU page-sizes need to match the sizes in the RMP
    table, otherwise the device will not be able to access all shared
    memory.
    
    Also, some ATS devices do not work properly with arbitrary IO
    page-sizes as supported by AMD-Vi, so limiting the sizes used by the
    driver is a suitable workaround.
    
    All-in-all, these parameters are only workarounds until the IOMMU core
    and related APIs gather the ability to negotiate the page-sizes in a
    better way.
    
    Signed-off-by: Joerg Roedel <jroedel@suse.de>
    Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
    Link: https://lore.kernel.org/r/20240905072240.253313-1-joro@8bytes.org

Jason
