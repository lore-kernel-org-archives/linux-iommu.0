Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A235898
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777582170; cv=none; b=iz5bnlp3MCFjBLyMBJFTPZDSRUriXiRASLYU6RTDOXBRLyeQ0UoVGMDynImxdB/mr1cH2FGHBpridiepu6LHmvgkvH8RUVJYdWu1WkMxQVyyOTVWAhGCj6Nt+OoIu3aYplpxNwHI5yISA0Tthjt2tjvI6dwDmHWTUTee0Maop5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777582170; c=relaxed/simple;
	bh=TriwdijzsiVRf02t1V40GPDZHZ41X/f0QJSAPNy0VeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK0s0k/VJxFGQoSQCPIitTfruwOniA86qXzbRkmSXI3NeTsxjBxsovJahC0j6coGXcn/a3makXL+OB7K9h16GwuR9wTxrybWip6/usjvVSKVDUj7zKgDVTv99akrgHlqVk2HbjlxUZSKbU5SESOSfoU+Oc+OF4K4hMPVInHPids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s08HH38q; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s08HH38q"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35691a231a7so957654a91.3
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777582168; x=1778186968; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hkx4tLK7DpveuSLFftKdSSEC4NdhOfO2fjr8Ook6ULw=;
        b=s08HH38qA0iIpnqkXuCy8WfDqz/A0M2y3K87SJQbfKPjOKb9MbmInPD6h6WYgLLTUM
         jk+kSPssGh2Pd4S0zP6nGbUMOcupzbhdaLZ3row3QGLgfJD9SI30s9Mw1iduP/G/pbeo
         kJ/2IbvmHkK/NU7zptXUyJC1stJPh4CATUMtloJw0uAVkuPCoxf9C4FgwlV6VyBojkZT
         1XN/Xvuvfrf17310whGpGBy3nz9qkPSyD3zQRN+qFPspAovarph0fKkqIWlfhMqfVOqy
         zGAMHQl3aRvrxTX7s1mi49qB7OaRfx0l+wSG3oTDU9/x10uz1iKHLBo4G4iE2cX6JQIP
         xHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777582168; x=1778186968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hkx4tLK7DpveuSLFftKdSSEC4NdhOfO2fjr8Ook6ULw=;
        b=gCrmEf2I4OeCdWzo8x1yu5dxkz+OjUcS7Lmlv4nei9orVzAZya0BsYDdOXCYG3Boj4
         ujQY3+i3Mu3BOoKQmD7oC3HjtEe357gOY3pDDx4sh7DLfctWk/yLi+MPE2t9PnfrIjND
         aaGECu22/FFNsWRCtPxnTD4Fzedbu6RnMYZiPsOKQH6AgSGchu8Yi/Ab+O3wHjdInjL5
         YnIcGfmBXnWBu6Qq4MUJbMdTAia2vUs0r7FrzBu0wC6rWJUeyf7Y9Fz6QlzR02UJDdgC
         GwK8uezgro+ahYTbozfh/EDO22He5GhzVkcRUZUil7HPFUTyF5YKxKvcdrpAMkzBqAoo
         KZOQ==
X-Gm-Message-State: AOJu0YzWQDz4PI6KCbE93Rr7S2nn9dCl9AVqfnO0fciTptGSkdLeM740
	dHrhP/dBLB49puBSdlcAOPC/F1CJAqkIMLRnQEHS0swDYIVsHvXuk1Mne+GOkJvOgw==
X-Gm-Gg: AeBDiet68UiCal7QQQXxIRu1ZTA6vyeyZ8Mt3a7o05DlUKtxp9o0tqsRxPInn4m8v7G
	zKl89rEB5akQIhsju+woHtgcdZ0i4A1NXJwnOyUkRZqk/kSxqUpjarG5LekhHH0bkxq+qP9HAKW
	ZJQDjK5WuQsL6lNoFPezNV7cEoyBIUPe/9QPNVWkHcTsl0FSUFvAgBqszgx+D0b0tgY55f98c6x
	Yh0MWSI94fgF48FjhpaUuJFxkcxvPjSLWlA+3Lqdh66+M8wuY012PyL6lJ6QZ7P4HNdduCKq+yf
	YMoyr2yFt4bPmRr27Kmu4mtCsYIdi0wEPV0w9zHFHuBWQUORyCEPa3lhxrCecQGyxd/YQmegLTO
	YWUGfksdPfSR2Dzb1KMMS96PSdnMnYjW3ffUZxkzWHtxv+Ame9/IzZoHNvrueVSI6kqKQdD45Iu
	+A5Wm2NEC4Thwbnnwf8tqSsCRYr0BLmv/HtPpHEq+jQG41i/dckm1C7bfOmF4e0FqpzCZ3HwOgY
	MXHSQ==
X-Received: by 2002:a17:90b:3e4f:b0:35f:b288:8e4c with SMTP id 98e67ed59e1d1-364c30cb4f7mr4328476a91.15.1777582167388;
        Thu, 30 Apr 2026 13:49:27 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec00b094sm307888a91.9.2026.04.30.13.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:49:26 -0700 (PDT)
Date: Thu, 30 Apr 2026 20:49:22 +0000
From: David Matlack <dmatlack@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
Message-ID: <afPAUiHoqoZl1-4I@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-9-dmatlack@google.com>
 <20260427135625.0000413e@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427135625.0000413e@linux.microsoft.com>

On 2026-04-27 01:56 PM, Jacob Pan wrote:
> On Thu, 23 Apr 2026 21:23:12 +0000
> David Matlack <dmatlack@google.com> wrote:

> > +bool pci_device_group_immutable_singleton(struct pci_dev *dev)
> > +{
> > +	struct iommu_group *group;
> > +	struct group_device *d;
> > +	struct pci_bus *bus;
> > +	int nr_devices = 0;
> > +
> > +	group = iommu_group_get(&dev->dev);
> > +	if (!group)
> > +		return false;
> This may not work for noiommu mode where we could have a null group.
> Maybe I can add special case later?

Yeah depending which series goes in first. But based on the other thread
I am going to drop this patch from v5.

