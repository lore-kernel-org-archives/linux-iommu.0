Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418079C0
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 20:36:24 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-76ef8b91a4bso5813585a.2
        for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693427783; x=1694032583; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9olKQHKl7i+BW/Fox3jX2swhAkTGXKGKjmjdi6zQOQ=;
        b=HTUcoTLVMJKPopZPx5brkas77UDvQYIjC7naYepzkdyyLzaJgfCC4cC5JwAlVN0zw1
         5odTw/6Hh+io9S7cO6rfMvYLDEIO31IiUr2Ztxc0c4RXaRW/AQxyvJt7L8RhEjF+70Q5
         CpGWsPg7PSJD4GIAbJjZLxoJza2f1yWwsk2G5rXvuB0C6AuXl1N4ZTOo0aE/BzZe1ry/
         DeU82ThH2Wp8XHdQvgsrZKiwnykZkwQ6JyF/yK2A3WmiYJekHvF6whUxF6TON22sjDS0
         aYFBHQUZvzQ/x5K83sbvTba63wgYXeHxAC8YZ2ftW2bpIroxOrkiRrsDr016wMs08bUZ
         TOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427783; x=1694032583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9olKQHKl7i+BW/Fox3jX2swhAkTGXKGKjmjdi6zQOQ=;
        b=N3t8KpPeCdpl3ovEziJExMS2TzfDmuLgcHzaFAV3ThfvU2TXE02ul7SwXdkR5YGCqS
         s8fccVVBxjo+k3OTRDsYH+qhBa6+plgk+JfOoYzEzRMVAkYGoUcwBESohasLRs2DE7gF
         qMzC0iQ4s4WnifNsTMBPanKFWwDMIw44LnRhaQ/Rr50HIWqkpI3iw9T9/o2g6P9ilDD3
         Cao/QCnG3BUc+S3ami6yNJzVcwmvMICTvusRupocjH53YkQO8sD45KKTFBEw/Gg4is1+
         8jC+oLEDGCG7R6ptRBh2/NxkRE3GpKPJDJR+5orKk0/ivWuT9v8S2dVKsJs60CC9t5Jo
         AMsg==
X-Gm-Message-State: AOJu0YzNKgXs173U8UkDF4HQwAjyiz1F5gxk9NBWOM60Rf+pNUUNXdAF
	XoebsEKuuzyIowr11w5DVQFgwA==
X-Google-Smtp-Source: AGHT+IGF4MU0rD+iQwT0aCopRevdjBpeHCOTE0yYV5wWvsuXnz48NfHVfNaBhCyzBhEFTczQi1j9zA==
X-Received: by 2002:a05:620a:3727:b0:768:1572:e9af with SMTP id de39-20020a05620a372700b007681572e9afmr1073374qkb.8.1693427783197;
        Wed, 30 Aug 2023 13:36:23 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id pj37-20020a05620a1da500b0076da620166bsm3998312qkn.103.2023.08.30.13.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:36:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qbRvI-000DB0-Qb;
	Wed, 30 Aug 2023 17:36:20 -0300
Date: Wed, 30 Aug 2023 17:36:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <ZO+oRPOf9jyNG2+B@ziepe.ca>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-5-tina.zhang@intel.com>
 <aa834f12-ce45-fe15-430b-2a9c3446a5ba@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa834f12-ce45-fe15-430b-2a9c3446a5ba@amd.com>

On Mon, Aug 28, 2023 at 02:02:52PM +0530, Vasant Hegde wrote:

> I am not sure whether I understood the flow completely. Just wondering why you
> are not freeing pasid in iommu_sva_unbind_device().
> I mean once iommu_mm->sva_domains becomes free shouldn't we free the
> iommu_mm->pasid?

No, for Intel use cases that PASID permanently becomes part of the
ENQCMD MSR and cannot be revoked once it has been set
 
> Also in this function (mm_pasid_drop()), should we check/free sva domains?

No, the driver must support a SVA domain with an empty mm_struct, eg
by hooking release.

Jason
