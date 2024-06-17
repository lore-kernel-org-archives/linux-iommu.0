Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16EB15B14F
	for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635164; cv=none; b=hQSgjh5aCVqP2U3He6kdbGyJEIbXQFQFvLLTTTbc6IYr2XXF1H05AGzFtmrq1MuLyxkuZURozBUwctCXRbSC7vs7oTOfW3pzO5oqiHCHttU3mg0jk9QOeMapJRAMi9ONinvM+N7gXzVcVt6/SB6fwCIzCu1peSTn7uoVUKj/2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635164; c=relaxed/simple;
	bh=V0ydNrFGcnxQcEaU5sMS6EBIm5WNR4Oj0pZJxqEWp7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXVOVl/mYu1mazzTKS7hhcEbjfIwqABq/GCxnEbJn2o+mdn1yyXH2dQWUh0cm+MauNnSgIJQjmqd8/GKE1hQAQ6OG7oOU9+goSL0BNa+xLoxNgNm0hAqNc1L/5laQP0Xh0Begs1CoBYASarW6BUYPfETSBfGLTmiomnC4pPL+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M7x/es4w; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M7x/es4w"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f9923df5dbso2552868a34.2
        for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718635162; x=1719239962; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0ydNrFGcnxQcEaU5sMS6EBIm5WNR4Oj0pZJxqEWp7E=;
        b=M7x/es4wlwW6CefrC7cTl4uSK6jtmLuZ6wm5ko6BY9t5sHsJHbJUiZaP7vBdZgv7Fh
         3w2BEvKzLoDdkPZDkLj/x5R7/ZZiNPN40bEeWUjD89HnvL9/PDG/WzGNeKqQR2Pv0qr/
         OOhcILnRZSDBXwfdpgEd4rQDZXyhvK1qwoclX7LqDU9/smKBHzoWwig13usI2pVML0A2
         NcmeDPu694DHOiNoY1EXqQDSRyac8r7moiLBMpsqnS5IGjbd5pmKTOyRfSpf5t0Yy6pe
         yTxC2v4SDPJ9awZy0DgqYF5Jwk3EFg5WnAaiDnlAfwv+NmaVZUGSqV5ALHdUveKPtrN3
         NnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718635162; x=1719239962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0ydNrFGcnxQcEaU5sMS6EBIm5WNR4Oj0pZJxqEWp7E=;
        b=BI03t1Aq0j6Eu8HFF115cslf2P3Y5QInDNNn2ab1a9OV0U0HHQwClNMb06U4jELa93
         YWwjh95hmSx7rM6TqItQinPqUPl3ekhIR22xrPav9xDS4s8E1XK6b3HrXFY1sH3fJVe1
         g8X/MwtqwfLZ9Q9WVn3K/F1rddxommaBoEDDjy2UjooOR4qBWPZZ5I6IfRXpDVVY+HJf
         X6tcCrR2AlMmPJfrj5dPnrodjeMjsPrqMmN3et96XzYmyWlmVvojVSHBcWRY1HqJSkKW
         ZLErBUu3ciN0f/3DxYqkYoQ2FPugGHq3lRr7grO8UC9IsZ/GveUvIGa0kuyc/bVcH529
         D78Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTHGcFSkRI9RqrTUmCS039sZMRiPGtgAdh0ETTQIuAsQm0kWgZyz3M7qaRK2CiKJ6oZMkg+LpFwqLBdemtpYG9kxH8pUM=
X-Gm-Message-State: AOJu0YyZsmTKBrvWh3o3Gl8usQYcmGJsC0K2dClq+4dvXTrba2FXJ5wJ
	ZxHc50N/qfMiL22FYpTFx0xDB0lliuHYGfrceZMX6W78eSqF6u/45hv1lfb4w+E=
X-Google-Smtp-Source: AGHT+IET1ur2Hbq+9cJMAg5HnRNV4tbPcm/2Ccc2KuGpX71T8/mhLJfk7K1KJMmzd/D0+4LvUiLm7Q==
X-Received: by 2002:a9d:7388:0:b0:6f9:cf25:d6fe with SMTP id 46e09a7af769-6fb939fbe5emr11889679a34.24.1718635161757;
        Mon, 17 Jun 2024 07:39:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c58e31sm56074816d6.72.2024.06.17.07.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:39:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJDVw-008kP7-Ol;
	Mon, 17 Jun 2024 11:39:20 -0300
Date: Mon, 17 Jun 2024 11:39:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, tjeznach@rivosinc.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	kevin.tian@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 04/10] iommu/riscv: add iotlb_sync_map operation
 support
Message-ID: <20240617143920.GD791043@ziepe.ca>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-5-zong.li@sifive.com>
 <a1a99374-dc40-4d57-9773-e660dc33beb2@linux.intel.com>
 <CANXhq0pQuoriKfHF51fXUtrZLkJBNOCe6M8Z6JbDjoRvbe1nWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0pQuoriKfHF51fXUtrZLkJBNOCe6M8Z6JbDjoRvbe1nWg@mail.gmail.com>

On Mon, Jun 17, 2024 at 09:43:35PM +0800, Zong Li wrote:

> I added it for updating the MSI mapping when we change the irq
> affinity of a pass-through device to another vCPU. The RISC-V IOMMU
> spec allows MSI translation to go through the MSI flat table, MRIF, or
> the normal page table. In the case of the normal page table, the MSI
> mapping is created in the second-stage page table, mapping the GPA of
> the guest's supervisor interrupt file to the HPA of host's guest
> interrupt file. This MSI mapping needs to be updated when the HPA of
> host's guest interrupt file is changed.

It sounds like more thought is needed for the MSI architecture, having
the host read the guest page table to mirror weird MSI stuff seems
kind of wrong..

The S2 really needs to have the correct physical MSI pages statically
at boot time.

Jason
