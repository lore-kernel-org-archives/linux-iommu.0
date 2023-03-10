Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1D2103
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678437711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgZ9DWKppXLbZXIYqFbF8nghQRnE3BR/P3wfdlRGiz4=;
	b=TdAvFcxAne2/p2ycYBjeP3t7MuCDxujcUnqo7G16bXj3ek5wHeAVAqCRPrDFIKMng0eaTP
	achirFu4sONGVswAz3aOEw8U78CiYeTjP13WjAx9P6YmTwyo6eMOE+A+jdJvqCaPkokAtW
	FNmsxTu+pEcCrjuI1xEXz3W3sk8XCAo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-I5E-r8dtOBSaS1norx26UA-1; Fri, 10 Mar 2023 03:41:42 -0500
X-MC-Unique: I5E-r8dtOBSaS1norx26UA-1
Received: by mail-wm1-f69.google.com with SMTP id e17-20020a05600c219100b003e21fa60ec1so1724512wme.2
        for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 00:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgZ9DWKppXLbZXIYqFbF8nghQRnE3BR/P3wfdlRGiz4=;
        b=bMhCszUfLs1HlAQxUqZUxNdymYqRse+qS4AW2b1+VJfb6HI4/wBgJka56lFBfgh2AG
         0IMLkC5llq0QwQ7PjydX4rr2Sqct4dguwyKpB0G3dSFdyYCNkkZnEy3ckPK7KsxdGu3E
         e3pj4Q6EQR5nxaxoFCB6pxG/r8qbhNWxmFM8ZiJXTeVVaUHMFJ9hPXsKdVpfSZFm+11t
         asgVvM4yd6BkwVNa+zuk0UN990KyiGhCnfqu91QB7QP8YlrPXCEabGseyQRaaP8rmUcQ
         YCve9Gr/Tr9GiTRoE5Llhx8SwuMH9UByaCcdzW//0zK3/0IHEmyTEMFyWORxBFjO39dJ
         w6Mg==
X-Gm-Message-State: AO0yUKVOAf5rO+CfLO7lxChvxIYWNAXbktTZ7TRFEDlC107DixeQS6Bz
	/Xd2VqHsNc47xbZ9ltWsp0C3HKIuMeEkVx1xeJNWTFqztVriDevyCyQirX8RaT+y4ZNNJt3p/TV
	QaVBf9EbyH9IVlMg=
X-Received: by 2002:adf:f006:0:b0:2c7:1a96:63f2 with SMTP id j6-20020adff006000000b002c71a9663f2mr15408170wro.3.1678437701510;
        Fri, 10 Mar 2023 00:41:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/0zNz/ZZRX8XUCR+0UQZYSDN/cLZcU6NuWf8z1hU8kWNXs0SEm1rd0WtH4SBmkrKRw2UpQgw==
X-Received: by 2002:adf:f006:0:b0:2c7:1a96:63f2 with SMTP id j6-20020adff006000000b002c71a9663f2mr15408153wro.3.1678437701194;
        Fri, 10 Mar 2023 00:41:41 -0800 (PST)
Received: from redhat.com ([2.52.9.88])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003eb0d6f48f3sm2337036wmo.27.2023.03.10.00.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:41:40 -0800 (PST)
Date: Fri, 10 Mar 2023 03:41:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nanyong Sun <sunnanyong@huawei.com>,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, wangrong68@huawei.com,
	Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20230310034101-mutt-send-email-mst@kernel.org>
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com>
 <20230217051158-mutt-send-email-mst@kernel.org>
 <Y+92c9us3HVjO2Zq@nvidia.com>
 <CACGkMEsVBhxtpUFs7TrQzAecO8kK_NR+b1EvD2H7MjJ+2aEKJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsVBhxtpUFs7TrQzAecO8kK_NR+b1EvD2H7MjJ+2aEKJw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 20, 2023 at 10:37:18AM +0800, Jason Wang wrote:
> On Fri, Feb 17, 2023 at 8:43 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, Feb 17, 2023 at 05:12:29AM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Feb 16, 2023 at 08:14:50PM -0400, Jason Gunthorpe wrote:
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
> > > Absolutely but when is that happening?
> >
> > Don't know, I think it has to come from the VDPA maintainers, Nicolin
> > made some drafts but wasn't able to get it beyond that.
> 
> Cindy (cced) will carry on the work.
> 
> Thanks

Hmm didn't see anything yet. Nanyong Sun maybe you can take a look?

> >
> > Please have people who need more iommu platform enablement to pick it
> > up instead of merging hacks like this..
> >
> > We are very close to having nested translation on ARM so anyone who is
> > serious about VDPA on ARM is going to need iommufd anyhow.
> >
> > Jason
> >

