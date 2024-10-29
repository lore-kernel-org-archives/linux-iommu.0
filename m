Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A0F204010
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191653; cv=none; b=mfi9FjX3OOhfpl0V7Cl8oTaqzCcpdwzCOfuhld6P/svauqz9n5Kc6mJ8o7RgAd19TvWPM+VDo0tg1NARu+ykCSq1EYCM+6dGvrQ/bbU86WvEVb6jfmWijg1eRthB2uO69INCH9rfCvxVhN813ZaCgkt7y9uCNM6DPVbijmMOPxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191653; c=relaxed/simple;
	bh=XfLPgZoKaYtXEXGmKww8zptgV1cA1uLvBl++Yge3U1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO8rw4apkm5F2AGTFxbNgjlTUCuGoVSa5f/NNpJoWRul1HfivfyxwcDiyVHqTMPvtg0gExSwp6sjjutay/NvXyC58XAk5RYT0W50tX+NvbqfdguJaUSqxEgwneOP7u4RLUG2A9AFd3Sir5JuPRKfBn9Mka3mJQxKqXNyhX4V2tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=JU63KdBd; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="JU63KdBd"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 78EEE2A8D41;
	Tue, 29 Oct 2024 09:47:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730191649;
	bh=XfLPgZoKaYtXEXGmKww8zptgV1cA1uLvBl++Yge3U1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JU63KdBd9rYxyp2PP44QhArOfIWFln2SBvXl6q/JGEGqjVgdTuycykEM6eV4QlZaq
	 9+D6XMnYOalRNQdfDOmC9HD07WBJg/cIH/+pauHMtzkUWgdOee+GmG6d7Z4nvVKybe
	 IS5L091vp412GJ9FTYx3c4h3E/vkXVGFPWVCOFRRBsJ+du6eXUGw1sWL8iaUOv7eg0
	 5g2TSf6navbDDDgtFZUj3HJmuKBuwbb6smd+ptx8wVEwqm6OVxA5/f+nm8nBKzByAw
	 UuTaT6N4MRf+DYXZeukBSlrgOF1rcGTAZPewfkvCE/sTVBunBcCMCok1pndTeYhWUs
	 zuVwakOcb28Ig==
Date: Tue, 29 Oct 2024 09:47:28 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu/amd: Do not try copy old DTE resume path
Message-ID: <ZyChILrBGUFJx8E5@8bytes.org>
References: <20241016084958.99727-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016084958.99727-1-vasant.hegde@amd.com>

On Wed, Oct 16, 2024 at 08:49:58AM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/init.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Applied, thanks.
