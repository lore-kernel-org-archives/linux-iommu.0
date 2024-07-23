Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588B1E522
	for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755953; cv=none; b=ZtNCRIvUZ89pGCV1DasobVLNzIMP0cAly5et8NeGEVpwfb/YYWeF2Aj4ob3DSxtPJdOjSngEsTIQXbLJRVRGIORYWKUvbEQoOlaVPOaNu7sjOlE6cOGSGvmog00CqiD7P3/mIw4qBg9q7GDWmazRynfibgB6vMyHTZ819VVuA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755953; c=relaxed/simple;
	bh=ihX9emVnJ8KwjR8jwdigWYzQ0um3s7KIfyfuCgrq2so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQrZxk+tfDIB6mnXXCHCsjJ2DywMQh0XcCOrXr7+6xzdbR0P/XNjaGUd6USMER3TSgRppX6pQ9dOuLoSmhKIuDmE8DQQjedTXwP/nAaPPEuaDhs+RNLQqN6ALQ22ctKlqXaY0STICXX9pm5VTzsAunytfy1XVOjUzVCPB5CpSfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NrVW64CY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NrVW64CY"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1c4475113so5855485a.1
        for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1721755950; x=1722360750; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+UAgw7HndU91iVl4uuG6v+TaR/twfYUGA6WkvflMVQ=;
        b=NrVW64CYL4pPBH+yP45F/+wg9qreC79RmUwkfpO5aSdoRlQSsOcmCE5PSmk0sZAE36
         7pU/ZiOZrh++umATEog5pBEKKhyIdOMC0AqVeerwz4EOIytYnsOfS8qKhfxxQ+5zZTRN
         t/tSgEk38HxlB5mwitJC+XG2cw3dk6WF+zfMp8nYBhMeDdYfT5mAPfoq/P6l1UjTOWaI
         lDIiwrE+AmOmFTu5pDnvqek5dbX78uSURtexIkTEWZdVKhoQIkLNHVw4QKkt7wS/WGzY
         cXWfqupHTJRJNcM978yl67Sh+5M31mjl9CxoAB1vX6XYJ6iq1Kg7s1Q59pzP/qQ54sV4
         XDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721755950; x=1722360750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+UAgw7HndU91iVl4uuG6v+TaR/twfYUGA6WkvflMVQ=;
        b=hauevQoLXsczOpoqlAN/h9iYTWS+fMCewun0TngmKad0KTcWwjhTLiyUcMjPqjCY1N
         DyKnfqGg1M1zZkALxHJtXV8mes9exhjnx1TA0IESJbWTi15MDZ5n//jNcPWMeCXunsLZ
         S9wc2sklaraZu05ISES3RQDJaM6B6CXWAsIQ8jWa4NO7xg6Gg6DRCSgYY21TgR0Rn/xT
         AjEql6C00v12lRXkPPRSwe4w0xAJq6kr6lVF4dcNbow2O9QW/D6t0z55Q3c7l4PISXR1
         TsZcU++SKmYLsr8sPpFlg9eKXe7zb6F2rNOWkJc1MmvJtkjPf7TjcbliwFuSsZP5Hfv2
         XPng==
X-Gm-Message-State: AOJu0YzO1kxjESxnLBtddb0+RLoQPXvFOvSlNQROxkNIqbxK0HPwWDfe
	0N2cJazBVAbIQHD557Am10OCMadjPB8Gj/9T4HSHVY3qfSdIYFbdDNbxG5XpESA=
X-Google-Smtp-Source: AGHT+IH6VGARW0OSwvqGDZ/+EtuV4DhoJxmB6OdyjjKvQbq9/MKZv68s0/6e34td1pKpIZ3cBIywHg==
X-Received: by 2002:a05:620a:290b:b0:79f:17f4:7154 with SMTP id af79cd13be357-7a1c2eb92cbmr461586985a.3.1721755949738;
        Tue, 23 Jul 2024 10:32:29 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19905ec73sm494601985a.78.2024.07.23.10.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 10:32:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sWJNE-004zPf-87;
	Tue, 23 Jul 2024 14:32:28 -0300
Date: Tue, 23 Jul 2024 14:32:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu: Add support to change domain to blocked domain
 via sysfs
Message-ID: <20240723173228.GN14050@ziepe.ca>
References: <20240722115553.6005-1-vasant.hegde@amd.com>
 <20240723130507.GK14050@ziepe.ca>
 <e7a6ce53-c473-44d0-9177-b7dafa5c6aa5@amd.com>
 <20240723164448.GM14050@ziepe.ca>
 <110c57d1-1a84-44e6-bf71-ab5cbae12120@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <110c57d1-1a84-44e6-bf71-ab5cbae12120@amd.com>

On Tue, Jul 23, 2024 at 10:16:51PM +0530, Vasant Hegde wrote:
> Jason,
> 
> On 7/23/2024 10:14 PM, Jason Gunthorpe wrote:
> > On Tue, Jul 23, 2024 at 10:08:52PM +0530, Vasant Hegde wrote:
> >> Hi Jason,
> >>
> >>
> >> On 7/23/2024 6:35 PM, Jason Gunthorpe wrote:
> >>> On Mon, Jul 22, 2024 at 11:55:53AM +0000, Vasant Hegde wrote:
> >>>> Add support to change default domain to 'blocked' domain. This is useful
> >>>> for debugging.
> >>>
> >>> But how does it work? 
> >>
> >> 1. unload the module
> >> 2. echo "blocked" > /sys/kernel/iommu_group/<groupid>/type
> >>
> >>> If you set the default domain (aka the domain
> >>> used by the DMA API) to blocked, then surely no drivers should be
> >>> bindable too? 
> >>
> >> That's correct.
> > 
> > What prevents binding after being blocked though?
> 
> Device is in blocked domain. So any access from device will be blocked.

My point is that is just going to make any driver that binds to it
malfunction. The DMA API does not comprehend a blocked translation to
fail all DMAs. It is great for testing because you call all the DMA
failures logged, but not useful otherwise.

Jason
