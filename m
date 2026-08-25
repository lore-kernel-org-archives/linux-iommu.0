Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9F383C83
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654076; cv=none; b=IJVYrLQIdWHjXSr+dfdianzFyy5u3dcYydZMBpyibuNglDMYnJI4F7HaK9sMr8v7rJZHbyNPnILDMgIIOHXtN1RCQfHfAjqIBLDoEr9DseDhmhshl4I/b1uQrfu3eUPHiOsLPg/8nsBeWU+dxDjFR80IpcnHsHMnVqpvnIAPxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654076; c=relaxed/simple;
	bh=O+P3xJqQ2iemp3Ulde4Fu2+lem2DE6IjQORZXOXh08Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN5WAQmz35YZqIyri+eb/c6M50ss9OWe03mdnsBynb+pTMZtYrQUbhXaC641tIMVFTSTukXvLFiTrXcMULTJ7AeU/pcWjqCBbJs7GFHXRiAIJj891vHUrUnjTVapxP7XUPg8jn+8oY96fLhgJaEOkYkSMdqneKzO+zu0eCU9PW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nhert8On; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nhert8On"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d3b440b97aso78705ad.1
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 03:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787654075; x=1788258875; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3I7M6+VDRcRqN+go+MtLjnMG5u02OBvW+7qZt2cSYZg=;
        b=Nhert8On7L3uz7O07S7wc/ZtQkXUCNsQ4PTSJ/dtLy6tOTVcuKzyI9KKGZr0Go1nWM
         QMpY6BchGdmIP2ZsC2SMpWE2U+UYoPWy9FVJivELYgFQSsqHmOYlir3Zjd1TqbcBHpIb
         2tkPJZ/Zxe44l1RMiGToCp7bQO5rScvFyPYeLCbhKjfyKF15xARgFb9Iits7gNHHg1rj
         Cgm5MlfCaJrvMYgTsH/A6jx8uvMw5G3aYfOnHmRcAr1S9byFgCcsqoOsLxWdIlLj6NJ+
         QygmptEoG603IFozeUwCYQSD0EuxsNB0yFKh9Ny6njh85J2DJ221jJ8M/lJGY0t7BVPf
         ZfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654075; x=1788258875;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3I7M6+VDRcRqN+go+MtLjnMG5u02OBvW+7qZt2cSYZg=;
        b=NWk7y/UG18mRpnLO97gWuES+EMhSGrOQ9qSx2kPzL1dVAPEK3aPuq6DPJ6wKudsD6k
         6bynqZVtWgione4Argcga1p0IltHWxmbwJkhmBYXZ8hvQcEI16ly06UHUSRRybJ1m1Sv
         cod8a6E9N4Vs3ftek4QVcnZnCJMIicUFI3jp3f2k1dda4eRPDuTnZ1uOyuGKDAfGfgHh
         bHafUOjaU8Col5882RSp0dPYmGSZHKtPQeDe87xEy2a72s92A+qF9h4buZ+mZGof9gvN
         S5Q516/qyldZl3dlgKwxX3cXRNPYLiAUrLiPESd9HJ9pm5oFfxZBtVY4kqTrFYW3oodu
         7FyQ==
X-Gm-Message-State: AFuF++lUCdI+mqWJeNQhwoSgaybWFQTTxllvS39L0SoCOlmaUIC6UuVg
	RLz5zkMTf/TTAWUA1Qnykwesg0pZ68t3oIocP4B3I0rK2EO8QzxMHhBHOzxRgv1/ig==
X-Gm-Gg: AR+sD11bDGjQGjCCJWrUI8QwPoe3NdpSvIho4InsBIZ4+HEr5smqDqYmLKIxkkV8QtD
	rtDsbANSv74VWE2QSfNhUw1Uj53v9BrYsvLrA06leJRpZV/9fNj3AQt5SwmCyp/xYNyFMn+U/yW
	1IShXxnS6+PwZkF+l+DADdncbd0heifM4O+aDvvPjy7ig9mNoXpGWlR6kOGAwMJsok0trcdR9Fx
	vHh36+FuDtRiYOcnypPiRNU+R5bFF9J5ITdN9t/G9hJ3dw2myMlfPhqe+DJ49j18tJ8jJztXlMe
	pjPsZN94Pjx7pnxAbe280Tq5z3gdsK+0sQQPSQnJbkJa1F7xpm334OBeXKFPfxRTiFU/Klgl7OJ
	NOZlvddL4mDcUHuZ6IRAK+dy4w0+oKG25IQOZ6WgmFdWDQQnQQIiVqvlRcP14Vm/XwyEyE7u9jA
	C9kZm/J4wJmfp2ASuS6kXv54/GVg1BXtv7jCL5kivNe733M0nQJ47DswrqCqCmZjAmozPN/3BQX
	hg1jqQt/Ja55sB0Fg0LtpTpNw==
X-Received: by 2002:a17:902:ef4c:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2d6f2f25ba2mr2769375ad.15.1787654074163;
        Tue, 25 Aug 2026 03:34:34 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d31e74sm3331799a91.11.2026.08.25.03.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:34:33 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:34:22 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] iommu/amd: Split probe error paths to preserve
 IRQ remapping
Message-ID: <ao1vrkp3b8n3U4xT@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-4-praan@google.com>
 <178759520117.3131778.6953869487486713121.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178759520117.3131778.6953869487486713121.b4-review@b4>

On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > [ ... 15 lines skipped ... ]
> > @@ -2540,8 +2540,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
> >  		ret = PTR_ERR(dev_data);
> >  		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
> >  		iommu_dev = ERR_PTR(ret);
> 
> I would drop this line and fix the return to have the ERR_PTR
> 
> > +err_deinit:
> > +	iommu_disable_device(iommu, dev);
> >  out_err:
> >  	return iommu_dev;
> 
> Otherwise this landmine is going to hurt someday since there is only
> one flow that would have an err ptr in iommu_dev.
> 

Ack. I'd refactor this.

Thanks,
Praan
