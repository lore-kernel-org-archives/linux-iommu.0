Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1217DE11
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200344; cv=none; b=Tbc69E8QhALC43iiYVNi048KgEOLo6b7MJnooednjIua7ObFb0DF6jml85ps95cqtIYxsqoioQ4Ga5F55Fw8Zqq4KrKLn+NTvGx8s6LEpbI9ys2iCxXCE5QFxh9GzscREOwbX65BzuxlEBKwlOlHJxQWzXchoE2ILdBWdugK4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200344; c=relaxed/simple;
	bh=Oo7eKQ/vuiKK57nzWHRwBZAQcLEcZwfz+apajKIxjpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfiIiNIG5YjRC7HtowU2to7NthsIVV6Yd4cbmWZoiMEmNWYzSfF28mgHcT1BoYRaQRFWJyEm/8/m9/UbUlfFAED9CDXpvhshFDqUL3x2n85pZuSHiDGSXgCN3X7+/zX8xAnnWuaypr2VkRUlAZfx9Zf+8eHr3u727URurs+oqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a1eKVays; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a1eKVays"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfb12fe6f96so4065068276.1
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718200342; x=1718805142; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n4yFXPH48K7YremfXbvI5F9w5geLcApF+zrC9idLOg0=;
        b=a1eKVayseDOipAphO64X8HfrwsgX3c45C6IUyjKBsueR7I5EqKrfjJc8KnNrHT2BYp
         R1reRCoXAY6tRERNgtQCYSKQitk8aBO0zPCs7F/oEyO7KM0UteRy6Vj6qTjwFLKZxD9U
         BjnHZjm9DUOyNZbN+tEtqGTFqPNQcUcoI2J56eAnB8U8z++44JkpoWP3U6m1oXcMRI39
         1Ni+MN80yn52MNtV9TdD2+6L38LwxWPggsIf6W0IE4P5UgclcUdDV+AgMSUTLgTqAo29
         YvHXAmo8ZhIWvebQjzpB/LheuspD3r9Cc2ISk5IwGwiJaLtVuSwAd+QJE/W1rJuTWL5H
         9Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200342; x=1718805142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4yFXPH48K7YremfXbvI5F9w5geLcApF+zrC9idLOg0=;
        b=HTB8FsmhD1eZ6lGXgavues5tS8aWhoIhqwOy+y1w3eDyT/JEr9rMSH7jUkfiCc6q8H
         BZ/iaaNkdW1LuTZWZ5NLhii+OZB8EPHpvIG91TLdeqeHHKl6S7SWWHcTPvKnBO7II5IO
         FHvBIdyC020pyi0HL+Hqu0ErCjL/pqXcD+tRtU6IuyR+j6CzlANBpSGjizPKddteogxl
         PVlTYLQyvnMSV9CE3ZvD1advoS10xU1H6TYZBSYjrkhnaNvNMgT54wMveQ0veAB08r0L
         L9vuDtSPxL41y1312jXVbliF4BQTmqwPP8M2eE57BjoAu4IZ5216iAXxxvkP2j69+ThP
         jKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjmagIV0KtEu0uPAmWPW9WgFqFefyU44FWv09gRdyqSWRFvj5pvuymdCcfTLnM1iTfXFbi+a4Waq7OK0Ued3p0Z1T9qRs=
X-Gm-Message-State: AOJu0YykJyne0INWdq+/3Jh6L2LhCH24XW9uv8rLnskBda8SegYSBv5m
	J3o1FrciLF2LY93d48gSI/jIOclB3H3o15Au0YWE5pmBvJ7nEAoiR2ONBf7DNC0=
X-Google-Smtp-Source: AGHT+IG5MsAGFlJNLCZBYHd/CyREyJszvbTdf4kNLXCsh8V0bZu+GJ7j2/lX4r8ZXtpS+8b1yVkNJQ==
X-Received: by 2002:a25:ac14:0:b0:dfe:388e:2987 with SMTP id 3f1490d57ef6-dfe694f0e9amr1659594276.64.1718200341645;
        Wed, 12 Jun 2024 06:52:21 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b08dafd095sm16499226d6.130.2024.06.12.06.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:52:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHOOh-0091GZ-F3;
	Wed, 12 Jun 2024 10:52:19 -0300
Date: Wed, 12 Jun 2024 10:52:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Message-ID: <20240612135219.GZ791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527040517.38561-6-baolu.lu@linux.intel.com>

On Mon, May 27, 2024 at 12:05:12PM +0800, Lu Baolu wrote:
> +/**
> + * struct iommu_hwpt_pgfault - iommu page fault data
> + * @size: sizeof(struct iommu_hwpt_pgfault)
> + * @flags: Combination of enum iommu_hwpt_pgfault_flags
> + * @dev_id: id of the originated device
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @perm: Combination of enum iommu_hwpt_pgfault_perm
> + * @addr: Fault address
> + * @length: a hint of how much data the requestor is expecting to fetch. For
> + *          example, if the PRI initiator knows it is going to do a 10MB
> + *          transfer, it could fill in 10MB and the OS could pre-fault in
> + *          10MB of IOVA. It's default to 0 if there's no such hint.
> + * @cookie: kernel-managed cookie identifying a group of fault messages. The
> + *          cookie number encoded in the last page fault of the group should
> + *          be echoed back in the response message.
> + */
> +struct iommu_hwpt_pgfault {
> +	__u32 size;

Given we fail the system call if size is not exactly the right value
we should probably drop it here.

The ioctl to get the FD can someday specify the format of the fault
messages if we need to upgrade. If we want to change it down the road
then the old FD will be exactly as it is now, and the user will
request a new format FD that only works in whatever the new way is.

Jason
