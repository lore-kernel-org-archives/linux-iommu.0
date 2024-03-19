Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A023772
	for <iommu@lists.linux.dev>; Tue, 19 Mar 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871015; cv=none; b=lqybDpNTZ8P3rLMO6o+flxMccgpShawQJ+ijeQgcDYwGJ9fRKZ1iAXQMryNf8KCRhohIE3B9TAmaXUqlOpCB6GBV43RRB+8YAAZiXBroWi7+1SQffytsAFiKSHFx/sUR+bJUVMK85aEJhexTkfSlvMr4MePenoUOnzLwMA2Tclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871015; c=relaxed/simple;
	bh=Cch9o7Gk1SqJ+If6+jt5UhMxS4LJaeDxObqxAPeFdss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl9Ym8t5fMxZgWvBOUdOMMAk0rARCqQTgUJy58I9UMhtYrsEHq1IFRQxCFgwWt+Ks9s6t5tbUGM9XKcND4XcwZ7p4sg9I7xvlxVFYkGcyjHY9yocUXkcUCmEiF7CFibBiUq1RlU2M+cz/+XXJSVt4rntgjs1CZjUb91Y1VMv5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=A+NQ1yrS; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A+NQ1yrS"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-222a7703048so1747651fac.1
        for <iommu@lists.linux.dev>; Tue, 19 Mar 2024 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1710871013; x=1711475813; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofmg0N+N+DdhcuwIhM9EjHN8YJy6VZ+aELTHRG55pC0=;
        b=A+NQ1yrStYPoPMp332QQMSvDhfd4xT+DT48gCM607TTLOt/Djcu47ln6Vv2kyDzaoy
         u8LbSaCNbmzWe1eSOhdxELoGwPMTAAsKRkfZJzWCqOW7vk4/IhSPvHJxTks6+n61VB9v
         COh9PKZL9VIpk4HJkKERSo6R7Btr3CfbHdyxtbcBNiPUrjcUKRzQaYl/y7T5Ze8W3zF6
         +yvFnLp7INq+FFIQQjP2mzfiZwoTNdJL7VBB/2Hf9wvj8X22CG299N20PESm6eN95VEW
         mcTWB5ubemB1lHqdDh4Z2fHNGFCJhyMaqgvQU8MEjgbbIRn2noQCagzzAZYRxep8i3Ga
         zjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871013; x=1711475813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofmg0N+N+DdhcuwIhM9EjHN8YJy6VZ+aELTHRG55pC0=;
        b=OQxGUkr2MOc48OFZzki5xh6UQWYg22CvZaV+78cjmt2VD/3uRFcJn3Sbb6FV7m7Gj3
         Y0Jv2Z/pas1RMGvws9bOcEujC7mm+Fx58Kd+Mdw3K8zH3N6SdZKfmd/ax5sTNjy/OAw0
         MOz/Y4mEtAb7GOrTfFXm4C17ayTPrR6/jN533y9FlD6zePy61SRzSbCc7Fzuo+EDjt1F
         M9oNFwheFO4ysXMCBhDHOd5+iDdlBbuNDSSjoEfAHes05Uud3N1nIXYzhi3hmLrhZ+Wm
         ry3DPfhjb7PPxUWBNqGz/fKTEbOjDLEwir/iFtjb10hBpcl9JVFim2CyOGCDGzHSqVoO
         +yDw==
X-Gm-Message-State: AOJu0Ywtp4n+ZOgJjC5KBkIcUHRXs6K5XbWqz0lrIIbLv7CFKjwX/Zvp
	1Y+vOAr7fjjQZF+RwMvONTVauiigr1UZ8TE4xjBAR0bHl4pSu/F9eQCLyfpFIV8=
X-Google-Smtp-Source: AGHT+IErAExxlGmB/qgDRnNwu4t9eHEBPG4EXbO93axFrljD1IW40rD5rj0iXMETKe17p0dYOuxV6A==
X-Received: by 2002:a05:6871:289b:b0:221:c8a9:563d with SMTP id bq27-20020a056871289b00b00221c8a9563dmr15533779oac.3.1710871013228;
        Tue, 19 Mar 2024 10:56:53 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id i24-20020a02c618000000b00477229b9381sm3017032jan.116.2024.03.19.10.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:56:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rmdhi-001lBv-Gr;
	Tue, 19 Mar 2024 14:56:50 -0300
Date: Tue, 19 Mar 2024 14:56:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 13/15] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <20240319175650.GE66976@ziepe.ca>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-14-vasant.hegde@amd.com>
 <20240305005053.GH9225@ziepe.ca>
 <0ee69ffa-564f-c298-2a66-b4d7d4440856@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ee69ffa-564f-c298-2a66-b4d7d4440856@amd.com>

On Mon, Mar 11, 2024 at 04:41:51PM +0530, Vasant Hegde wrote:

> >> +	/* Setup GCR3 table */
> >> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
> >> +				 iommu_virt_to_phys(domain->mm->pgd));
> >> +	if (ret) {
> >> +		kfree(pdom_dev_data);
> >> +		goto out_unlock;
> > 
> > BTW, I'm not confident in any of the error unwinds around command
> > execution failure. The sync failed, it doesn't mean the HW didn't
> > already load the new CD table entry. The driver is basically totally
> > wrecked at this point as it can't assume the new entry hasn't been
> > read and it can't assume the old entry is flushed out. :|
> 
> Yep. This is tricky path.
> 
> But for now this particular one just adding PASID to GCR3 table. So if we enter
> error path means we didn't add PASID to gcr3 table. So it should work fine.

Not quite. The HW could have cached the new GCR3 table entry even
though the invalidation failed.

So on the failure path you have to assume the HW is still using the
GCR3 which the failure path is busy freeing..

There is no way to make this work right. Either kill the kernel on
invalidate failures (ie try forever) or assume that the HW will
eventually become consistent and continue forward..

Jason
