Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB72F5F483
	for <iommu@lists.linux.dev>; Fri,  1 Mar 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298336; cv=none; b=NngL5SQLonBr1+WHm7fOyinRli17CGR5vQyR7bcY4PrWdsX+4yXYIOXhbqvgWHBixxk0IMOPr4DtdOSb2ldirNJopCd/iiRjNhHXF71qDsDaSE0YTNbHaf+K41qiaBwb2LepE5VMJ3hmaKrx0lc8YpZEeUPxPAjYN94P4T7hHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298336; c=relaxed/simple;
	bh=h87fasa27cwtoBBQjvXIjHlGyU3m9Dzkdm2Y9DRzkWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9/jJhS+w5wl9gWUesMYVmvjxioy2j4QUmEt91BIsWEgb87MKj6WOegIsVxxlhC/hm4yRg5mAEwHAqCG1tPSm5KvtJFmrTJD8TirAHJhlouqzj7PEdi/gcrYKywCFMDszQuIOEoah/JnrfM0kFbsgv8daqSLo2BbmIg8qEbG0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=PwyaIrZM; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="PwyaIrZM"
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9CD761C3319;
	Fri,  1 Mar 2024 14:05:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1709298332;
	bh=h87fasa27cwtoBBQjvXIjHlGyU3m9Dzkdm2Y9DRzkWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PwyaIrZMvEDiRkn1w3RRVKwKcLH7gVN9YmfA+1JNlxPxgpZTZUY1YPqVIgS74FANV
	 Hy7wtBA/WK8VBIjymPcAYzMRwU9v7zzF63jZqA/uAkinrHN0orLvI6y1HQWZojtZ86
	 6g+pBykzn9Kz+t4+kOwJDYSYCtFTj5KXAW2n8TblH1c+ta5UFJndIdiw1sNHhBJUYQ
	 lDsKyOITVAsQ6VPBT2Dknges2eIg2twE9ec/u9zJar/4oxMoYitY9lOxuMg7xKtE5B
	 CAMm1fiPUxobr/x4R05ne8ZC+YMxtplxxmxYDOTK1xBgRPdQhL9k6eY+PYOTrFrZS7
	 JVHEp5kAE2l3Q==
Date: Fri, 1 Mar 2024 14:05:31 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.9
Message-ID: <ZeHSm1vSj7sfDeNB@8bytes.org>
References: <20240229181533.GA16854@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229181533.GA16854@willie-the-truck>

On Thu, Feb 29, 2024 at 06:15:33PM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.
