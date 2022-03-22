Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C831C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 22:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3EC5848D6;
	Tue, 22 Mar 2022 22:15:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iLTcRjiINGwG; Tue, 22 Mar 2022 22:15:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7DC03848DD;
	Tue, 22 Mar 2022 22:15:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53A1BC001A;
	Tue, 22 Mar 2022 22:15:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14809C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 22:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F18ED41638
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 22:15:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YtaDGJGKY7Hk for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 22:15:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B2434160F
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 22:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647987348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Plq65sjLL0seJ7WvmjtQdv4sWgADshYNALH0Py3ngKI=;
 b=iMXaiUen2xwE73JvBxpJgEZDin78wKILHzSWCz5yQ6I6KpPIgKJcjM6/Pj0+k34hHBj3yL
 B89qifx6cdE45/0jJc53HxdIu+apjS1wNX7GhQ5AnVm74FPth3WnHmsSJ63MruScrO/ZtM
 PYlRAZ+b5VkO2iWRdQuSE6JWdCdHukg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-1ptEe3RZMXS83aG1LV4UAQ-1; Tue, 22 Mar 2022 18:15:47 -0400
X-MC-Unique: 1ptEe3RZMXS83aG1LV4UAQ-1
Received: by mail-io1-f72.google.com with SMTP id
 g11-20020a056602072b00b00645cc0735d7so13343596iox.1
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 15:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=Plq65sjLL0seJ7WvmjtQdv4sWgADshYNALH0Py3ngKI=;
 b=MtJbGNTQMVQ+dD2I66jzmjijlnYYdhrQWb9Qw5Euv/R3bcs/OwzVSxOZ8oc3wdJW4J
 LNWtq0pGVXtAU3inoqSlrVwvaDkHPMBAicTI+pdmBJGL0EMYIvFiVyeTpSw8ySqr6sWJ
 hkkPhBBrvmXQTXwvJF+0/bq8HIjY7CG/uvNpPqI/32CHmVag1jB/l0rF/8X686h247ev
 X5ov0W1UTbDBok3wo7xZJFHYJl/7CCs0V5q5K9sBezCaNXlQ+Dg5gUWYYy/cbGyPS1VT
 dJe2wlysLV/rpHFjZxY0AWVmPcpXV2+rwFwWUh0GEASj94kdhtiVLsRAegy2PcUAv/U+
 237A==
X-Gm-Message-State: AOAM533FXtY2gHLev6uRGoIZ23ZERM5BO6P8Nmhfp5//p1RyyZJLFUQC
 pQD/5i00H0npD63sZGOFNwfdPomBAd7t6gQ/XWHUk1oAmeZKBgJteeoZSu81LDKWrm01hA8FouS
 fsp9W1XAzOUyhY/6IzfCI1xt1ZNvmDQ==
X-Received: by 2002:a6b:6902:0:b0:649:d744:e0da with SMTP id
 e2-20020a6b6902000000b00649d744e0damr992070ioc.211.1647987346868; 
 Tue, 22 Mar 2022 15:15:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxjk0g8Sn80FYrVpeaQccm0Nksq/bB6kFNnm5nbL6fD3Uhbg9fTikYRNK1AIqrXjXzanDEWg==
X-Received: by 2002:a6b:6902:0:b0:649:d744:e0da with SMTP id
 e2-20020a6b6902000000b00649d744e0damr992055ioc.211.1647987346557; 
 Tue, 22 Mar 2022 15:15:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 s13-20020a6bdc0d000000b006408888551dsm10103375ioc.8.2022.03.22.15.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 15:15:46 -0700 (PDT)
Date: Tue, 22 Mar 2022 16:15:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 07/12] iommufd: Data structure to provide IOVA to
 PFN mapping
Message-ID: <20220322161544.54fd459d.alex.williamson@redhat.com>
In-Reply-To: <7-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <7-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Kevin Tian <kevin.tian@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 iommu@lists.linux-foundation.org, Joao Martins <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 18 Mar 2022 14:27:32 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:
> +/*
> + * The area takes a slice of the pages from start_bytes to start_byte + length
> + */
> +static struct iopt_area *
> +iopt_alloc_area(struct io_pagetable *iopt, struct iopt_pages *pages,
> +		unsigned long iova, unsigned long start_byte,
> +		unsigned long length, int iommu_prot, unsigned int flags)
> +{
> +	struct iopt_area *area;
> +	int rc;
> +
> +	area = kzalloc(sizeof(*area), GFP_KERNEL);
> +	if (!area)
> +		return ERR_PTR(-ENOMEM);
> +
> +	area->iopt = iopt;
> +	area->iommu_prot = iommu_prot;
> +	area->page_offset = start_byte % PAGE_SIZE;
> +	area->pages_node.start = start_byte / PAGE_SIZE;
> +	if (check_add_overflow(start_byte, length - 1, &area->pages_node.last))
> +		return ERR_PTR(-EOVERFLOW);
> +	area->pages_node.last = area->pages_node.last / PAGE_SIZE;
> +	if (WARN_ON(area->pages_node.last >= pages->npages))
> +		return ERR_PTR(-EOVERFLOW);

@area leaked in the above two error cases.

> +
> +	down_write(&iopt->iova_rwsem);
> +	if (flags & IOPT_ALLOC_IOVA) {
> +		rc = iopt_alloc_iova(iopt, &iova,
> +				     (uintptr_t)pages->uptr + start_byte,
> +				     length);
> +		if (rc)
> +			goto out_unlock;
> +	}
> +
> +	if (check_add_overflow(iova, length - 1, &area->node.last)) {
> +		rc = -EOVERFLOW;
> +		goto out_unlock;
> +	}
> +
> +	if (!(flags & IOPT_ALLOC_IOVA)) {
> +		if ((iova & (iopt->iova_alignment - 1)) ||
> +		    (length & (iopt->iova_alignment - 1)) || !length) {
> +			rc = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		/* No reserved IOVA intersects the range */
> +		if (interval_tree_iter_first(&iopt->reserved_iova_itree, iova,
> +					     area->node.last)) {
> +			rc = -ENOENT;
> +			goto out_unlock;
> +		}
> +
> +		/* Check that there is not already a mapping in the range */
> +		if (iopt_area_iter_first(iopt, iova, area->node.last)) {
> +			rc = -EADDRINUSE;
> +			goto out_unlock;
> +		}
> +	}
> +
> +	/*
> +	 * The area is inserted with a NULL pages indicating it is not fully
> +	 * initialized yet.
> +	 */
> +	area->node.start = iova;
> +	interval_tree_insert(&area->node, &area->iopt->area_itree);
> +	up_write(&iopt->iova_rwsem);
> +	return area;
> +
> +out_unlock:
> +	up_write(&iopt->iova_rwsem);
> +	kfree(area);
> +	return ERR_PTR(rc);
> +}
...
> +/**
> + * iopt_access_pages() - Return a list of pages under the iova
> + * @iopt: io_pagetable to act on
> + * @iova: Starting IOVA
> + * @length: Number of bytes to access
> + * @out_pages: Output page list
> + * @write: True if access is for writing
> + *
> + * Reads @npages starting at iova and returns the struct page * pointers. These
> + * can be kmap'd by the caller for CPU access.
> + *
> + * The caller must perform iopt_unaccess_pages() when done to balance this.
> + *
> + * iova can be unaligned from PAGE_SIZE. The first returned byte starts at
> + * page_to_phys(out_pages[0]) + (iova % PAGE_SIZE). The caller promises not to
> + * touch memory outside the requested iova slice.
> + *
> + * FIXME: callers that need a DMA mapping via a sgl should create another
> + * interface to build the SGL efficiently
> + */
> +int iopt_access_pages(struct io_pagetable *iopt, unsigned long iova,
> +		      unsigned long length, struct page **out_pages, bool write)
> +{
> +	unsigned long cur_iova = iova;
> +	unsigned long last_iova;
> +	struct iopt_area *area;
> +	int rc;
> +
> +	if (!length)
> +		return -EINVAL;
> +	if (check_add_overflow(iova, length - 1, &last_iova))
> +		return -EOVERFLOW;
> +
> +	down_read(&iopt->iova_rwsem);
> +	for (area = iopt_area_iter_first(iopt, iova, last_iova); area;
> +	     area = iopt_area_iter_next(area, iova, last_iova)) {
> +		unsigned long last = min(last_iova, iopt_area_last_iova(area));
> +		unsigned long last_index;
> +		unsigned long index;
> +
> +		/* Need contiguous areas in the access */
> +		if (iopt_area_iova(area) < cur_iova || !area->pages) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Should this be (cur_iova != iova && iopt_area_iova(area) < cur_iova)?

I can't see how we'd require in-kernel page users to know the iopt_area
alignment from userspace, so I think this needs to skip the first
iteration.  Thanks,

Alex

> +			rc = -EINVAL;
> +			goto out_remove;
> +		}
> +
> +		index = iopt_area_iova_to_index(area, cur_iova);
> +		last_index = iopt_area_iova_to_index(area, last);
> +		rc = iopt_pages_add_user(area->pages, index, last_index,
> +					 out_pages, write);
> +		if (rc)
> +			goto out_remove;
> +		if (last == last_iova)
> +			break;
> +		/*
> +		 * Can't cross areas that are not aligned to the system page
> +		 * size with this API.
> +		 */
> +		if (cur_iova % PAGE_SIZE) {
> +			rc = -EINVAL;
> +			goto out_remove;
> +		}
> +		cur_iova = last + 1;
> +		out_pages += last_index - index;
> +		atomic_inc(&area->num_users);
> +	}
> +
> +	up_read(&iopt->iova_rwsem);
> +	return 0;
> +
> +out_remove:
> +	if (cur_iova != iova)
> +		iopt_unaccess_pages(iopt, iova, cur_iova - iova);
> +	up_read(&iopt->iova_rwsem);
> +	return rc;
> +}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
