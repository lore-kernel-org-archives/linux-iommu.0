Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163971368
	for <iommu@lists.linux.dev>; Sat, 19 Nov 2022 09:09:50 +0000 (UTC)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9237D2A02E2;
	Sat, 19 Nov 2022 10:09:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1668848989;
	bh=kKv4IcWBr50pq+u1BsUqwwkMsNOwSFyjY9GF6aF/+/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ok9bmgNGkOFDK3nBHALmX1F+tClW4U2X15E+un7wmwfbG9fSpCyXUL24R/bHxtX/y
	 RVGtkK/eTLpnyLm+96eGa7VMM3RykjztP+TG9etEOratXP57/PLrTm1KRgrBYRPTUv
	 /iuaeQfENCfGbCGbSFvwTD9MnVSXQyYrfpflUIwC1wjR8w2/RNJBExRObHMiX9s9UX
	 DAOmoTYZXNsUDVvXTzG6dnuprImgAr7lUGCSVbHKF7oUVoxnubQQkOEnYrRBdC5bPW
	 B0/MzTWBXqBD5AMIWiARKjdKNoT75sgNrCcopUvBo6gXV/tSAdSPHrIFR3mydLf6fk
	 jmFwRtOfdI7WQ==
Date: Sat, 19 Nov 2022 10:09:48 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	yong.wu@mediatek.com, will@kernel.org, robin.murphy@arm.com,
	matthias.bgg@gmail.com
Subject: Re: [PATCH] iommu/mediatek: check return value after calling
 platform_get_resource()
Message-ID: <Y3idXEvo8/uBl4UV@8bytes.org>
References: <20221029103550.3774365-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029103550.3774365-1-yangyingliang@huawei.com>

On Sat, Oct 29, 2022 at 06:35:50PM +0800, Yang Yingliang wrote:
> platform_get_resource() may return NULL pointer, we need check its
> return value to avoid null-ptr-deref in resource_size().
> 
> Fixes: 42d57fc58aeb ("iommu/mediatek: Initialise/Remove for multi bank dev")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/iommu/mtk_iommu.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.
