Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A013AEA
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 10:08:34 +0000 (UTC)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C74D51A225C;
	Mon, 25 Sep 2023 12:08:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1695636514;
	bh=bYPK4L80SaBw9siaRRxaOBF4u3tr6pKF6RCfC0nKevQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Esa5JeSzJpgWFogLtHmJEyNBE/w4bf6DZqnhGGQlXVMwSg3ylrp2fo4mfzkLisFH/
	 qFwvYeWxJOZiwMiHSPELxlB/mWyALQRRsiu4b54hzi2P8qyoN1geSbO6qbizlwVFhN
	 Jucv84Ahlo9zUJnlV89BI2zmqLYDivoeujsSazysbPgi65jmfQ8IpB+BtIhxGW9cHk
	 xNCpDqg/YloofwEZ25IzePc8BqnWYm52FqufjxjEaYQbYyc5XLRgImBKAr0hO/HyAU
	 mUZV+vLRrcel76tW8xeRrZyC5E59btVCWAky22rXhXj8RTO4wDXyy8l2jp0gliB0cN
	 PxUJH3S4Hw36g==
Date: Mon, 25 Sep 2023 12:08:32 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhangzekun11@huawei.com, john.g.garry@oracle.com,
	dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <ZRFcIDNeeVrVnKvD@8bytes.org>
References: <cover.1694535580.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694535580.git.robin.murphy@arm.com>

On Tue, Sep 12, 2023 at 05:28:04PM +0100, Robin Murphy wrote:
> Robin Murphy (2):
>   iommu/iova: Make the rcache depot scale better
>   iommu/iova: Manage the depot list size

Applied, thanks.
