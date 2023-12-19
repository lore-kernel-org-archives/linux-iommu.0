Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F0819473
	for <iommu@lists.linux.dev>; Tue, 19 Dec 2023 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="zFZO3aeb"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9683F1A41B9;
	Tue, 19 Dec 2023 14:37:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702993039;
	bh=NpWqJJ4mJlYDo/iteFBb9+HPNteedhEoRraLdLfLkxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zFZO3aebw8/K8FrWn51Gm6sV2ideYQNoWiottCBOJuanOCIiYRcz/h8+oH8+HDHp/
	 2FULvHwp2fdKe57ByTaQdwKutdoFBUXUaZCGggNFfmAF3nMrk1YkjiokYxWEcvpGU7
	 94eNJs7t6Vw5pFTAJqEiKj714hgPG5kdukZp15PPoeLQ8WZrD/aOS5sY9zEhEJ6CJ6
	 pDM8ohN2dYS2RfxMYkS452K051wos/zPnFok6F86VE6XI7sJZLB0pHrMBxhYtWvk3N
	 lMun5XxUUG4P0oFlEhxCWNGCydr/8Py+gXCZzA6gGw0vlNI0EYBvAJ77365RzmoOW1
	 TU5+ZVfAyaXQw==
Date: Tue, 19 Dec 2023 14:37:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>, kernel@collabora.com,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 1/2] iommu: Allow passing custom allocators to pgtable
 drivers
Message-ID: <ZYGcju8vsrf5YywX@8bytes.org>
References: <20231215084302.2484163-1-boris.brezillon@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215084302.2484163-1-boris.brezillon@collabora.com>

On Fri, Dec 15, 2023 at 09:43:01AM +0100, Boris Brezillon wrote:
> v4:
> - Add Gaurav's R-b/T-b

Thanks for the re-post, but there is too much on-top (including merge
commits) to replace these.

