Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935FAD47
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 14:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668521651;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBHWqy78eJDHtx/+9ycGf77SRANac5lVpltsrKsyVRI=;
	b=CqypqTjxQ+aFiBBlz26RQKoEtwN381l3Anjykp2JCVtc+EK9ziDagpo7G/Xtz4m/4FqjSK
	iyrMum5s7/qwJadq2soz+MVTVGDWGHFeaHtz1mlJZFhhBM/PqdW9v7qlV6Bq5jORCEU/Sl
	K/Pi7Qfn2C8i3dnzhcwRj8yuYOZfTxQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-OmL_d8-VMre3Ruxy5-RA3A-1; Tue, 15 Nov 2022 09:14:10 -0500
X-MC-Unique: OmL_d8-VMre3Ruxy5-RA3A-1
Received: by mail-qv1-f69.google.com with SMTP id lb11-20020a056214318b00b004c63b9f91e5so4140615qvb.8
        for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 06:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBHWqy78eJDHtx/+9ycGf77SRANac5lVpltsrKsyVRI=;
        b=by4l7oUiluDYuxWWSLunyfAIowhbVDXwpr2FxZhNDZu4hDKguxuFXN32lt9NVyTXNO
         1y5HzLQ41Dc8zxqFriZTaxHYy+dqpjZzJdhMHPqVZamW35h12ei54gv5n44N7lwSoiqw
         ud4n0AwlzMTZXOJjlJ8xwaDuJLxCR7CSw3YucprC0XaavPSz4oOQvnUOkQsGmCn/sOLK
         mzQw2183c50LQRVyx9oRYIe5qJCS15p2SOII6Gdme3nXO4IbwrRkptSpLC200zt4Cmfh
         0mru8uuyHFLS6DE/gXFgxMcEnkWeHw6mMe8brOUbjDybXOBuElPjiY/+MWbnO1LDSEkz
         nPzw==
X-Gm-Message-State: ANoB5plYGLvcfhHc57ibZq+kIsJVtR9nuKKFSwx5hGRhnySfwoKOICYx
	aaUKP1axoRsh7M5/1jj90oa6H50ZzzL90A0kA6mWUzmX9N6grIxcCx8+BzAWxSLCYNyIbtFTPRU
	jeu0kOWz2B1vDzh4=
X-Received: by 2002:ac8:5787:0:b0:3a5:ef4:675d with SMTP id v7-20020ac85787000000b003a50ef4675dmr17018444qta.409.1668521648894;
        Tue, 15 Nov 2022 06:14:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Y4TimZPGdX70IP8PmI8c9rCynvQENWzgkJNWsyiaJkaR7UUVYgMweGq+PBlV4dXb9mUSPFA==
X-Received: by 2002:ac8:5787:0:b0:3a5:ef4:675d with SMTP id v7-20020ac85787000000b003a50ef4675dmr17018410qta.409.1668521648505;
        Tue, 15 Nov 2022 06:14:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id x81-20020a376354000000b006cfc9846594sm8029860qkb.93.2022.11.15.06.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:14:07 -0800 (PST)
Message-ID: <112905a9-ed6f-4aaa-2bfc-46502e558ab5@redhat.com>
Date: Tue, 15 Nov 2022 15:14:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v4 03/17] interval-tree: Add a utility to iterate over
 spans in an interval tree
To: Jason Gunthorpe <jgg@nvidia.com>, bpf@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
 <cohuck@redhat.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eric Farman <farman@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <3-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <3-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/8/22 01:48, Jason Gunthorpe wrote:
> The span iterator travels over the indexes of the interval_tree, not the
> nodes, and classifies spans of indexes as either 'used' or 'hole'.
>
> 'used' spans are fully covered by nodes in the tree and 'hole' spans have
> no node intersecting the span.
>
> This is done greedily such that spans are maximally sized and every
> iteration step switches between used/hole.
>
> As an example a trivial allocator can be written as:
>
> 	for (interval_tree_span_iter_first(&span, itree, 0, ULONG_MAX);
> 	     !interval_tree_span_iter_done(&span);
> 	     interval_tree_span_iter_next(&span))
> 		if (span.is_hole &&
> 		    span.last_hole - span.start_hole >= allocation_size - 1)
> 			return span.start_hole;
>
> With all the tricky boundary conditions handled by the library code.
>
> The following iommufd patches have several algorithms for its overlapping
> node interval trees that are significantly simplified with this kind of
> iteration primitive. As it seems generally useful, put it into lib/.
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .clang-format                 |   1 +
>  include/linux/interval_tree.h |  58 +++++++++++++++
>  lib/Kconfig                   |   4 ++
>  lib/interval_tree.c           | 132 ++++++++++++++++++++++++++++++++++
>  4 files changed, 195 insertions(+)
>
> diff --git a/.clang-format b/.clang-format
> index 1247d54f9e49fa..96d07786dcfb46 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -440,6 +440,7 @@ ForEachMacros:
>    - 'inet_lhash2_for_each_icsk'
>    - 'inet_lhash2_for_each_icsk_continue'
>    - 'inet_lhash2_for_each_icsk_rcu'
> +  - 'interval_tree_for_each_span'
>    - 'intlist__for_each_entry'
>    - 'intlist__for_each_entry_safe'
>    - 'kcore_copy__for_each_phdr'
> diff --git a/include/linux/interval_tree.h b/include/linux/interval_tree.h
> index 288c26f50732d7..2b8026a3990645 100644
> --- a/include/linux/interval_tree.h
> +++ b/include/linux/interval_tree.h
> @@ -27,4 +27,62 @@ extern struct interval_tree_node *
>  interval_tree_iter_next(struct interval_tree_node *node,
>  			unsigned long start, unsigned long last);
>  
> +/**
> + * struct interval_tree_span_iter - Find used and unused spans.
> + * @start_hole: Start of an interval for a hole when is_hole == 1
> + * @last_hole: Inclusive end of an interval for a hole when is_hole == 1
> + * @start_used: Start of a used interval when is_hole == 0
> + * @last_used: Inclusive end of a used interval when is_hole == 0
> + * @is_hole: 0 == used, 1 == is_hole, -1 == done iteration
> + *
> + * This iterator travels over spans in an interval tree. It does not return
> + * nodes but classifies each span as either a hole, where no nodes intersect, or
> + * a used, which is fully covered by nodes. Each iteration step toggles between
> + * hole and used until the entire range is covered. The returned spans always
> + * fully cover the requested range.
> + *
> + * The iterator is greedy, it always returns the largest hole or used possible,
> + * consolidating all consecutive nodes.
> + *
> + * Use interval_tree_span_iter_done() to detect end of iteration.
> + */
> +struct interval_tree_span_iter {
> +	/* private: not for use by the caller */
> +	struct interval_tree_node *nodes[2];
> +	unsigned long first_index;
> +	unsigned long last_index;
> +
> +	/* public: */
> +	union {
> +		unsigned long start_hole;
> +		unsigned long start_used;
> +	};
> +	union {
> +		unsigned long last_hole;
> +		unsigned long last_used;
> +	};
> +	int is_hole;
> +};
> +
> +void interval_tree_span_iter_first(struct interval_tree_span_iter *state,
> +				   struct rb_root_cached *itree,
> +				   unsigned long first_index,
> +				   unsigned long last_index);
> +void interval_tree_span_iter_advance(struct interval_tree_span_iter *iter,
> +				     struct rb_root_cached *itree,
> +				     unsigned long new_index);
> +void interval_tree_span_iter_next(struct interval_tree_span_iter *state);
> +
> +static inline bool
> +interval_tree_span_iter_done(struct interval_tree_span_iter *state)
> +{
> +	return state->is_hole == -1;
> +}
> +
> +#define interval_tree_for_each_span(span, itree, first_index, last_index)      \
> +	for (interval_tree_span_iter_first(span, itree,                        \
> +					   first_index, last_index);           \
> +	     !interval_tree_span_iter_done(span);                              \
> +	     interval_tree_span_iter_next(span))
> +
>  #endif	/* _LINUX_INTERVAL_TREE_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 9bbf8a4b2108e6..c6c323fd251721 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -479,6 +479,10 @@ config INTERVAL_TREE
>  
>  	  for more information.
>  
> +config INTERVAL_TREE_SPAN_ITER
> +	bool
> +	depends on INTERVAL_TREE
> +
>  config XARRAY_MULTI
>  	bool
>  	help
> diff --git a/lib/interval_tree.c b/lib/interval_tree.c
> index 593ce56ece5050..d2882db8fa2a07 100644
> --- a/lib/interval_tree.c
> +++ b/lib/interval_tree.c
> @@ -15,3 +15,135 @@ EXPORT_SYMBOL_GPL(interval_tree_insert);
>  EXPORT_SYMBOL_GPL(interval_tree_remove);
>  EXPORT_SYMBOL_GPL(interval_tree_iter_first);
>  EXPORT_SYMBOL_GPL(interval_tree_iter_next);
> +
> +#ifdef CONFIG_INTERVAL_TREE_SPAN_ITER
Maybe add in a kernel doc that a prerequisite is state.nodes[1] must be
populated
> +static void
> +interval_tree_span_iter_next_gap(struct interval_tree_span_iter *state)
> +{
> +	struct interval_tree_node *cur = state->nodes[1];
> +
> +	/*
> +	 * Roll nodes[1] into nodes[0] by advancing nodes[1] to the end of a
> +	 * contiguous span of nodes. This makes nodes[0]->last the end of that
> +	 * contiguous span of valid indexes that started at the original
I would suggest s/contiguous span/contiguous used span and remove "of
valid indexes"
> +	 * nodes[1]->start. nodes[1] is now the next node and a hole is between
nodes[1] is now the first node starting the next used span. A hole span
is between nodes[0]->last and nodes[1]->start
> +	 * nodes[0] and [1].
> +	 */
> +	state->nodes[0] = cur;
> +	do {
> +		if (cur->last > state->nodes[0]->last)
> +			state->nodes[0] = cur;
> +		cur = interval_tree_iter_next(cur, state->first_index,
> +					      state->last_index);
> +	} while (cur && (state->nodes[0]->last >= cur->start ||
> +			 state->nodes[0]->last + 1 == cur->start));
> +	state->nodes[1] = cur;
> +}
> +
> +void interval_tree_span_iter_first(struct interval_tree_span_iter *iter,
> +				   struct rb_root_cached *itree,
> +				   unsigned long first_index,
> +				   unsigned long last_index)
> +{
> +	iter->first_index = first_index;
> +	iter->last_index = last_index;
> +	iter->nodes[0] = NULL;
> +	iter->nodes[1] =
> +		interval_tree_iter_first(itree, first_index, last_index);
> +	if (!iter->nodes[1]) {
> +		/* No nodes intersect the span, whole span is hole */
> +		iter->start_hole = first_index;
> +		iter->last_hole = last_index;
> +		iter->is_hole = 1;
> +		return;
> +	}
> +	if (iter->nodes[1]->start > first_index) {
> +		/* Leading hole on first iteration */
> +		iter->start_hole = first_index;
> +		iter->last_hole = iter->nodes[1]->start - 1;
> +		iter->is_hole = 1;
> +		interval_tree_span_iter_next_gap(iter);
> +		return;
> +	}
> +
> +	/* Starting inside a used */
> +	iter->start_used = first_index;
> +	iter->is_hole = 0;
> +	interval_tree_span_iter_next_gap(iter);
> +	iter->last_used = iter->nodes[0]->last;
> +	if (iter->last_used >= last_index) {
> +		iter->last_used = last_index;
> +		iter->nodes[0] = NULL;
> +		iter->nodes[1] = NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(interval_tree_span_iter_first);
> +
> +void interval_tree_span_iter_next(struct interval_tree_span_iter *iter)
> +{
> +	if (!iter->nodes[0] && !iter->nodes[1]) {
> +		iter->is_hole = -1;
> +		return;
> +	}
> +
> +	if (iter->is_hole) {
> +		iter->start_used = iter->last_hole + 1;
> +		iter->last_used = iter->nodes[0]->last;
> +		if (iter->last_used >= iter->last_index) {
> +			iter->last_used = iter->last_index;
> +			iter->nodes[0] = NULL;
> +			iter->nodes[1] = NULL;
> +		}
> +		iter->is_hole = 0;
> +		return;
> +	}
> +
> +	if (!iter->nodes[1]) {
> +		/* Trailing hole */
> +		iter->start_hole = iter->nodes[0]->last + 1;
> +		iter->last_hole = iter->last_index;
> +		iter->nodes[0] = NULL;
> +		iter->is_hole = 1;
> +		return;
> +	}
> +
> +	/* must have both nodes[0] and [1], interior hole */
> +	iter->start_hole = iter->nodes[0]->last + 1;
> +	iter->last_hole = iter->nodes[1]->start - 1;
> +	iter->is_hole = 1;
> +	interval_tree_span_iter_next_gap(iter);
> +}
> +EXPORT_SYMBOL_GPL(interval_tree_span_iter_next);
> +
> +/*
> + * Advance the iterator index to a specific position. The returned used/hole is
> + * updated to start at new_index. This is faster than calling
> + * interval_tree_span_iter_first() as it can avoid full searches in several
> + * cases where the iterator is already set.
> + */
> +void interval_tree_span_iter_advance(struct interval_tree_span_iter *iter,
> +				     struct rb_root_cached *itree,
> +				     unsigned long new_index)
> +{
> +	if (iter->is_hole == -1)
> +		return;
> +
> +	iter->first_index = new_index;
check new_index > iter->first_index?
> +	if (new_index > iter->last_index) {
> +		iter->is_hole = -1;
> +		return;
> +	}
> +
> +	/* Rely on the union aliasing hole/used */
> +	if (iter->start_hole <= new_index && new_index <= iter->last_hole) {
> +		iter->start_hole = new_index;
> +		return;
> +	}
> +	if (new_index == iter->last_hole + 1)
> +		interval_tree_span_iter_next(iter);
> +	else
> +		interval_tree_span_iter_first(iter, itree, new_index,
> +					      iter->last_index);
> +}
> +EXPORT_SYMBOL_GPL(interval_tree_span_iter_advance);
> +#endif

Besides, looks good to me
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

