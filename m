Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DEF19E7E8
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742380; cv=none; b=mOu49dHEhN9DJcIB+pFUpJ3Noh++0QEqVDS0O05BnHAGmSaVWkWNKhCjbsjnPSOmdYfyGL/oujHmWCjQ5Xri7gwAOkvTAgggCoFw564+S3jEKXtvkui9wvNi0MPetjfEIp7DjMXGbUWhyg1agqPYAum62JRFrG8l6mr2LgrrsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742380; c=relaxed/simple;
	bh=dafIEuKWl+LEXkEWjZkUgjPP9oOtLFYUT9TqZFovKRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip7GMI5n4PR3o7BMnyN4GD9ISk9CDLHqJ86DQI9l8tzHcPwj2IZyTucibUZ4RZZrxXJ7iTemlDKTSrFNwMsASHez5CMka1pAj93tvIgUIijrk8KJBieYy0B6M2/exoEKvZJShwkoHRubH5+l/UwG5ixcQZKQSY/kQfhKAa7uMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PLXWUT1H; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PLXWUT1H"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a4df9dc885so94348185a.0
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723742377; x=1724347177; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BqaSFAda1BULnUkvbkqjvUbbEFCCq1QGyMDyl6SYwo8=;
        b=PLXWUT1HvgJIc/0DA/uFEyiZ8r3nzUhZm96BOXRxMP56N/ZYDyYpQit9At+3sYJOEZ
         Oh/Qp8msr48CrvVaAS+YNKnjQpUFwcKRSG8AKPr0rFcoBWRgIIR09RqES9dVo/q2oHo0
         B3/b/x0LHiaqe9meK++qeKT7vzA4eHR4lCeygJlXhY+i/P6S4LVjjl3c6ke6K8l/fhL5
         rC80AjbAQumY1ZQx9Y/GbUqEvUh7Vcn3X3jx0RfVUxvA3Ug5R6nrcoC6XFlpjJ/RNvQN
         6NypwgZ84KxknILVSvVWm6Ii2GspDki4uYpfT6CJWtSpDaFmuF8Jdt8DSeNV2mvY14UU
         kWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742377; x=1724347177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqaSFAda1BULnUkvbkqjvUbbEFCCq1QGyMDyl6SYwo8=;
        b=Yiq2rdGf95To7vlyJBnqbKDgDV8aP8/Rf1SYAZoJxKq7j8riiWu7lZdlUxZKid/KQj
         z2iXzYw89cHX/8FRbJ9PS7J7roQZNDB2XPf6ABaSpUmOv/Hq25LsOzd9UoxIvIkgXjab
         R/fnduU7FnAVPoZwXDMhLyUxL3na+H8x1mD19RY304pD03+EdwNWsJscnrK8qys1zMXt
         mFMMYoITkEqWRTpk+/WZNj+eMawyV9Q3Gjhqrs/MCzRb9zBvfQV1MxFMuE1EHBg8qjqj
         jShVTm3bMlX8AEFat8Du+rhBWwvibH2iIyCUKs/RscVRcpwmD9RmM067mbOKLiH2qmjl
         14KA==
X-Forwarded-Encrypted: i=1; AJvYcCXna5b0LggUeX+X80Dh1ej5qyGJPZrMnouUVZDrewcVd34ve3VdjAU5P3Evg+yJsbvMain7a7XiXg9vs3A9h4T58ZIX8zE=
X-Gm-Message-State: AOJu0Ywu5sbB/jR3dQGejHGK7aEJAkix9g37Dtfeuz7WngD90O5wrtls
	qWSdW61mWQgLATtSyEo38CIpzJBoWvPbhKg0imMzp5gUXNt9/j/SwNLxtI3eiFA=
X-Google-Smtp-Source: AGHT+IGEGC1/A/48dBre5gaeZ0zHau3OBx975u/klzSPGEReClcShxi3bAXTedaOfHOOcJfdHkXOVA==
X-Received: by 2002:a05:620a:294c:b0:79e:f745:5445 with SMTP id af79cd13be357-7a506ff0efbmr18473085a.31.1723742377586;
        Thu, 15 Aug 2024 10:19:37 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0dcac4sm80966585a.84.2024.08.15.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:19:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1see8N-004EaT-MX;
	Thu, 15 Aug 2024 14:19:35 -0300
Date: Thu, 15 Aug 2024 14:19:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
	kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
Message-ID: <20240815171935.GO3468552@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170045.1584000-1-alex.williamson@redhat.com>
 <20240813164341.GL1985367@ziepe.ca>
 <20240813150320.73df43d7.alex.williamson@redhat.com>
 <20240813233724.GS1985367@ziepe.ca>
 <20240815105905.19d69576.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815105905.19d69576.alex.williamson@redhat.com>

On Thu, Aug 15, 2024 at 10:59:05AM -0600, Alex Williamson wrote:

> > This is probably the only way to approach this, trap and emulate the
> > places in the device that program additional interrupt sources and do
> > a full MSI-like flow to set them up in the kernel.
> 
> Your last sentence here seems to agree with this approach, but
> everything else suggests disapproval, so I don't know where you're
> going here.

Trapping and emulating is fine.

My concern is really only about skipping SET_IRQ.

That works because of the assumption that the IMS sources are going to
re-use addr/data pairs setup in the MSI CAP.

That assumption is frail, and won't work at all under the proper IMS
support Linux now has.

I really don't want to go down the road and have someone tell Thomas
he can't convert the Linux driver to use irq_domain IMS because it
will break this stuff here.

> I have no specs for this device, nor any involvement from the device
> vendor, so the idea of creating a vfio-pci variant driver to setup an
> irq_domain and augment a device specific SET_IRQs ioctls not only sounds
> tremendously more complicated (host and VMM), it's simply not possible
> with the knowledge we have at hand.  

It seems like you have reverse engineered alot of the necessary
information though??

Maybe there is a more generic approach than a variant driver. If you
wanted to use IMS from userspace generically you could imagine some
kind of IMS focused "SET_IRQ" in generic VFIO. Where we'd create the
needed irq_domains and pass the addr/data pair back to userspace?

> I observe that the device configures MSI vectors and then writes that
> same vector address/data elsewhere into the device.  Whether the device
> can trigger those vectors based only on the MSI capability programming
> and a secondary source piggybacks on those vectors or if this is just a
> hack by Qualcomm to use an MSI capability to acquire some vectors which
> are exclusively used by the secondary hardware, I have no idea.

Well at least that should be testable - but it seems crazy if the
device has registers for an addr/data pair and then somehow doesn't
use the values that get put in them??

Copying from the MSI is almost certainly a SW hack because IMS support
has never really existed in an OS until now. I think your guess for
why it is like this is pretty good.

> I do not believe that introducing a vfio device feature that disables
> virtualization of the MSI address/data _only_ at the vfio interface
> (not to a QEMU VM) provides some implicit support of this device
> behavior.  These values are already available to a privileged user in
> the host and the same is available for an MSI-X use case by directly
> reading the MSI-X vector table.  

To be clear, I'm not really worried about showing the data to
userspace.

Userspace just shouldn't be using it to implement an IMS technique!

Jason
