Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8647377015
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126821; cv=none; b=fYd/SuiPXohu29x/T3SLMl8uTatHiHKNv86iJ/dbfCAGzL0RGZ/RreHm8BgnPwFiyaPHcDMbrneFv+fI8uq5x+zJmsPlxIO1mehh7W4ogcLDObICyBw3XF3OnrXSSExcS9/UFa3z5Z8YlEAnsfVtnIzXcXtR6xm42X0PyN6Vnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126821; c=relaxed/simple;
	bh=uQJoR9F+JTLHFeALKkUq+Q0MNEImv4dProP3GHVEWS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzKSZ2abahAHzZQPGuC1lLfKN5ExOW9edV7U4UMdaG9V0/Qc7qhufL2waWubfyfcK8LyHN/Zj+2rgXHIWMkyBvlA4C0KcnVEgCjAffXZ2kXou54RFaqs7xmYIaIFgTvctvnrE7BStPN/DNwP6zhgdgT3yERft9R9oeqEPaukDgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lZRdemDf; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lZRdemDf"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92ed3993c1eso194756185a.1
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786126819; x=1786731619; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uQJoR9F+JTLHFeALKkUq+Q0MNEImv4dProP3GHVEWS0=;
        b=lZRdemDfctZTEurXSt5iXUXJTyGLEUMjjmh35H8e0lZ7Phye2X2PpuMsTGNgLBYeex
         oFlh094w99mCMQDdNxmwI5usgVwIGcEAuY76ZpVJI9i2IeevGbPj506hipvNZAjnjygb
         gtfrLS2kQ8BYrXTDOul81oXlYUj+AvZ2LF7lSWb2hY+3ypnfdNwjK0d7dSfKJFHeRf99
         dfeRFpjMmGpH7CfeAF/Bv/Nd5EZUvRopl15d0Vm1l2uncRdy1I5YbQBl/yyAExC4w7tt
         a2M7HT1RJZ3Zkrnk154PL0wH9szCLqavrcpWcKgA49Ru3MImqJtrSvyzNqFfE+fjbD+H
         Kytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126819; x=1786731619;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uQJoR9F+JTLHFeALKkUq+Q0MNEImv4dProP3GHVEWS0=;
        b=q2D95ZlS9WkYbiKGVw9ea9w7KmTuIdZ9VKAR1XzQwj5qvrN1ZHBrSURPVGX30jjH8h
         s1jkidJmdMUqtSry9XXrj8qzALpG41BHoVbYQkl2mOeWuv6tHvpRFe3XydJc009Vuxag
         BAUVuuoZ1pwHFCbrif8zrR0dvB4InlPFRG4MOrI5OhRiyEZfrE/NOfWqSmmAP+zhspcN
         4NFXm/ADjsm6X7cO2/zr3ueFWYr60qP+Ydvu8zjkWNAI0T/IcsLV3vXWdpiN9lUGmnIm
         RL/6mDUQHdSgpA3u6qGqw0SwubNcaw+mW2kgEWiVGYBeBn3pzw2IjNvWJsFNIxOvaw5P
         Bz4w==
X-Forwarded-Encrypted: i=1; AHgh+RqpljngNF8mDZFHkGpi/cEr+d31MFmOVvINWR6uIWiGP/7K/+wPEwuVYwXhbrXoF/USC5aIfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2xcQRzvvr4WtJY8zYb8nwyZGIVFpsrN5e6Vum3eAI3v6E3Bo1
	Zqq+AFK6LVQsbpqrCO9A5YOlrZPcTztnoJRp3uBWI+SVdOiQ6O7ott+qzxdiVlnH/fE=
X-Gm-Gg: AR+sD1361t69xgJDkybtw4iESyX6MslWeb8or3ePvjkRMdco4reVfgKAO5YwvjIcoXc
	svfkCkV7TVA0BC9gaINKYNlGRmm0aXXLws/uQnBAuDTo0+QCRUCfmfE9xchb17KCexv3+LhJUaf
	nVUdPP2LqMXQM4zxUuT4+m7M0wORMEdcwtoPbWHrk785KcIBg+ZBvqkYvWmdI49/tRxzewopyVR
	PwAgxD2FNliCcXNVbH8mOa4Pgjkj2Yiu3MSB1W009cjzChM3x/OIF5pDLK4k87a8iYk6S81tEXJ
	ixky+UchiTgmBW+d265vYr0P6fDWUisY/59GudJyCHPgdF3+X3YQee9+8hcL7CFOOOa51pmq3PB
	TZ9AeGZwxM6YB4gKrrdOjnLQSlAhvu5P1MMA0toIeQkKD5k8jZ46+ix8m6OorgnNR+U6JFgiG9V
	ATUq85wvtkvsFCN5mc+Hj6iQIDxqEh6LbQhQC6gKf372ZvrTp95KW4dyzdzPkE
X-Received: by 2002:a05:620a:628e:b0:930:a38d:4030 with SMTP id af79cd13be357-93671eae149mr628522585a.29.1786126818655;
        Fri, 07 Aug 2026 11:20:18 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e02d54esm204051085a.6.2026.08.07.11.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:20:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wsPB3-00000001Bmx-1xNi;
	Fri, 07 Aug 2026 15:20:17 -0300
Date: Fri, 7 Aug 2026 15:20:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <20260807182017.GH200537@ziepe.ca>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
 <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com>
 <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anYgXSR4VAi3TpOj@google.com>

On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:

> But the whole thing is best effort anyway, the kernel picks
> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> how many devices or how much DMA they do.
> SWIOTLB memory is wasted if unused so we should be careful around
> that as it would be the other way around and users would have to
> decrease it manually.

Yeah, it is why the arch code shouldn't really be sizing it directly,
it should be done in common code and, yes, we are probably going to
have to do something alot smarter to have the common code better
auto-tune this for the CC case..

Jason
