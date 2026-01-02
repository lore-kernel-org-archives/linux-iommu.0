Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5FF2D3EE3
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767340781; cv=none; b=dpTbnIp4ZmWNgg5buBzpQLi/aqVc5OE4Qti8iSytUpdsf/b59xkeJ467Kohe0U5hn21/cSX32c4JYSEksmXoK2/i6hR4Y6gl+HM4xFUoZWmGN/6By3IWrKnxg4MpOYx3UyeHixntveGVMJB6MSE45vSl+lLzi2+wL2/omrzeDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767340781; c=relaxed/simple;
	bh=UD0nX92LmX0AHSDMj1Aw7fSctz7TIO+ioQ0bAnsD9YM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbOmR+gwLWXqzlWgimSh55CikX38GST+AZ1l86rDwr6VfgthlJwTtPGCbtE1mjYum8AU+Wp+Vc3NkyjRTXSdW/3pLHUXK7OWIwdGExZzTLXajg1zWDyTocVry1DoecyjcQpo3hMbIulsRiy9azfOHXhYtIxmZxRsVRtCAM5eB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CIKcKR6I; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CIKcKR6I"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47a9567bcd9so9683615e9.2
        for <iommu@lists.linux.dev>; Thu, 01 Jan 2026 23:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767340777; x=1767945577; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIhwYQ0S620I5qazfGkJGP1Z1tDhQZ9HETsO3rBfl20=;
        b=CIKcKR6I4IF2NUtCLmd0lBoZYPr0anBtxqGjHK4fOMEV3j0U/y2eMHuNC6o4oVLGY+
         yOHOJNIXzLLq3i951qIPwXcZiIGNxOHUjgEDKe5nrnZYpk25kXGyguLyv+VcarKY82Zn
         0wSG0ep0FwA8Z2JM97SHFZ/CyFvUkJ8NgkamR7okMo1zpxchvnmi1qn2JNRIrR0ILDwe
         J00h2EvDYLKNejyAJerQKvm273hu6okO+hN/mYl4x88rYyjwR7elqfcdczR0CGwfcvem
         /Gw+XlqqFFeC12xEfjW+hHAs5qpqRIvuLXmthXT+IA39gm9p+IA7kAC8O+PRls8s0ssX
         HFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767340777; x=1767945577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fIhwYQ0S620I5qazfGkJGP1Z1tDhQZ9HETsO3rBfl20=;
        b=qLX5ouKzVc3fpoPrXkZ+914VTmYrs/VlkAZdKO0lMSK/waXfmt4DkOflMSlT3Yr0/d
         6uZYStA5XnZVxcCsfbkGtE/Hk1q0Lyl6NGZfBQgpPivyE3y9AuSMQTF0joJLeTRR+kFR
         9f2DlxzOgYpp+r+CQL1CoVJTUy4E/r94Rx9o3LTwmyppXLge1d+ow5hHm9ZM1OTfoX2d
         U9IspooTS2N3622WAH+ULNfX8ZFS5LWi2NIAZwgxn9sAn2qs+NCImBAHpGY8GX5kOdJj
         vSBrcArQNJUdF1ByQHOgDAVT3wc4ob8VV9kwgbtuxHaOyKX1BxfdMgk1QlfnGykDrye4
         iSGw==
X-Forwarded-Encrypted: i=1; AJvYcCUvdObRcznYQvxHRjP0qiIIdaZcCJ4yse/3m2A6HOShMRZDEktvlyZL2Y1m7Tk4qJLh5SZk3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAc5pGMVAos/AHGc94ukNFZ2QPn5mLdSxELjASBgiBTX5jMpZC
	d+vYFvuumcq607dt36YCKJOJb0hoB9urJVsi56R4ggMea6CE5YO3gCsmfj19M3AV7xE=
X-Gm-Gg: AY/fxX7VVlvcqqgUeYFnFZ2G8BgBRiomWTaCWfJxh7J4xUh1xnvV0CzOsTUIlAgga/m
	xhfT4zBMUJ6cKANEKZ2u6S9hBSG17mD2eyeAi0GetAYuDCXUxmL8RFSK/DOvMyiA6+p24rc/I/Q
	P2b0L9KOLGTyg3n+02cHRLNFRWNWR6nGhRUcfkHD/Z8aR+2fIUvXGTX2fcIjYfNdaTwaO6o+Fww
	VkLh289uOjfLhLN9p23S3YnbzX6BiYohR5yv+rzOpfH1iOrymliYf7FY8rri89FMQ2rk0Yx27K9
	ObXI94XM+zv317jI0w8jVi45Pog2925Ke6sABPhTH0pcSdMZtJxn8+zTf7RwP2OsWsexVABGKlG
	kILqgz0JTkIB092xPfdke0J4fIfRrOow0Jmg4w6bAohQV+AQPjJlj6+j3YFsJDr6KweE+sosIWQ
	Mjmsk/SbR53oSKlXB0wtYh6Ry5itde/IKmdthRkbM3mu0Qrd0qEhz/VTB0rxmZcP3yvjl+Btb3z
	F3sXGe/bf1QBJM=
X-Google-Smtp-Source: AGHT+IGPmW2Otkj8FnNc/KvSgCnn85RbpVPA2pWTb5toeH0C7mqfw399DBVUSTCo8Ruk60hhUTeL4g==
X-Received: by 2002:a05:600c:310e:b0:477:7a78:3000 with SMTP id 5b1f17b1804b1-47d195815b0mr307920935e9.6.1767340776886;
        Thu, 01 Jan 2026 23:59:36 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3af6dbdsm314869295e9.19.2026.01.01.23.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 23:59:36 -0800 (PST)
Date: Fri, 2 Jan 2026 08:59:33 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 05/13] dma-debug: track cache clean flag in entries
Message-ID: <20260102085933.2f78123b@mordecai>
In-Reply-To: <c0df5d43759202733ccff045f834bd214977945f.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
	<c0df5d43759202733ccff045f834bd214977945f.1767089672.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 05:16:00 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> If a driver is bugy and has 2 overlapping mappings but only
> sets cache clean flag on the 1st one of them, we warn.
> But if it only does it for the 2nd one, we don't.
> 
> Fix by tracking cache clean flag in the entry.
> Shrink map_err_type to u8 to avoid bloating up the struct.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  kernel/dma/debug.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 7e66d863d573..9bd14fd4c51b 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -63,6 +63,7 @@ enum map_err_types {
>   * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
>   * @paddr: physical start address of the mapping
>   * @map_err_type: track whether dma_mapping_error() was checked
> + * @is_cache_clean: driver promises not to write to buffer while mapped
>   * @stack_len: number of backtrace entries in @stack_entries
>   * @stack_entries: stack of backtrace history
>   */
> @@ -76,7 +77,8 @@ struct dma_debug_entry {
>  	int		 sg_call_ents;
>  	int		 sg_mapped_ents;
>  	phys_addr_t	 paddr;
> -	enum map_err_types  map_err_type;
> +	u8		 map_err_type;

Where exactly is the bloat? With my configuration, the size of struct
dma_debug_entry is 128 bytes, with enough padding bytes at the end to
keep it at 128 even if I keep this member an enum...

Anyway, if there is a reason to keep this member small, I prefer to
pack enum map_err_types instead:

@@ -46,9 +46,9 @@ enum {
 enum map_err_types {
 	MAP_ERR_CHECK_NOT_APPLICABLE,
 	MAP_ERR_NOT_CHECKED,
 	MAP_ERR_CHECKED,
-};
+} __packed;
 
 #define DMA_DEBUG_STACKTRACE_ENTRIES 5
 
 /**

This will shrink it to a single byte but it will also keep the type
information.

> +	bool		 is_cache_clean;
>  #ifdef CONFIG_STACKTRACE
>  	unsigned int	stack_len;
>  	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
> @@ -472,12 +474,15 @@ static int active_cacheline_dec_overlap(phys_addr_t cln)
>  	return active_cacheline_set_overlap(cln, --overlap);
>  }
>  
> -static int active_cacheline_insert(struct dma_debug_entry *entry)
> +static int active_cacheline_insert(struct dma_debug_entry *entry,
> +				   bool *overlap_cache_clean)
>  {
>  	phys_addr_t cln = to_cacheline_number(entry);
>  	unsigned long flags;
>  	int rc;
>  
> +	*overlap_cache_clean = false;
> +
>  	/* If the device is not writing memory then we don't have any
>  	 * concerns about the cpu consuming stale data.  This mitigates
>  	 * legitimate usages of overlapping mappings.
> @@ -487,8 +492,14 @@ static int active_cacheline_insert(struct dma_debug_entry *entry)
>  
>  	spin_lock_irqsave(&radix_lock, flags);
>  	rc = radix_tree_insert(&dma_active_cacheline, cln, entry);
> -	if (rc == -EEXIST)
> +	if (rc == -EEXIST) {
> +		struct dma_debug_entry *existing;
> +
>  		active_cacheline_inc_overlap(cln);
> +		existing = radix_tree_lookup(&dma_active_cacheline, cln);
> +		if (existing)
> +			*overlap_cache_clean = existing->is_cache_clean;

*nitpick*

IIUC radix_tree_insert() returns -EEXIST only if the key is already
present in the tree. Since radix_lock is not released between the
insert attempt and this lookup, I don't see how this lookup could
possibly fail. If it's not expected to fail, I would add a WARN_ON().

Please, do correct me if I'm missing something.

Other than that, LGTM.

Petr T

> +	}
>  	spin_unlock_irqrestore(&radix_lock, flags);
>  
>  	return rc;
> @@ -583,20 +594,24 @@ DEFINE_SHOW_ATTRIBUTE(dump);
>   */
>  static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
>  {
> +	bool overlap_cache_clean;
>  	struct hash_bucket *bucket;
>  	unsigned long flags;
>  	int rc;
>  
> +	entry->is_cache_clean = !!(attrs & DMA_ATTR_CPU_CACHE_CLEAN);
> +
>  	bucket = get_hash_bucket(entry, &flags);
>  	hash_bucket_add(bucket, entry);
>  	put_hash_bucket(bucket, flags);
>  
> -	rc = active_cacheline_insert(entry);
> +	rc = active_cacheline_insert(entry, &overlap_cache_clean);
>  	if (rc == -ENOMEM) {
>  		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
>  		global_disable = true;
>  	} else if (rc == -EEXIST &&
> -		   !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_CPU_CACHE_CLEAN)) &&
> +		   !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> +		   !(entry->is_cache_clean && overlap_cache_clean) &&
>  		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
>  		     is_swiotlb_active(entry->dev))) {
>  		err_printk(entry->dev, entry,

