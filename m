Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F3914015
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="DTgipGR5"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9C98B1A5C8A;
	Mon, 27 Nov 2023 10:23:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1701077015;
	bh=5XvWu4SCjTGmDrrNKE1KatUlot8/Q88rx/yko7yl438=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTgipGR59rmL4c5iInY8POzIwIYNn+7dtsMPdnAiT+wI1MyLeJGg/gbPZ50RiNMlg
	 BVezA45Ab25KMBx2phDRol4RQ9m06UGDmY0Of7RU0gdJ7vBNlcWkysXrIG9alj0dde
	 r7Hu85H0/pTCI1LcLfcKzhDUlR5l1X34CG54/a7iVXuAfRVk+D/bkTT4g3a4qyBNgO
	 WROWEtbwg6j6p/Fm7mr9rIC+JCJXvn4wOfSFX1gMKAYPKT0mbACiEze2/zk1UiR1gh
	 RHhumhb5dk16chHT5Z1XpCXKbyPmcA4jMRHbcnAha8kgYaPcfGqWPTjeLGh4e4KJOp
	 imBi7XRaqHZLA==
Date: Mon, 27 Nov 2023 10:23:34 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: will@kernel.org, robin.murphy@arm.com, treding@nvidia.com,
	jgg@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu: map reserved memory as cacheable if device is
 coherent
Message-ID: <ZWRgFjIvnuzj5URP@8bytes.org>
References: <20230926152600.8749-1-laurentiu.tudor@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926152600.8749-1-laurentiu.tudor@nxp.com>

On Tue, Sep 26, 2023 at 06:26:00PM +0300, Laurentiu Tudor wrote:
>  drivers/iommu/of_iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.
