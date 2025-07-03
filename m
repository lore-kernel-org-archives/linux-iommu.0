Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2AE1FFC46
	for <iommu@lists.linux.dev>; Thu,  3 Jul 2025 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751580848; cv=none; b=qpKCsnmGtIfDRyySdSdweKwH9W8FHexHRVxU8+1HEvFNammeA2yGFqImCFlwQyn4aXYIahXT+TWoCERm4I+vJUmzulGRdSLlq3yE+B5U6AvjgagVcpGZNxD96L6vw+pwfK3UVvHb5u5Ih34DvZXFqILuRw1ZVIGf7FMoVLrb3iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751580848; c=relaxed/simple;
	bh=UkzW8Ro69MEnCly9rrVk9a1BN9hioGbdCMPz+Y+hFRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mw9G2EOACf3V1d6/sS2MuFTd8XJlgxyZkW+0c8pE1DVDb5QzrKv+r3vhMiKBS7bVvd5aCUDMdQAm6x4I1GJIN0CagYCvGk9cfPV27mTp+xwMXP75dXHZVMCRD7queuwtgHHI0g140dkl++3ybtMqXOX591ReSNTjw7fGij52ko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ueO/fa3E; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ueO/fa3E"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235e389599fso273385ad.0
        for <iommu@lists.linux.dev>; Thu, 03 Jul 2025 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751580843; x=1752185643; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MuHvBdZctEtzhPELFeCYnZqsR6O+CCEh7cw6bo3Z+rc=;
        b=ueO/fa3ELf0tubhn2XM21xdao2CGpP2WY8DIH7pWC4kv22QzRYKCuXXOl0hHEwYLD0
         4Fx9AlPtkRwYAhPhCnpIW1xCTn+IvTg5fdnnypN3MMXge5A/kkd44co4mldS4MbdjZa/
         FyCtE/iCGHYsRJH5SkFOTgU0dCMkkty/ru9y9+iJ1U4pfeP2djaZfBNRkVZGgNyyaUm+
         cI0RKLFT7G0+fTYlfTIAO2+Ek8XuuiFGuJR4NE6Le9mhP83iK8HCyUhMwOEgObJBePdK
         nsbq/+vKMPNNLJp89iHe8gZFtbI0wnJ7jPx+zij1H9+gQeX7dQ1+EmcIAuOY/HPkCaeE
         qi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751580843; x=1752185643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuHvBdZctEtzhPELFeCYnZqsR6O+CCEh7cw6bo3Z+rc=;
        b=Za9E4b8CncU0cJRM7SokXi4jOdA6vaIBBhk2PXQ0HyX4o6U7XJtJ2C8Dt+LVcxpK3r
         MhZnMzJ4chb9nRQe7jrUiIx5KwVDNJXKqNLle897cZUz67gkEQRQEOU+Ese47U5r/JTu
         Khonoq/QRdorEcv9IUBbAsj0U9h3oDwq904lZ2CnyF6nP7g6hAHEEY2Nn9EEq1e35BSt
         CZ8DeovT8wNH7ns/kmQVSwhCS5HyQrpNxwHRejQdVALrnYAwenO8NkhH9Uu5SquhRj0+
         xCWv7LAofRnRl6DwXzVA6eTEpZnciIJsfILy6t+yMvqOTka/hHvxGNUHterwqtOb1WKd
         itEA==
X-Forwarded-Encrypted: i=1; AJvYcCU/0arZtlIHVubDLLTSI2mf2Dr3V/RNfnnyRh36BmU8hf0nDbQAPQzFxnVYw8JSP+975+/mjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFJkrcn68IuRB6DveKyUa7scX8Ptprj0qNUFeg9UJFDPYWi3aH
	zQykjzW/PBAh4ELwoMODgyXaG46BVE/VIvaV7H25bQwkHDwhQvOoscRlpZCte44grA==
X-Gm-Gg: ASbGncspcMRfi2TG6PJhOMaJHkvjuhOUw4L5UjKpxWF5EroKuvBrFuCEI4RDA+CaQTH
	ip0AX+RCb8sD3Y8njMjZKv7A/BeZUPDte+f1w0nOpLyCA0v/nohUQM2qo61yN9TSwlJNDgS9FZM
	urfRorPKoOZn3iuIn+zIYakdMkkthHTfR++kU/bKZ+kQnR6VJIH+4BNF7A7ZiIZA0MTGhy/I/2f
	trd3ECelE5LZlXqsjf5nciiadNc9lLwLbAhs7Yya/b3v6C9M5Fvuy7FfjV2iDVBK+GSIbzCR9z6
	oc0MfsqzK2W6sJU+SYHjfCW4YWO01m9idV29kvUzvdO2CYmOg1bczTBDjeD4wjVkxHCN7XR0Cam
	CFeZMb4i4jqwLWtY9HuPdl5ggpxqkORB3+CKGkA==
X-Google-Smtp-Source: AGHT+IH31YOAgpp6cWXPyDDiSdW0FsgI8z3zIJNlzWY7vAq0H2n7kS+w2YKYWOMSnIdeLnEkqfRSUA==
X-Received: by 2002:a17:902:ebca:b0:234:9f02:e937 with SMTP id d9443c01a7336-23c7ac250c0mr3191765ad.25.1751580842742;
        Thu, 03 Jul 2025 15:14:02 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455ec28sm4302055ad.117.2025.07.03.15.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:14:02 -0700 (PDT)
Date: Thu, 3 Jul 2025 22:13:55 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Rolf Eike Beer <eb@emlix.com>,
	Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Nate Watterson <nwatterson@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: arm: fix building smmuv3 as loadable module
Message-ID: <aGcAo3pUwdsa-mON@google.com>
References: <20250523121257.2340274-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523121257.2340274-1-arnd@kernel.org>

On Fri, May 23, 2025 at 02:12:53PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The smmu-v3 kunit test fail to link when the SMMU driver is configured
> as a loadable mdoule:
> 
> ERROR: modpost: "arm_smmu_make_cdtable_ste" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_make_s2_domain_ste" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_make_s1_cd" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_make_bypass_ste" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_make_abort_ste" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_make_sva_cd" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_get_ste_used" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_write_entry" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> ERROR: modpost: "arm_smmu_get_cd_used" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
> 
> The problem is that the drivers/iommu/arm/arm-smmu-v3/Makefile only gets
> parsed while building modules, but the driver itself is accidentally marked
> as built-in unconditionally, so not only does the kunit test fail, but the
> entire driver is missing.
> 
> Change the driver configuration back to $(CONFIG_ARM_SMMU_V3) so it
> actually gets build here.
> 
> Fixes: e436576b0231 ("iommu: make inclusion of arm/arm-smmu-v3 directory conditional")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks, this fixed our allmodconfig builds downstream.

Tested-by: Carlos Llamas <cmllamas@google.com>
