Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819D42C518;
	Fri,  9 Oct 2026 06:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526221; cv=none; b=SZvXwhQQ3YlhgaNyrfK23favSUBtCq452dAATk3RnQn3IBbQcrCI4GY78d07f01lmtzPlm8s0pN3HHaSCLQuJF9ebPA20iDz9UuhP3Y+DuGOUmDf1pNax8xVsKyC8FADDwh9Ssf1gmYHvRNlCednlHsonNEYYLtIU8kXNmB29U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526221; c=relaxed/simple;
	bh=flrZtGuBWN5uhPpVz0flFxAvlWbkl/ZkK9l7vI322/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU1FNurFTLAnJztx4QOjLAFlAqkSgK86WDJ7EKjHs/dhN9DnRJvrDj5xdeWxwTFRkjaLbgPvfrkfKdWBoaN9pwCwOir0xKHBgPx56MlVaiTR/fqBPBft5A5PimgPtisWMFO8um8zCFOENwT+9GvIMNS4nw9K2VkZVEHDekAcyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItDXhXo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItDXhXo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04D71F000FF;
	Fri,  9 Oct 2026 06:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791526218;
	bh=EKOWnKBJbJXeo8x7ZpRmGUBbXlEBT0+pIRkZH0GNbaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ItDXhXo2lnHxe4Ty/4W3UyneDlSvPXkqY1slCpv+/7L44f/H4MflyLcIPg1F0NZL1
	 WxWCTDpohl1nagM2Mos1gx+t5J9XCO8EFZUQ449XxQrFF9mkSXJsscKKmdbAdguvWA
	 MQr75gWIvkmf7QtGuytNbx24zzZh0LgqxMvNHjTw2dPcyl/QaBLztME9BD5ZbtnIQt
	 Ch/4lZtWUQ2c8qAll6JMREHTy8zt3oRzdQXcIb2A1FtH39mJWx9mR76qQorM5G0Ro9
	 uI4WIYQYoQ1A4IuEgTxOymxp0leN25nseGB8cen3v6KvCzEEx1pZN/sOp/WbGcjOnB
	 p2J63HhwyivYA==
Date: Fri, 9 Oct 2026 08:10:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/exynos: fix NULL pointer dereference on
 device_link_add() failure
Message-ID: <20261009-refreshing-squirrel-from-hyperborea-ea10de@quoll>
References: <20261009034539.3073100-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009034539.3073100-1-vulab@iscas.ac.cn>


On Fri, 09 Oct 2026 11:45:39 +0800, Haotian Zhang wrote:
> exynos_iommu_probe_device() stores the result of device_link_add() in
> data->link without checking it for failure, although device_link_add()
> returns NULL when the supplier is not PM initialized, on a dependency
> cycle or on allocation failure. exynos_iommu_release_device() then calls
> device_link_del() on that entry unconditionally, and device_link_del()
> dereferences link->flags, so a NULL data->link causes a NULL pointer
> dereference when the device is released.
> 
> Check the returned device link for NULL, unwind the links that were
> already created and fail the probe instead.
> 
> Fixes: 7a974b29fe5d ("iommu/exynos: Rework runtime PM links management")
> Assisted-by: DeepSeek-V4.1-Flash
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/iommu/exynos-iommu.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback.

2. You use multiple identities with this email, thus I actually doubt we speak
   with actual person.

3. Finally, same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document usage of LLM and how what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof




