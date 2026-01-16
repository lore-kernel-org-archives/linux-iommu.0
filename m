Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28E35959;
	Fri, 16 Jan 2026 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768565993; cv=none; b=EubFQ1Vnc1NoQS7+eEHm6JzKNnN/5rB3Mr4BpUS7rDZ7F8fcagO3Cz3v2z59wweGj0Y2D+JuycRq4rjwqb8TfW2gtMHvxn/TxikXyqKGBt9PySEuBWyDU9xTlQShxyxnqW9Sywvc3RMRjrQcbYJZEgolLSNV3ln+XvqwxDP5NfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768565993; c=relaxed/simple;
	bh=N27lR6LD8aLrpqUY3jTvrBfxTbUYZ+iLvKoUwVGh4p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqR31n/zyKHC78O5cuGs3ESzcLyUDZeKHb42aO7QicbJMn8c8swpuedWgvDTvV88J2gk+m85sj/Q1B3FBqMxIZVzUa64v6zFXN4Ic03QY/bUcfW4aaQhtDsjZWPBDK6G0gzkW4FeiOaqErlOnynRgmr0cG22YU4pZLNp4v4qHvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLDqW3um; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLDqW3um"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA661C116C6;
	Fri, 16 Jan 2026 12:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768565993;
	bh=N27lR6LD8aLrpqUY3jTvrBfxTbUYZ+iLvKoUwVGh4p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLDqW3umKUH+oTSWeFot7VEADoh18cZVilBpn//cNgFD3fP0Bxh+2ORvBW1B98Yst
	 GB/QiuV75BD/IAJzSl0SjZ5nI8Nf35O63pUOq3j8tLKWi//TNDE6XNb/iuAbpIaiTV
	 L3Ky+yG5G96EPeyo3Rmhmi8oDXcvMZVsjShSrYq8+B3dvzeIzrFnhM2B6oc4bFmMBT
	 MH1ib2aX1LQSJO5pvg7w3fWjAATy4D2EyqR6051befqLmQKGiZWfPME/S1vX82U7+w
	 yX20DDUn4pt6fugT9hFrKeMcdmd84MPGKKZZ9MLThalk0lScIBzxAQP4uWB9JxNNHl
	 put1nqc2PqCnA==
Date: Fri, 16 Jan 2026 12:19:45 +0000
From: Will Deacon <will@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, xiaqinxin@huawei.com, rdunlap@infradead.org
Subject: Re: [PATCH v7 0/5] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
Message-ID: <aWos4aIxKpqWuHoK@willie-the-truck>
References: <20260114164322.787125-1-smostafa@google.com>
 <f3ab0156-3d7c-470d-9c1e-922195ea27af@linux.intel.com>
 <CAFgf54rVPaUgbouXWQkczCyFQvXkrei_x6FYY6n1X5NkSSwYfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgf54rVPaUgbouXWQkczCyFQvXkrei_x6FYY6n1X5NkSSwYfA@mail.gmail.com>

On Fri, Jan 16, 2026 at 09:08:42AM +0000, Mostafa Saleh wrote:
> Sorry I was travelling all day yesterday. I see Jorg hasn't done the
> pull request yet, so I was hoping we can still change it.
> But I can send the fix separately also.

iommu/core is a stable (non-rebasing) branch, so patches on top, please.

Will
