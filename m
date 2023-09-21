Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C1199D1
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 17:21:50 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-690d9cda925so1069094b3a.3
        for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695316910; x=1695921710; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DDlx5u08Y4vCd1/nVmbrXXCewhf3kn19HA1I/+IIlzU=;
        b=eiOGbfyn91tUB2WEZsxFSdmicyBV3/UJp+uGBCfqIhx7gkOIjXlbBjG5F5KZpYvlWi
         7+wT9uovxPybK0vJGwuiKBd3luZMTFEd32dc6ZfWRyt7DPfTyYlx/sY4gXPPUAJbAup7
         i1iFhDJXo6y6W4bzQ5CLEVF7io6Ygzk20FCDU/X8BhM2E3401I+CwVlFHdu6PgH5v9jb
         7HUGtQYYfDXXXoTmVCzORmruHtKeYZuDUZ7lTBXYBbKwJbJi0O5tl567S7W8XGb8KO1f
         E+lXhL5BGKthW5MWE9qAYcw6Wtnsepn9c0MW8l1KstgDHPJsy4zYoINllYHXmX7izHCB
         g18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316910; x=1695921710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDlx5u08Y4vCd1/nVmbrXXCewhf3kn19HA1I/+IIlzU=;
        b=u/7Ydyo7kVG5rAJsRT4Fm1cNHS1AC+eFJHIZhWe2b34QIds53mevz5CTkYD9yizqdg
         7rjleFkpmAD8WeJJeF1S2n1sx1Gd8o+sGJxG73PeX1GvywnSD1ZjRcd4eL/C98C9Bg2V
         2P0aJWmATpYOwzKCgh92BDrHA+NtQf75W7fXulNzwVFZ8TuidHXyCKS0l4rw5OrBa9QW
         QEVnYBpsnzNHalii8SqceXyG4Ggrarsr5Bab1+fhS/v8wweYBo5So93mV4xcm0uAlT2m
         4h0/oVFos430HYCaLQCCz5ZR2SE2y9ODYPgZ1xsO1QfsVGB8bSEj/HhaSwWJTO4VKCVt
         Sn3A==
X-Gm-Message-State: AOJu0YxoiOVOztNfg/JNY7s7lmotwMTbijZShEVx8z9wK15wXXLIKPGt
	lEAbJQbnQq0veQBpStbqTEfygw==
X-Google-Smtp-Source: AGHT+IF+iT5bUyjUish2FFfSOSqXCZvJKK7nG1hU3ihueQyPk8QOt2OQb3+vSPmx/noLidk1FI+CeQ==
X-Received: by 2002:a05:6a20:5648:b0:12c:b10d:693d with SMTP id is8-20020a056a20564800b0012cb10d693dmr5634143pzc.6.1695316909978;
        Thu, 21 Sep 2023 10:21:49 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f20-20020a63f114000000b005703a63836esm1555894pgi.57.2023.09.21.10.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 10:21:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qjNN5-000SUu-NP;
	Thu, 21 Sep 2023 14:21:47 -0300
Date: Thu, 21 Sep 2023 14:21:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, wei.huang2@amd.com,
	jsnitsel@redhat.com,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v6 00/14] iommu/amd: SVA Support (Part 1) -
 cleanup/refactoring
Message-ID: <20230921172147.GX13795@ziepe.ca>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
 <04e44120-61fb-3aa1-50b7-8a9ac01cea7f@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04e44120-61fb-3aa1-50b7-8a9ac01cea7f@amd.com>

On Thu, Sep 21, 2023 at 03:19:37PM +0530, Vasant Hegde wrote:
> On 9/21/2023 2:51 PM, Vasant Hegde wrote:
> > This is part 1 of the 4-part series to introduce Share Virtual Address
> > (SVA) support, which focuses on cleaning up and refactoring the existing
> > code in preparation for subsequent series.
> > 
> > It contains the following enhancements:
> > 
> > * Patch 1 - 7:
> >   Clean up, refactoring and miscellaneous improvements.
> > 
> > * Patch 8 - 9:
> >   Use global functions to check iommu features
> > 
> > * Patch 10 - 14:
> >   Modify logic to independently enable PCI capabilities (ATS/PASID/PRI)
> >   for devices. This allows more flexibility in preparation for SVA and
> >   IOPF supports.
> 
> 
> This is an independent part of bigger SVA series. This particular series is
> tested independently and it works fine. Can you consider picking this series
> while we work on sorting out Part3/4?

+1 

Also the v2 API removal:

https://lore.kernel.org/linux-iommu/20230921093140.6162-1-vasant.hegde@amd.com/

Jason
