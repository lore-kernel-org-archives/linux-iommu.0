Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743A39870
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOC5/NxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697670876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RiaZftp2sTY9F+anMpEkbmYxNf1b1ZMPyR9wBMotkjE=;
	b=TOC5/NxCXFlRM8N0MIU9CqfJb+HfDUg4hCMjdWUnW+is3W1/wqoigyaA7O0PeBeSPr1zXd
	iLyOwMC3/eOVjHv8LvR/jS2GxDAb57qhCw1Yzp9WDc60uHyQMvvrEAFDnrnpn15O/Nfn8v
	mYjyTINqc5LNiBfFzk8oDB4qAm7iIdk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-eVk_PiZoNHm6-w4IQwHa1w-1; Wed, 18 Oct 2023 19:14:29 -0400
X-MC-Unique: eVk_PiZoNHm6-w4IQwHa1w-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a7ac9c1522so111660257b3.0
        for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 16:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670869; x=1698275669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiaZftp2sTY9F+anMpEkbmYxNf1b1ZMPyR9wBMotkjE=;
        b=d0c3KZdFsdcv0sRSUn20A1CxZ6KUCPYE+0szbg8M8mpYfRpjwh01E9U8ARB7LCqNwA
         Kfz6UxnvQvlIuh/P3G69wCSkZs2OQFeSzkFn59NKQ8hix8tj7oSeXQ14eNVmj9ozKRqE
         Vpmum2K6m+KM0z+R/D68B92/pVKMSoMTWNqwkd6u38WGblHp8KpGAlKZxnqCLtf4SYHE
         ikzKnmda53rtRw0tyDU+mMupWCQA9qZwscLIivwJ4Xj7MGF/N5wrbnA6uOQu07Ad/697
         DaCSlzUoHVjOJ6OBrfWRqCwpKZl9qIuegJBy85Cd3skhMLljWq5pYXxqfJh35Fwli+Pz
         zHDA==
X-Gm-Message-State: AOJu0Yzcv5Irfwcx1qmQOSuh85AVtDeH1TZww46hHN8z052boqgImz3T
	n0y+wenHtaRuJx+S2pgoJjiXbgaEAcRjvJ7FBXjRGPQdFCUqk3IQgbFmJRvj/QhLiCmIp/vsUFW
	sWkfcsSirscwmeDU=
X-Received: by 2002:a5b:849:0:b0:d9a:c946:bb47 with SMTP id v9-20020a5b0849000000b00d9ac946bb47mr779958ybq.5.1697670869378;
        Wed, 18 Oct 2023 16:14:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Qlh2VPorkSO+9RrzUENXrsGkfk/ZnsdYWF0xLaVuov4AA5j14vG088ZVN9GgcVux/fgJdg==
X-Received: by 2002:a5b:849:0:b0:d9a:c946:bb47 with SMTP id v9-20020a5b0849000000b00d9ac946bb47mr779947ybq.5.1697670869063;
        Wed, 18 Oct 2023 16:14:29 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id ef10-20020a0562140a6a00b00656506a1881sm314623qvb.74.2023.10.18.16.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:14:28 -0700 (PDT)
Date: Wed, 18 Oct 2023 16:14:27 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] iommu: Validate that devices match domains
Message-ID: <4syngx7peypqkc6aakw7ybapuoqkww5kv3drujkysvywuj7wzw@6cnaldhvqx3l>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <4e8bda33aac4021b444e40389648deccf61c1f37.1697047261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4e8bda33aac4021b444e40389648deccf61c1f37.1697047261.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 11, 2023 at 07:14:50PM +0100, Robin Murphy wrote:
> Before we can allow drivers to coexist, we need to make sure that one
> driver's domain ops can't misinterpret another driver's dev_iommu_priv
> data. To that end, add a token to the domain so we can remember how it
> was allocated - for now this may as well be the device ops, since they
> still correlate 1:1 with drivers. We can trust ourselves for internal
> default domain attachment, so add checks to cover all the public attach
> interfaces.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v4: Cover iommu_attach_device_pasid() as well, and improve robustness
>     against theoretical attempts to attach a noiommu group.
> ---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

