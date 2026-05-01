Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090493F0AB0
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659437; cv=none; b=lY/+9Ak1ZhfV3V1qK+W94QNB/RRf+9x4YKcic9T6Q+x5V9AMF/nI90qBFtDI+qzO8Ot0jBbeWkjqI5bAArPNjCyvC2DPVhuzlzs3K5CFTFmDtRVZakWSbHCC0NA8EBuVtruFRxlsytNreretY6sVBbIOmqIq5Gy02qkrnL+zecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659437; c=relaxed/simple;
	bh=FuyGme0uC1dQYmMPiHV3ukU8NV7ufPunP8OPpbJlgHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRWu/sfyruGOLCeaUR94MxtbbYIRKrPRfQYhqUVZVxPubnbTf31n5blJNEr4yAIbKeW+L0ndaKf3hdvtO251W6IxcIKy54QwaLSPuaypv2kAXZX1iO5n744RJIIyeB2vmNoJFMXc+WR39flNEcEG6D6xgYiNwqubyDIXKacVyVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uclbxVXm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uclbxVXm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso9925ad.0
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659435; x=1778264235; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hH8WjvIFvfB7lCVYfIBULvtLO+n9YZWTzS7cJlqaCmA=;
        b=uclbxVXm5nCZEUHrue5GM/3U3YltxaLV7rzIM/J1+20IEKaCZcz6Hw0lGx3QT9lFzt
         iA5W0oRw8Nld8KAhKpVkRj/ScALyALfCXx1dNa3+cweSOKlNZ71EczR4AIlmmkO9CZzF
         09CM+kUp8x0yyVmvzVssZGTa+pzJIq1LpchvSQQzVhap8iT38O2h9cLaCkBg7W6iJAEA
         toQRvABqlvHSv111YkoHmmGSJx3bXIkgtqX0YaJwWt/ACpHrRji41tATp2rGzct0SazO
         GON5UURxaeDxErGSkAscrKp6sEloi/vqkLqY9jXLLWcD1Kma1ih6OQxqXEkjKW8tl4v3
         DPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659435; x=1778264235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hH8WjvIFvfB7lCVYfIBULvtLO+n9YZWTzS7cJlqaCmA=;
        b=JQmgkKC+nBRKd/v6QJA+En0h5bbXNOc7O+gqsHXsgeHOW2sSo0wxK0VDIHkNhHFPH4
         QHOQmN283lwiSwTDUlzw0fkIsd2n6PdureC33l1eJ7HJ/gBJhYuG4qEmpnnuDn2v8HwQ
         M37q4J9vvp8To5ah8Lj+eJFp9j9K2EwXXcc1AeV5prUUxBlWkpbnQ+SlKpn2l05B/S+C
         5cpu73OP+qMsuzz+jrye8htNxJNiEvzwrt8hZcfZGEvxb21CkC9xYJ4XTDVVCcPm/E8b
         pl44YW8vOGH8eByfrEBNMbzseFHkoWVdPOzy6RwBegOu65EE9JAXz4SYMJrHS7eJ/LMG
         j4iQ==
X-Gm-Message-State: AOJu0Yy4CPrVdn4w4ZyUVXcBGpuv715NBN9A5rFodRf8S8awLYyXsysE
	sNKZfgEfrYaeVgskZogVmX95z6zpPy5BeaasYeIpzzgyxLZZwuqedF9PpCmiiiuRyw==
X-Gm-Gg: AeBDievUvsmDITfPonhkcZcjGiz3ObeLSXDuWYTd66Rxnn503Y4hhMVp2muddl2xf4t
	SQvX4z7jtDKZ0Dgn154sBOTqyhfuwGJQM1g9n6SWcnetjbvCXcqq4n1obXFVSebcpf4Y1dYZTc8
	OODNYpvhrDmZqB5Kaz+Kg8/Ci/Aix/Kf0Bwcf2tcdi1hpjXaA6AAzxQeS+1lINHbnMUlykvxQn6
	1ppP+tntkcSOghxEDu4ED56qdQpExwwFbkD68qavZNmc/cGAOwLCC3BZt2JLsrzN3z7DIsP7z7n
	lm672g6CmID/eqzv/L+GzD3SE8GgtyX1zT27d8qM9sfE780RZShJdlTd2L1b0VFplzmRcuKB2fK
	IYDc3mW5/2nHbpuu8ktn2i9fODtMk+zJDcOqY1LZlO1b0pn/XaoWf0GlYkxHKbkIECOcayk1I3R
	sSMt8iKoDplL0qJ2OQ77xswQtC3WKrTag9mS6RgpLOegVb5sPDteEp16z95MUqNBnXljtst3uOv
	WwHgHVtUloADRy835F9aA==
X-Received: by 2002:a17:902:cf4c:b0:2b4:60e6:44bc with SMTP id d9443c01a7336-2b9f38a41abmr300485ad.13.1777659434630;
        Fri, 01 May 2026 11:17:14 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc85c61sm2776855a12.22.2026.05.01.11.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 11:17:13 -0700 (PDT)
Date: Fri, 1 May 2026 18:17:10 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afTgOXpUNWMapPAS@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com>
 <afPGYp145FbrvURR@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afPGYp145FbrvURR@google.com>

On Thu, Apr 30, 2026 at 09:15:14PM +0000, David Matlack wrote:
>On 2026-04-28 05:24 PM, Samiullah Khawaja wrote:
>> On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
>
>> > +	for (i = 0; i < ser->max_nr_devices; i++) {
>> > +		/*
>> > +		 * Start searching at index ser->nr_devices. This should result
>> > +		 * in a constant time search under expected conditions (devices
>> > +		 * are not getting unpreserved).
>> > +		 */
>> > +		int index = (ser->nr_devices + i) % ser->max_nr_devices;
>> > +		struct pci_dev_ser *dev_ser = &ser->devices[index];
>>
>> nit: Maybe we can move this logic in a separate function as down the road
>> when we expand this to add VFs and Hotpluggable devices, this might
>> change significantly? It's good if it is self-contained.
>
>Did you mean to leave this comment on pci_flb_preserve() where it
>decides how many devices to allocate room for?

I was talking about this one, as I think depending on the scheme we take
this might change significantly. Just a nit, you can ignore it.
>
>> > +static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
>> > +{
>> > +	return dev->liveupdate_outgoing;
>> > +}
>>
>> Is this expected to be called under the outgoing lock?
>
>For now this API is only used during shutdown, at which point userspace
>should have already been stopped so drivers should not be changing the
>preservation status of an outgoing device. So I don't think this needs
>to be under the outgoing lock, but it would be nice to have some more
>explicit synchronization.

Ok that makes sense. I have similar cases in my series, but maybe we can
add kdoc regarding these stating in which context this is expected to be
used?
