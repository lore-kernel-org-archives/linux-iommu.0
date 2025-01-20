Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8813D531
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382804; cv=none; b=M4Q5+yiPAbUZpKvALrUebeuX24LHdyWCD7MmG0GG9OGaGaGJyCxvzuXu5f8aERhP5NubvX2dXfs205IGO8AEHOnpR8ALbZGi8YrT2IiAI8zF+Wye2MvBUPqBsbi9GG7eQEODve8F/2j+Gpe4TmOoat12j/9A8mnbRXfALoK3xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382804; c=relaxed/simple;
	bh=ChimlzVgnnRdEx0IbwOEzpVywHcES5IyZTAkGygkZMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqWC/KNf8ahr5Eplj7eMpDU7ghjKawDPFUJWJ5Rr5qtpdeRVIF0xMqx3bVjmduIS+pnzXLYBEPJk9q3ZrodAxc/m6DQ6r87vAcQygFJvEQG2YQUpQ58zqtzcGMFzUvDLmCx1iNFt6qYJZ4ILmKx8Gsp9tUfwwY5OKZncbT/kmwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K9qQ/1u4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K9qQ/1u4"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be3d681e74so411503385a.0
        for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 06:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737382802; x=1737987602; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJYVtS2wyp4YmPXThKgYxTKEqaWqBzZ28kCjv5DfTK0=;
        b=K9qQ/1u4YZe3b2/3h9K4UwHr2ry5KA6bh+DcvjzptwvESSmbroUylnpHEbrapcg0Hb
         R7IVog9HxRWHRayomre2ZC71yUNvE0DATohzlM6VBrHvgwQLyOFKggu2erjlf5OxSIm6
         lwQVZWAexznvhTBlYRlc5DhUYZxs55oheqtYTSSLaSjDOe5+zpfrzfOnOdhOKlobfEjU
         WdSpivMjCw3fCQRyYDe9WtJwjcDxLbQKdilBu/ZuJtxnUzlhPm2gDj0I2eQJpDPp0ZIc
         HS2Sv9mCcPo/eFk7dY5ATQC+HjaGNdtb4R8LRHwv01/UcxaDP3FCKsd1TwBHAbl21hhB
         eBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737382802; x=1737987602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJYVtS2wyp4YmPXThKgYxTKEqaWqBzZ28kCjv5DfTK0=;
        b=QxVYyTlFyzMd7Uez+ogaaBMNXumNkrDJVeHdj0WMsm5xmehb9gJKqLtH2F9Kc5c1rA
         yJcSFcSIiGUT+XcBKoqhORRBoFP+ftH6ZCxcu2HI+cFQqOQM/zSKjsTsPvpv08H4D4J6
         rGjKgXBhF0wMRYH9pu5+kUC+3XkNU379/H8cXzfhC9MxhKe92DYcdGtpewGGR3kFxwzQ
         cYRIlOV+tQGsXxvZRgITOigZxJgrLY1rQzWwi3onmxB9G48QMEbMKQw9We33+XuErwVu
         dIoBbeVi3IJ2lWm+9ybpQuhnYaQvsV9VmFYUCv4wHGx3v/WHTTbMeQgsbENTHiKhUCPw
         t1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUvyheZraW6CVXvIEcsP1A1dq9/SPD5ukenQU6LfHE08/iapEkcsPxUz9fFjV9f8eSYAqximA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyps1xf/PkWe99lZgbZw+WOgVmHcJaooc/aC3Z9dJCPc4vYjUWV
	j/93PvB30xQ9S3uqg2avcqvvvJpOSm6w/AHe1fMhx6XDYxquwSp5WCHWWnQA7h8=
X-Gm-Gg: ASbGncsXY9jGluJnngGOSn5We3xADsPeJypaXs0t4Rah7RpOJU6mkm4iv8Kf4Z0TZdC
	ut0v9N6tyevmdQ2MnMIm+Fv/M+XlG0jjXitWwcCrGUJLZxJapGgJKxYZ3RuD6qnlu53pelK8FpB
	kBI5mMx+h5euRYKpk4hdpB43vYMNAbdmeBIgeNDnG3OlYt7nGysmOG3X/K/4ce1F2Fhm2horc8d
	CyxpyUkXToWMDQyb58ByXJLozPQihTP0a75JJDZqo+bC4jNRrL6iHIQl3S8vQwPp6ze1NcDqJ6I
	t9iqi5MAm4AO1Tl98MUZvKefxbpIuLc3pJyk7kBtnw0=
X-Google-Smtp-Source: AGHT+IEQfbHlAGgpHPfeCc+lyD5fWS//N7IJUpSAPNWDgqwoZI0jSTzrUMiH8syVCBErRhB4O4Vhqg==
X-Received: by 2002:a05:620a:43a4:b0:7bc:ded5:888d with SMTP id af79cd13be357-7be63210578mr2197984585a.1.1737382802189;
        Mon, 20 Jan 2025 06:20:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614758b6sm447691685a.13.2025.01.20.06.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:20:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tZsdF-00000003Pge-0aIb;
	Mon, 20 Jan 2025 10:20:01 -0400
Date: Mon, 20 Jan 2025 10:20:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, will@kernel.org, robin.murphy@arm.com,
	kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	alex.williamson@redhat.com, joro@8bytes.org, shuah@kernel.org,
	reinette.chatre@intel.com, eric.auger@redhat.com,
	yebin10@huawei.com, apatel@ventanamicro.com,
	shivamurthy.shastri@linutronix.de, bhelgaas@google.com,
	anna-maria@linutronix.de, yury.norov@gmail.com, nipun.gupta@amd.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	ddutile@redhat.com
Subject: Re: [PATCH RFCv2 06/13] iommufd: Make attach_handle generic
Message-ID: <20250120142001.GL674319@ziepe.ca>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <c708aedc678c63e2466b43ab9d4f8ac876e49aa1.1736550979.git.nicolinc@nvidia.com>
 <62ccc75d-3f30-4167-b9e1-21dd95a6631d@intel.com>
 <Z4wP8ad/4Q5wMryd@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4wP8ad/4Q5wMryd@nvidia.com>

On Sat, Jan 18, 2025 at 12:32:49PM -0800, Nicolin Chen wrote:
> On Sat, Jan 18, 2025 at 04:23:22PM +0800, Yi Liu wrote:
> > On 2025/1/11 11:32, Nicolin Chen wrote:
> > > "attach_handle" was added exclusively for the iommufd_fault_iopf_handler()
> > > used by IOPF/PRI use cases, along with the "fault_data". Now, the iommufd
> > > version of sw_msi function will resue the attach_handle and fault_data for
> > > a non-fault case.
> > > 
> > > Move the attach_handle part out of the fault.c file to make it generic for
> > > all cases. Simplify the remaining fault specific routine to attach/detach.
> > 
> > I guess you can send it separately since both of our series need it. :)
> 
> Jason, would you like to take this patch separately? I can send
> it prior to two big series for a quick review after rc1. It'll
> likely impact the vEVENTQ series too.

If it helps you can put it in its own series and I will take it with
pasid or vevent, which ever goes first

Jason
