Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC0145A01
	for <iommu@lists.linux.dev>; Thu, 16 May 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859729; cv=none; b=tE99Xg4YARqnL4MxaYcdMYLojwifJSrXn6Gdpoxaxya4v30+Q+4fLFLhCgcBOpL9V1tlz082ghN9RkAvSrEQphuIE2VwUVFNXdtuCuo2gUvJoaNAJZZJEK5Gf1Ua4Rq1weIDxvAD8hlO1RDExOXIda+Qa9ZRhDqREsdZLkwWsgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859729; c=relaxed/simple;
	bh=NSfyT0Gs1FAv8AytyIHVbbNnX2pciDwvMHWsM6/tgxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrxg6PoTcy7wsFvikpNvTyewqQIhFaYc7BviUSL1Gk787j1HEMFSXITzaeZDrN3BfuolzoP7Vj8Za2XnElUOk4NZ3eier7v8GHKezCt/kb7J3NKzFT4vOLwY3dR9xkHL/1BtwEidRWHccTe5/7lPrb1Msl4dJZv3tKTAVKLOz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fnsj2Uit; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnsj2Uit"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so5659671fa.0
        for <iommu@lists.linux.dev>; Thu, 16 May 2024 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715859725; x=1716464525; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Qama3VZjcFeoB3/3gxCMfJagw4b+jGrPyMrffchcbY=;
        b=fnsj2UitVGOgixkdJinMiSC7x7khRpbL7fE5EhBKDfZ6PbVyDe9gqgkuEpVr9tGiCG
         Ir55i1ICSPdhZPftUitQIOQrNhf0naSQdUXxT+inFTBbX4nsfozO9KNJsJkjZt9b3/v2
         Y+VBmTmN3byu0pSdSczfy9af+vYlDMIA0li0fL9oU38WMhCarRVBf9NafVzie7AfWRRM
         ALm3umku2u1HrUEUcOCNqSMrEH4EZMMkJ/z1/WZvKkwUOY9MMU4j0jDmj/xU8YYl51Nm
         VuTg3cxibg2HNOdMMWoDJ6R21Y6FyfJXTTUnA3d50idubV1wN7qPDMWhl1M53AguR7Z2
         a6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715859725; x=1716464525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Qama3VZjcFeoB3/3gxCMfJagw4b+jGrPyMrffchcbY=;
        b=dd+LBTVc6HRv4+X0MrUkc2sIlazqPc3XLyR++mgWqO/zIB5yt4JlWuVhJ8kCX74ft7
         vbG9gpgkLLGrnBCUIhskdgO88AXGQ1N1Z+u9YT9LNzOjWTSU6+fZd55RycNWU01G7FNm
         XzFNPQ7ondqwAIX/lDy4tmXI4LqaOq1tahCzOEE5u5nDbQaLlRkTcmqHdMJ7K+FlWSBL
         JGTvV4xg4s+3bbkedbJtgd1WaSNAGX5G8+olkv2oxyz5YPyQ1zCw8LkswJIGPz1IvZu7
         MhjtA/cjZkZFs4vGrL82f11ck+JuNYL2358IFKVSyMQeGmf1Zx2lX0BQ5pSZgMUMy4zl
         DpzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo8x+xrwGt9VNMRrcJkDIzmwRJDLOKhcYHUUed2Xq66df9MxgGbTjLzuegYol9Mx1/3MNAolZoifzeG/V1F9vvIpmlzyc=
X-Gm-Message-State: AOJu0YyZpKIIZyf1wi7/BRGSGLK41PfIWYwv54A1hYrdenYiCPd4uB+1
	+1Sy1zEejKiC8q0A+8m7JfWx2aW9BB8cL7O376iQNhH44pdf5LyFbxAw5j9p/iw=
X-Google-Smtp-Source: AGHT+IFr1zVjdK7K16AgALnOgUt1S1AfB42I67YFPLAWXkf7y20RmbEGmkYsokzWNXk2gyfEhqCHoA==
X-Received: by 2002:a2e:905a:0:b0:2e4:5f13:dc48 with SMTP id 38308e7fff4ca-2e5203a45e3mr123286001fa.38.1715859725611;
        Thu, 16 May 2024 04:42:05 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42012276231sm166586685e9.26.2024.05.16.04.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 04:42:05 -0700 (PDT)
Date: Thu, 16 May 2024 12:42:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	"will@kernel.org" <will@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"liviu.dudau@arm.com" <liviu.dudau@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Ketan Patil <ketanp@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable PCIe ATS for devicetree boot
Message-ID: <20240516114203.GA3655402@myrica>
References: <PH8PR12MB6674391D5067B469B0400C26B8EC2@PH8PR12MB6674.namprd12.prod.outlook.com>
 <20240515185241.GA2131384@bhelgaas>
 <20240516073500.GA3563602@myrica>
 <ZkXi2LCy9ZZkupjM@bogus>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkXi2LCy9ZZkupjM@bogus>

On Thu, May 16, 2024 at 11:41:28AM +0100, Sudeep Holla wrote:
> On Thu, May 16, 2024 at 08:35:00AM +0100, Jean-Philippe Brucker wrote:
> > Hi,
> > 
> > On Wed, May 15, 2024 at 01:52:41PM -0500, Bjorn Helgaas wrote:
> > > On Wed, May 15, 2024 at 06:28:15PM +0000, Vidya Sagar wrote:
> > > > Thanks, Jean for this series.
> > > > May I know the current status of it?
> > > > Although it was actively reviewed, I see that its current status is set to 
> > > > 'Handled Elsewhere' in https://patchwork.kernel.org/project/linux-pci/list/?series=848836&state=*
> > > > What is the plan to get this series accepted?
> > > 
> > > I probably marked it "handled elsewhere" in the PCI patchwork because
> > > it doesn't touch PCI files (the binding has already been reviewed by
> > > Rob and Liviu), so I assumed the iommu folks would take the series.
> > > I don't know how they track patches.
> > 
> > Yes I think this can go through the IOMMU tree. Since patch 3 is still
> > missing an Ack, I'm resendng the series next cycle.
> > 
> 
> Extremely sorry for that, since I saw Liviu on the thread, I assumed he
> would have acked/reviewed 3/3 as well but now I see that is not the case.
> That said, you must not delay the change just for the DTS file changes.
> Anyways I will ack it now.

Thanks Sudeep!  It's no problem really, I sent the series very late in the
cycle so wasn't really aiming for 6.10 anyway

Thanks,
Jean
