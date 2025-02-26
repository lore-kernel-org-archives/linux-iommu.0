Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2418B42A9D
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532389; cv=none; b=KkMGDi5Xd9tUYyOJvESn0l/piGKjXJ8syYEUKyRrhWI/vukmFh7bj7uhlfbxcBgWksTO8httA78piae5LivBus3ThX4OLeUin/9CG8M5dGdBKmk5f8nvy0qER8uTNc/yxTNJaZDZDMs/szVvXxEjt0eqb/tDzL5KNj32EsJ07kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532389; c=relaxed/simple;
	bh=ZhYvcbnSpdbK5dNhM69G2KfnETqhUalySkxQijX4+Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er6V8206XtjaHvMrGycTDbZHZN7yir1P+T+VpMod3BXxNgL7AG463FMgEiMAtsgOBp7cPftAGXhxu3c813zO0kqsrGmMxDJdcJKca/8r5pzMGxIj+DS8iZghsP1VWl0KXvSolQy9JYU3v8/B2tuLA/DihybjJTac3OeHcfm6R0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q0+urMBl; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q0+urMBl"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e889e77249so390636d6.1
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 17:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740532385; x=1741137185; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rlfxFtny7lwa4i0i0UdsBfRwT+1oz48jksHZV5cn6ZE=;
        b=Q0+urMBlq3lwVEggpF1JuqkCrbHIAD0hIsnNhfN3NrJD3LpXcjmd7AUbjqUzCBEKv9
         vYXsUeAmRb8yz2m29QjW79dwAjudsjUPR1GBpuDPjG39sgB6Gj4EttvuAHxbqJdwpkjw
         v5Ud/WB8mAiSDaRl3mrl0ouGhN0v4Jn722Y6l2TiD/Q/QMl0UzoCNlbjwrBdbl0T4uCQ
         ndt75K876LmjAZvJmb3v9OENGsKawCAzjsoio2+bJJdGzPM3k10HxWexqxeAn7y0SV2V
         Aiq28n/g1QMljop+QUITk1Cvt38lQPaGPgqftWyVSmgYnZeCHumVi+GuyapfB77Q+0T6
         MbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740532385; x=1741137185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlfxFtny7lwa4i0i0UdsBfRwT+1oz48jksHZV5cn6ZE=;
        b=Ns64UqeqOXjeGJzID7agKmcByBHnAqEd3N1vJHh22AJQvuaS4F+dUVn06RRXPnF8V1
         XzMTGfQUD4gG5X1R7t4cjtzM34ydZU87LzWrbT/Y3vYpi867pc45gmT6mlNfEyOrP6x8
         Jucus6hjk5cSSDEcsThCqc/7u2/wGD4sOXeJHiynkVexsJub19Da4FUa9eXQNNBIuyPV
         6lWOXEQdiZ89V2Y6trsEdZ/E4flJIIL/zoR+qwHtcw585ibpovpo/chlAdl5pmOY6kL1
         cay3oq7A/dKvyVTx3a8UtMA20g1ANN/dV+ql+2m2nVehSZSyMw2oYcCxOueNyoDcF13J
         /eUw==
X-Forwarded-Encrypted: i=1; AJvYcCWQhsTdB04TvN71Pm5+eUU4Mf5+XcVxiuFNvUtYBRW8UaX4z68hO0VhLd6OoZ/1np4cloxEUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YybHeZQebGsMzFHNDH4Vyr3kgHxmHEFPln1OXr9beeflTAOCIkI
	QtTf9gsF9Fx+zYevJSOSBx5Ss6MnDA+HFEGyEe2WwqsoYLGnZNuXLugvOInCTxM=
X-Gm-Gg: ASbGncvVnKFzdM6o3ImTpKW/RdZcixfU/uFgNm7hrt0CYDbe4KupzX6oSTPhDbOLUR8
	VpI6tltcM2WHolR8JY5fipiu90hO2R40KWwKTVqcB4XPW0kbh5zG7tcW5WFYDMGbrof1g8QplBW
	fjyLyF/mcamE7lc5pCsFVbUj1z3m3y/wmegbK/lMMFwC+SVe0/Lo+uFs+GnOcdvKpskCTz/Cyy3
	rGSm0qy/vx6bZi4NlMpuYtfgHfuktZvl0jwO1IbybCVnBvfiX5eA7ak1Po4JprJC6V7IINARLad
	DlXZ8+EPyX7Ei26AdCkBKUPyFmJQnsTfWZdnGKPyWxFMQiBzHxWL2qvFpWOLcFF3n29dio8gR+g
	=
X-Google-Smtp-Source: AGHT+IEGjzO6dZT9M3ohgUCf1czI+cDFTJT1sdWhxC9D61QbteETCn7+ttTXhZ28C0n8SvSwA0mDwA==
X-Received: by 2002:a05:6214:2486:b0:6e6:61a5:aa57 with SMTP id 6a1803df08f44-6e886887be5mr22871866d6.14.1740532384913;
        Tue, 25 Feb 2025 17:13:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b176d77sm16162346d6.109.2025.02.25.17.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 17:13:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tn5yx-000000003sz-0oIa;
	Tue, 25 Feb 2025 21:13:03 -0400
Date: Tue, 25 Feb 2025 21:13:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250226011303.GA5011@ziepe.ca>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <baa35632-eca7-4779-8862-b032d56f82e1@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa35632-eca7-4779-8862-b032d56f82e1@intel.com>

On Wed, Feb 26, 2025 at 09:09:29AM +0800, Yi Liu wrote:
> > What are the options here?
> >   1) Translated Address (TA) is a full physical address and IOMMU does
> >      do anything (today)

> do you mean "do nothing"?

Yes

> > Not sure how to setup #4? The core code also needs to detect coherent
> > systems (ie CXL/etc) and refuse to do anything other than #1/#4..
> 
> The DPT and the HPT validates physical addresses. So such tables need to be
> programmed when a physical address is mapped in I/O page table. So the
> choice may be associating it with paging domain (e.g. the S2 domain that
> converts GPA to PA). If so, a domain alloc flag is also a good start.

Hmm, so you imagine doing it as a side structure under the map
operation.. Maybe, that will complicate my effort to unify the page
tables somewhat, but maybe not too badly.

Jason
