Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCB171D2
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 23:33:12 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d776e1f181bso3531560276.3
        for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695425591; x=1696030391; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8rKKRCqUyQLWkNEBe6s/yUPdVExxmOivIwMSOHwl/8=;
        b=H/9jxsivqgxAIuBT+gSL7SvqimTPAX8qQpvVHmOz3XwryOWA7JtMMrbKgU7PASMnwS
         7DpDNI0LG9AkaVhNeNR7S4a91N3915U9vcf7K7AkNCvk5w4kELzNdH7R8L+4h2Q3ftb5
         dShjmEMgmH8lMxrlOjHyYxDTwSvWBzvC4gRIkypeBu3flg/znyIOHPiqiDQg3HM2RRuZ
         IayYBDGgdNDC8ByrRRcDCyFqlHAPZPJDK2beE6cQiv6VTWcsX02NSxoCoCrIhqdtj4R0
         7PhuTk/2k2/UPFC2xrWUr5Ta7iwkzKv+T6NwNQjD9jq7Cf1gPZh/vTAj3Wgn2mpXxRl2
         DKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695425591; x=1696030391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8rKKRCqUyQLWkNEBe6s/yUPdVExxmOivIwMSOHwl/8=;
        b=Sq/fkLzyXlxXkgdOdewCqM6CglMlbYkBOo3OcmlOdm/3Z//qjw+daQ4PqSNLXluLUV
         y1TaEfiS4Pbd/UU9ZdcijNfXBOBAS8gGcJ2RJNS64dMcktF1bqFWXCbxyZOROv8ttWl+
         Fjn6s21XSkyu4dVHg+jE/AlOYVcCWZbldzgwgPImyWSyuATcdWSJRGmTRU7/zB/qkuYW
         Z7eZpW3dQ60niEY/WeUGgWTTCFs6wk6k96U31Gbj/6J8xwnZ7VvA0k3KvRWu2SgE7lkN
         qIgDauhywKXfCeySWuKMiJsC+T+XVyGFdTqRlT9JVqplx2jX5aaco5SrjiPsMiAH8ivK
         /8Og==
X-Gm-Message-State: AOJu0YwHxwQWI01QvInO7/BKNnI02TFg2yXncKIovAnrPVq2mNHLeqBm
	8GeKwVHf4i3BZ7unrd7Dm0ziRQ==
X-Google-Smtp-Source: AGHT+IHXIm3CPio25fJfcUEZEUoMW195I/INyvWWRxd2/4S04spIkfTN65/K48HdwB4EwzmNKU/gPg==
X-Received: by 2002:a25:dbcc:0:b0:d81:4168:3a83 with SMTP id g195-20020a25dbcc000000b00d8141683a83mr680844ybf.25.1695425591345;
        Fri, 22 Sep 2023 16:33:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id i15-20020a0cf10f000000b0064f523836fdsm1838074qvl.123.2023.09.22.16.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 16:33:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qjpe1-000eFO-UF;
	Fri, 22 Sep 2023 20:33:09 -0300
Date: Fri, 22 Sep 2023 20:33:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922233309.GI13795@ziepe.ca>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
 <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica>
 <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
 <20230922162714.GH13795@ziepe.ca>
 <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>

On Fri, Sep 22, 2023 at 07:07:40PM +0100, Robin Murphy wrote:

> virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings
> either; it sets it once it's discovered any instance, since apparently it's
> assuming that all instances must support identical page sizes, and thus once
> it's seen one it can work "normally" per the core code's assumptions. It's
> also I think the only driver which has a "finalise" bodge but *can* still
> properly support map-before-attach, by virtue of having to replay mappings
> to every new endpoint anyway.

Well it can't quite do that since it doesn't know the geometry - it
all is sort of guessing and hoping it doesn't explode on replay. If it
knows the geometry it wouldn't need finalize...

> > What do you think about something like this to replace
> > iommu_create_device_direct_mappings(), that does enforce things
> > properly?
> 
> I fail to see how that would make any practical difference. Either the
> mappings can be correctly set up in a pagetable *before* the relevant device
> is attached to that pagetable, or they can't (if the driver doesn't have
> enough information to be able to do so) and we just have to really hope
> nothing blows up in the race window between attaching the device to an empty
> pagetable and having a second try at iommu_create_device_direct_mappings().
> That's a driver-level issue and has nothing to do with pgsize_bitmap either
> way.

Except we don't detect this in the core code correctly, that is my
point. We should detect the aperture conflict, not pgsize_bitmap to
check if it is the first or second try.

Jason
