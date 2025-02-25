Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7C1FC7D5
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506395; cv=none; b=W3pIyxEu+DmUai16Vku49T308+pUkNhIcaxcs/1q/9iRSegK7SNCnZTY4NHi7PX9TK8YGpaHZiLN69f3gG4S3u+vjJTqj3o9AyrQt8ypF1ZFzHelvGNBUI7NIlddPWH6i+bIqKnJUFpOvIbWvkvgKrz6EsgirbfotOLwmyqCr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506395; c=relaxed/simple;
	bh=t+3/xgTztA90riGckbgrI9IzG66KkbXPYhDKFDRxAeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnqt5QYvU8CFjUJZeDyqyAaQ0EJc9hpGrrKNU3yWOl8JIYI7ptUSGJc40w7cql16Wp4aCKJxh7HghzJDrVb5NQ6GniNEPXQpRoM1hstTnurklk1nfb4qVPipq9fryi/kDWwj+xqWES4PgYWsD6IrfJmXHrceMYmAqO7Cf4ImKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=omoHpupr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="omoHpupr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221ac1f849fso3705ad.1
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 09:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740506392; x=1741111192; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zet+c1c4ONj7xvmenDNyn9l5ztIYraYudvekwtRFR4g=;
        b=omoHpupru8f9xcVj4QPXcpFIlP5h8TLFOaRkqRC83hq4Bi2NSXAwu4AQh4pb61ZN1h
         Xx6ly2m8+7rvP5/CPAQm8bA4nzTqmF9ReyuF7Ey6r+4/IxXMQ/NovqwCQSDVg3rnVONu
         Q4UV4oHp5BcmJEqHZKairm3lXmQ1j0St8/pobLCGg30+5uItq9UqzZkYTemDufLZa2Aj
         AfdnfCRfMAsMSBRS+g9T7PSakf+XrGjjw7YUQs16iMBJq36TfVti2CGSRxcS737OUw1x
         VwW5HCaPvV9hfFRf49MFwiJ47so8fH7QoZTjcvvZOm92a1E+UzAPVGXnqMnsvn+TJm5L
         zyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506392; x=1741111192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zet+c1c4ONj7xvmenDNyn9l5ztIYraYudvekwtRFR4g=;
        b=CwkdvhiE6G9ztTHXcbdjt10CsmZ6Px5rGm7g2UnrM20MMlqpeWY+rbxO6T2yEWBZEC
         QolqPXGxrmso0ge8FxerPAFSTDrixh76e3zlbYdcO601BgeSbVa2whXB/nNrUPn6ao7F
         IhBtjqyk6N0n3r/f5Ni1KCzN+VY6aMnQCB2p2SRmwnOQrFD7SdfGnuw4YqJePap396ko
         DcpBbQcsKnIBe6kON9Q+62DjTBD9pwJqEOEHQWuT6kSIHTn1uDgbVsbkGLPECUehk4Kw
         jTexzz5221tg2mFvzSRf+6EUdAFJwXF/Z4LVE+9M8tZhugWbgh9D+YVZZeP9wUaIHP4b
         qTpw==
X-Forwarded-Encrypted: i=1; AJvYcCXZZdNKZ3GlY0Ce0IJ1Bv9ny1/wklFtY2Y1ta6UhSU/xrBlbpslp23x/YQL/EW6TqUt3/aT7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6TUC9e8ZMVdDS7BQFe6wBpRNpbG/kLpk1bw9RPvpWFumH3g0G
	CmKP8OZWpYRSfu3DynxpYzMMRnuKkQ18HAP2lU4fPnMXQIG1LFeJ0S95Nxq57w==
X-Gm-Gg: ASbGnctUCPhl/190IcgKxuHdfpSbO2Fe/R5kXImtlDOKtDG9VKm6LCjR5fqraJPgz/t
	xRrr4dvo/QvegwZnZA07wC/79ZwaKUt+ftZhg1SQTaByH5YqAEQPrvgyBLoN5F4V6rDs7I+gUeP
	9VF0EJvd9TGuQXkwZWWIWaC3/qU2bKOFyYtAaWJix5VwIqH5pmL1zmcCLhVxo8P+Cu1Jm+EhCvn
	dKoqzPcQCcCPQm2c91Lkz7Z7zMM5y+MAF4ravJVUaW/uS3fQOFalR7X9krxrxCdT59DgzDJm/kr
	/c+NhoocYsEzQhLBXQTlXaRDqzc+uEhIjQH0/+O3sXfGpbU4/rQArZDR2yQ/q7Q=
X-Google-Smtp-Source: AGHT+IHt1jR5XD9845sVRfVXJk9oOqx4VZihn8kcHDN1a+U5MuzF3NMe86gHqr8wYv7wnn00ZADsGQ==
X-Received: by 2002:a17:902:ec85:b0:21f:631c:7fc9 with SMTP id d9443c01a7336-2230798c8c9mr3956505ad.0.1740506392319;
        Tue, 25 Feb 2025 09:59:52 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f8ec9sm1867028b3a.53.2025.02.25.09.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:51 -0800 (PST)
Date: Tue, 25 Feb 2025 17:59:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v8 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <Z74FDTtZkjwrjv29@google.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <f465dd9defdc0fc748c2fa2cfc829e37778a4ced.1740504232.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f465dd9defdc0fc748c2fa2cfc829e37778a4ced.1740504232.git.nicolinc@nvidia.com>

On Tue, Feb 25, 2025 at 09:25:42AM -0800, Nicolin Chen wrote:
> There is a DoS concern on the shared hardware event queue among devices
> passed through to VMs, that too many translation failures that belong to
> VMs could overflow the shared hardware event queue if those VMs or their
> VMMs don't handle/recover the devices properly.
> 
> The MEV bit in the STE allows to configure the SMMU HW to merge similar
> event records, though there is no guarantee. Set it in a nested STE for
> DoS mitigations.
> 
> In the future, we might want to enable the MEV for non-nested cases too
> such as domain->type == IOMMU_DOMAIN_UNMANAGED or even IOMMU_DOMAIN_DMA.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Pranjal Shrivastavat <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 4 ++--
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
Apologies for my spelling error in [1]. It's supposed to be:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Correct spelling in [2].

Thanks,
Praan

[1] https://lore.kernel.org/all/Z73zvIbsXzJMCaNt@google.com/
[2] https://lore.kernel.org/all/Z730M3XptvDRObBp@google.com/ 

