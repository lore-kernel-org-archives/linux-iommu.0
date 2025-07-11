Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4022EF28F
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250459; cv=none; b=p57hmdb3Yw1CvENf4h2Ro0FV3XSPzqOecRngfsbSGQYWPGw0kSCVGWVBFOoRSJz6PgtwZ2VbkSuZM5Jc6U3eKA0kMjU2RiqkJx1nixmcKdqXFE4LGIOict9a2jyom9lZw6DpVv+6pH2/NjIk6VT5pEOminIKF1K/3o8XJTGzMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250459; c=relaxed/simple;
	bh=GePTBPUGrrwsRz9pdDEyuSfHAPi7zB169H/6HRYPsug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUHwVTEC02ykXoo7lD1q9iqgbv0vzqnMCqy0L7SnBtr71VvCMaSx9IMmh+ERpOS1JSdMdBcdR+MVg2QDqZg84nVoTel7fWYfpQwNe9JGQVRsBtnVihfJp2N+asVwJz3MbY7NuuJrUfJhaGw+Pqt2dm0lzUsuqwmgzK3unEMKVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhjyhKjE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhjyhKjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DECC4CEF5;
	Fri, 11 Jul 2025 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250458;
	bh=GePTBPUGrrwsRz9pdDEyuSfHAPi7zB169H/6HRYPsug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RhjyhKjEdyL2XlgiQbu5DZPleCFBLlKuL9qvp4+Dye4MNcgt2qNcwbotciP+LBrsr
	 wE6zrWlZk8YSzXdIfRj19vmrso5eG4ytdVb49ehKW57W/on0fKkY37WmgI0ldZH7Wj
	 CBArxbCqAhEM+TB42kUNl33JUEmlpllShe0s+5kSzbtHEococI4ExQiT5CbpRjcg/1
	 twgphtrzJ2dj0q+mimXroYIiI4NhVLixPyaRByM1ZKM5we+/xde5ifSzz0miDPVu9M
	 V6mRb+em44TVrVSfjTWFBD+YOVFIU1Vwfy7hWL9ZtA/Soj37YJNC5UXReiXUMYoJAu
	 KSIpF9oqwsqWA==
Date: Fri, 11 Jul 2025 17:14:14 +0100
From: Will Deacon <will@kernel.org>
To: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Cc: iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: Off for two weeks
Message-ID: <aHE4Vo7rJAQVkZsA@willie-the-truck>
References: <ojjm5wbqi44t5v2qo752u7q36uvbrda7au5coskjbnxgaom6t5@ebbfcm7zmwfa>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ojjm5wbqi44t5v2qo752u7q36uvbrda7au5coskjbnxgaom6t5@ebbfcm7zmwfa>

On Fri, Jul 11, 2025 at 04:39:46PM +0200, Jörg Rödel wrote:
> Just a note that I will be out for the next two weeks and not do any updates to
> the IOMMU tree.

Have a good break, Joerg!

> Will Deacon thankfully takes over during this time, so please
> send everything his way :) I will be back on July 28th.

I'll do a sweep of the list and pick up what I spot but if folks think
that I may have missed something, please just shout. I'll switch to
"fixes only" mode middle of next week, given where we are in the cycle.

Will
