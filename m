Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA42225E458
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858660; cv=none; b=ojMZ024kWYS16/C0Z8U4l4sAigRzAqyNnHMneaMa1XvGS0CAIhPKXbTjOgSxh1LxieUMXYCvyBeWL5RxbpXBulqc/FS3jN661a/H/cK85yXWyflgaNdIb4mD572A0esKP9Q9qmQxBszJA/++iliMcU7T5sWRxB8avQk7l+IoEnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858660; c=relaxed/simple;
	bh=UdYQ1Nu+L55yueU5BMkbqZe3IiP3IgOF4R8o04XgR7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpWdFwJbCorqzRT4v3sYrRjk4g5MzTf2fb+oxI0wpKro1QU5rLDi5Qcvwj9VI6ZDjpsMZ1oYqAWl3dDxUILAnKWH6WKpKIInKjVA0Gw0OhFUUPHqI6YGEMJvruMNjzvcvYAW4U52l5ycgxfaeXmFeMz+0g/DfzFag5dNmzzFMm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aC4BBwlY; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aC4BBwlY"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fae04a3795so18848696d6.3
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750858656; x=1751463456; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NglHKItE2MnRf7kVBkJpZrmGam+ZtM8lvAR6jGRQjyo=;
        b=aC4BBwlY222ivap27RzODdAFvScIJcxnbqeaPKRHgQPOIbuyRJ43lTX84aZhHwDyJ0
         I2W1QPTthjfENf5g+CeXTVIFQQF3FB7Ij95U+HjxzWbdHb0ogbx+6qb22lc4ZKrdKj25
         pVw8WKz8KCWzZzJEJUnAD2/SlqtwYiEHfpDqCaVq7vyz/Gn/45b0RKA7E2am7cqaVvoA
         q+qpKoiEvSYhuyj5aum9m+GYOtH7LA1HpAyGUfWmwRxTHKtClNYnVYQQyME1w4m5dRs5
         r98VmoipekXnxKDLevY0ME/e/hOiAWFUN4ej91JhGGnT+7tYNn6Nc4smzYcary1NgZHM
         BGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750858656; x=1751463456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NglHKItE2MnRf7kVBkJpZrmGam+ZtM8lvAR6jGRQjyo=;
        b=b4o3CXFj6U7yocVfFdr4qVdeW/95OJKW6CJqIcHrj4USpOW6/qLQwzxM6O8NeU1oKM
         +8QD6zQUuBoc44Pi/NeptOeacq3rfGiw5e1uc0OpYewJvqh/HPmnxiuO8k4G0N6mcYX8
         pJPwdZY7UyDsyh4B/on2z5Ss46QoPvBE0mcCsiLWWvqP7m53/IYsCRb1LA9jNNV8TCyY
         aAHQL6ng4pi80scpemNcU06+IFrEXhsHACfXYu3fAt8qsRwPx8x1hjluFNQH77LwFVVp
         xSd2BzhTDIu4BU+AHIG0xrCBHhhv/iM6mphF0kU+R2n2s3cvNp/D/T8/q+q64dk6KBDa
         jMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCFOwH7MuBBfZuKf256Oh3/pNuBMQRkfGZyCxtWbPKvAP7+DQiMrr5krMGcDVD7+qm/ehBbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRV5g1oi4zv48kdPb37vb7/Ze73qJF9As/YZaqrc4i8iqlFgBO
	qkruTXRgepqWr10zota7jVW3ESTXEquayEIdHDIqmfasRmlwJ+eGbVTIAxdZlthDC9E=
X-Gm-Gg: ASbGncu/lwfybyIi18LAlmVG+rg3w5AjGRAp3ApyzgjKfkJtKWdd6b1BRlvk8N2K6rn
	6juOSdwaPlusijAAVbQ7eWVwtVG2HYTWcjDfu6qj0/WVpEUBTbC33g0yibCSklrF9vTVqUs9zuO
	iosJ1IkMbFp9H6sXAxE11McGGfP9HNY7MPYqnmb0ptNrKFF0T1AVprqnxZwHMUtef1KyqLPIWGM
	LW3u4fO835qZBQaNebjiFockUKRg/eB2MI0JDWGEFjHIobyEl/7S5SNFiZVsUq7BUrUKsu19emo
	1WMRBFhWkQ0ZnIP023pH8+9PIPWbs2bJyMESZWJBMi+SrSBwBc5LWnwt8kLn6WcUzZoh1lFjTvO
	nvYvotm1UYZIHvYg6H0JCm7swgyR634pstHCe8g==
X-Google-Smtp-Source: AGHT+IHNWTn84Obl4sCOYge34wUPUvuPQlJlnAKQv8tTsnsg8qT0v7mGMowd+Em7yTBlsKIc3f9P2A==
X-Received: by 2002:a05:6214:cc1:b0:6fa:b9e9:e799 with SMTP id 6a1803df08f44-6fd5ef802afmr35290316d6.24.1750858656416;
        Wed, 25 Jun 2025 06:37:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093e167esm68119946d6.18.2025.06.25.06.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:37:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uUQJj-000000014g9-0Uom;
	Wed, 25 Jun 2025 10:37:35 -0300
Date: Wed, 25 Jun 2025 10:37:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	yang@os.amperecomputing.com, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	james.morse@arm.com, broonie@kernel.org, ardb@kernel.org,
	baohua@kernel.org, suzuki.poulose@arm.com, david@redhat.com,
	nicolinc@nvidia.com, jsnitsel@redhat.com, mshavit@google.com,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v7 4/4] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
Message-ID: <20250625133735.GB213144@ziepe.ca>
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-5-miko.lenczewski@arm.com>
 <aFRlDSZ2PPnHixjc@arm.com>
 <7105112f-b0bb-4191-b3c9-93522162319c@arm.com>
 <636c8901-6e05-479f-ae06-ee391d4d36e8@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <636c8901-6e05-479f-ae06-ee391d4d36e8@arm.com>

On Wed, Jun 25, 2025 at 02:07:23PM +0100, Ryan Roberts wrote:
> I think what you are saying is that despite going via invalid, the HW may see
> this direct transition:
> 
> +----+----+----+----+
> |RO,n|RO,n|RO,n|RW,n|
> +----+----+----+----+
> to:
> +----+----+----+----+
> |RO,c|RO,c|RO,c|RO,c|
> +----+----+----+----+
> 
> There are 2 logical operations here. The first is changing the permissions of
> the last entry. The second is changing the size of the entry.
> 
> As I understand it, it's permissible in the architecture to update the
> permissions of the a PTE without break-before-make and without issuing a tlbi
> afterwards; in that case the HW may apply either the old permissions or the new
> permissions up until a future tlbi (after which the new permissions are
> guarranteed). That's the first logical operation.
> 
> The second logical operation is permitted by FEAT_BBM level 2.
> 
> So both logical operations are permitted and the Arm ARM doesn't mention any
> requirement to "separate" these operations with a tlbi or anything else, as far
> as I can see.
> 
> So I would interpret that combining these 2 in the way we have should be safe.
> RNGLXZ and RJQQTC give further insight into the spirit of the spec. But I agree
> this isn't spelled out super clearly.
> 
> Perhaps we can move forwards based on this understanding, and I will seek some
> clarifying words to be added to the Arm ARM?

FWIW this matches my understanding as well.

AFAIK the actual physical issue for BBM < 2 is the TLB lookup HW
cannot tolerate having two entries that overlap in address because of
different sizes. Every lookup must return exactly one result. If more
results are returned the HW fails in some way.

For BBM 2 if the HW lookup gets more than one result the HW selects
one unpredictably and uses that.

Permissions shouldn't have any impact because they do not effect how
the lookup is performed, they are the result of the lookup.

I've been looking at implementing BBM 2 support on the iommu side and
I didn't see anything that said we cannot do arbitary transformations
under BBM 2? For instance when degrading from a contiguous range of
block descriptors down to single page descriptors I'm expecting to go
like:
    16x2M -> 2M -> 4k -> FLUSH

Jason
