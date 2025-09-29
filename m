Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109EE1E9B35
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161088; cv=none; b=UfUidYsbIhggJH4D5RrsyNVGl+tvzYF+IQOsc0s+8KjQK+WXdc5/AGEnvQJCROECZ6AKHbMlGYlDptgoEtiHQ9Te6fGEa3/83Nr1BxeoOiAcdzUH8tJUn75LBNAO0eAqErLm6Ai4YE67JDVr4Jlo71L470Q0i2uWLqjfJdeAG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161088; c=relaxed/simple;
	bh=j12PYgPvI4mST8WYTzVIepUS1TEez0LNB32yuIJo0sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r59x8xA4Q1S5jHJp5+iBSWdAsvXY/oI84aKc6odVWFqHVqyAQrQY4svFYyELwZe6KH4JbCFfd6kdDkoZFN2jeO7A299hA+b+x5reyePfey5z1onirx5v30ei9wIXwgRKtuhF6AAbF462fwIdXt039tmllN97FDS5Dm9XOhbhr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iUThW9ns; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iUThW9ns"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4de8bd25183so43054891cf.2
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759161086; x=1759765886; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Put4MtO4NY6a2XmnhJf3sCRZjJgIgJeqBjj8elXuKDg=;
        b=iUThW9nsMlp157OpizIDQggWsJ9SqvxlfHd8oNp4PLIfOPYuW7c8G4a2V9CmlGnSwu
         5qseiFDuBzFlUL4EhQcrGWjLKrTbRp6FLY8CJX6mfwJDpkdGW6RDb5Y8D3Em1tx0FhUG
         PXmjW7vlXzmlq/0qFQ1BWUc2zat8xlFbE5zShosDR0aDfZ2sh6EZ4mnDB2TgTRY5Cpcp
         dg6ub3kOC7GsxMAYbKKzyMe+HK66aUVM8Dq4i1bcLjtIlXZiGxVOSn8OduM6PnfdYeHR
         V/QNZmio8m3JRzUHJNVNWuiQDtK84Oz7tSPpU3WcJOxxyspHauPNTixiHqAL0I8VSDGR
         6sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161086; x=1759765886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Put4MtO4NY6a2XmnhJf3sCRZjJgIgJeqBjj8elXuKDg=;
        b=TXK46cEwu8swvks00SQ0wiGO+1FNnD46eXOB3SHVXn7accmNYNUF/EBJJHqTfNYLHV
         SbwCtQjWpEc0DtfBmMFwalYVdpm39gxkLEQRwwxgObLzPUehvRO+0Tv7k81lJmQDm6P9
         /v0xoJ37aGfGnAvj4l08i4sIYZ/+LJSchqpVS50W9cjCEPdbZCsnFXj7T8bBqHUEWGld
         Y73sDF40R6k678fk9nEpVqiwd+rtKnKqXQ5dkNsRqrG5cHx92msBP8HOkKdtXGoQNKO1
         ZdvXljyhK/WuIozbZObmchDQwmRMlze3u++zQzMGmzLHKqscJDKq29Q8nM+pmtr/svv7
         CxvA==
X-Forwarded-Encrypted: i=1; AJvYcCVxqZBTgLL/rfg/59sxF5GSU0GYN/mx8tq4keRcY5j7ilk7dXsQugDbrN0p9NDhfR+zrSnlEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHvVd9hWe0l4elyKUXzXkHRie0Y9b85tfkIqH5fzTNljILLyzz
	Dk+Ydthl0L4Zu3rUILbs+B0o+MoKqe8TXjhJakyyA8xokKeBbNWHB4EN29bX+mh8tKU=
X-Gm-Gg: ASbGncs6A8GLM1jTxOfTnRHqyu+3C8Sw7+BesPdJXJLzEeVeGFLM4w+OXpJeUD9PG2+
	mvND67YZBjhUs6Umqjs6aqdR8AaYn0QCRmQ8mUzZ9YOYuKDIKXWGVydU4qYKzUhGeveC9MHT6Jm
	9i5+vsdFbjxu1gUmdaOuWAO1EJlOM11tv9Ov5yw7YMm84JspL3RooLO6tBYaOU+chRTQnOG7JvG
	LxXOoJDkrXsDtKn4KBsYSKCkapnqX/mTzumot09gBACr4lsBt7V240B/lVdYhp6gX8H2AvheBjc
	xsMSDsB2z2huVEUsbuAmP851Ek7j99gmD48scAAuTHoa9ZnbR18ew3LgxSlh5lJwCRz/qlQq
X-Google-Smtp-Source: AGHT+IGgK/H6E95ZEVHjccaoGgpq05fPxt0rIDHkithQ/hz8a0kgKH5wKvNfO2Kv1RxwdJoxGAgPtQ==
X-Received: by 2002:a05:622a:212:b0:4b5:ed9d:7bcd with SMTP id d75a77b69052e-4da47c05749mr321551731cf.16.1759161085754;
        Mon, 29 Sep 2025 08:51:25 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db108726a2sm79374111cf.34.2025.09.29.08.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:51:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3G9r-0000000CM2n-36dx;
	Mon, 29 Sep 2025 12:51:23 -0300
Date: Mon, 29 Sep 2025 12:51:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	zhuyifei@google.com, Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 03/15] iommu/vt-d: Prevent hotplugs when live update
 state is not normal
Message-ID: <20250929155123.GC2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928190624.3735830-4-skhawaja@google.com>

On Sun, Sep 28, 2025 at 07:06:11PM +0000, Samiullah Khawaja wrote:
> Hotplugs should not be allowed when the live update state is not normal.
> This means either we have preserved the state of IOMMU hardware units or
> restoring the preserved state.
> 
> The live update semaphore read lock should be taken before checking the
> live update state.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/intel/dmar.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index ec975c73cfe6..248bc7e9b035 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -26,6 +26,7 @@
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
>  #include <linux/iommu.h>
> +#include <linux/liveupdate.h>
>  #include <linux/numa.h>
>  #include <linux/limits.h>
>  #include <asm/irq_remapping.h>
> @@ -2357,6 +2358,10 @@ static int dmar_device_hotplug(acpi_handle handle, bool insert)
>  	if (tmp == NULL)
>  		return 0;
>  
> +	guard_liveupdate_state_read();
> +	if (!liveupdate_state_normal())
> +		return -EBUSY;

Pasha, this is madness!

Exactly why I said we should not have these crazy globals, people are
just going to sprinkle them randomly everywhere with no possible way
of ever understanding why or what they even are supposed to protect!

There is no reason to block hotplug. Do the locking and state tracking
properly so you only manage the instances that need to participate in
luo because they are linked to already plugged devices that are also
participating in luo.

Jason
