Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D53334C1D
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179633; cv=none; b=R+WVzL3kPKIt12PBS71FpX5k/Buw4sDK1aeCq7ZfM8Up9T4n3zCbEwZVSNdH9jjk3o6KHjAFCXD3LGm+1Dg3lHmCHpylAHkTgM4AfNib1Pv4tq3wKnEW8y1jIB65XCU3L6XRBYE1CDqYNptdlIG+yXDa3ofnAazH72tmUDsXQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179633; c=relaxed/simple;
	bh=h1JkDde0JEpeHExaAaLcI/3EDWHEcgua5TaSpojYG5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0+1Q1zzxzer7sqd8Y00Vo5E2EdMGABoZ3W+nso9jui2MFNM+A8OS+lTejnK5cechtQ/5yIqwetrGZFsSm7Nj/WGv6KoTy8jlM9wF1KGpwtYMZuXeHB5U1l+ReVQoOVjawLxPtuLHY/OvoPycqF1X81BuD5kx5kgxNA07lf4e28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vo5GDSYl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vo5GDSYl"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso17625ad.0
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778179632; x=1778784432; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CukuR4C0VokxuACh8W7BiMV3ykO5i2dF/8Jc99UlNZw=;
        b=vo5GDSYl+l6YeZ+hTGxHB1VvfFjue9NaWAZbWOXeDpHn/Kjdn6TeqAWVL2CMtLlCOu
         JZpzxV5fmPN3VsjLnmivq0fprkm5VP45VMfwFZQcX13QK/9l8IvomMGFERN6wGBwjRbk
         jENXCAlGkHxzv0+fCe6CiiS6HdMdrNzq1/dW0qyRQN+IJXgrXU+5KhItil6nFwr/D14x
         U+DfW317nlixSx1OVFTJ6+XwYWE5HPKblbxcJTZjsEkZYM8ou9UcGHZZG9qnx6P1W8ms
         YCAR3V0Jtls3efGpveapvBQ8xeUuR0kdJDbpnoOf2LjIqOwRlE0PJGVjrvIzd0ux6Ukp
         xpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179632; x=1778784432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CukuR4C0VokxuACh8W7BiMV3ykO5i2dF/8Jc99UlNZw=;
        b=JR1sL9IWx6J5XpG+vLXt71WBOTmwP8SgquPoJj9PfsCbP+NyUO86BIM7rXsmx32PK7
         +klUxfvMb208Q7aiCNAl7PxBjtFoGht/wVVZi7KCzwb00ERaahmsb967DIl7T+m1ou/B
         GsFyNcjtFWCNLitSIU0JMng7nnnAkk6BFsqvd42aRcdzTZJSllNRliV8nCxoI1Qv1pk1
         BVbTOZvO72xdGBOVZ60GZflDK28FtxQmSJKX35LW6C3kQbRCWwuTfV11pTjzI67GMSeO
         oaCHnFEZ5KU8L44ka6vkNv9hFtKDi7X2wocWHMC+qL2/CRCKOkP55tuJlkuG2mZ0WOxj
         cd0w==
X-Forwarded-Encrypted: i=1; AFNElJ9/6DAIy5yoVul1/Vkit1963dduRwJCE8fiqtlOEyO8Gdj2GrElq0PbkSb5r6AcfKAom5/0Vw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6++ettV9rphp6KECHa4CIPQg1ZXq0jcXbHltAoZIxzZE1n6kN
	8khQZ2aMPEs+j7SvuH3RFQ3PmbZf3BDApdFCFG87BPUqfHeyqhQjS7R37DA3eVhyXA==
X-Gm-Gg: Acq92OEXr/7eoxyk/Dql4JRT0rHwIntQ+q4YLue1AUTgXMLAAKmRoGQiCXEdKuPt7IV
	78ZNf11abPHXysyIfvNcQYpV+XEtYEdnbsu0+lVbgsdJ6XoOu1u2peqbPDq3hVBXMYfSy5YTaVE
	jVPRZi2MEavNlvXhTEs4yO0u6TVsjR29xAcu8+wro316DWQTC9bnCzJ2M6UEFKrrCSjL1ElV2er
	82pyAxHXxEhBWoythhmCgihccUuIfBDDg8Q/BdSrk6JkA2yGJC91KFGIRJJsmUnv5tj49QOZq2z
	bp+DfZWz3YL0y3Rwq5ON0sg0z2pHKi04OX2W97T5uOdV4ZT17Z0yYJKVmOtLThbYcCqDoQ31m0q
	M9m+bE8jU9YqxNeL4c5YAJ8WRPhIYAkhukxyITVq57ergl9itSzarC3i6IMeAExti3/T+RfMUXk
	FaTS2lvuk3FGcbYbF4Ru4Pz2mp5DLVdhg2rZWdub3rlUsVM7sqCpvlIufM248ogVfZe3U9jw==
X-Received: by 2002:a17:902:d50d:b0:2b2:5931:5950 with SMTP id d9443c01a7336-2bae9e68566mr558665ad.16.1778179631231;
        Thu, 07 May 2026 11:47:11 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82640ca287sm278224a12.23.2026.05.07.11.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:47:10 -0700 (PDT)
Date: Thu, 7 May 2026 18:47:07 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <afzcqWa8iVqrhJLs@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
 <3874a086-98ae-4b94-8c1b-20e13f5a92fb@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3874a086-98ae-4b94-8c1b-20e13f5a92fb@linux.intel.com>

On Thu, May 07, 2026 at 10:07:43AM +0800, Baolu Lu wrote:
>On 4/28/26 01:56, Samiullah Khawaja wrote:
>>Add IOMMU ops to preserve/unpreserve a device. These can be implemented
>>by the IOMMU drivers that support preservation of devices that have
>>their IOMMU domains preserved. During device preservation the state of
>>the associated IOMMU is also preserved as dependency.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/liveupdate.c       | 162 +++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  33 +++++++
>>  include/linux/iommu.h            |  20 ++++
>>  3 files changed, 215 insertions(+)
>>

[snip]
>>+
>>+int iommu_preserve_device(struct iommu_domain *domain,
>>+			  struct device *dev, u64 *preserved_state)
>>+{
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct iommu_device_ser *device_ser;
>>+	struct dev_iommu *iommu;
>>+	struct pci_dev *pdev;
>>+	int ret;
>>+
>>+	if (!dev_is_pci(dev))
>>+		return -EOPNOTSUPP;
>>+
>>+	if (!domain->preserved_state)
>>+		return -EINVAL;
>>+
>>+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
>>+		return -EINVAL;
>>+
>>+	pdev = to_pci_dev(dev);
>>+	iommu = dev->iommu;
>>+	if (!iommu->iommu_dev->ops->preserve_device ||
>>+	    !iommu->iommu_dev->ops->preserve)
>>+		return -EOPNOTSUPP;

I will check for unpreserve ops here also.
>>+
>>+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>>+	if (ret)
>>+		return ret;
>>+

[snip]
>>+}
>>+
>>+void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>>+{
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct iommu_device_ser *iommu_device_ser;
>>+	struct dev_iommu *iommu;
>>+	struct pci_dev *pdev;
>>+	int ret;
>>+
>>+	if (!dev_is_pci(dev))
>>+		return;
>>+
>>+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
>>+		return;
>>+
>>+	pdev = to_pci_dev(dev);
>>+	iommu = dev->iommu;
>>+	if (!iommu->iommu_dev->ops->unpreserve_device ||
>>+	    !iommu->iommu_dev->ops->unpreserve)
>>+		return;
>
>Is it considered a driver bug if it implements the preserve hooks but
>not unpreserve ones? This would at least cause a silent memory leak. How
>about adding a WARN like this?

I think the preservation should not be done if the unpreserve ops are
not implemented by the driver. I will add these checks in the _preserve
functions and return EOPNOTSUPP if it is not implemented by the driver.
>
>    if (WARN_ON_ONCE(!iommu->iommu_dev->ops->unpreserve_device ||
>                     !iommu->iommu_dev->ops->unpreserve))
>        return;

We can add this warning here also.
>
>?
>
>Thanks,
>baolu
>

Thanks,
Sami
