Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA442BE7DD
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733497; cv=none; b=ToVFr4M2kfNi6D3O2oVCKcXERAs5dpyOkuc7LErIh+GXVi3PM23wReokvZOxZtGa25FV9TOwhIijo1snqmCTGSlxgqUq03c+yiW4iPNKJYQqRAz+ZxzjuB4mpBFxCzVnN6qkRCS1cdCFiJS/WjBZUk97Mfo6nFAU9Nd7JcVAk+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733497; c=relaxed/simple;
	bh=s1lDql1VXnlCt+ybH6i0BOOo/feEGB/hjnRQ3YgjUvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gd/2RvB38tlqzGCX62Gw6l+sSQv2zPEYBfreHvae7Sn+Zpxsm4pvcarE/Rc6/YUR/Ztnabp5n/BCP6xv/BMhhoFh5ciQ/NKbPkPPFQi/PrtA0X58u7rA3Qz5Q6s4kJngz7OcpKAjCBRhAQOAA9GuC0jB5E7f/7EuaQReL7HFg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fq+vKd/W; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fq+vKd/W"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb767d286so5794471cf.2
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789733495; x=1790338295; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i+QN5KkkjNb5WJjRU9SzJ0Y+OF8nxYNyQV24JJbuLlA=;
        b=fq+vKd/WFw451pgY7Wq9I/NKKWEsnCzm2t2JlLWh4INsKWNxeYsUahK6S3Mm4Y2jQr
         VIpgnLwx7QoMyNxdZLde2BU1IqmuWj/rsmnNZ94U30UJPyX/LJTUw9/iK9cnpwkus9+9
         Sq1bYsiQ0bLKprAZMNIDLS30os2IMGv5R6mmKWSARCSjNFp+LfNkgo7yTJUr8hRZRQqL
         pUuX1GPjvUKTIwJUNSmEQDD0kz6UsVxOQODfI9VdQp/kzoQJwzryKDKCONLQAcAey0wP
         KCNtNYFJPaL166JkRI7FrB+cMD1SS4MIPxjvk/ZYGnMSQEwvfeUz6R+qJObYliEcjMIK
         PD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789733495; x=1790338295;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+QN5KkkjNb5WJjRU9SzJ0Y+OF8nxYNyQV24JJbuLlA=;
        b=jfoH6tZF19vy212AjiD/x11gGnTEFc/ndWzFM8s6no5vC5HcpVD5GY2//mDccuYWxb
         4EvSCna+fkR2blTTvt8UuXeiYUwA+VEgGsuARXtlTE0NZ99eCPIER8su1+olxxfKjznz
         4fVI/mS2l99dWtGvwj3zhYSNsIrUj/CNh6Zxal2KqoWdNbkm+we4lE3uplQADstkU26d
         0nuaR0OpfP4bdMdwNH3gDf2kwXX0ZEfTiDH8xFLTBX3Y4eH6L/f1RQnXqbh5+tSDLuae
         Y6MTWAApxOPgRQQ2+Z09Vdf59OVMohZSvZTIIf5NTR6lnKqfFCaVyysO3J2e8ZpVKt8R
         5Pgg==
X-Forwarded-Encrypted: i=1; AKwUvBwyDPtMba59HbtMHh6I/pUZolokFW7uvd5VVyFNuc9TewfivKDe1MiEhrc4BY523weG4rytPg==@lists.linux.dev
X-Gm-Message-State: AFuF++kJ2qudzG+A2JJLaUu2NrpkhQqPsIB4z4uyoVCgjCSlv7N3zJMh
	/sE3jBjBaV35AWfK6xio68Txiea0cu/PBNWhK2kx7tIejzri1foTlQoqBDIEWzQN2n4KdrPLqsv
	FcTob
X-Gm-Gg: AYBFou3NX1ZNu25hRFZIGFqxIiB3wrmxYBat7uWWelx4PiEeW0k9Da17ufDTM0h3DRE
	sQ0TRdT0cYFgTVn0k9YUQ92V8PcpTyKGFB/e5lZIyb7ALTL/gxpLOlQGTAZtof1LTjWoNC+LYPt
	Lpl+FXbwJgWpHcdkufg+INIn9jkXzCkncySyvjGUMqfd4q6dXTcDG/+gtu9JzRBY0fuvym7vMEW
	VZNjMiXzWWobtT7O21CaKyj4WPTHPAcf8fY1uuAozdETRCQWVEdlGfV9QUXGO3MRtlY8v/SwoaL
	Le/+L74bBqI8yxYXMKe1Lf+UgbKW8k8CayJhxl9QG3dCfNh9g2t4LZqplG2tI2TqEVUWBX2RrGw
	T7Zlk+JQnTKFf4XNWimZz8INOAnP0kC2m9YHkrGtaib1zpQ/zePm10imZ1eDHqJuLuavg3fM0/S
	8SxtnpXNkU786688Szh4apWLg143qjWzdhn1TbmVHc/Twgui5tbT7SpySfWAQopVZCZ4UrDWGW/
	uufMeQA6qEWRiG/IKS7ZQIAjKwBfbQ43qW5I8BBPn7ajG7rdwRiRG7g
X-Received: by 2002:ac8:5c95:0:b0:532:9ade:b6e5 with SMTP id d75a77b69052e-5329e58dffdmr33222601cf.78.1789733494642;
        Fri, 18 Sep 2026 05:11:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532a1a27288sm12168121cf.28.2026.09.18.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:11:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7XRE-00000001A2N-2VCC;
	Fri, 18 Sep 2026 09:11:32 -0300
Date: Fri, 18 Sep 2026 09:11:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Frank Li <frank.li@nxp.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 0/4] iommu/arm-smmu-v3: Support shared Stream IDs
Message-ID: <20260918121132.GA11599@ziepe.ca>
References: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
 <20260916161018.GE3196566@ziepe.ca>
 <aqtDg1EH95RYOdCJ@shlinux89>
 <20260917144804.GI3196566@ziepe.ca>
 <aq0lEk56qRi93geW@shlinux89>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq0lEk56qRi93geW@shlinux89>

On Fri, Sep 18, 2026 at 07:48:34PM +0800, Peng Fan wrote:

> However, the DMA channel case was just one example - the shared-SID
> need exists independently of it. Our SoC (i.MX95) has only 64 SIDs
> total, serving MMC, SD, NET, PCI, DMA, NPU, DSP, DISPLAY and more.
> Some of these are genuinely separate platform devices (distinct DT
> nodes, distinct drivers) that share a SID by hardware design because
> the SID space is exhausted.
> 
> That cross-IP case cannot be solved by DT restructuring - the devices
> really are separate. Would you be open to reviewing the shared-SID
> SMMU support (patches 1-4) on that basis, independent of the DMA
> channel question?

I think you should revise your commit message/cover letter to focus on
something that is not a DT abuse and try again 

IIRC Robin said the SID aliasing was a PITA on SMMUv2 so it
really needs to have a strong reason.

Jason
