Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EAE12C54B;
	Mon, 16 Sep 2024 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517473; cv=none; b=mM0YpSdCAg3BljIBJb+z1sAmFfDIAqxwFhNCYzu8iveARNuf56UkRV6KI3EDaZa+sy29lbKj2JvGWWOV9srGVdUa2pBd6TsqQ71nofhOwWxvEsisu4LOeBfeEfLZma6Cz1guS7H+umMvp8b5yTEliOeIBmQp9Z4+zsCBfQ05/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517473; c=relaxed/simple;
	bh=7xxeWsqRcrCxoadi3+koKT0WOIpuhPaRbtLyPtA77bs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rwBA7onQ9CuiU6vGpbl3ho3fzPHkF2Ll3Ia94rp1vgPP6e85wHzQkVdTMW+uisgeJGjLuKjDArKON1UGxnzZA480JZu6Gwu1OchuCRbxp+K314a40N0xDwLhiX2PCGL1ls8kI0Sck1IZsPKO/951Ed0A/1lSTFfcrm3SSb/0waM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kExIBay3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kExIBay3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F1FC4CECD;
	Mon, 16 Sep 2024 20:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726517473;
	bh=7xxeWsqRcrCxoadi3+koKT0WOIpuhPaRbtLyPtA77bs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kExIBay3WywWDJXf4lrsk3I3J3fyBZjWFSUp2wll/2aYTJz2zyTblmY9kcagsPK5e
	 huZ6uT6Fnb+M0JEgCRX9c5YSuwG8c2/z5trX+eLloC+tDDjD61sRL5Uw60BMUQO3wq
	 G4fXlimhNjt5kXFJIJyENxLmOurRW7l48bvfA7NGoR7bCtnUMNFmP9j4llgblBWQXP
	 Hu0BfdXIPMbrX0Fw1UKp1gTXzgeZw2XAjtUGqLxQ98NjDqT7V7Qf/3x48DbFW91E2y
	 qqLcjQ+Q5FYvyr5WaGughNb1Sm23LpJmrkmSCSUnsu0d3wj6iukrPYlPS3vZsP+QdC
	 jj6I7czhS1+KA==
Date: Mon, 16 Sep 2024 13:11:10 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Jan Beulich <jbeulich@suse.com>
cc: Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
    iommu@lists.linux.dev
Subject: Re: [PATCH v2 2/2] xen/swiotlb: fix allocated size
In-Reply-To: <d0075562-6a21-4a87-b7f5-854f09c0743a@suse.com>
Message-ID: <alpine.DEB.2.22.394.2409161311010.1417852@ubuntu-linux-20-04-desktop>
References: <20240916064748.18071-1-jgross@suse.com> <20240916064748.18071-3-jgross@suse.com> <d0075562-6a21-4a87-b7f5-854f09c0743a@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 16 Sep 2024, Jan Beulich wrote:
> On 16.09.2024 08:47, Juergen Gross wrote:
> > The allocated size in xen_swiotlb_alloc_coherent() and
> > xen_swiotlb_free_coherent() is calculated wrong for the case of
> > XEN_PAGE_SIZE not matching PAGE_SIZE. Fix that.
> > 
> > Fixes: 7250f422da04 ("xen-swiotlb: use actually allocated size on check physical continuous")
> > Reported-by: Jan Beulich <jbeulich@suse.com>
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> Reviewed-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
