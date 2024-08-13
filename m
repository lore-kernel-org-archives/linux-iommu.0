Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E141A255A
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567425; cv=none; b=GafW/YQN61HvtSIv6O/pP0qWTdFa9hJ/mzG7of3MC7NYHE2LI2einIFyWdio6h3Y6Q0loxX6uff6I/7JsceAVzISyx2IBraCK0y8CBm8e9po0nSGqxc07Bs+CWgcUV+y0S4gwGiw5u2oUHq2C0BeETboIVmdHoW73Ygng6cYphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567425; c=relaxed/simple;
	bh=clgAIbvfrJrk1IcVma008X2y2mp12ev0nTOUNJlQorM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PccXbd8inxyt/QQuYcyquso0MzhX3bcTvaYjluZUxXPQSBA6M/iorUc+URwwqGtpyJGlqXIg55F7/gODr3oNJh25A2hMM9HprwIbfXItyVAIwNA18m9s0T/tPayp/BfLojWLFNayrNe3FHMeG+zc10Sjhbo3/1jDABc4pUDxp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cldUH9nm; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cldUH9nm"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5da6865312eso896629eaf.3
        for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723567423; x=1724172223; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROqRYY1dqCAC6kog/NOEL1zLkAqrmdMPMSau7oyZjtU=;
        b=cldUH9nmV3kLZnw+zI8vtjPD92oCQ6s7Epm4juYNtt+Bj72cFFdA/BNXLGxjKgu21Y
         47PlIQyXxiXRK+2+qN7FYBst7IS6T5JGTpwOjWi+yoOq2pT2mU1YxM3MGrDPNUjFjbRR
         sTb8LXYdXYCKupX85UQXG9eQ557tAfVoPlYiO5hUp1LVNIqAZooyo7Rd9NgJxYdfNKEs
         YP47UmnSE9y9e5mYiVZncMbqcE/b/vXoGXftaPK/u7uK8yA0sTCTkWiYNkYmG9PuJeGL
         ISdl/llgcqKQUQejmQV1S9mmPD9VEnAuZqVUr3z126Mk8NRmCPSy7Nxdd5h7exSOC61s
         DFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567423; x=1724172223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROqRYY1dqCAC6kog/NOEL1zLkAqrmdMPMSau7oyZjtU=;
        b=VMZnyEFSzZzUzyIv556PBI1hA+5FhnxX1+lOZ3zHa2lfWcC5Nonuq/VyXX7DFLc7/q
         6KbqZAfPsJgVPrTa2bdQRUbkdRUvRb9HJnuTjhKL3QBb7EAiOjY331j2hcd+wb1AAkP5
         xAEvHjSKE1BiV/Q4pk5FETISiZg5fCTmaeuk0gUbrZfU3flF8Dr8FuYYZtlXcrKexiMF
         g+uf15LgSHfe5uvZapGFHxcpGY+A4klAfLhDE/CmSYOKpjOnQBB22DoUzQz01kFMW1oW
         MSIzk+qDt191Yl6qyTSBWryF4nFP6HENbZfcj0QqWK7amtt5/HrHjKUov6lMP88EoLSn
         setg==
X-Forwarded-Encrypted: i=1; AJvYcCWtIesoHPkU7Jm9kyN104fg96TEpl/qWsri7bixXuo7MaLqw90WRXKQSjyHWMSCoD718bJkIDj+eVct9Gxp6nIhD5yfBdI=
X-Gm-Message-State: AOJu0YyrD7tYnyHmKc+Y3g1FVxhZ4pwy4zZuSMDibPX3gjUWZFMxNNcx
	U+ko7k1qpPnymEvqhCFd7xQFWHG+LHNgr9L3PlNFFxvuzuLW1Kxrcv6dcHeKxU4=
X-Google-Smtp-Source: AGHT+IEvmSCVnjpjqrFJiGnBKOZvxrmuCp6UnsBlqoXz0YHrq61kKl9NZyVY0sS6gN/GBZB3kKmjIg==
X-Received: by 2002:a05:6359:410d:b0:19e:fa9c:5ec9 with SMTP id e5c5f4694b2df-1b1aab4ccf6mr3925955d.9.1723567423216;
        Tue, 13 Aug 2024 09:43:43 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e2f405sm35400856d6.79.2024.08.13.09.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:43:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sducX-008U9H-Jt;
	Tue, 13 Aug 2024 13:43:41 -0300
Date: Tue, 13 Aug 2024 13:43:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
	kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
Message-ID: <20240813164341.GL1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170045.1584000-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812170045.1584000-1-alex.williamson@redhat.com>

On Mon, Aug 12, 2024 at 11:00:40AM -0600, Alex Williamson wrote:
> These devices have an embedded interrupt controller which is programmed
> with guest physical MSI address/data, which doesn't work.  We need
> vfio-pci kernel support to provide a device feature which disables
> virtualization of the MSI capability registers.  Then we can do brute
> force testing for writes matching the MSI address, from which we can
> infer writes of the MSI data, replacing each with host physical values.
> 
> This has only been tested on ath11k (0x1103), ath12k support is
> speculative and requires testing.  Note that Windows guest drivers make
> use of multi-vector MSI which requires interrupt remapping support in
> the host.

The way it is really supposed to work, is that the guest itself
controls/knows the MSI addr/data pairs and the interrupt remapping HW
makes that delegation safe since all the interrupt processing will be
qualified by the RID.

Then the guest can make up the unique interrupts for MSI and any
internal "IMS" sources and we just let the guest directly write the
MSI/MSI-X and any IMS values however it wants.

This hackery to capture and substitute the IMS programming is neat and
will solve this one device, but there are more IMS style devices in
the pipeline than will really need a full solution.

> + * The Windows driver makes use of multi-vector MSI, where our sanity test
> + * of the MSI data value must then mask off the vector offset for comparison
> + * and add it back to the host base data value on write.

But is that really enough? If the vector offset is newly created then
that means the VM built a new interrupt that needs setup to be routed
into the VM?? Is that why you say it "requires interrupt remapping
support" because that setup is happening implicitly on x86?

It looks like Windows is acting as I said Linux should, with a
"irq_chip" and so on to get the unique interrupt source a proper
unique addr/data pair...

Jason
