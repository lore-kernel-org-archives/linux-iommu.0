Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70570283C93
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410083; cv=none; b=UsoJlEFMZdSigu72tYKwekXvxIlis7UYT1EZ/Dd1B8422XfJ/QsoxuhZsu/Ija97HqqGTDWrMh3yonXw5e8jESfYmZW+YYyTcVyCArBF1aX3QPQ/dTnNwEz4pa6Y3GB/nKRCa35JAcikMr0M1mRtRUV4zub60fPHpSdS8uH02rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410083; c=relaxed/simple;
	bh=HeyU0X1Cd7WV8d7kBuIX1FDpgYGRaAtOSZh6Uw8ZlE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYhDLvnWd3Ya/0F1I/5eHIlKl+2YJ4XvL06ev2+eqLiX7m8VUauno/YBpY8nJ4Upw4nExZifTr0GvczOY6suNzVRfHLGfBqgbBIKPnGbIK8ZxO1lvlhuvVu7Bk6FKZ1eZnG0ybl1DqLEnMb2UBPTiB0NnoTAFRrh2heVpfTyJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UgFMbQ16; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UgFMbQ16"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-74526ca7a46so324568a34.2
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 06:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759410080; x=1760014880; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUsMdpmRM7X879n8mCS3/9BWR9IxrODIsWMUJBwywLc=;
        b=UgFMbQ16FlzUX2Jc7PVoKa7yH7aGNQSAP0iao+3fvaLypSN3LSgjmNyBF3x08oXN0h
         u6wpxFnqc5qv/4Nh2lovaL2sBdlfVCWPIfG5qETlSo8EtUf0Whbb00PH/zApZtY15nje
         4WaJTaXFlRjMxPnAT2sOJseuCgBIy3ukBgzbcdAyIDMLmHKcarWAnjoce8kcri+zLbPm
         XATUUY8sCLeDQp7yQP0YLum2PPoNyjHUR4g4hwQwr+jgNIo86lMeSLI6n+Due+0+OdQb
         kDnk0LG+J5aFbFOuwsaJWjUlSAxHzfnPw4xdN8RF3NSrbUDOyqfoaUa/V0q9SPVXcJKi
         InMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759410080; x=1760014880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUsMdpmRM7X879n8mCS3/9BWR9IxrODIsWMUJBwywLc=;
        b=loem/UX1iUrWTbL+6JaxG74X0fhl5UoI6TP4GehGsO+dn9hrywX5QPy7fQsRxnIld5
         PxQqIpDdj4dHFct0GNmTBEfdAaGurlz60DWmFEhTJa9gnf/9In7uDuIWkKX/CUmCWmDG
         ABOIGF6bUjzwj05/Zmoqzr/fqp+YYx7BrgwAHbg5B+Py843Pg9CWtMa3ejwRWx1EUHrx
         ZQH+fUG+8kFh5yoylmIENOdY/HTu9oGCtj807n8GNM9XjjgAv3oyXXqnDoj85g/wn1E9
         C/Bp6ld9K2z+hBqgteyCpspIrIls4lvn/iEKSHJzkUVIxZbvQabx9EVtQUloEP7vrNxV
         0AeA==
X-Forwarded-Encrypted: i=1; AJvYcCVjbw2Re1RQsCw41tzK5ccI/TyHN0wHtIUAHYu4BhW1SvNF6XGUf7YY8ZQr2zK/jSemCt98HA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEHa++DLl8QYwNxIIyY+Aig7MUC4JJR/IRvsMUGz1412EG6ape
	9ertXoOetgU4SLiuf32TDwU4TGxKlJz23Omn0ks1G76bPsAY9l/2pHdc/BXJn4NGeoo=
X-Gm-Gg: ASbGncutIAXlHloByeTWJfaWzai4PqRmaWsTRmt/s14XyySGzIpS+jjLwzGuk+m/4xS
	PY+aMVAPe8iphMEhdsUHpaBavqvSWGh1+EmVGrGctCpkuNgM4xX28ZFxPknhVUjLHYmP2hZ01tq
	MxxzCmgBxG7n658uruZosQHSxBu8ElOO9X1uoncDJSLy23aCWsoXPop7AswWP4yH6VmqoDuHqwV
	JcPGpNPTQLenUbOKglTQt1zScB+yor+MEz6Jbsu9tPCK2SYnsL7N9XOi3LWsxc9xI+5m5B4ehmM
	5KmWRk9idIvfSNJqz4XLDxOFnUWqraGGtiByb81ZL9fZJbIILlacPdrWrlwjPDU5z3FU5GN6WVl
	OZEtpiC+MiW9ESVi+LQfn
X-Google-Smtp-Source: AGHT+IGFzneyhPIwEYTxTRu+3x9cUEyBSh7N480rnZah8RtVK6QFov2ZqKcqlL3gifb/fKYD/MCqYw==
X-Received: by 2002:a05:6830:6001:b0:7ba:e3fb:f2b0 with SMTP id 46e09a7af769-7bddb7ed06cmr6745878a34.31.1759410080285;
        Thu, 02 Oct 2025 06:01:20 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf439d2ccdsm613003a34.35.2025.10.02.06.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:01:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4Ivt-0000000DhmS-03Ch;
	Thu, 02 Oct 2025 10:01:17 -0300
Date: Thu, 2 Oct 2025 10:01:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] iommu: fix device leaks
Message-ID: <20251002130116.GB3195829@ziepe.ca>
References: <20250925122756.10910-1-johan@kernel.org>
 <20250930182158.GS2695987@ziepe.ca>
 <0d5d4d02-eb78-43dc-8784-83c0760099f7@arm.com>
 <20251001155851.GW2695987@ziepe.ca>
 <2d94b52c-cffc-40af-930a-20f0130a23ea@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d94b52c-cffc-40af-930a-20f0130a23ea@arm.com>

On Thu, Oct 02, 2025 at 12:48:35PM +0100, Robin Murphy wrote:
> > However the SMMU drivers are doing this under the
> > iommu_probe_device_lock and not stashing the pointer into a drvdata
> > where there is no locking protecting it.
> 
> Huh? Every .of_xlate call is under probe_device_lock just as much as
> .probe_device calls are; they *have* to be, since they too are in the
> position of working with dev->iommu before dev->iommu_group is set to
> guarantee its stability.

Yes, of_xlate is under the lock, but IIRC there are still cases where
probe gets deferred, the probe_device_lock is unlocked, and the
drvdata continues to exist.

> indeed the driver cannot be removed, because we hold a module reference
> around the call

That's not how module reference counts work. Drivers can be unbound
through sysfs at any time.

> > Anyhow, I drafted a nice fix for all of this. After all the rework it
> > is trivial for the core code to pass in the struct iommu_device * to
> > probe and then most of the drivers just drop this ugly code
> > completely.
> >
> > https://github.com/jgunthorpe/linux/commits/iommu-fwspec/
> 
> Eww, that is neither nice nor a "fix". Once again it's just piling on a load
> of extra complexity to have multiple confusingly-overlapping-but-different
> ways of doing the same thing, one of which is still the exact same one
> you've decided to object to because you've failed to understand it (as
> demonstrated by the commit message below, the obvious bug in the hideous
> mess below that, and at a glance the other patches actively *breaking* at
> least one driver.)

It is hard to take you seriously with such vauge objections
Robin. Please try to be constructive. If you are specific I'll go fix
the things and maybe other people besides you can understand this
stuff.

I'm shocked you disagree with the core code helping the drivers find
their iommu_driver. This seems like very basic obvious good stuff. We
don't need all sorts of different open coded ugly ways for drivers to
do this. It removes 200 lines of junk for drivers :\

> > +			iommu = fwspec_iommu->ops->probe_device(dev);
> > +			if (IS_ERR(iommu))
> > +				return PTR_ERR(iommu);
> > +			if (WARN_ON(iommu != fwspec_iommu)) {

This is at least one typo.

Jason
