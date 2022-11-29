Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DE5BA28
	for <iommu@lists.linux.dev>; Tue, 29 Nov 2022 20:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669754553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORCjmiGb/K/55tEXTBQQi1bJm0eRrca3JaXl3fCWtkw=;
	b=DrxofvLCRjXirT/jJXnoCf8qzwNJnrIditNr9qA2wCf6JkeY6ciLhyB003qPyH7dZoWQeU
	lBQYpd/J8oCxFzncMn1i6mKTYVVZw9tPmvcb6PKtsbMVhYgdlfENC05l49kvfatvJ1cQdo
	IBM8qJyG/jzPFXeIvNNUtA16gkvlUn4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-nKX_7hNlNAuc9s6aDK11Aw-1; Tue, 29 Nov 2022 15:42:31 -0500
X-MC-Unique: nKX_7hNlNAuc9s6aDK11Aw-1
Received: by mail-wr1-f72.google.com with SMTP id s1-20020adfa281000000b00241f7467851so3115702wra.17
        for <iommu@lists.linux.dev>; Tue, 29 Nov 2022 12:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORCjmiGb/K/55tEXTBQQi1bJm0eRrca3JaXl3fCWtkw=;
        b=JOc+SlUuPoYpRVrzqIbjfW4V5Atj2AOFdZEwlcGqEcKlHKI74dHCu85x4v+1TYGVb2
         aVMN/XalAsU43RQ49uSfts9WOuNBdO4xKJe9h27+XwQrPxH8Pe/XmhCnCbhFNIeaUYQE
         QMDYI6o1ivMdgCc5miNLPGMxcRvAis9EBpCoPbUchkMZ27UKjWYNSSYDG4xqPsbFJboV
         LhlPTZrBZXTzYGxpQMQpdLfvLRNoQzA8BdfVOZnfjKQMTq3iyPWw628PTr/dGfweYfvA
         nGBqtansVn2GfKaTi0Qgt1RhorLJBi9UnsoxsjKZhR6vn5j6bDN8wsdeIS4ec9qoIWq3
         I+Qg==
X-Gm-Message-State: ANoB5pnKsZm7nZgdxglkpUruAQpxwpSbqsarMQ36qEWbwUQVHr5Wclm9
	xfk/x1B2JZzXkr9IIdyxa4QT5LeGynqpDMrm5cPE4zqTmVP3oMOpnWipmfNN1/viTYjIKynk9lI
	aJZWuQ49BpNA7I9I=
X-Received: by 2002:a05:6000:691:b0:241:b92b:d086 with SMTP id bo17-20020a056000069100b00241b92bd086mr36364805wrb.259.1669754550273;
        Tue, 29 Nov 2022 12:42:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf63ZsyYy47GtAtEWEyrk5xpOClIukNmSA71TCq1WrQI5aN9Cx4NyxS/92+TDYLGEWXsJMj+0A==
X-Received: by 2002:a05:6000:691:b0:241:b92b:d086 with SMTP id bo17-20020a056000069100b00241b92bd086mr36364796wrb.259.1669754550033;
        Tue, 29 Nov 2022 12:42:30 -0800 (PST)
Received: from redhat.com ([2.52.149.178])
        by smtp.gmail.com with ESMTPSA id r4-20020a0560001b8400b00241bd7a7165sm14614156wru.82.2022.11.29.12.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:42:29 -0800 (PST)
Date: Tue, 29 Nov 2022 15:42:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Cornelia Huck <cohuck@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Farman <farman@linux.ibm.com>, iommu@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jason Herne <jjherne@linux.ibm.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Yi Liu <yi.l.liu@intel.com>, Yu He <yu.he@intel.com>,
	Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v6 07/19] kernel/user: Allow user::locked_vm to be usable
 for iommufd
Message-ID: <20221129154048-mutt-send-email-mst@kernel.org>
References: <0-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com>
 <7-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 29, 2022 at 04:29:30PM -0400, Jason Gunthorpe wrote:
> Following the pattern of io_uring, perf, skb, and bpf, iommfd will use
> user->locked_vm for accounting pinned pages. Ensure the value is included
> in the struct and export free_uid() as iommufd is modular.
> 
> user->locked_vm is the good accounting to use for ulimit because it is
> per-user, and the security sandboxing of locked pages is not supposed to
> be per-process. Other places (vfio, vdpa and infiniband) have used
> mm->pinned_vm and/or mm->locked_vm for accounting pinned pages, but this
> is only per-process and inconsistent with the new FOLL_LONGTERM users in
> the kernel.
> 
> Concurrent work is underway to try to put this in a cgroup, so everything
> can be consistent and the kernel can provide a FOLL_LONGTERM limit that
> actually provides security.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Lixiao Yang <lixiao.yang@intel.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Just curious: why does the subject say "user::locked_vm"? As opposed to
user->locked_vm? Made me think it's somehow related to rust in kernel or
whatever.

> ---
>  include/linux/sched/user.h | 2 +-
>  kernel/user.c              | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
> index f054d0360a7533..4cc52698e214e2 100644
> --- a/include/linux/sched/user.h
> +++ b/include/linux/sched/user.h
> @@ -25,7 +25,7 @@ struct user_struct {
>  
>  #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
>  	defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
> -	defined(CONFIG_VFIO_PCI_ZDEV_KVM)
> +	defined(CONFIG_VFIO_PCI_ZDEV_KVM) || IS_ENABLED(CONFIG_IOMMUFD)
>  	atomic_long_t locked_vm;
>  #endif
>  #ifdef CONFIG_WATCH_QUEUE
> diff --git a/kernel/user.c b/kernel/user.c
> index e2cf8c22b539a7..d667debeafd609 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -185,6 +185,7 @@ void free_uid(struct user_struct *up)
>  	if (refcount_dec_and_lock_irqsave(&up->__count, &uidhash_lock, &flags))
>  		free_user(up, flags);
>  }
> +EXPORT_SYMBOL_GPL(free_uid);
>  
>  struct user_struct *alloc_uid(kuid_t uid)
>  {
> -- 
> 2.38.1

