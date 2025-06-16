Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8902B288C96
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095189; cv=none; b=YOIrrFmfE3klBBwM8/mguYtU6bf1ZZy+dJgMrDQ+/tV3WlLDtHiOBn9Kgqp1Fvp1iVfPecO+NB+EBB/dHLC9esZQYWiG9npnaaA83B1kVMHaC8OVK0qF37zrxcsXg7Z5DxyTsEFeA2x/dgSVUzQKYuXe1B+z2WKOb/MSO3qZrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095189; c=relaxed/simple;
	bh=xFsrEhbFGU3z9UoiI2uJaXv//xa6Xz4juyBcTH3R7C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4Lyum2HnASpdc+gNHkYKJbGz/YXa7K9Cg/HMPyaA5NHa8iC1EW0T7nJsOzMFDIV9j2/Vs0tYFsX8++AtkmtzlKpmXaBNin6SSj2XGVzi3OoZ6Piobm0GPeYt6CtGPz6yVxTL61vZoUgUqFgU4xPhJ1bcuLay6xG/K/R4UsdCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=drqhHnHS; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="drqhHnHS"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d3cc0017fdso242868185a.3
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750095186; x=1750699986; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8X31SysrSCqMRM+zb4wzBK8eDdmvTJaf6Uq+iS7ehOE=;
        b=drqhHnHSpOW1JDYYB2RpeH2S/H5md1qSpXxYJQrLOauxW4vHcswcMQGKHzme+cLzZH
         yd0ots11BTp1FsW5C8YyseBmxesdooLmZ0x+DWFnlDM/IuiEg3KB4AeiSme9IednEOeO
         8LwX6JqKNf2rE5BWZ+Q4wOEOCDJJTIiD0s89tDL3Fogw/9qETJUDg+p8zg02QJbpl18/
         OCacL/Z3OmuoNbl4V5TBDvGzTdxrx1GkfNTDevN8iTT4h3Dea/CrZePq9Ac/LFxzoTGs
         gJiAFW0mHnZcReQL1x3fQYJkVrGtzct21B9nWSWtMCN5CeUm9vkKOBDE8iXHSKW0AwM9
         fS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750095186; x=1750699986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8X31SysrSCqMRM+zb4wzBK8eDdmvTJaf6Uq+iS7ehOE=;
        b=BiWIux4GfflOepVigOv8Hkt9aL9jePUbwR5wTGJEHcVwY+CLmuh6dkZL6FNPazUXMR
         YEDuqUS6/Ovh01B4nBjfUtWnz6OzPH39EZSab0pgb8GxpWALNPyuUTOuAmYmK7ePd+Y1
         KB0fi52OUS1buaJCKbkJ1D675um6r/NJng0jWgyzGgcjwzbHz1JDFa5FrhngcoyK/p/U
         C71wksbfQYydIwhnRPHHXP2tUDnEOzbV7pQ+eMUdbmcLfvUC9LIqLhFY1K1ju1njku4g
         hCwwx+uJNg4io2+/D+2G5zLbWyUUvuatP9QAosA8f2NX4U8wp9G3re0XmLzdSX3RzXK3
         Mr/A==
X-Forwarded-Encrypted: i=1; AJvYcCXGbEw/f97toBarRHwY4FGq6DI6l86SeTlQ2iz3n7oFMDMg08q0Q6Vt5oMZqDlZoPbEslBdQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXilquxJJEVTkuZ7ekLsPNQV5BAe3+xBcrYmb4aek+T+I4OHwZ
	RCNo/VQx0p6lEumAGs2r1Auvh7VgT387bodLHBy6i+eNg/06FGF5Eagq+C5QjSB3vcc=
X-Gm-Gg: ASbGncsWqTrk6mY6aERaimyM2M/oNh7Ol53TqBROkxobqF1gzVgfLfFO0suMfntel/a
	LC2new7PLaNpiNz6jCuvDS/BKepJL+akJH3tA6Xtoaf63EzbEFvqo+gxd4OGYHUC3+pmNycRHam
	Y4UjKiakfsLgnIe64tOoqoRP805AvobnTSc7+SqhSdJrjdcXt6zDITtIa6VmYMe/WtyicNAuwVe
	OoXozLYZGawLq6hhdZOQS3T4dLkAQoOl4D++CKAGtHv9Iqx2Vlf8LTVfTW6dEWmonriDYCCS5NS
	Fr1TiUdXMkHx8HN049CO0wY+TMw5J8aM0KzzSbSD+eTxpny4RW3aHwTLajy6BBFRUGYijla4ywI
	nhv8pEeRV1C9OEoVxSoTy9H8SyoJNXUvckARPqQ==
X-Google-Smtp-Source: AGHT+IF4chGBuDLOAfxdrZKfkSU9t0Ai/SG6GB1rXrSJpRvbZP1WNygH1xEW0dli48w32M0hptcl5w==
X-Received: by 2002:a05:620a:c4f:b0:7ca:dac1:a2d9 with SMTP id af79cd13be357-7d3c6cdf0c2mr1264284085a.28.1750095186387;
        Mon, 16 Jun 2025 10:33:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dc9b58sm553436685a.13.2025.06.16.10.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:33:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRDhh-00000005m43-1aC1;
	Mon, 16 Jun 2025 14:33:05 -0300
Date: Mon, 16 Jun 2025 14:33:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alyssa Ross <hi@alyssa.is>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, x86@kernel.org,
	Spectrum OS Development <devel@spectrum-os.org>
Subject: Re: Virtio-IOMMU interrupt remapping design
Message-ID: <20250616173305.GA1376249@ziepe.ca>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
 <20250616132031.GB1354058@ziepe.ca>
 <8c3b08d5-24aa-4db2-84e1-dfd1d2c52065@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3b08d5-24aa-4db2-84e1-dfd1d2c52065@gmail.com>

On Mon, Jun 16, 2025 at 12:53:40PM -0400, Demi Marie Obenour wrote:

> > AFAIK hyperv shows how to build something like this.
> Would this need KVM patches?  I'm concerned that implementing this
> in userspace would interact badly with the irqfd fast path.

I don't know. I think you get the same issues even if you did
virtio-iommu irq handling, it shouldn't be any different.

I'm not sure there even is a fast path here, remapping happens during
initial vector setup/affinity change only. That isn't fast path. So
long as the MSI is delivered to the correct CPU vector entirely in KVM
it seems OK.

And the hyperv approach of asking the hypervisor for the addr/data
pair to achieve certain parameters will work alot better with existing
Linux than trying to build a iommu emulation where the guest is
building its own private addr/data pairs :\

Jason
