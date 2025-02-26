Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2C25D1EC
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740609734; cv=none; b=NauJvPPyEhqwDv7JJg2vCIYxlGjH3ptrv8m8jbpBWwJtTRnTg+c5kVJdkR37Lt3RtR6+LoV7bTL/F/kTdbx9qhSFtNuh1ILpxJW84Lo05k7seVeM6DdSm0O1JOCPp7Uarb+pat0GyEVOnOX98y4NGPuwg4uoZb13QfJkuyMRuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740609734; c=relaxed/simple;
	bh=ZTwxM8rdADerk/cNx0arx7kDS01SOH9QXEdxpe9tTTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=avOmp5E++idAPnXwsUl6Tlh+M2bTy+0FVlnFapNNjLjMuxsftOwdmS5QRZpRr8QWapKwrHD8qEzY+vFFB5RKHohKJZx2bBQJczj0ezyYk4gOVhn5lzUYgmbm32l5jsJaK1QYvdg7+YEskEvMgMtT4fAx2HlPeMIuLvrQ6dFJVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtbafQow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtbafQow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740609732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WSsRo9f/kZpAVrmCeaQeyN9jgr8wCPdFSD6yxCjk7C0=;
	b=LtbafQow56+eAZFLTOOH7RJ4bkCj7Qw/IYJ3P18gExSWWYBRK4TxkzxZcoaqF2/uWc5LRj
	bvMkMpoev+mb5Zgit2pxwXo+AH3UAP4+SebRmAp1NCx7NVYE88MZUy9L/J6iW0Nocx8LIb
	U7a6Tp1nBRZZ88/PFlXQvxFZEFjt4ec=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-JivVx9Q6PhaPA4B4gP4caA-1; Wed, 26 Feb 2025 17:42:10 -0500
X-MC-Unique: JivVx9Q6PhaPA4B4gP4caA-1
X-Mimecast-MFC-AGG-ID: JivVx9Q6PhaPA4B4gP4caA_1740609729
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2b6d933baso9613985ab.3
        for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 14:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740609729; x=1741214529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSsRo9f/kZpAVrmCeaQeyN9jgr8wCPdFSD6yxCjk7C0=;
        b=QXoenJIC9JKdD8uV1rsyMoW8id30m44VTYf4V1iI1jhNj9UgxJVZVV0pT4oO03JQ2O
         x1YwgCCjH2aSj+5uwTgIavd7D6YdC/oFcyME5l9h+CoPlTq9CIbzY80SDjxZAfsuahZh
         PusSxb+YgB97dRLht0Yq5WJ2re2jxfGYFuDf8LbQGR1e/O2gQg6EQ8zfYA8/HKVbe/x4
         OuK1y/ryeGzE8jHEdejwmEGc4WimuZKDio3RFTFwgXtKpv8EdStyIkQ86AnSiShXeufi
         7oL15KJUmI8xob4VsjddLljy5+4guHkfwb6iymn8VViHlL4+hAGXRswsat2Pqg6JKohe
         JQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5LZHvOc2KruHiASvftAYpAx3Zb8o1EA2WnhXSKNZO6SYxDnq2qbX+FLhhCMrbCEOij7d+NA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxnl2NsLq6DLOtDKkoJ6l+O8O/p4F+2lIVO08/wSBlvRz9Ly/Bd
	wbMdqq6jCI1aWIiDh5Eyp+Dbjz5voxfPr/2JVrullxhfLU/zjuIayRqzLIxmxhJlN1Phg5tkTTR
	7Oynp8FCEh5lRaaDbaPCVCoGjQR5r7heRWLx14bQEaNyz30s2bdtt
X-Gm-Gg: ASbGncva42UlxwSAP6oGE6pS9WWlKS22EVMj20Bfb2/2NWJpFV/Jfa8TvE6n8aALAjS
	Qshwaxzow5S4NKcyr5Zq3cOzstcZKDAJA9vJZsuSDzhTLeuWFKBVByQdBHJam4hjA6iK782MrHo
	QSmAwMnMWFnjVFOOP53ftaF6rdW1P3HwA+pQB9HhXSX8grk+KEfYuH+Kbykkz3uxYYYqLTh+fVa
	zUD36DW4+2tUcLRVnWAgxQPDnTPhWu4f3KpWpQHKLhhfGMXHo9K+AmV9qpP5dGsX53vzF3qoPDW
	bFRPftKJxmvBqQg0RNrHw6ZOPEMiOuwsZjgo2lSRHDt8
X-Received: by 2002:a05:6e02:154c:b0:3d3:d00c:3602 with SMTP id e9e14a558f8ab-3d3d00c3936mr56345395ab.10.1740609729688;
        Wed, 26 Feb 2025 14:42:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTOhYn4pJPekUzWwNQSiCzQRh4WaIeP5+YWFj49thpAD57sNWc7+2Gayd29nUpJi00satggw==
X-Received: by 2002:a05:6e02:154c:b0:3d3:d00c:3602 with SMTP id e9e14a558f8ab-3d3d00c3936mr56345235ab.10.1740609729433;
        Wed, 26 Feb 2025 14:42:09 -0800 (PST)
Received: from localhost (ip70-163-223-251.ph.ph.cox.net. [70.163.223.251])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061fabd2dsm59010173.143.2025.02.26.14.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:42:08 -0800 (PST)
Date: Wed, 26 Feb 2025 15:42:07 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <t4tpaydcf5drs3apwp6w6thil2zobe3qzmz25pntl5whyoqt7l@6oq4xo2azhml>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
 <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _7ekUql3BlbMBLgW06p7jWh8sZnF8uja6k4fEcoHFpE_1740609729
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2025 at 07:10:20AM +0000, Tian, Kevin wrote:
> > From: Vasant Hegde <vasant.hegde@amd.com>
> > Sent: Wednesday, February 26, 2025 12:47 PM
> >
> > >
> > >  3) TA is an IOVA and the IOMMU runs it through the full translation
> > >     to validate it. ATS is just used to signal non-present
> > 
> > Yes. AMD does this when Host page table is configured.
> 
> Here 'signal non-present' implies to support PRI.
> 
> But...
> 
> > 
> > We need to consider various scenarios. For AMD:
> >   - Currently on baremetal, we cannot enable SVA and Secure ATS
> 
> ... here it says SVA/SATS are incompatible. Any more background?

Wouldn't this case be SVA with non-secure ATS and still use PRI?

"In normal non-secure processing of PCIe ATS requests, the IOMMU performs a full address transla-
tion and returns an SPA to the requesting device to be stored in that device's IOTLB."

