Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250144;
	b=y0AHxe1CYqLS/23yD2yurY8B9EI8DTDj0PirhQEsZ9Uvgp4+7trrS2F+iRzlbdNS2l9K
	 5mGyKlDQAYHN2Kfpx6tWuzr2F5B2DNvTRu2pn1yMJRJ9n5sNGELvE5Ip0YB2O/9cFHu6L
	 3X2v7ESS/bzatG/dE27GU/pAVgL2CZWBXFEZM3kV1Jk3+aV/n2Nh5xVTpIDRmRoREPlEg
	 ykNRNiFqo2TK74Mi9HcvwF29wUpApxsJCXO5MZrcCH5BlZBog/1+Rgmv8i+bpGy16gpMj
	 n+GIYO4Ovy59kzhwnolojBbo9M+u0nQy56wk3jx6fOPw6SceeFpQLgVxcmkCYB3I4tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=O+PQWQ9PbJFOCn9EB5efiBTAKX4GJUUBrxAtO9OF3Dc=;
	b=xP+2ksW16mXBlyvYBMfToVPrhWpgf9kBznUImZEJbfkDhN6rjqIcboB2i2Flgs6URQ/T
	 Z6amm7oBprhScpO24ar6wBBCK+hZUmJCN0BqwHeUQdO+CvtOLCRfpoCpdt7+bed0eZnz4
	 nK1/BdIOQnFge9pa0WN11wqLVDXqDQrm/dotxjyc38fWfISJF+SbVC9As2cxYqySYZojH
	 p4h6b/PJhlvEqz9h+sJk+3cTQGJ/rjv18iD/R1b0PWs9u34v6uRxZT6jkYDdFpYCwrmUd
	 pHfVQWZSMfKN1zYVF9N1Ar/11Vu90geEtnKx9IAcPzuZZmPzd7tadpWxVFgdTgaP9Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=OSTrvkxy;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1434C606A326
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 18:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1434C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=OSTrvkxy
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-536c8f958d7so9490521cf.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 10:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794250143; x=1794854943; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O+PQWQ9PbJFOCn9EB5efiBTAKX4GJUUBrxAtO9OF3Dc=;
        b=OSTrvkxyStCzAPKHkk0BZhcp8cPjvkzNM33CaX9Tf5sRm7KiDf6/de7adnd3irxDNN
         GKx1dEJI5f3BOszlnz9VRCADc25zjksNVVjFVvc8geoBYncULhNb5loZAoc3ZvWHlk89
         hxv9g9N/TwO1WmBFkpnODafKy4YizPO6ErItRK4FE6fWe/fnLLf4BLehSsWyYiQxHRjX
         h0q2duE+0ii2SHECaouZ84c23nW/5jB3Z7xkaaeRsiNtjXhSHSdoptfKZKxjtrXV4Vh7
         acIriQP0IQBtgnBIsfkrTOIlY5RxDpHOYa1BbY3+GjPjiQFJREQ5bowVIkCUm6jHkhoX
         Nsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794250143; x=1794854943;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O+PQWQ9PbJFOCn9EB5efiBTAKX4GJUUBrxAtO9OF3Dc=;
        b=aUGV1IM+UhXOKRd/fFPfDUlwofpTifkNGIh2QQ4UqoTBTNCRf/6lyUZctZlna5KShc
         wBsZmhAZYy+z6m2uFyNvs+yHZHx+IMn0e1B/LH6ug2KRn8+xqyLjbJ2ifS4BDMQTcwDG
         In/cmrBTsxGlcpFWbvCT2A4+lr86mlbvvRq2oT10NYlbB3nsM+8RxFgTBawwkwAdLGxx
         AEBrBujUZlcyurMbNuaCcpXlNxBj4JES2C8rzaH6zmG+LxP99DgArCaEp4C8OiLC488o
         Xop0K66HVQ20nG+j/s14rw72XpSL3e+mKDvrtysVcXLS2per38B0zmEId/XBglKjFNR6
         cYGQ==
X-Forwarded-Encrypted: i=1; AL+hErE7Rt83ZfOmu/veluPJOyqcKl6HPfSXqTlG/tpRdsXnjMjXtukwOUDSGuXY+GDGitI/Bnj5Fw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8rHCDzwAPJA7dzQGb2kYgpXfYmOkCjOEO0nluLk1bJan9/i8q3
	TPhqzWfQHkcBugXcoJUowQGP0n3hs5u7Dl2EePiWWorVzeu4SxENGTl6OuLuFK7wj90=
X-Gm-Gg: AYBFou26ZG9wieaZNpe0I5GhLct0X5h8KgsCXHHVIvw+hPnsHBYDAAHXLFPvsOSLh/t
	ddoAi8prTMNuW3wePgvbQ7Ogn9KmEnhQZ9KEfprKbXYgVk32sYTGTCIklVNYmLBz61JOKln8y9x
	xhxnRjKa+IJAANYRgZ5CqidqrLr0e1J41E6tweC6wlWbfQwq/XVtuYMstQFANStvyqhxXRiAltL
	6q2qmrdvi/D0eOiXTPX+3wcKB/WeMHWDGpjjP6ZRGEIsm22G2XCLyGtzPk9zL6ZTRRVIzmxmM9v
	7rKR6bfPeLGDAuD62gpKqaEqkfeMo1hfpHW6Rl494E8oJRRkLftd4NB4jKaNBMdSzpXdVdzXunZ
	YUFTeSUEpqj1ivPkVuWLIlNw7Y1tZh6DPyMrVBdNtBxdpUndwjl8WaKLJYCK6cciHP+fakuf7iT
	5GKQ6rbot49aj9scCuZadDaTOwiQUKbOsv0qUn8L8KMi2546RtPYyJIJ/059/aKHJc+mS9c0+JO
	35VZn0Quo1hE7yyq98IuZlrrPlh5LImb1mNHz9PQIQnaMyqBa6G5/A8YS78YrWZaM33Auy89irU
	A+pnSsXlXcRRYKgJ0WYLdBH/bw0lftlZBjzxFn5QpeYtNeCUNoAQ1otL2bMMpnsp1jpTKc7FvSk
	khvLfSpU20smi4PYenPsk9gouscoH6VU=
X-Received: by 2002:a05:622a:40e:b0:536:3600:f0af with SMTP id d75a77b69052e-555253df92fmr3996711cf.7.1794250142846;
        Mon, 09 Nov 2026 10:49:02 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af60493sm3967801cf.4.2026.11.09.10.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:49:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQUQP-00000002A6b-35np;
	Mon, 09 Nov 2026 14:49:01 -0400
Date: Mon, 9 Nov 2026 14:49:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v8 12/15] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
Message-ID: <20261109184901.GQ663069@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-13-aneesh.kumar@kernel.org>
 <20261104152351.00002565@linux.microsoft.com>
 <20261105004934.GE3889730@ziepe.ca>
 <20261105091622.00004a9c@linux.microsoft.com>
 <CO1PR11MB48352506BB91C461F25147098C762@CO1PR11MB4835.namprd11.prod.outlook.com>
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
In-Reply-To: <CO1PR11MB48352506BB91C461F25147098C762@CO1PR11MB4835.namprd11.prod.outlook.com>

On Fri, Nov 06, 2026 at 08:03:48AM +0000, Tian, Kevin wrote:
> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Friday, November 6, 2026 1:16 AM
> > 
> > Hi Jason,
> > 
> > On Wed, 4 Nov 2026 20:49:34 -0400
> > Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > > On Wed, Nov 04, 2026 at 03:23:51PM -0800, Jacob Pan wrote:
> > >
> > > > I am thinking MSHV/pKVM can register an assignment-only tsm_dev to
> > > > leverage this? Could PCI/TSM support this role without
> > > > device-security?
> > >
> > > It is certainly not what TSM was originally imagined for, but with our
> > > new arrangement, yah maybe so?
> > I will rebase on this set and send out patches for a detailed review.
> > 
> > > TSM basically just becomes this weird overlay driver on the PCI device
> > > that does stuff. Some of the stuff it might do:
> > >  - Register an attestation subsystem device to do SPDM
> > >  - Register to allow iommufd to create a viommu
> > >  - Some status sysfs ?
> > >  - ??
> > >
> > So we may expand pci tsm to have more than one role? currently it has
> > one.
> > int pci_tsm_register(struct tsm_dev *tsm_dev) {
> > ...
> > 	roles = is_link_tsm(tsm_dev) + is_devsec_tsm(tsm_dev) +
> > 		is_assignment_tsm(tsm_dev);
> > 	if (roles != 1)
> > 		return -EINVAL;
> 
> Not sure what'd be a proper name for this, but it sounds to me that
> it tries to over-abstract something into tsm. The reused logic related
> to assignment or viommu is relatively small, so the other option below
> sounds better if it can work.
> 
> Or it may be the original provider framework that Aneesh proposed,
> so tsm/MSHV/pKVM can each register its own backend...

That is definately undesirable for TSM

I think the very best answer for this is to get the viommu from the
"kvm" fd, I just don't quite know how you implement it..

Maybe just register something like a notifier chain where the struct
file * and the viommu type value goes in and a viommu object comes
back out?

Jason
