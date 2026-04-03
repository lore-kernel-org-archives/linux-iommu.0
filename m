Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF34346FA6
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232454; cv=none; b=LmMICXpTukP03lha2Uw37iWLlZcd68omQVclyvzh8HBOEa+DOyROojwPOtEmSXDgBEQhqNeKpETsObMENJne/JFAOdXbvq2vzra/8KftKZgehnRNZxglpquYlSzQwiNDVzXfZ2+K+aTiN9UEKlVIpkNy2HNuuMTGYgI05CuM4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232454; c=relaxed/simple;
	bh=9//i/l/99yq+vnARHHYnQK2GDVb2B+L5A462BYB1OAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYqL25h9ayicWdzjMs3Nie+UJT6EbevnF2xVQHrXwTsDVHu10tyWpQffIyhSnWQksv1BHPNgSTr15b5pCb8I472WkhjnN3cwqRo2sM7gY5Xq65/F4FBrJvZ0JWkqgREwoD1QC68+LaWb2ZOWREuhMYqlG4nJ/fY3yjs21szvjDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PCiebmmn; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PCiebmmn"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d6144877aso13311541cf.3
        for <iommu@lists.linux.dev>; Fri, 03 Apr 2026 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775232451; x=1775837251; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GoRjrzwsrBkq63H71O5T18FssH5et47xTHlFEqom36Q=;
        b=PCiebmmndASvG2Ev54xcQmy+5VICsr/DkGggwJC4KW3zjkaqAImGHkmCtCi8jXxlUd
         yy7TcIn4vqzx4fGHJXlHqlqYYO1ngzAlmDOOfASbVtHhAV6A6o36p5xbaActnECGfu9w
         jU4JjLSmy73xSDKXWSd6hhTPrn27jbXfmkfjrzf6F2W8JspIQqrKWQlj3NL6sqDKaCim
         9wAf6fwUQQkSo4kVK+U3Rg3n2PHRO/agrQXKdIdNkX758e+kK3NBPUOFgpNZX7caMei2
         xlozcTI9v5IM5J8xArkiDZz3w3QQZ9mlgThNi9E+uRbf+129LjaRmlZLAt3ITYAwitsu
         GvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775232451; x=1775837251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoRjrzwsrBkq63H71O5T18FssH5et47xTHlFEqom36Q=;
        b=VLQBtW9G+E/BQr8zqGSUVx1mgklQ2mukAkqrp4wukaP/fnrRctiDMchabW42DgP7ut
         dxdBbcqziae2gCmaKxLqQoP5PUd0wpUZMlYX3yxoPQoKieh9TSh15QjMPEsFdM53IGnr
         6j4+mvbrCwUxJqn4npZ/kbkKQ9nTPdNJSaiKS2CsltMlVwXpcGgUp0btNyzzl3WZ+Xea
         +i6hd2Y12RRAA6nTEKm3vyeWXvWZKqeGEnJqLPRKw5OFDkhORn17fYHQu/qmQ8FC507L
         Ulpn5vBiAI4GfNYYXE9FXZX4K2HYK31jwGxipwTzwYJ0PSr0Hc03Ybii7Ojj3jR/bZYw
         sLHw==
X-Forwarded-Encrypted: i=1; AJvYcCWyE+OU5Ujpos2kF5lkHK4SqLTz14vu6BNHkCl7I0pj7b1ixTs4N0AuQhMPZdcAnDzVP23brA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1kPvm6+/hvujDn1gPrjEreDMO7OlegneJ3f3Y9dGEe2Rm6adu
	6vhP9Rax35k9oDzTbBbtOQtlYeeY/dyaC1Dce7oorP6deUe7GyowWfjcw6yI5fL+x4w=
X-Gm-Gg: ATEYQzytse6X/mY0H8bu54w/HUfg4Hov36dD9u1LoH0ZfqiCMoDYQ1LA1jFN88D2iaf
	QJPJZiue4x2q/0v2Clo66oGX+nwEXGWqdvsvXSQUDuVbkVk/kOO79jIdGyQih61UTDjzYNtvN2i
	NE9SpaIUv5dqMOSgEhyHHA53U72UIiL2MQdq1CsbHU25N+J07RDM1EbvMqVcLk5fiUQdJ4drt5f
	xX8U0SyZ7sXUOfmou5NRTB23G+N2wZhknrWOxASTH6P1Sobe0m7Ur+3GUqFR0aWQpFcXKJqjVSo
	Qaqt6sMLXL1+L9FiHx2OxUds/6toGsFxA4QAPutfk6Rx/aLS1ONZy71mY+iMxlMsL6HDnaZTXna
	KkIZzd41ieAv5xONEEL2E7wsslBl0ryHb6Apso7vSZX2BKgDhcsyLXwCXTWx2rrYoxYr9JHg+Cr
	LgChYiXSMN+HYxLW1Ksh+6Spz/HBHt52PDUU+7GggSn7qM0DC7PZi/vGbV/FCEaa1PbOR9Xg==
X-Received: by 2002:ac8:5f90:0:b0:509:3257:c050 with SMTP id d75a77b69052e-50d6278f405mr52196981cf.24.1775232451465;
        Fri, 03 Apr 2026 09:07:31 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b1a739dsm48217621cf.1.2026.04.03.09.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 09:07:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w8h3R-0000000Cnh8-3mSR;
	Fri, 03 Apr 2026 13:07:29 -0300
Date: Fri, 3 Apr 2026 13:07:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] iommu/generic_pt: disable GCOV for iommu_amdv1.o
Message-ID: <20260403160729.GC2551565@ziepe.ca>
References: <20260402141012.1437095-1-khorenko@virtuozzo.com>
 <20260402141012.1437095-2-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402141012.1437095-2-khorenko@virtuozzo.com>

On Thu, Apr 02, 2026 at 05:10:12PM +0300, Konstantin Khorenko wrote:
> With -fprofile-update=atomic in global CFLAGS_GCOV, GCC cannot
> constant-fold FIELD_PREP() expressions inside deeply inlined page table
> walker functions.  GCC creates .constprop clones of the inline level
> functions, which get their own GCOV instrumentation that prevents
> constant evaluation of compile-time checks.

That's hasn't been the issue here. gcc gets confused where it thinks a
value is constant so the builtin_constant checks inside FIELD_PREP
trigger, but if the value is constant then control flow leading up to
it excludes that path ever happening.

Somehow gcov is breaking the elimination of the impossible branch, and
I think this is all just compiler bugs.

Also, I thought this was fixed by adding the always_inline?

Jason
