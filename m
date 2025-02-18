Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2826F459
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897597; cv=none; b=dDAVBbHdIDDMB6Q0RxVIWpuU9FFAzbA0hKibhfhZ4a5NYFYVvOUVvhD0x9CdkmDRzx7+/lnta7OgL1+36iM++TyLBgGJqymWMnTexL/FQUSXzIW9cLvJqG58rGe4Jnnb3CoZ0VHSvG+zptkafKoov9RWAmTQ/FSTP/KLPjqmC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897597; c=relaxed/simple;
	bh=JN+vmPozrfL53NbfbGS/Xiap+yTcolfIfbz+5mlE9OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcpvVIfpJBR8RDdLH+gnbb2X/A+UaSQpa/6qcDuw48109fWdFIC589/GeKmbLXVXSCoOOAULe39z/mYjQuQKsP5CEQNkL0QjD8/IJoDW06HfYNeDxyztj88IP2Ci7RdJy9EAIVHOTCCNKjwUEqgx/3m8GcGIHh0OY/LwvKKTYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Bw8AeVy4; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Bw8AeVy4"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso101236006d6.2
        for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 08:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739897594; x=1740502394; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JN+vmPozrfL53NbfbGS/Xiap+yTcolfIfbz+5mlE9OU=;
        b=Bw8AeVy4dOkOzvIlvsEXoaRq45HdHUHJI468K+Ysyz4Q073sLubvRHtKBO55zFL6Dp
         17Up0ptPG1yvCkmw3DP47y9shic6Pm5U7vvADG3XxReNJktpGbX5muRgaGn1R8pDX/XU
         709uxmepk90V88dOvWJeH/0Q/z14ROMYT2BGhvKeQY0Ulpw2tTRIjhirTSRT7tArn7DX
         es594Ihec+Dmr6uJ6swdima0bES4kXEygytW8w59WdXJ9SnYEY0/2eai/wq4nk2UpIEm
         ibkA0cYruX/YzkI95+9XMXJaoiwUmC7cQaHtbziA5Mg9qZ+RIHswDuhBJOqJQPQ+GlHJ
         g9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739897594; x=1740502394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN+vmPozrfL53NbfbGS/Xiap+yTcolfIfbz+5mlE9OU=;
        b=eH+Ve9KzaHK1XT5EjH3dXFVCDshXyOXVANC6g0rkzj7eNgMMAnIw5ZPWokA5yXa1aV
         zvy8Cqd8Y3WRX7JwNt/fDHd3agU2ImEtBe68oJ4YmIBgkCw/clVmeC4ahlgYB+cQXUSQ
         0ByfAQo4Ag4G5ETwUKfwGcs4HwHymeDE9FolnscXo7is6x/H5oNqCbSzAHukbYw7mVZ+
         Yko5OoHwy1bPHW+54FeIrfY122le9zbxy/g6hC9vJ202irfoC2L3snb/Kxnd2Oqy39jQ
         QywkTaToeTxUVVmb3XO1D/tV/81TmHufwV34vUFU5nd9bNlY6I4DIjnXQ+zOnVK4DoY4
         Lv9A==
X-Forwarded-Encrypted: i=1; AJvYcCUR8tHq5cdvAWw6h6+2a86/7vcd0zfCvmeUKNvtEBeNBU27zk0Uis8Jk+z8jIWdo5hvrYOtwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKpxZe5w0diba8yebM04kLChZywOesSYIoPNpnGoD6YhIbk7v7
	u2WvBeW/8um73GwSnW6YrDfqu4O7bBkFYLnTIhmfVlJxsI2X8yfcI5PGCou4Nkg=
X-Gm-Gg: ASbGncsAymPGjQV5qq6qUQsL9V00qp2Feo6g75qFDoJW4wQdNWBiPlmX5JKjXPjcW8Q
	Rg3hCCnEyY7ZtgCULsllDN9b5wrdO/Vdjarmbv5lgdX7HLXCpepDBRU1mxv1oV8Ti1VgD6x7VIK
	2kGBhogFZlk9S1ken9OwJxS6imSDkDNLe6j2Hjta60eWaw5zbg/yS2akXYUoWwGgbeFcLPmhEP/
	3LbHbXYF0zC6lSVvwi+PZ+poFEbcTpPmqmk6AHGbjm7h9z7aB8+gNzPmPw+rkAy7KlcMoShm2nE
	6ZQqrbEZ6j+vt2WzZKNuO0fYMGO8n6z8z3BLe5yWUztDJGJqvyB8UIRJgLIHMB9K
X-Google-Smtp-Source: AGHT+IF4ueE9/T1SsRmpMnPF74ga1OvVK9kyodfV6ipyhxushK/lMBjJL6RWxuF+bbMy3ZOnH9SWRA==
X-Received: by 2002:a05:6214:20ad:b0:6e4:6ff6:bacf with SMTP id 6a1803df08f44-6e66cccb3e8mr226386376d6.19.1739897594138;
        Tue, 18 Feb 2025 08:53:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c87412fsm675156285a.101.2025.02.18.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:53:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkQqO-0000000HX3t-3bwR;
	Tue, 18 Feb 2025 12:53:12 -0400
Date: Tue, 18 Feb 2025 12:53:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Message-ID: <20250218165312.GJ3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
 <20250214125600.GA3696814@ziepe.ca>
 <CABQgh9FQYe46hfjcs+o6GfLaS7OfSqrmvXUzOKd6PRK8oBF8Jw@mail.gmail.com>
 <d578bf4c-f475-42bf-9cb8-21941fc7af88@linux.intel.com>
 <CABQgh9EG3gjtw19qvr7OhxKmR8E6+xwBf9b3=WPNrXRc-m9DjQ@mail.gmail.com>
 <59998dcc-9452-4efd-be69-d95754217633@linux.intel.com>
 <20250218135751.GH3696814@ziepe.ca>
 <CABQgh9F8BJr_bkEQD6s6DSsLw2jwpgq-p73YL=439_WwH8P5zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9F8BJr_bkEQD6s6DSsLw2jwpgq-p73YL=439_WwH8P5zw@mail.gmail.com>

On Tue, Feb 18, 2025 at 11:25:59PM +0800, Zhangfei Gao wrote:

> I have tested it, and it solved the issue.

Great, thanks, Baolu can you updated the patch?

Thanks
Jason
