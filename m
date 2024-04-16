Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E1131737
	for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283422; cv=none; b=FWb1qHYKZcVLGxLZJ7a5XHIveyJyUrdH7mo4DMExq+sWorMwfEAI0YfblXRJ2V7zTwwgW+fCZap65Nqgr/0Iw38e7H9IKi58KSMTjQYRosgADS3HxlHAjegyRZlk/ILk2H3wj8vDddSwai4I7SEb3ZEEtNfEQX7b5r5bclDelI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283422; c=relaxed/simple;
	bh=si6bSXALhcGafn0TtYNK4HLYq/pmOcGZ8JvxEosmpvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQwK/Y5i+/ky+tEpuYJOueq8Lad52V1FrvCY63xI9hUpJOD+fA9wVrqj99PSuOMcgsmo0GAmGMzQX3SPdSaUL/uAwdIkciLdYQoaEeSksldBtygH/5yZsfrDNa/8O7n3SeuZJf5lI/YvYzTiXMwS+sHY2X1pr4CARQFlFBPrG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5/DVgwF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5/DVgwF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713283417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1uoik0NkY6s/5+CwKoUEiuhmIYFgX72G/vMa5Zu8RA=;
	b=T5/DVgwFpJavXXfLPeiGE4dxfFDWbMLKhwwAOFIuNv1KyJU4lE+NHYlWrJkCbMsGaruXK4
	DlSYJomT+om3Iuz6nf1Sctqmq0KSuWW4KpgiInnmkT6UlW8EIkZbubTf7t1HwVVqbqjxMn
	eOpkuc3QG4TDRBOxq1qthiNvsXF6qeM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-DIChk8I9NmaBYLkQ_KdhRA-1; Tue, 16 Apr 2024 12:03:33 -0400
X-MC-Unique: DIChk8I9NmaBYLkQ_KdhRA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d6c32ef13bso340373639f.0
        for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 09:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713283412; x=1713888212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1uoik0NkY6s/5+CwKoUEiuhmIYFgX72G/vMa5Zu8RA=;
        b=MbbhUYbY5CeXGVSDAxERFGNgBvMtu9xg/JUn60jKTHXhf/QNY3awFLiX06QzP1iOHP
         19KrUaICDBVvD5JA78IdW8AG2kUwcjRifm6SEGRaYEudwNSMGcPKVs+pWITUjhBSY4Rd
         nzOrgyEqeiteRmBIxbfKK4ejmtnT5SRueCCheXM05emEodiMRrFq1wjMyFuJx2400ZqX
         KrN7ofC9iE6u/COcXge4FsRSmZDS51zQiWOBRVqHsUPWMBW/J57AQNEt8iPGrXKZVk0h
         7oQzvmatDcT1pODPsC8KjqUtwkqDOIc5SYxZ8cjZ8zM8YR4KMc1GjbpmU9fv32C3bu2I
         V3dA==
X-Forwarded-Encrypted: i=1; AJvYcCVTBKiBjhFzsi9kGYK9t6dwJLf6FATgnTrkxJ/zoJRHWHy13oD9HFEd2D74Q/PE6Q6lSXNcU5ijiEzWdjCs4KR/CKejn0E=
X-Gm-Message-State: AOJu0YzviKWYz2S3iD04ZdMShSYK5SZ+iQzIvQqp9EOczZ1piKJpitcM
	ob9s5Zme347W+a3xrS0GTBalbf3YCkXUDjtBPhlFwlVJOribVU9OC7fqw4wlconpLVfej0bcZoE
	es6+jGeNAtO3zPF/IEuTFxu7Z9sTR0FgJ5PGFBLsg2pBiKahkbSgC
X-Received: by 2002:a05:6e02:1381:b0:36a:2351:60a with SMTP id d1-20020a056e02138100b0036a2351060amr15722305ilo.25.1713283412571;
        Tue, 16 Apr 2024 09:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP6XbG7AtMfSt8tTbG0ms4D7qY6F6Q/+JOauf6Lfwl470OQ4wnMZZbLNCupK1yrrHtrfsj7Q==
X-Received: by 2002:a05:6e02:1381:b0:36a:2351:60a with SMTP id d1-20020a056e02138100b0036a2351060amr15722277ilo.25.1713283412251;
        Tue, 16 Apr 2024 09:03:32 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ay24-20020a056638411800b0048300215ce3sm1861970jab.155.2024.04.16.09.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:03:31 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:03:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
 robin.murphy@arm.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
 jacob.jun.pan@intel.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/4] ida: Add ida_get_lowest()
Message-ID: <20240416100329.35cede17.alex.williamson@redhat.com>
In-Reply-To: <20240412082121.33382-2-yi.l.liu@intel.com>
References: <20240412082121.33382-1-yi.l.liu@intel.com>
	<20240412082121.33382-2-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 01:21:18 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> There is no helpers for user to check if a given ID is allocated or not,
> neither a helper to loop all the allocated IDs in an IDA and do something
> for cleanup. With the two needs, a helper to get the lowest allocated ID
> of a range can help to achieve it.
> 
> Caller can check if a given ID is allocated or not by:
> 	int id = 200, rc;
> 
> 	rc = ida_get_lowest(&ida, id, id);
> 	if (rc == id)
> 		//id 200 is used
> 	else
> 		//id 200 is not used
> 
> Caller can iterate all allocated IDs by:
> 	int id = 0;
> 
> 	while (!ida_is_empty(&pasid_ida)) {
> 		id = ida_get_lowest(pasid_ida, id, INT_MAX);
> 		if (id < 0)
> 			break;
> 		//anything to do with the allocated ID
> 		ida_free(pasid_ida, pasid);
> 	}
> 
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  include/linux/idr.h |  1 +
>  lib/idr.c           | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/include/linux/idr.h b/include/linux/idr.h
> index da5f5fa4a3a6..1dae71d4a75d 100644
> --- a/include/linux/idr.h
> +++ b/include/linux/idr.h
> @@ -257,6 +257,7 @@ struct ida {
>  int ida_alloc_range(struct ida *, unsigned int min, unsigned int max, gfp_t);
>  void ida_free(struct ida *, unsigned int id);
>  void ida_destroy(struct ida *ida);
> +int ida_get_lowest(struct ida *ida, unsigned int min, unsigned int max);
>  
>  /**
>   * ida_alloc() - Allocate an unused ID.
> diff --git a/lib/idr.c b/lib/idr.c
> index da36054c3ca0..03e461242fe2 100644
> --- a/lib/idr.c
> +++ b/lib/idr.c
> @@ -476,6 +476,73 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
>  }
>  EXPORT_SYMBOL(ida_alloc_range);
>  
> +/**
> + * ida_get_lowest - Get the lowest used ID.
> + * @ida: IDA handle.
> + * @min: Lowest ID to get.
> + * @max: Highest ID to get.
> + *
> + * Get the lowest used ID between @min and @max, inclusive.  The returned
> + * ID will not exceed %INT_MAX, even if @max is larger.
> + *
> + * Context: Any context. Takes and releases the xa_lock.
> + * Return: The lowest used ID, or errno if no used ID is found.
> + */
> +int ida_get_lowest(struct ida *ida, unsigned int min, unsigned int max)
> +{
> +	unsigned long index = min / IDA_BITMAP_BITS;
> +	unsigned int offset = min % IDA_BITMAP_BITS;
> +	unsigned long *addr, size, bit;
> +	unsigned long flags;
> +	void *entry;
> +	int ret;
> +
> +	if (min >= INT_MAX)
> +		return -EINVAL;
> +	if (max >= INT_MAX)
> +		max = INT_MAX;
> +

Could these be made consistent with the test in ida_alloc_range(), ie:

	if ((int)min < 0)
		return -EINVAL;
	if ((int)max < 0)
		max = INT_MAX;


> +	xa_lock_irqsave(&ida->xa, flags);
> +
> +	entry = xa_find(&ida->xa, &index, max / IDA_BITMAP_BITS, XA_PRESENT);
> +	if (!entry) {
> +		ret = -ENOTTY;

-ENOENT?  Same for all below too.

> +		goto err_unlock;
> +	}
> +
> +	if (index > min / IDA_BITMAP_BITS)
> +		offset = 0;
> +	if (index * IDA_BITMAP_BITS + offset > max) {
> +		ret = -ENOTTY;
> +		goto err_unlock;
> +	}
> +
> +	if (xa_is_value(entry)) {
> +		unsigned long tmp = xa_to_value(entry);
> +
> +		addr = &tmp;
> +		size = BITS_PER_XA_VALUE;
> +	} else {
> +		addr = ((struct ida_bitmap *)entry)->bitmap;
> +		size = IDA_BITMAP_BITS;
> +	}
> +
> +	bit = find_next_bit(addr, size, offset);
> +
> +	xa_unlock_irqrestore(&ida->xa, flags);
> +
> +	if (bit == size ||
> +	    index * IDA_BITMAP_BITS + bit > max)
> +		return -ENOTTY;
> +
> +	return index * IDA_BITMAP_BITS + bit;
> +
> +err_unlock:
> +	xa_unlock_irqrestore(&ida->xa, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ida_get_lowest);

The API is a bit awkward to me, I wonder if it might be helped with
some renaming and wrappers...

int ida_find_first_range(struct ida *ida, unsigned int min, unsigned int max);

bool ida_exists(struct ida *ida, unsigned int id)
{
	return ida_find_first_range(ida, id, id) == id;
}

int ida_find_first(struct ida *ida)
{
	return ida_find_first_range(ida, 0, ~0);
}

_min and _max variations of the latter would align with existing
ida_alloc variants, but maybe no need to add them preemptively.

Possibly an ida_for_each() could be useful in the use case of
disassociating each id, but not required for the brute force iterative
method.  Thanks,

Alex

> +
>  /**
>   * ida_free() - Release an allocated ID.
>   * @ida: IDA handle.

