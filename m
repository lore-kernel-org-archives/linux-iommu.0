Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233912B6C
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 15:02:25 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-406b9bcad5dso28684821cf.2
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691506945; x=1692111745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rM9s45ajvUEfm13rVKA/b953azw8KNY+yLlHhnSd5UQ=;
        b=DsT6u6J5AmNLt3wanf3yA9m8lD4xX5dy3qdymQa/JNgvtVwtzOEitmERjrN8R8dffw
         acaSnVdXU/HDP6fGmnh4VkirimAHTDK73UwB5aar6DaDNQECOLas/Fmzgcjvust7XkdI
         Olyd+xQvQBpPx25wjBOfpUL3J/RJ+Ncgt0Il6PFpbvYo5tYdxZhVH2K/4slawps0liJ8
         Voc8c7THTjLTW7kAg7adAkoJl3dTqSJ8C72tJbshhrpMek8qKjMyFl/7aHu6g/DuzU/+
         5Lta+bjDJBbu5guqfu2wZYD4wKAnaanF5Gvi9frf2g1cezzFxAmHfK4j/lPMDbnr63cu
         yQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691506945; x=1692111745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM9s45ajvUEfm13rVKA/b953azw8KNY+yLlHhnSd5UQ=;
        b=HEiQmuf3OLMlbJvo2EwsivDdLmJAn30D/pTTSMd2qCf5hXmnTjxbpVZVVMFpCBeM0B
         FuwZM1Flu8OEcGDffAaDbD5fu5t8hWBzC38Cr3pKwRGWtq/7tAVCxiO/+HmVSf1tOdoM
         MVcZ3NCvS3YrcJOyqG92MLh6FoTIfcpplt9uncJWjS4SJOZiivU5/Bq8fdAXcGMcVrF9
         2HqoQmK1URA/aY9DjAqeT6oXGRn1t8e7EHjSv1sKpTGgkLUpP+AodZrd80HwfO6RD0vo
         5P6j8DeUlEXy83Wx9JGSiCVgV64dAcKL9Hlwo2cHXeARnTsHnsFSvga2o0AEfRJnT//S
         v9SA==
X-Gm-Message-State: AOJu0YwAUBxvj1j5y0hIP+7F1HSgdDegl7vy+C3mIyEfhTYODkvmk3gQ
	0vUGX/QFM6IflF6aFH/Rti5kGw==
X-Google-Smtp-Source: AGHT+IH1k2gtxB/qMeg2HYGK22I3eNo31aRxolvh9gdfopezij2ls2Y2lVbvyMlNtptN2VT/xlyoFA==
X-Received: by 2002:a05:622a:93:b0:410:bc4:d7c4 with SMTP id o19-20020a05622a009300b004100bc4d7c4mr7082848qtw.51.1691506944768;
        Tue, 08 Aug 2023 08:02:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id k14-20020ac8604e000000b0040fefceb8d1sm3387788qtm.20.2023.08.08.08.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:02:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTOE3-004cz2-M4;
	Tue, 08 Aug 2023 12:02:23 -0300
Date: Tue, 8 Aug 2023 12:02:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iommu: Add mm_get_pasid() helper function
Message-ID: <ZNJY/9pwRxIkFEjD@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-2-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808074944.7825-2-tina.zhang@intel.com>

On Tue, Aug 08, 2023 at 03:49:40PM +0800, Tina Zhang wrote:
> mm_get_pasid() is for getting mm pasid value.
> 
> The motivation is to replace mm->pasid with an iommu private data
> structure that is introduced in a later patch.

Maybe we should start out by calling it what it actually is:

'mm_get_enqcmd_pasid()'

We can't actually have multiple SVA domains with different PASIDs
until the places wrongly calling this are removed :\

eg, I would expect this series to also come with removing
'pasid_private' from the Intel driver.

The mmu_notifier should be placed in the singular iommu_domain that is
the SVA domain for the mm. Drivers should not attempt to de-duplicate
this, the core code will do it like you are showing in this series.

Jason
