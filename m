Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902869;
	b=IlB+j2gL4ZXOTDxCvcM5ceYnzD8qGkkEk3GHiQPodc4Nsqiez9IyY09LN1lHQLV4bTgC
	 4O5fWg95HWwL4JvIMhdRcbjnE1z9Gk+9CBJFX95tETRPVetcc1vepXyWQWxbTRA4xXY7O
	 vy3+tc/Ezm9o8JmuLmIhkDFD6SDdm7r9h1fgeflvi06NZbo87tHd2gntzQSZlrJgbSYP0
	 726wV2eWyA3ZC9P8M7Ss3xHp2rsX8mZBTT90bzr9ibyh+te3Hc3UGS3nW/LdRbK8g83//
	 pXW8DaCUzKpWtiQ0RVZTBBsIWROKp1vzzsXXQbVGEajVI8XYoucRAWKZo9YHSd71qzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jskhMrN6L8/ity8GI6Per+nZ8wI0zDQt0quVEnFZ+Iw=;
	b=r/JKA/r4xVq7neH5+JGrOQltEY6lzISTAzbw14s+RSEOdLrSh3U1LEXlx8YGJW50s+Cb
	 DIg0kwHly8BhzYIvf+2bYirO6ttfU3LXMnQiaWYAFT6VQYkqyfbX8ktzVSL9f8vG5rVUk
	 +PsrAcOqXPntaPtQNCYK4HnXvClJNLJvDXgI87L4fpNNIrPCjbaLAO1epTz8gedR3j4uB
	 4a9naQuYNUHOZ5tYYyze25f5qlxMP5Ro/oaCC3ANK+LMeOCyQBOpiEnhEyo4iFKEXpcfH
	 g1kEuubNF798ukKaGXTLlHiWABAZM02/JQGCdFXeeSyLeeo3BQThCwfu5i1jPEAC4qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=b4esm3gb;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681B606A330
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 18:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0681B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=b4esm3gb
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso1406164137.2
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 10:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793902867; x=1794507667; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jskhMrN6L8/ity8GI6Per+nZ8wI0zDQt0quVEnFZ+Iw=;
        b=b4esm3gbcJb6r8rlxSrAFNW7GNp1jiAn7vD/jRWmyRDIARqOI59yeN/ZgYDUuIAnNR
         650DXg7xGrbkQfs7Xqn4VPihl0TgBqDHTHYkfX1/SvTtG1LsaEv7IQVtg1j0e/tFFWA3
         hV3AHreU1LmIBWc0App9ZYKGGoSdS+HJCN3lpu9vgodI2VykFVEqeL+6DO023gPyku2B
         FgG/RxyOtp/pfRLeuADdaFvXFeI5T6KjVj3M2IFptmX+OHP+Q1k94Nk4+bwRFZyUhONf
         6ke6Ji79sSPhJZnGDGc30ZciD5y9bfDhE2ltVrTSjQm58h5gTepPchgnqx/WHNEsdeRa
         nBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902867; x=1794507667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jskhMrN6L8/ity8GI6Per+nZ8wI0zDQt0quVEnFZ+Iw=;
        b=AysgSZy+EDNJ1B8wgh4BWQnB7+CRiTyFCkliaNkF19JGsrjM11vGj0KgCaDVvR3kkH
         IgeVOBEWpH3IfZrhWLmTuc5u60v9O2p1MLLDKZHfuiIFMQTHpG3f1EjoRuonQOTYgZiL
         GR6/Usp0bWdG1JerNvmZgZknC6BiWBwKZLO4X1WygEyytyXXq3HD11Rkl2CoVNsix8kp
         Fr+a0ObNsZkcnNGQcMqgZnnPlkxCHTRTblJ4WfTpYsFqHY8MHbseeenpoXhiurUh69hB
         D+eHAi7uSm1dQdb7t9fHWjsX65ZqpYFcTTihvQQlm8PZZCsJ4BI8ApZKGFq0/x8T2kY1
         4KRg==
X-Forwarded-Encrypted: i=1; AKwUvBwAALAVptzDjW6+u7JQSn/p5xCT5B50I7HESPXg/oH9RucIHEIx0CRHGJH8TK8ZalBFzwPfiw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Ym4TaSl7Etwgatbu2FDCL8/vCbVN/h0uumLW4+7gxajEMJCc7
	2BZmkDDllD9vJHjJxmN2vIhl0xuTFelZeXE9Uw9m7zIWptZNFf84mLXuZkng93qolk4=
X-Gm-Gg: AYBFou2htrIbv5/Z2aZPKXkvpIHWxQmsBEi+nrVqHtIjkQOXOH9h49g/lv9Jp/aXOUv
	Ld8mOLuh65u1TULqLy+dtdmDa+ulPiCzhYzWAh5iLlZsezBalxCucBtkxk4TNZ705CXZi6Jr99l
	h/E1kaEIfYvCFqHYSHq3nsMJGtJi64kh8Rg6HCxfq+ScciWWc9a2QpN7FOUcHErBC+bg/Xortgg
	uw4cUaNYPYYtXgt/+aI9N0iAVud7O+8R+Jt1CsBumm37lAafKbVW6aap/bhPr0FbVAQBOKwp1Op
	n5zWJyuSBm/nT8xxNWompjTT/oHsqLoFEhkSMcEL2MnHAlYnmMGk0sabRcWfXtNafb85IXtAoiA
	M3FFlBQMyuZtqN2MXdo+EGERbgXWu9S6n6UYpJcGqr3XSGwO5GN78hJSKYIlkYjEoFE7zx6I9oX
	k6MN2ojF+0YZn/nCbrSlRb6IDzyNRUxL9h2AET/M6txcBzKuAziXW6fIhKUCeXcHptUjLY49DK4
	dfXLQFG7Be56DTAP42Or30YHmB/r+oPmde3ZaClVbig7s1Zhd9KEl3lwEZyE1tuiLlznMm7Lkyi
	KfAe3IL5CD0f8K1UbKYUDcVF6Whlnvj6Xn9YFzmrLaQxgSaaOwjFPEalL+FAyiuq5d28XXDs8e9
	j2Jcse9tFBw==
X-Received: by 2002:a05:6102:5706:b0:7cc:2712:caf2 with SMTP id ada2fe7eead31-7d2a1628b19mr348440137.23.1793902867469;
        Thu, 05 Nov 2026 10:21:07 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998da178b59sm5242293241.12.2026.11.05.10.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:21:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP25C-00000003LsF-0vAz;
	Thu, 05 Nov 2026 14:21:06 -0400
Date: Thu, 5 Nov 2026 14:21:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 13/15] iommufd/viommu: Allow vIOMMUs without a parent
 HWPT
Message-ID: <20261105182106.GD663069@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
 <auuBjRjQwXl7UvvO@nvidia.com>
 <20261104193139.GB3889730@ziepe.ca>
 <yq5afqxf97a1.fsf@kernel.org>
 <auzAivzpzSUHjEQj@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auzAivzpzSUHjEQj@nvidia.com>

On Thu, Nov 05, 2026 at 09:44:42AM -0800, Nicolin Chen wrote:
> On Thu, Nov 05, 2026 at 10:58:06AM +0530, Aneesh Kumar K.V wrote:
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > On Wed, Nov 04, 2026 at 11:03:41AM -0800, Nicolin Chen wrote:
> > >> By dropping the nesting parent from VIOMMU, it just simplifies the
> > >> attachment to an S1 paging hwpt, right?
> > >
> > > Yes.
> > >
> > > The VMM must always maintain a S1 paging attachment that is the
> > > identity map of the VM on all devices, same action as when there is no
> > > viommu.
> > >
> > 
> > I am currently creating an S2 paging attachment. This results in a
> > configuration with S1 disabled and S2 enabled, which is used by all
> > untrusted devices.
> 
> For validation, that would work. Yet "no viommu" should would be S1
> paging, i.e. hwpt allocated without IOMMU_HWPT_ALLOC_NEST_PARENT.

It doesn't matter, consistently using a single S2 for everything is
probably better..

The VMM should try to minimize the number of hwpts involved, ideally
just one per NUMA

Jason
