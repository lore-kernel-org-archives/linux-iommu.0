Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163DF1368
	for <iommu@lists.linux.dev>; Sat, 19 Nov 2022 09:44:46 +0000 (UTC)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DF6272A02E9;
	Sat, 19 Nov 2022 10:44:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1668851086;
	bh=InKK49jYZPzbIwU6l/Xvg3Y1+AkrospbAgMfxxg7bQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxvP5UOpEB73kpHRWrFYg/Bb16tmIIYHPJvvxcJonP4PT3gJPuJsmRpOqwhIa+8yw
	 5hGfwJjObrEtU7Ibv98MBJg9HFzZbRKV3DJ7h8tQLuUTtJYei87AfDx6HaLPCoI8He
	 nXWmj5qeE2+Dzxa3s8fKTtZlYcZggAQLCuTvhSskLmqj93sRbkcUnjtDgJ6E7omjrC
	 nAxvpLZEv83lDqUIXkh+8yiy+2UN9xV5JP+2UBOYykFh2kqtmYueJbgcZQ6hz63xwP
	 RZlM8M5+GnEeU/hpcfToAodZ/cxAq4ZrUp6F47m65XCWrDsCZ6xEw6xRCYWWJUqXcw
	 f7B17Wg6as/sw==
Date: Sat, 19 Nov 2022 10:44:44 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
	yong.wu@mediatek.com
Subject: Re: [PATCH 0/9] iommu: {map,unmap}_pages cleanup
Message-ID: <Y3iljDFK3bkZWdbv@8bytes.org>
References: <cover.1668100209.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668100209.git.robin.murphy@arm.com>

On Tue, Nov 15, 2022 at 03:26:34PM +0000, Robin Murphy wrote:
> Robin Murphy (9):
>   iommu/mediatek-v1: Update to {map,unmap}_pages
>   iommu/sprd: Update to {map,unmap}_pages
>   iommu/mediatek: Update to {map,unmap}_pages
>   iommu/msm: Update to {map,unmap}_pages
>   iommu/ipmmu-vmsa: Update to {map,unmap}_pages
>   iommu/qcom: Update to {map,unmap}_pages
>   iommu/io-pgtable-arm: Remove map/unmap
>   iommu/io-pgtable-arm-v7s: Remove map/unmap
>   iommu/io-pgtable: Remove map/unmap
> 
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 14 +++++----
>  drivers/iommu/io-pgtable-arm-v7s.c      | 41 +++++++++---------------
>  drivers/iommu/io-pgtable-arm.c          | 42 +++++++++----------------
>  drivers/iommu/ipmmu-vmsa.c              | 18 +++++------
>  drivers/iommu/msm_iommu.c               | 18 ++++++-----
>  drivers/iommu/mtk_iommu.c               | 15 ++++-----
>  drivers/iommu/mtk_iommu_v1.c            | 30 +++++++++---------
>  drivers/iommu/sprd-iommu.c              | 25 ++++++++-------
>  include/linux/io-pgtable.h              |  6 ----
>  9 files changed, 94 insertions(+), 115 deletions(-)

Applied, thanks Robin.
