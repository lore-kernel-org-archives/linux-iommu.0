Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA916EBEA
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457404; cv=none; b=cXBI6s0Nxw3ePmFXK5+AipG/em0/6Eh+IaQU/it4bajhPKD+g0ToAfE38+vRl8IIu/SuVXKLSgD5uCY5xlEjPFRqUN1p94nIcWum43SH9ex4RHz8l9YOkPJS1QZrtjB2BytQDBsFfusIdurhl7KEv4smvr8AYBnxOx2NF8fhgeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457404; c=relaxed/simple;
	bh=TjOvDbdSH+dx9HkxftsUqbLvpLxJA7iClDmwglPSNDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRb6CVSObterNbbmXb8BTA+l3he4vgmkTL8kHD4pVqIcghu+vzGwABUtLSJO4Jgz3TfiiCoEzXmTalZSc4BujoC8bRVPDl+HXHd7uPljHkUrgn1K1e4MEmYsloIMnSqUmCgVacAQxWAq11mJOpe50Smeosed7hK/eyC1lHFxjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CU4YlQQH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CU4YlQQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713457401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OpPhF8w7waMvk5Q41LU8inZX3Uugvi3adKbK1DhEk7o=;
	b=CU4YlQQHkYPQSxtwh+EGdJu1MS9vb6PEuQz9nITeQbtbfjitOs7mOJL1kMFiVq4I686J6B
	1ylN+jOh4TQnqKOZ2XOZw6RnxcgGt6NAOkMjOmXUw5HBj6frOlFAmD1wM2zPkn9mPWuj4t
	V9GO4yiioOnKv4T89+GuyEbheOthJpY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-z1zv9BzkNVmhxrTbdHEJlw-1; Thu, 18 Apr 2024 12:23:17 -0400
X-MC-Unique: z1zv9BzkNVmhxrTbdHEJlw-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da1e2fc445so117283439f.1
        for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 09:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457397; x=1714062197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpPhF8w7waMvk5Q41LU8inZX3Uugvi3adKbK1DhEk7o=;
        b=DPvJNCbGDkR6j2BoCQr1T2RTOu46WTgvGMhg9hoh3yyR/GMRxQ4U6mu3J3VPcBwz9y
         xLVB2HOE2klbP2eY20gYmjyD/hvx3piWKgYHxxwUjh2mrLMa9MzjgH/D86C8ea9YZDdF
         Idbs3JJGNNNYhAZ4bybNggHopX1qzBtQmGk8YnUoQl9ID8j7ICx459L522p/4sQ27t/U
         Dnz6U7fWkDCg+uADYUrCBJpzAyvGWZcNed/96rV+a4RtiYrLmvA+vRU2ChG/LuA92vwW
         IpwxGvsRo2tOoNzPsquz73Oa4p1oC3Xn5OBpKoRFlunEZGExi743WW2bHFFqMJNFm5sr
         vLOw==
X-Forwarded-Encrypted: i=1; AJvYcCXQzVArJYoednhCap9CybwGu2vAj2R+ODiXiSZErYUEGRRJdlOwyge92EQVTLRMe30IAzJ+EZRO5j64oOxjJTKKNdTBS6c=
X-Gm-Message-State: AOJu0YygTpSUK987WP/eDd9tr0oeJELIgCQNdYVhqfI6NaWk/6yDet/C
	/DXavOzcdW88JlZ6ia9PgUSzQlw2WdI0JJEtRs5qoNCzkoYKSC2Zf5JvW5vW98rRune3zsZ1qkL
	fEmzvBpcBPntoq21ikZYnQ/k/lGzr+IV48HYZYlFfib/1YyLoeDEQ
X-Received: by 2002:a05:6602:2289:b0:7d5:f591:2cc2 with SMTP id d9-20020a056602228900b007d5f5912cc2mr3572769iod.17.1713457396757;
        Thu, 18 Apr 2024 09:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfNtiABViCn51G//5YknWbS0WdR7g/EL6w1vtnNGKLFbqCipmFcU3Cc0Lw1gIFArYQDtFutw==
X-Received: by 2002:a05:6602:2289:b0:7d5:f591:2cc2 with SMTP id d9-20020a056602228900b007d5f5912cc2mr3572741iod.17.1713457396409;
        Thu, 18 Apr 2024 09:23:16 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id hj18-20020a0566021d9200b007d5d1e0ae05sm419393iob.44.2024.04.18.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:23:15 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:23:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
 <robin.murphy@arm.com>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
 <kvm@vger.kernel.org>, <chao.p.peng@linux.intel.com>,
 <iommu@lists.linux.dev>, <baolu.lu@linux.intel.com>,
 <zhenzhong.duan@intel.com>, <jacob.jun.pan@intel.com>, Matthew Wilcox
 <willy@infradead.org>
Subject: Re: [PATCH v2 1/4] ida: Add ida_get_lowest()
Message-ID: <20240418102314.6a3d344a.alex.williamson@redhat.com>
In-Reply-To: <e3531550-8644-4a7e-94bd-75bdb52182be@intel.com>
References: <20240412082121.33382-1-yi.l.liu@intel.com>
	<20240412082121.33382-2-yi.l.liu@intel.com>
	<20240416100329.35cede17.alex.williamson@redhat.com>
	<e3531550-8644-4a7e-94bd-75bdb52182be@intel.com>
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

On Thu, 18 Apr 2024 15:02:46 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 2024/4/17 00:03, Alex Williamson wrote:
> > On Fri, 12 Apr 2024 01:21:18 -0700
> > Yi Liu <yi.l.liu@intel.com> wrote:
> >   
> >> There is no helpers for user to check if a given ID is allocated or not,
> >> neither a helper to loop all the allocated IDs in an IDA and do something
> >> for cleanup. With the two needs, a helper to get the lowest allocated ID
> >> of a range can help to achieve it.
> >>
> >> Caller can check if a given ID is allocated or not by:
> >> 	int id = 200, rc;
> >>
> >> 	rc = ida_get_lowest(&ida, id, id);
> >> 	if (rc == id)
> >> 		//id 200 is used
> >> 	else
> >> 		//id 200 is not used
> >>
> >> Caller can iterate all allocated IDs by:
> >> 	int id = 0;
> >>
> >> 	while (!ida_is_empty(&pasid_ida)) {
> >> 		id = ida_get_lowest(pasid_ida, id, INT_MAX);
> >> 		if (id < 0)
> >> 			break;
> >> 		//anything to do with the allocated ID
> >> 		ida_free(pasid_ida, pasid);
> >> 	}
> >>
> >> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> >> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> >> ---
> >>   include/linux/idr.h |  1 +
> >>   lib/idr.c           | 67 +++++++++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 68 insertions(+)
> >>
> >> diff --git a/include/linux/idr.h b/include/linux/idr.h
> >> index da5f5fa4a3a6..1dae71d4a75d 100644
> >> --- a/include/linux/idr.h
> >> +++ b/include/linux/idr.h
> >> @@ -257,6 +257,7 @@ struct ida {
> >>   int ida_alloc_range(struct ida *, unsigned int min, unsigned int max, gfp_t);
> >>   void ida_free(struct ida *, unsigned int id);
> >>   void ida_destroy(struct ida *ida);
> >> +int ida_get_lowest(struct ida *ida, unsigned int min, unsigned int max);
> >>   
> >>   /**
> >>    * ida_alloc() - Allocate an unused ID.
> >> diff --git a/lib/idr.c b/lib/idr.c
> >> index da36054c3ca0..03e461242fe2 100644
> >> --- a/lib/idr.c
> >> +++ b/lib/idr.c
> >> @@ -476,6 +476,73 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
> >>   }
> >>   EXPORT_SYMBOL(ida_alloc_range);
> >>   
> >> +/**
> >> + * ida_get_lowest - Get the lowest used ID.
> >> + * @ida: IDA handle.
> >> + * @min: Lowest ID to get.
> >> + * @max: Highest ID to get.
> >> + *
> >> + * Get the lowest used ID between @min and @max, inclusive.  The returned
> >> + * ID will not exceed %INT_MAX, even if @max is larger.
> >> + *
> >> + * Context: Any context. Takes and releases the xa_lock.
> >> + * Return: The lowest used ID, or errno if no used ID is found.
> >> + */
> >> +int ida_get_lowest(struct ida *ida, unsigned int min, unsigned int max)
> >> +{
> >> +	unsigned long index = min / IDA_BITMAP_BITS;
> >> +	unsigned int offset = min % IDA_BITMAP_BITS;
> >> +	unsigned long *addr, size, bit;
> >> +	unsigned long flags;
> >> +	void *entry;
> >> +	int ret;
> >> +
> >> +	if (min >= INT_MAX)
> >> +		return -EINVAL;
> >> +	if (max >= INT_MAX)
> >> +		max = INT_MAX;
> >> +  
> > 
> > Could these be made consistent with the test in ida_alloc_range(), ie:
> > 
> > 	if ((int)min < 0)
> > 		return -EINVAL;
> > 	if ((int)max < 0)
> > 		max = INT_MAX;
> >   
> 
> sure.
> 
> >> +	xa_lock_irqsave(&ida->xa, flags);
> >> +
> >> +	entry = xa_find(&ida->xa, &index, max / IDA_BITMAP_BITS, XA_PRESENT);
> >> +	if (!entry) {
> >> +		ret = -ENOTTY;  
> > 
> > -ENOENT?  Same for all below too.  
> 
> I see.
> 
> >> +		goto err_unlock;
> >> +	}
> >> +
> >> +	if (index > min / IDA_BITMAP_BITS)
> >> +		offset = 0;
> >> +	if (index * IDA_BITMAP_BITS + offset > max) {
> >> +		ret = -ENOTTY;
> >> +		goto err_unlock;
> >> +	}
> >> +
> >> +	if (xa_is_value(entry)) {
> >> +		unsigned long tmp = xa_to_value(entry);
> >> +
> >> +		addr = &tmp;
> >> +		size = BITS_PER_XA_VALUE;
> >> +	} else {
> >> +		addr = ((struct ida_bitmap *)entry)->bitmap;
> >> +		size = IDA_BITMAP_BITS;
> >> +	}
> >> +
> >> +	bit = find_next_bit(addr, size, offset);
> >> +
> >> +	xa_unlock_irqrestore(&ida->xa, flags);
> >> +
> >> +	if (bit == size ||
> >> +	    index * IDA_BITMAP_BITS + bit > max)
> >> +		return -ENOTTY;
> >> +
> >> +	return index * IDA_BITMAP_BITS + bit;
> >> +
> >> +err_unlock:
> >> +	xa_unlock_irqrestore(&ida->xa, flags);
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL(ida_get_lowest);  
> > 
> > The API is a bit awkward to me, I wonder if it might be helped with
> > some renaming and wrappers...
> > 
> > int ida_find_first_range(struct ida *ida, unsigned int min, unsigned int max);  
> 
> ok.
> 
> > bool ida_exists(struct ida *ida, unsigned int id)
> > {
> > 	return ida_find_first_range(ida, id, id) == id;
> > }  
> 
> this does helps in next patch.
> 
> > 
> > int ida_find_first(struct ida *ida)
> > {
> > 	return ida_find_first_range(ida, 0, ~0);
> > }
> >  
> 
> perhaps it can be added in future. This series has two usages. One is to
> check if a given ID is allocated. This can be covered by your ida_exists().
> Another usage is to loop each IDs, do detach and free. This can still use
> the ida_find_first_range() like the example in the commit message. The
> first loop starts from 0, and next would start from the last found ID.
> This may be more efficient than starts from 0 in every loop.
> 
> 
> > _min and _max variations of the latter would align with existing
> > ida_alloc variants, but maybe no need to add them preemptively.  
> 
> yes.
> 
> > Possibly an ida_for_each() could be useful in the use case of
> > disassociating each id, but not required for the brute force iterative
> > method.  Thanks,  
> 
> yep. maybe we can start with the below code, no need for ida_for_each()
> today.
> 
> 
>   	int id = 0;
> 
>   	while (!ida_is_empty(&pasid_ida)) {
>   		id = ida_find_first_range(pasid_ida, id, INT_MAX);

You've actually already justified the _min function here:

static inline int ida_find_first_min(struct ida *ida, unsigned int min)
{
	return ida_find_first_range(ida, min, ~0);
}

Thanks,
Alex

>   		if (unlikely(WARN_ON(id < 0))
> 			break;
>   		iommufd_device_pasid_detach();
>   		ida_free(pasid_ida, pasid);
>   	}
> 
> >   
> >> +
> >>   /**
> >>    * ida_free() - Release an allocated ID.
> >>    * @ida: IDA handle.  
> >   
> 

