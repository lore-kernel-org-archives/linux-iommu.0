Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F49E6ADE
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 12:43:27 +0000 (UTC)
Received: from 8bytes.org (p200300c277327f0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7732:7f00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B52F6262340;
	Fri, 13 Jan 2023 13:43:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673613806;
	bh=eAedM8kUpXf74wYVvw3sbi954tDx1WJVtgDncIaNFq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVvCfrEHbJJBmS+tx4zrgb9AW8hqb3KqzWWGZhf+kizYzwhSaHILZZ/w1IEqVvKUs
	 82Rr7nw9/Otg4eeV2II5Z9XkfRJmtC29LfRYGbj27HUMzIj8AvZNt73Va4e1sIB6gp
	 ILFTXXLcLI3dtOoRv6zB98XtnvJsdlmRzsilsXQ967oY0BTT5m7wSt4bu5D1HC0aQP
	 CPEVAOZTMabLxz8YfwGCGRjLf2evCsYlQoYq7c6OSoOcWgIGErvmPQEiQ8zKQ1qgR0
	 UAJaYXMH1gSjXdgjKyYu81pur7zkCA6vmnQ/VxYOESwQb7c8uUyghiz/VlACimGvfi
	 06u70PnpsuPEg==
Date: Fri, 13 Jan 2023 13:43:25 +0100
From: Joerg Roedel <joro@8bytes.org>
To: yf.wang@mediatek.com
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"open list:IOMMU DMA-API LAYER" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	wsd_upstream@mediatek.com, stable@vger.kernel.org,
	Libo Kang <Libo.Kang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
	Ning Li <Ning.Li@mediatek.com>,
	jianjiao zeng <jianjiao.zeng@mediatek.com>
Subject: Re: [PATCH v2] iommu/iova: Fix alloc iova overflows issue
Message-ID: <Y8FR7U8YaDrIF62d@8bytes.org>
References: <20230111063801.25107-1-yf.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111063801.25107-1-yf.wang@mediatek.com>

On Wed, Jan 11, 2023 at 02:38:00PM +0800, yf.wang@mediatek.com wrote:
> v2: Update patch
>     1. Cc stable@vger.kernel.org
>        This patch needs to be merged stable branch,
>        add stable@vger.kernel.org in mail list.
>     2. Refer robin's suggestion to update patch.

Applied for 6.2, thanks.
