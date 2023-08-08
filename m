Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625A134BD
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 18:39:40 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-40a9918ec08so39694931cf.0
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691519979; x=1692124779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=64QCZ+lCjqLCLgWqPm6Im36kRBI6O73TOOo0qu3TAc4=;
        b=ngl7ca+dDeOo1NbtsDWD3hb35GubXAE9bW4YU+Q9ZeNQiYlwws2AP21vm1W9mce/Yx
         6ip0BJ/dz8OEdvpusCgK0uEuMiptwij0mmqFChb/mPzoZnydcBzqCj/wld2p+OPVf6aA
         94cg94q9bQBcUj9Shjbi2ywkjakp+/Iuhhg8yF14oxRyg67JuNY8DDoIdat+Bb7WNm31
         W6hOXXt1M8Bj4UHq743YLSzvXXeU4X/bf5rjjn1XoYfXfkxTdDqEX+zEwcLdcBisuwd8
         Y3ls3blTbOZaIN0WkgM2lPu6FUW3roESHOhBLzCk9y44Sc2qYJBZ3qim4dVFt2ny3ReI
         /GQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691519979; x=1692124779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64QCZ+lCjqLCLgWqPm6Im36kRBI6O73TOOo0qu3TAc4=;
        b=kSs4iA78uxnCeJ6nQj+dQN53yFGcFzi602qSb8OtVb0xWh/wiP4BNSEW2Eqwm06bqF
         zs8ZQQIAHGx5esGoYR8FJq3exNXBZGQumtqhfq3kHfOGM6BoOmgrl3FLRAt84AUqqUSL
         /NK74w6Ji7Q3uxyucCpby7yiHCZ070xht8X7Zozmksadc2UcP08b2osVVIkZZbrfT/3L
         rH2hvk9NUBS+dzMXr73kF6Q4ki7F172mKItlZ4ds25z6mWvWtj+vfF+qsHiJzjzm587Q
         keYMsNg0Rc+xPIwTq1SK/pF0LwP22mCSNtM89bLCYaHZw0TkQ0mGeh9zMVEHOq/Io+zU
         4EGA==
X-Gm-Message-State: AOJu0YziNvILxb16fG1LKal73mqXNZIM/rIJzNhrgQFHVKNWl0usPRFZ
	c9YuuzRSAzEHLXgQ2mR083fQYA==
X-Google-Smtp-Source: AGHT+IHpUQvjin0dfbxMHZFXvfs1yLMSRD2Rp9ldZKVLrYQ9K6NRMfi8+h/vzLGKDPZotUVGEmHXeg==
X-Received: by 2002:a05:622a:1a9e:b0:405:45e2:39f9 with SMTP id s30-20020a05622a1a9e00b0040545e239f9mr682152qtc.15.1691519979699;
        Tue, 08 Aug 2023 11:39:39 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 16-20020a05620a071000b00765ab6d3e81sm3457218qkc.122.2023.08.08.11.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 11:39:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTRcI-004vXr-3a;
	Tue, 08 Aug 2023 15:39:38 -0300
Date: Tue, 8 Aug 2023 15:39:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/12] iommu: Remove unrecoverable fault data
Message-ID: <ZNKL6hGRZT9qfV1K@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52767976314CC61A0F8BEFD08C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <faad1948-5096-c9d3-616a-cd0f0a4b5876@linux.intel.com>
 <BN9PR11MB527614E61BC257FE113EFE358C09A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527614E61BC257FE113EFE358C09A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Aug 04, 2023 at 03:51:30AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Friday, August 4, 2023 10:59 AM
> > 
> > On 2023/8/3 15:54, Tian, Kevin wrote:
> > >> From: Lu Baolu<baolu.lu@linux.intel.com>
> > >> Sent: Thursday, July 27, 2023 1:48 PM
> > >>
> > >>   struct iommu_fault {
> > >>   	__u32	type;
> > >> -	__u32	padding;
> > > this padding should be kept.
> > >
> > 
> > To keep above 64-bit aligned, right?
> > 
> 
> yes

If it is not uapi we should not explicitly document padding (and __u32
should be u32). The compiler will add it if it is necessary.

If the compiler isn't right for some reason then something else has
gone wrong.

Jason
