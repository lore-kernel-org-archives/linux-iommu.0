Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A912C8E2
	for <iommu@lists.linux.dev>; Mon,  7 Aug 2023 12:41:44 +0000 (UTC)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DAC3A2802BA;
	Mon,  7 Aug 2023 14:41:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1691412104;
	bh=mp2Qsqmqah8UkRtLTNmqskWPJiQVCGLwZfRRCk4gUv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vN+U4TkT8J7/ejLOgCgn3kE+bPPtSsVsqHieYrl6Nt/d5evULvccAlyQWMk5Q91dh
	 giEbvRgHA5hr2UX9wsuAB8sWMMPq+6dc3rHELPKrZQKf6D263818yPGfM2+L/JhF3N
	 38kguKaBHWIv7wN1kAeffVZwQ2mOGAlybmr6yX+RnjkdpHe9igUqaDLqDHEvLtOkA8
	 lG+vC/b95bfc2uEK+/MfEox4x4c2c1DNdMKuhaMv3Y+PdA736mvJkyRJ+4/l388xBG
	 PFmbm/ETJZ8Vb4gvi4wG9dq+xw2EkjDzaZtg/PLOIz+RqobwHaBrpUkrlL7zAz2cOf
	 c2J/WjOfqO+IA==
Date: Mon, 7 Aug 2023 14:41:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Zhu Wang <wangzhu9@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev
Subject: Re: [PATCH -next] iommu: remove kernel-doc warnings
Message-ID: <ZNDmhiWj3PfDlDfD@8bytes.org>
References: <20230731112758.214775-1-wangzhu9@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731112758.214775-1-wangzhu9@huawei.com>

On Mon, Jul 31, 2023 at 07:27:58PM +0800, Zhu Wang wrote:
>  drivers/iommu/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
