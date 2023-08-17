Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683FDDA5
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 11:05:18 +0000 (UTC)
Received: from 8bytes.org (p4ffe1bae.dip0.t-ipconnect.de [79.254.27.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4ED01280B2B;
	Thu, 17 Aug 2023 12:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1692269921;
	bh=ELb5VVnTKzaZUuaPkg7DH+QwaVNKekwnIp0RtJhTxxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZ2zYN4n8udzDoFxW89rpXtSSXAVb4srCbWqAJ9HgL8kZUXWk02xKhIFAf5FYEIXW
	 N7crgAIDLN5m/eaXnz1IduTnGw+r/okmO959pg6AAHOEL03MMPpi28ZgdKk8DmTxoh
	 hc2lTI9BnPvlzihv4byfoabZoEmZfu5wjnmho6kGWcrqs112yoWhperERIOfLAWEhM
	 +/utOZUPB2yNx85OM1fIzZN+9oASHPGjNoONY46gL1gRdPz+ZwN6eHSfk9Y1JK5ib1
	 Uw8W43QMcVVE4V/5g0pzAlGLsPGA1ipO1Mgn4NJz4v361sH3WfOwWvUTJhsAUFOPFY
	 VkTGezPhfgTtg==
Date: Thu, 17 Aug 2023 12:58:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
	vasant.hegde@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/amd: Remove unused declarations
Message-ID: <ZN39YE8MCF6CTp9F@8bytes.org>
References: <20230814135502.4808-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814135502.4808-1-yuehaibing@huawei.com>

On Mon, Aug 14, 2023 at 09:55:02PM +0800, Yue Haibing wrote:
> Commit aafd8ba0ca74 ("iommu/amd: Implement add_device and remove_device")
> removed the implementations but left declarations in place. Remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.
