Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125163B3
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 13:06:51 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1bda9207132so11789275ad.0
        for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691759210; x=1692364010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvTL2oVJ0eiAc078W1yQ7hrHg2PkiBD3S5QRuBrCIeU=;
        b=UaDL/fB8QEuFEO1d3w9bW3cFmCqaFmiZOBzXudSWb6PUfsqsDQ6JB6Q1gleEHshwoS
         N76HHcVqLellvb4agRQkzYHsh/4rTMxiSwB2qPNrAfVqb4W9Zy7IiAkNqB9Jf9AHKpmA
         NdTIMNd2uCIFKlYPbEwveqk3Op9+MY/L0I2v8iCgwf7T+8UrXxmta8t2+ygYiUUZ4Hy/
         fEolecBVu0Zsd21wbiBrr3LdgJLb4p6k9P81f+u02DcvEbgEoRN3OVAfk4mFaJ7y93si
         TFdtmATOCbJoOtY18c5cb5KXEO5wcfhfJSS3T+iJLjgwe/X8sfqI9SF0VGtIBelcwtms
         OsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759210; x=1692364010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvTL2oVJ0eiAc078W1yQ7hrHg2PkiBD3S5QRuBrCIeU=;
        b=ByKLs8zzNA1bNZml2f9s72qUJg17UXu5Z+S3kUv/bq+/XMeeX4mOvH6Wax9WQdXUWi
         zSkJoxo1eOZq39dwH188HDKgDyBI8IPzohKuvPAMlcuZ5SPWyQB9LAKOEvqEOwL5loZW
         EYMdgxWQXaEY0WuEsnv1XyfdtWV91JeQCSJ4faRPnZ+X59WfrkNk3gCcqU8U1skMjGG3
         sDxqFmU06r+/uOi95dir9aOZjdciDGMHKPRDsvK+iKbimdZxP1ENEKPqxSLayIDfwWfy
         QzuKxtUIWtwVfeZqhauuS6v+AvpQxsapRDB2Y/oUhk/BQUZ7LaBFyJtjoVI/04sseEkQ
         ikmA==
X-Gm-Message-State: AOJu0Yzb0v+7K/IyYaUxs6vs+I1lthXOdV/+smkfEJFZ/nW7pnF2mLCX
	WeNINfdmJ81YSe4p1uRvTAgPZA==
X-Google-Smtp-Source: AGHT+IHajFS15kRqRTBhJy5rDfN5rnwogKEGXx6eTBpjTdeCtYbrW22ar55MnMLWpMdKhbI11faCFw==
X-Received: by 2002:a17:902:d2cf:b0:1b8:b285:ec96 with SMTP id n15-20020a170902d2cf00b001b8b285ec96mr2016038plc.23.1691759210410;
        Fri, 11 Aug 2023 06:06:50 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001bb9b5e86b7sm3842460plg.91.2023.08.11.06.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:06:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qURqp-005Qt2-Rh;
	Fri, 11 Aug 2023 10:06:47 -0300
Date: Fri, 11 Aug 2023 10:06:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 01/11] iommu/amd: Rename helper function
 rlookup_amd_iommu()
Message-ID: <ZNYyZzo66vu8VvTh@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-2-vasant.hegde@amd.com>
 <ZNJfLQTJhOgorIHB@ziepe.ca>
 <bcd2749c-d4de-fa8c-c865-ac9ed184ea17@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcd2749c-d4de-fa8c-c865-ac9ed184ea17@amd.com>

On Thu, Aug 10, 2023 at 04:06:52PM -0700, Suthikulpanit, Suravee wrote:
> 
> 
> On 8/8/2023 8:28 AM, Jason Gunthorpe wrote:
> > On Tue, Aug 08, 2023 at 10:02:22AM +0000, Vasant Hegde wrote:
> > > From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > > 
> > > Rename and make it available to other code.
> > > 
> > > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > > Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> > > ---
> > >   drivers/iommu/amd/amd_iommu.h |  1 +
> > >   drivers/iommu/amd/iommu.c     | 30 +++++++++++++++---------------
> > >   2 files changed, 16 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> > > index 56996dc2868d..1471ab2dddd1 100644
> > > --- a/drivers/iommu/amd/amd_iommu.h
> > > +++ b/drivers/iommu/amd/amd_iommu.h
> > > @@ -24,6 +24,7 @@ int amd_iommu_init_devices(void);
> > >   void amd_iommu_uninit_devices(void);
> > >   void amd_iommu_init_notifier(void);
> > >   void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
> > > +struct amd_iommu *amd_iommu_rlookup_iommu(struct device *dev);
> > >   #ifdef CONFIG_AMD_IOMMU_DEBUGFS
> > >   void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
> > > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > > index 26e509ffe77a..77b913211c35 100644
> > > --- a/drivers/iommu/amd/iommu.c
> > > +++ b/drivers/iommu/amd/iommu.c
> > > @@ -164,7 +164,7 @@ static struct amd_iommu *__rlookup_amd_iommu(u16 seg, u16 devid)
> > >   	return NULL;
> > >   }
> > > -static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
> > > +struct amd_iommu *amd_iommu_rlookup_iommu(struct device *dev)
> > >   {
> > 
> > Er, wah? This is a really confused function. It should just be:
> > 
> > static inline struct amd_iommu *amd_device_to_iommu(struct device *dev)
> > {
> > 	return container_of(dev->iommu->iommu_dev, struct amd_iommu, iommu);
> > }
> > 
> > Right? At least for many of the call sites.
> > 
> > The core code maintains the association of the iommu_device with each
> > probe'd device automatically. The drivers don't need tables and
> > searching.
> 
> The rlookup table is setup from the information in the IVRS table, which
> contains list of devices belong to an IOMMU instance. This information is
> used to for setting dev->iommu during probing (See
> drivers/iommu/amd/iommu.c: amd_iommu_probe_device()).

Yes, I saw that..

> Subsequently, it should be able to use the amd_device_to_iommu() you
> provided as long as the device has not been released.
> 
> So, we can add the helper function above, and make sure to check that
> dev->iommu is not NULL before calling the container_of().

There should not be a null check

Such a function should only be called from one of the iommu ops and
the core code guarentees it will not invoke the op without an attached
iommu_driver

Provide a little inline function in iommu.h to get the iommu_dev and
give that explanation in a comment.

If you want to do this outside the ops then you have a locking problem
and have to address it properly. Try to avoid that.

Jason
