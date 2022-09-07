Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1288539F
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 12:19:07 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 239A624000A;
	Wed,  7 Sep 2022 14:19:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662553146;
	bh=UL8stE99xSrCXZrjqPgS+K5txYBsAqspCdTFQkef41o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tz6Vv6G7FBC5TmlIW2Joc3NahiRksRLP/D4D981/yFMpYklDDSmvD4YIOM7lWV9Rg
	 GVu+8xVrouziMnS6PhvEe6X8TrKudzt7YPnq5rptwtE7aSQWFyq0clp1CahosFkOPO
	 HDTHqthN0xS3+oUVpuge6DctddHFxaf48TVQv8qk089KF38QE18bL1ZV8V9gnlrWw9
	 eKgf3/C6f0IHQD9+NZSdyat/AnTS7u5nFP1nl1MkQSdwCb8wHooF/uIbrs6mR56wL3
	 voE+wGSrx0765ZljjFaeA5amf1Bx68SRXK+s1AqV48m33jMA0UPQBfi6JlE9drjPCV
	 g2G+cQQ8Uaubg==
Date: Wed, 7 Sep 2022 14:19:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, subkhankulov@ispras.ru,
	khoroshilov@ispras.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/io-pgtable-arm: Remove iommu_dev==NULL special case
Message-ID: <YxiMOO+8Zz5bnUQ3@8bytes.org>
References: <e2095eeda305071cb56c2cb8ac8a82dc3bd4dcab.1660580155.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2095eeda305071cb56c2cb8ac8a82dc3bd4dcab.1660580155.git.robin.murphy@arm.com>

On Mon, Aug 15, 2022 at 05:15:55PM +0100, Robin Murphy wrote:
> The special case to allow iommu_dev==NULL in __arm_lpae_alloc_pages() is
> confusing to static checkers (and possibly readers in general), since
> it's not obvious that that is only intended for the selftests. However
> it only serves to get around the dev_to_node() call, and we can easily
> fake up enough to make that work anyway, so let's simply remove this
> consideration from the normal flow and punt the responsibility over to
> the test harness itself.
> 
> Reported-by: Rustam Subkhankulov <subkhankulov@ispras.ru>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied, thanks.
