Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6512B6C
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 15:19:16 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-63d30b90197so35017746d6.0
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 08:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691507955; x=1692112755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gL2omywPOVNbKUeglpeFfHMIDiTEoGuel7UocewbmbM=;
        b=KgWQ2glz+2t2vfVu3y+qddUr2/dfuq4wOl/XtZp6n7t5CxVuBS4/Z5BUaAwpI8SztL
         +XTgDQuMxJeE203sSdosPcoSkZCve8JMnkJp8e8FvojpVBeX3eKZNYv7EJL6qjgY2B/o
         cAn7gWTigm4N6MQrGX9vKhkA7FbYlxWLboaTShh5oHbE0YV6rT4hLxvyEAJ5L/WjiZ75
         UufN1FLu8SBW0LXyTYU/nrcO3QvcXaWEgUU/JHnxq+tdCxstij1RLBS9gftZZNYJ95kS
         U9T1wCg/dL0dyYPN80uBczv1qxxbVpPSY4JK6/ID55d3cMMCtL42MZiN4VGPZcEi67ZO
         lzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691507955; x=1692112755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL2omywPOVNbKUeglpeFfHMIDiTEoGuel7UocewbmbM=;
        b=jEEpgAIN2Zcy8URZ45gTM0KGuVPJrDrl5V9HOajFitBoKVwnyFowejhqAcWsXfzwvu
         K4bATejMuELxTQNXsVsNKyNyr2c37VVw166htZlgM+Pao6AlJeMRFEZovpRsDAG5VSmq
         SaKpfASRQAUb5pgSWqZJUjrZF5WGo10yzJplyMTO00X4AP8wHjC9nJC+58YdvZTW16Jm
         HW7cHFuwjejhZbvFlAvnnuQFt34CCkhfar7GOKP7mMRIfBRVNdPILxbLwrHzP72NkOgW
         x+BCua+BFmogKv+OP8AIeGSbdFH8crfj4Jci0ffKldjgvWvv7KoGb6sb1wKM2ZKFxQLc
         KDPA==
X-Gm-Message-State: AOJu0Yxk/IYcBoaOhavmvjcGrfa1Fj7vxCqWzLF3HyhiGF8ibkwo3baM
	9ryNLx53rtWK7bosGbtX2XdQ3Q==
X-Google-Smtp-Source: AGHT+IHgfILa7agMZ6r8NdDf08gKAYAowHDrZpHWJkfH8WLRw020X3h5zqhAKbPn1XmQpt9bdUdJBA==
X-Received: by 2002:a0c:a9ca:0:b0:62f:f2f0:2af3 with SMTP id c10-20020a0ca9ca000000b0062ff2f02af3mr10760271qvb.41.1691507955581;
        Tue, 08 Aug 2023 08:19:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a13e300b007659935ce64sm3349304qkl.71.2023.08.08.08.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:19:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTOUM-004d8H-L0;
	Tue, 08 Aug 2023 12:19:14 -0300
Date: Tue, 8 Aug 2023 12:19:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <ZNJc8r1eeQZ8GqxY@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-5-tina.zhang@intel.com>
 <ZNJbaiTDG+YTgpDP@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNJbaiTDG+YTgpDP@ziepe.ca>

On Tue, Aug 08, 2023 at 12:12:42PM -0300, Jason Gunthorpe wrote:

> Lets please rework this function into two parts
> 
> The first should be 'iommu_sva_alloc_domain()'
> 
> It should do the list searching and user management. The usual
> 'iommu_domain_free()' should be modified to clean it up.
 
I suppose we can't quite do this fully since the domain allocation
needs to use set_dev_pasid to detect compatability :( This is a
similar problem we had with iommufd too.

Still, the 'alloc and set_dev_pasid' should be in one function and it
should be undone with iommu_detach_device_pasid() and
iommu_domain_free().

The helper bind/unbind functions should wrapper that sequence.

Jason
