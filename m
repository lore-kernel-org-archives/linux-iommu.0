Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9B1DEFD4
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737383207; cv=none; b=Q3u2kvGLeASr0qLHTA2GdZQ6l3SMAokPg//IkFA8ya4bG1y2YmcUqKwHvYTv9SE472URMAwawq8TY6I4dXXrJrP5KZmokNJ6OSZlz4q7uW9azmnc8FHCFADEuTvaymgzQxO+uGlSVer4Gs7i3zrox3Z3hXROHqrXQ+cMCNQe8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737383207; c=relaxed/simple;
	bh=tv0Xp3xiPoEPgBSdoRMHuXoCTFjFb60HbGfkmSrhd+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyZYc0asOnlnmL7v/mLf4wYnfJMQ4+5oQ6oOHGja8Uued8PAAG/qCeVhq/44awzBUncDaU2VRsIlq0tWU/pYGPVxNxIwvH7MM/sHO5a+HDd5pOCThzqJoQTHbmxthtkEBc3GO1xwJ425BJMBhzIdBSVCiJB232ZBd1m1DPaSN5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mdAoAjoK; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mdAoAjoK"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be3f230436so421560785a.3
        for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 06:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737383205; x=1737988005; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vr2EIyCsdB5gdGa7/0WwIe6wMDGX9eJ5N6s6izoCruk=;
        b=mdAoAjoKY9l1leoJwuqzvCD7v+GHoxym6GGZwNoP70t3SJPPuhCcU+1fhTruDAzvRU
         NVmLNQTSNRev4cO1J167L88D7/xoqxhSN77fj2c8eYyM5NGiwn+5owSVHJdYpY7YeIJP
         Xvc1PTk0n3xKlxXFnYZo8/JOMpEC0kLWTzf5KRFdZhBMI8Yjzw0B1gtb4jhZJbQsdMeb
         ZIgmlwhhf2KZPK2H+7ozTDsCGKbDzHmZYhIVj18lANgcsTaGgIALu8XBdn6zVO0hadK+
         SOHWCeJbzjLtaVZBAhzBzTJ9fFQ/CRREMCAmcD1PrbiSxZKbCMrGc0P7zkb4I4vZH526
         N6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737383205; x=1737988005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vr2EIyCsdB5gdGa7/0WwIe6wMDGX9eJ5N6s6izoCruk=;
        b=aXo+IWbmPQHMcznvnIILotEHzFVi9gjkMlAsnYY32rxnaAeM5ShgZ+KI1UxI+HsifY
         o2WPFpmqH3tyx3W1/bumB/UcIgoT/7OQ036Lsv6VjFbMyLBrhCF5SDvgnUeP+VZ6X1x1
         jLTt06YJPS6diCOCSIinzDiJfTwyip48Mir2QerhRrHBYANMR0n6VH14br+wVSUx1Rfv
         8HtqwvgI4msauinPQ/+chPWy6WgnZ3XzeR1EoQO1kwi5OxWnaVj6cMV4c63KutRUQhLW
         /N7CKBrsnOzhNdbKpmYTchxXJLF9SBxjF/DvzpbHBATtx+3MBgiVeUaHmyaLQZwW3OFo
         vIgA==
X-Gm-Message-State: AOJu0YzbrqqWl/sduLOuvZ2jjJYo1WUefEFkUy6MgJOK8pR1bQb6wCYB
	z87+F+GK5/kCi/f9w5sP2ErOAaS0pqno3G2G29DNHY6c2JIILhApvUGtK8Ficn0=
X-Gm-Gg: ASbGncvhHjWM1DnMjOBXg3SZnG1ges8gS1oqcp2vcE/F8A5LMFZ8+Busz9TQwCJhatm
	joFEwddRqbM+rRWb0Xkea1iR2qV5fI3luFtEY2X8pVZ9oNvb3LHRuj0PjKJrPRG4E7VB2m3e02a
	+QiXGy6WNSZjbISHB4PNr/cQI5f1rO6mXcwsOquVOU/x1LBR3mDyeJDM4H6TYeQkdwV5//dGlmK
	H2ktkEKyjzvCpdHzv0dvSCTlwOpQMppL8Fx4Sep7x42B+/0TCgyMhmOzAcV4/iFB3RSv9eIG+6U
	7Mv8n/8iMXXNEk23iFnC/pdHEWFlmklpWAMtTdm4hCA=
X-Google-Smtp-Source: AGHT+IGtvIsUesTGjb37GoPOTTbLeWODGXjdLhV2Jx7A+73Ah5xBJFQ5DKfLkBk9bBAu2jSA4Q8O9Q==
X-Received: by 2002:a05:620a:4513:b0:7b6:c462:6b82 with SMTP id af79cd13be357-7be63288222mr2782957385a.54.1737383205075;
        Mon, 20 Jan 2025 06:26:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be6148931bsm446023485a.65.2025.01.20.06.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:26:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tZsjj-00000003PkA-2hgf;
	Mon, 20 Jan 2025 10:26:43 -0400
Date: Mon, 20 Jan 2025 10:26:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	will@kernel.org, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH 0/3] make MSI IOVA base address and its length
 configurable
Message-ID: <20250120142643.GM674319@ziepe.ca>
References: <20250116232307.1436693-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116232307.1436693-1-shyamsaini@linux.microsoft.com>

On Thu, Jan 16, 2025 at 03:23:04PM -0800, Shyam Saini wrote:
> Hi,
> 
> Currently, the MSI_IOVA_BASE address is hard-coded to 0x80000000,
> assuming that all platforms have this address available for MSI IOVA
> reservation. However, this is not always the case, as some platforms
> reserve this address for other purposes.

Can you explain this some more? This address is in the kernel
controlled IOVA space, there are few ways a platform can impact this.

How is the platform impacting it? Is the non-functional IOVA always
reflected in the iommu_get_resv_regions()?

Why not avoid this conflict in your platform software?

> There was an [1] attempt to fix this problem by passing the MSI IOVA
> base as a kernel command line parameter. 

Yuk

> In the previous attempt,
> Will suggested reserving the MSI IOVA at runtime whenever there is a
> conflict with the default MSI_IOVA_BASE. However, dynamically reserving
> this address has debuggability concerns, as it becomes difficult to
> track IOMMU mapping failures.

Still, this approach seems like the best to me..

> This patch series aims to address the issue by introducing a new DTS
> property, "arm,smmu-pci-msi-iova-data". This property allows the
> configuration of MSI IOVA with a custom MSI base address and a custom
> length for IOMMU/SMMU drivers. It accommodates platforms that do not
> have the default MSI base address available for MSI reservation.

My understand was using DT to set kernel configurables was frowned
upon? Ultimately MSI_IOVA_BASE is an arbitary choice by kernel
software.

Jason
