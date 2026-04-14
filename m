Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01793B6BE8;
	Tue, 14 Apr 2026 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158745; cv=none; b=jpLOWF5/sFmUIVkBxHe/RdF1hclEOTIBsXU7kYpLPkTBs2OqNDcq8vs7PJm8GyqvY313bTMnoQOnswMeHIP+QiV99qvtRTtaQ8Ow5dH0yqQjI5j9YCtz88KHnB/x+xLQMTn40Z5RLcsjGx8QKC57Wp+WVXdcKpyBpefGtdZisUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158745; c=relaxed/simple;
	bh=Enikf7tmTFT9YEWtUAMcNbMYVjKpPfAXdLZXLro6lcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jB8iMB2fYFGRRAhaEg6njq7JPM0GHvrQiz7gRSyYq7mktNTHQwkTrAfUpdB0hujk3MfN7JY4sNVqrtZZo3ri8VxliyFvoamsgE8JYTcPuVHbfA+l/beQBRGOi5hZZhtW7PW0mIlNpsHahOW38PYQZIlPBlhBvcCX6Txr+ylFUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIpsbLoY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIpsbLoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AB7C19425;
	Tue, 14 Apr 2026 09:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776158745;
	bh=Enikf7tmTFT9YEWtUAMcNbMYVjKpPfAXdLZXLro6lcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SIpsbLoYkXqDmJK0GkqM4NSASNWDnCPz9jZIqMmNDElbQvCv3vxNrQ6pMcNTV0Qiv
	 9qYVIksf2oNIKAkI1bLsYughD1w2R8omjS0lduRY8KMe+Aq1QV0tLQKKqLm5NjNS9W
	 z6sTgUX7SQJwH53DrxdJBdVWQL6wQBc/+vr3Qid2KUMcQVTfVeKDsiQTRqnNy8s6cY
	 bcgO9OBhZ7stV4NeRJLZ+lNIvXuBS1MTK/36UMTQi4nU7seKgQtvnuukpjqc12d3m+
	 5IgB0S3XJwalWCNHYSljqEKWE3xdMpF/RUl1esyAiFxlMZem2ObMKbx+fVfu9ywl91
	 NwPEwkNcirqOA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC PATCH v3 1/5] swiotlb: Return state of memory from
 swiotlb_alloc()
In-Reply-To: <20260408194750.2280873-2-smostafa@google.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-2-smostafa@google.com>
Date: Tue, 14 Apr 2026 14:55:33 +0530
Message-ID: <yq5awly9ao6q.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Mostafa Saleh <smostafa@google.com> writes:

> Make swiotlb_alloc() return the state of the allocated memory, at
> the moment all the pools are decrypted but that would change soon.
> In the next patches dma-direct will use the returned state to
> determine whether to decrypt the memory and use the proper memory
> decryption/encryption related functions.
>
> Also, add swiotlb_is_decrypted(), that will be used before calling
> swiotlb_free() to check whether the memory needs to be encrypted
> by the caller.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  include/linux/swiotlb.h | 25 +++++++++++++++++++++++--
>  kernel/dma/direct.c     |  2 +-
>  kernel/dma/swiotlb.c    | 23 ++++++++++++++++++++++-
>  3 files changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..24be65494ce8 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -63,6 +63,7 @@ extern void __init swiotlb_update_mem_attributes(void);
>   * @area_nslabs: Number of slots in each area.
>   * @areas:	Array of memory area descriptors.
>   * @slots:	Array of slot descriptors.
> + * @decrypted:	Whether the pool was decrypted or left in default state.
>   * @node:	Member of the IO TLB memory pool list.
>   * @rcu:	RCU head for swiotlb_dyn_free().
>   * @transient:  %true if transient memory pool.
> @@ -77,6 +78,7 @@ struct io_tlb_pool {
>  	unsigned int area_nslabs;
>  	struct io_tlb_area *areas;
>  	struct io_tlb_slot *slots;
> +	bool decrypted;
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  	struct list_head node;
>  	struct rcu_head rcu;
> @@ -281,16 +283,31 @@ static inline void swiotlb_sync_single_for_cpu(struct device *dev,
>

Should this be a property of struct io_tlb_mem ? 

-aneesh
