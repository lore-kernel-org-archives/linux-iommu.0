Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE6013BC20
	for <iommu@lists.linux.dev>; Tue, 18 Jun 2024 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731665; cv=none; b=qhHQb7R/R+tzq66RL3nFi6lh1hy83JVkDpqxwOpMcogaBAQdN5D86LTBXA/ymbh9hbIkcJML6MFKvGaelTfVbqrVg7Op93BOkRs0Zz2zSRxkvv83yypEaUNPSyw/1oIPuX4LLXI3cqsZf23s6Nzs4acXHrgnbyGfueJuTRLYT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731665; c=relaxed/simple;
	bh=UcBlVIfyhzyatIBzaGtoXKCPX2Zgj5bWJa/znlgXM9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Wid/qnxkPQbDvlAsX1ceqBz3f9G2reclyY3YSWuQ0TGrE8vtLxIikvIRNiLUpBglFUSEERHXZ5hxsEV8JXZzVtBH5yJ1jPw+S8OISc0SsVTGFxdTec2bok0bm4M3cYyrrXqA7LR41jk2sLjs/C8wTE0cIa40kXLBOOPjB2QCWZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsI3xF0N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsI3xF0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718731662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KY4cYpr7OGAgBF1z5TUy3J3eXP0t4BCyHmgbv9I9nQk=;
	b=OsI3xF0NYgGdNFeyypBhHNJ+1sa+x/1B2uNoGmI8glE3+Z9sPJinWl07/CsJ5d3p2o3g/I
	W2gzE5vNtRdlHoajI5Z2xfFQ11GEwprP+TFjo7kP5WA0E0qaAJEcFK6TqK3btOKISzUvzy
	kgCakJzi628OnkOekE0szBgKwTcPhV0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-W6rVF8KiMZ6HtdVvGYAtgw-1; Tue, 18 Jun 2024 13:27:41 -0400
X-MC-Unique: W6rVF8KiMZ6HtdVvGYAtgw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79557d418e0so6352285a.1
        for <iommu@lists.linux.dev>; Tue, 18 Jun 2024 10:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718731661; x=1719336461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY4cYpr7OGAgBF1z5TUy3J3eXP0t4BCyHmgbv9I9nQk=;
        b=sqP8W9Xs9Fs6n4UfKW29LjNgn198yuHrAl3xFORfLYcD/NdYPbnQrBA+iRwkJZi93R
         Di5DoWYFTygOdv/sFlsNFInPuIMgtB78J8XiVkRVLP8UQ8s+JkSnRiS6KKIBQBvi9ePS
         FbaxAFF2yI5fdrdfeDu4BHPhPErAlUvod2XjCg9hyZuCrq/kLOsMYkH5cSUU/ZcmmipU
         10ebXUYdt0ltOFryqPDmjXaPHICmRu8POPf7WCBnBGhF57YVCnDQK0XIzQFPiYTS9XAE
         ypMYFFXQFbkHV5IGyoG+d7IEiGmVFDSf0/cPIqkbbJ1HaUt50tfu9KhrwYF5Qmp9JL3S
         htnA==
X-Gm-Message-State: AOJu0YwnJmbz3GCv2a1uNuBhzG3X7Dd68efx/6yEOz303zaEVds4rBIM
	6TnsJUUMo4NqtQ9XEsDZ3EShwcQ+ovS31waWd4yVqlQ0KQnfvFrsWmllyz/cvTQGjyIxiOlyHbw
	4EZaBHO3deQsSOTVnSIHP6riTJ47IiOuEqfkLVYYodwNOOuxh5Ra0
X-Received: by 2002:a05:620a:3903:b0:795:2391:bc36 with SMTP id af79cd13be357-79ba76e3bebmr526292085a.21.1718731660843;
        Tue, 18 Jun 2024 10:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtXoSVoWCAsjsTzixnT8ic4JjoCi/m7ZDPk1Wd03/TCxy0NULHKDf3CrXQHrcYhg9e3OznWQ==
X-Received: by 2002:a05:620a:3903:b0:795:2391:bc36 with SMTP id af79cd13be357-79ba76e3bebmr526288985a.21.1718731660497;
        Tue, 18 Jun 2024 10:27:40 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f30f142esm57948651cf.83.2024.06.18.10.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:27:40 -0700 (PDT)
Date: Tue, 18 Jun 2024 10:27:38 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 01/14] iommu/arm-smmu-v3: Convert to domain_alloc_sva()
Message-ID: <736p5z2eubxzg2ikeqbdbs563gouvzfwlxdxalga7cezjv4xqx@jygkrfs6g3ca>
References: <0-v8-6f85cdc10ce7+563e-smmuv3_newapi_p2b_jgg@nvidia.com>
 <1-v8-6f85cdc10ce7+563e-smmuv3_newapi_p2b_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1-v8-6f85cdc10ce7+563e-smmuv3_newapi_p2b_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2024 at 09:15:46PM GMT, Jason Gunthorpe wrote:
> This allows the driver the receive the mm and always a device during
> allocation. Later patches need this to properly setup the notifier when
> the domain is first allocated.
> 
> Remove ops->domain_alloc() as SVA was the only remaining purpose.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Michael Shavit <mshavit@google.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

