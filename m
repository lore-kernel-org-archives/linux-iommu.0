Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F8481A3
	for <iommu@lists.linux.dev>; Tue, 26 Mar 2024 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480381; cv=none; b=RYayCuI7Hw9OVFl/RBKHn6t315zOjfLrN3Wj3pal1HthXvMbLO2f1Q4Q4OShh1D6ppksJGIXnQ+2SN7jntuZKoh649sIzuMqohY4eRauOTfYc49F/2UZ5172uykS3xiJV1kALK8Kaakz04lfdoKKTYBIF5sibhw3dJpGydfxhpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480381; c=relaxed/simple;
	bh=qouNgkgg9VsvQ92eRyQNmGXWlS3bTfDe7jNsP/hBeUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESBLZ3yiwYEu7Qc0Un7qEYakrrlFW+gr7fTh+bWFlklYmX+fJpdMAhX4/i+wPo4ohNfbUrmxrPohgArAtHjIVb5SyoKr+gxQG1QfX/A7iMjfPkTMnoaRX4JhrTguGA1wjfdndAHPxrYAKxNnpjPYnHgHau5AWMCkYk4lasgvvF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zt8op9Xy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zt8op9Xy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4146f72e2dfso17685e9.1
        for <iommu@lists.linux.dev>; Tue, 26 Mar 2024 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711480377; x=1712085177; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TdvoN9pLMcneCwvNfRcnO2A70DXtwDqMLrFJIxZqg2E=;
        b=Zt8op9XyyCib9eO2492jQYwVmKg6D6MBt9SziB+lkX1rZQRIQbLjKl+ot+536LJa9r
         oPiFYnSkMFTAFj/VGcfAL3Se37Kj+ii3fuJQqNQoYlJeF0lpxwqQl/eDuAfwFWyLCny7
         lfIkSoItlzhqp++rGj/SVW/++dzNehn2sl1lFgatMvCe/3OO1dd8cHxDdJSf+BLE3n7e
         s16ZAScQx3bGOk+JT6WJ+90S6UfFpCpQjFw8u/BK6sQJdDgmYX6mumDJnmN9fXs5YNl7
         gmaVjVpVql6AnS+erBM4ugQYVKTQFsY7C6ivPPVbts6k1x9+bjYdJ68y52BNyzQIUwTD
         dDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480377; x=1712085177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdvoN9pLMcneCwvNfRcnO2A70DXtwDqMLrFJIxZqg2E=;
        b=dCj8V0MTMPVLI8EuRTAAhNapLp3Ag3rndI6yV6pfZJtXb1Q3IyM5XQ1AlzB98urSMG
         JsLBCMIWKGiPOfKCUQ6d5da44dqc7sUylX0M6HHPLCmfLg/fU0PA5FTA2NPOsm4mYwaq
         gUAmHipDDA67qs9mKvdv2PoDjxyPQ1a27mEPx+p9+02PO0fNcKxzxLrGkRmKdZYIjxVz
         w1yLcPhyFu7DNLPIgkxHocLJD98cvSOXNmmlsxyEsdk5Na/kU+r8fpUQk8N1fbOP3iMJ
         DINFRtPhrpHB6JupTb5POtIOEeTEUaxhq1EU9SlBi+DXK5Bj8ivL9vj+6a6heoq9a8Ut
         bPpw==
X-Gm-Message-State: AOJu0YzX5ymAVDzfAN8H8BpNPC+4mcdtvlVOFvGK2CB2MYz2XY/dYqWI
	v3EoJmzsLR+ctAjxA/tRV50xsDjF4ENgvCpbYt8LuiYHgdo5Bb9e+U2wsX9o3Q==
X-Google-Smtp-Source: AGHT+IEbk21x/F4NM5dydbnppbzz05fY51i8qAeXlO7V6M0rwLjEk263RPNp0tgBz6RjvVc+dJQPVA==
X-Received: by 2002:a05:600c:a018:b0:414:11:ec14 with SMTP id jg24-20020a05600ca01800b004140011ec14mr29973wmb.6.1711480377299;
        Tue, 26 Mar 2024 12:12:57 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id bs24-20020a056000071800b00341de001396sm311379wrb.110.2024.03.26.12.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:12:56 -0700 (PDT)
Date: Tue, 26 Mar 2024 19:12:53 +0000
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
Subject: Re: [PATCH v5 05/27] iommu/arm-smmu-v3: Make CD programming use
 arm_smmu_write_entry()
Message-ID: <ZgMeNZP08aZu-nVe@google.com>
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <5-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <Zf7S109OKJlRVXiR@google.com>
 <20240326183055.GL6245@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326183055.GL6245@nvidia.com>

On Tue, Mar 26, 2024 at 03:30:55PM -0300, Jason Gunthorpe wrote:
> On Sat, Mar 23, 2024 at 01:02:15PM +0000, Mostafa Saleh wrote:
> > > +static void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits)
> > > +{
> > > +	used_bits[0] = cpu_to_le64(CTXDESC_CD_0_V);
> > > +	if (!(ent[0] & cpu_to_le64(CTXDESC_CD_0_V)))
> > > +		return;
> > > +	memset(used_bits, 0xFF, sizeof(struct arm_smmu_cd));
> > 
> > This is a slightly different approach than what the driver does for STEs,
> > where it explicitly sets the used bits. Is there a reason for that?
> 
> It is just more compact this way

IMHO, it seems too much to have this mechanism for CDs for just one
SVA case, but I'll need to go through the whole seires first to make
sure I am not missing anything.

> > > +	/* EPD0 means T0SZ/TG0/IR0/OR0/SH0/TTB0 are IGNORED */
> > > +	if (ent[0] & cpu_to_le64(CTXDESC_CD_0_TCR_EPD0)) {
> > > +		used_bits[0] &= ~cpu_to_le64(
> > > +			CTXDESC_CD_0_TCR_T0SZ | CTXDESC_CD_0_TCR_TG0 |
> > > +			CTXDESC_CD_0_TCR_IRGN0 | CTXDESC_CD_0_TCR_ORGN0 |
> > > +			CTXDESC_CD_0_TCR_SH0);
> > > +		used_bits[1] &= ~cpu_to_le64(CTXDESC_CD_1_TTB0_MASK);
> > > +	}
> > > +}
> > 
> > We should add a comment about EPD1 maybe?
> 
> Driver doesn't use TTB1?

Yes, it's not immediately obvious why we ignore EPD1, so maybe it's
worth a comment to highlight that, but no strong opinion.

Thanks,
Mostafa

