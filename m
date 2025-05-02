Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383DD1A239E
	for <iommu@lists.linux.dev>; Fri,  2 May 2025 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746167924; cv=none; b=fP0GaGFSzM9KDqnWpf+QLwiC/Boe8pJBqEKub+6tC7v5d+yJ5bmtH+cpR8Y/dGXWPViRDGZdr7H+8F+QYXiJ9zekV+OEXik/lrQne7bv+qx+Dh1pkyCGqW1z9GXIA9+hirz28iu8Ky1yqTMNmagj6S9rzZY673lvdlxOeNbckuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746167924; c=relaxed/simple;
	bh=SAQBi96O1Qyh69y3TbdSGDLJNE38sCOnyxFkFvBJEoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USqx+uMnf6h9bmoeCKc57tu8a6zLwVvkYGB4WAv7sqEMHTknxcjllTaLri/i3gXvX3gwu9Z2In2TguzvZxNSBLz9SCq76mMsT1p08vmcJLQx40srshcFR+5ucrOLSRh3Hnrugkd5rZMU4Q1W6XcZd9b/Yn3CeMHU3YWDfqe9Pb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=BzdDEgyz; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="BzdDEgyz"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0500649B71;
	Fri,  2 May 2025 08:38:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1746167920;
	bh=SAQBi96O1Qyh69y3TbdSGDLJNE38sCOnyxFkFvBJEoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BzdDEgyzkC5En37s1JNWMXXJMa8Mv0FaJW8+Hgk9byy5pLQgtsoFHyidfQ1gtYpDx
	 iYZv7VS+JuUay23yJhsleBcNgyhgg9EqLejjjF5Dy2/Ar/oe6WDEi73/cd6GyiQL9p
	 lTb7kpu+NnD4Qmh96D9k5X/t17B26aY5CW4CujfIb9ikqSbZzCfzomZS1I4QKw+5nM
	 K7eMNpHq/j1xXZWgWtvv5O1S1ScKT6HCWd0JrpgbzFhKuI0O59ydQWMrvFezamtEAB
	 5jk1HUcDHuk2uFBoFihkkLx+qKdvwyN7vRTC5WPl6e2cdErLB23PYhLbJ5mtakdXLI
	 tk79VVk0pe0MQ==
Date: Fri, 2 May 2025 08:38:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, vasant.hegde@amd.com
Subject: Re: [PATCH] iommu/amd: Add support for HTRangeIgnore feature
Message-ID: <aBRobm_aB3NWduBG@8bytes.org>
References: <20250317055020.25214-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317055020.25214-1-sarunkod@amd.com>

On Mon, Mar 17, 2025 at 11:20:20AM +0530, Sairaj Kodilkar wrote:
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       | 2 ++
>  drivers/iommu/amd/amd_iommu_types.h | 1 +
>  drivers/iommu/amd/init.c            | 5 +++++
>  drivers/iommu/amd/iommu.c           | 3 +++
>  4 files changed, 11 insertions(+)

Applied, thanks.
