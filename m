Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39D4963BA
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784144403; cv=none; b=nVOYTsCxj0TXLwPsUhg1R0yIOAsojydJLkMu2z0ufz3ZJBwkLh4vCGU94rciZ6rqTI9UR3B1VL09fWabla6atdoSNnb5GNeOT1rbRsXEpT7i6ES9nII84P06K0rC8vGlrqZ5SMtXBEFK+Uis27pLgG3h48dQyi0aaS0muzms1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784144403; c=relaxed/simple;
	bh=ZVZQ1uH/Du1E/GLHLvsmgCFfYOdpMFENq758X4InRKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+ML2Nu+LPatPa5Yrsmn24rOAUX02RzdIbhXhfSVl3Qm55bsVe9vgP5SUCpyw5r9KqndZKGs83BSqTpVCFho1sVUneTvwUXIA8w3SVbU9pdQ0XN6mK2Tog7sU+ceqEB+KkhbIoSOm/iY084CT0bZGZdu2V/8TM3XXZo63QdB3aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MgjjRJ7Z; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MgjjRJ7Z"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c2cce930cso23925941cf.0
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 12:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784144400; x=1784749200; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uz/I9zjdLCZbUHGbjgtmB+dGGWHOROD3Eamf87Tym6M=;
        b=MgjjRJ7Zz6GqAJnc90pY5HUYknQbj1RSLEDwdTw0Lf1v4hIxeTW7Bf7PMJ9ZVl4ONV
         jJWXNsLiSsIT/nK/9i+OF4yMtTkeoukS77Gw1i8gFDjwn19BmyKx6X7PBD3+WN3bLxFZ
         4T9XXv4gtNzPWGDrjwbl0N5Xrt4EzoSapbOtzmY+dYgzsFriPCPyb25nnhXQZrl6iDvv
         XkWdaPxU6orenu+q2mkBNtjraKkUsnYLMOwEGmMl+rVOIX2ijtyGE3vnCjcFr2Shkxfx
         +zGpNxCvqBqMrnW6EZivt+bfOxDR6BkKFb0jiPNZx62wqycG8VFJLfSKaj/Xmfp+ttyZ
         Lhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784144400; x=1784749200;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uz/I9zjdLCZbUHGbjgtmB+dGGWHOROD3Eamf87Tym6M=;
        b=fLG7X1XxIWVAPI/oqAkmiplNgGho9+gWehrXnWvNoE3Eq5kayoonVxX7ck3cB2wGvP
         AGPkBlHhb+wJJHsHhlcqjODayIk0fD01hHtwbfnxFKLBm5tos1X2fFJHSR7C1FFYhuRe
         zOl1sh3P09s7biB+7L0KDoa0g4NBcsCihbkHyQygLb7xJ22jrm/TJxiE8gdj1KuV63Ed
         9lYE+uTmoIIUEEM8izOLEYYCr1/Weve05WmTugtzUcoTg5Gl+ypAaSm/eGDc6UuPc0kf
         ZM5HmxwTLo344KJuShSWYcGmjc65GHVBULp0lPzArMWutV+F2HGDlOcdKSh5LstNSrwS
         jLDA==
X-Forwarded-Encrypted: i=1; AHgh+RpuE3OcKZlzpbjVocvp3ZZip0XBbjbpKcOjRyxDu7hErpwsmaTtej/bcZgknMW46Pg0dlrQAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUyIfbrmTpVqQl3c7fEvPWKtZBkTxAnIDbRKiGqJfQU7+X2AKk
	bOUimSDkvARfExmsdKG2GD/KVbWhKEBpx0rZs6QGbA32wzlS3f1YErPvCLGueBH+zE4=
X-Gm-Gg: AfdE7cmaPr4RRqYjfcQ8EnK+oFUlpH0DaXk512we5vmnhIUyhD4ofz5aFOjk2147XMg
	W3xiBCMHrgYGebE3iIeHe20jVp+cl8vjhQZQyJzyYWDsYzW4JOYqrZonTL2xlSVvgdrgoeUxYQI
	Wqr6SMA7M6T+2liclUN3HtvEjcP/wg/uqcSMHquYYaHBYDr/bFY3fO5a9RNGUFCniLY+rB0KQp/
	mn+ngY0VY7Mv35EFu0Mg80DGtP0yE56vHC8hvW89/X+0n17yy3SrYtYZxvDBG8/0phDUa1iED6Z
	qzsFHh4j11ti7+ruRUBhuhDKl6F1iMUUsfNu6pe3kjRQRKERNOhVSNWpIdBpD3mBHlHLwFWWFEk
	wnjCnChjb3y+KQuE6WXafH92DsJn1KQ8greYv0G5Hg1hNYuQJK85uYpl76fgv
X-Received: by 2002:ac8:5fc3:0:b0:51b:f40b:2fac with SMTP id d75a77b69052e-51cbf279099mr203782551cf.50.1784144400189;
        Wed, 15 Jul 2026 12:40:00 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caace31a4sm145676151cf.12.2026.07.15.12.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:39:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wk5SZ-00000000tyA-0hFm;
	Wed, 15 Jul 2026 16:39:59 -0300
Date: Wed, 15 Jul 2026 16:39:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: weimin xiong <xiongwm2026@163.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 2/4] iommu/arm-smmu-v3: Fix fwnode lookup lifetime
 handling
Message-ID: <20260715193959.GB210048@ziepe.ca>
References: <20260714060930.220277-1-xiongwm2026@163.com>
 <20260714060930.220277-3-xiongwm2026@163.com>
 <20260715193732.GA210048@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715193732.GA210048@ziepe.ca>

On Wed, Jul 15, 2026 at 04:37:32PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 14, 2026 at 02:09:28PM +0800, weimin xiong wrote:
> > bus_find_device_by_fwnode() returns a device with its reference count
> > incremented. arm_smmu_get_by_fwnode() drops that reference before
> > reading the driver data, which leaves the returned pointer derived from
> > a device after its reference has been released.
> > 
> > Read the driver data before put_device() and return NULL directly when
> > the lookup fails.
> > 
> > Signed-off-by: weimin xiong <xiongwm2026@163.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Actually I got confused what this was..

No, this is nonsense, if the devdata is racily being freed then so is
the smmu pointer.

The whole design does not support hot unplug of the iommu and the
purpose of the put_device is to pair with the
bus_find_device_by_fwnode() not to control any memory lifetime.

Same comment for other similar patches in this series

Jason
