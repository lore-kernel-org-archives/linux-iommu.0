Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CEABA28
	for <iommu@lists.linux.dev>; Tue, 29 Nov 2022 21:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669756233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k698xTv8b1qqm1dRRZgevYpv3znOLNXUsBrj1mzERPk=;
	b=UPsZWlbOEphvCE/G6isATxvVzsBa/H0neWZ57mzNqImre2LxQ0bDY247x0BiurRcb1tsqG
	1I7zL8rWh/oFS9PBTuFvqXfetMdIHN6OZEBFTl91I5ugxTaC07/8vVkr0Bjq+doz4tElsV
	RgDdYDzXMu5JVPbENTl7kiMlTMOc7Wc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-205-VAxYWZc-OkO8JIvXj7HcsQ-1; Tue, 29 Nov 2022 16:10:32 -0500
X-MC-Unique: VAxYWZc-OkO8JIvXj7HcsQ-1
Received: by mail-wm1-f71.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so10780815wme.7
        for <iommu@lists.linux.dev>; Tue, 29 Nov 2022 13:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k698xTv8b1qqm1dRRZgevYpv3znOLNXUsBrj1mzERPk=;
        b=7sdFbkbA7ToJ3lx8jo7UwZs6mcpOQOgKTGUGkpXvFSDXkczdd6474wIYb3p6Z2IyKR
         fdAaoWY/HcC2U25h9DhsOeBuelYMh/4jsQEWRktmtBBYN8RwXG8km0hduNPk+vbpXUz2
         ka8AgwQETcAt2VWa2BmUTP8/kj8GMA5xVwfmc6IlY3rqs3fCiAUUptpWfABMYYrwfqdl
         pmTjg2PfAvzM/57JUSLCL4G3/iMEoyikEFvKhVxnJF/o5533QoVtoSkEwG4uSzxPaqfE
         /M0XxZxn6KeyVQ3gTjjDH7C2dAtxC9QmHJPPmUBe4s/l+vJEPqL3OBYmsRcPMBsT7lgw
         tHaA==
X-Gm-Message-State: ANoB5pluRNGIQT90ngjMpvxMdsiEHSZvSTeoV6h7MGsFPI+fDcrtf9ji
	YZswdwSwdOrkxwsiQrb9i9NRGy4FiqfR6vMi4y0Hu6p3tIyeDF7B9fmRzZz+sgeWGbf/q5xIyCb
	TNvRX3shS+jPbA1w=
X-Received: by 2002:a5d:46d0:0:b0:242:91c:a12f with SMTP id g16-20020a5d46d0000000b00242091ca12fmr12901693wrs.524.1669756231200;
        Tue, 29 Nov 2022 13:10:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6+iPW2bfSUBCiA/vEABdm4r2E99sY8GFRM5gUzIgdbDggVKb5d5xIs/N7xro3zHpnqh3uj+Q==
X-Received: by 2002:a5d:46d0:0:b0:242:91c:a12f with SMTP id g16-20020a5d46d0000000b00242091ca12fmr12901684wrs.524.1669756230981;
        Tue, 29 Nov 2022 13:10:30 -0800 (PST)
Received: from redhat.com ([2.52.149.178])
        by smtp.gmail.com with ESMTPSA id i28-20020a05600c4b1c00b003cfd4e6400csm3259683wmp.19.2022.11.29.13.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 13:10:30 -0800 (PST)
Date: Tue, 29 Nov 2022 16:10:25 -0500
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
Message-ID: <20221129160444-mutt-send-email-mst@kernel.org>
References: <0-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com>
 <7-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com>
 <20221129154048-mutt-send-email-mst@kernel.org>
 <Y4ZwEJotH0U0Qzt7@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Y4ZwEJotH0U0Qzt7@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 29, 2022 at 04:48:16PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 29, 2022 at 03:42:23PM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 29, 2022 at 04:29:30PM -0400, Jason Gunthorpe wrote:
> > > Following the pattern of io_uring, perf, skb, and bpf, iommfd will use
> > > user->locked_vm for accounting pinned pages. Ensure the value is included
> > > in the struct and export free_uid() as iommufd is modular.
> > > 
> > > user->locked_vm is the good accounting to use for ulimit because it is
> > > per-user, and the security sandboxing of locked pages is not supposed to
> > > be per-process. Other places (vfio, vdpa and infiniband) have used
> > > mm->pinned_vm and/or mm->locked_vm for accounting pinned pages, but this
> > > is only per-process and inconsistent with the new FOLL_LONGTERM users in
> > > the kernel.
> > > 
> > > Concurrent work is underway to try to put this in a cgroup, so everything
> > > can be consistent and the kernel can provide a FOLL_LONGTERM limit that
> > > actually provides security.
> > > 
> > > Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Tested-by: Yi Liu <yi.l.liu@intel.com>
> > > Tested-by: Lixiao Yang <lixiao.yang@intel.com>
> > > Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Just curious: why does the subject say "user::locked_vm"? As opposed to
> > user->locked_vm? Made me think it's somehow related to rust in kernel or
> > whatever.
> 
> :: is the C++ way to say "member of a type", I suppose it is a typo
> and should be user_struct::locked_vm
> 
> The use of -> otherwise was to have some clarity about mm vs user
> structs.
> 
> Jason

I note that commit log says user->locked_vm and that's clear enough
IMHO, I'd leave C++ alone - IIRC yes you can write ptr->type::field but
no one does so it's not idiomatic, :: is more commonly used with static
members there. So this confuses more than it clarifies. But whatever,
hardly a blocker. Feel free to ignore.

-- 
MST

