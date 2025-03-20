Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E6209F4D
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504467; cv=none; b=Xef1DgrBSKkB3AMvBF0MpG/UnYC+2MRW91EdJtPUKAofk8yieLypXx8FErV1ENQz+WpP9kTGjPEmCplteoZkIfocitNMEO3PxXwxHv5Bzc7R2Kvl/SIwC7/P0Eg5+D36JQSUzt1LDbSi6aFse91AcacYZqjS93nsPqEPf0qhk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504467; c=relaxed/simple;
	bh=ZBmHuk31cJ478EqE2Vxx1ad4uLTI9M6k72cDIgirdDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqK2ZMJWIXrSI5roFoEU7nNrqv7wFPrpRH4TUdrBoU9UtSG6zocxc/AgcAKgTKskJumOq0bejcj4yFTIi7WXBb7Hkj3k6ffavWwR7nB9Jc++fKhmt2+CbAi9C2mUHZ59ee/xvStdUXKxFiLQfS80cOGe0BP9mcVb7zONB20RXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQZuInYc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQZuInYc"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2263428c8baso19825ad.1
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 14:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742504465; x=1743109265; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3ftY1SpPcwjVEc9YHOQsceFxu2opEhrb0Lfr5h92uA=;
        b=SQZuInYcqAvjNd4XGZKJAyzH8fjG/9TGkaqgUhvtg3foM8gX0GUyH8gHA+TGlmRIjH
         GeAGjkWWgc5j7YdT67wZhqU8F+Pwlv6cwBq1mjK5Yler28jKQf/DwFGjIdnr1boJ+KPZ
         9CDrUxKIgD7e4XpFcY9JPGCJLvh3N4/sIpX45oE284kfYr01WHD7rB62hDzAe3FgzJ/m
         igE0C15oPqthyFOKLBVqWRgVwR2UAuuA3PI9Otb3J863u+4C9pxqNZtCKBWXr5G1ZZfS
         qMLtxJefXXema0SOYDcachvumEpVzVVVb/eKD4JKTMbVeCCJh0Bz4SAwMqJkizn+q2uR
         TXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742504465; x=1743109265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3ftY1SpPcwjVEc9YHOQsceFxu2opEhrb0Lfr5h92uA=;
        b=l2O0g1YZy4RYUcODbYyjb6Fen/RP+pOExgPDkvaYkGLfOkMTDeS3dWArPz6AYaQaWM
         gC38TljkDMZPylKbN0hMnMVS+n7Jk+0k2ILMsEQG7DCrDH5boKvbV3zOmxy9XHL6m29Q
         oVzq3VadrWcBqSegH+9kPYGZRVukuHACpHpVx1LUxisUHV3i18MHV8RbZc0cdZj0hYnW
         SrQfa/agIPU2ogr8VEeu3Y7wyWqC6dgxT49nzInlR8y9pvc1M4e4Klx8qLmJ9xlRamkZ
         BaBbJixchgcoDtzazEsRbEq16x6j1XxCK3nrlnq8MuBZTBxV5JEy3wkUV+EANKhGpgKY
         PXBg==
X-Forwarded-Encrypted: i=1; AJvYcCWmweZ6Q1ENmp2XZFUxjLUMydPRRe6JfoDy/oH+6I3MbobN4Xm2PEneXC+Z9nHWPTtmBj/L2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAIxcfG4fnLv/4zQAEMhYHUKJDAWaehodhLb5V/hkVpDyzzAWi
	36uJeTNWmM5sR+THeiEiWsG6Klfe4yjKuUXsLllOPHyEGb45IJSvW46Ta2b4DA==
X-Gm-Gg: ASbGncuDL0jkIhmFVlufRdZMkg1xfP0/udX7O/gJeky7Be44fL6js+g9N8/3gPuC2y7
	j2AUTftdDao1zM1B/1rmukL2MRRlIMuyYlwmi7xzePEyXFsuqfuVAXceqLdws9CzsE/QtUYaYtf
	S+DedloADVr2SPM2xZ/Ymd1qJVE8kPcLgAZYB8q9u+YaDe8sbhNs3ymp3lEMIlKhWLB0isCpYfS
	7HIuEF1CV+AHbosNihS92d/O2TL56Rn5ssKGbEvWP4/uH1YL59FIBNpZ8yeEgFvLfL3LcC96v5j
	WwUUO7rTyh+oPG2NPXUgr+RYn6Xl7GaXyO51b9vIlqVf/d0o0Q+Xhw0s1e+dluzTudP9iXmvFvY
	NsX4=
X-Google-Smtp-Source: AGHT+IGiN0KzVGiWtm+P1bpXvBXbwlNpLNI4IFB/8DJttt4ccSgHzBZqS4/mIlmzVqRGC7VjU2rTsg==
X-Received: by 2002:a17:903:8c8:b0:224:1fb:7b65 with SMTP id d9443c01a7336-22781da2413mr962405ad.22.1742504465203;
        Thu, 20 Mar 2025 14:01:05 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2278120a552sm2418955ad.256.2025.03.20.14.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:01:04 -0700 (PDT)
Date: Thu, 20 Mar 2025 21:00:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z9yCCe1mRTr-4dTx@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <20250319194609.GA126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319194609.GA126678@ziepe.ca>

On Wed, Mar 19, 2025 at 04:46:09PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 19, 2025 at 06:22:30PM +0000, Robin Murphy wrote:
> > I don't see SVA and VFIO needing any special considerations, so it might
> > just be the new vIOMMU stuff which may need to hold PM enabled for the
> > lifetime of things exposed to userspace.
> 
> Are you expecting that the VFIO driver, and whatever driver is
> managing the SVA will keep the power turned on as necessary then?
> 
> VFIO is not going to work if the SMMU power goes off unexpectedly
> while the VFIO FD is open.
> 

In that case, why not hold a ref till the FD is closed? When all the
refs are dropped, we can safely power it down?

> I suppose VFIO also can power off on-demand via userspace asking
> it. In that case the VM would be co-operating.
> 

I'm wondering if user-space / VMM would be willing to control runtime
power at this point? Maybe we could have n VMMs vote when they need
power and drop the votes later and we can simply rpm_get if votes > 0

> vcmdq probably needs some suspend resume logic like the normal
> commandq.
> 

Ack.

> viommu I think will only uses STE fields so it should be OK?
> 

What about IOMMUFD stuff like the Get HW info IOCTL?

> SVA.. Is similar to VFIO, if the power goes off while the SVA is
> working that is bad. The SVA requesting driver would have to manage
> this. HW with userspace command submission probably can't allow the
> power to go off while command submission is possible.
> 

Hmm.. maybe then rpm_get() 

> Jason
Thanks,
Praan
