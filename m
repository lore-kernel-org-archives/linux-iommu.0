Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B3F156F44
	for <iommu@lists.linux.dev>; Wed, 18 Dec 2024 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511215; cv=none; b=VbHo3gJ8mgTFO6EsOzcirPlQYriytFprH+d4H3y4+S2ijntfsPxs7yHOYxfQIye+B+Zsg6S/xuvnq/YxoFVm53qu9pVKXNRXKhdYKl5lrFe/QNkTOJcfHyPypzEf3E7UTr4UIkO9c2W2w2qzQ0Wq/m1K20/AefD8tt8E6C1fZqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511215; c=relaxed/simple;
	bh=MV6KyVfXoz6PKOZWMTqYD+2szsG/qGUie4tUdM4jbnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PToGQ8c+MhcaaTW7zMvUj/4OlZv9fnVoqVY4P9BCwo74bGpEX5CWntgIJhWMu8JMBoiNj6CU9gTeAdY2wosjVDIRKKP0rTKLgSl5vN66XeDMQecAuujw5CcyDgl+N61yqHWpo3eQd5HDQwO3ueqRlXLEwmmjP8UBuTr8IC94Kb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=jwMYFleB; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="jwMYFleB"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0E86A2C1E66;
	Wed, 18 Dec 2024 09:40:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1734511213;
	bh=MV6KyVfXoz6PKOZWMTqYD+2szsG/qGUie4tUdM4jbnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwMYFleBfIH5EjtdopEG/WNOvS6eQh8D3OcZO1Wj8ZvCyPCcOIiNrumrQk4OhXsHT
	 qKLufnH0qpRJlNDW1YiVLK0wbx0jslFfBhitJokECoashxDH75zWKiloFer2QwNzCO
	 KxQ40EdBXw7PfbzijsGydBKZj3jTo3b0nKkZL3yXh5+e9I/oWayJ5H+AlEYUq7gqW+
	 V6etIZb71h68c9fZLxSE1YKaBkHDai0VNJmVzz9RBqu3r5a22qWyJZHUk0bQTFOT4F
	 fYQ83+/myzHP4tnuMod9kRd0b9QaXekuiMXICmcsVPhUNTk7/bhQ+cTiIamMYixaO9
	 N5gvZXAEWLdGA==
Date: Wed, 18 Dec 2024 09:40:11 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yi Liu <yi.l.liu@intel.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	zhenzhong.duan@intel.com, vasant.hegde@amd.com, will@kernel.org
Subject: Re: [PATCH v6 0/7] Support attaching PASID to the blocked_domain
Message-ID: <Z2KKaxftA52hAXN3@8bytes.org>
References: <20241204122928.11987-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204122928.11987-1-yi.l.liu@intel.com>

On Wed, Dec 04, 2024 at 04:29:21AM -0800, Yi Liu wrote:
> Jason Gunthorpe (1):
>   iommu/arm-smmu-v3: Make the blocked domain support PASID
> 
> Yi Liu (6):
>   iommu: Prevent pasid attach if no ops->remove_dev_pasid
>   iommu: Consolidate the ops->remove_dev_pasid usage into a helper
>   iommu: Detaching pasid by attaching to the blocked_domain
>   iommu/vt-d: Make the blocked domain support PASID
>   iommu/amd: Make the blocked domain support PASID
>   iommu: Remove the remove_dev_pasid op
> 
>  drivers/iommu/amd/iommu.c                   | 10 +++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 +++----
>  drivers/iommu/intel/iommu.c                 | 15 ++++++---
>  drivers/iommu/iommu.c                       | 35 +++++++++++++--------
>  include/linux/iommu.h                       |  5 ---
>  5 files changed, 48 insertions(+), 29 deletions(-)

Applied, thanks.
