Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83C79CF
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 14:15:35 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-768054797f7so596241985a.2
        for <iommu@lists.linux.dev>; Wed, 02 Aug 2023 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690985735; x=1691590535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/v2fhzkoLc0XBqBu1jWFj/Nwn47lwdRkCiLxyO8V30=;
        b=Sxdue3MHFYBbmk6FfucrMbAKCC/vqFsDJvMkC6HXzY02Qba2GTHr0SHy1DwQO07w8A
         Gxi3Fk//XxlHJFW+0AaTYct04Om8rU5nIrErYS8hm82LO9r8W+nPak0n5OWrQEPjNRl1
         8+zxXUx5T3IWrVj9iFJPYAmUwOaFILiqk9eFcGuJzgk6IICab1ppy0/AY1k+AegChCKz
         lpNVHQLxYegoj1+mltezt+ZRXkrP9NhThJ4fnXfbGVot3WaEc8H5FrMRVt9Dn4CbdiZm
         Rozx7DgQC0/x1PP/RXh0wc19ORG6eXFtFDQUtFUP8KqnHGFR4oQLjDUvyDBysjFguDb+
         kDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690985735; x=1691590535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/v2fhzkoLc0XBqBu1jWFj/Nwn47lwdRkCiLxyO8V30=;
        b=MOm7Kfgg5Bo5E8GhahnwCuBfRhrprEIz3c9jbQUhm4IbSE85e9HHLwsGrCN+r3cBk3
         px46ebpGGuQw+rOhKwCJIjFH45ErrlyMe5y7/F8z30J4zLZJp4ZCMFJ2v4y6wEoJiBpH
         WnI8Pty7/qeycv//hvXcrmbAwIRMru1pkxdshbcGFWOHQgWdmAHhKR+xPNZBF3t/yJ4D
         9GZ+r7uwndsqV0MPYo3WyDD2hGgAFmj+7yWUUZk8adG0xMAfQ6O+SV3XIg+/UDcnL4fP
         boagYiUhCHhLH7ACSZcy4FVpV7qV5LgAHKgr6k3fa828/Dethz1SMT0UF7Rb5XFotteM
         /wnw==
X-Gm-Message-State: ABy/qLbttszb4j0C1Yl4O6B802ROwQTrkpxjeh9B5m75+TjMC067E3ih
	6bmbzRcsJqGWoHxxM8UoZIKz8g==
X-Google-Smtp-Source: APBJJlGInqqbbLPaE80P2pKXirrUYAT7zZzyHhPtLanpiPQ2UB6qB27NxHN+Y/2YgtYZ3tPQ3pH3nQ==
X-Received: by 2002:a05:620a:205d:b0:76c:be58:d770 with SMTP id d29-20020a05620a205d00b0076cbe58d770mr5994984qka.78.1690985734872;
        Wed, 02 Aug 2023 07:15:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id a11-20020a05620a124b00b00767cd2dbd82sm2507399qkl.15.2023.08.02.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 07:15:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qRCdR-0033D9-O2;
	Wed, 02 Aug 2023 11:15:33 -0300
Date: Wed, 2 Aug 2023 11:15:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Make pasid array per device
Message-ID: <ZMplBfgSb8Hh9jLt@ziepe.ca>
References: <20230801063125.34995-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801063125.34995-1-baolu.lu@linux.intel.com>

On Tue, Aug 01, 2023 at 02:31:23PM +0800, Lu Baolu wrote:
> The PCI PASID enabling interface guarantees that the address space used
> by each PASID is unique. This is achieved by checking that the PCI ACS
> path is enabled for the device. If the path is not enabled, then the
> PASID feature cannot be used.
> 
>     if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
>             return -EINVAL;
> 
> The PASID array is not an attribute of the IOMMU group. It is more
> natural to store the PASID array in the per-device IOMMU data. This
> makes the code clearer and easier to understand. No functional changes
> are intended.

Is there a reason to do this?

*PCI* requires the ACS/etc because PCI kind of messed up how switches
handled PASID so PASID doesn't work otherwise.

But there is nothing that says other bus type can't have working
(non-PCI) PASID and still have device isolation issues.

So unless there is a really strong reason to do this we should keep
the PASID list in the group just like the domain.

Jason
