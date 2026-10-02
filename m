Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8441B3346B4
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941597; cv=none; b=U1OaCxltxK0zaTMSMuFO+bJqGC+NJhGrwQoUNBholiZ2FnlzCvvdrVf1YnUQenhDh6048vHh3e78sofA3yXMampEVacoxGW5zUKPppdm+7wSq+8t4X1KjBIXb0+OGahWjW4JveWd4iLpzlC3z+lueE3l8p6+BhPZwgzUVSD19dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941597; c=relaxed/simple;
	bh=oBB1ofT7Bs53EtnSpRWhFXOivni2BxFwa0cRVdF0XSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nidzkIJKWOdzIV9/0Q50XkGKUy1B2x87mJMGpfvits1Pc4NzwgTqOnuDtOySTEWz1MH4aq9DCV2Lrb+brqKg+DHYCSVL1v8AKozmAPxLBmZX+DIPmJqnK68Qr1eGn0lhVVlKbSRWfwckGzuqglt4DzaP+U1TP2Qs6RBqNeGKzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AbZ13+jm; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AbZ13+jm"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34cde269e1bso2095680eec.0
        for <iommu@lists.linux.dev>; Fri, 02 Oct 2026 04:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790941594; x=1791546394; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p3RrKegDIYcP9bXP/97JoW1rLjg2e5Ae98djanO6X2o=;
        b=AbZ13+jmWTlEsM/cw6ztDU/tf+y8xxLo9o92QeZJzNUo64gkA6+7Lh38Iaj0ioYQ3V
         71ADUPcY0/ZPGTEI3uSdGtZ7deE+6A1O5I9efDsP2NLCtq3Dwu2FtpzyeI7evj5SsIL5
         ssy5Y4vkH8QqhVkk8qWhhB5zj9soy+lSS0MSdEhJHZGq34hN7+klemfwbi258cuCP2D3
         VwqQIEMeXPsJZvceG/yO6cPurxUMsk124aCpKz1WEWYF4JAv7DD6aEFCL3VStJSnd1ha
         OY2/3qc0V17g5bYL1FO0jKMNbBdGqFrKIVWLLdJ3cpKRKR0g/Q4fOV5ulZzfryDvt7lZ
         Jiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790941594; x=1791546394;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p3RrKegDIYcP9bXP/97JoW1rLjg2e5Ae98djanO6X2o=;
        b=UQdipX8vk8/kRd3Ac3TC8OeStN4Lqam2MMAKS8jUyWF4KjL9tIqv59OLL6vv5TUPG7
         SUfTZ0yAkQhCyiZ29pt1WKMDGEfuLFqwdDVkco6eD8Plq5S3L0BSx6+tR4vILbpmbuZn
         +/TasvO6eLHrW5I+nwNAHA3YFGevBZR/3MZD/rI2VLhKBNTBk//af5brYGIFq32pAZlz
         0lMGsQLncGMTweH3tBJWjaXjtxwJ86RCOZK4JD37FPJj9Ra0OzZZIf0lSIEoSBmw9TCu
         oL+VzG4Fjarkuo32VuMVfN1i4QayOS9ce0d7jVHx2KeaNgF1r8K11o3h7Y2mtDwFZLUp
         3Upw==
X-Forwarded-Encrypted: i=1; AKwUvBxSEA/6/QeOHpGEZjDBNS6aAEc4id4aD41WcZFrohseqxwlKXBvqrC9jh/Msoxt7k5XT1kqTQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ0tP3pu18C0KTQMe92yo17daULqjqwQ69hWvRIvyVQfnhz7T0l
	b9bqX1HWiBizFUp/3kBJznGc9izvpO6ZAKspVjTvRMtadBRLczYQZzydvdmmkm4bNn4=
X-Gm-Gg: AYBFou0QRk3GQyP+PovPeOXED14MMhut1ICPFk6/rZ9gwVKctaKe1LKYxm3k5izTeZG
	6mqPT6SaBEX3TMmgTtpmpHhD/xK4k1JIyHQVhy6Nn3Mxvx4ZynpR/kr+UcJlMllbdeqCX6JJzdu
	7gluh95yXNWWvqPqPhmYPdtAUGpQXSM1TEiaDqxfejd/1WJnD5ZHJgQ/JGQfSUpv+d/omro2SY5
	IklZw869kbiRMQ1vhLDPV7ApTAtVB6S5Uf1AIJ5ZDp17UQZ4No8ghXLsIt1nV00mqx3Ouspf14C
	UOg+9DOKiA1F1pmHOSozgmzZhxzcuP25uCAy++Goee4EwEWpNoVI/MRw9YIZQj2Buzi7sNl2CMK
	PPAXdpmOAPbvpwF+QJOQmjz9Nt4JCR38orcm5xXixXkuoxWBPpRcObUz8sqSS7YY+/X7G/lhMZS
	Oevfkxw7VEtfq2ZC7/7E+YDWQOVwweLZhZuz3gvieqrAQ/
X-Received: by 2002:a05:693c:8808:10b0:33c:259a:759 with SMTP id 5a478bee46e88-34f21996151mr2610780eec.36.1790941594306;
        Fri, 02 Oct 2026 04:46:34 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f303e3sm7587040eec.5.2026.10.02.04.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:46:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xCbih-0000000GQhV-36wt;
	Fri, 02 Oct 2026 08:46:31 -0300
Date: Fri, 2 Oct 2026 08:46:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <superm1@kernel.org>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>
Subject: Re: [PATCH v4] iommu/amd: Make PerfOpt compulsory
Message-ID: <20261002114631.GA3481470@ziepe.ca>
References: <20261001182410.1525285-1-superm1@kernel.org>
 <d4634df4-ab32-46df-8b05-665998959e43@amd.com>
 <f790bd53-8610-4e8a-aa4c-1f346c0cbbe6@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f790bd53-8610-4e8a-aa4c-1f346c0cbbe6@kernel.org>

On Thu, Oct 01, 2026 at 10:57:17PM -0500, Mario Limonciello wrote:
> > On 10/1/2026 11:54 PM, Mario Limonciello (AMD) wrote:
> > > PerfOpt is only a feature usable by integrated GPUs and only in identity
> > > mode.  Instead of leaving a policy knob in amdgpu, just turn it on when
> > > an integrated GPU is in identity.
> > > 
> > > PerfOpt locks the GPU into identity mode where the DTE is ignored, so mark
> > > it require_direct (blocks VFIO/iommufd claims) and disable PASID (no GCR3
> > > table in the fast path).
> > > 
> > > This drops quite a bit of compatibility glue.  There was a refcounting
> > > system, exported symbols, and device attach/detach logic.  By just setting
> > > it immediately it's a lot more straightforward.
> > > 
> > > Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> > > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > ---
> > > v4:
> > >   * Disable PASID for PerfOpt devices
> > >   * Don't allow attaching a blocked domain
> > 
> > This will block attaching device to guest via vfio-pci. Is that fine?
> 
> Right - The thing is from that experiment on v3, putting it in blocked
> domain does nothing while PerfOpt is enabled.
> 
> I figured the user should be aware; so I was between blocking attaching a
> blocked domain or showing a warning.

Ideally you'd fix it by making the perfopt bit only set when an
identity domain is attached.

Though I'm not especially happy to see a driver that can't support at
least blocking, that's pretty broken in our model...

Definately don't show a warning, this is security stuff if the driver
can't do an operation then it must fail.

Jason
