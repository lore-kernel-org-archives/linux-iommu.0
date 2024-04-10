Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8BD15B159
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764538; cv=none; b=Hh2fkA9sJjpqbUlXXnbJxZT7ZlxwNCfub23iEnNqG2o1wdo2x+eynuSUvRIgSZ0PM1TE6fw7r8zbHp60K1O6ZHM6z1BNWwCjXIWFjxgTxzqTZ9Ue96dXloXq8MDoldXGakq+OZr5jr2gjPT/55RY0aoZlVhbKudhNUjew8V4eDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764538; c=relaxed/simple;
	bh=YgnL7jcir981RH55ITpvaqSgvPK1CEMYZBReNU3yk2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep5Z8KYDSR6y2vWYbbSaNleBTpdjhQiWOnShkWQfFHp2Urj6c7g/raRrkEzpS0LNEPYFGXjmNn3bmoCMWcUX8Ou8Q6TTf9Auz/zbzWSM++5lHSBpkXH37YLZL0lLoejdJ8RlMOUeVStA+reLliL7ATEwDczym/r8t3Vm06xKObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OGdoi4x3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OGdoi4x3"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78d68c08df7so194993185a.2
        for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712764536; x=1713369336; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXUImnNxV09JBTgxvo4M2YuJDwI+AB7aa82NvkhuYtk=;
        b=OGdoi4x35NcBTp+NB8FxVozbwdh4Qso6tbMrKwQquFSDM6uv9YaQhndVATvi9PJMNP
         uH4QNraT0AqilnQoADJFeveHufUAabX/cjLU9uzLniFehBIme81r0Bj7x/Xw02LWVmAk
         Rs6W8mMG+JsFvt9l5GdpLkJGRdACHLDl2E4QXY4Q53gL3qGmSw9ks4cawEt0YdtOUTbs
         brotIKOxE4HKpSvNH3GKpdRgK7Cf+24Lb6UNwfG74xxGeEBOztfiEevSfqCwisUxU5M6
         7Y7J0qLtBGYG2ny9pRMY40ZX7dne8dCSDHrtDbcQ4SUL5QF1IiX/ddfxIiVot94tJKXm
         /DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764536; x=1713369336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXUImnNxV09JBTgxvo4M2YuJDwI+AB7aa82NvkhuYtk=;
        b=ZCI8/je+tGegmW2mPQZEzw3TFi8dukif3UoISWoPZS5O6/JhrCBCDvPRE8CTFA9l36
         SF8QnMLgD6su+7iLAuyKA7rXRyFPZTz3BCAmiF31KfrqZmZDqYvPbRw4mCIes5F9GGh+
         jxDSogE4cWLySXEFFMOTY3ygb/LXBZ5/MpEjpNTe0bT7OTtmci1ZaoX4u4bRy/x9ZMTv
         ohY4S0/7aSUvnvQonGGqri+LvwsXn2D/II8wEzgzFOCMtdTFQIWfL6ZHk5wPpqvO6QET
         lNaMGq1EtNeWkDd2I9l++NeDSyr+oHM1Wu0CNLNUmFOUhQuKgqmrv36/CVRce70Chi+g
         0/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU80wJq8A3/AgXYHLbf9DvTe4SuQR0JSMu9AcFa/OdHUrRw0ZpJTD9qfvLQy0azet4FXp18VXr1vezDg9nUrUwjVjdfdNI=
X-Gm-Message-State: AOJu0YwyxVQk83dLkeGmrjVH3kQCMA4+zLxPn8IBiqDdbHFOx09sw+vM
	jDCa7+nNYmrvqrqzhFt7X5tpJfByTNmOA2lXfJ9Nuo3vLFde9SXPmBXs38TNONQ=
X-Google-Smtp-Source: AGHT+IGnLTu8iKva5GUlMCiRXZBoEBA2BHf3PHT7xxCia8wpcTL3uQ+NzL/WcsUXgwErHK9GXqr3xA==
X-Received: by 2002:a05:6214:ca4:b0:69b:1930:6914 with SMTP id s4-20020a0562140ca400b0069b19306914mr2957329qvs.28.1712764536057;
        Wed, 10 Apr 2024 08:55:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id c8-20020a0cf2c8000000b00698f7eb9997sm5233380qvm.54.2024.04.10.08.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:55:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruaIR-008Fb1-2n;
	Wed, 10 Apr 2024 12:55:35 -0300
Date: Wed, 10 Apr 2024 12:55:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/12] iommu/vt-d: Use cache helpers in
 arch_invalidate_secondary_tlbs
Message-ID: <20240410155535.GI223006@ziepe.ca>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-10-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410020844.253535-10-baolu.lu@linux.intel.com>

On Wed, Apr 10, 2024 at 10:08:41AM +0800, Lu Baolu wrote:
>  /* Pages have been freed at this point */
>  static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>  					struct mm_struct *mm,
>  					unsigned long start, unsigned long end)
>  {
>  	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
> +	struct dmar_domain *domain = svm->domain;
>  
>  	if (start == 0 && end == -1UL) {

ULONG_MAX ideally.

> -		intel_flush_svm_all(svm);
> +		cache_tag_flush_all(domain);
>  		return;
>  	}
>  
> -	intel_flush_svm_range(svm, start,
> -			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0);
> +	cache_tag_flush_range(domain, start, end, 0);

Be mindful of the note from the ARM driver:

        /*
         * The mm_types defines vm_end as the first byte after the end address,
         * different from IOMMU subsystem using the last address of an address
         * range. So do a simple translation here by calculating size correctly.
         */
        size = end - start;

Given that the cache_tag_flush_range's are all tied directly to the
iommu gather API, this is probably missing a -1 though perhaps it does
not cause a functional problem here.

Jason
