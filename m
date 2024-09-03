Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB61865E6
	for <iommu@lists.linux.dev>; Tue,  3 Sep 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353108; cv=none; b=UV9hE7OwaUvT01cuygeq7ypr1LwVIgVrpIsOBhKZoXhcsMbFOgrJK2Tka2cUAl0RghFBRwDDju6717/hHIt3di42Ut8Gn/mfyf2tfI5F976xP/ShBcB3EHfvbmW+HHdCx0iKGuBQAD8gRfS5TYDVbeZ1hpJUFeDSYFCPDyUJa+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353108; c=relaxed/simple;
	bh=nyT7r5MZqhPt0BIuOIy8XqrvxLElHINde+6SX1vLMs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avfDbKNW9AUmeIcYsObdDUVuspHkBMUMH2hn30KpeQG5sxUJXjN6VH40hsFoue3MMagwm9dZC0LnXQVF0AoyrFKvP1+azdud7MuNSbf6/NcHzdkNtis0IWU4tU/dBDGPPNeUq15z8uNB9kMXoNAkyWqhsk8DP01H2fRf+7Mau14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WyfMN2t7pz9sSC;
	Tue,  3 Sep 2024 10:45:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o718uC4gj9KF; Tue,  3 Sep 2024 10:45:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WyfMN25FSz9sRy;
	Tue,  3 Sep 2024 10:45:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 37A688B76E;
	Tue,  3 Sep 2024 10:45:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id UFzvyiGJCqRY; Tue,  3 Sep 2024 10:45:04 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0D72A8B768;
	Tue,  3 Sep 2024 10:45:04 +0200 (CEST)
Message-ID: <966741a8-7df7-4efa-9105-f5762f75fb44@csgroup.eu>
Date: Tue, 3 Sep 2024 10:45:03 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] soc/fsl/qbman: Use iommu_paging_domain_alloc()
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20240812072527.9660-1-baolu.lu@linux.intel.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240812072527.9660-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/08/2024 à 09:25, Lu Baolu a écrit :
> [Vous ne recevez pas souvent de courriers de baolu.lu@linux.intel.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> An iommu domain is allocated in portal_set_cpu() and is attached to
> pcfg->dev in the same function.
> 
> Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/r/20240610085555.88197-14-baolu.lu@linux.intel.com
> ---
>   drivers/soc/fsl/qbman/qman_portal.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> index e23b60618c1a..456ef5d5c199 100644
> --- a/drivers/soc/fsl/qbman/qman_portal.c
> +++ b/drivers/soc/fsl/qbman/qman_portal.c
> @@ -48,9 +48,10 @@ static void portal_set_cpu(struct qm_portal_config *pcfg, int cpu)
>          struct device *dev = pcfg->dev;
>          int ret;
> 
> -       pcfg->iommu_domain = iommu_domain_alloc(&platform_bus_type);
> -       if (!pcfg->iommu_domain) {
> +       pcfg->iommu_domain = iommu_paging_domain_alloc(dev);
> +       if (IS_ERR(pcfg->iommu_domain)) {
>                  dev_err(dev, "%s(): iommu_domain_alloc() failed", __func__);
> +               pcfg->iommu_domain = NULL;
>                  goto no_iommu;
>          }
>          ret = fsl_pamu_configure_l1_stash(pcfg->iommu_domain, cpu);
> --
> 2.34.1
> 

Applied for 6.12

Thanks
Christophe
