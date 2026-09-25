Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452A44AB6C;
	Fri, 25 Sep 2026 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330500; cv=none; b=qCdpaTgszfkNabOFO/UFNJhLaoFa/n65hm9tQneMkOGGhuggVeFRlJHLK4TxU/E2Zz8TKlOORUfxhC3PqMW50CDr9f6Z9BMJbTjrJBaeNBtfYeKPQcdNbZIVP+XBp6g7mM/iO7F37ifGbnPKoDuQrPGUPcomma0iQGkQWwBxUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330500; c=relaxed/simple;
	bh=/pqGybG3gH7p6HG9P9eE+H322CVWdY9u2eX8pVq+/A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXcOeX3P3gDwT2HfrUxX+y3lTWlbRRsXTDqXGi+QdLvlX84B2qh1Li++H5+ReB8ONHDfORXAqF2Q9MzIv2qbosZtoJJU34QLdlr37n1fWQLw1F7HMQ1xaEMcIe9kLGRld+LiLbWhISjhY2P7z1bNsKiUz+0QQ7hdx4mGQ702uXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYwfCVG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYwfCVG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8911F000FF;
	Fri, 25 Sep 2026 10:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790330498;
	bh=c1qtZNQkSLL9jY8cFQvdaU+DuydaEVSzJnJZ/ismFcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QYwfCVG6JAMk9qByU+y21OUB9XibtfndvajO/P2w7i07XB6jM4pCcFfEi1rihN0Hq
	 PPAeBGcD8eS9KCGS/SVfxF/uxjLrJWevPD8sjNr1R8XIxfToJi8pC9iLHsMY7yhhJK
	 jWCMB8aF9MFdHncbuAbST10LwBnUox+VupAGDrMfxXrQAGn6toos+Kqon3eq6NFkFL
	 JkQhaXFeC5Ojd3fXHIx+f++/u6WV+xe6ZIAE3v/e7s5+NTiCHAK62jLz4O37pFyDLe
	 oLYAA9BKMOrOJX6vPzeWQklm3EmXoHI11TXkbqImkKOJQ3O7y32eQDSi9MSY1A4Ehc
	 cXVjcto8MTV9Q==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 919B6198003A;
	Fri, 25 Sep 2026 06:01:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 25 Sep 2026 06:01:36 -0400
X-ME-Sender: <xms:fUa2asZjlTTZThjWtSXaPFZJgFBkPnUcvkqUZslxtET03teSnRpFlw>
    <xme:fUa2amoAxKgYnO5i2XNOhhxeIngCv5Id18Wb4ZmZTTfyyQeXVjC367AEl48R0Ymb-
    N-wqC9bFjvNyVKj6H8KDnn2ct9Di3B8mSNtusLXcArlZ2eL0u7N87DX>
X-ME-Received: <xmr:fUa2ajL-639cc4qE0KKv-MgFk1cpqQ4AC0xvbceQOuTWyx4IWGeVB14YLn4>
X-ME-Proxy-Cause: dmFkZTFaHL7/M+1Ihc5bUYqYtFwJSgrnURianRf/JR5tgLUu7fXkjZXZfmxr42uVkLDENz
    n6CT7lbp4ydF0hj9OqU2bDAPnJ4sy7gAysDEagQgRgjtp5/JepVQ5/DqM747wnWVnxDpTm
    jrc4s8XALNefiP8J76+Wd9Svwha8zvIC0O9O96YtBwgD0mX6idSPc1uKI30oRERQlqN8L3
    Lr8Ld3qlOHIm8iMljBRija5/BxhTJp2TXV2Mkb4SNPIlVJe3N64zVavtx9WdcYOkYU023N
    aDiaeR+VutG0GUjhSEsKc9hMRKknxanLE2/l1pwQvzn6kS5GFbP3ihVGhp6eMTXXkGvkBS
    AmeIHYIzhZ1yFuqqvqaHttceMfXxJ9esOyF3qN0yTrvFw5l7swuIkeiaIWZfmYXCLOkUxH
    VeWCFrW6XfDAicXxWHkznCBWbqieq0djlQ2YFijalVtJhux2dw5S6+WESijC+Z5SzkpHD8
    6AP3T5/WJZ2Twln5733ADDWrueKkQAIHBNwGdZOaXqWW2Ih4AoS7VjqMXcHB/MboRVRphc
    DhHmLwygPFVFuzkxTsFkVJmQ+ak4ZvhUKjAEascAyCoLk6pNwzBmTcsQ4y24hX2qaB7OjP
    0Bk2Z8itCVYzHmcxnXZN5gCoQguQAyxW7M12yG9pjkOqhVb6di6ypYXqSAig
X-ME-Proxy: <xmx:fUa2ahZg5cvFEiejGT_ny8tJvzmJMMCC6JEOjYjtSmZ2BAsNA8rxTg>
    <xmx:fUa2aqpZiordqWJcp4HQOrUmrM111pY9DfhfHzjmDir62mi3QT7Gcg>
    <xmx:fUa2akAIbnxQmmH6kSR8fZHJpOaxnd33Ad3h83f7tdT8gDu1pfm2Tw>
    <xmx:fUa2aokJ9B0Y8g2Ixga72Cl0sERlNFrflt8vPCraPEXQcvYYyqT6KA>
    <xmx:fUa2ahptMA3Q0ZKMkk_xxAAkDBS9NMREmdQlWyirfizDxAIVAR4NwhgC>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 06:01:32 -0400 (EDT)
Date: Fri, 25 Sep 2026 11:01:31 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Krishna Reddy <vdumpa@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>, 
	Usama Arif <usama.arif@linux.dev>, kernel-team@meta.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iommu/arm-smmu-v3: Add a cmdq_max_n_shift module
 parameter
Message-ID: <arZFDAofKaurSjCd@thinkstation>
References: <20260909095228.2174031-1-kas@kernel.org>
 <20260909095228.2174031-2-kas@kernel.org>
 <179018301689.3334538.1783583175230817305.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179018301689.3334538.1783583175230817305.b4-review@b4>

On Wed, Sep 23, 2026 at 02:03:36PM -0300, Jason Gunthorpe wrote:
> > [ ... 34 lines skipped ... ]
> > @@ -40,6 +40,11 @@ module_param(disable_msipolling, bool, 0444);
> >  MODULE_PARM_DESC(disable_msipolling,
> >  	"Disable MSI-based polling for CMD_SYNC completion.");
> >  
> > +static unsigned int cmdq_max_n_shift;
> > +module_param(cmdq_max_n_shift, uint, 0444);
> > +MODULE_PARM_DESC(cmdq_max_n_shift,
> > +	"Cap on the command queue depth, as log2 of the number of entries. Zero means the hardware maximum; the queue never shrinks below one page.");
> 
> The patch looks ok
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> But I'd rather use lg2 as name, especially user visible, instead of
> n_shift. "shift" is a word for bitwise stuff, this is a 2**N log2
> encoded value.

This name has changed twice already. v5 took the value in entries.
Nicolin asked for a log2 value and named it after max_n_shift, which is
what the driver calls this quantity everywhere else.

I would rather not rename it a third time without input from the
maintainer.

Will, this is the user-visible name. Do you have a preference here?
Unless you want it changed I will leave v6 as it is.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
