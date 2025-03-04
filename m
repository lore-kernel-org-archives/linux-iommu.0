Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2EC24BD1C
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098398; cv=none; b=Q75yXUIEWzb6vqsOUMmY+2Gpu/ULrWzNL20az+hr8jwydo9JVZlivUuhlQG/+mEpF3o/GCZrwqmaSsATrjrH/PShbEzlWunb6SKZQXj7eGGxURVvZXhokc07eAKw5GoBUOSb/bBHzM2vcmx8yeAVyn7+4E2sUWcG9TQC0a2PeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098398; c=relaxed/simple;
	bh=ZZ7KMHGJDKL1wdw85tJIpxyh4i61E6zj6IeC9gOCMHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLeBqEB1qXNZWF8msCiJiejJWpJVcwBZbyU1z0gA4YpElILsQ+C7smAZUlz/49F/Z99Q/jIFN7To8KynNwPVY/04M7JRbZK0YgrZEcX0mQKA4HiS9PxZXX6kskTzWiv9iTaEGD98bsWiFcKR2MFeSP+lJ6tOsXQu9bOu8A1xJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nyKSrRxy; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nyKSrRxy"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-475038900b4so3478141cf.0
        for <iommu@lists.linux.dev>; Tue, 04 Mar 2025 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741098396; x=1741703196; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZ7KMHGJDKL1wdw85tJIpxyh4i61E6zj6IeC9gOCMHg=;
        b=nyKSrRxyHMMkoH0b0YMd5DgsFY6Ee9tokdL7t2AmD7UdlgZJONnFx9uoFcPxQTTJc2
         wBSo2H6GGdAqkiijM/qB5VN9TwicLXqsTvBTvjHkvM7OWr0vIJ009zAZOpiUifSaBamm
         RAyMzM8wtsBjGSv/8qo9QFCrirH7YaX18XPIe8t1UrMRaKo9GmX0ZL/oqTLXJ7sTmXNZ
         AZDXuqI9O+Rf7oTKWRc/YEumOISrI8zO3oXtJXxn5L1z37YLGYDUJaWBRhHpNgN7B+//
         gzvLH41yPfIRXM+RfG9QAp2Id9w3TGTVFPwKdt7Uk3Qam3yUEIcOsHj9CsvyDvcuH3eR
         xfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098396; x=1741703196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ7KMHGJDKL1wdw85tJIpxyh4i61E6zj6IeC9gOCMHg=;
        b=OvphSjzqCULFKs3Ncr+N/AQXISgi0VwJpoPuqEtKPqu5Iaj8t0MRmvrHfOdcbrzfSp
         EeGPuZHFleMVktzKHiL3bzCJwyg6xEm9qSSy5QdETjADz5vdJzb8y4TsIIt+aO8PRowR
         6K5eT2GYdhTv/kVPZ5mGK7oTfVatqOuWMgyjKFyF0RB42T4dKFUsPDRHB17CxGDjNMx5
         kXjUFmIf9lRz/VTXOFiJmzDy+vnTAWdboIRsIUCgkteWLVbM9fC3S+sE83ExwjTlhmMg
         n3j0gbAZX1AjBu0CValodTlMmVN1jSJ4AcKBzbS/B/J6cWgjPUuWcCX97Zw5MbaCJIsx
         lr6g==
X-Forwarded-Encrypted: i=1; AJvYcCX5Jki9EQ+bY2y5Q1G6go2b6swW+dvdh6qWhy0Uj6Sfo6S2pZnBV0+FItZrMCC/HQ4lnQfx3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLlQ2cQ3EDVeuMWkMR3GA6xezC1kobuMox4cLnuYVHXK/K5L5Q
	22afxKbYCFifm13oEIr6bBpdZRW5J93t4lnzPyTuYxex3tv0bMZq+m6mlmxCw08=
X-Gm-Gg: ASbGncua5bbgqBW9trnBu3tD0bp3jOWyEDrcyN+Yuu4TK8imx8sAtCVJFDNMxDHWVvr
	Ak++612uZH7r5ZKgV+aPl/ABiZ40C8Xpvzj2J/v3/M1tq+um1ypPL5yrSOzb5ymn551lk6xoQ8m
	XmThWj2RWLcJgofiuPDfzuE3ja37JdcW3rddghxfYtlanAPYxMsTgRqWvGnPLgTAUQ4kcTQfFr7
	hZXVB038Dj/0VbSxg7rEQY0kEcyBhnS3qTa5940T/ZL+D9uyVD1tQT1pqdn5S0a0tm9tZEmquUr
	zsOMwVHeSj5XI3JmTM+sW06T+2juZMcziZd+SZxLhpr7vH7yBc6vuSjWGTj4GIUWRpgLtnfPZoD
	0/q3LG+FKXvuZCbnmYw==
X-Google-Smtp-Source: AGHT+IGpGwzh4Elz0HvbqFWhkWlBebcf1jH6YCXchA+m15FaB7zfVQNpWK5QB2cePx+kDOFF5fxCRg==
X-Received: by 2002:ac8:57c2:0:b0:471:f482:bba7 with SMTP id d75a77b69052e-474fbd559afmr45366221cf.22.1741098395939;
        Tue, 04 Mar 2025 06:26:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474f2875726sm21811991cf.8.2025.03.04.06.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:26:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpTEA-0000000179G-3zqe;
	Tue, 04 Mar 2025 10:26:34 -0400
Date: Tue, 4 Mar 2025 10:26:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Message-ID: <20250304142634.GC5011@ziepe.ca>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <20250228193221.GM5011@ziepe.ca>
 <b23aa37f8e864dea82a6143bece912d6@huawei.com>
 <20250303103102.GC13345@e133081.arm.com>
 <20250303165255.GS5011@ziepe.ca>
 <20250303190330.GA426248@e133081.arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303190330.GA426248@e133081.arm.com>

On Mon, Mar 03, 2025 at 07:03:42PM +0000, Mikołaj Lenczewski wrote:

> For example, if we use BBML2 for kernel mappings, does that require us
> to repaint all kernel mappings when disabling BBML2 on smmu attach? I
> am not sure, but definitely something to be worked out.

No, it would be a per-mm_struct basis only if we did something like
that

When the SMMU driver puts a SVA on top of the mm_struct it would
disable BBML2 usage only for that mm_struct and it's contained VMAs.

Kernel mappings are never made into a SVA so are not effected.
Userspace only.

Jason
