Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D581323E
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 10:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676628706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dvpK31b66LZjOlbG0RKceUyJP6Xe2y/6MQclDivAbW8=;
	b=a162mr4qXZaVlzcIKbKIwdArdg9ZR32w3iHdjSPwfZDn5WRO2s4I3ANQEQHfncjmTX6rSR
	I1WJviZxOYssxqU1zGAE91d0rdPxwnQm6FKap1pUM/cCaNV+3xVK5A/JbDXae5HrRA4Li7
	Kg4lcWA77wlBotkB9hXxBpWQnV+lvI0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-610-3oNh5Pb9OKyNyN1H7YVGdA-1; Fri, 17 Feb 2023 05:11:44 -0500
X-MC-Unique: 3oNh5Pb9OKyNyN1H7YVGdA-1
Received: by mail-wm1-f71.google.com with SMTP id o12-20020a05600c4fcc00b003dd1b5d2a36so184014wmq.1
        for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 02:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvpK31b66LZjOlbG0RKceUyJP6Xe2y/6MQclDivAbW8=;
        b=prw6ENaBl68ptdh/qGgPWiW9BYbW8D+cRYWc33FTemMtuQjMk8T3eD9qvvlcnMzC0Q
         62gQ84rqbM3efGqeG3TtCS8HLpGIiyuVjQvGGGMpvrDOlfmy3+wkjuoq30wcpmbPUx5b
         WmNvhG2jer2pbBYGkU7vcuWuZ9/28BPyI5KKL+HerGxE3GYkCTViUp/6ZqmahkXMRZRJ
         GDJU4G37NjhCY6YZWvSjEJDZcp0MfAFB5H2H0YwF/HXZoMS87ZeSVYerrHmnOhZDuNGe
         krk2/9OWJjfA6sFUx3spCmg7oxYupyleMU5QgX/IDL43aplDrTDYWscgCv2E0zfsQWvQ
         qkfg==
X-Gm-Message-State: AO0yUKUj3gMm9WgHNdFignho9dnXod13R/vUpDudcy0xqQCdBYxyfVYE
	Sy9Rl52kjfjh6Lgq2npQdByXljNXpuQ/VhCWIQPrEiMlQK/CIgtiODt2dYxk2nUoMSN6JeQmuDE
	P/WqfW0G42HRJdzk=
X-Received: by 2002:a05:600c:4d21:b0:3d9:f769:2115 with SMTP id u33-20020a05600c4d2100b003d9f7692115mr188609wmp.26.1676628703387;
        Fri, 17 Feb 2023 02:11:43 -0800 (PST)
X-Google-Smtp-Source: AK7set+Kcg4izxtCX4bYTTRixMiAEVt9Z6ixnz/KbWXmJ3fdzzSg3LAlSGK6fov0vMkMCzQhoGEOjA==
X-Received: by 2002:a05:600c:4d21:b0:3d9:f769:2115 with SMTP id u33-20020a05600c4d2100b003d9f7692115mr188590wmp.26.1676628703126;
        Fri, 17 Feb 2023 02:11:43 -0800 (PST)
Received: from redhat.com ([2.52.5.34])
        by smtp.gmail.com with ESMTPSA id az5-20020a05600c600500b003e20a6fd604sm4644634wmb.4.2023.02.17.02.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:11:42 -0800 (PST)
Date: Fri, 17 Feb 2023 05:11:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nanyong Sun <sunnanyong@huawei.com>,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, wangrong68@huawei.com
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20230217051038-mutt-send-email-mst@kernel.org>
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com>
 <CACGkMEtehykvqNUnfCi0VmHR1xpmhj4sSWdYW1-0oATY=0YhXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtehykvqNUnfCi0VmHR1xpmhj4sSWdYW1-0oATY=0YhXw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 17, 2023 at 01:35:59PM +0800, Jason Wang wrote:
> On Fri, Feb 17, 2023 at 8:15 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > > From: Rong Wang <wangrong68@huawei.com>
> > >
> > > Once enable iommu domain for one device, the MSI
> > > translation tables have to be there for software-managed MSI.
> > > Otherwise, platform with software-managed MSI without an
> > > irq bypass function, can not get a correct memory write event
> > > from pcie, will not get irqs.
> > > The solution is to obtain the MSI phy base address from
> > > iommu reserved region, and set it to iommu MSI cookie,
> > > then translation tables will be created while request irq.
> >
> > Probably not what anyone wants to hear, but I would prefer we not add
> > more uses of this stuff. It looks like we have to get rid of
> > iommu_get_msi_cookie() :\
> >
> > I'd like it if vdpa could move to iommufd not keep copying stuff from
> > it..
> 
> Yes, but we probably need a patch for -stable.

Hmm do we? this looks like it's enabling new platforms is not a bugfix...

> >
> > Also the iommu_group_has_isolated_msi() check is missing on the vdpa
> > path, and it is missing the iommu ownership mechanism.
> 
> Ok.
> 
> >
> > Also which in-tree VDPA driver that uses the iommu runs on ARM? Please
> 
> ifcvf and vp_vpda are two drivers that use platform IOMMU.
> 
> Thanks
> 
> > don't propose core changes for unmerged drivers. :(
> >
> > Jason
> >

