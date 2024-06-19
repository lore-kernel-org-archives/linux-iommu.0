Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1F1419BA
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814791; cv=none; b=HMODSlsrjsZGJGJsA4fOxja+vkP/rxJqnKFMtiAj8xebE2hjlnnB+Qzy6fYLkLmQ/sdVPHZFL0vGLrwviKJQCzay2l5TIgi9CPINXJJYN9i/tu1gK5inT5d2Xph+/6hKzmyq0c041uQu5wd8dfCt5sU24Z1PIRSMK/mCXmL2wFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814791; c=relaxed/simple;
	bh=FVFYCJ1EGfwnkU654yIVzNaWy+IFuApDG9DYERxXLt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCzDgLS2uzcf0iZ7I87xvtAZEzc9Rc9EK4CwRTBE06kdnEW+LQ/0vKzS8qEmlCC3lEnu2Vj+h2HOa9Jw4pFLcGergoGLF0B9nk3JesL5aeiirfcUTE2ZejbZ7ckWbXcGpOdYm9Yg5416GhbHKMRoIMRvkp45djUE2t1Yq8GUbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JpuqH75l; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JpuqH75l"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so159596d6.1
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718814789; x=1719419589; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxqMh14wh6rgt2Gb04HuzckvnrRRbYR5Yps3CaoDEDg=;
        b=JpuqH75l3MzVFRLcbRyYLnxhckW9b8BowiQiOfYWbLu3BGGFXLEbS7piEMjhuSx8K+
         ZDsPNwLCvV7m12hGQGM13qcyF8SEzojCDR/i8DLee76o2Q/PdaviR2la6aiuinrNt/0V
         Ypp3yuV3oktirD12j1l2HkfCZr6whwuofhQN5wLCqYrYWgkgNwQ8cz0OaIid8G4eJ00n
         63lQtFaAAXCxfb2R87QuibPXzlFLaTzrcdyCGjEiOsfFo1yO9A162rYKtgBbciQZmKp3
         DQ09xINWuGUF3k8Hnu2JPuLYvyd30BucM7P2zEXxm9knIKz/NshnkHKNQQtfFYBEjeNh
         T4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718814789; x=1719419589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxqMh14wh6rgt2Gb04HuzckvnrRRbYR5Yps3CaoDEDg=;
        b=rMcH8baFyQindOzmVvKof6SpE5JeJOrMvJSrk3P3EtIZxb86mmYM+/FXWlwv8d+SRx
         zF8MDrE+JgYoZ7eHY4IY8xHF3RdWr2h8MecgGffn+6yixkvjlI99Sb/fICNiCNZdc/cc
         d2tysYdp/4dlMBwmfnT29QSJ3zfwU0wd01z4fghgaz0OCIH6kxL7VI5JGjVjZ8/A9aA0
         sKarp73ZJaGZiIUXMjKWPQLbEuUyeKIymBjbG30Sm1s+f5RvsIwznag/0Yi0Imz0k0oQ
         C6weQlXhn+avsYWbWO69Au6VSTAsDKzjNlNrpc13eCWwDL/qgpk8femM6TEJBg5myQW2
         QRMg==
X-Forwarded-Encrypted: i=1; AJvYcCXC4tw/jdxj67aPUlse+GSpF1pSyqgHWVwZ+khpJpudAvt82rkXF8AebS4c7ULaA3ZlcS+RaEpm4YlviuE8xYNT91jd638=
X-Gm-Message-State: AOJu0YzyMQ2CTXsHzey27l4vP7j0CNyYc9OmcqHCtEf5Lb/fd25OaeL5
	9st657ZJw/dh5qAHu2De4TCXXUZEM/vlRfASwwiN8/0LHFHXt8Mrp4IB/vvZRZM=
X-Google-Smtp-Source: AGHT+IEi+7foZgh/9Z0anYpjxAAXArw1uJUHOfsFSQr7PUdyfMayYNr0/bYNAmiUhoW9f3jLzo/I0A==
X-Received: by 2002:ad4:55e3:0:b0:6b2:1094:83bf with SMTP id 6a1803df08f44-6b501df81a9mr31902396d6.4.1718814788824;
        Wed, 19 Jun 2024 09:33:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4cf9sm78898276d6.97.2024.06.19.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:33:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJyF9-005AMj-BB;
	Wed, 19 Jun 2024 13:33:07 -0300
Date: Wed, 19 Jun 2024 13:33:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 1/2] iommu/io-pgtable-arm: Add way to debug pgtable
 walk
Message-ID: <20240619163307.GL791043@ziepe.ca>
References: <20240523175227.117984-1-robdclark@gmail.com>
 <20240523175227.117984-2-robdclark@gmail.com>
 <85f5250f-0d50-4aa3-93c9-2008c6ccb8fb@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85f5250f-0d50-4aa3-93c9-2008c6ccb8fb@arm.com>

On Mon, Jun 17, 2024 at 04:13:41PM +0100, Robin Murphy wrote:
> On 23/05/2024 6:52 pm, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > Add an io-pgtable method to walk the pgtable returning the raw PTEs that
> > would be traversed for a given iova access.
> 
> Have to say I'm a little torn here - with my iommu-dma hat on I'm not super
> enthusiastic about adding any more overhead to iova_to_phys, but in terms of
> maintaining io-pgtable I do like the overall shape of the implementation...

If you mark arm_lpae_pgtable_walk() and the callbacks as
__always_inline then the compiler should generate the same code as
today for arm_lpae_iova_to_phys().

Jason
