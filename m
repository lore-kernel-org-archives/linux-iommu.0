Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C4334372
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829432; cv=none; b=J+yuuwOL+LoJhy70rWscEQox635BWj3sk2fvLs3QkZRMhSuT84BKHAMvbNkKoPPycAr7QG+T8JB0e0QZiYmlMw5R4RQr2Qi5ZdngL/OihdgWmwpA198ikAT6Ax8yZKNWCL8bUn74ZcuvOYQkc1UYBXxRauUQ86lHrXAr6bC7u9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829432; c=relaxed/simple;
	bh=KG5LHOGo2mh5vIaKq+QebXYxVd4hhMHqQE7w3KCpNFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGMXo376V4tGWA/xknSGGo/1WA9QZBxlsu+ftWKoVjwSfQPjCoGe2hD+m1TsgOfGBPrB8Wy5z94rgZi1LCJ42QFErpDHco3s5Jmlcgv/cULceieIK5DrayG8hyt2dtUdMoas8UTnNP/IDDFP2iH4pBAfJn2Ck1SPfvi1y/RxzcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aCXOYHEe; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aCXOYHEe"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70ba7aa131fso61755206d6.2
        for <iommu@lists.linux.dev>; Tue, 02 Sep 2025 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756829429; x=1757434229; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTQRLWXvEI14NWUbWjh+wxk4xMHeIyr9b4st02lORnE=;
        b=aCXOYHEeAuLBIdFF64w6jYqeBGxrH/xvod6ZICAfwZ2Z/OU96r8/QcLxcVLEpiGZLr
         RJTy2k0XC1q+DebqRwvXJJbUdtPWEZvNKXl5t5FF47C/2sG1f4fuEUZ6i34DX1z9tNy5
         0yZ8+cIpmfUvgfS+Ms5w3v09ij7Nq+r4UXhZ1lL72GsJIFmTeVbAwsiBt+yDuE+pr9hD
         Ygs+gGZdZNj04oP1NWdfHTnN61EY7R3b3feYwWpuoa/jHsfuRpPy/AERCncDWkc7avzC
         b492V4T1f6DzasbpunhYcMo18r7GymUklxV8HnEYi9THGzfCd/QfIq8a3fNY3XBZsohB
         gK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829429; x=1757434229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTQRLWXvEI14NWUbWjh+wxk4xMHeIyr9b4st02lORnE=;
        b=Pv21IGHMeRuZz0OevTupNLSTCPpQAscnISm7C3wnDphcJskyxuoOSerj36SKyh6thU
         nnYY0DlnjAmXebWXFhXixPhSLjAEncw4MbCzEZIvx6Jaby120+dZxkYahMeHYwM5S3e5
         3l69edZg0SWzH8xTnG99XSulPQUrnrBBUkrpscb/TP4IYxfcPDHmoFt7mnKkpJRejoLq
         Cakx6QfIqvuBrojEUbujX0J/RYaw3VGDx7a79S1ZfhwTNL5YkGeTMo1jq7mFVA6MYqqG
         +tIb+JmbfNzlvfb10ZvlOegUhXAamQZ94ECSH0wY08IuxBk3p0iryR1YcKZS1yZ6AZTV
         Yw1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqIl7hpNCmRFzSaPRZc5xYX/HS2jcpfSB3cS30SahOYlTBugYR1rvDtF9KJYliWP6ye0zJhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqPkmbErQsRXbjTNQJpdoIYeefDh9RVg08aomvDd5Yf2RRorVF
	34loKazrKicO3aSfHvvV1VAQgrnQY/AvU6CP6tzHW4EJoALGNaQ3QlhtmU9VFSyhGx8=
X-Gm-Gg: ASbGncupo6mQqfFVSj7/jsymsYfKQ/jxyfq0abCCx5gW5SqFtyufmOP7X4QkTab3lCY
	coyjo0t0AhiPbJdg5uWNiDI/rOKGmKfmOwDqcr/jVXOd7c6iyWunRJiJiIk9SKfbrFPwvyALHPd
	/CvlyVi2UQ85/BIGloXo0OKC6zhRGpBjl2U3vFSP5TAyfjR5rZ5AsoWWM8mOvUrlTJzRvfSMVyP
	NGRnoLJJn+UN++R83kWcB2eQhupsdGERFSWUU2URWjYSe9+Mk3Xx5TSeLIyhK4IDyWdzxOHCM+D
	NUDt/SnI29QPD/0+k2VOP91Xpr7gkqfvsFh6fVB5/d2vcaqlhYhJ7NZ5/SjtkIbA/pdrlJ+KkGH
	z1IzVg9UzpW2S3fS5BsKd6eDcR9cnnutOHrCmAc2F0SWcpT925FI5Qp/EguchHbyNsRPb
X-Google-Smtp-Source: AGHT+IFhzQTA7hTae/ikIqwqd6lRBifnM++rAw/xHgCOughJssiMfvo0jbnnGhHjDPXZ244dXS3P5w==
X-Received: by 2002:ad4:5a07:0:b0:70f:b283:77e8 with SMTP id 6a1803df08f44-70fb2837f6dmr81568126d6.3.1756829429395;
        Tue, 02 Sep 2025 09:10:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-721cf6d6cffsm6692606d6.54.2025.09.02.09.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:10:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1utTaW-00000001ZJf-1Cbn;
	Tue, 02 Sep 2025 13:10:28 -0300
Date: Tue, 2 Sep 2025 13:10:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	yangyicong@huawei.com, wangzhou1@hisilicon.com,
	prime.zeng@hisilicon.com, xuwei5@huawei.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 0/2] iommu: Add io_ptdump debug interface for iommu
Message-ID: <20250902161028.GC184112@ziepe.ca>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814093005.2040511-1-xiaqinxin@huawei.com>

On Thu, Aug 14, 2025 at 05:30:03PM +0800, Qinxin Xia wrote:
> This patch supports the iopgtable_dump function (similar to kernel_page_dump).
> The IOMMU page table dump debugging function is added to the framework layer.
> Different architectures only need to provide the implemented dump ops.
> It also provides the implementation of ARM SMMUv3 and io-pgtable-arm.
> 
> Qinxin Xia (2):
>   iommu/debug: Add IOMMU page table dump debug facility
>   iommu/io-pgtable: Add ARM SMMUv3 page table dump support

I'd prefer we do this on top of iommu pt please, I don't want to
further deeping the hole of changing all the page table code in all
drivers for debugfs.

Jason
