Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301C437136
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600929; cv=none; b=UXRc1+o5kXGyU1stYTdL8m1PPA1NJDDG/5a/KsTSxULay44M/cK3fiaJ9lNoSN/H9REN0C/fQbeJX1fpandgVKuRXvRMOzbE3ws69Lx3MMC7YuYlbIJKpMsSctTUcL4kWJtBRO58tvbAbW6M458eS5c+u6blPehSMDIYbBBsDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600929; c=relaxed/simple;
	bh=HMf8sz6h2dnybYBuZGK7jThBHP4dhPBd75prPtkOxHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DopcPhFDT9+5r41Zw3Lt2xYJHXPbjkzXZJhS8eBT7GGhiR1bHOE68xQd/gu3IcoHpEdy80+hMAvPziFgsSNJh0wlGCB0C/4SAB+9LFlGhxmlqqyUTB4s1LpImrBzHjjRuLM4zxAB8V4aSzneMO/bvz/fuKjkgPIYu5yjYsMHAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nmeQv4Xu; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nmeQv4Xu"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-67534eb4effso1056336d50.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790600926; x=1791205726; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HMf8sz6h2dnybYBuZGK7jThBHP4dhPBd75prPtkOxHo=;
        b=nmeQv4XufmXnn1j5MhSDVCgfCe4BLrrF+MoaD5jdIAe++Gq0a7AQkRHlryX+kE0f5F
         dlkJ2md9C1E/Ipfr4wHJgqw4Qz1dVvEUKl1BDkwGBves8+HUSsk6AqxzCNLmxaQSkK4r
         llPtHCQA1oXnFb5xKdbynPU/RsHitb7r6Po89MEb/wvdEmHuZ6CbX3da2Sd5dvkdr1Yz
         6b0PEKUGn9DpJmn41V9nJDOmdTwIfZVUlPrfDZc5F+Uv9hukfqZqEg6jroUjocPRkqrG
         AjWkXIBQjZbVpB4UDeB+Ls3gI7wcDTOp91WREFaBux38LSpjreVNj9WINTsYd/4J+SOX
         YqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790600926; x=1791205726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HMf8sz6h2dnybYBuZGK7jThBHP4dhPBd75prPtkOxHo=;
        b=1PcBSHF2LWwpxpX6uIsztsGtOkDzls/cjD8pkj+2KTnN51A2A5k6TxyxU8TWbqHe+K
         uYAAwFzn6ahlKz9sRkcTxOy0tcZ4m64DChbluUIpcI0MUMHjfX7zJlBx2r55f6pJ+/4n
         flMOMLjYWXjehUqhhOtvm9fv5eoEdR9Khy1aVONPjj9eozCiCwrViR0NJGlH0IcK9EZD
         SK2K+YDfy7piiEW8RF8PO3VsHMST9ruZ/B7HQV0R5Rxwp8x6oot434eHHzh00NzKv5BD
         tFkMxIREPX520KiU4zQQJcaCO61VFmZVP2qmH9Za7gNwC2CqE3PBV5jOx9nUGYHVwRG7
         mrUQ==
X-Forwarded-Encrypted: i=1; AKwUvByecxuiQFgpj65AR/IGD9b6V+RvInxh9JlKWVTC2SZo1z8FcsHMuHcJAfwvc/GRCaNK8kPEHw==@lists.linux.dev
X-Gm-Message-State: AFuF++nsruRZ4+4C1wMRaULg/bNqnsuSGwBPttYTsAle3/2I2w/VNkDV
	hfn8OFuOQhzbSwn57nypsRBx0Y4xvBso2H+tG/fEG6AbcXWz/VPFt1xrpkvawKt/LVM=
X-Gm-Gg: AYBFou2SzSMy5hHIIpIxLKBGxIRnMJ74YppzlUxhtbjRx9hg75TeL9F8xDlbGkkIz5J
	j77KOVtLpTYYbaQlzK8JC+VTFhAmFll+LV852p4U1edhhOVJ9ZaCGR+qSFZfMJXkXZYZm5dqA9Z
	o49b6+YIOid10gWzg7wcQQo+oEpl259fAbcdauuD2/1G4Tz3ssDReq+FU++qEEtFjlD6OFf8fZ0
	7w36GqoEnw3PqydWtTbZvJC+/omjvxucCTTP/XTm1EReV/C4ovivdvKIAA2IcTNPYY1VW9sRJQT
	Ooj4yuEbOJWYXYXCDil5uOqTFlEDzstKNZSGO0K9zuyoPMUGpI4+nYylz8AmFWm9RLo/XEahmyd
	VnnjZnZVy2q/Ut3dYyrJfve4hvowqV9+jEtIBBIDG+t+oZFyf951fjacsqcePn0j5IWILa1VK2u
	N7aWGxaZ5+wFmWWnk5QimmZKcHx0pxdstxjmcfT+gW9aGK
X-Received: by 2002:a05:690e:128c:b0:675:40e7:8e58 with SMTP id 956f58d0204a3-67540e7c5aamr1608190d50.20.1790600926197;
        Mon, 28 Sep 2026 06:08:46 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ef28dfasm4604200d50.11.2026.09.28.06.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:08:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xBB63-00000006mlN-3bcU;
	Mon, 28 Sep 2026 10:08:43 -0300
Date: Mon, 28 Sep 2026 10:08:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Message-ID: <20260928130843.GH163130@ziepe.ca>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <CO1PR11MB48358E3116CC6CF34E6437658C812@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260924192054.GA16465@ziepe.ca>
 <SA2PR11MB484477E4875E71E4C78854A18C8D2@SA2PR11MB4844.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA2PR11MB484477E4875E71E4C78854A18C8D2@SA2PR11MB4844.namprd11.prod.outlook.com>

On Mon, Sep 28, 2026 at 03:35:29AM +0000, Tian, Kevin wrote:

> Looks there are some resource shared between the untrust and
> trust invalidation paths, as iommu->qi->q_lock is also acquired
> in the trust path. I still need to understand the motivation behind,
> but this can be resolved properly by exporting a helper to the
> TSM driver even if it's truly required.

That seems a bit suspicious from a security POV.. The secure side
shouldn't be sharing anything like this with the insecure side, that's
just inviting invalidation integrity attacks???

Jason
