Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55130E831
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776123636; cv=none; b=Uehq56H8BP6jDNuwKMhMEqsZDAIe9mmwgWHHZWTHjCDGpFoySt7VpJv+8MweHXlgUf6Sf69lgLdlRXUkZo4FhcRHbvrl62ig0XMN1IKtXd1t/puH19fbRb3ELIURWvrlJc5BdmlM1WbUSRvyE15yljhspq7fgDZyHy+n/u7Ihvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776123636; c=relaxed/simple;
	bh=q9GsDWqx4vIAmP/y72aLjZfj1Cz9Fw5+/QUmCubtrss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ75jeG1iO769cpJU+jAfvQ5g2SRUNZzxYvqSIRsjku6e61izgr0donQTn+vDKbjoAPT+VfQUdiwxGGSfGVY5CrtvkFMyZqpFmK6FqRO00/HdbTh7wYnyVU37Vh05bso4gId30Tao/RjKc484LNNQDe4/aCyMcWo6nxyU/2ypiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=knGVJ68Z; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="knGVJ68Z"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d75bfb259so33557191cf.1
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 16:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776123634; x=1776728434; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ToWxrQd5JMxwaz3rbuBFhGsBagVFYiOF9oK6XIorEnc=;
        b=knGVJ68ZbgWms6kfuuaA79ytWgGZtfwxaOcnGDp/KYKsYTYO6RbtDTjLQM8krKYl6L
         5MUBqXo3/A2WBFOirfGnFZylyVn6cjyNGLhb68PQZpK2rLfKEeICxmqqkMZjOjacDW3D
         yHJAHyYyjUYrOZ+ebfLK0CqhF8nR22+ZhK4x1ipbw7BpMe4Ki3mbvNLUx07k6zsE3DT8
         C5clUe73z/nvXYqa08QbXl26sSsZxmQlWo9ih8r+8AYjR/eTFBGt6LFcxM5SHJTpO6Xf
         ywZPzTw8Ng0znJORMLK3zosXfReoJFT+HLmKv009LdXhAhU41Hr7DOjBxvgESotsxlMQ
         BFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776123634; x=1776728434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToWxrQd5JMxwaz3rbuBFhGsBagVFYiOF9oK6XIorEnc=;
        b=L2T1t2hDdFssYiTbDt6Zm5XM9Dk7dSvu8Pz68QHKW7Zg1a7ZNVfcVPSadJ+V9ljcJy
         nr5/M8gUX2ZWUwTB0iXyoGRKwb991c5Pv2cxk8khBMbWL2G5tTBXO3vAYz7b25PFVpFf
         EmV/L84l5ZsDhgf5E67tJfTH1dqrGYwfSDNZKMcne1L0VRtPr74j+aB+e+dRcuMREmnA
         Dgt4gewm77UhH261NExA4y47IER9+P27Xwh+Azy3zzjxAc5OD9Yvn+uWy9UBHssll9yi
         YgLzx3ym8caWPazyobO4CHsn/xI6GF9h/+gYINQ9inP1/I0TCtLTXVP6DGJgN+Gd/YBh
         OG4Q==
X-Forwarded-Encrypted: i=1; AFNElJ80nMj9Rju59C4c9LkDILNSOQNdbuiphmD+cmbHJ0u3quBYzxEGoVFhYDpgl3/g3tdUBHhhZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNNDONVOIq+wq/a/3RSKvawEbemqn27ea0hPrl//vGMxT6qkG0
	02GiaoowcA/rC/RhxnsD4IbVVnENk9uOylM0v3b2aMPgj+jLdfuotNzT2sRM7qrouCA=
X-Gm-Gg: AeBDiet0rJ+uUFRkww2BH4hHSWy1GvX0FJDTw6vvqqroDzo/QM4GIqEZef4RVzMcXsG
	qPwNRcpvJB/ABCzZnBRuKLc2OzYJs48Mi4ISNq+eABGZXmzz9/lwwRz2KvkaYKTmLfLlJC+Yo/I
	gTCgUhpPvSIR9r9wcX29KrkBEyPVIH3t4ULK1XNPo/2M87pvmbJjCA69ENquqqomAQ2ZDpJ4dP1
	5ojNICQrGNlSzQsABnOHeFyQwlteiRKcdfWHLjh/ZwdqB0VmYZBSc0AW9mtmktevKrIhkGa6QaR
	fcGXyVGZfT3Q4IA9PQnp5RgW8u+WixiuGQEkDw0Rw1UzQh9cwkaMl/ox6OK7C+V1RI3rpS3nnj3
	Q9f2uGffmsrq64w5wDLilb2ph73IZPuW5n2OPsyfRhLrPJOmvUF3M4mokoFrT8fQJaTQ0LqdlFV
	PI2r20hfgy0k966QwV4UFqId2lhULtGQqgx8Ly6Kj8SWqRCZjFfwIhx03vUym8j1wgOPs8bjVji
	HfDFw==
X-Received: by 2002:a05:622a:209:b0:50d:65ec:a071 with SMTP id d75a77b69052e-50dd5a91ae1mr245871871cf.5.1776123634207;
        Mon, 13 Apr 2026 16:40:34 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd5607b83sm98638941cf.24.2026.04.13.16.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:40:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCQtM-00000007OXQ-2rtN;
	Mon, 13 Apr 2026 20:40:32 -0300
Date: Mon, 13 Apr 2026 20:40:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <20260413234032.GT3694781@ziepe.ca>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
 <20260410141652.GV2551565@ziepe.ca>
 <adl2QX6gra99bkOV@google.com>
 <20260410231650.GD3694781@ziepe.ca>
 <ad0b-5aRU172-Od8@google.com>
 <20260413223318.GR3694781@ziepe.ca>
 <ad1z6YYIiO_jBX3P@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad1z6YYIiO_jBX3P@google.com>

On Mon, Apr 13, 2026 at 11:28:57PM +0000, Samiullah Khawaja wrote:
> > Hmm, even the free walker requires computing the end_index, and that
> > requires at least vasz. eg ARM will compute the number of items in the
> > top level based on vasz to support concatenated pages.
> 
> Yes end_index setup using "derived vasz" is exactly what I was referring
> to earlier. Basically KHO stores the order of the folio, so we can look
> at the order of the top_table and that should give us an idea of
> vasz?

The top range can be smaller than a full page too.

> Even if actual vasz is less than the one drived from the order of the
> page in next kernel, rest of the page should be filled with zeroes, so
> iterating through it should be fine?

I wouldn't do that, it technically breaks the design.

> complexity and ABI right now. We can put in more functionality with
> subsequent patch series to handle other usecases. WDYT?

Yeah
 
> > I don't think sign_extend is used in the free path though.
> 
> I think it is used in the pt_all_range() during free to calculate the
> range to iterate over. Based on the sign_extend it decides the vasz and
> that affect last_va and that affects end_index.

Hmm, Okay it used to not do that, now it does :)

So that will need to be preserved too

Jason
