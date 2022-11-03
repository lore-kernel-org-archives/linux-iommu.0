Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9740E6FCC
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 13:06:59 +0000 (UTC)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0123522405B;
	Thu,  3 Nov 2022 13:59:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1667480355;
	bh=qeEwW8fQOw1wm3MkjAsYSb7lyBfW6zgGK2aj+8YTzEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=6kfeTXWvHyDWmm4gAg+I+oycD2ChvmpeQkHL+lUiixejwNIRguYRNfoVlIyz3+mj1
	 YgJD3atrD3Zw7958FVIRUoTa8G1x/tv23ozgFwxszeJ9+qWRndWCXzlJZXbZiCkICi
	 pYEH+Sk++h03iXR1qNvhSRSyS1wyW/3cQI1txZv9P9/7tZdNzBtt7MXo6M42U4lLtn
	 fsEhMbpot7QRE2DAVnChWkL1YLdxgPqgAxW9/BGnMH3BeG1hZBFE3CPRVPrz942fAw
	 2Xh0+kZyq2mE/1yzXd6TVj2kBmpipXBMkGuo70NdGa+iFnENh8DsAYDjeBEq7wIYtj
	 9EIWwm20sTg+w==
Date: Thu, 3 Nov 2022 13:59:13 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Prathamesh Shete <pshete@nvidia.com>, iommu@lists.linux.dev,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Always define struct iommu_fwspec
Message-ID: <Y2O7ITA/YQ31pTlz@8bytes.org>
References: <20221018105149.820062-1-thierry.reding@gmail.com>
 <CAPDyKFopppohLJ7ptnQxpBHzMLh2SZObarQRC0bJyTwE=nky4w@mail.gmail.com>
 <Y1pLPHER+Pq+cRvc@orome>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1pLPHER+Pq+cRvc@orome>

On Thu, Oct 27, 2022 at 11:11:24AM +0200, Thierry Reding wrote:
> Adding Prathamesh for visibility. Another alternative would be to
> prepend this to Prathamesh's series with an Acked-by from Joerg.
> 
> Joerg, any preference on how to move forward with this?

Sorry, missed the discussion until now. Adding this patch to
Prathamesh's series is fine with me. Feel free to add my

Acked-by: Joerg Roedel <jroedel@suse.de>
