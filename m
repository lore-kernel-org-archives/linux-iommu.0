Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B382488
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641830; cv=none; b=eVeBdrkV+pbOx3MYRXalzpiq5ZKRun8E0duDfXqPj4v82lOr9s15GS4ZRmxjqVt38S0MwGnlri2QMqy8szafR5ZLp2B6Tg5nbXV/cWSsyqd7LmPwVXMu6L5NGT75j9gds+GDYmZHokhDfScOFtIYbAp3nP50UxT0KUhwuPN3qMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641830; c=relaxed/simple;
	bh=1WDDb0G+Go3P3Dw5AcG0i87vAB3ot81JQmWmWx52LiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F63S0+Wx1L/8q9yWCLpZ4MSZ9Jm8J6H9n1CKv0ywR0xCD4tLR7FUYIu2+bgiDyslTVbvG+IrFyQhXJplJn7sm38CPQEt3F+g3YSyx5EroQsBVCcY6nbEBr37rGaKDT37NiqjjfcB35rziPQElDU4ApWXmeocDXyjReEPUmEwing=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aV9EZ1/J; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aV9EZ1/J"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1edf506b216so33488735ad.2
        for <iommu@lists.linux.dev>; Mon, 13 May 2024 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715641828; x=1716246628; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqUtHMhIHZ+cDddS0kGh4AWHOaBRInzG3LMW1ryk5e0=;
        b=aV9EZ1/J+mqIrnQ0ejN3Yz/oC6PJNz5kzltfWyW8oErNJ+TOXgFiLKUMRhpNi4me6J
         Fzuzjl5seh0C0W/dY8QMGtLWHUVj7sNjRLrxAy1/Eg2d7e5wPQ4He+WNXSIuYNm7qrAF
         XAkdi2KDTse7yRok4bQ2v41F4nKzGIhGY/XrEMyhDOrswNHaKXKLs0MPF4Revr/ePieH
         4cBTfHKjjUSKqFWKmSfkSSu/yitcaJWPe+pHudbTyjJizrRei+dt/t6GUQJJnidmbe9h
         wFv0cs+BPTKQjza0ZruNQRjuA2jO2TVDMeJzMaua5nnttCuCkFH+YMAnMs/4DwGqr/HA
         yYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715641828; x=1716246628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqUtHMhIHZ+cDddS0kGh4AWHOaBRInzG3LMW1ryk5e0=;
        b=gMl1ArgXYL8YrZiz19kv7E8EZPK99eM5REc1F+rJGMuiElAllOXG1HMgpzp780cW4Y
         c4Bx/WPgJiJuUOBdF0ZpLUhjjgVHGgbw9ruZVBF7r8MW+N+wMZTaJyRJBk/4CNO17W8H
         6jtKtNkBAnfcJmKsibr2MEiuWYm4Ekg6df2iP2lALNzZwV3nF9vHDcLeuaxnTgwm/M5g
         gTvBS58cd/9+jwyorncQFLZ3xXDjkoHIu4/FXcn6khSXsdEG49MKsTOCnncy0uUaxIkD
         qeeDuLuw8CY97kjcNd1Sld/AWKu3R0zR1R6jE+N1NHv0GR5MYhw2XZX7AcZLDyyDGobP
         yGCw==
X-Forwarded-Encrypted: i=1; AJvYcCV8VaV3fVU8piVMmrh4ZBMVDrYenqre0Y5JLUfNUgrjO4Nt1miai0N8Cxy5yWD62LXJUcABSuj3oIpZuYF0NzGIckqVHl4=
X-Gm-Message-State: AOJu0YykRq+4qHGWvdaajUecUXxW1bkXy51mgPmOA7USC96DTG35jL/w
	s9+LIjPJbaXQPtwEyymCMdI+GftvdNh6i4SJqqEZbkOPxSH/oMb6FUBbAhISYGw=
X-Google-Smtp-Source: AGHT+IGYgJZTZtNiduqAOvB6Tm4M/yJ8HythCJeRBzJLhT8PXhf/vrWofASJznIm3W5oA28r520mtQ==
X-Received: by 2002:a17:902:650e:b0:1e9:a0ce:f618 with SMTP id d9443c01a7336-1ef442ba9c5mr109684375ad.69.1715641828258;
        Mon, 13 May 2024 16:10:28 -0700 (PDT)
Received: from ziepe.ca ([50.204.89.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d3b0fsm84494655ad.22.2024.05.13.16.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:10:27 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s6eoN-0001gR-2Z;
	Mon, 13 May 2024 20:10:27 -0300
Date: Mon, 13 May 2024 20:10:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	thomas.lendacky@amd.com, vasant.hegde@amd.com, michael.roth@amd.com,
	jon.grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH 9/9] iommu/amd: Set default domain to IDENTITY_DOMAIN
 when running in SEV guest
Message-ID: <ZkKd49lPHj1WhBXp@ziepe.ca>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
 <20240430152430.4245-10-suravee.suthikulpanit@amd.com>
 <20240501141737.GB1723318@ziepe.ca>
 <aacaa02c-0e58-4a0c-b180-f201f483b70b@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacaa02c-0e58-4a0c-b180-f201f483b70b@amd.com>

On Mon, May 13, 2024 at 07:17:49PM +0700, Suthikulpanit, Suravee wrote:
> Jason,
> 
> On 5/1/2024 9:17 PM, Jason Gunthorpe wrote:
> > On Tue, Apr 30, 2024 at 03:24:30PM +0000, Suravee Suthikulpanit wrote:
> > > Since SEV guest depends on the unencrypted swiotlb bounce buffer
> > > to support DMA, the guest AMD IOMMU driver must be force to setup to
> > > pass-through mode.
> > 
> > You should block the creation of paging domains as well if the HW
> > can't support them.
> 
> Sure, I'll add a logic to check and block domain creation.
> 
> > But, is there actually a functional problem here? Doesn't swiotlb work
> > OK with iommu even with the encrypted memory cases? What is missing if
> > not?
> 
> Currently, SEV guest is default to use SWIOTLB. This does not have any
> issues.
> 
> However, in order to support vcpus w/ x2APIC ID (> 255) in a guest, it
> requires guest interrupt remapping support. This is achieved by adding
> QEMU-emulated AMD or Intel vIOMMU models.
> 
> In case of AMD IOMMU, depending on the CONFIG_IOMMU_DEFAULT_PASSTHROUGH
> kernel config, it would default to setup the v1 table for DMA remapping,
> which is not supported in the SEV guest (since it requires to use SWIOTLB).

But this just means you are inserting an iommu hw that is totally
non-working. I'd expect that the iommu continues to work correctly but
cannot access any encrypted pages..

If it is unusable do you even need to allow it to probe to any
drivers? Nothing works so there isn't much point to binding devices to
the iommu..?

Jason
