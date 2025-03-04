Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269BC2BEC48
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105187; cv=none; b=kRUAWeCNmtQ/HeMqk3C7Vbtj8yVOwCd2i1GhmEK6m/98yu15TsGExWY/53j1Ss9T9yJH6qFv4cQWoaloeAMitZhssh1hPBcM5L8A62t0zZ1gvW1IfjUR9geRFmH7KNLUiD7OBSIrDNualBIHlISGASw6o3H1L50w3Fwp/94XXg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105187; c=relaxed/simple;
	bh=BEQy1uoQGIdDIi3PrKYRnsp/aLnLk9DPsaBIdyAvs4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaVmFm4pjjwHydXTLPsUKl0eubjG+MrbDT18kmk38geozdWTXXYaAZAwLUoWmN1pgl1aV0hpsTXZetO4bF+H2Jw741cbtbaSv2uvjtwqIbpK59Ptgv0OiQ4ZqisuOPKNZOuTG5gZy3rB9WnOcQxfDnY9Ulmb0I98QmVHp8ojDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dC8RV0jH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dC8RV0jH"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46fa764aac2so49874401cf.1
        for <iommu@lists.linux.dev>; Tue, 04 Mar 2025 08:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741105185; x=1741709985; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+QyCC8CcTX+xQp+BLqbobfaOcWMa+Lol1b2+RKYTYvw=;
        b=dC8RV0jH4kUGLnAkL0KrCA5lEPYcGM03qR7y2o39DU0YE80QrdJ1rDKcLqkL68tst+
         4MDBD46WHvkYXE4tD+PtA6bAtvtTy9p0sRLg9CCuTvSYHiOU5/5oGWtynI1Y9OLZpIV5
         bs3pJV/E0JR0f4i2UIxHFKV2bEqR/X0veDGEhpF4+PR1GzSv4c9QjCZpz2a21zz4Q/EC
         pvu0m4XMX4dCCVIArgaYua1ig9T3d5zAf7/DC6OLTj+TH1iul5qMOuyzQP/sFQwoq/gG
         BGxcaitG0mxR3u3NlNb5LuqjWzMFrCZqvxRpYnRrPDYf2zfAFGdbH+3AUJj/y/MFva6w
         thbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105185; x=1741709985;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QyCC8CcTX+xQp+BLqbobfaOcWMa+Lol1b2+RKYTYvw=;
        b=HRlQz5rZA316hlhMfgjUznqJv2KWJd/sgBz9qLYpd1rSABA83JhJU3mzxmqPKxA7F5
         j6++vcfV/pMitwZLAeZ9szujoQcv9ubeJuICIFv1z4EeIF4wgNNu3XQK28yLIY9yRoOe
         mLQoPei+eL55W8Lfm17SuvzcnyxQcZRGzJNMY3Ivj529bDzIBThqyhM/xFZhXDxfi8/B
         2XIgJSVddDmWUSFTwsiAO9n0KPXWmYJa+s+1vzfM++ZvDZFIKMKXt4TGN05xK+IvViMN
         QUaJJHgKEboLsw0+iJVxW/6gkHk0fE+lD3ztLAHerdQMz5w35nDCulrO+1GuMGURo6O+
         z5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdtZ3TPN4uG1qgqcU5HSvNdURIUwSgY3WqY2ifxg6Qjx5KpMqXstwUXAYeyK0mzcLHWrQpCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBzX/7xhGd79WjTnzAbU4GwbkAg2UrGhGPWebdnw3LCZnLGd62
	axPhcGdioH0BjAzKhf+uYNv3ze5RjCWLaoKYb1+ah6WhXE1jhaZW7HSANJZnFv4=
X-Gm-Gg: ASbGncuFHG2r+NRcpSyKCDN5yWyc0l1yCpT8+n7yf47QaNYhIjDfcxJ+vHkWjBGRxW9
	2auJ9ZzE6eIRzNmNaINVjp+I3vJSlcm88gMuGF1p1IS5to0n+VBnkBOkM1Sc1DNqr21vKTE4GNW
	ljUSwdcOQsvH5g+cJKULx7yJcWUZIJluz/Xq6023wNXVmDn4qvYIgVdz3IF2JeB7ssKjFilZsL5
	WGHlEk5Lf6UDsSq/aZABFmYXEz9C3kabrhcKuiFpa6pBOdhU2xG4QL2sy+zLx9r8JX/E4XJqFVJ
	lOKl84uc6GKRS49MVyi6OZuvhfyzdFotPHKq/jzYjDh5AXsy33CtwxGUvIF4KW+vF50+kYL84Q3
	XmJxGsFs2vbvejf3Xcw==
X-Google-Smtp-Source: AGHT+IEh35K+Rji/J97KgXv7b0qtNlNusVFI1SmT/EdTjyyFjXOLkEHdIcDO3dFOzig1wg6gty4MyA==
X-Received: by 2002:ac8:5dd1:0:b0:472:15a8:4021 with SMTP id d75a77b69052e-474bc100267mr252633741cf.37.1741105184975;
        Tue, 04 Mar 2025 08:19:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474f9a4f6a2sm17784561cf.1.2025.03.04.08.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:19:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpUzf-00000001Go8-445C;
	Tue, 04 Mar 2025 12:19:43 -0400
Date: Tue, 4 Mar 2025 12:19:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
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
Message-ID: <20250304161943.GD5011@ziepe.ca>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <20250228193221.GM5011@ziepe.ca>
 <b23aa37f8e864dea82a6143bece912d6@huawei.com>
 <20250303103102.GC13345@e133081.arm.com>
 <20250303165255.GS5011@ziepe.ca>
 <20250303190330.GA426248@e133081.arm.com>
 <20250304142634.GC5011@ziepe.ca>
 <67fbe3f4-4fb6-4753-b34c-320b7897fd16@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67fbe3f4-4fb6-4753-b34c-320b7897fd16@arm.com>

On Tue, Mar 04, 2025 at 04:02:20PM +0000, Ryan Roberts wrote:
> On 04/03/2025 14:26, Jason Gunthorpe wrote:
> > On Mon, Mar 03, 2025 at 07:03:42PM +0000, Mikołaj Lenczewski wrote:
> > 
> >> For example, if we use BBML2 for kernel mappings, does that require us
> >> to repaint all kernel mappings when disabling BBML2 on smmu attach? I
> >> am not sure, but definitely something to be worked out.
> > 
> > No, it would be a per-mm_struct basis only if we did something like
> > that
> > 
> > When the SMMU driver puts a SVA on top of the mm_struct it would
> > disable BBML2 usage only for that mm_struct and it's contained VMAs.
> 
> I guess we would need to figure out some synchonization mechanism if disabling
> BBML2 dynaically per-mm. If there was already a BBML2 operation in flight would
> want to wait for it to end. But that's a problem to solve if/when it's shown to
> be needed, I think.

I have a feeling we can piggyback on the mmu notifiers to achieve this
as all the changes to the PTEs should be bracketed by notifier
callbacks..

Let's hope it isn't needed.

Jasob
