Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1D3CEBB8
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847712; cv=none; b=AzXfEco70vPJMcVd8iBw30g1lQLtSXK6QJgOUNPC8CfJIWVqdGFbLgSHeHlVDH/rltAihQ2nVd8IBHAWmkZ/Z3U2X3cZJlKwgQ4DidjvrcQtSXDo+/sxwwZ3Yp4tyLJT/we7STtncx4QxLFOxe6lAThUxPoG7qk0ehRRsalVD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847712; c=relaxed/simple;
	bh=mAh3nAX3kL7MLxSzGqnmDDPsPCYD6Z7jzPbZ8dZAykg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAYSAzkHBAEmf2ixpA6hOnKtFTKTGRKO/XodyS9btYQgkje3l/8Nd4Damq0A9395uRqRElYFCHbi7lHf4Y0I31W8D9syr/EhKpk9vwWCFmG3B7jmLnpE0d4qoSvQoCTVW4L+z1SStXORa/6OJ/lF4vlL6agYErqgEegJX87r4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CLjw7yOP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CLjw7yOP"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c2a818fc4so537691cf.2
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787847710; x=1788452510; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yzfjA7QFnokR+rC2Mkf2GkJZ8x+lNdvBL5B9Dfcy6Vs=;
        b=CLjw7yOP5fcThUCB0kFII2h0H73mWdY7XnIY4iCLt5PUhySO5U2YBfujdnNwQmD8Os
         qqZRJTYjqixV6xGgTsma3dm4ueXzQQt5Mj//hKwpXvPek+3MpKxcfy2hkSKGpWIh4xhZ
         vgLvu4KZfYqeqxMkmI4HCxGJqVqHyfuoHmwW4Ncmmd0s55asmj/j9i7sAHYnU+GGu51S
         eTC/JdzMTlcLu9V9Cvu2n0qqsppL+A8rroIRtPa19upzlzISQ/DnZiSV0lWW+d+UBuOd
         yyncyjNiG/JVf41pcuNo+4AKAFioDzhsvdwC5YBC6SFa7iRWfDRMDzKqf2sB+b+FO8BE
         1NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847710; x=1788452510;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzfjA7QFnokR+rC2Mkf2GkJZ8x+lNdvBL5B9Dfcy6Vs=;
        b=eVXZqLsgtlcH5oTFmNYnBtw6z7u7yD5t8U4TyjvcZEuRz1rq8lHdJE3Jm0MQi+svpG
         pcY2A3uU/27WFhNegJTr/+DU1+OdBF/FkwGb9YbBtyc8E2am2StG8K2T8fP4hKR33oNi
         CcRTYP+pvAfNLfinNc048n52+c5+fKSrhNfbsJT1e2/5ekSUlgeaw6KlNtrXo6iaT1OQ
         smVm+/YemhVlVyqErmQPowZ7GUtsJqNoZiYKg1mHeJQRc3SFtgmPrlI7JVrA6/Stn//z
         kXx+aHXJOE3aiF5xs4U99cLJ3fRi4TGvW1wGsEqjfwdnee9Cb+vvw1yAYSSgAyc76Efs
         0n8Q==
X-Forwarded-Encrypted: i=1; AHgh+RofXgKGpDc3V+9AHj+nIFHLp37TDKog6HWzj3x2n1i99lqd7NEavrJ6bZs8NSGvF5aSzJaQ1A==@lists.linux.dev
X-Gm-Message-State: AFuF++mDAMv9lbgE6+GfybsE8loeKciONSbIEKwEJdb1VCGj9WM1qutK
	u+OLOWstZsxaLgkxzedR0NyTZhaXucowUG4Co9VRrnRoQ1xHAkYjqUQn7t7k66oGiP4=
X-Gm-Gg: AR+sD10cRAnQu6gYIOYbFQhViLFzibjuQv5ViJ61SO8mPgTEt2tGwW94fkdOjWqsioL
	Fbr8/n0aOR3UIeqeiy9GHjy+nhM8ZC77c8H+sT+SUItTZHO63FPjLf0O27br0jHf+CC3P5r6Bp2
	Rh10ZG/pbZ2hSHC8ERlrtel4sL2F6hYrzafO5GyJfqIU3y8EhMIuxwYq1+Kfl+5G437dVsruSSk
	BiEyZLsiBHv24+cGqpPKEP4hhbcO5uhcZFspyxUhIt9oYfcW0UCcDNTc7fA56BRnogylag3W187
	JHzWJ0l2DKQW/2N3dLgV3yLr/dHrxQanZ0dQi0hx/aIxi60nvkyvuymzpUXAfdng8iNNbWYQsW/
	wUfFMBjuDXN0DGP2E0AvxjFQqHXW2t49vNk8CPVz7NAdLy99fd0ycUrB2BGhawPuDMCUHlqMyHl
	qWm+7BCphFOgh0ySVxqdn8jl1K/Cijzw7vWpIgeairhV37Fxatt6De7/T3ayVbnU39ydd6sxz+M
	AKExH0OokKxha8xsLUqP2eHCN5b7xXbJcVjXpGTPsmwRA==
X-Received: by 2002:a05:622a:10a:b0:51c:8432:1753 with SMTP id d75a77b69052e-52fb96736b4mr922801cf.30.1787847710507;
        Thu, 27 Aug 2026 09:21:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e4270aae9sm40204551cf.16.2026.08.27.09.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:21:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wzcrM-0000000G4hm-2y5d;
	Thu, 27 Aug 2026 13:21:48 -0300
Date: Thu, 27 Aug 2026 13:21:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com, smostafa@google.com,
	praan@google.com, skhawaja@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: Add __iommu_debug_unmap_phys() to drop refs
 by physical address
Message-ID: <20260827162148.GB3769797@ziepe.ca>
References: <20260827145855.1616223-1-xiangzao@linux.alibaba.com>
 <20260827145855.1616223-2-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827145855.1616223-2-xiangzao@linux.alibaba.com>

On Thu, Aug 27, 2026 at 10:58:54PM +0800, Yuanhe Shu wrote:
> The IOMMU_DEBUG_PAGEALLOC sanitizer takes a reference on each page at
> iommu_map() time, keyed by physical address, and the only way to drop
> them is the IOVA based iommu_debug_unmap_begin()/end().  A path that
> tears down a page table with mappings still installed has no IOVA to
> unmap with, so add a physical address based counterpart of
> __iommu_debug_map() for those paths, sharing the counting loop through
> __iommu_debug_update_phys().

This is not right. The following patch has the iova:

+                               iommu_debug_unmap_phys(&iommu_table->domain,
+                                                      pt_entry_oa(&pts), oasz);

Every pts has the iova of its current iteration location. Call
pt_index_to_va() and then pts->range->va is the current spot.

Jason
