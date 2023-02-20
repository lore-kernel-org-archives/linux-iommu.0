Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECDE63DB
	for <iommu@lists.linux.dev>; Mon, 20 Feb 2023 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676906670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXbeg/8n4ojsPY6rFquIIVMt+7vRYFxzuQ9z7o+cgT8=;
	b=AjbXDjPHVKBbHJsXTgWkgZX8qJ32lC7L0co1Nue0JK/0XlSYAuk5R4Sz8TOiqap4dY4/ot
	elLAJH/mOc7NLy/oJWFSjV7uGl7FouDLtymj0H6IHevlmwN9XJp3sXWjQMMA0/8+y95K1+
	55dNdAlqVjayKOv50onwyqOTgRbgyTE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-208-ikD8o5M1NVOEDF2vtck6Ag-1; Mon, 20 Feb 2023 10:24:28 -0500
X-MC-Unique: ikD8o5M1NVOEDF2vtck6Ag-1
Received: by mail-wm1-f72.google.com with SMTP id t1-20020a7bc3c1000000b003dfe223de49so747450wmj.5
        for <iommu@lists.linux.dev>; Mon, 20 Feb 2023 07:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXbeg/8n4ojsPY6rFquIIVMt+7vRYFxzuQ9z7o+cgT8=;
        b=Y8YzWud49P9LBUabN+GOEBzmTvHajEB0eKC1aITutk/EA2VTwLSUCxctmmsyDgEcep
         vYwIH5PqJOP/YgjHRKeNAxTAcWA/z+ADBuzs1mPVEHH3InRc9RwF93BvnAkjokQcuZQ3
         9MWCdXGl6sM+9MHvn+xhXPpRxYMwJHmoMDnqOORxLWNWKjyQhZ13LJCoafeb/qnTDuoz
         037iayKlpn++SIIzMGSEXPp75VhzjpdeuiKQK05PDIFMGiFfkqs6usfMdjaPSKwdXpFI
         VV9VnT/VySonatDsGOaDqNTV75R1oRlxzOW/v2HmZ9TbYbXOX8on6SC6dDycbk2m6oRb
         3f9Q==
X-Gm-Message-State: AO0yUKXHPZSVjZ9WemqHMxhaH6cogX4cs17q4QrfmUNRZfxFPxCwT2FQ
	/bx6tiqotHZwumWi5BWhBNhhjZfkxBvVbTOXW8dExnA3ATHWO+ZdziPO3VbPD4+MDEP0TaDmQJm
	2aovJ7KuHf85gwCM=
X-Received: by 2002:a05:600c:4591:b0:3e0:481:c897 with SMTP id r17-20020a05600c459100b003e00481c897mr1269885wmo.37.1676906667352;
        Mon, 20 Feb 2023 07:24:27 -0800 (PST)
X-Google-Smtp-Source: AK7set9tFwhAVYPdJYx0EhG2sVxAmzmAIlOl5vAvFJ3YD45gjzKLDP25kfvtfbMuXNPd38LD2ll++g==
X-Received: by 2002:a05:600c:4591:b0:3e0:481:c897 with SMTP id r17-20020a05600c459100b003e00481c897mr1269863wmo.37.1676906667016;
        Mon, 20 Feb 2023 07:24:27 -0800 (PST)
Received: from redhat.com ([2.52.5.34])
        by smtp.gmail.com with ESMTPSA id p8-20020a1c7408000000b003b47b80cec3sm541587wmc.42.2023.02.20.07.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 07:24:26 -0800 (PST)
Date: Mon, 20 Feb 2023 10:24:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nanyong Sun <sunnanyong@huawei.com>,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, wangrong68@huawei.com
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20230220102216-mutt-send-email-mst@kernel.org>
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com>
 <CACGkMEtehykvqNUnfCi0VmHR1xpmhj4sSWdYW1-0oATY=0YhXw@mail.gmail.com>
 <20230217051038-mutt-send-email-mst@kernel.org>
 <CACGkMEuDG1NUs0=ry1=Mphfd+TrqAvVS0yeu9hcni2VrPkB8tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuDG1NUs0=ry1=Mphfd+TrqAvVS0yeu9hcni2VrPkB8tQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 20, 2023 at 10:36:27AM +0800, Jason Wang wrote:
> On Fri, Feb 17, 2023 at 6:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Feb 17, 2023 at 01:35:59PM +0800, Jason Wang wrote:
> > > On Fri, Feb 17, 2023 at 8:15 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > > > > From: Rong Wang <wangrong68@huawei.com>
> > > > >
> > > > > Once enable iommu domain for one device, the MSI
> > > > > translation tables have to be there for software-managed MSI.
> > > > > Otherwise, platform with software-managed MSI without an
> > > > > irq bypass function, can not get a correct memory write event
> > > > > from pcie, will not get irqs.
> > > > > The solution is to obtain the MSI phy base address from
> > > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > > then translation tables will be created while request irq.
> > > >
> > > > Probably not what anyone wants to hear, but I would prefer we not add
> > > > more uses of this stuff. It looks like we have to get rid of
> > > > iommu_get_msi_cookie() :\
> > > >
> > > > I'd like it if vdpa could move to iommufd not keep copying stuff from
> > > > it..
> > >
> > > Yes, but we probably need a patch for -stable.
> >
> > Hmm do we? this looks like it's enabling new platforms is not a bugfix...
> 
> I think we haven't limited vDPA to any specific arch in the past?
> 
> Thanks

No, but it still fails gracefully right?

Anyway, this will need iommu maintainer's ack.  We'll see.


> >
> > > >
> > > > Also the iommu_group_has_isolated_msi() check is missing on the vdpa
> > > > path, and it is missing the iommu ownership mechanism.
> > >
> > > Ok.
> > >
> > > >
> > > > Also which in-tree VDPA driver that uses the iommu runs on ARM? Please
> > >
> > > ifcvf and vp_vpda are two drivers that use platform IOMMU.
> > >
> > > Thanks
> > >
> > > > don't propose core changes for unmerged drivers. :(
> > > >
> > > > Jason
> > > >
> >

