Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0CC25F7A5
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540112; cv=none; b=FbvuWoLyzKrlCgym/Ok4w6PvjyCraVRd53F3l3IEFlChgE+/LSPX9pG48NrAhrW0eFg8hGIwdPx9FRdXj4oN4Hc2AamiKvUGFUSjS9tnFLb3/XOKhCTIrwSwrqiPg8UuEPTP2CDgyN5Zv9cHDax4WnZdy/rcFMD1t2F80GfOg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540112; c=relaxed/simple;
	bh=7Rc9j3LNiGnIyTeHz2J0Avp/KOXJP6cs2JgWLFyvSoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD22UZ+KuRkka832Vts3ewnmywTKvceph5XwHbZBWM+8/tIyvYCS247GpxkfYMO9wyKHROZlnLhhW3BArj+Kymt1J8GDAHHINw2ZSoWoZFcP5XAhXaU4qYrQAZFjBA9KlbEOlFtavexKAuOTlkzzA4goOLrr0j97f768Aj1mORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OlAEzPOr; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OlAEzPOr"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506cb1b63d0so67770681cf.2
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 04:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772540110; x=1773144910; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MM4W4u3ny+cRpfXrxu8DnH970Z9q8VF2tWXlyBc85c=;
        b=OlAEzPOrBC6oDLtL95+/y0ofItDQ6BTJOw59di0uOKb3cP9aYPYFBLl3hRZP3LER/Q
         NKYe6Ee6sBN8+U/Wny71PK9mi2M1IMkIs0lyFdHcIW34YaiacTiMMwz8IA9Sz42HQB06
         scSO7dWLMWun8KchwR6b8WlPG5ksbtLqiNcwV2LfQNavQY2pXJP6nSRHMFu2aqP22xBH
         gCCaZl6cp43+hk4Gm1SvMwJiQQ7mg+t838l83yy2YAjLZReNcn/PGCqyJH3l8fRU0lIm
         J8y4ay8mpoFwHMqRGYgfMbxlh1gugO5nat7E3Xiu0QEYJ0BRaBllcE9l0YXai8S14d/z
         7D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772540110; x=1773144910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MM4W4u3ny+cRpfXrxu8DnH970Z9q8VF2tWXlyBc85c=;
        b=MzH7jlfiOFfDkHKSFbglZtj7x0USY0bQZtXsRDMpFdIjhJal2mXC9yu2JC9H9hf7wY
         oBP5CMK882JJmgMmeLwjDARtDKquFSJeB2UVoDww94f1XL8WnOglFoV91TTSD3Ld+AKT
         ShY2UYwhW/y5GsN6Advciz3btXPH768kGvLLO5yPs2oEVzSc9PaCihUfNPa66644RF25
         hCR8UNpPiM5aExgqOq8D3pUEI5aEzYWy/1TEYYtcohO/4gVBlhu+LyDPzH7jGMvMEYMt
         010vqHJuHvz1TVhSqCCTO1CkLvxBkkE+HmUFQdgi7FZWTO6gqQHL7MeeqZXkHwzVlvfy
         j1bw==
X-Forwarded-Encrypted: i=1; AJvYcCVDTX4aVSkMUyqlqXGnDVAnwg3g32WliMg9sYjV/esNovDhKBnDIwuCPKeUVioUWnbYE9fUUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDTA6sIhZSdjck6A/9JkWyJSzPgQAcEHp3/iaBDkRwEWqv4sr9
	rvVasUuU0gc9MnLiMm1TREqsNhsiGTYfpows9cUKi/D/F1VYxTnWHx55jkkRYh3L9BU=
X-Gm-Gg: ATEYQzzsV3NoTK3/uoBJ+CKmi4TdNKLm47UiB1w4ot4bXbuXvSNuymnTTRDUJAvtjWi
	qsqC3lzi0r6qPLnJ4RemK8/FPc8Z0/R0b4NOz+88na7auXx4TQrMGJIlzz0Uszwh/Rz8Z3QDQyF
	ZR3HXh5XfhiKzPugR9jh58FpYbTv0Sr2ib2zXDf3VV2UStz6YUFuRYzRF3jEXupPJitFqNoNzzN
	Uoa96JgNAYuBoGotFlNbV8fye2ftlKIzl+lx+mr6Iqi+eYlUCMEUOCEdqQ043yn5hwwBwAx+AJ5
	2pDWElSqTQ4JWOLVWmr8Unlpuof1YnfvshBtOx41WeTZCUkxR3pAG1xrer9h2vNGPKgp0egeg4J
	Y+B0AITHtYu9wrb67Gh1a4+/sqkRq67K/sHmQL+mbTCsVe84+ZUBt6/9YQtRLmHgOsb/zpgHuHF
	Rl9klJhym5gSXZMUY9XfHaX6T1Zd/dmavsKaDJktO8oRwIkLs5TePLcyx6KKMNzL/+0svXpd776
	vFUhgem
X-Received: by 2002:ac8:5908:0:b0:506:a287:a87 with SMTP id d75a77b69052e-50752849955mr200806971cf.40.1772540110255;
        Tue, 03 Mar 2026 04:15:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5075feb4db9sm79588961cf.22.2026.03.03.04.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 04:15:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vxOea-00000004CWJ-1Uzg;
	Tue, 03 Mar 2026 08:15:08 -0400
Date: Tue, 3 Mar 2026 08:15:08 -0400
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
Message-ID: <20260303121508.GD964116@ziepe.ca>
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-7-aik@amd.com>
 <d8102507-e537-4e7c-8137-082a43fd270d@arm.com>
 <20260228000630.GN44359@ziepe.ca>
 <2a5b2d8c-7359-42bd-9e8e-2c3efacee747@amd.com>
 <20260302003535.GU44359@ziepe.ca>
 <500e3174-9aa1-464a-b933-f0bcc2ddde68@amd.com>
 <20260302133527.GV44359@ziepe.ca>
 <9cf2e2e6-0fe2-4804-9c62-bc60c89d57c1@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf2e2e6-0fe2-4804-9c62-bc60c89d57c1@amd.com>

On Tue, Mar 03, 2026 at 07:19:36PM +1100, Alexey Kardashevskiy wrote:

> > It seems from your email that the CPU S2 has the Cbit as part of the
> > address and the S1 feeds it through to the S2, so it is genuinely has
> > two addres spaces?
> 
> S1/S2 PTEs have Cbit. Addresses to look up those PTEs - do not.

So we are back to what I was saying before: using phys_addr_t to
encode a PTE bit is probably a very confusing idea - especially when
contrasted with the other arches that have a legitimate address bit.

> > Same way it knows if there is no S1?
> 
> If no S1 - then sDTE decides on Cbit for the entire ASID (with the help of vTOM).

Sounds like the intention was the IOMMU shared/private space would be
controlled with vTOM which actually does a create a legitimate address
bit in the phys_addr_t.

A sDTE global control is OK for non-TDISP devices, or even devices
that haven't entered RUN yet, but it is not OK for a TDISP device that
must still be able to access shared memory.

> I understand I am often confusing, trying to unconfuse (including myself)... Thanks,

It seems to me the AMD architecture itself is pretty confusing. :\

Jason
 
 
