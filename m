Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D865F182AD
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 12:31:18 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-40fd2de0ddcso51149651cf.2
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 05:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691584277; x=1692189077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwxMc/Jnf4KYiaUH2KdLbTiq/tI1vp0nwZHG7xf4bjQ=;
        b=JGgHp8s1/q17mE16KjiuAbrpI+wZnxS9jiieUXX6BnO3L5pZOuM+jYpbmKm+ouHJlR
         7WEC2Qb6WMFXDl436d9Q58D2e9JubHm8efuk/mVFKuTFjMIEx0oSiMtnEw4YjyMCyhBj
         mBdPARJI9Y3w/N9xVq/0QF9mWnFLBGa9YALweT5v58LILwqqj8KmJwEnQQZlZ3GEkhe2
         5susF1zxhAh0BbxG9LLWGjMrXnBX1CvlxqwkqSUUHk6eLhHCL1hmSckD1zgeXja36aeh
         mqjmx1656ysy1g1Gfa5RflRrmlXBBXMusGLtNkXO0RgEMslQ45NWKkalm+AFfCNEZywR
         hdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691584277; x=1692189077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwxMc/Jnf4KYiaUH2KdLbTiq/tI1vp0nwZHG7xf4bjQ=;
        b=Cprx4zozds8HsdG5KusscOE4KGFdPwgzy6z3gDjF1RfB3waNqyZ4kLmxGmnSegrUIe
         uTUjPu4psWxjNOgSFR1h1KaZ1HBT4wi4GM3QmGIki9UJsSfRGHJS33LOQtnwcHOgcjid
         7VP/YI+AkGRFfcSKRP3AFdifFBpGZ0j3mKkR/N0+dWASgVMzGvd3AzoYHL0eNVydsSUa
         1iKqX100KA6yD2+EBEECc8EQdcMRlpDz28mIh/IgZrVHvyNOjhS9bCGdpwZ8B72e27g1
         vEKYwuQrYB2SMDepfHbrvBpBf9j+6Mjgud11qyEHFPIIU5aHGqJeR0yNFkJCMsPsZYuK
         tcLg==
X-Gm-Message-State: AOJu0YxfoPUZ0Mgkx9lCMjWxXcbxzWT6q1tvpbemYMsIHfQ8CTFL9+b3
	DlltH+YgyssL1GGBaW39VjqP5g==
X-Google-Smtp-Source: AGHT+IE/9nPEzWHTfAO4Unck7OivGgxHUDY+IIy8TYtQWjM35uS0OME7kSgnmqRHBiRv00LegSDHZw==
X-Received: by 2002:a05:622a:101:b0:40f:d66e:8134 with SMTP id u1-20020a05622a010100b0040fd66e8134mr2652250qtw.59.1691584277408;
        Wed, 09 Aug 2023 05:31:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id fu25-20020a05622a5d9900b0040fdcd391d8sm4039493qtb.72.2023.08.09.05.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 05:31:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTiLM-0051Mb-4k;
	Wed, 09 Aug 2023 09:31:16 -0300
Date: Wed, 9 Aug 2023 09:31:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Zhang, Tina" <tina.zhang@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] iommu: Add mm_get_pasid() helper function
Message-ID: <ZNOHFKbkQ75owuwC@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-2-tina.zhang@intel.com>
 <ZNJY/9pwRxIkFEjD@ziepe.ca>
 <BN9PR11MB527654AF38084B07EC7734468C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527654AF38084B07EC7734468C12A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Aug 09, 2023 at 09:47:15AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, August 8, 2023 11:02 PM
> > 
> > On Tue, Aug 08, 2023 at 03:49:40PM +0800, Tina Zhang wrote:
> > > mm_get_pasid() is for getting mm pasid value.
> > >
> > > The motivation is to replace mm->pasid with an iommu private data
> > > structure that is introduced in a later patch.
> > 
> > Maybe we should start out by calling it what it actually is:
> > 
> > 'mm_get_enqcmd_pasid()'
> > 
> > We can't actually have multiple SVA domains with different PASIDs
> > until the places wrongly calling this are removed :\
> > 
> 
> it's kind of egg-chicken problem. mm_get_pasid() is used by all SVA
> scenarios beyond enqcmd then calling it mm_get_enqcmd_pasid()
> also sounds weird for non-enqcmd case.

Well, those are wrong. We need to be fixing them not hide our eyes to
the wrongness.

Michael is cooking a fix for ARM, Tina should come with a fix for
Intel in this series.

Jason
