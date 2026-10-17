Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170ED35E93B
	for <iommu@lists.linux.dev>; Sat, 17 Oct 2026 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792259356; cv=none; b=BIwOxY8PRAsaXlNIdvgtW3ETs+ALs7G2ObmoZ5PhkHjQHkYGjGVXl3mSabHLwn0Gd0EdMIg96Cwyt7iVRrn+z4u+EMUs5IA7VnV6snUK3Y0HIpyvNLFMHz/Fn1/CLLBvYHPPQYUJfj8CSsAPRt+hTjBPNFgGK/wOSMVje/d9s0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792259356; c=relaxed/simple;
	bh=9iVYwkAnCtZ3hFTHC7pQKEPigp9IEaagz00Mkpk73RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdjRrrL22hkwmtkdC0xcrQV5AFRw9bIodr/9KqdXPZqaLsc3yT6lTR00f8wUdNr4N8PC1Zs14FuJqAR+2HlIQikX9SuFgOLTuDri4c4skE59kBWyzx6oilGn+DCLioN9aSfbyiKd3Heyzfoglt8NT+5YndudU3XylvFEL+zPSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EeG3nYv1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EeG3nYv1"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91bb5795792so4287266d6.2
        for <iommu@lists.linux.dev>; Sat, 17 Oct 2026 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792259354; x=1792864154; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ZKiIqr2wNuyAPe6hCnVLHZyBqqQ8TWVMIEldJ82jWw=;
        b=EeG3nYv1MNZIroHep9FKj8muQu2pcDk1iN8n/p3fptvZcQERhZXVHzgdI+DOtodAPo
         xb09CU9hihy+rhfn5zwFgzEkUmZUVlmblyOlN8cD2K9n5yWnDLVnfH/aNZrChFiLkhiF
         vT28h3QS7j1ZFdTV+QL1Hkb/vgROay66JVo3Ruj95Xo5AcE24GCBLln0k8Q/LvwtIrCb
         DI+ZQcksX6Jv0mmHgTFE01AT5Opt6PRfw7c+V3wGZ82QvbMD3ejNPTrNIcmcN253vrAj
         0riPnMmXQbcpkBkuauKbH8EQuiXyADhbplvy7ZDKteYaPhyJ85cBsnQJSchGu+QjbRE4
         BcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792259354; x=1792864154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ZKiIqr2wNuyAPe6hCnVLHZyBqqQ8TWVMIEldJ82jWw=;
        b=qTcqRUNXdW+VyKtd0JIRHzd/OQoIGeYRfq0bjfNGkaNrXTMcBobgPaM6BPOx3wHsCt
         gYiPqdAo5sitOAdb8cbawAN0z1O/TvFeiB+Nt7WtBWfNB9KnrXXMViSOpfGvXuJ6ocT9
         g/OQcIdkvu19WULu+WAxgu2H/OcvrpXyYaUB5uAzQ/0OWsrdAffP+Jf2C6/Yy59jx+fi
         6cMGP6ZCX5TnszDdf4r/aopwVRRQ4o9AHkli/d/Sk9+VbLc/gLt3OVhu/94AaXOa3vSa
         hTDM8a1BUlJknExze4B7EdMexqE/4AbmJr1xomhuuzWQW4BwAV9SpoMO55KGxfyxqwr5
         OnsA==
X-Forwarded-Encrypted: i=1; AKwUvBzm1vWBWaFRC+wsFDVQNo3QADTOzgeAZkxxRSCU/1OeeqCff2HuhGro6emSuwq2tlMfWSGxzw==@lists.linux.dev
X-Gm-Message-State: AFq9FYITHZ4P/jsMecng1bEyEz4Ybw1wzVi7KmhRF9YhX1ozZngpql7y
	wZn1HemQe7i5Dx6+IZJ/35Nn/kUFXsVx6tlgkRSHkcItec0OjanzKnE4U2XXfuWM/ys=
X-Gm-Gg: AYBFou3ujdaXIY5YuO4jjkCmT+eGJba9EwrORRL7HlpAYgdK640PaRFe8lrCda7njqx
	wdPVmsDo4qklrpjcFcBivCJJThVnMyw4qldFwO3YmJdSYnxrHZ5RTWhcw97KtNZOkRsQIlZ+vry
	lXMDlaoywnjA3Vqu2NuFDVT3iOMasZgVMA876U1DDrC2QyCCXzMm+AsjvpUMBLhbTDr3FV6iRgr
	HW8gHtF6ERnlmBoTwQvvIPNUxpLBaG5EqO62XwUvMOiBiPSkonT+Fwq8r3dB2WGZJcjQATwE5k2
	cNGcAO/VbgxfXQakxWQb+aalp4YNRKmEm8wq5YAORYnpX190yEz9c41pWCgfMjQhjkw2nIXtRLh
	D0uV2RAy42U6P5qWOdzpVYhfYU3GzzNqd4Ln4lMtEirS7n06x0d5vMtyGBxhtYzOV9CjJLp5b0t
	gKsXcKRJULVGNB45MQYjEGLtoFTESxfc8q528OqAdlyrG4hZz/bi6pkRiY5WZI17PwPm5Oq6/si
	OkKvlf9Cjmyagik624dCO6UzQxREK7/OrnWzFkcaKuI13iO3hiB9oDh
X-Received: by 2002:a05:620a:45a2:b0:93e:c12c:9dcd with SMTP id af79cd13be357-93f29deb855mr546221985a.77.1792259353931;
        Sat, 17 Oct 2026 10:49:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f2f045ca4sm171937385a.29.2026.10.17.10.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 10:49:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xI8Wu-00000004sUa-33rg;
	Sat, 17 Oct 2026 14:49:12 -0300
Date: Sat, 17 Oct 2026 14:49:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <20261017174912.GK14213@ziepe.ca>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
 <ar6gY9grmdMZcN/M@nvidia.com>
 <20261002164748.GD3481470@ziepe.ca>
 <asAeCz_rmpe5hbsh@google.com>
 <asUvUf4PZJ7JCLXp@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asUvUf4PZJ7JCLXp@nvidia.com>

On Tue, Oct 06, 2026 at 10:26:41AM -0700, Nicolin Chen wrote:
> > pci_dev_reset_iommu_prepare/done() pair (with slight refactoring) in EP's
> > suspend/resume?
> 
> That sounds right to me, though a different API for suspend/resume
> will be required. And call them in pci_pm_runtime_suspend/resume()
> maybe.
> 
> Jason, how do you think about this?

Maybe lets just start by refusing power management when ATS is on? For
PCIe devices too?

It isn't just ARM that has this issue, every iommu is busted if you
suspend the PCI device while an ATS domain is still active..

Jason
