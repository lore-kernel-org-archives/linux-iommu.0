Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23407AD27
	for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 17:44:34 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso2208428wmp.4
        for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 09:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABAymivtzLVXmfabanq8IH08mxiGWPYpwC0ephBRLG0=;
        b=gYU+7Unrce8q6rrCpIL/B0cnvipjfJwjoXnHA9enfaMCXALHoxu4g4kz0BM5G2JS7J
         fLIUujLpCOSHfGfG1Bp+Izyc3f+noF01kkC5p0fn67OvuBkRCQTQFXqRb8/r0luGyMlD
         Kc1hsFRIp31Ub0PKsVVt9JaCEg5zGMmNzOj6qxgQv6gsyL7jdfak5GS5g2fdXpZFAawC
         POeLstnKr7hp3IT6ri1DJX5xz4c3sdRgm1MlzlW7Sz37lG88eE2Oz2ecqQi8YXJcTJae
         rq6zDjiQM7h5jd9LlprSBTr834/ey4zelWSss+JKqM40BAXa5NugKuVbEHBpPIJ7DeJT
         ZevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABAymivtzLVXmfabanq8IH08mxiGWPYpwC0ephBRLG0=;
        b=G7/K+JjjGBTAWWQ09/YuCqw/4P7r+PjgmtgSBBYWtYfRrlOGrQcJvFzLfKFSsvJkTg
         zidwafHlAjmDCWZgoP+7gN0bhNixBxc1YcjNFPY/4bO3m7nWjWSkS04zcnGCnpk2Mox3
         i1jiZ7N36sNzTMmcvT/euisk4ySa72rJAU511HWbs8LRcEZPUt42uaTUfJJDF9M2XYBN
         epy2oSrW6MaaJcEWDbps46MDYcKOJTqVnQEUfusKWc6RdYfmKndG82SBlVPsC5+cmbyf
         vpzM+AbOlQF75pVs+MQGNFLCYsajZ7xCpMOuhca6VfeQfq9KtSAQI24+TmUR2QfqO/jD
         Velw==
X-Gm-Message-State: AO0yUKUG1n3twYCp+jG4r761Efg+DEo5niHBUAdJpTzhUfk1cc73/pjF
	ZrZL5WKQLNNVDig3CDAb/WaLfA==
X-Google-Smtp-Source: AK7set+UVe9jwKR4MXwkj0n/p9aOAlU1m0yXD7Hn0JW6PRPP8wNnTUvpeXbNeJeOiHs/Emw541fz2g==
X-Received: by 2002:a05:600c:3b1b:b0:3df:eda1:439c with SMTP id m27-20020a05600c3b1b00b003dfeda1439cmr401643wms.11.1677260672271;
        Fri, 24 Feb 2023 09:44:32 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id x8-20020a1c7c08000000b003dc4baaedd3sm3267078wmc.37.2023.02.24.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 09:44:31 -0800 (PST)
Date: Fri, 24 Feb 2023 17:44:32 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 2/3] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <Y/j3gO1GsqS6svhO@myrica>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
 <20230214064414.1038058-3-jacob.jun.pan@linux.intel.com>
 <Y+tW3kxFeOMcELww@myrica>
 <20230215133651.776a1553@jacob-builder>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215133651.776a1553@jacob-builder>

On Wed, Feb 15, 2023 at 01:36:51PM -0800, Jacob Pan wrote:
> > > -	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> > > -	if (!pasid_valid(pasid))
> > > -		ret = -ENOMEM;
> > > -	else
> > > -		mm_pasid_set(mm, pasid);
> > > +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > > GFP_KERNEL);
> > > +	if (ret < min)  
> > 
> > Just check ret < 0
> yes, but i thought < min is safe too. 

It is, but 'ret < 0' is the standard used everywhere else. So someone
reading this code will stop and spend time trying to figure out why this
isn't 'ret < 0', wonder what's special here, inspect the ida_alloc_range()
doc, etc. No big deal, but I think it's unnecessary.

Thanks,
Jean
