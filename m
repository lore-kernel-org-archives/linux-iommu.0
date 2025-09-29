Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093C21257F
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167794; cv=none; b=AXL3AelatW27YgEVqye2xx9/7mpzz30avDE5xeLZ1zHyuX3IMrNPL04ESdqhXa8wgYbw/GEhKrkRUt9mhhVKicyvTsvX2WItqrVoHnydWHKo9DBlxmKfpEfgALw4KJ530D6efYugwn8BUiBLGKDCG+TM0r8atuYghrN+9eyDlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167794; c=relaxed/simple;
	bh=3JVKtBMAMZZBZ5zOL9O8wIoDC8qOntu82iaKyXHAYrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBXAcYZC3TE7XRepjuVA3widlEct2ZgT11ACHXdRBs2sDSW4Rpd/B01qF75w8SgrkIWcYzgbQ/JaVbFqbmS63WJUPedzlnV4nAWgrsEc8VDb/ghSxz1XfkUB/SLKYodJcC+jEUsJ/fKfKOFAtSdjMGJ8Bcsf2R+a8h32RK8Eg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gg6tJ3aB; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gg6tJ3aB"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7ea50f94045so56944446d6.1
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759167792; x=1759772592; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hTb85gQ4f+/WEhJAyT+/KrdoEgjCXeB2waAEe62R8S0=;
        b=gg6tJ3aBDq4of1/9906RyPeLdpBJDeyBQQqWQhVSL9o01GucWk+OzR5PT1JFYOpVwx
         WgCGGdjZeSxgQXo65Eg389KH76r07f9ZxWOVRVeBBxS+ZVpXYFxaPfTgVN9+X/WUP+JU
         RYqSJrk/XYS7oQ7XhPjIPqmZYtNr2plKhEDUB9A10fSyn2FyISISiRCJY9JfPlxJ0jkf
         myAVmzExl51yQWR9pLvbObgbLUJkb7fFMHtIZC87jDfAb9BpumTMWjezVtLHBZHdM+V7
         MUQzf2KJkN/VSeTf0/McoioY4CAC4dUXVUAXEIU5iKmM+4kJCCFfN1b8KRJsMe6/XPRK
         EGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167792; x=1759772592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTb85gQ4f+/WEhJAyT+/KrdoEgjCXeB2waAEe62R8S0=;
        b=SNavmUXk8n967RuT5d7RupvpX+ZWF1r+8SYXwqgxmIae/6UNmVQclvlJYnTjgBkstc
         FQ0kDRxEm8L0Pww+fYJz3UUdrvTnu9h9Po7bK7KYuyVzD89jBJo8DmrakAAXJUjkx9zL
         +rM195tCJ0alQZYsC50G+Sq+PxV04lsmbn0IHNavFuHTyKIsM2ME1erz5rhntcL948Ic
         q+lcMjs86/7Es6VLjWjieOPHjuWPUpbEfclC50lDlVEhm3+a7/CXVKZlMDfIqHjOXSA/
         ZCxZ3U9BaaRiYdY71Y7ylmfFxZCZqmDjNZ75mG1i17a3yw2g8FWATGJ9UKcD5SwQgz/g
         hMrw==
X-Forwarded-Encrypted: i=1; AJvYcCW8xzVlve55NZxXVOHrulU/ETbc0aLbOns6tA1ranNQLGyK7NRuFUs5SA6NpjLPQVG3HLZf7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgLpcOTr7QWs0s9RrRL1rHmVYbgR1gkYHQfYBEZW12OfILlhnP
	zsQ9/K7KL5a96g7EsUEP9oYXqPMB5NqgW00SkdAN/jTAVwf5PoM/SMisvErt7CogLmQ=
X-Gm-Gg: ASbGnctUazW1h1gtiV9oYKoOgHHyrcIXESIxmciQjfPRhzn1MEJampWyPoJ7QiDbKWo
	VAhEOZwP/8OygxYTE62UJXAp0t1HT2u6A1A0IGoodeqQp01NDhiet3Hr2Q7botMW4sVCktVYnhM
	Rgo/mBUA03iUCVra2rLV5rBKeHfvjRbnmq2XNgoAiNr+iTznBW0NYYpWGj24tCmDCF45Cs0zoc3
	MiQSVn3B7AjyWYHwfrRqX1sry3tC2B2QQP+yJi74TSbMc7Hk9Jlbq77cqVbndT6lERq0tHiBD54
	DhpzwPk4/5KfIOMJCUeU+Odmd5ZNEOwJ3FxjSjPeeluv7vwznUNcqx0i3PQw8+kTlhgHtuv+
X-Google-Smtp-Source: AGHT+IFOpDHOnY9/ayuIhdieudSUU/wr+o55Uc1egUgLHoDjxTPuM7/x4vrcjFQx2LaetA0cp5o9Sw==
X-Received: by 2002:a05:6214:ac1:b0:796:e048:ee97 with SMTP id 6a1803df08f44-869973a161fmr20467686d6.19.1759167791682;
        Mon, 29 Sep 2025 10:43:11 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8013cdf31besm78947296d6.18.2025.09.29.10.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:43:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3Hu2-0000000CNjB-0ASr;
	Mon, 29 Sep 2025 14:43:10 -0300
Date: Mon, 29 Sep 2025 14:43:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20250929174310.GH2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CAAywjhS+X5o3B60hKZiioTCqT_7cYThRTz09fHmi4WnSr3ceYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhS+X5o3B60hKZiioTCqT_7cYThRTz09fHmi4WnSr3ceYA@mail.gmail.com>

On Mon, Sep 29, 2025 at 10:32:22AM -0700, Samiullah Khawaja wrote:
> On Mon, Sep 29, 2025 at 9:00 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> > > +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> > > +                          struct iommufd_lu *iommufd_lu)
> > > +{
> > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > +     struct iommufd_ioas *ioas = NULL;
> > > +     struct iommufd_object *obj;
> > > +     unsigned long index;
> > > +     int rc;
> > > +
> > > +     /* Iterate each ioas. */
> > > +     xa_for_each(&ictx->objects, index, obj) {
> > > +             if (obj->type != IOMMUFD_OBJ_IOAS)
> > > +                     continue;
> >
> > Wrong locking
> >
> > > +
> > > +             ioas = (struct iommufd_ioas *)obj;
> > > +             mutex_lock(&ioas->mutex);
> > > +
> > > +             /*
> > > +              * TODO: Iterate over each device of this iommufd and only save
> > > +              * hwpt/domain if the device is persisted.
> > > +              */
> > > +             list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_item) {
> > > +                     if (!hwpt_paging->common.domain)
> > > +                             continue;
> >
> > I don't think this should be automatic. The user should directly
> > serialize/unserialize HWPTs by ID.
> Interesting. So the user should be able to serialize/unserialize HWPTs
> before the Live Update PREPARE event? But what if a device was marked
> for preservation but the user never serialized the attached HWPT,
> would that be considered an error during LUO PREPARE or should iommufd
> serialize the remaining HWPTs here?

yes that would be an error

I also think your patch series is a bit upside down, you should
present the iommufd and core pieces first, then come with a driver
implementation last.

It will be easier to understand the context that having a driver
implementation appear out of no where with no callers..

And everything should be driven by iommufd in this step, the iommu
driver should not be magically auto-preserving itself. Just preserve
the drivers linked to devices being preserved by iommufd.

Jason
