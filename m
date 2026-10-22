Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697641;
	b=V3paYCIT6ebl++WtlmF1bGfSIvtB9wfYP5h8j2SCupSIDAnHwvMdGKuELHfhlwXan3cg
	 /vpA+y+BBzAdVg2wMnwsg0cwRB9Q6RKcsdqiftZbVhLohcaKmt6n27S6O6j25VX/c3Ygh
	 4GscD54mKStsD922v+Z+4EuqHhfzS5H75BDmZsnpMVhshSl79LTbFMyGf9y+i08cNoYX4
	 u3Ggi7PQK/4mIDpeZkAzUCofkVRkJ8WjILxXpRz+Kv1XOnhATk611wVS01ZhgKY8jj55z
	 P/XP/fsZ7kiS7m8kvFOsst09xu7WLSFV/bmGLZt511irI6/jjwIAwRXxriIWUnQK5Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1WFg6Cm2FvST/tWX04Ds4MFu/JJiRPf7HeaSO2EoRtU=;
	b=d7rEw2ouV6R0+wI3Zq/pGrfW/sUL4MG7HmKek3+q6qvzdC8Eh+TvQPkPFaxRENwEIl0g
	 Xud1l2ezsXqHhqCQDhpAK0M3T1rjnMVc8HCCRjt94uXod/Dpgz8vujcNaqbmTcS7aFs0T
	 /d9E4kvI6K2Vr4f6oOV2v5QeGXdmpsT37L0CN6hiFJ20Koz9Xt14ZXSS0ltdqpqRYhM9V
	 BrgUp/iSJk1XdQsKxWz4TflnRiKuOhztB9iIIhG8eT4gcbjio8xf5lWNBcctXivGK4Kxe
	 O+JwdkSTDhHOV2Gep1NFwwqaaDE/ZwHj9emGXUnfDrddXRQ57ao6xEZagokx8xxESYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JIxgtjbt;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE38606A31A
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 19:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FE38606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JIxgtjbt
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-536605c4d8fso581321cf.1
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792697640; x=1793302440; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1WFg6Cm2FvST/tWX04Ds4MFu/JJiRPf7HeaSO2EoRtU=;
        b=JIxgtjbtI0TAc/MhThBafoaEgxwdmKRjfZIr5wAfXfFwzfHxz9mCiJ9tTZVfrulDzr
         y5kCtX648zskHpUv2neLCHCQtOe5t2agJmtXOZfm27GiTSATO43t+LChewafmv8AT/G0
         B90ZoAx97IfDwnSvIEYosDn07akm8OZ4BojmmxuL95nptNeVrTQQaWf6aA+CZNue9HVd
         v+mnDV/V+5pwIA5B+e9Dq4G/2dS7R42KsRze3e05rM6eVnf46cJ22PKdBURKvRhMtoku
         0ZwEhjVMdqDyM1IjyN5DyUylkD1WpuVw5QwwL3TA98soIwpUhF89wmbhYtFR8yYLLTPl
         6LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697640; x=1793302440;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1WFg6Cm2FvST/tWX04Ds4MFu/JJiRPf7HeaSO2EoRtU=;
        b=qE3zQd1KuyE9mEvmULALni9qRgydvO44WfqoI3P9jHBlp1cB64wzV5mnLbyj+AZPIS
         43uFFx/XeKeS956XzKAmZlWkuMPRNe242ZBAiH4xxRA3KKr4NzP5cybIq4L2koJkR960
         HFOxt/w6/j8nQeGPSljK44Zg84nSmlN2+tkLkrctPvNrYRO1pTtIYY9vioxhetaUgIAj
         gcjJsHNkqc+YNu5W5EdV9Djp/otGCxlcDrdd4B0M2BLan/PlQ7QvS34MNPGrsgJJa3N1
         fwARbiUz4tjcoDvjPSJkA/SjtQHYCkIy19d0M8QkqSzkgPaJt3XEV6QeajEsGyTVf3aY
         /H+w==
X-Forwarded-Encrypted: i=1; AKwUvBylJ3Kv1hjB7bG0lQEiBoAXe2mI5Yf9vdyRBUpOlg9SOA4WLPbAtzYZY3reo3KuUjP+9pGP6g==@lists.linux.dev
X-Gm-Message-State: AFq9FYJMTDTkIpQ4zsu5hgQi7V2dKCB3mopp3I7xBJ3uQMHKp9ghaELh
	XHX1eGbnT3rivkX0YVUolWHYZb7f841//g2YOz/taNRkv8u31Na52TZMoL7UCIStBpo=
X-Gm-Gg: AYBFou287ptPWj7c8rjBociEAk1s15+tvx2AVmG3jPWO8qBJJMwDrLuQmcUi5x4Lo3R
	HAOMHvuoN6Y5676SkcmuNiWUT6f0sMJrMoYtnXU2BxUbOThhrFC886Hb4MZ/Z6Gl05HqeqOdWK+
	QJkLtamIFfYWGbQVfoNptbuir1XGOE0q7JnTL5uMdqHMtLeVgpHUvqVHoYX1myj8tCgymqk/Xlg
	iE46qHLb5iGem0OtRfxU4apODsGoDfo/EDBEoYju/v2fIUWbV3LlA48krGL6D4QdzTl2NTSKYxR
	7gNU6EuM41L00zHfjqT0us6euEjNwZMzE5ZDSS1OOEX9y46u+jDrJvBdPiLm0RTmS/At34p7QKz
	xe2ExX8jHQBmNivBLGyH5J3pqYto0TolQHfXgAhufDnViTvh7CcY5r06Lx9clC3TdA4LwcGTbIJ
	EZ4+t/FPyDa15SDy/gCA+YLT/ICci3yKEoZZSrsDJTZigUE+02J1b0S1BZV0TEjDpWueEXgrvxF
	XjdGL2XitMVy/XWNQng3lzd0yQueoMcUTJt1EWzMvtpmfwyWTaYgYxxQ+hVJeR6gQaGR5zqUM3U
	sVMA+ueu5MspUNpV1YjVclf1TQzrtpMtiPAgPQ==
X-Received: by 2002:ac8:5cc1:0:b0:535:a5fa:ee0d with SMTP id d75a77b69052e-5369bb95d51mr93655331cf.77.1792697640024;
        Thu, 22 Oct 2026 12:34:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396e8d07sm449806d6.22.2026.10.22.12.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:33:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJyY3-0000000FmMC-02vs;
	Thu, 22 Oct 2026 16:33:59 -0300
Date: Thu, 22 Oct 2026 16:33:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: alex@shazbot.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v3 2/2] iommufd: Add IOMMU_GET_PCI_MMIO_WINDOWS ioctl
Message-ID: <20261022193359.GF3381610@ziepe.ca>
References: <20260921115513.GK11599@ziepe.ca>
 <20261004162213.3787623-1-guanghuifeng@linux.alibaba.com>
 <20261004162213.3787623-3-guanghuifeng@linux.alibaba.com>
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
In-Reply-To: <20261004162213.3787623-3-guanghuifeng@linux.alibaba.com>

On Mon, Oct 05, 2026 at 12:22:13AM +0800, Guanghui Feng wrote:
> +/**
> + * struct iommu_pci_mmio_window - a PCI host bridge MMIO window
> + * @start: First PCI bus address of the window
> + * @last: Inclusive last PCI bus address of the window
> + *
> + * A memory window claimed by the PCI host bridge that a device sits
> + * behind.  Addresses are PCI bus addresses (i.e. what appears in the
> + * TLP), which differ from CPU physical addresses on platforms where the
> + * host bridge applies an address translation offset.  For a device
> + * using an identity (1:1) IOVA layout the IOVA equals the bus address,
> + * so these are the IOVAs that a PCIe switch could misinterpret as
> + * peer-to-peer DMA and route to the wrong device instead of memory.

iommufd has no way to use devices that are not 1:1, don't talk about
this stuff in the kdocs.

> +/**
> + * struct iommu_pci_mmio_windows - ioctl(IOMMU_GET_PCI_MMIO_WINDOWS)
> + * @size: sizeof(struct iommu_pci_mmio_windows)
> + * @flags: Must be 0
> + * @dev_id: The device bound to iommufd to query
> + * @num_windows: Input/output number of MMIO windows
> + * @windows: Pointer to the output array of struct iommu_pci_mmio_window
> + *
> + * Query the memory windows of the PCI host bridge that @dev_id sits
> + * behind.  This is advisory: the kernel does not reserve these ranges, it
> + * only reports them so userspace can choose to keep its IOVA allocations
> + * away from them and avoid accidental peer-to-peer DMA routing.  The
> + * reported windows are pessimistic (the whole host bridge window, not the
> + * precise BAR ranges that may actually conflict).  If a IOAS has devices
> + * behind multiple host bridges, query each device and take the union.

State clearly in the kdoc if the list is strictly non-overlapping, or
the list can have overlapping ranges. It makes a big difference to how
userspace has to process things.

> + * On input num_windows is the length of the windows array.  On output it
> + * is the total number of windows.  The ioctl will return -EMSGSIZE and set
> + * num_windows to the required value if num_windows is too small.  In this
> + * case the caller should allocate a larger output array and re-issue the
> + * ioctl.
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
> +	__aligned_u64 windows;

IIRC out_windows is the convention in iommufd

Jason
