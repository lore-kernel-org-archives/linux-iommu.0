Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACDA430B96
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458531; cv=none; b=ICkuRd7qP1Np8o/7haw6rH/V/Rmm50sSBWcCTf5ykuJmmumdwgZZGuX2M6/xx1ygJRNUEpf5NHLRnJgnx/6N8N36gYlGxEJF0uJuuZ5JdjlzhxLYZhrTzLT8ORRfyTmBrLDiUStjLKu2CiMcGBUPQDr8UosTUX8jMkBQfoWiaZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458531; c=relaxed/simple;
	bh=FbvCdNY37UamTN31SSyauOm8sq3E53gqKRjT2KA5HYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQRkVqR29Df6FPd76/Pb4n3hCWYJj5h6/yLJAy9j/hBdmPt0D053wSJAcWz0dAMSIJN6geD4inG2vwsthx5StyipDB3YJbASbMGpClJcAh9lESldNNkGC/1M5tsNTwbLaCb06k6og/f58T/GWjheevmaDsdApxdlKiTzU/YDsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=U4bw/Upu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U4bw/Upu"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899e43ae2e1so14097316d6.2
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 05:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772458529; x=1773063329; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+HFg2ochnrDtRr4Pe6iIPk9bCWPHCXlKNRCptQLo7I=;
        b=U4bw/Upu7yVBgtP5AWDqggoOxhGd3M24rlRpMvzzXy08y7dawgC9irW/q266yizPCS
         Vt3ATdOZuBXqGHDyxo7TWWeD375/UvKwKggGE+bIXT5Xv4KobFjU26UFdwpbg1FwEu2M
         4tpijnL7yYu15KLe1MQQa3kwMu8LosROPllyEjGffRZA4C3K8sDxXUhgTWZxMZawg0l+
         rwbj0OIpOFWYd/2Q9kqTK5m5u0pmG4vtf2aQrHqIrnUo4ASbQrcyHpv8koMD+Li+OmQX
         Hm5ispgO51yiSab3urqjFSl007b/Sk0CPDj7epgKmmOGfMi0I6TpyqZMCx0SEXEZSRV7
         ylBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458529; x=1773063329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+HFg2ochnrDtRr4Pe6iIPk9bCWPHCXlKNRCptQLo7I=;
        b=BVstL3y6/jpLa5a/ty2X8nFNHW7FHGGbr5uJXIbPRB0ryvjqSFozkLnTW+RU405XbW
         QbaB8XretdiufFNSxWonFqVbQQmwAhO55zJhOSKmtva/kcQFa8aDYWBC6jK6xO+0iY81
         MpgRsx9YKPWtXUHlvRHsiiutRgTuijkGirxNnPLgL2sZXFM5f+AShENOG33OV8v+eEmG
         LhoA0xT/ZbAIAxZDl+6NOj+iy2dLA1bge4UmyMNs9/0aiVyGBj/bEhGTSIMbQjpLwUyD
         bNon5Mj3x4EoJ0MzGxnkuWRiL+ug/f1wd3dkdj7WkWxGe/PpkQ1RxrvBB7u3VAjUxRX2
         E1uA==
X-Forwarded-Encrypted: i=1; AJvYcCUWRKats/2zk0RlpyFMtgarY0k8pVUVUTe2aWunziViIFF8Ky3sc2hacYZ5udj0hd0VkJYoJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+0BXfiax4xbxOEaOzW/EbAVH3b0QLk6nr7tzOH6cBDB1Ybbrj
	5fqI3tCLNUn+0bXix4Iu5q1yA4R1ad0VwMB20XZvzTYUBa7abhWtaV/3kgmvURJvHPc=
X-Gm-Gg: ATEYQzzYUQq1eOC97eU2KGPAW889vWb8W6gpFrz+7a/KddPue2C/7lWswcpLj3sY24b
	v7rVC/vCojT5sYY+bc9hr0FJax+u7JTtJuhhSHcGHc8XofIPmFysiRTKzfzhGcbzxpScuQOaQM8
	4Dmr9Meg9kvuL1HzPez0kK+Z4LadzvGs/tbu8zPPXATEnxMaBhOTgt8AoAvIsLBH81OMgv2g5Xw
	MdIqA7HeyfR7RO3vu9PxwDlDRm2pm+n2upwkLI0L1/ya7eLPWfl5purDwh/8tAMDDz6S3ihLUw+
	/AlY4mNfpG01yioI2Aa9c/ucSE+Qqog1wPb91pWHT2fHgWEVfPr/PZxJ1Dk3gruRXnmVxWYPNst
	0UuPLf8A+y/QLFk8JVWAYSaPU0n41grjuJYxgj0tq8uy4qmU0Ma49JfXxrJXW+7PbwyV+IbYMOL
	iISsnmSg0t2+MwoOGSVI9u7NjhdfCFXrViRN5iAzMc+k3W91gauXkQrSpkRSaL37zlAKUCo2Whv
	aEOMujF
X-Received: by 2002:a05:6214:21e1:b0:895:4b4f:133a with SMTP id 6a1803df08f44-899d1d8459dmr178895326d6.5.1772458528769;
        Mon, 02 Mar 2026 05:35:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f4fb208dsm35628906d6.28.2026.03.02.05.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:35:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vx3Ql-00000003fNz-1MAa;
	Mon, 02 Mar 2026 09:35:27 -0400
Date: Mon, 2 Mar 2026 09:35:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Melody Wang <huibo.wang@amd.com>,
	Seongman Lee <augustus92@kaist.ac.kr>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Andi Kleen <ak@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Denis Efremov <efremov@linux.com>,
	Geliang Tang <geliang@kernel.org>,
	Piotr Gregor <piotrgregor@rsyncme.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Arnd Bergmann <arnd@arndb.de>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kim Phillips <kim.phillips@amd.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Claire Chang <tientzu@chromium.org>, linux-coco@lists.linux.dev,
	iommu@lists.linux.dev, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH kernel 6/9] x86/dma-direct: Stop changing encrypted page
 state for TDISP devices
Message-ID: <20260302133527.GV44359@ziepe.ca>
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-7-aik@amd.com>
 <d8102507-e537-4e7c-8137-082a43fd270d@arm.com>
 <20260228000630.GN44359@ziepe.ca>
 <2a5b2d8c-7359-42bd-9e8e-2c3efacee747@amd.com>
 <20260302003535.GU44359@ziepe.ca>
 <500e3174-9aa1-464a-b933-f0bcc2ddde68@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500e3174-9aa1-464a-b933-f0bcc2ddde68@amd.com>

On Mon, Mar 02, 2026 at 04:26:58PM +1100, Alexey Kardashevskiy wrote:

> > > Without secure vIOMMU, no Cbit in the S2 table (==host) for any
> > > VM. SDTE (==IOMMU) decides on shared/private for the device,
> > > i.e. (device_cc_accepted()?private:shared).
> > 
> > Is this "Cbit" part of the CPU S2 page table address space or is it
> > actually some PTE bit that says it is "encrypted" ?
> > 
> > It is confusing when you say it would start working with a vIOMMU.
> 
> When I mention vIOMMU, I mean the S1 table which is guest owned and
> which has Cbit in PTEs.

Yes, I understand this.

It seems from your email that the CPU S2 has the Cbit as part of the
address and the S1 feeds it through to the S2, so it is genuinely has
two addres spaces?

While the IOMMU S1 does not and instead needs a PTE bit which is
emphatically not an address bit because it does not feed through the
S2?

> > If 1<<51 is a valid IOPTE, and it is an actually address, then it
> > should be mapped into the IOMMU S2, shouldn't it? If it is in the
> > IOMMU S2 then shouldn't it work as a dma_addr_t?
> 
> It should (and checked with the HW folks), I just have not tried it  as, like, whyyy.

Well, I think things work more sensibly if you don't have to mangle
the address..

> > But in this case I would expect the vIOMMU to also use the same GPA
> > space starting from 0 and also remove the C bit, as the S2 shouldn't
> > have mappings starting at 1<<51.
> 
> How would then IOMMU know if DMA targets private or shared memory?
> The Cbit does not participate in the S2 translation as an address
> bit but IOMMU still knows what it is.

Same way it knows if there is no S1? Why does the S1 change anything?

> > > There is vTOM in SDTE which is "every phys_addr_t above vTOM is no
> > > Cbit, below - with Cbit" (and there is the same thing for the CPU
> > > side in SEV) but this not it, right?
> > 
> > That seems like the IOMMU HW is specially handling the address bits in
> > some way?
> 
> Yeah there is this capability. Except everything below vTOM is
> private and every above is shared so SME mask for it would be
> reverse than the CPU SME mask :) Not using this thing though (not
> sure why we have it). Thanks,

Weird!!

Jason
