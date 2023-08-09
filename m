Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9579612D
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 13:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E1DC433C7;
	Wed,  9 Aug 2023 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691589368;
	bh=JlmnTYRkyCKAu72Dr0ArIxvge7wlJAGTJk4llf1Z1x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKqa43aEiNKTbA1zxSi5LJmiDduB9FYNJoY0LnMBWXTmNYhkZQBxoXniK3JTkdEJg
	 +piz+sBf3Pbt3/18k8rafHMjIGOyGx+TNdKOK2Qrb4BxtDrLTvsarzmsimviXq+GvM
	 j6+IK/bSlZdhwFnMJ2/sNo2zNHNA1RWsxoXsqwdYA1RugiMdEOcwd5b7551wp910Fl
	 aHcDeZFUT9Yzhn2SpAw2qtWE26FNPKs7F/TsxbIDFhReYZUdpJE4aTJ8nEwhD460n+
	 ABI1U2GZUMY95sPoE1Dlr7AtjIFFz+y9vu/IhEi6ltXVR9jrVCxe9VsSImuCYK5c0I
	 pYw5iCAnWbNWw==
Date: Wed, 9 Aug 2023 14:56:03 +0100
From: Will Deacon <will@kernel.org>
To: thunder.leizhen@huaweicloud.com
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>, jgg@ziepe.ca
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: Add support for ECMDQ register
 mode
Message-ID: <20230809135603.GE4226@willie-the-truck>
References: <20230809131303.1355-1-thunder.leizhen@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809131303.1355-1-thunder.leizhen@huaweicloud.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 09, 2023 at 09:13:01PM +0800, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> v1 --> v2:

Jason previously asked about performance numbers for ECMDQ:

https://lore.kernel.org/r/ZL6n3f01yV7tc4yH@ziepe.ca

Do you have any?

Will
