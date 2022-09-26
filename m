Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8233F7B
	for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 11:31:44 +0000 (UTC)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 406DF22264E;
	Mon, 26 Sep 2022 13:31:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1664191903;
	bh=NsNWAeCq66HrW1GGxO8USl6J4kFilGYZmkinmTsFGgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nayy4gxca25kl8M2YW+Fv9qPGKUoX1SzDHBtYmPKTzLCnQxdAqcWhWm74X5JNpA/m
	 BcXcZq77s7qPqZfDnv0vjW2hq6AStGXOR9mlJrO4TDvT84J41F2csLWq0AbJ9U/T/9
	 CjrQY+aN/WRvx2UlJr54aAAkNNOAzCJLp6hlrwclA+Iv+6TbZnpzpG8TnhItfK8LW/
	 x5osLluUTHqmwEsehGq68XfuvfGs0rf9x+YL/0Dqj6Jr8JCDn/AICWQ+/IQncQeRzf
	 UC5gPvnCKxTgGWlE5MB8HpFI4OU5VHv1W+/lBm1qUUaiKHRG8duI7KmS063w61rFK6
	 fOved/jCrO/jA==
Date: Mon, 26 Sep 2022 13:31:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] iommu/iova: Fix module config properly
Message-ID: <YzGNnmE6ZnPFI4fk@8bytes.org>
References: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>

On Tue, Sep 13, 2022 at 12:47:20PM +0100, Robin Murphy wrote:
>  include/linux/iova.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
