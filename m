Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E05A44
	for <iommu@lists.linux.dev>; Thu,  9 Nov 2023 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pXJAPaeJ"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so153557fac.0
        for <iommu@lists.linux.dev>; Wed, 08 Nov 2023 16:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699489986; x=1700094786; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpvSVpOIuoICwr0eisYk7Xi99IWTfuOr8GvS2fUSAq4=;
        b=pXJAPaeJDDjcGQnyeAHHKYgGXQ3hl04Awa4R+MV+vuLspfuHktbarxnJTRBMAOf3/+
         Xl1CnCmAfCFQhYFDnaxt7v1D9meZF5kbDwWNCFZosBHjBoz0DVU902h7znnqD9a1sOfN
         9j4DbASjBrgUsvLCGLD3Nnxksne3TE8L8zBt2NZhMg6A2j9iRBNoxk4vGiYW7unaPVce
         HbaJfrVeMxX7Qdys4aPVIXsdKIdAAwEDN03V+nxRx47D1fuoLyoFXTZPLn3gB0p7Djvb
         iCv2hj1F/1tj/8k+01OZITkajwS0/46jaWuG11hhGMIdg/kShY2hXkbKE9CrAxyw1RqV
         Mi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699489986; x=1700094786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpvSVpOIuoICwr0eisYk7Xi99IWTfuOr8GvS2fUSAq4=;
        b=E6l2ZlJ3OA7Of1oOp2UE/XJNIGp//6XsqajxsgrcZNOeAjxnw1+78VVijJHGxIzAeP
         Un1omd9uBsFYGzaEUwcFCVeYXP6Zuudr0dFk3GnbiX5YzEhm3VjE11XorwlCJ6r7sUnX
         03456h0jfdslsnzHxj+UGmpFXOyC7Ri5e8Is3awinPVX3TzMsJKoBmJyTDglCdbv265P
         wJzli+OlmrPgpnPiYQOpLFSjHvk/A9a4gWtcUW7Y1wKxeoj6+EwM5ESNSjYgCLeTfLcC
         f5U6hCWmUw3HgE5wC8c1O6u5K3KLl59752WqeWKtSo4KgE0Tld0ZNVhzszEtgubYHp2v
         HbJQ==
X-Gm-Message-State: AOJu0Yxo7cL6Gszntc5+Q+tntpyezgBueG1Rjz8n4rUScHnJbGYpQAUQ
	8J8Wo8icN5I7EF/yxwt574mKvg==
X-Google-Smtp-Source: AGHT+IF96nOKOaNh89TNNrC8DvAIA42Xn4IPrYpq+5CGXZoyWBXuWbQokFnyps+CZE1BYCDOJhxJVg==
X-Received: by 2002:a05:6870:1290:b0:1f0:36b6:ef26 with SMTP id 16-20020a056870129000b001f036b6ef26mr3049223oal.46.1699489986633;
        Wed, 08 Nov 2023 16:33:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id ki14-20020a056871bcce00b001eb7196de06sm508956oac.54.2023.11.08.16.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 16:33:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r0sym-001jjD-8L;
	Wed, 08 Nov 2023 20:33:04 -0400
Date: Wed, 8 Nov 2023 20:33:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] iommu/vt-d: Add generic IO page table support
Message-ID: <20231109003304.GG4634@ziepe.ca>
References: <20231106071226.9656-1-tina.zhang@intel.com>
 <20231106071226.9656-3-tina.zhang@intel.com>
 <20231106193228.GU4634@ziepe.ca>
 <MW5PR11MB5881FC3D9DBF14D6BD07025489AFA@MW5PR11MB5881.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5881FC3D9DBF14D6BD07025489AFA@MW5PR11MB5881.namprd11.prod.outlook.com>

On Thu, Nov 09, 2023 at 12:10:59AM +0000, Zhang, Tina wrote:

> > If this is going to happen can we also convert vt-d to actually use the io page
> > table stuff directly and shuffle the code around so it is structured like the rest of
> > the io page table implementations?

> Converting VT-d driver to use io page table involves much code
> change. I made a local version of it, and it didn't prove much
> benefit.

Well, it structures the code in a similar way to all the other
drivers, though I admit to having not looked closely at the io page
table stuff.
 
> VT-d only supports one 1st-stage IO pgtable format and one 2nd-stage
> IO pgtable format. So, the current IO pgtable handling operations
> seems more efficient comparing to adding another layer callbacks in
> them.

I would like to de-virtualize those callbacks, is is completely
pointless when we have per-format iommu_domain ops now.

Jason
