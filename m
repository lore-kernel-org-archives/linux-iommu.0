Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C4A42EEC4
	for <iommu@lists.linux.dev>; Sat, 12 Sep 2026 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202622; cv=none; b=dH/XM8/LVnks5SmOqAjqIe2yFje8SGzpb5Ay3tOZGZnSKk7DQpd6RsF/An8Ai4tknXVMW71Em4BO1hS5mcbIydytNxtwRotETaLEwakFNXcekuLPw2lz/5a8ETwfOFZglRm87PPKEq2nu8kVWs3qvM7/hMDt7aOYGwnnX8zZ5Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202622; c=relaxed/simple;
	bh=l7p5lwMjBfG5qbG8xJJqnlpiR912yHXTgSRMsRX85bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF+9NOSi+TtrO+wtdNwwlVRVkEMjxkQIQkf9fCOkZB1fsMl3enoWiGs/7Om0D23HQUsBbCNGbbcDBUP0HBT+9T0kQt+TVZ/sXG+bSPA/WntjeVtsQf6B+R7POI4ZRnkecm5UKg9B9wwIdtXO3dAK18a01kbKNuTZfld25YxpHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1383.dip0.t-ipconnect.de [79.254.19.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1B50D20AA25;
	Sat, 12 Sep 2026 10:43:39 +0200 (CEST)
Date: Sat, 12 Sep 2026 10:43:38 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 0/4] iommu/amd: Cleanup and fixes
Message-ID: <aqUQpHj2MBYHy-mq@8bytes.org>
References: <20260911083353.4812-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911083353.4812-1-vasant.hegde@amd.com>

On Fri, Sep 11, 2026 at 08:33:49AM +0000, Vasant Hegde wrote:
> This series contains few trivial cleanup (like removing redundant
> checks, unsed macros, etc,) and fixes.
> 
> Vasant Hegde (4):
>   iommu/amd: Make iommu_sva_set_dev_pasid as static
>   iommu/amd: Remove redundant check in irq_remapping_select()
>   iommu/amd: Remove redundant checks from interrupt handler path
>   iommu/amd: Remove unused macro

Applied and on their way to Linus, thanks Vasant.
