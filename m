Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B617DE22
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198736; cv=none; b=nBOoXvniSlGaOlrHm186O/YTYF92mZN75jHnrAS6axpPaBAh5OIqsSMyAGf1CQoQLxW6/oO0fFAmvmzgX76ufASLQVZLptGrZUqYnXhb5vvGo2ZoLgoPobfquXzfzzDvS6ZsJkBEkXFmrWagYj1uDoh/zMB3kA8G0BL4TAJGbiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198736; c=relaxed/simple;
	bh=5r7kTei3l3CsdNg/q8RBiLmWZ032Se1UCEEyvhJU1a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaXzAb1e9ZRSMV0+v2etCqOjN+jwUdZq1B1KSL0o7Ha6zvU3VTNHWU2rcEs3tRpZCio3AgPPSBQ+jEkiHTPcFHAu1vWTbue6JvxDuKvRN4z8l6RoZs7qw3GKZci+2YuAw/vzwpfOTfY/sGWmZue1MJJxB6SMbWbKyuC4gOAZRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aZ07XtAr; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aZ07XtAr"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-440608f5ce4so19905791cf.2
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718198733; x=1718803533; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUSqpmX+ejk/HnC4nbAm5rQmmAITtEvd4QugKxTCvc0=;
        b=aZ07XtAr6jjfcNCLAY30dzkp2rPeOSbmEtWPNcO6ul56sxNi7/0a8TYLKp1id89MLN
         tffegmAqhln0Teb9z2rdB38+DCTLId/E0QQg8ioH38FAi+MsYze7Ww0Tb8EhQg6u8Lz0
         nQyn4HImw1fRP66XodD1wndjIG4mJbwkXF+UfJoqvUj3vrAaV3+XE4dQ4+9aifpcksgf
         jngVufyQiNdlcO4vmWj5UrrdUE6sWhfmuMzhRepo9lp/zRmWUIvOOzcKMOObeYnxTcQS
         MfTVgdcfoQTCxEr5n6Ktiy5TcN+agiY3q3dpzLABsQs8yxDH+ZHSpOlwlhbS4trqs0mu
         q6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198733; x=1718803533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUSqpmX+ejk/HnC4nbAm5rQmmAITtEvd4QugKxTCvc0=;
        b=OhfZiF9i+mTh6GuSSbMLzTtpOAJg9llkRs+H8oeoaQ0n4DGQtJf087mtoz/ixQxBBz
         iiQF/eN3+6U+x48Mc5j+x0ZB4hL4uiDj2RYSlRDfR4bJ9x86D6gkoGV4Wsn+UfoBxGXj
         S0KAACA1umIHdd/2XSaDMMENnEJHiFSwwoJqdRk+s5M10zUKvXezfcVu7TZOF3EmYIMI
         oLHzRwbWg02d9sI7Iqq74XJdkrPIwsHADU2/00D8eXw9O56ncDsubmVtZuhqajSyTz7C
         /+EiNXhUZe8Y3smHA3VDqp0qZZiSfDiFytySVUE9Sh+a0pbxvdHLpQksSLEk/tbVpa0Y
         XmeA==
X-Forwarded-Encrypted: i=1; AJvYcCU5NuJDSWW/A9mFgc4OEA/y+APAEy5mZVE7IaA9c7DLXolBUWWKGd9FdMgSszkBCJkafvgnfuiFAoL2juUxB144+rtkzlA=
X-Gm-Message-State: AOJu0YwylX5Yd4rmk9FQGomyOrm98QL6y1HL4aPD1nQfJPPPVzRaruz8
	5gtDu72P2JQXARE0FJ0d+OTfBPvSvnLIaevaz/iv+0hV2xHN5NQKajb8Cj8er08=
X-Google-Smtp-Source: AGHT+IEaSleQ5/4nSB1kEi3YoGwZTAao8TntM14Myn/eVd0unCfawvyN6q3ByV4cJt9BsHj66DtLGg==
X-Received: by 2002:ac8:5d92:0:b0:441:37b:cd68 with SMTP id d75a77b69052e-4415abd5a8emr18860231cf.25.1718198733475;
        Wed, 12 Jun 2024 06:25:33 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440542e98f8sm42778781cf.18.2024.06.12.06.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:25:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNyl-008tWb-7f;
	Wed, 12 Jun 2024 10:25:31 -0300
Date: Wed, 12 Jun 2024 10:25:31 -0300
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
Subject: Re: [PATCH v6 06/10] iommufd: Add iommufd fault object
Message-ID: <20240612132531.GV791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-7-baolu.lu@linux.intel.com>
 <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a17113d3-500e-45ef-a2d2-747d890c9c5e@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a17113d3-500e-45ef-a2d2-747d890c9c5e@linux.intel.com>

On Sat, Jun 08, 2024 at 05:58:34PM +0800, Baolu Lu wrote:

> > > +static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
> > > +{
> > > +	struct iommufd_fault *fault = filep->private_data;
> > > +
> > > +	iommufd_ctx_put(fault->ictx);
> > > +	refcount_dec(&fault->obj.users);
> > > +	return 0;


This is in the wrong order, dec users before ctx_put.

> > hmm this doesn't sound correct. the context and refcount are
> > acquired in iommufd_fault_alloc() but here they are reverted when
> > the fd is closed...
> 
> These two refcounts were requested when the fault object was installed
> to the fault FD.
> 
>        filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
>                                    fault, O_RDWR);
>         if (IS_ERR(filep)) {
>                 rc = PTR_ERR(filep);
>                 goto out_abort;
>         }
> 
>         refcount_inc(&fault->obj.users);
>         iommufd_ctx_get(fault->ictx);
>         fault->filep = filep;
> 
> These refcounts must then be released when the FD is released.

Yes

The ctx refcount is to avoid destroying the ctx FD, which can't work,
while the fault FD has an object pinned. This is also why the above
order is backwards.

Jason
