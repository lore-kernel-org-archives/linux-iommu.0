Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7520FB7
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 16:30:49 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1bbf8cb694aso9693095ad.3
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691685049; x=1692289849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BwRQL+AWUvKim0GQsGEOotK3a8TzoberHriHLEkkia4=;
        b=mzJNdH7j3KXWCdbERyami1eWUZrwE1hCaBSAo2i2Oto6L8ZP39PhBlRnCfAsbbulgv
         eWCxmIW+10HSi6CFKRHF3Zs2BZo7EHHSnVqypjjcyFCCaEyu64D9xJ8wpGX/uEH8Ma6O
         y8LsxBXxMvGK/y1/PHiUlqtc/WXJFgih0Q1E9W43g/xd5E51ZDLkuveYyZZNgVqpBL2t
         a4IJ/+dyfJkqZAiec1G/jo9wG4imwZCXdQn/yDJVlhdzVL83GMHz0pId5BEMkLS6qEEj
         ZeTFSEhHNiApWuGK31f60wQ3Fjjct7i8IniyRZOSpLnmyRyeQe9X5tZZtt6RYeJiWbZP
         +4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685049; x=1692289849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwRQL+AWUvKim0GQsGEOotK3a8TzoberHriHLEkkia4=;
        b=grG++QEnUX2JEmgYrMm9BrgHFp7GzweX6bb+X/MYYYUT3UEKIqiK2F11uC/h/0ylhD
         /CajN0l1v6aQMCgc8+0ee+CS6GKBBE5vzslJjj0DyUGQdtDxGYdTQry3qFQ537DK1dai
         6kEghvwF7zzSAFee8s2pjbjFNuF/bNm9EeWSX/dIn9HYM3P28LrPGN8E1bgadRxx5bWW
         LN7TQdqbD6adC9O65TxRPTy97RSbbi9rzP/Dp4hF0J7D8vWbsi1j/hNiDTIeE9aSB6B5
         Jp6hOybXqYUCru6ngrcQIZMxe4PUYg5z8ZnHXX6MjspdsaNj0T0i0/QGsuyY01cjOvlp
         mOIQ==
X-Gm-Message-State: AOJu0YwlOLvq1XkiV6ZA5p08D2JzWu1lo0nknQhDSQedr5YLCGIjZz5N
	ACpz7MPXMClOpI/OJr+hyDv3Iw==
X-Google-Smtp-Source: AGHT+IE+7nKHZqP6buWiqUSlddecY7m4E5CwyR8YNx0+cTrP4l5fwKqhcNkHnbRErSgUOFxWvM8zqg==
X-Received: by 2002:a17:903:32c8:b0:1bb:9b29:20d9 with SMTP id i8-20020a17090332c800b001bb9b2920d9mr3723397plr.20.1691685049135;
        Thu, 10 Aug 2023 09:30:49 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902788300b001bbd8cf6b57sm1980870pll.230.2023.08.10.09.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:30:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qU8Yh-005Gyn-01;
	Thu, 10 Aug 2023 13:30:47 -0300
Date: Thu, 10 Aug 2023 13:30:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"Zhang, Tina" <tina.zhang@intel.com>,
	Michael Shavit <mshavit@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Message-ID: <ZNUQtluLWek3PnEn@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
 <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c0e94e88-94b8-69de-69c8-ed132ae28951@linux.intel.com>
 <ZNOnOGTfpXzrrRTz@ziepe.ca>
 <84494c88-66eb-a731-fbf0-4a83fb9102f1@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84494c88-66eb-a731-fbf0-4a83fb9102f1@linux.intel.com>

On Thu, Aug 10, 2023 at 09:37:09AM +0800, Baolu Lu wrote:

> > The core could put the mm_notifier in a common iommu_domain_sva struct
> > and it could stick in the driver's invalidate ops, that would be a
> > nice simplification (and discourage drivers from doing the crazy
> > things they are currently doing)
> 
> Yes. So the iommu driver can retrieve the sva domain from struct
> mmu_notifier. The callback implementation will still be domain centric.
> Hence, there will be no need to use mm.

Remember the driver always needs the mm as it has to extract the page
table address from it.

At the end of the day installing the notifier is a single call in the
SVA alloc op, so it may not be worth optimizing beyond allowing
drivers to do it in their SVA alloc op.

Jason
