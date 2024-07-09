Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A7155389
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549393; cv=none; b=RqN83BGK/yEQ095/u0G4klUp/RyoArxYgVaoSA2NcZdeKEfupYbhD+YBr5yXOi09q1/hN5LSRk2cstJqOnTXpM53CPySWMsPr9fHsIwBFvxc5xy+k9EN4bWAccLi8+JC48Uc7BCyvFgpGomK4SlE/D2ypD5kKabN8pVqgNSxq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549393; c=relaxed/simple;
	bh=xlqxn9Y4qR6/raN8e8ZNOZsykrUhWV17UR8Ofh5mjB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/g5Nlw58HEZnXbA8LwhrxPkaqQKW6MA7DyJRCIp2w4Rg2qn/wBQORD6Le7rsJxavVU49Dfb/oc0+zOuchp//9zFi9Z4GcvJjTtjXTB2Fl/4Xe9x0wAXLBV1XkdEzDLr7f3XyVh/3scod8cTg04Kjs4LnPPhl8ixPPbv2cWTUV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GlSsz/6d; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GlSsz/6d"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79f18509e76so93988185a.1
        for <iommu@lists.linux.dev>; Tue, 09 Jul 2024 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720549390; x=1721154190; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xlqxn9Y4qR6/raN8e8ZNOZsykrUhWV17UR8Ofh5mjB8=;
        b=GlSsz/6dNCiBnNqBdswYAzQSzF2JaqRNQ5tjZCouFU7wpISz7i7W8f77a1xLWs6USe
         ia3SbzpGCRnxFFHS7gEHBVkvMUOZE77pfTz07KVJkqqu1pobUJ4TtlTNLJz5yGcjBafe
         DnsPVECLKHzI+K15VDOrjZpG+K1hpye0Z739leE84tAui0IoCmSta+2eAPNSxVXGQMiY
         TXftrovpp3lRh/b5HoRNwVvQJ5+RYSj9nVXjMD/ppDUlGRLVSlD+GdVzy9VwrF8tUJkv
         6SNk8QBFCOgtCqE3k5qlB0HLsQsFGuIzzQyNVoRTklk83ICrrx4UsrA7vyW/3Ics93zX
         SaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720549390; x=1721154190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlqxn9Y4qR6/raN8e8ZNOZsykrUhWV17UR8Ofh5mjB8=;
        b=KpGZp3iTMo229iGcIeAY+eK4wGAbfWQAfRRiRRx/lPiN7P+dFPWfEnMV11Ni/ioK/K
         s49U3S8fboZGQcMEsKuXEoE2iB9QkUiK4411a5Seabp78hJor226BA2DpNhBJvRtd+IU
         nplKd6n52tTACjdArT4Ah7eDtz8AZNXNV9+nCYfwy7fHdTUCNKpUZPdI1sJPtH88lcEZ
         BcojZw0AHpsVXsA3HAp7hQc1Q1wjGamzfGxxD8zmpRAIZw7qDTDimGUKOpFMc39+3rjH
         IYBF2h0VGAQdLxXzsM9cJ2Gd/VK984L3AEz8l/f1fBNd4qw51cszM9GyHl2m50s6wbB5
         e/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVPwg11dHySAL2mF1BJ6RT0ROZEIyd96pdwvgsIlkKCMZU2axYCjQuFn37wCuX8yYGIc+BAy1TdUiGh+Y0uXtYRXEOQV1g=
X-Gm-Message-State: AOJu0Yxz9QPQtKfnzjKelo+9Rjy+rop3s21pUkbLS+UBivagWUykAsMu
	QeYQVwUuTBQPtfpO7sbYJaFMkhSwCgalwEU0k3tjTEQOzm7eKUlK8R5q5AnFff8=
X-Google-Smtp-Source: AGHT+IFcClzWS0hQdp1MWqU/r4yvSfge/imGos3pRKsiQ63fFn/WCHnq2uSXxllOYyr/RsgZRX393A==
X-Received: by 2002:a05:620a:1a0d:b0:79f:1eb:d76c with SMTP id af79cd13be357-79f19a52238mr445703785a.43.1720549390378;
        Tue, 09 Jul 2024 11:23:10 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19012068sm120991685a.31.2024.07.09.11.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 11:23:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRFUV-002pYD-Ny;
	Tue, 09 Jul 2024 15:23:03 -0300
Date: Tue, 9 Jul 2024 15:23:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support
 AMD IOMMU driver
Message-ID: <20240709182303.GK14050@ziepe.ca>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com>
 <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com>
 <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>

On Wed, Jul 03, 2024 at 02:57:51PM +0800, Yi Liu wrote:

> BTW. For AMD, can a single device be attached to multiple V1 page table?
> IIRC. looks like AMD has only one V1 page table pointer per BDF. But there
> is a PASID table which has multiple cr3 page table pointers.

Yes, ARM and AMD both have kinds of iommu_domains that cannot be
attached to a PASID.

We are going to have to deal with that as well at some
point. Currently ARM is always creating PASID compatible iommu
domains.

While AMD would like to use a RID-only type by default.

Jason
