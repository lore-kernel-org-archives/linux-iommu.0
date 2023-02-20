Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A987E8
	for <iommu@lists.linux.dev>; Mon, 20 Feb 2023 02:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676860651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4mF9eRLWUighxaWu/WlNqJCc0pM0J+zyyIk2SE2gxU=;
	b=fPygkbLALlk+6ukzBEvSJLsPhuqYnNPH0N7bl7BG0m0F3E6y+Pfob4gWdaTJz9lCvJobxG
	fLG5thQGVgd5lqzmTEaK+4VJqNjDNVV5AqTmIVNbM6TxWm8X8UXf6x9VIgJMcbcNqKkxoW
	PWh5hg2L2e56X4rdY32ZSAVN2Bs/ppo=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-9-bGf9YIBoOgKu4VTPq156bw-1; Sun, 19 Feb 2023 21:37:30 -0500
X-MC-Unique: bGf9YIBoOgKu4VTPq156bw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-171d9537ec5so562356fac.8
        for <iommu@lists.linux.dev>; Sun, 19 Feb 2023 18:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4mF9eRLWUighxaWu/WlNqJCc0pM0J+zyyIk2SE2gxU=;
        b=h+YQnlMgh76ZP2SThocHsM3PZ5AB0ISwLB7qC/ducz8BvKZ2vG298KIgGMMifG4rT+
         gn6B9kgzqJwhbA4L6eSUyeX3UTy9dKwfI/rXKWY3kd7IQCKaPL+XXyuWrzvDkppNyh6s
         p9Eafr0FxVO03Qw/G2uHu0VxHI5dP8QRD5EevER71Cph1G03zblXBBcVMxtskdTbCi+u
         bCEn6xjzs7kzSvtapJkdne0KH6yaYxhcrRnPIo5+NnkikhOmcWskKU2gD/5SccWXi5XR
         /QWHJ0tGUN8kDIQph6Mvut9zitqw6Mk+tnUv4m2lmbRc5d58y1wioN/4iNr8XIu2fdYo
         gWpg==
X-Gm-Message-State: AO0yUKVs8zdbWeJcsXAPscXIVim0KsRXgz+8cngvZNJVG0Os21N86b+8
	A63ITmsrSgGSoK/xxwl33mJK2Zl4aAQYYmuWj99MNHmTj5rjLZ2UVOuwxOv8mcwlOPT1g9GE80A
	bZKQB2g7IR9Adm6XFavMdcoYix19wZBQ=
X-Received: by 2002:a05:6870:e309:b0:16a:cfba:d187 with SMTP id z9-20020a056870e30900b0016acfbad187mr57937oad.2.1676860649424;
        Sun, 19 Feb 2023 18:37:29 -0800 (PST)
X-Google-Smtp-Source: AK7set8SJitLQ9LUE3u1syC+o7Uv38TErayt/RAfp5Ui0lrmlYgjeBjytjXtpn+4L/G0i6tLLMj766NjBhCbz614fY0=
X-Received: by 2002:a05:6870:e309:b0:16a:cfba:d187 with SMTP id
 z9-20020a056870e30900b0016acfbad187mr57932oad.2.1676860649055; Sun, 19 Feb
 2023 18:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com> <20230217051158-mutt-send-email-mst@kernel.org> <Y+92c9us3HVjO2Zq@nvidia.com>
In-Reply-To: <Y+92c9us3HVjO2Zq@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Feb 2023 10:37:18 +0800
Message-ID: <CACGkMEsVBhxtpUFs7TrQzAecO8kK_NR+b1EvD2H7MjJ+2aEKJw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nanyong Sun <sunnanyong@huawei.com>, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	wangrong68@huawei.com, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 17, 2023 at 8:43 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Feb 17, 2023 at 05:12:29AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Feb 16, 2023 at 08:14:50PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > > > From: Rong Wang <wangrong68@huawei.com>
> > > >
> > > > Once enable iommu domain for one device, the MSI
> > > > translation tables have to be there for software-managed MSI.
> > > > Otherwise, platform with software-managed MSI without an
> > > > irq bypass function, can not get a correct memory write event
> > > > from pcie, will not get irqs.
> > > > The solution is to obtain the MSI phy base address from
> > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > then translation tables will be created while request irq.
> > >
> > > Probably not what anyone wants to hear, but I would prefer we not add
> > > more uses of this stuff. It looks like we have to get rid of
> > > iommu_get_msi_cookie() :\
> > >
> > > I'd like it if vdpa could move to iommufd not keep copying stuff from
> > > it..
> >
> > Absolutely but when is that happening?
>
> Don't know, I think it has to come from the VDPA maintainers, Nicolin
> made some drafts but wasn't able to get it beyond that.

Cindy (cced) will carry on the work.

Thanks

>
> Please have people who need more iommu platform enablement to pick it
> up instead of merging hacks like this..
>
> We are very close to having nested translation on ARM so anyone who is
> serious about VDPA on ARM is going to need iommufd anyhow.
>
> Jason
>

