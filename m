Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8E13D243
	for <iommu@lists.linux.dev>; Tue, 26 Mar 2024 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479986; cv=none; b=uwMhujhKNlKrmdI+IhSBY8QSkmIZw0l06d00IBEFqPNffkWk+xVzQOlntpFX76KUl8vW5bT07u/7FqUK9TUSCYll/50JDaIt2VUBCeFPDOmtzGQutneDttp/ZJdge+mBp7TD/xT15UJ9ltywTzw5QN4zsoz9+nSxysSGwq5WjNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479986; c=relaxed/simple;
	bh=XMHtLInhdpFNORtCsxmlEXN6TytSsp4Psd0vpGJlhFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agHWsMBC+jzJc/Pgeob/zOpjUiHNurNGftC4Ad1ExCxbOKfcHyJarS0dG8K6rGfYwnZWDQE/6hkvcFs4Fcdurgmef+hlc0rVVa8kpPVK5ggj8TTIf4FxELFCWIyuhHNowuETtmZSR8Oia+4oYounoK1wqhrCu63dzOUvFGJz77I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f59szWCm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f59szWCm"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4146f72e2dfso17035e9.1
        for <iommu@lists.linux.dev>; Tue, 26 Mar 2024 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711479983; x=1712084783; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2O++aLuPGdPac9vhoK8OY9HLMIShoUjHnfyucoaDzxo=;
        b=f59szWCm8L9zJ7maEA/9Ct542Du8TDZNzfeIxKHMJYCug7EB3F8+wZYROlAgtC5L1Q
         lkH7W0mgM/eASl37N42n8GZdda1aa5NA10Yu+uD9i2BBG5QIFt4yhSYVeSEKGBrNSSGn
         wA4lICCmt4NlLt0XP6dd50R0ZtEGyTrEEmENk57njhIq1ZyDdHa1b0mr/ozgxy2cLOhy
         BW+/v0ThwONzYzqXtnPpMa41txNR/KLGggDqg8If9ZGNWbbfsy0lTMbw1NPrZD2mTCiF
         YUuen55ZQWy6qlo2cQ0GHbajbH5bhWC8nKh1UrEWCzEKLrNsJ7JaJwYCcZwbpfo5DQuy
         RFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479983; x=1712084783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2O++aLuPGdPac9vhoK8OY9HLMIShoUjHnfyucoaDzxo=;
        b=Vk1Mhc6kznPXTbMnVXR1HkAP4KEKKhwBa2sa3TGNVNmcZh7G+JE8GHsAsZnhLiQRko
         mDYWd/EtnKwYjjuDIOsjoKWxen1Lh33sbS9nmI0jqvtKhKLbBH8LatnvvLjKRR4mPukM
         l4Maxxn5oAvgDMl4seg6yEeCcGurjV5+7iuAtFmvhUIAD3Nth+cGJOQy5SbtPaz7LT15
         l60WZufNHq6PKN+MiXI17+BfqpmqTGH3z52PG3/11Q6ML8OJbw0rXfSqgMA4qK824EKo
         XWtVxxHCRW1Thsvxw6nZVFbjMq08BiULMjJAdpPRr34+WvGdAzcLtRJP6NHV2bAOrTyv
         ORIg==
X-Gm-Message-State: AOJu0Yx4gXmSa8c9csVKLmO0UkAQ+4x9yWzhjtwftYrisXuaDsGMoray
	lFctHN9u3bG5cqADHotZK1OPz8DyrN+UXLrTpMXHvxHhVGJ/prGh81VotuoPSg==
X-Google-Smtp-Source: AGHT+IHL9mYz18k3QjEkWU5YbvJMBb0fbp8YknTOD+ioScRXPB6XD6REp1IPUdO7uzrTv85PQWkyAQ==
X-Received: by 2002:a05:600c:3b1a:b0:414:89bf:b77b with SMTP id m26-20020a05600c3b1a00b0041489bfb77bmr28030wms.1.1711479982958;
        Tue, 26 Mar 2024 12:06:22 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id g4-20020a05600c310400b0041462294fe3sm12325788wmo.42.2024.03.26.12.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:06:22 -0700 (PDT)
Date: Tue, 26 Mar 2024 19:06:18 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v5 01/27] iommu/arm-smmu-v3: Do not allow a SVA domain to
 be set on the wrong PASID
Message-ID: <ZgMcqr6427vk8ei7@google.com>
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <1-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <Zf3EhA5ZBNwF2XOr@google.com>
 <20240326183016.GK6245@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326183016.GK6245@nvidia.com>

On Tue, Mar 26, 2024 at 03:30:16PM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 22, 2024 at 05:48:52PM +0000, Mostafa Saleh wrote:
> > Hi Jason,
> > 
> > On Mon, Mar 04, 2024 at 07:43:49PM -0400, Jason Gunthorpe wrote:
> > > The SVA code is wired to assume that the SVA is programmed onto the
> > > mm->pasid. The current core code always does this, so it is fine.
> > > 
> > > Add a check for clarity.
> > > 
> > > Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > index 2610e82c0ecd0d..347c2fdd865c1a 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > @@ -581,6 +581,9 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
> > >  	int ret = 0;
> > >  	struct mm_struct *mm = domain->mm;
> > >  
> > > +	if (mm_get_enqcmd_pasid(mm) != id)
> > > +		return -EINVAL;
> > > +
> > I am not sure if that is needed, the only caller in the tree is the IOMMU code
> > and it does the right thing, as that check is removed later anyway, I don’t
> > think this patch adds much.
> 
> It really should be backported, when we get drivers that do other
> things it creates a hazard. I've added a fixes line.

Maybe I am misunderstanding the case, but AFAIU, the only caller for this is
iommu_sva_bind_device() which is the function populating the pasid, so this
condition should never hit with the current code.
And Linux won’t backport new drivers, so there is no need to do that?

Thanks,
Mostafa
