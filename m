Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE19168488
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496724; cv=none; b=q+h+3334brjg9Rf6rHGIJN1BtvSxJljcXZnTI/fDogFiqv0+cUSHBZG4IvX85zUSvXtZyv24CMYbw9f+6tuEzAMS7yiRcnj6obdQVSLQSC6Op5wPp8THgCcQeiIrN4jI7fKuJnJxOmqtDJSxgJzJArTtziDk+eZ1Wx67TizwdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496724; c=relaxed/simple;
	bh=LbBiV6nsi/J+IrMF3gtgKQSavRfwiKLcJsTTKHaAYeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtA9nfhJdKuoKQTTP5p7Gkt9q6poWQgjqo9GPMTJQqeewJreGoKTCQQQSdSo6+v+7HJRMIZHuIQvFbkXdUiLkv09xeXDmCkPTYpJuoiYDYAFVc0LluPdBBfDcIBmneUdmKmFtn7DwTirNUa4D5yTAQvwVCMOXKBvmZkj6Oe8gXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iu60VZwI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iu60VZwI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723496721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fvp/k4c6ssxQxc3li1rRDmBx8Y22GUNVJDztdSbzXPo=;
	b=Iu60VZwIFX/1MRnnJ6pDU2M3d6Sx7BVl7s+KUNuBbRz8AYK4UYZJCwtYRIRvFPw3IFH86D
	MJ6FmrAxwpy0T/w9ZC8PlWMxk/bCEbLTwo69LU1wZ7n0AvXgSXPfPYnAlldhwJHKEui9Dn
	wLu0vrRW24k1YokgoJm1vG52/GozmM8=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-4geemMWSNMWJEvoH8M5ySQ-1; Mon, 12 Aug 2024 17:05:19 -0400
X-MC-Unique: 4geemMWSNMWJEvoH8M5ySQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f99189f5fso612793339f.3
        for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 14:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723496718; x=1724101518;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fvp/k4c6ssxQxc3li1rRDmBx8Y22GUNVJDztdSbzXPo=;
        b=kZKyY6ebjEkkyoeq/S5OxwG01trbgjxuyV+uk17pqS+MHtuc1uYy8l09g46ctTZ8bu
         jJhxVCo6YJR/lIfm2TRL3WwE6u/j+gH1Drwcg/CjNfjpLRrKmNyzR/oFIIBdMMlW0ORE
         7FWRa31R/VQ+lVJF8zeHEslBk3mJ978A2V5vqqWNJVfYA34zTKyV3tEvVtzHCjlmGhy9
         cnejRwmPQLxNB/KoMvRqnFFu04OFeDEZUTRINmvnEX1SmnDxa9y7MsxhkqyOR31ICtE5
         LIPKjUspzcsVXdMSawHoCsb+zpopRf7E2UfXCTWJbUOxgXRpHFSuZBk+mtbT2W3KilCf
         i/IA==
X-Forwarded-Encrypted: i=1; AJvYcCUaKKoqw15H7hO2ufwEjJcmebhW1tbN435lUFc+66ZIrNoR/6ORi3eOAfLMH0WoZIulGLsGcMhUCKwDJzh1+V02mUGqtd8=
X-Gm-Message-State: AOJu0YxNO8mHN0mXhJJNETn6/3KujqC1qiPD1YyUH4NxUuDumKm5abEg
	1MvrAno8rmlClz/APxb+xYHgqCNuIsZwTrQJ6tU65B/oND5AdvpbgEQubmQ41eWT1h2wmKo+X5z
	UZ93b8GRforl7KmG182+j6/wgGZXcLb1iqMRssVE+EiXEwu0HXhV6
X-Received: by 2002:a05:6602:641a:b0:81f:9468:7c3c with SMTP id ca18e2360f4ac-824c9a3e00cmr210182839f.12.1723496718490;
        Mon, 12 Aug 2024 14:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQY4pYwhRrnIkzDtH54du/yDw84DPv1IwXjyMVqIuMooGwtqen0BuuzgU+vbg0uvpmF13RXQ==
X-Received: by 2002:a05:6602:641a:b0:81f:9468:7c3c with SMTP id ca18e2360f4ac-824c9a3e00cmr210180139f.12.1723496718066;
        Mon, 12 Aug 2024 14:05:18 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca769416e9sm1819446173.69.2024.08.12.14.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 14:05:17 -0700 (PDT)
Date: Mon, 12 Aug 2024 15:05:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev
Subject: Re: mapping files for iommufd
Message-ID: <20240812150516.3e33c5c2.alex.williamson@redhat.com>
In-Reply-To: <684a3618-ee15-4f85-ab44-3de0527f91fa@oracle.com>
References: <a745cabd-5e38-4242-b3b1-da02c1e670a8@oracle.com>
	<20240812184005.GQ8378@nvidia.com>
	<684a3618-ee15-4f85-ab44-3de0527f91fa@oracle.com>
Organization: Red Hat
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

On Mon, 12 Aug 2024 14:56:03 -0400
Steven Sistare <steven.sistare@oracle.com> wrote:

> On 8/12/2024 2:40 PM, Jason Gunthorpe wrote:
> > On Mon, Aug 12, 2024 at 02:09:11PM -0400, Steven Sistare wrote:  
> >> I have been using QEMU to test legacy vfio vs iommufd compatibility vfio.
> >> I find that backing guest memory with an ext4 file /root/guest.ram
> >> succeeds for legacy but fails for iommufd, with EFAULT in
> >> IOMMU_IOAS_MAP -> ... __get_user_pages -> check_vma_flags.  Ditto for a
> >> hugetlbfs file.  This is with unmodified kernels, no live update changes.
> >>
> >> Is this expected?  
> > 
> > Yes - I'm surprised that VFIO is not failing though?
> > 
> > /*
> >   * Writing to file-backed mappings which require folio dirty tracking using GUP
> >   * is a fundamentally broken operation, as kernel write access to GUP mappings
> >   * do not adhere to the semantics expected by a file system.
> >   *
> >   * Consider the following scenario:-
> >   *
> >   * 1. A folio is written to via GUP which write-faults the memory, notifying
> >   *    the file system and dirtying the folio.
> >   * 2. Later, writeback is triggered, resulting in the folio being cleaned and
> >   *    the PTE being marked read-only.
> >   * 3. The GUP caller writes to the folio, as it is mapped read/write via the
> >   *    direct mapping.
> >   * 4. The GUP caller, now done with the page, unpins it and sets it dirty
> >   *    (though it does not have to).
> >   *
> >   * This results in both data being written to a folio without writenotify, and
> >   * the folio being dirtied unexpectedly (if the caller decides to do so).
> >   */
> > static bool writable_file_mapping_allowed(struct vm_area_struct *vma,
> > 					  unsigned long gup_flags)
> > {
> > 
> > Why doesn't that fail in the VFIO case? I didn't notice anything
> > special there that would make it work???  
> 
> vfio_dma_do_map -> vfio_pin_map_dma -> vfio_pin_pages_remote does not call GUP,
> it just grabs a reference to each page.

Can you be more specific, because...

vfio_pin_pages_remote
  vaddr_get_pfns
    pin_user_pages_remote
      __gup_longterm_locked
        __get_user_pages_locked
          __get_user_pages

Thanks,
Alex

