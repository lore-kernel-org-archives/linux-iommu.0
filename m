Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5FD63E
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 05:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676612172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8y4UETkQqs5POhMp8MHo+VmSRaMVJi1lvssc8jHWBA=;
	b=LtZih23huMqAw4NgIYsOc/MYAYSkNOODoUd+S+N9x5tZhXOs5yc21cxzi5JjICDfwZ1hKm
	ajk1f2PskoVT+M0hBcomvC2zgi1YsWpjvahQfvM4ol21Gjxsw13cRKuvqoA8hiVD2kIGSc
	L5cgYRktmQkHzCOJGDddGiwnxN50nBM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-173-Exprm_4jMsSZ7q8KirIqsw-1; Fri, 17 Feb 2023 00:36:11 -0500
X-MC-Unique: Exprm_4jMsSZ7q8KirIqsw-1
Received: by mail-oi1-f199.google.com with SMTP id l17-20020a544511000000b0037dc3a143bbso1394028oil.9
        for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 21:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8y4UETkQqs5POhMp8MHo+VmSRaMVJi1lvssc8jHWBA=;
        b=EwZPbhGveMZH7C9BI0vIJKq2YYCuoCWLqTjB8zn05m35WFsAYAPS5m53WGiFhTfxdn
         +ZkysYlR82y5rqnWfRy2LBcASh6odNOJYVZi9Sr4TciyGvxD2zoWtK5GR56fFfu1gFKo
         BgB3lli8l/ktk5KOhX7vylUmPl5AguixvmIIWsLUvSURpDBaBtqkeMe3mmYUpQY0DdIC
         JC8fFFo6zNke7zEe028kv7Y1p4qaItB84qFjSX6I17CvlvOIjXRRxSpXlH8Vw+LEITGi
         N/LGQ7Coduh2N+VeXqvPP+TiVExjSbYCKRHlrOsEcy6bi2CKXs/BZrJ/vu7kCbpGbvJf
         Zwjw==
X-Gm-Message-State: AO0yUKWwbEL1Bu21znmB85briURld97jjVNU2tZDxagx53DLHt7PYpV7
	cvr8UalxZWdsobuGzzHj+0m8geKkdkbg0i+hRnyyDSenF+owE35zpajU+mH2BepFcXVVAnvNMy5
	1TqwimoMm57JLd94n9vw8ozJ6zRve7Uw=
X-Received: by 2002:a05:6808:3186:b0:37d:5d77:e444 with SMTP id cd6-20020a056808318600b0037d5d77e444mr296395oib.35.1676612170494;
        Thu, 16 Feb 2023 21:36:10 -0800 (PST)
X-Google-Smtp-Source: AK7set+hY95HRDtXDD+GXnz1YrR2uwZRZowpsAyCm1bMt4U0npjM2XW+YfzeYKDUlmV5UD794AQCKMHVcQs7RZ9kgLs=
X-Received: by 2002:a05:6808:3186:b0:37d:5d77:e444 with SMTP id
 cd6-20020a056808318600b0037d5d77e444mr296388oib.35.1676612170318; Thu, 16 Feb
 2023 21:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230207120843.1580403-1-sunnanyong@huawei.com> <Y+7G+tiBCjKYnxcZ@nvidia.com>
In-Reply-To: <Y+7G+tiBCjKYnxcZ@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Feb 2023 13:35:59 +0800
Message-ID: <CACGkMEtehykvqNUnfCi0VmHR1xpmhj4sSWdYW1-0oATY=0YhXw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, mst@redhat.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	wangrong68@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 17, 2023 at 8:15 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > From: Rong Wang <wangrong68@huawei.com>
> >
> > Once enable iommu domain for one device, the MSI
> > translation tables have to be there for software-managed MSI.
> > Otherwise, platform with software-managed MSI without an
> > irq bypass function, can not get a correct memory write event
> > from pcie, will not get irqs.
> > The solution is to obtain the MSI phy base address from
> > iommu reserved region, and set it to iommu MSI cookie,
> > then translation tables will be created while request irq.
>
> Probably not what anyone wants to hear, but I would prefer we not add
> more uses of this stuff. It looks like we have to get rid of
> iommu_get_msi_cookie() :\
>
> I'd like it if vdpa could move to iommufd not keep copying stuff from
> it..

Yes, but we probably need a patch for -stable.

>
> Also the iommu_group_has_isolated_msi() check is missing on the vdpa
> path, and it is missing the iommu ownership mechanism.

Ok.

>
> Also which in-tree VDPA driver that uses the iommu runs on ARM? Please

ifcvf and vp_vpda are two drivers that use platform IOMMU.

Thanks

> don't propose core changes for unmerged drivers. :(
>
> Jason
>

