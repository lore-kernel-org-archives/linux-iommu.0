Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B8242D69
	for <iommu@lists.linux.dev>; Fri, 26 Sep 2025 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758873810; cv=none; b=kJlZ+vTDABkDdFVboOHNDWVEYqjA6Ee3Ixgbc2g8L5XHjDX1fa7hkI5y1JOu/xhECDsmKaoYsukHlFCSCwhMQuWMDrPToAPwsumxti3N1YatjQlWNSOrY8LvqyMoThyOtaZQIEJo3BmWXnFODk8XES0E2SpdM1Ngg0a8jqySbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758873810; c=relaxed/simple;
	bh=aknss2c4TjsEbw0W4xTW3NYBRTnEebEtwOKbSYPdURs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzLlCHxctmbHR9aMZ0U9iig3HamNg/3byqqUSuSnHyjqY0BHgsyUpYvA+Gt7rRwQpOYiazGCoKqiyL8zYBxB0xLTiNmtUhi77bCaxB+oO/dZO4aePfyQKI1zeAK7D10KJyN3h6S01SBDfahS7NkYPBfAPXC6OTd+VSnkyDm5eRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=kH3JhuuO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kH3JhuuO"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0456E5653C;
	Fri, 26 Sep 2025 10:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1758873801;
	bh=aknss2c4TjsEbw0W4xTW3NYBRTnEebEtwOKbSYPdURs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kH3JhuuOoYLh3s2thS1edOqEnGbkVbxEb1I05EXdxq3R2VozvMtz9wCxA8HvtiqqE
	 smz9fpeewu9CK0EALC+RS4bReXfYhpYP+ChtSzZ2WDDb5tJsd+SPkoX0Hv9bgrGCYr
	 WvxUFF/YKXwHKICn0S4rlnTj392lxw1ljY1chvCTb0hTerXcMfGH2WUmEYVNokkC0w
	 BX3oBbBftUfOmpiRushz9VZ9GY6c1nEnnId+wnndkNQxGaoHtB4pQUd8XL0YYreCm2
	 fG9PFv2P+ZOewBK/PIyqmAgYnZubDwiqQSSn8HDZkGBSb2LthwK7QkLdfGiz4LTyDn
	 Mp6d8udCEZOZg==
Date: Fri, 26 Sep 2025 10:03:19 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.18-rc1
Message-ID: <q444lw2d26oikxwmuasfbrb3mzeey53uvmk6ztmq3r2h6ie3qd@4hbemjg4kv6w>
References: <20250926024130.157514-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926024130.157514-1-baolu.lu@linux.intel.com>

On Fri, Sep 26, 2025 at 10:41:29AM +0800, Lu Baolu wrote:
> Lu Baolu (1):
>   iommu/vt-d: Disallow dirty tracking if incoherent page walk

Applied, thanks Baolu.
