Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46621E8332;
	Tue,  9 Dec 2025 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765310394; cv=none; b=rGQnGDVzl8HVYeu3j87V6SswarfbCcKj8Dk/pbuNTnHQPqeACQ0Wy/KYZSReoR0876RfQGXVERjz1eP8M/ySJNvviCgdl0CznD3hXqAV+dG4lTDe4A480tkyTaY9BJU2yjoIy1QvCl6PFS6isjUK+lYJ6Rsn0+/PLYnrONixcAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765310394; c=relaxed/simple;
	bh=bSBSOMZzVxZ5Cf+yjiZOP8aoxsPQwvX4T1edYoaT4TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHBpMcCs+jxEppGPguq8fps+nHm0lm4iCF+xQa3b8tzFLzXhRD1chu+KXyG9p79HANSpeWXo33J6+SMGZAbW5cH0W/i8YDF05/bg5UukPV/uAPj0nBpKcBanv+29U7ZSywxr8L2ZBtdDld6z9HvucKI6QMbxRw7sh4PsXRqz/s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+o4qRND; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+o4qRND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA9BC4CEF5;
	Tue,  9 Dec 2025 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765310394;
	bh=bSBSOMZzVxZ5Cf+yjiZOP8aoxsPQwvX4T1edYoaT4TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+o4qRND33ZsKQaV1iKgwz+g3nSgXIusOx/Jk0cVwwmBzIpQkSBz8OLg2GZQNtXEm
	 +0PId3fSLfAijxXP14Z00UYFlNDeQGF2rzjV94BXwsffxt3pROTqGVYs2hNOrg6EX1
	 Mjfn3Go3uCYtb2WUC4osxfXJlh0Fhn48OnRgLTQeugiI4eMnq5EbMCXoWkJrhNQGGL
	 27ZdU/DRfTW6W58l1gC9KiVtxfse6b3lAuHg41p+1yguh670zw9L7bz2/g4T+wIbeT
	 tAzLOR4XE0rro/qDKJFXM6RxsAsvcEa9KQlVwctQO14TVW6inGq3bbZLeT3olJhgR3
	 EsWDeSLXvotcg==
Date: Tue, 9 Dec 2025 13:59:51 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: vikash.garodia@oss.qualcomm.com, krzk+dt@kernel.org,
	prakash.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org, will@kernel.org,
	bod@kernel.org, robin.murphy@arm.com, conor+dt@kernel.org,
	bjorn.andersson@oss.qualcomm.com, charan.kalla@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
	joro@8bytes.org
Subject: Re: [PATCH v2 1/3] of: Add convenience wrappers for of_map_id()
Message-ID: <176531039069.1014961.838560850328790360.robh@kernel.org>
References: <20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com>
 <20251204095530.8627-2-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204095530.8627-2-vijayanand.jitta@oss.qualcomm.com>


On Thu, 04 Dec 2025 15:25:28 +0530, Vijayanand Jitta wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Since we now have quite a few users parsing "iommu-map" and "msi-map"
> properties, give them some wrappers to conveniently encapsulate the
> appropriate sets of property names. This will also make it easier to
> then change of_map_id() to correctly account for specifier cells.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
>  drivers/cdx/cdx_msi.c                    |  3 +--
>  drivers/iommu/of_iommu.c                 |  4 +---
>  drivers/irqchip/irq-gic-its-msi-parent.c |  4 ++--
>  drivers/of/irq.c                         |  3 +--
>  drivers/pci/controller/dwc/pci-imx6.c    |  6 ++----
>  drivers/pci/controller/pcie-apple.c      |  3 +--
>  drivers/xen/grant-dma-ops.c              |  3 +--
>  include/linux/of.h                       | 14 ++++++++++++++
>  8 files changed, 23 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

