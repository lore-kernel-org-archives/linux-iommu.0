Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA818DF8C
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933016; cv=none; b=b6qDz3rCeZ5Ut+NJMQq9EQbYZopcVaX6RXxWti5jHFFFiY4oNMV65Bh866H2E7dXXrFFBtqi80CSEuJYJJcHZiHAB9R3OGFtV/hF5p0fM6psjFiFTdohsn37YbT4N7JFTa36lBivRp/xe6kOMWVbwPylIRtavPvf6n1wkKqiLf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933016; c=relaxed/simple;
	bh=u8awxGC8APLD2fBPkfXwUnekJ7v92Iejds6q48zmlhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb52CEK6NrGUzE0cghLfYu317JtKvfT//MvEFagvNskGabHcA2pDjPO3LkkHhqNs4wes8vnHe0cFO3KpYmKVsEGQntWbeouu8UB2LWV2Xd8EZPHqGar6FEcMF7GQP8x7iwMiO7xDuP3P9KAGhYQv2wsHbDv2qErNd4qzb9ziooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hjRnRAAA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hjRnRAAA"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a80511d206so25059585a.3
        for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724933014; x=1725537814; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8awxGC8APLD2fBPkfXwUnekJ7v92Iejds6q48zmlhU=;
        b=hjRnRAAA7hm1OxOEs/Wf39r3yBM13+HGhvSGdRpTdEvpgmGkeWJoFM5vNvOywoaAMv
         QEFlmlNKdmk6MeBfKoAHFM5EkCMcPZ7dUzESsRT6kRcPGjY7ah0GfWj/o3ATvF/lc5x/
         kNEEBONu1uiVEZVcpSh06Ph+vpLJSTSWYYKCm+BmX5wW3y+DmH8POlnSNA54nmDKOR//
         suqcJSW0+zmj0/jY7raezHl9p/Puj40lkbEb++RqEISi3BqE4XcJY2UiGVLm9pVOOWIO
         svu47IBoFlRRet18N5nS4j7geA/RA8hLjxskVLUYe7B1dqgV/5Psu7sJuzHKFLLXPM86
         1Awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724933014; x=1725537814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8awxGC8APLD2fBPkfXwUnekJ7v92Iejds6q48zmlhU=;
        b=d0N07ZTfEukrbRg+HNoSoxSVvn8qKe5heHAkk7+TbO6zvAeVanKJ2Qucys0nJjVPhu
         WiPP1vqC8OUSHYjvP0mo9xv7OdKHL7XzC8ofchWbu1Ntsm4C58mBrO40Zx3ESRgMCXvA
         QZ04Fy/JigPo+Vp/XbMHX3Gyp4PMOF+sdlOq+73je3BjMDw2w9EUMquQnfOTF7FzOTr2
         o0nbMsp1KACC82ogB9OIhUgFKhJ8nVPKoPGcR6U6AhfElu36GpvUTmC8g0kz11C0Bu0x
         xf8FDrZPqFE0qaCsxFa806VrDuCv2UNXtaqgIqNNbK88GtUYfs8zEulNgZPm6Iq27n5Q
         sGRg==
X-Forwarded-Encrypted: i=1; AJvYcCWclV2HF+6LjLC7WaC7soj6hqF/lzSOWSVrn2XUsQgY2l4dYNY/nk4S2NJrDKJJAu/UbbG2Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0YymP587AW/WGHkwY4T57iAuwdb1U0VlGWoA8uQ/QeBWJeYbKhe+
	sLGKq/wEWH/fL8BJ7Jv/2LLb03iZQD92RGaac0VziJsUiCMea7jtVZ12ckOYNCQ=
X-Google-Smtp-Source: AGHT+IGh1eftOELfePw5LBn8NrYfzH+v7ipL5QEhLmSsHv26fcAASM8yAzTbd5l6W1iebV1DkwTkvg==
X-Received: by 2002:a05:620a:4409:b0:7a1:e41e:4d5c with SMTP id af79cd13be357-7a8042668b8mr337112085a.59.1724933010626;
        Thu, 29 Aug 2024 05:03:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d3944esm44767985a.80.2024.08.29.05.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:03:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sjds7-007TEL-WF;
	Thu, 29 Aug 2024 09:03:28 -0300
Date: Thu, 29 Aug 2024 09:03:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	pratikrajesh.sampat@amd.com, michael.day@amd.com,
	david.kaplan@amd.com, dhaval.giani@amd.com,
	Santosh Shukla <santosh.shukla@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>, Alexander Graf <agraf@suse.de>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC PATCH 07/21] pci/tdisp: Introduce tsm module
Message-ID: <20240829120327.GT3468552@ziepe.ca>
References: <20240823132137.336874-1-aik@amd.com>
 <20240823132137.336874-8-aik@amd.com>
 <20240827123242.GM3468552@ziepe.ca>
 <6e9e4945-8508-4f48-874e-9150fd2e38f3@amd.com>
 <20240828234240.GR3468552@ziepe.ca>
 <66cfba391a779_31daf294a5@dwillia2-xfh.jf.intel.com.notmuch>
 <20240829000910.GS3468552@ziepe.ca>
 <66cfbec0352ca_47347294af@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66cfbec0352ca_47347294af@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Aug 28, 2024 at 05:20:16PM -0700, Dan Williams wrote:

> I encourage those folks need to read the actual hardware specs, not just
> the PCI spec. As far as I know there is only one host platform
> implementation that allows IDE establishment and traffic flow for T=0
> cases. So it is not yet trending to be a common thing that the PCI core
> can rely upon.

I think their perspective is this is the only path to do certain
things in PCI land (from a packet on the wire perspective) so they
would expect the platforms to align eventually if the standards go
that way..

Jason
