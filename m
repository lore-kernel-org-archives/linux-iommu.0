Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ADD22EE5;
	Wed,  1 Oct 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759310183; cv=none; b=DIodaYMeYvxquD57gGmjnPw02g6WEHPVCPga4bYWfzI2qQaqqVpPEUIN4aXOrmA/+zlB6NnjZo0ZbYl+pQe8tyyXzYgsk/lf9PMAsWhxd/A+gOeA7yQ7GmYFVb36x/er05nqvtTmwGObsRjeFDywLougy5Sk8F2xPL6N+3qOOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759310183; c=relaxed/simple;
	bh=mPBO1rFwJ1V+N4Nn3UZ6M3kDFyVvHgIu8ezrCVhp4Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moNpNUYzxgrSDN+8si2YPShftpndDgGCg2t3HEKIXcrBYbNbDG4R9sK6T1y7zivSq3/anVrzPFbUqRCo0TArwQPGT+LAu6rI7C18sjtbzNaRO1mWrFCN8qNFnlaZaBMnzK1hiu59YZsU4uCnT95I/eYGU0pejaz6gMkKF8mW1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryRoarZc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryRoarZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F50C4CEF4;
	Wed,  1 Oct 2025 09:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759310179;
	bh=mPBO1rFwJ1V+N4Nn3UZ6M3kDFyVvHgIu8ezrCVhp4Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryRoarZcIeB0a1FI+KXWkDbnpfF299BgMzYE/5pLLRYQ4CVBLbePE9bWsFKHRrzNt
	 eEZJcFUGOHIWLqWKubSNNY67pGaX3f8Tc2yyB0phIc6/BU2Ww4Lv5ZSh4md38dIZ91
	 CYc6GAcP/Kp/WF38vFyDbP7topTzZUF/N/+bs7sKwG41cXM+T5c0T3iaWfAdb6/zdm
	 FO/Q1tyPjiIZ0D6ceaPJzkN+zWiEMeW8UlsIdFgM9P6APVB+CT7FdJ/0AI0FNwePW0
	 kvPa+2tMznxnfqXFf8imRueREfZXK+BOOoW+7B6W7h/0ID4qerZ/8dqzj8/RoG5rys
	 P0QLujRb4Vu2Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v3swT-000000004dK-0HS8;
	Wed, 01 Oct 2025 11:16:09 +0200
Date: Wed, 1 Oct 2025 11:16:09 +0200
From: Johan Hovold <johan@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] iommu: fix device leaks
Message-ID: <aNzxWZlWmQMokLd_@hovoldconsulting.com>
References: <20250925122756.10910-1-johan@kernel.org>
 <20250930182158.GS2695987@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930182158.GS2695987@ziepe.ca>

On Tue, Sep 30, 2025 at 03:21:58PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 25, 2025 at 02:27:42PM +0200, Johan Hovold wrote:
> > This series fixes device leaks in the iommu drivers, which pretty
> > consistently failed to drop the reference taken by
> > of_find_device_by_node() when looking up iommu platform devices.
> 
> Yes, they are mis-designed in many ways :\

This seems to be more a case of developers not reading documentation and
copying implementations from existing drivers.

I amended the documentation for of_find_device_by_node() in 2016 and at
least of some these drivers were merged later. Fixing up the existing
uses will hopefully reduce the likelihood of further leaks being
introduced (e.g. in places were it matters more).

> IDK if it is worth fixing like this, or if more effort should be put
> to make the drivers use of_xlate properly - the arm smmu drivers show
> the only way to use it..

As Robin pointed out, those drivers just drop the reference as they
should (even if I'd drop the reference after looking up the driver
data).

> But if staying like this then maybe add a little helper?
> 
> void *iommu_xlate_to_iommu_drvdata(const struct of_phandle_args *args);
> 
> Put the whole racy of_find_device_by_node / put_device /
> platform_get_drvdata sequence is in one tidy function.. With
> documentation it is not safe don't use it in new code?

It's not racy in the context of iommu drivers as Robin also explained.

Johan
