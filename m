Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C4C2F6
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 15:29:07 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CA157248072;
	Mon, 22 May 2023 17:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684769347;
	bh=T808MH0tB+qH7+3vMadAzcd/LhE//tnYZdyYSR9sxlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfN5Az3IvTcAU8uqQ46MQFLvqQm7hKJBvRONaUdte2Hcqo2cCOHGR0/dmI5D9NJFR
	 eSfKC8BAbUr2GDlXf+Zt+SEJVnSAFKgJcpdqHAfn2OT1qqoR8MuZ48f4mbi1y21kny
	 D2Z5ofNn4oT/RHApw3S/0G+ZjpQIyVXkUjff/zCCGqDZPFBp2MCr6zmWjTDBPPARju
	 VTeytXUYLeEoC6LOsI7/Tv5lc7DytlcTF3UMwX8ncrNwGaCloSZNVaLk1o4JrTTQN1
	 hHfdIvwIUZ/cuXzjn+JN5wfAZYKK/Of30E0VRf9nHfVVkZQXmTUefq0Rcxe7qcKhqY
	 9oGqJcp8V9kBQ==
Date: Mon, 22 May 2023 17:29:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
	Tony Zhu <tony.zhu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH for-rc] iommu/amd: Add missing domain type checks
Message-ID: <ZGuKQRFxE2oaU4c2@8bytes.org>
References: <0-v1-2ac37b893728+da-amd_check_types_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-2ac37b893728+da-amd_check_types_jgg@nvidia.com>

On Tue, Apr 25, 2023 at 04:04:15PM -0300, Jason Gunthorpe wrote:
>  drivers/iommu/amd/iommu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied for 6.4, thanks.
