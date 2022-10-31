Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF438F76
	for <iommu@lists.linux.dev>; Mon, 31 Oct 2022 22:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667256796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHpC1zf1qV1jmlc1wntYS1OKLTiiLa4Edpg3f0kbUyY=;
	b=BN+EvRRauibQvs3QghlcOMA5pe5ImWI5cEWd7QybddMNxesYL4CaSpebsOAmomxq+/mB7/
	3s2O/DNzba+UPTrsdpDQ5wb+q7FHhFSFz5199z3lEZrtONUodBbfoZRBxqsGkReZ+BDQUp
	LWO6ZFL5YEgD5CzvgLxgVboO1WWxvyE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-TbCDBkNkOd20eCb9NAYx6A-1; Mon, 31 Oct 2022 18:53:14 -0400
X-MC-Unique: TbCDBkNkOd20eCb9NAYx6A-1
Received: by mail-io1-f69.google.com with SMTP id i6-20020a5d88c6000000b006d088a0e518so2479311iol.19
        for <iommu@lists.linux.dev>; Mon, 31 Oct 2022 15:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHpC1zf1qV1jmlc1wntYS1OKLTiiLa4Edpg3f0kbUyY=;
        b=aNVwKJ6rdgO8hyTWz/VeNbn++Lx2zDHb/9k7GlbIG7L6SZM+M3iM4iLVw0/2zW5iK+
         LN9QaQiLkmgFa2Rfo3QaxolE6HbxFKlC9rqKsaZo3rjlIaGererpNDzOYVBWgbUEuq8Q
         CvacVYjWIBtXoKAzlmbTxtwBo2n5XSYLd5Ct7S6DrAjLLjEhrWweX6blWv9NyFzuTdCQ
         FCu9F+1rCpxdwKq/Tlpez0T+Q8ic4NG5uAnTGrVvy+cVSPkorjlYqwJZt+TZ9nHYdg/b
         CJMg9HmB/UDPa8OEFzoGq17Elx2uc7kbIGMvExxhzW6mzhgyB599WXCyhz+9OvwXbX+y
         UMbQ==
X-Gm-Message-State: ACrzQf0/J+G7IjpelWDxWzNRZ35oPJK5OP7Govu4zA4vJ8BRLvlIddWx
	dN8eT4I047baMmzYYM/Wi2U0uo8l0sQalDiQITVd+ylPZPv22zyFXSPvigcpbFpiofAdXY6Euws
	I5yYcfVg4PrcBaiE=
X-Received: by 2002:a05:6e02:180c:b0:2fc:4018:9440 with SMTP id a12-20020a056e02180c00b002fc40189440mr7991818ilv.225.1667256793698;
        Mon, 31 Oct 2022 15:53:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7liCEme2wsc4XzJa+HajVmv1KVpsxVcMQII15KI4qdQbhYdKRKQskOMruD/YfHk1W7Cq0evQ==
X-Received: by 2002:a05:6e02:180c:b0:2fc:4018:9440 with SMTP id a12-20020a056e02180c00b002fc40189440mr7991769ilv.225.1667256793463;
        Mon, 31 Oct 2022 15:53:13 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g15-20020a02850f000000b00372bbd04b75sm3200984jai.87.2022.10.31.15.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:53:12 -0700 (PDT)
Date: Mon, 31 Oct 2022 16:53:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, David Airlie
 <airlied@gmail.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Diana Craciun <diana.craciun@oss.nxp.com>,
 dri-devel@lists.freedesktop.org, Eric Auger <eric.auger@redhat.com>, Eric
 Farman <farman@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 iommu@lists.linux.dev, Jani Nikula <jani.nikula@linux.intel.com>, Jason
 Herne <jjherne@linux.ibm.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Kevin
 Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, Longfang Liu <liulongfang@huawei.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, Peter Oberparleiter
 <oberpar@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Robin Murphy
 <robin.murphy@arm.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Shameer
 Kolothum <shameerali.kolothum.thodi@huawei.com>, Sven Schnelle
 <svens@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>, Zhenyu Wang <zhenyuw@linux.intel.com>,
 Zhi Wang <zhi.a.wang@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 10/10] iommufd: Allow iommufd to supply /dev/vfio/vfio
Message-ID: <20221031165311.0698e1ea.alex.williamson@redhat.com>
In-Reply-To: <Y1wjFNxwPRm7S6yZ@nvidia.com>
References: <0-v1-4991695894d8+211-vfio_iommufd_jgg@nvidia.com>
	<10-v1-4991695894d8+211-vfio_iommufd_jgg@nvidia.com>
	<20221026153133.44dc05c8.alex.williamson@redhat.com>
	<Y1wjFNxwPRm7S6yZ@nvidia.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
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

On Fri, 28 Oct 2022 15:44:36 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Oct 26, 2022 at 03:31:33PM -0600, Alex Williamson wrote:
> > On Tue, 25 Oct 2022 15:50:45 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > If the VFIO container is compiled out, give a kconfig option for iommufd
> > > to provide the miscdev node with the same name and permissions as vfio
> > > uses.
> > > 
> > > The compatibility node supports the same ioctls as VFIO and automatically
> > > enables the VFIO compatible pinned page accounting mode.  
> > 
> > I think I'd like to see some sort of breadcrumb when /dev/vfio/vfio is
> > provided by something other than the vfio container code.  If we intend
> > to include this before P2P is resolved, that breadcrumb   
> 
> I don't belive I can get P2P done soon enough. I plan to do it after
> this is merged. Right now these two series are taking all my time.
> 
> > (dmesg I'm guessing) might also list any known limitations of the
> > compatibility to save time with debugging.  Thanks,  
> 
> Yes, that makes sense.
> 
> Do you want a dmesg at module load time, on every open, or a sysfs
> something? What seems like it would make it into a bug report?

I think dmesg at module load time should probably be ok, every open
seems like harassment and sysfs would require updated support in
various bug reporting tools.  Users are often terrible about reporting
full dmesg in bugs, but they do often filter it for "IOMMU" or "VFIO",
so keep that in mind when crafting the log message.  Thanks,

Alex

