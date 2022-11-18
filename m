Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1112C28E3
	for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 09:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668762572;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeXTZcuI1CLep2o2KomhSyxmx0lROJCn0LGc6rXRQUg=;
	b=a9ggwPHCMc6NIaabB4Okt2j+I6+Wx6Mk1vrRQMELI6IjtLRYRdDj+yKKYKF9JbtFXDqhTt
	4vnEtnDv25Rp/8nG8h1C8ki3Q4Cd3d9hCSl2D8pPl95gqpGMnTxmIVY69HZHnsS/96D0Fn
	Nfnsq7oWK3lRo/5vpgoGCApqEF9HEPg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-68-NK2_bgcXNXatuJ1xImBR1w-1; Fri, 18 Nov 2022 04:09:30 -0500
X-MC-Unique: NK2_bgcXNXatuJ1xImBR1w-1
Received: by mail-wm1-f72.google.com with SMTP id i133-20020a1c3b8b000000b003cffc0a69afso1783076wma.9
        for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 01:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeXTZcuI1CLep2o2KomhSyxmx0lROJCn0LGc6rXRQUg=;
        b=YH/oaaXODow4czJyYBwF+tvmfTu4GqTPPf510xMKn+ppTPc7cIB6uX/aFa7Ru7+7Xk
         qSeHvvuJBkvGe887EKnCi8HaH8Kg4rFb7WjMORMG12ESGM0Mj+8cpX+9DMKmvUr/J6x8
         swLJhib9+W0TjOXZ/vQnPJHNtE5fMN0yoYqSriktuMUqS8DcxCgRREKuXu971Ljltunf
         MBrChgqPvEU018U2oVRThsEZGzH+nCO26+EfuZqZafQzKsAPchtBRM8gHywr70OdltMU
         AcA+y1XXYJDAh/SUpEoJwnLRxO4Yo88MwcZCWaIaxRLYsCfsEJigY1aSF9gSiUNgZVPn
         nuig==
X-Gm-Message-State: ANoB5pmeRjxEFLZEu2B1x6KDwG0aSZkNf1Y+wrYgszSlcfl4fZmX1CTK
	m6o/iA5TazVgjEbmbKKyumlgbLxqxHVGnUq/BhNaM0CkTLnQA0uqC4BK03SyH1ETw5QNZnete/b
	qJw8QS0rRa5Cl/YU=
X-Received: by 2002:a05:600c:1e1a:b0:3cf:7959:d8be with SMTP id ay26-20020a05600c1e1a00b003cf7959d8bemr4452089wmb.85.1668762569744;
        Fri, 18 Nov 2022 01:09:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7jsIC1kyZP02uLsDpFgwzo/jh+9BTiREaq3zKB0f5w8O4mQu6CokrtkacAoWZxpUfLgP9J7g==
X-Received: by 2002:a05:600c:1e1a:b0:3cf:7959:d8be with SMTP id ay26-20020a05600c1e1a00b003cf7959d8bemr4452051wmb.85.1668762569479;
        Fri, 18 Nov 2022 01:09:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d48c6000000b00241a8a5bc11sm2955443wrs.80.2022.11.18.01.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 01:09:28 -0800 (PST)
Message-ID: <569b4eeb-792a-9ad6-d52e-555f987bc7f7@redhat.com>
Date: Fri, 18 Nov 2022 10:09:26 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 07/19] kernel/user: Allow user::locked_vm to be usable
 for iommufd
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
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
 <cohuck@redhat.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eric Farman <farman@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>, Joao Martins
 <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
 Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <7-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/16/22 22:00, Jason Gunthorpe wrote:
> Following the pattern of io_uring, perf, skb, and bpf iommfd will use
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
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
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

