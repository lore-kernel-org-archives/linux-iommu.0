Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B042BE62B
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667841; cv=none; b=VcrnMqeFjBX7kTdC3D4fpGtIg9gOATV3LM/N6MIJVnBwvBayiPkje4fwJeoEKYi4UplsJALcWfD2Yg2hmjI4smKALwn2nOHNk1ZsZvh2TwOxaJlvVCtggfE1+Y2tz6FduXKgXOxIrxXOTJfMmJw/XotM25AwSNLDwGtsLyrGJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667841; c=relaxed/simple;
	bh=DqrxxRzNrVElQiSFybdiqSTB8zLMpM9xyST4z/mLO2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+tIqadirvxK5OypwMhlJle26cKXXDM1Mp9lW+NrBm8CnAv0EjuvH2Q6mTBA4IZ4tczGKSaHoUWqp+7USBCmR6h/E4gWe6geiHoI4kXkazuIFtvJaFaCZ6xphgcaYjY/qRjzjOpOvjX/ZQ6ug7Q1kqjivYuUVt/ZQanbKnDyi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=L22eGVEM; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L22eGVEM"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-702cbfe860cso61150776d6.1
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752667838; x=1753272638; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIP3ya1BLuzxXr6bkJRT0LOoJh7qbBYpTnmvsHp5Va0=;
        b=L22eGVEMrQmgDDiCmQu/ndEzzNsPoYr4rp9zpsrXqNrWPW5PK5nDMlvBWmcgjzPix8
         N2OJ4b+NauNJ6gWzs9eDfKayHZGIk3ILMHFTpnt0PZm+fI45CJUh2s2xcC1UBYMZ8A5i
         eGKTTXZ6POCOYjJ30HCsPEdG2omBcXt81PHVFQyM5yknCtq9ZRa8Wm/IvUkbbqtDPfiT
         SgwihtB+fmvgx6lJuHTw3mQz+vTsMsYZCqsncJvk6kkSVusycjlL1bCrjmrBI7UI10nA
         Ro3yWjC9vt/MWe30ZMkARZRpqQOWzMaEJHc6SpkV0r/rcJJx9Ev+B+nnNNZB4pkzuDWq
         Nu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752667838; x=1753272638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIP3ya1BLuzxXr6bkJRT0LOoJh7qbBYpTnmvsHp5Va0=;
        b=dyS1FnqazE7tyL5HFwZBQ/mbI+t+4KTzqBY/nvvvdJH3d1XDYyfjqJCPAx4jVorVWU
         5o9P1vzg9ie3B+x8tPwO3PX+oQVlKhnjHvvLfJI78qkefLLlxUDWOwzFW3SZ78p6TZxN
         2SBwOHrPnlP6Aq34iE7RtMxGfeVUT1Zg3SSIAFR2eicDlbUrHr07J08HT3JEiwHIV19R
         yv9vN5vJO0DP/JNidHAQpcwLzsAeCr5oVpdK2mK2ZChKznw0QuiOd/E1yG+km8gAD+hf
         p9lXbn3X2O4qXiLbgMgJZr2KVhoBCoDvvil3GRplqNHabkfcdntikc6WrR79M4bowbJn
         8tqA==
X-Gm-Message-State: AOJu0YxS4kFLl8L86kblf4S01824L8Jythk3pAbWM7SbU9jVLGJFsNBd
	fyeAv7Pe6Zcj/Sk0VdL6SS+1KEfB3YA400TDEMZak7b0zVJ9ELZ4A6+TSi7fq3dO3kc=
X-Gm-Gg: ASbGnctqOK6XvtKZbv1ot9QHBOxsM+aCtwQoEt77xvbgltJ4j0PUSpII6D8NpmBEneV
	ykG4VtLHxUXvRSE00OxXMEdhpgknf68yz+zPtzy3deyziNPVekY4wI+v/wrUAN3P6hr/nV2FopJ
	tbQEIg/XLZ5KzHzunh+z6LnkajFWvd+cxTlU8Cgc6W+Yefgi9DCY2UPvxwFJ0010GlUpzgmQ8Sf
	i7Gi5C/1j6HtwMLYE9caxW5BO5gdtSNS//RakFb8ezUO7puvtiMtdVNK6aNeKSmoQBHiCNPGHB/
	xI2aEZ+Uwn+o4k/Q1Isnhy6QT9J3YvQGvr/DIGdjcfAQSpzm286G+POwNvgvCSUj1dJrDv2c4bz
	0/gruoeDHYL8SjqGBIUpVDr35J3CP5qbg/IRwFEUd32qcExFoMgj51Hdk3Uv5AjbnXXSgwENRhQ
	==
X-Google-Smtp-Source: AGHT+IEaMMoAabKIvy/6hUm3Pz2Mj624nFTDoPAXqr71BGISR01CFU/2f0dv9kGGDC6bv7sfs6TmXA==
X-Received: by 2002:a05:6214:4283:b0:704:7df7:c1a0 with SMTP id 6a1803df08f44-704f47fa4bemr46732856d6.7.1752667838252;
        Wed, 16 Jul 2025 05:10:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab3d44b3d6sm51417661cf.56.2025.07.16.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:10:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uc0y4-00000008xUh-2T4l;
	Wed, 16 Jul 2025 09:10:36 -0300
Date: Wed, 16 Jul 2025 09:10:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 0/4] Implement IOMMU SVA page fault processing error
 notifiers
Message-ID: <20250716121036.GA2120051@ziepe.ca>
References: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
 <20250714145658.GH1870174@ziepe.ca>
 <MW3PR11MB46813837E82395797CEE39AF8056A@MW3PR11MB4681.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB46813837E82395797CEE39AF8056A@MW3PR11MB4681.namprd11.prod.outlook.com>

On Wed, Jul 16, 2025 at 11:07:50AM +0000, Temerkhanov, Sergey wrote:
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > 
> > You need to come with a driver using this as well.
> > 
> 
> There is an OOT driver which would use this facility do report and
> handle possible invalid accesses (e.g. mismatched VMA permissions)
> during the SVA operation

Upstream a basic driver first then ask for iommu changes to enhance
it.

This is normal stuff, we don't change the kernel to accomodate OOT
drivers.

Jason
