Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0FE15D1
	for <iommu@lists.linux.dev>; Thu, 29 May 2025 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748479110; cv=none; b=FUPQOvSzmUQJ/hHFn4aB/e2X8cfP3Ij0DVg+DbDIoel1WO3c1MqIIHEERJInvVGV6iI4HOgGH1wprgxPcJOUT0kh+jLTF8tGBlCF38Tmshp89Q7mIu4hOS2FdSaUAZQqQV//XVkjmVpq3G4HSNXhzsWTLLsXmtP/Iu9qKAFhtR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748479110; c=relaxed/simple;
	bh=ze/vE+pLOw8LtKqumJmv32tL8OFv0ndyxShmm8Q5lTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRhE7yFJgVmnCUlbd5eEKaU/F54WDOElSmWI/TiGrZo4qOb6+/WgzlUk7Mur7mo+afiKXBmaVxHx8UodvaqpoLLFxKUqXiXU4J7JTMrTuXQrkbbekwyAYIU8vdSdwf+As66atnvb+FwrTh733WFpgVFf1OVJ6x4HyRDEShhz234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pH+kIo9J; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pH+kIo9J"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6faa9e72827so7326916d6.2
        for <iommu@lists.linux.dev>; Wed, 28 May 2025 17:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748479108; x=1749083908; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sVQkha02xf9SMmtYT1jV9HNI/f56xB5GG/vabKlGDf4=;
        b=pH+kIo9JCIM989xAeZgCTlHvTWVlV3FIi+EyRdOk30GYUcTtC1b1WxqmG3iktVw8u9
         mfKFJSEB54m8Y63LxACD4PssiWCsp3ZvRgIhUhLNvLLb0tF9xiM4H0Tn5ClQAZFniTsO
         0Vdhx1JN5hg6lWYCdTRRs4tMsYSwX7zYSQXUrDjiMeDR2bIrJwO0x5m7N3GCfSJA/DFs
         01om6YaSlJL+NBd1ZELL0nLVQFclw+Cg4YSWVfnChg7ISGG1Pg4SnfaeEu+cnQxRm1As
         OSX9Jp8i2WzdNcSCCD1f8VAs+pN4BJltOv0zAKuogPGlJMKVMMyJq7SKnaPnYn37+uv5
         y8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748479108; x=1749083908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVQkha02xf9SMmtYT1jV9HNI/f56xB5GG/vabKlGDf4=;
        b=K3DG4/3L+ylsQQ5ym0mdM2kqjAfEoze5FjKefM8+3YaKkQG8LUZz9vs6xDFWcWb7Ic
         2Q+3jX1j2+I252Chg0J74r3DCaghcRnTQUs5xWY8BkQ2ls5ERu6xa3RwGkBRo0r3/PLE
         lhW5NOKx/H1ym5yiZFcm5ll56UkYaW4cG//DxsQmjd8RyRK4hMw4/eR9cXS/u7h3sXXS
         NkF7GYYRnNUpqfBR6SXyjOP+zYbMYkezMLfMA0RgtcVu/8DpyRjD2+hOhb0fvFFLLKV6
         kzazU8sWCBNn6l7LcQRfH2yteqPMdXy+gEldR3dqcnGS1sRlY7EteKo6CB9GEE+7dreA
         F19Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWmuyCWFlISYyXQ0jgJDZ3tasLZiMiWb6BPvYjFcWkPfPbca3TEh+a6okOfICtfMXj7r+OtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr3h31GD0x1Zr+CgtC0om7GcKcxCi/TUd5TNPnSj2tAKwOHFG7
	wx4a7zHV4e7U7e3fnshPRaLZUgVcF8YGi4shSFE6yTtkkDxV2ydGYnVYZuAUpS0agV0=
X-Gm-Gg: ASbGncsKY3zjzAylTUGditQA0aV3EmAVD78b4Kl6ftYXiM4mAjM4T5MA5rXH+py+YHo
	v8MMBhA1d2Y7LtGAsLSPKDbkmkNFnRU6d9JfHMCBAzW/oQwXlF4QURcn24E0ORt5coi6UwG6JX3
	xAFi/Wv+HRUr7UibCG4/lRGO/B0p1Dp6OPiH/EmlDPZS+AIOXi+VkMASNDhiQ8CL1wJcxLnGHhX
	efHrHBDKQfk6kqgt2adDEYA2XUdQ+mg821+/ryvuH1TA+gjM9r6+at6XndkW0VeP6Cf96EdFCAv
	AhtWM0Wq1tLIooX6xcyWEuegZ9+dY5Yq1RwuD9VQ8K1OEDxWbDfRHyzey0gjpwLFt1smj8hPbOo
	EUEVSYpoyUCzLy3Jg1zonk8AR3cM=
X-Google-Smtp-Source: AGHT+IGrrQU6seLehXMngMNgswY4d6WsTh2X0qCSzttXJecRsw5bF1myMzmOuM/dLs2M8hI+8CLE1g==
X-Received: by 2002:a05:6214:234e:b0:6fa:c85a:20c0 with SMTP id 6a1803df08f44-6fac85a2328mr4035616d6.28.1748479107982;
        Wed, 28 May 2025 17:38:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d337aesm2521866d6.8.2025.05.28.17.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 17:38:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uKRHu-00000000qmU-32Wy;
	Wed, 28 May 2025 21:38:26 -0300
Date: Wed, 28 May 2025 21:38:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250529003826.GA192517@ziepe.ca>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
 <20250410230008.GA6905@ziepe.ca>
 <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250416181759.GF493866@ziepe.ca>
 <20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250525190703.GD12328@ziepe.ca>
 <20250527205428.GA14019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250528000425.GC146260@ziepe.ca>
 <68379171.170a0220.191ee0.8d6bSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68379171.170a0220.191ee0.8d6bSMTPIN_ADDED_BROKEN@mx.google.com>

On Wed, May 28, 2025 at 03:42:55PM -0700, Jacob Pan wrote:

> > All IOVA that the platform cannot DMA from should be reported in the
> > reserved_regions file as "reserved". You must make your platform
> > achieve this.
> > 
> Just to double confirm, the expected reserved region should be marked as
> "direct" instead of "msi", right?

I don't know, it depends what is wrong with this platform.

"msi" is the SW_MSI region created by the iommu driver, ignore it.

"reserved" should be from the DT and it says "my platform is broken,
this IOVA doesn't work, don't use it"

"direct" is something entirely different, it also should come from the
DT and it says "must be mapped 1:1 (iova:physical) at all times" which
usually means some FW or other component is controlling the device and
doing DMA using that physical memory space which is unknown to the OS.

Both cases would interfere with the MSI so if the DT/ACPI declares
such regions that overlap with the SW_MSI address then Linux should
select another SW_MSI address.

From a linux perspective "reserved" just ignores those IOVA spaces
while "direct" sets up 1:1 translations there. So FW using direct
incorrectly could become a security problem.

Jason
