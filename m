Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FFD39843
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMsU9tzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697670264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gu5mPYKh9dQbGLd+i7tjPbhn1ktXDSWeNhUmcltWWxk=;
	b=MMsU9tzoRX9+apRksW0xsdDHaq4vaAtDkZNOzHmy4fIXJR09wJhbpFpwihoougPO/gwez7
	vXz9qKC3dPXUyXZ/6PV3o0fiqqbEz253nZ6bvqLDsNjYp2yEy6SpoZ+MibqbPypkjE+odo
	cSSDD0gKp4aFcgcB5ufganbmOsVfb8k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-HmkXkVdOO-isGKx7BGQMkw-1; Wed, 18 Oct 2023 19:04:08 -0400
X-MC-Unique: HmkXkVdOO-isGKx7BGQMkw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d75988385so20730676d6.2
        for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 16:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670247; x=1698275047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu5mPYKh9dQbGLd+i7tjPbhn1ktXDSWeNhUmcltWWxk=;
        b=VpVbCAg6e+tYuAUtzD0StDJIeCv1naT623+t8UvtKzugMRdR/hykBCJtOjylVsCgnI
         XuSmllbv7H62trkV7mUgw06X7f6lzf3XQj0sPdKH9bdEICIfUEq9u+Bt+ck6SmihiVQP
         DaND+5Ry5mjJCezXPSpmJsl3dT0yLEs3TAGrokDLQQwa7sxsfWYBA+omYCcbqeartd4s
         k5P32fjGHFQ16VqvUwdLf479YYQQMufkQg7r7X3DLH36vBWNKsKpqUky0Xe+6W2xJLVX
         XJzUFyM8hAJo+1m/0gvhszUwgBfGgTSvCIVF1TL2mG87xsur/2V3OVGo2zWfODSn84Ey
         tPeA==
X-Gm-Message-State: AOJu0YwEZywm49tRYDps0ifZLFQ9GckH1bPoeUn3IIiHxYiL81I1+NBE
	uujUQdcc40Fh5IqrdlsrerPzIne7Tv9X4E0x0sdrqxcP3cPilxo+ZPefIxtRXzxhfSUOqa+K4c7
	UPm0INPpDMbiB/Bs=
X-Received: by 2002:a05:6214:27e8:b0:66d:5ee5:8158 with SMTP id jt8-20020a05621427e800b0066d5ee58158mr601914qvb.55.1697670247592;
        Wed, 18 Oct 2023 16:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjeoen4qzTFqffIe4D5jlsyPICKPQ7WSnlA+MDwTRET3suu1ar7hxsRqdxsOSwRRrxd4vQGg==
X-Received: by 2002:a05:6214:27e8:b0:66d:5ee5:8158 with SMTP id jt8-20020a05621427e800b0066d5ee58158mr601903qvb.55.1697670247356;
        Wed, 18 Oct 2023 16:04:07 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id ff8-20020a0562140bc800b0064f4e0b2089sm310951qvb.33.2023.10.18.16.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:04:06 -0700 (PDT)
Date: Wed, 18 Oct 2023 16:04:05 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] iommu: Factor out some helpers
Message-ID: <j42ztri57qkw345hkiwvw64xe36qsxbbayhihfjpmt2qykaowa@kn6uwjio66ou>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <72c599ef84ac29c9759c7f0ecc7bd69fa9aaf5c1.1697047261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <72c599ef84ac29c9759c7f0ecc7bd69fa9aaf5c1.1697047261.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 11, 2023 at 07:14:48PM +0100, Robin Murphy wrote:
> The pattern for picking the first device out of the group list is
> repeated a few times now, so it's clearly worth factoring out, which
> also helps hide the iommu_group_dev detail from places that don't need
> to know. Similarly, the safety check for dev_iommu_ops() at certain
> public interfaces starts looking a bit repetitive, and might not be
> completely obvious at first glance, so let's factor that out for clarity
> as well, in preparation for more uses of both.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v3: Rename dev_iommu_ops_valid() to reflect what it's actually checking,
>     rather than an implied consequence.
> v4: Rebase, also catch the sneaky one in iommu_get_group_resv_regions()
>     which wasn't the full pattern (but really should be since it guards
>     the dev_iommu_ops() invocation in iommu_get_resv_regions()).
> ---


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

