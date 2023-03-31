Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10A51FB1
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 08:15:56 +0000 (UTC)
Received: from 8bytes.org (p5b006afb.dip0.t-ipconnect.de [91.0.106.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9C916244F14;
	Fri, 31 Mar 2023 10:15:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1680250555;
	bh=Nj2RPEf5tHAVw/0IreoUpeL1UqVxou3N6q/B5IWphOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRIQgLCra8Saeqj8TG5tYTBgTtFlea3Q9xRjzQ7/AxIXZxuiM8ODqK69mCzM7+mtl
	 rJ5BDXKtTBR4XYzGacMxlCT7sWBoGjnl4cpYoMZW5+HJVfctu5OqQG4UneF/8P+Tat
	 HdhIB009CoSEcff1qX8tvPYhKfmjMx0vYQQqkZxiJI/lv10a/xtmcd80E2QerIgNTM
	 qB5X9fHFxGCDJBsVEmvBubxp+NxRAUQtYTKG2njy3lT1A0isbqVwzZx8WZmqrM+Jas
	 qd0aNaUAMX3+JWiyY+RdyhtGjtIU2B9U2lPh/L0rJR+GVoWZqav1iz1C0rfcqgUamq
	 LdZmT3WtSWIrw==
Date: Fri, 31 Mar 2023 10:15:54 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, Baolin Wang <baolin.wang@linux.alibaba.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Chunyan Zhang <chunyan.zhang@unisoc.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V3 0/2] Add reattaching support and fix memory
 leak issue
Message-ID: <ZCaWug1VGoV6M1Hh@8bytes.org>
References: <20230331033124.864691-1-zhang.lyra@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331033124.864691-1-zhang.lyra@gmail.com>

On Fri, Mar 31, 2023 at 11:31:22AM +0800, Chunyan Zhang wrote:
> Chunyan Zhang (2):
>   iommu: sprd: release dma buffer to avoid memory leak
>   iommu: sprd: Add support for reattaching an existing domain

Applied, thanks.
