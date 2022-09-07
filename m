Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546EF5C91
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 14:01:57 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D18D92409A7;
	Wed,  7 Sep 2022 16:01:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662559316;
	bh=P37GJtfC9cpZshVFxKia1PKxLTHUt7UKWeJ5u5EBnPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OD0ueQ69vUXSqom3AvFg+1weMJ+TnRY8GPru9h9cSpQx0RXnXyPSnJ+FSb1QNI4YW
	 mHML+s1dzxEMkZ3BYjd3vI764FYlC2n0vSZNRWOT/znePuVQFuW9u/jZlOWwkPam7+
	 Fu6Vqrlh5tUQq8TDqd8cbFn84vetWolz2zvKN1W9VM/g6zNhvn129YhaMLMGTr+mvq
	 JytZssS86YXKGFuqk4IyjECDin+jO6GKrSmHoUyn0E6ors34UO40ILcuWYF1FuKIxb
	 kPBquMun+wVRfV2kJJyJbH1YjFX20CDGZbHw/5m/ICzhK+EwYaPR5clXEK9Bc5tt/b
	 8Lda2PWJe/dIg==
Date: Wed, 7 Sep 2022 16:01:54 +0200
From: Joerg Roedel <joro@8bytes.org>
To: John Garry <john.garry@huawei.com>
Cc: robin.murphy@arm.com, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jsnitsel@redhat.com, haifeng.zhao@linux.intel.com
Subject: Re: [PATCH v4 0/3] iova: Some misc changes
Message-ID: <YxikUvhOiq45dnnj@8bytes.org>
References: <1662557681-145906-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662557681-145906-1-git-send-email-john.garry@huawei.com>

On Wed, Sep 07, 2022 at 09:34:38PM +0800, John Garry wrote:
> John Garry (3):
>   iova: Remove some magazine pointer NULL checks
>   iova: Remove magazine BUG_ON() checks
>   iova: Remove iovad->rcaches check in iova_rcache_get()
> 
>  drivers/iommu/iova.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Applied, thanks.
