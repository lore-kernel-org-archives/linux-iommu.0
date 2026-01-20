Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFA13D3CE9
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900603; cv=none; b=TOU1rkA5n8ZviuHeJ/81uAXnvkNGaZR1YohI5KjhPWoaUYm5VEiP9wlEjcuLP9HLjpX+/fQyIJP7CNEKy/PUeXiCF2tCroT1dojA85GodrenwWRmHC5rAdJdWIldXH5Vnp50CrFb3QLK6EVEIxsDMVSloK1D6gnYVe4+ZyV82Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900603; c=relaxed/simple;
	bh=61QirORLlFi3LIg+ahRLOdg0TcDAiI25XAn7W2oJ5Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kno+1GCsOgIGqqnInJytolZHrbccqy4Ty+5a+NwxBcrbMrks0Mu9h9KdYHPr6SFAxKNJezwQjORa+M3L6vCQTF5u+25dVsiB7PTNGKTahTYs4HjIhpSU0+sleRZD/dp01Y0MmgKP9PW502rw0Ws7J3/ijJrQmQItyWM4RvtYYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=IKEsJEPe; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="IKEsJEPe"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BE1705E2F3;
	Tue, 20 Jan 2026 10:16:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768900600;
	bh=61QirORLlFi3LIg+ahRLOdg0TcDAiI25XAn7W2oJ5Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKEsJEPe9gBYlUpSEuqdToG9ukMkwRgl9wrpefwJbF9pGwIJRoMMoGdSAJjNKJaGD
	 wBiVsoHKIzbFPXKBANIL5urTs8gHga+Nbsf3xv6EjbBo/EC9lrlO1OC7HfN7qLo2yW
	 bAiTM/cO3+7PwYPQIf1+OOUgs1xCIOsoxOxedypKhxvnH6p/OegBNIFsFWtFmUnaHj
	 YndUR1q7u3bE3KRJqqQ/NeskwRXjCz2l90y3qrzU+tKrRoMZ6PsL9kgz4RHy50xpY9
	 V1rUsTrRYbv8/RbYLhKhtR3uzWwxBrn2ZWBqrHUf4c49/Haku5DIMfNfXfjMuz4Oef
	 MDdwMdU0sovaQ==
Date: Tue, 20 Jan 2026 10:16:38 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: jgg@nvidia.com, nicolinc@nvidia.com, linux-kernel@vger.kernel.org, 
	robin.murphy@arm.com, will@kernel.org, kevin.tian@intel.com, jsnitsel@redhat.com, 
	vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com, 
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com, 
	wnliu@google.com, gptran@google.com, kpsingh@google.com, joao.m.martins@oracle.com, 
	alejandro.j.jimenez@oracle.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iommu/amd: Remove unused variable in
 amd_iommufd_viommu_destroy()
Message-ID: <34ciedtkjkjgzr7kac7qkzfj4knzy5n5hvcc3viv6ntbxnju2o@coabxzqielmb>
References: <20260120014843.194645-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120014843.194645-1-suravee.suthikulpanit@amd.com>

On Tue, Jan 20, 2026 at 01:48:43AM +0000, Suravee Suthikulpanit wrote:
> This fixes warning reported by 0-DAY CI Kernel Test Service.
> 
> Fixes: 757d2b1fdf5b ("iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain invalidation")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601190634.bl7Mjx5Q-lkp@intel.com/
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommufd.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
