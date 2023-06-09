Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E288D79E5
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 12:58:53 +0000 (UTC)
Received: from 8bytes.org (p4ff2bfbf.dip0.t-ipconnect.de [79.242.191.191])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 98027224B97;
	Fri,  9 Jun 2023 14:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1686315532;
	bh=UFNw8aIZXzP10GiHCjImDZ/A5kFejFNCGxeFW07L8lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbwZt39UrSPDO7MwAi9RgoieiVepk2NvW9pD+jbUYdR3k7mZyH9tvF8s3xSqTiBm3
	 x04t/y8MxFfS0Nyml70AUiCFdBJf6UzrhwEQn2FLsUUCIlbBuDYlHi8ySs945sMOuU
	 p2aNLIuQZa4dM18zVHDYQqdyU/osxXLEzi83lqe6rCOFiN3D54+UywegrkqohqV37k
	 sADfaF/JTfYserBB5ce/p20q/igalJ91c+g7L9CHRG5xhm8QlWMNoL3aJPrJBh9pHq
	 zfjtX1GtgI2EbGEuFMUo6TeKxdOPeGeMid2JUpG7kcGbHPpoGaAHS+L28fDcgbP+B5
	 5No9bg4XSLINg==
Date: Fri, 9 Jun 2023 14:58:51 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.5
Message-ID: <ZIMiC_-GIKRzwB8Y@8bytes.org>
References: <20230609091435.GA3741@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609091435.GA3741@willie-the-truck>

On Fri, Jun 09, 2023 at 10:14:36AM +0100, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.
