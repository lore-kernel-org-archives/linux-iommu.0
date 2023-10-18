Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233B39843
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+TK1mJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697670368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emwLO1oEgFxoohwR39m91tAAqusjqAjflYtV60nLTMw=;
	b=h+TK1mJIPcrdZOuZiUuDCZA0+sLfyz/HE8snScD2QlJsUN/wNFvTYt7A/W7Ms9ha+Und10
	t4DzyJSBypRXQ2V5Y3qsU9FhxEaOYBshKw++dW5k5YGg7/PJmI3p6gworAQTmRjyHbZGMA
	pc1iD3LEquCSq6JpIj+6e7y1rTmOr+I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-R5w-9vUWNDCJfxRoYy1KkA-1; Wed, 18 Oct 2023 19:05:57 -0400
X-MC-Unique: R5w-9vUWNDCJfxRoYy1KkA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7742eeceeacso918270185a.3
        for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 16:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670356; x=1698275156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emwLO1oEgFxoohwR39m91tAAqusjqAjflYtV60nLTMw=;
        b=XlFDtoy4SFZQoCheOJrhcgbToPtorKJRC3e+3BOuQ/zgmabKpeA2zwEfaFeG8kbVLf
         uy6qhw+FlJlbevfbgnRMUDi7loFOPVXh1GHUfBmDStvyK0PGj0wYw6uL/bmXHJ3dCauN
         xrDKoY/o6rFIfUuN9yVtId/glWrOO8Lu7prE9/qiLUAIT/mjc2qJU91LlleMicUzGHiZ
         ElDqp0QYzh7Jt+UWRc0ukmsInJOINqiNknKfBZUID5KTBukCPN2+zpwGkuYVVLZiJNlO
         ySM9CULaq0EXE3j5GLt2lAHCwDsYpQrv4iuhbX0/51Ydnoq64pQUsnrByXlC6pmU6/yS
         2umQ==
X-Gm-Message-State: AOJu0YzUzrPwW4U9MhrS2HZOI+y8Hm8/vnquCNAtCmWyLXkJ6YNUVSIj
	IEscc6ZbrLxxH3urLqNLmM/WJBmza5Y0g7SNfmOEQ6e/Q+f3NofbCfhTyPSZDqHvtBroN7vEDrq
	lb6RtoJRxM+MW/OMVZluqoUs=
X-Received: by 2002:a05:620a:3d96:b0:773:eeb1:ed1 with SMTP id ts22-20020a05620a3d9600b00773eeb10ed1mr568310qkn.51.1697670356138;
        Wed, 18 Oct 2023 16:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGrsMiHhEWrXRi/9hyvAu7EMDkO8fLMcZWguNzwo9WCS48RlQAIEWo7JYyQZD6lhLG3E/brA==
X-Received: by 2002:a05:620a:3d96:b0:773:eeb1:ed1 with SMTP id ts22-20020a05620a3d9600b00773eeb10ed1mr568299qkn.51.1697670355940;
        Wed, 18 Oct 2023 16:05:55 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id e25-20020a05620a209900b007742ad3047asm307347qka.54.2023.10.18.16.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:05:55 -0700 (PDT)
Date: Wed, 18 Oct 2023 16:05:54 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] iommu: Decouple iommu_present() from bus ops
Message-ID: <hczdhgxyhpdjvwl4k5e77g2id33gjmduwcdfye65qxpdu2n5fn@g2byzbj47kff>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <6711338e24dd1edfd02187f25cf40d8622cefdb2.1697047261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6711338e24dd1edfd02187f25cf40d8622cefdb2.1697047261.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 11, 2023 at 07:14:49PM +0100, Robin Murphy wrote:
> Much as I'd like to remove iommu_present(), the final remaining users
> are proving stubbornly difficult to clean up, so kick that can down the
> road and just rework it to preserve the current behaviour without
> depending on bus ops. Since commit 57365a04c921 ("iommu: Move bus setup
> to IOMMU device registration"), any registered IOMMU instance is already
> considered "present" for every entry in iommu_buses, so it's simply a
> case of validating the bus and checking we have at least once IOMMU.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v3: Tweak to use the ops-based check rather than group-based, to
>     properly match the existing behaviour
> v4: Just look for IOMMU instances instead of managed devices
> ---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

