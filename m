Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDD170853
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197863; cv=none; b=ifNPRBswGbQCZYdZG0JxR0c5CDEeaOoqsap8ueKM1KUPCT+ElWeYwn6YM+G3PISZtaiEeqqalnxGTfNWnunD/T+W6tTfaabKJxHBIorjSVepAO4QwD1SMV58gf5Nq0eYhqcC8X4BXLdBA2w+IbMUufGwvDGTLRaZ6If5j8+A+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197863; c=relaxed/simple;
	bh=65xpeURwcmOmVb9HhCKWlX4HTGmbshxZsViqDHmAa2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX9ePOgObk7orOrd4gQO8QoIJ7o4Ha0SlCYnN3vLuG9LGz5vsfu4jx7wG1DEBF5NdTGdXLbpe+fLdGwzCANJXDA5qNmCLzi1jDnH6hepjQVrinylDqb/W0ZyCZSR87+kRYMurD0kRfW4po5cbGERIJhkiHS6NUGvfXTZCpJzSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H+V8es7l; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H+V8es7l"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f9a7120d9dso1861520a34.0
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718197861; x=1718802661; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDxonTYHz9nxQaqpOoNfBlOFb36tO8nlEtyL7Ho8AwQ=;
        b=H+V8es7lFczBbe2NV56Yb7bs47I+DDeQMVZZFO0KN+iyXCwDFGe7iewHZ0abFVbhFf
         7eqNKsc2szCF0A811i70btR2cPnLTk5RwBDgBZ9nQeO/rkVQTgHndJ+Yb9JjmJsb0NCg
         AUKH2Qh+2Qou+X6UZoPm7YK4rzXC75tO6GoJvrsyLr088F7ewp70M8WCl4+wsbpftNIn
         SunH6jBhwWWe/mnM6ULRuBnNJX1CchrFQ65btCUpQIylhKMnXfImA6ZsQb23NT0zdGeq
         5sEOUR/zgT9XgbgxOzJFlSJSXiHHWPxTEEt6gkK7eZKDO0P0/j69AqiK+E/toQKa0aRL
         jkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197861; x=1718802661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDxonTYHz9nxQaqpOoNfBlOFb36tO8nlEtyL7Ho8AwQ=;
        b=TT7cWlKSPn8eW0N7bTqs8Wv0bJUK8Fdn7ulOxZMTiM/GWovfr0vyn57nY5ZGJBusJR
         TlOpRQ4hh5c5YnYWlhoqnknjiXXhG0QfK/fHCw3mg3Z0Y4vD5I7FBlqaufZGzKQeNiee
         649obwF/ATLEQdUvZxxcf3E1J5dP27Dr4OHm7PzfMET5SVliMpYM5zDAkZcd6bDVUVoJ
         vwW5zVHCtMyjju42eMEMPwvTUizOmJIOWejC5Ztda1hBa/MUQGUXL7svRmL5vmiPoi9x
         WbyLSvNo9gwXa5+fCPaWaHFqQgEvRTOyW73a510OQHS0j62BRrCuZun2LfO6cUD2cD7t
         SMVA==
X-Forwarded-Encrypted: i=1; AJvYcCV9lz+0DFOOklaREeEVjepafNGhl6WQfwYZFMOn5DJyFmBvCO2dsN0VGht8VRxQLmu9Kpgul4n2RHOAXeMs0Di9ZrP/m30=
X-Gm-Message-State: AOJu0YxzT1R0/5sM8yvCfdD+vek3DQPm+C5iszXulWdpbFrRDT+HQvta
	oxLZd/jXxYjwIR1pNF5vWpKFlQPCAgaSPZ28k8itRnVWPHIuLLi/qTCvdeKrQ44=
X-Google-Smtp-Source: AGHT+IGl8HcoadNuoHnllo+K1b1rGMd1ZFrjzpRpn566P4vS2gHW66FG2Ie4jvGYbR3pikDM/mmSHg==
X-Received: by 2002:a05:6830:1e04:b0:6f9:b580:e420 with SMTP id 46e09a7af769-6fa1c43951emr1549072a34.37.1718197861362;
        Wed, 12 Jun 2024 06:11:01 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954f6f337dsm444526785a.42.2024.06.12.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:11:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNkh-008pLb-LU;
	Wed, 12 Jun 2024 10:10:59 -0300
Date: Wed, 12 Jun 2024 10:10:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 01/10] iommu: Introduce domain attachment handle
Message-ID: <20240612131059.GS791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767B3B1F441D9AA656AC258CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ae7c05b0-104e-4c71-99aa-fed2a4f209fb@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7c05b0-104e-4c71-99aa-fed2a4f209fb@linux.intel.com>

On Thu, Jun 06, 2024 at 01:33:29PM +0800, Baolu Lu wrote:

> > But if certain path (other than iopf) in the iommu core needs to know
> > the exact domain pointer then this change breaks it.
> 
> The iommu core should not fetch the domain pointer in paths other than
> attach/detach/replace. There is currently no reference counter for an
> iommu domain, hence fetching the domain for other purposes will
> potentially lead to a use-after-free issue.

If you are doing this then we should get rid of
iommu_get_domain_for_dev_pasid, and always return the handle
there. Making it clear that all those flows require handles to work.

But is this really OK? What happened to the patch fixing the error
unwind in attach_pasid? Doesn't it always need the domain to undo a
failed attach?

Jason
