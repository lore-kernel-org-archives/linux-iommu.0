Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110544685C
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905893; cv=none; b=EXJ5axpaSTiVuLPAaA2YWjAWjoIKSU42sUVQUi54DuJ6S8Ta6olv4UaDrOEkqnJb87dQOjh0Fgcl7InLijIaWW5EAsW1ZFHh2SBeX8U1vTdIbj7bjfTy370liqTaaMSDToWZ+RliiIu/osJnS7i1cOnyEcN+xDKRnHaZmS4t/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905893; c=relaxed/simple;
	bh=6Ky7RUFYVrq7ZdVer0P6fF8pIZq2ZBH2F27HGxmfcHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXmA5lCn3R7v14qFhhAsJDYuPCOA8f2yt/nkfxz52i3NetnxxSvVC3rmmCi+dojgZ5r/6Cbl58LMGD8Or9iwW6Dox05SvmpBUPQTnXHHSWsfolg/uZ4XIgrVHWUSKDqIYpHx7G+bU0ZorHitxnYMIkCqSOQYVUp1dneEToSjTVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dMbrSz/v; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dMbrSz/v"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so436882b3a.1
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784905890; x=1785510690; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ke98c75eH/+iYi1A8tNuqQeqLvc55paMqSI5+8TgofE=;
        b=dMbrSz/vZudxbYMcEpKJUzSNz/3oTjCLWzfXcaWZ5aXPdL1OJA3RyV+HWJI0ByV9bf
         5hReCpNjmNwUSSzMAW1cE9NVGcaNvytzClkjqfcfFraYk4eMK/IFSjTETomCy1DjJo1D
         YMyAXIxkj0u+/duLLjLqQgVeIW8GUhQV3D0abXzZ47SLjAsIqSHdMsKfLCBd/rkO2BPF
         CTnaD0+8PFjnkbK0F4nFiqMQeEkxy46/2zGoHcnPDBcoonSnUEF6jv/5NWVHFl5kcEMd
         sFJIlnh4i6X2pnjNgzI+z54MLdow5N1A7GKi/p3QGUMFup94WKILq1ShynmHPWIlEUDi
         zHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905890; x=1785510690;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ke98c75eH/+iYi1A8tNuqQeqLvc55paMqSI5+8TgofE=;
        b=irP+2FkgyREwcCxxJ5GKATGztWB5tswdY1dg7XGWl4tWQmKtkEzTSAv+Vo0KRom8Vv
         400dJzEzFHLj1VeVGS6HO0eR6ZcXkaExGNGWtaHPc3+Kix5RmkQX4uZPTo9Tahc7WdKi
         DeoxFg5LVVgSTh6pmHOUCL24TjInj84H7aOxxnLNa9WNzl9nXlufBo0GsEHjGWRZVYyz
         uYTgwA04jPV4nTZwR1N80U4wnNKaOGufYmqAxj2uQebG594/mmxgZmb5WfI7UsD6wLpV
         c08q0xxPO1exshTAMvkRvrvvWoV1foMe0Vx4lhhXJBNylqKKSzVhXgYwqKsVkXVK9DjZ
         EVDA==
X-Forwarded-Encrypted: i=1; AHgh+RpX/7zAliWpniiEI381Sqt4zlrO7BZIwMGSiVP6nABWtHvMrtKXqMve4UljnMfM4InVZ7TAHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzL8Yu9jZM6D2NMRBFl64sJ7gxwCGD5GK6KH47QZ0iZHDpL93JD
	h+RKe7hpH05dAebtrNqA2+jcIoRCOiwLunyErZncGU9QLMozTnAzzP4CPmpF5KjE35E=
X-Gm-Gg: AR+sD13CcrOc8BQkj675svuqc+diNVs+Ti68SwjjLuC+9XF3+8BH+EjQnAMVoMBdNjP
	ASZkUFzUkNSyNO7WJtobjELXE8PzvV/lI+KA6sZER4xrGNKASirfI+K9FffHjb1uv44AY0a9JOO
	wc2p51nDEebOPxe2iYT/VI6wNM0D5XmCRs+eNVm2IixxAp+TeKLwUl8hLqxn3y0s/2ntowDbHT1
	v2E9pK4Bi1H87vbArYkn4CyjZCTGs28AUxzwizwIle7I59rrQZKSwNrzrdXpd4icd1wEcOD+VrB
	0YRk/jLhH8vWSOwDTpkI/krE6sxc0C8SZIUF/kwDVgugo+CdLr55+xbFNxAhKNLTBZB2ceXR7ol
	7yUBSnxLcXuCrbs54QQZbWwnK4HLQUgL34WaOPAkCPF8vSJS6wnRg
X-Received: by 2002:a05:6a21:7317:b0:3c4:2036:3032 with SMTP id adf61e73a8af0-3c44b06afccmr8103843637.34.1784905889794;
        Fri, 24 Jul 2026 08:11:29 -0700 (PDT)
Received: from ziepe.ca ([216.228.115.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5a67f3sm572419eec.29.2026.07.24.08.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:11:28 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wnHYe-000000002lY-0zFZ;
	Fri, 24 Jul 2026 12:11:28 -0300
Date: Fri, 24 Jul 2026 12:11:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, linux-pci@vger.kernel.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	bhelgaas@google.com, alexander.deucher@amd.com,
	Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <amOAoNmkgDc3kuBi@ziepe.ca>
References: <70e6d40b-3e13-4efd-b1e7-62195ff66e91@amd.com>
 <20260723210246.GA856455@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723210246.GA856455@bhelgaas>

On Thu, Jul 23, 2026 at 04:02:46PM -0500, Bjorn Helgaas wrote:
> I don't think the Root Port is always passed into the guest.  From
> 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports
> them"):

If this device has broken support for iommu translation entirely then
vfio is unsuably broken too. The right answer is to refuse to attach a
paging domain to such a device, I think this patch series should be
enhanced to include this.

Like a qurik that says translation is broken and then def domain is
changed and paging attach will fail

Jason
