Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60A210C35
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411156; cv=none; b=U/1LEre6TX+37aHPS4T1c1cJUSa4/e9d5JVxXTywhRuPCfL7IETDnn4P/6RHY5E8sakJ8kpLJWGz7rwGf9KVB1BboGRrYqL4HUL1nP0GR9D1pwMPx5voggwir8xzkaqsYaZgfDgH3c95IMqvk2sGYTx1Ua+UrpYTXzTDxeajR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411156; c=relaxed/simple;
	bh=KZtnorh+6De5MzRF06EfiOi8deC4jcrfngGuRSraIlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNvA/0C7/EaBYKTHyIlpPEgzRosNzyOz7dnHDRGlRL5xv+rT98YvCrF+uxyVmouRv1EVc0SCEogY4CnlXGsHQo06AyCrYMhFlnEAMHhZpNyMZgkN3V3xBYqMvubU+m18ePCsl9WgFQVJflHVqc5AWGe2tmS6AMEhT9RlSDIiUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hXcA67/P; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hXcA67/P"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45aeef3ce92so41022661cf.2
        for <iommu@lists.linux.dev>; Tue, 08 Oct 2024 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728411154; x=1729015954; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+daBNbE4A3/IkoAmsu5dUuddPR6v/H43OmoGOvQMFg=;
        b=hXcA67/PlnQIU5PMQdJXOh5YoZhZr5F6sKWU5H7YZTK6EvJkUxWzpkjMpaO0VtIdiO
         qKnOlEPcPAFRM69jxOJIhd76EK/+tm0krdECiNPm/8VRLYzujmGvm9jKThMCiUwHyPNm
         ca3IvocTjgQnhunrJZ/hlqJ8J33rZHCiIZn6/EduF9OHzuibj4QT7/snUZ9WFEE5bBuk
         ocMof10bY/W9k+u8UEUVOHYGMNoFz3DrpWpn22RhmrUsHY52yuOL2ABcSaB5TO3OVPTj
         KGKCNr8IQdl7styZmkE10m8LEgNIy6gCt95KiJsqDHZ/xzU1ESqSntsT6EygNhi82CrY
         oWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411154; x=1729015954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+daBNbE4A3/IkoAmsu5dUuddPR6v/H43OmoGOvQMFg=;
        b=R7rlf8VL75H7sXIHUn+PK8kTCOFSRE8LHXGdt5vyhNVT/ABMODlu2khl2Bj1e/f4rc
         UIbL5NEEOV/P+OhwscTcrEhY+RGA0z/yp2uu/pc93TMYcSbJ3ylGUXV8ApBxXqUFZCKj
         tvqygXPI9YtuI59BRgxz++GoA9rJf1NS57KtvLt21icqHlfk/Me97LXDmiy4kMz9ac5w
         9bBsf1UEywjlmEllu+2pCS7ra8iLekG9tzz+HaEkwoOlAZd0hz74pOMu08Rt3owDR7Dx
         dYdgta5aGubB4FEy0gck7PL9+aij45GjMbzNBL+orOguzr9XynVjlVPmkD4o3iqQHgoK
         itRw==
X-Gm-Message-State: AOJu0Yzl9M+Gwc1y2FYmXUHNwPDFCF7Blq+R+9xVH+E4ixkKkf5nri1G
	g8C9WtBIAoq/stjnEE6nRNHZpGudXOzkisZWaWJr0scBY4h6UaTj4yLYOFISyqQ=
X-Google-Smtp-Source: AGHT+IFZ7849aZEK7tygFhqWieCpfCpQYJY7F+nz/8tdd79wkaQ8EwIY9JISq9FkFonwvaH6jvNvDg==
X-Received: by 2002:a05:622a:1a87:b0:458:5011:6671 with SMTP id d75a77b69052e-45d9badaf62mr199367281cf.39.1728411153683;
        Tue, 08 Oct 2024 11:12:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da763fdbdsm38396711cf.82.2024.10.08.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:12:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1syEhE-006qUW-Iy;
	Tue, 08 Oct 2024 15:12:32 -0300
Date: Tue, 8 Oct 2024 15:12:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/amd: Use atomic64_inc_return() in iommu.c
Message-ID: <20241008181232.GD762027@ziepe.ca>
References: <20241007084356.47799-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007084356.47799-1-ubizjak@gmail.com>

On Mon, Oct 07, 2024 at 10:43:31AM +0200, Uros Bizjak wrote:
> Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
> to use optimized implementation and ease register pressure around
> the primitive for targets that implement optimized variant.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
