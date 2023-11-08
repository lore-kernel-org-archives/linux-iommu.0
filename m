Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE34321B9
	for <iommu@lists.linux.dev>; Wed,  8 Nov 2023 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fXDyLWaM"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-586b512ba0aso3363253eaf.3
        for <iommu@lists.linux.dev>; Wed, 08 Nov 2023 09:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699465167; x=1700069967; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fez7d2oD0jqA877WtYGemcz1mIG1xNotv9HuUKl17lg=;
        b=fXDyLWaMDUTlZG7sHVFMH0QJyKg7qSV6k1H/0BzcUhSl6T8mJn+u8UIbLhqkew8spC
         C/cN3HVgvjKfd2z7m4VAwf/UqoB9yrjtixOXDqUa2KokpaF3Jxsg0yrQ5f6X5D2o3bAg
         qMvnO+S8CBo4aFraUyq023r5g03mx99fV+8XrdK/ikV6lUpgVUaCTnEe4HjyKGIElk6i
         RYXh0KZNkrdHYpedjdXnnp5wnLnGWdq3EWBHKyiLsx/tiIZlHngxYWpQqWYElEjlpWwQ
         QO/AsTv/zqqznIDE0Z+nnesAaD4mEg+mGubqTVEWOUi/kFNG12xm0lT3sMQ50wLhUj0v
         MrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699465167; x=1700069967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fez7d2oD0jqA877WtYGemcz1mIG1xNotv9HuUKl17lg=;
        b=UGFJz6+XeklSfm95xhXjMPzuf9Feu1XqVEMmgnPry4fMbmjmkf0iqgUDMZMLmXkogU
         qe7lmYap2PfNwyYeulOw/heW2RNbS/WJOt7ec8z1W8/cSBJmdSuyaIMRNMxjLviE9m7Z
         ZmLYeI5JIcRn1FDJnfaxvTebj04gb2hY7HGvB3KelrfBKC3YAZJMaSqIwR+ACuO1ivRg
         P+3viINmbjbYPgzTHQW4XBRZ2K5pfGVqt1EiWM+mvso9INKIyeinCyjk5eo67sjRZNvt
         FrBmmtusNzS9JJ52Uc+zkQlVB3+F3io/euVCr3V135ciBI85t6Ib6mB/Ge92kcCSlb8T
         wlQg==
X-Gm-Message-State: AOJu0YwrUxZYe6UzRXJ39/2RJ+Zcuv0NiUlCaiDIK+VbY/L347s9knCH
	FLmIty36PBEgRIUxM3NQM27k3g==
X-Google-Smtp-Source: AGHT+IFej9NZgQ/+2LjPp+xoxu9RiYGW6gMR81sDvfm8bHBPH21cB7z0X7CwypR1KBJQgpyCkOlg8g==
X-Received: by 2002:a4a:e282:0:b0:57b:de27:28ed with SMTP id k2-20020a4ae282000000b0057bde2728edmr1987087oot.6.1699465167350;
        Wed, 08 Nov 2023 09:39:27 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id v15-20020a4aad8f000000b005737ca61829sm940312oom.13.2023.11.08.09.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:39:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r0mWS-001gwa-G6;
	Wed, 08 Nov 2023 13:39:24 -0400
Date: Wed, 8 Nov 2023 13:39:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231108173924.GF4634@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <BN9PR11MB5276B1582CED568795725C198CA9A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231107175405.GD4634@ziepe.ca>
 <BN9PR11MB52764A460BEDD56A56290BA48CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764A460BEDD56A56290BA48CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Nov 08, 2023 at 08:53:00AM +0000, Tian, Kevin wrote:

> > There are many events related to object in guest memory or controlled
> > by the guest, eg C_BAD_CD and C_BAD_STE. These should be relayed or
> > the emulation is not working well.
> 
> so that's the category of unrecoverable faults?

I haven't looked exhaustively but I do have the impression that the
only recoverable fault is the 'page not present' one.

> btw I can understand C_BAD_CD given it's walked by the physical SMMU
> in nested configuration. But presumably STE is created by the smmu
> driver itself then why would there be an error to be relayed for
> guest STE?

If the guest programs a bad STE it should still generate a C_BAD_STE
even if the mediation SW could theoretically sanitize it (but sanitize
it to what? BLOCKED?). Since we have to forward things like C_BAD_CD
and others we may as well just drop an invalid STE and forward the
event like real HW.

> > > but I didn't get the last piece. If those domains are created by kernel
> > > drivers why would they require a uAPI for userspace to specify fault
> > > capable?
> > 
> > Not to userspace, but a kapi to request a fault capable domain and to
> > supply the fault handler. Eg:
> > 
> >  iommu_domain_alloc_faultable(dev, handler);
> 
> Does it affect SVA too?

Inside the driver the SVA should be constructed out of the same fault
handling infrastructure, but a SVA domain allocation should have a
different allocation function.

Jason
