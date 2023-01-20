Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954313C38
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 17:50:28 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id b81so2904166vkf.1
        for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5pTLkkWdxz2TuSidslY63LQA+pUSk+xfh9K8bmwLCbw=;
        b=OtaNHK/aRm4AsgU7KyBwK2LgLEszXKKsEpgKGpD7iDgrAG3HJJhAqnYBmd0Rs6DnLR
         Yfl1aolgDZgmSFtytcBJngDHkoT9UdqxdC+MVZ8laJG3e6c7bd/wGD7NFdXgFZPHxxYw
         AMvBiHT+bHMmVRCzKBgQw7RB4w/3V31ni2plxVkNaSm/bnsOLIstA0K+Fzh1hMovO8wh
         FuAOX0gHEDPZFVCvYyIBxRg2UzrtlUWCCRNlkFp7g2PlTBUUgN8IcNpiGDZwym8Fb2Mg
         0Rhw15OBpzzoPzzBkv0Srq091z174d8XOS/sCU6qIX0lAb/uLkSnh9ytTY4u0wFmX6bH
         UNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pTLkkWdxz2TuSidslY63LQA+pUSk+xfh9K8bmwLCbw=;
        b=sW7FsCgI4NonGlcqFXFLIdvLtx7Kbtz3VgtsXUZ7AAc9bcNSxU1YRDihd6BkPW/oIo
         vFDENaPqcuxXA0AbI6+OyxxFz/MsVN1A7dKsiaKem06NghbMdTB8A2kaCUs/NpHGBFfo
         XLQ0zZ9ohQh0b7ONUkBTlUcs2pJ5uinIFdulHv+cGGtxq3eRj1KMIiMcdMzEKcCYkGbF
         MFdHp+0JPW8ZGe08hL6t0CWWbFpRCp1mCY91AG5eVOzdCfsqCvHQpmrG4fJvlMhyvJ+S
         iF2cMMJkxxL6xHqAQQYXEs1fR2AaUOErbjoAxptxWZZnaM1VZq4/ZTyus2C6PzUGXsRK
         pbYw==
X-Gm-Message-State: AFqh2kr+A5KnKM5EZNDtC4I4NUzSQZSg1GfJKVyC0iqZVcUdMXOs9CgK
	lTrw+qMuYfK6uQWzudEBe7+GlQ==
X-Google-Smtp-Source: AMrXdXsK2UV8ggdawPljqg1YdQGkuBmiReYfSrTK4e2ygR2LCcXuQjc3MenxIkbktc09gC17u/LzUg==
X-Received: by 2002:a05:6122:11a8:b0:3da:7734:2e9 with SMTP id y8-20020a05612211a800b003da773402e9mr9890123vkn.16.1674237027193;
        Fri, 20 Jan 2023 09:50:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id r8-20020a05620a298800b006bb29d932e1sm26816788qkp.105.2023.01.20.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:50:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pIvWz-00ElKv-VS;
	Fri, 20 Jan 2023 13:50:25 -0400
Date: Fri, 20 Jan 2023 13:50:25 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	joro@8bytes.org, robin.murphy@arm.com, thomas.lendacky@amd.com,
	vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH 1/4] iommu/amd: Introduce Protection-domain flag VFIO
Message-ID: <Y8rUYTjVhksAu+i9@ziepe.ca>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
 <Y8F53dzdebKLTlOy@ziepe.ca>
 <90762dee-1559-58ac-220d-a13635d5032e@amd.com>
 <Y8mBczFH/Hw6xot0@ziepe.ca>
 <c3fbec52-1281-eb1c-40f8-588438146c14@amd.com>
 <Y8q9ocj2IZB2r6Np@ziepe.ca>
 <1ba09b11-8a07-24dd-a99f-eeacb2f5c96c@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba09b11-8a07-24dd-a99f-eeacb2f5c96c@amd.com>

On Fri, Jan 20, 2023 at 11:01:21AM -0600, Kalra, Ashish wrote:

> We basically get the RMP #PF from the IOMMU because there is a page size
> mismatch between the RMP table and the IOMMU page table. The RMP table's
> large page entry has been smashed to 4K PTEs to handle page state change to
> shared on 4K mappings, so this change has to be synced up with the IOMMU
> page table, otherwise there is now a page size mismatch between RMP table
> and IOMMU page table which causes the RMP #PF.

I understand that, you haven't answered my question:

Why is the IOMMU being programmed with pages it cannot access in the
first place?

Don't do that is the obvious solution there, and preserves huge page
IO performance.

Jason
