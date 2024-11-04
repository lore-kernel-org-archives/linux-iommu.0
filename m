Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED31AF0BB
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725214; cv=none; b=pCvyX48ojHe812T77CBLRdrLPQJlkTOG3emLpLhABhtFhF+3XZRh67k3FjYEopzpt3ETl/battLXAMJKGQ3TVeiGdWutXvrhXdoyRf4hbkuMnizetkq3xcAEZaZLD+zqRKyIwdBCg4qXYhZI5pno7hE1hOPV9EmQyxdzVkrCfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725214; c=relaxed/simple;
	bh=L+EGisSPUD9tN9fyrt+Fm/ZTB69LOdQhO31vrdXZvlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXMTAwGv/VTGhsRAmr1JjomkhIocDB2opttiGFPNjVpx0OlDXC5mmIW25/HAwv8I1mYBeNvCMi4A9Yiwr+mf14Wz5znvIa/XZgxENL/wQJLtamt/5IEY26wWjtD71aAtIFD2vIqaaWkIEUq4hbhPDV979odLk1UnBqa+vHRoDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=k+N6fTE4; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="k+N6fTE4"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e5f9712991so1887739b6e.2
        for <iommu@lists.linux.dev>; Mon, 04 Nov 2024 05:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730725212; x=1731330012; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D85xQiYplOl/lLwSIlNTX6yVoYLo3NvP+w7RapkdIR0=;
        b=k+N6fTE4ZEiiQdICQlWF4mYsfF8lxnQymbeVFu0LnYbher6q9CPXVTbLdf8e3Vjmb0
         bJPDgQ2m3CdRlrx0GhKxy78P0mWjUndN92wq2Lj0SyegXdZ9oX4VANdaZq32vtTEAIPR
         REs02cBhMwpEFG7Ol6rgRCIc/rEXN5+gZRtISzutsztjcAK6aejxsus6TkDJWlwasYCr
         i79hJwXm43Pbyuuzt+rlik0ZIfoVywhrySppMVEkLcewXtCOh1MpGX5AmARni88Qx5wW
         nBdrYsgPwmWptmHlxIZwd/Rc1Qzvwdh40vKeZJbr6TSK2TzhRl0/SAtuhyXW7zEAp2v6
         pwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730725212; x=1731330012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D85xQiYplOl/lLwSIlNTX6yVoYLo3NvP+w7RapkdIR0=;
        b=wb1wAwC8tpW29NgssCiBWK4zSm7H/jTdZvy7tKRYhzzKM09SkGaE/ylkXgXaAajPNn
         4FmRAwF8b8QYb+oW0p9aHQRHCPzcoHfz8ixlSB0bjVxzwZ/8XJfQn9xigDCkULLfGLiq
         q7ltCh5oHWY8/Z09R5bYFbd4+RfPmyBof5MOlVyJCs+Mtn7OU2ZR95eXlwLmVCg2JXXl
         bt96NUur5hVUTDvgzY/XBalCvRzK/1fcco1dw0jvqetx2ooPmJV8yRlT10fnJx4JtfhM
         heJrvDFDPyiLUzVrz8L16tfsWJfCfSzFd/TDtzWbyve6Z9NklKUwvejHMZf2uOQLXz+t
         ychQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhKRcbQgEYLVHMbzHYWZK2nPIBvi2fKDpGopY8cN8++rJQ3bIh/fQlnv7FoyBVFeZO0IBh0g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+jSshD2ILeg514S3bRRomTat9Vp1j06t96nkE0ntSil/EOfUo
	VfAs8eMVthsjknM5wa1HdrSBuCcUfR2AwifkexuPQlJOK+U8MFO6nYAHnaRbXeg=
X-Google-Smtp-Source: AGHT+IEsOehBbhKvtzVymOA1MjhlkfmyQrOqjHBJ9OIDfFQs9tk2WoBgYZ3/d/FwxGd/eC4Y/sN09g==
X-Received: by 2002:a05:6808:23c9:b0:3e5:dba3:2480 with SMTP id 5614622812f47-3e758c5a8a2mr9460367b6e.15.1730725212293;
        Mon, 04 Nov 2024 05:00:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fef918sm47647116d6.73.2024.11.04.05.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:00:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t7wgl-00000000hTj-0A8B;
	Mon, 04 Nov 2024 09:00:11 -0400
Date: Mon, 4 Nov 2024 09:00:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"yi.l.liu@intel.com" <yi.l.liu@intel.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>
Subject: Re: [RFC PATCH 05/13] iommufd: Serialise persisted iommufds and ioas
Message-ID: <20241104130011.GD35848@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-6-jgowans@amazon.com>
 <20241016152047.2a604f08@DESKTOP-0403QTC.>
 <20241028090311.54bc537f@DESKTOP-0403QTC.>
 <1f50020d9bd74ab8315cec473d3e6285d0fc8259.camel@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f50020d9bd74ab8315cec473d3e6285d0fc8259.camel@amazon.com>

On Sat, Nov 02, 2024 at 10:22:54AM +0000, Gowans, James wrote:

> Yes, I think the guidance was to bind a device to iommufd in noiommu
> mode. It does seem a bit weird to use iommufd with noiommu, but we
> agreed it's the best/simplest way to get the functionality. 

noiommu should still have an ioas and still have kernel managed page
pinning.

My remark to bring it to iommufd was to also make it a fully
architected feature and stop relying on mprotect and /proc/ tricks.

> Then as you suggest below the IOMMUFD_OBJ_DEVICE would be serialised
> too in some way, probably by iommufd telling the PCI layer that this
> device must be persistent and hence not to re-probe it on kexec.

Presumably VFIO would be doing some/most of this part since it is the
driver that will be binding?

> It's all a bit hand wavy at the moment, but something along those lines
> probably makes sense. I need to work on rev2 of this RFC as per Jason's
> feedback in the other thread. Rev2 will make the restore path more
> userspace driven, with fresh iommufd and pgtables objects being created
> and then atomically swapped over too. I'll also get the PCI layer
> involved with rev2. Once that's out (it'll be a few weeks as I'm on
> leave) then let's take a look at how the noiommu device persistence case
> would fit in.

In a certain sense it would be nice to see the noiommu flow as it
breaks apart the problem into the first dependency:

 How to get the device handed across the kexec and safely land back in
 VFIO, and only VFIO's hands.

Preserving the iommu HW configuration is an incremental step built on
that base line.

Also, FWIW, this needs to follow good open source practices - we need
an open userspace for the feature and the kernel stuff should be
merged in a logical order.

Jason
