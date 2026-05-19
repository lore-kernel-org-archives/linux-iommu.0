Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A24DC52C
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201793; cv=none; b=ZTXIdnDgsxxchkbZNsOezY97a9Iwoc5DPsXPV1zUYQtP46moDpw+p6lQYygmN17k0gYmhP9ow6nrBl7FDokn5QroSmbAobH/KfWtTdb3RKEyV9PzSw7Rq54ePM1ZqD8Fls1O3v+auyq7FkEq6jvmNjqV0GZ4oi8sNRWhBQGfEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201793; c=relaxed/simple;
	bh=/6T9OxCp9BfBAX39R91Thab8mMF0XqoU64D3P4OeBeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Huqex+eaV2CfRYCB63I6G314z6rd9nA59KO68V574S/FcyBh1bs+PphrvnzdaSkbwjNPkCyjO7COxO/zOurr6twIydzdxV/5ySgUxQEjhf5IZJGactegF4BXCjbuiAZTOhaYgoe1GBS6BYjEUkO4+L5D9YeD5U4sHqtWZ8dw0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bguqNznx; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bguqNznx"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-910bb291688so454450485a.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201790; x=1779806590; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXdhVWEeXcyE6eZ570qB7rBPR0o0acgN6kYHC3GZbqY=;
        b=bguqNznxoQfJk6r5soYx8vf4fUkOSybqqJdJAMfVWyZm3RI7ewiM+CtB/H/lCJT00E
         KnVtmn/Z/nHoUPtMD5ilSzE+PSHcB4ahbFbG83fuovr1PnMHHgH3dSAAQ2O/Pa0sQBh9
         2C+waHjEPACa+ds8LfN7LBlbnHQpJFsAJvpNm7qYxr856BQW9o1uywged8Zm9o0IDRyq
         qQIYkY7Uw8AsJd+tSrunNAtg82oTgLfqMsRWV45AibId1VPFoBQ5hsySbNSFHkApICwA
         EKku05aCod8P89UwYi5OzCmR8FvhwlXz4TgyqAOs7GHvUPXLXkfVDwaonnxKnxPrNRDh
         8hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201790; x=1779806590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXdhVWEeXcyE6eZ570qB7rBPR0o0acgN6kYHC3GZbqY=;
        b=Hpev54FtnKhZxyp1nt9Ledw3RNqHlZD3u8GptxzNnrY6TgyXG7COSGuW/GnnUoo7Sa
         Yxx9AOieNO35X/HdarCEWVR+Xold1HJhbgKfUa4vclPG+K3V8dvU+9tIXqAmPWB8DvVZ
         gxF0mlRnSFWRXOA7I+YiVRrolxFuBgVtiKB4hGUGH/z4TpR/XFY3/RElh0x7qlFOPaw0
         GkZ14Yv/KTXDIJ7lBm+iwqJfd0+CmhdlUyZDgqk1JzYZwGBGovEk1CwSepLoGwz6GAcY
         lBIDCtH8brzczlOdt7H/VArMFRJQhOCQICuoVWLvMunDWvBl2UjRfHdcCGFumtY25qZg
         PrKw==
X-Gm-Message-State: AOJu0Yy8j+N25S2F8KJ8e77cuYn/WM6iT5KHA7u+gzW6YeofMesQWyDr
	YG6zqTXCr6FKVJSWmCgAjLZc/rRIzghMyEil5SasMlCHF87oi/1G1cH1sr/8cZKvdRQ=
X-Gm-Gg: Acq92OF4ns3RCP/BQVwmrkXUUefj/oppc9PZ6WNhEDHaHcrTELnWYlD+OuAVtyqKNGQ
	LH4I2bdlXiMPKY5wlmMo4yV6RDaVP1qqM89zCXdl2HaOOYFrHCBV+Zgq8gOx+KEwZp4173Hrpul
	ExOOVFRqndskj+E1R4htMeMbipDtRgX3ymewgi0oABRt4PReXBR0UtnYVKYbJIXpnCjOW5hMuFA
	C9D2kqb34jTeSagRVBqfXPQXMAYKAvJskUT4HMj9lOeB1n+z9QOLDsfLL/ej4YXSBFzWEUcslGl
	jD0Y9OUgwk7Z8GfjocBaJy/lWoMCF6oBWnSmupvQc53+lnHDj2qBBJON0+QXezCzr8nZu5i8L7N
	wUofrQ0QyImB4DVDJ5dx2TchTw+mLMejH4I3JOvVCP+F29udqD5p1YDtlzv34zzAPouXqtkEk8g
	LQYVHJmKOm2nTQKfK46bqeyyUB0k9WZPFwjNjta2YHTDIcWlNnEffPOEoLuSCOPvXs5HBghV4qN
	6c+dQ==
X-Received: by 2002:a05:620a:2685:b0:908:e262:52c3 with SMTP id af79cd13be357-911cef034cdmr2991227885a.46.1779201789618;
        Tue, 19 May 2026 07:43:09 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba181322sm1861707685a.7.2026.05.19.07.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:43:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLf2-0000000F8WO-2rlK;
	Tue, 19 May 2026 11:43:08 -0300
Date: Tue, 19 May 2026 11:43:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 2/3] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
Message-ID: <20260519144308.GH7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-3-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519135323.1558777-3-praan@google.com>

On Tue, May 19, 2026 at 01:53:21PM +0000, Pranjal Shrivastava wrote:
> While every PCI Function that implements ATS has an independent ATS
> Extended Capability structure with a Read/Write Smallest Translation
> Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
> driver to configure the STU on the Physical Function (PF) before any
> any Virtual Functions (VFs) are created.
> 
> Currently, pci_prepare_ats() bails out early for VFs, assuming that the
> PF has already been correctly prepared. However, this creates a potential
> mismatch if a VF is subsequently prepared with a different page shift.

I would be clearer here, this is not a "mismatch", it reflects a
kernel bug.

> Update pci_prepare_ats() to validate that the requested page shift (ps)
> matches the STU already configured in the associated PF. This ensures
> early detection of incompatible configurations and maintains the kernel's
> policy of consistent STU sizing across all functions associated with a
> given SMMU.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/pci/ats.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
