Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126062;
	b=J/ntoFiYEqTdMjRnZhfQEsiAjGVAZuVvhghNvDMXjT7PZ73nBISDAbFr9vSamTcdYmW3
	 EOsmBBXxTaALBiU9q/6/NuGs6aTHIKnyxv2CrVVoCq2BgAxaS0oRwcmeOQ+e+5PPf5cou
	 +GulCM+ktJaCaPHhsNIJSwcJTCqwoVn1WnWcb+LE/07XO0B4lOk0q38a/Aw4J7xaGfCFP
	 91R9PbL8OCzSDxh839VaD3YzzweBo6SrYad3GRyO9kP1ZPsBuMUOv/U+SqlfFRqdmeUGC
	 IgCTROVrK0LM1AY4hyzm6GLYAlAElEY8c1cJBSLe43V66N7SdVGCkRvXIV2VWqf6Seg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BcXyn5Pt3Ud5pWl9ffP7/JMMW96ISxtzbbqlGIIDb20=;
	b=xkwNCCirTJGmd4n96T/TsACA/QwBXbdsueVHMnrKlab524vWXgNTOEZmzKP62P4GtT9Z
	 cCq95K6s59f3RifXxlAtrsPJJygdhFrD6Hhc2dbFeQjRCkEpUJbxqoJcE75EJfdeZFs/9
	 oZkjlQ+FddftBE2/SkZWMQKfoThnesaFRTE6TvZIHcd7MdN7h1o+45O/xBcKQ8WbOnOO2
	 O5AgJtkixdhhZIQYkdGjQvF5kE0C/9jguwVaYNVgjmfu9yNf5+XW0IlDeyKLyzUcFL9S5
	 J9IEfS8nhMfDDVMxfkGAxea+GgMpIea7G8rYmAxw296SGa8cu0V4/ujENhVSvFZKwjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=USvxqdOD;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6B606A31A
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 18:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99F6B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=USvxqdOD
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53644ab1f7bso2393601cf.3
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793126060; x=1793730860; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BcXyn5Pt3Ud5pWl9ffP7/JMMW96ISxtzbbqlGIIDb20=;
        b=USvxqdODAqHbcxNJoN4OdHTP/j7DZiPTubDVL3oy0jiSkWXd1xeNHrN/USEuXCq+nR
         UyZQ+tIL+WAE32L++c35N/4T6M4gNqdokWzb2h521pPqkJNV2NAhry1Ve2sg48VwQIe4
         WK6wUVzzImBZMi//xoXVns+A56okCuGXdIIhXTD1le5+PbGmqO/KAT4GioxUDU/GRnh+
         TpTb/VVZHjqK5tyZN7UbVH770KgCa0NU29xBxYGkKB9utgp+9Xknrix57+a/FBWXr0vz
         6bnFSIr9G/+DeCsZA8vPWX8xQqLeR14I6zZkq5HJTyvsaHm+GZyX8Iv8xUl/NvlsWTnM
         J4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793126060; x=1793730860;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BcXyn5Pt3Ud5pWl9ffP7/JMMW96ISxtzbbqlGIIDb20=;
        b=CxYfmDjeJurjdwjyVUPWbuWQ+SbeN6pINlgfPwKXGPxQ/pLYkqEQUXg8mwadGLRP3S
         q22h2Mq/RSZr4tDEjaF3CU3xRedjl5FdXBgGJdS1iCDjx3itJ7T8fVF2mvlegJJhWGpy
         u7LXASFuvO14X1+MaZ9JbpousnhRdPTL+rp3ezxZ8DYisDkACqmhhkuvW8EtFnJOUEwX
         5s3GQj6qry281DbpeWvPL17Cl0rAwN2nTCaMhIzGKY82bqMIO88lBT0HSLluwf/xsHbd
         ugyrdzA01PlCXAJrYmPSk5C4RcT5ApxKtHvcCxk4rpLnX/GT9bsjPcrvjwFIghBV4wj/
         1+eA==
X-Forwarded-Encrypted: i=1; AKwUvByMZhW0RNrI6vbBI8z6RGnd7VVGq0DG2xp0UsLEU0Are4Wdpny9rRYBeFbDUDoqMRzq+3NgJw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK+gLc4kNVhNYC9+hArp7erd9AN2WyzaWcIhmIcfsIQXTXt/GhE
	Rvhvu5A8nE6tnWBSGOyLtrVaAW4opuMGvqWolf3YGBaY1xAyAjSzkyPeH3cwcbpmSN0=
X-Gm-Gg: AYBFou2Zwq7oiWJ4lcrTVFIGj3gFFLzT98UU6cBS8xTW4D2TVPuq6t0GXtHYng7TcyX
	UT/st854lXXQTPiHhfses1nloEnl91rnoN7yPiqp+bFfMZyFRlTNxphHxvfYycoa0qb/gpEiZ+S
	tufFpTeuTyhcQBG3qCRJcdvyUmcR5AcyUORhodkL7Aun8E7j1hZCxKClVKJq0o45tdvTN54ILzJ
	ZWoW/lnYfGatmPkIz4kRWHUu7JgO0lH5KzECBSo3fCMyCRfyzClF9grAPGVWDCxS45o1rwWNSLM
	RBOeVui/5z2J9mjBsUyYZfGxiM8/XWqlrT8uQXXMMdYvqq2cZ666YfA+7NqVedwDxE5mHGKg8mJ
	9Cifmf9M2iLo7qKWT8u7ckJor4t/JWxD7neAOsVLdxp+0SQMeLvt3IBBCtIVDu2Dn5Gs1C65Bp9
	esKn2tN+oxu4GNcIfSGQN4TQBIBVaJOAl6BYGMdorVkV5vtB52dZ14alU0huxvPQ8OatQIFf5as
	J0wc8HwJFtzIhXY+dBSQubAgaagIBNJqDXMxKkOSs51iJHwnHE/qrc/4+U47VMmhoPiQF+9cvdk
	SWfDJTwDe7R5eXcVAh3YikLBGyZr2BGg52LY3w==
X-Received: by 2002:a05:622a:4d07:b0:536:458d:525e with SMTP id d75a77b69052e-53fcc5c17c1mr1974831cf.37.1793126060344;
        Tue, 27 Oct 2026 11:34:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c518csm84854701cf.8.2026.10.27.11.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:34:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLm02-0000000AgqP-3BXi;
	Tue, 27 Oct 2026 15:34:18 -0300
Date: Tue, 27 Oct 2026 15:34:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: alex@shazbot.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v4 2/2] iommufd: Add IOMMU_GET_PCI_MMIO_WINDOWS ioctl
Message-ID: <20261027183418.GJ1685504@ziepe.ca>
References: <20261022193359.GF3381610@ziepe.ca>
 <20261025133000.205508-1-guanghuifeng@linux.alibaba.com>
 <20261025133000.205508-3-guanghuifeng@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025133000.205508-3-guanghuifeng@linux.alibaba.com>

On Sun, Oct 25, 2026 at 09:30:00PM +0800, Guanghui Feng wrote:
> +
> +/**
> + * struct iommu_pci_mmio_window - a PCI host bridge MMIO window
> + * @start: First PCI bus address of the window
> + * @last: Inclusive last PCI bus address of the window
> + *
> + * A memory window claimed by the PCI host bridge that a device sits
> + * behind.  These are PCI bus addresses (what appears in the TLP).
> + * A PCIe switch could misinterpret DMA to these addresses as
> + * peer-to-peer traffic and route it to the wrong device.
> + */
> +struct iommu_pci_mmio_window {
> +	__aligned_u64 start;
> +	__aligned_u64 last;
> +};

We already have struct iommu_iova_range, don't need another one.

> +
> +/**
> + * struct iommu_pci_mmio_windows - ioctl(IOMMU_GET_PCI_MMIO_WINDOWS)
> + * @size: sizeof(struct iommu_pci_mmio_windows)
> + * @flags: Must be 0
> + * @dev_id: The device bound to iommufd to query
> + * @num_windows: Input/output number of MMIO windows
> + * @out_windows: Pointer to the output array of struct iommu_pci_mmio_window
> + *
> + * Query the memory windows of the PCI host bridge that @dev_id sits
> + * behind.  This is advisory: the kernel does not reserve these ranges,
> + * it only reports them so userspace can choose to keep its IOVA
> + * allocations away from them and avoid accidental peer-to-peer DMA
> + * routing.  The reported windows are pessimistic (the whole host bridge
> + * window, not the precise BAR ranges that may actually conflict).
> + *
> + * Windows are reported in host bridge resource list order.  They are
> + * typically non-overlapping (host bridge address decoders are exclusive)
> + * but no sorting guarantee is made.  Userspace should treat them as a
> + * set and compute the union if needed.
> + *
> + * If an IOAS has devices behind multiple host bridges, query each device
> + * and take the union of the results.
> + *
> + * On input num_windows is the length of the out_windows array.  On
> + * output it is the total number of windows.  The ioctl will return
> + * -EMSGSIZE and set num_windows to the required value if num_windows is
> + * too small.  In this case the caller should allocate a larger output
> + * array and re-issue the ioctl.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if @dev_id is not a PCI device,
> + * -ENOENT if @dev_id is invalid, -EMSGSIZE if the output array is too
> + * small.
> + */
> +struct iommu_pci_mmio_windows {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 num_windows;
> +	__aligned_u64 out_windows;
> +};
> +#define IOMMU_GET_PCI_MMIO_WINDOWS \
> +	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_PCI_MMIO_WINDOWS)
>  #endif

I wonder if this should have the word PCI in it..

Maybe this is 'recommended reserved regions' or something?

This is also lacking a way to send the ranges back in so they create a
restriction for the allocator.

Jason

