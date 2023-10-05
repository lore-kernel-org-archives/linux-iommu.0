Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360B38BB5
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d3BxdETP"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-419c8911049so7644211cf.1
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696531755; x=1697136555; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftxOEPJW1rckghtvt8DSd7lLtI0tEVMwZjbURy6macw=;
        b=d3BxdETPR8GbubCCTQEkyM1kRocdMuSwPPPtLwLA1LCcXfBqIjBY1cD26qob3pjvhC
         382FY7QSOTYKjgdTOTUqjY0CqgYYTg3A3J3IXd4YggWxQaG++pcW3NhADtnPibqjHSTN
         35bbHQ7o6zzlThQFzc2y/4u28OAHG7nGsbgwxeheIdAgY2ur4eO89ZmPVOzbSHB3tCH6
         lgEwBJIHIeG2Slr7LZ/O7adfQIEwTow515+tzsJaez5s6Vrn+vQRyhj+L4H7VSvyv4jv
         66ucqo0vhRZ3CG8prCmyzlRhcjSp2MmK8chnr0KchMzpiKBjjThZfps1NMzKBWAMh3a+
         1ExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531755; x=1697136555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftxOEPJW1rckghtvt8DSd7lLtI0tEVMwZjbURy6macw=;
        b=JL6N30elHfgx6/wb2fkglECqr27vSCmbiKTAtlgp8SS98I1WiGkCvh67ve1GrUb2IV
         iFYXnzR57+g1sOTHhW5iO6GTS793q7MBzkt6ZOEOhYpwhfVr0TAaqvxBdX+WJy9akwzT
         WBUATuk8+rx83f2zhCUdpfUoPjoJlsm24zcsokJldYZ2phwusbFIlSGuJh25qppqmr4o
         uNK+1oOvpz5pCGDiZZneA3Ow2fO3jOkfEVTq8vXsEork74jOIVL/vJaqRg3uaVywsYjL
         NJYzOnN3K7w80xZoP1SGB4+V+dtgdW8JgD6+TTon1qS+4Y9WCDNnsyeDNr1SGvYPZLsi
         XCow==
X-Gm-Message-State: AOJu0Ywb4qV7WKXKWiTbLALQsQT4+gyVsbrk9ECpEW9wgaSE7LzOpXeq
	IvDNZv8+Gpae+yqiRQHitVqNbQ==
X-Google-Smtp-Source: AGHT+IFS7T8aTHEEQCpK5XZbn9bYJAs8GTcH67a+kIKA/dbNAgv/8+/6Fb+kHkwEyNlWV7wHeziYWw==
X-Received: by 2002:ac8:58d0:0:b0:403:ed26:4083 with SMTP id u16-20020ac858d0000000b00403ed264083mr7375927qta.61.1696531755314;
        Thu, 05 Oct 2023 11:49:15 -0700 (PDT)
Received: from ziepe.ca ([142.68.26.201])
        by smtp.gmail.com with ESMTPSA id m3-20020ac84443000000b0041520676966sm674475qtn.47.2023.10.05.11.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:49:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qoTPM-004Z7D-Cd;
	Thu, 05 Oct 2023 15:49:12 -0300
Date: Thu, 5 Oct 2023 15:49:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] mm: Add structure to keep sva information
Message-ID: <20231005184912.GU13795@ziepe.ca>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-5-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023813.575016-5-tina.zhang@intel.com>

On Mon, Sep 25, 2023 at 10:38:11AM +0800, Tina Zhang wrote:
> Introduce iommu_mm_data structure to keep sva information (pasid and the
> related sva domains). Add iommu_mm pointer, pointing to an instance of
> iommu_mm_data structure, to mm.
> 
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  include/linux/iommu.h    | 5 +++++
>  include/linux/mm_types.h | 2 ++
>  2 files changed, 7 insertions(+)

This is fine, but you could probably squash patches 4/5/6

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
