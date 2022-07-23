Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D617E
	for <iommu@lists.linux.dev>; Sat, 23 Jul 2022 16:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658594007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7RhhPlmh/dGI5CL58sn53hCX8DKgVY5/Lyve4O4jeUU=;
	b=NEZTrPagShtynqeXxOuMFzUB18lW4GmDbLfwvg346f23r1eN9SZupLmi9j1IIoW9AnG4tB
	T+vGCvDEXjn21wdh8BXgBpt9w3owbwK44hFolQrD/ziTIdaqfei52U/+JV+0jq9rI2NlDx
	f50EL1OOSJCAx8Xb44lMtdd4zjPD21w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-5SVujwlbMQSIq1iS5WXB9A-1; Sat, 23 Jul 2022 12:33:25 -0400
X-MC-Unique: 5SVujwlbMQSIq1iS5WXB9A-1
Received: by mail-qt1-f199.google.com with SMTP id a10-20020ac84d8a000000b0031ee6389b7eso4074942qtw.6
        for <iommu@lists.linux.dev>; Sat, 23 Jul 2022 09:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7RhhPlmh/dGI5CL58sn53hCX8DKgVY5/Lyve4O4jeUU=;
        b=ZFVEVvolib0bxif+8oQ2fERoyczYdgAvGDqecdSISX+uJzFZLq2rL4REudiWMvODgH
         M2AGZ6QKTecJ7tANe9KVOSQrlM2Aguxoz4Gw03757DYLxzh5pWs3INbVuOslGlJa+3AP
         LGDCV37BMRn0AciE6LfWl9rkDfc9tGzMsYMryw1LfhYci+DCXRk3xz1JF6+glsZMVho/
         NAM5dWK/29KPjPLNj/naR7hPKqDvh4a9m6LHu77PW0nrmkUZdlWwoTGEhBgWqdPDbQnz
         fu2E0vzCxgre/g1pR2YgM9GQjUviZk5BsO1Ws7vPHhE7fVpDlCpICPwXnguA6GjcEwZ2
         e9GA==
X-Gm-Message-State: AJIora/rnsPlTqrd8p2zRxaIBT8Ox0Zb14hlMMzTWkl5ftBqlmaD5uDJ
	omzQPqmiV4Hrn8QZha0q/CxtIlINOLnuwQcY/CXLxNzOQSEiOfK/DRYFtweD2yAUin82srv5h5t
	s24DUdGa7v/SXpCI=
X-Received: by 2002:a05:620a:254e:b0:6b6:bc2:e083 with SMTP id s14-20020a05620a254e00b006b60bc2e083mr3766709qko.317.1658594005330;
        Sat, 23 Jul 2022 09:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uF6O4GIcegNS7OhgngfC4nGoV/PV/fGplM98i5ZGB1zyX12JZNAI9d5d9GqBYsmqUFuvIjVw==
X-Received: by 2002:a05:620a:254e:b0:6b6:bc2:e083 with SMTP id s14-20020a05620a254e00b006b60bc2e083mr3766698qko.317.1658594005124;
        Sat, 23 Jul 2022 09:33:25 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o63-20020a374142000000b006b5e3bf0eb8sm5461107qka.19.2022.07.23.09.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 09:33:24 -0700 (PDT)
Date: Sat, 23 Jul 2022 09:33:23 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Disable guest vapic logging during early
 kdump init
Message-ID: <20220723163323.7cam7o252qdi66ic@cantor>
References: <20220721003439.403435-1-jsnitsel@redhat.com>
 <Ytq2GRX7UJjvXk4w@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Ytq2GRX7UJjvXk4w@8bytes.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 22, 2022 at 04:37:13PM +0200, Joerg Roedel wrote:
> On Wed, Jul 20, 2022 at 05:34:39PM -0700, Jerry Snitselaar wrote:
> > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > index 1d08f87e734b..2b00d7f28df7 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -815,6 +815,11 @@ static void free_ga_log(struct amd_iommu *iommu)
> >  #endif
> >  }
> >  
> > +static void iommu_ga_log_disable(struct amd_iommu *iommu)
> > +{
> > +	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
> > +}
> > +
> >  static int iommu_ga_log_enable(struct amd_iommu *iommu)
> >  {
> >  #ifdef CONFIG_IRQ_REMAP
> > @@ -2504,6 +2509,7 @@ static void early_enable_iommus(void)
> >  		for_each_iommu(iommu) {
> >  			iommu_disable_command_buffer(iommu);
> >  			iommu_disable_event_buffer(iommu);
> > +			iommu_ga_log_disable(iommu);
> >  			iommu_enable_command_buffer(iommu);
> >  			iommu_enable_event_buffer(iommu);
> >  			iommu_enable_ga(iommu);
> 
> Looks about right, but I also let Suravee comment on this.
> 
> Disabling the GA-Log under a device still using it should hopefully not
> put it into some undefined state.

Hi Joerg,

Yes, I sent email to Suravee a few days ago as well to see what he thought,
but haven't heard back yet. It might be a couple days as I think he is
overseas at the moment.

Minor, stupid thing, but I wasn't sure whether it would be better to
name it iommu_disable_ga_log() like everything else called here, or
name it in the format of the other functions relating to logs. I opted
for the latter.

Did you see my other email about kdump kernels on vt-d with scalable
mode and passthrough enabled?

https://lore.kernel.org/linux-iommu/20220702154956.x2dxqalzjuzjraxk@cantor/

I've been looking at it, but haven't figured out what to do about tracking
the copying if can't borrow a bit in one of the pasid fields now. Any thoughts
on that?

Regards,
Jerry

