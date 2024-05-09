Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B36FB0
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273967; cv=none; b=sANYbTw5JCR6kv/UiXegjjJaeeVKRbB5OLPQk9y8lNDETKTr11bYDXGlBEdbvxjSh0lr/HlLZNf34ZGQEmPYyA74T8z+e8pJVHKiaCPwUiyzt0FjkPSs4UAV7RXRJANXsokULwVzmqMBxg1PJrjiUe/KtR1hjHkri1+Ex4s2LYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273967; c=relaxed/simple;
	bh=LVofdpMaaybe534rT1hXOUzrYQT8JG8i1eWkbtTPuwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kJ32hYJKj+eoEEDtFwFEtT6fRTIAFYBwrfnisLmooKoWsKSDC+zH2jGLCL3zdzjiMChFFHQeoJwTcUpuj8AvFyAd8s06M5genNzILWeIzTNvnF3CbM14WkvsTenhmmSZVdJGZQNPmr0qz0V1oaeWcyIy+wI+UV9XDmAFx0qcDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P66kLthE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P66kLthE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715273965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sD1Wd7jElJtfuth9SeXDpzh6EeccVA2udVrpzSZd9iU=;
	b=P66kLthEMoNzakGszCjGLZB1k0uCHXM5OqExiFU1ft+Aaj8H1moI3LUvo7Y59lF+gw9ED6
	qbQEtpZpPeToJQp8ze86m3NFSf81YhC+kRwMBuvjmFeseup9XWZZEwr5fe/ZqpToeBh2+P
	IWCxpcJPGXXe1c26SoPqNDTNrlIEjfE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-RS38tGXaMAS78zCM_ydHWQ-1; Thu, 09 May 2024 12:59:23 -0400
X-MC-Unique: RS38tGXaMAS78zCM_ydHWQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6efef492e79so1157471b3a.1
        for <iommu@lists.linux.dev>; Thu, 09 May 2024 09:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715273963; x=1715878763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sD1Wd7jElJtfuth9SeXDpzh6EeccVA2udVrpzSZd9iU=;
        b=JY/YxRQe+CI4rBnDF4IcuVTw71mhrSXROjQRhhcZE0HAAT1INZExKk2LlzgnKKkVsC
         fFxLXgO82h565VkACSNELYOtJ4+KVqWgeZIvRi4ti0X4HFccLgW0rx39ZFUAqQiYZ3Xc
         g6DelTYg9JmHEedoqbTfJZzEL/1hA4yY8DsY9BFEcqtjbpp/o18H4AsjsWWfbaU2CCk8
         vY5yf6aePWw25CFAtrpw9C1pzkmG8btLUFJs4HKsrB/s2OaAElX2L1VSY6GdFuqpEAo1
         XbYgF5fCeL7eQc/rOc7gQ3rJ3F2EhQzDov3KabWDUXCYnkjJR2dkOOlXh2A/mK2E7D91
         ByGw==
X-Gm-Message-State: AOJu0Yxh/VoWXSi6qOFNK/eZ7VkfEefPT2BDtVpWYZz4AGk4F9G5H0bg
	jTIAwqc8arjtGfATeIOyahvh8bGiJBnAtk6k6AbSyRr8WA4bxZeyQvq+dROGU0EIAmwYvmDWLAk
	2r9mkD9Hyg74Ehh1tlCbvHrzFliBtpjSsSZulmq9WIsECdnKagPSl
X-Received: by 2002:a05:6a00:1405:b0:6f3:ea4b:d1c1 with SMTP id d2e1a72fcca58-6f49c1f5e1emr8009901b3a.1.1715273962790;
        Thu, 09 May 2024 09:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMjtkZdVFKPzMvl+HELD+5jPrS1G3kUoLn+QP5lBuCjXOWNjMd91ExYaXEwh8qZyFJRyMORw==
X-Received: by 2002:a05:6a00:1405:b0:6f3:ea4b:d1c1 with SMTP id d2e1a72fcca58-6f49c1f5e1emr8009877b3a.1.1715273962428;
        Thu, 09 May 2024 09:59:22 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a666f9sm1518079b3a.21.2024.05.09.09.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 09:59:21 -0700 (PDT)
Date: Thu, 9 May 2024 09:59:20 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Moritz Fischer <moritzf@google.com>, 
	Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v9 9/9] iommu/arm-smmu-v3: Add unit tests for
 arm_smmu_write_entry
Message-ID: <3wwifo7cnhradd6uoi26zivcabd63yacz2mgll24rvdidktehe@f2mh6zxw7jgh>
References: <0-v9-5040dc602008+177d7-smmuv3_newapi_p2_jgg@nvidia.com>
 <9-v9-5040dc602008+177d7-smmuv3_newapi_p2_jgg@nvidia.com>
 <smzgwi3nbkt5ws2psvh6hzygaelalfviv425q6igherxp52tga@6x5u45gvorrj>
 <zgyiqgym6tf6dkxa6bxzfgexjojwhteqjmuxmed3twejpeoy2i@ortfllwylmpp>
 <20240509114014.GO4650@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240509114014.GO4650@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2024 at 08:40:14AM GMT, Jason Gunthorpe wrote:
> On Wed, May 08, 2024 at 07:21:10PM -0700, Jerry Snitselaar wrote:
> > > Should this be 'depends on KUNIT=y'
> > > 
> > > Seeing ld complain when building it on top of the rhel kernel. I'm grabbing a system
> > > to verify that it happens with joerg's next branch as well.
> >
> > And I see you and Will are discussing it already. Ignore :)
> 
> Indeed, if you have a perspective what your distro would like please
> share in that thread
> 
> Thanks,
> Jason 

I think there was a mistaken assumption somewhere on our side that they are all tristate. They get
built, and then moved off to a separate kernel-modules-internal package that isn't shipped, but
used for internal testing.

