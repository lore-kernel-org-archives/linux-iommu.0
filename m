Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0B36B;
	Wed, 15 Jan 2025 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899304; cv=none; b=Mylhwib4xqCecD80gYfC09DI1YRrw5spDbHPHo9YNTDnqlTC6blis8rXLmBy4U4Ewo+xZ44m+vgSaIKK+Xmawk/t7zoic/hYgXoiQSg8JFzsppzVW+e/DsU5fFfjga+n0Uz2GOz/bQpiitZ6mH+Jv90Gsuv6nrceJMPPzKeNpek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899304; c=relaxed/simple;
	bh=R5zLWF7CbOxpfboysM0ptUUtByEdQJcyaoamCb44Zic=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Phtd95673ICzYUbrT5rQt8lw1oDk6JV6v8q2e8C14iP8MTRLt6n6VhIJZA8utLO4HrDF9Snrl6C3C7wAkF5UjuMFw5+WLEX+efRJrbR1zFAYjjLMPmsT/Ac9b8LZxaoDONaww/J/ror8Z+EiIIo5tAeAHBD5w10mvQFsoyXF0Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlM6PkkF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlM6PkkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1727C4CEDD;
	Wed, 15 Jan 2025 00:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736899304;
	bh=R5zLWF7CbOxpfboysM0ptUUtByEdQJcyaoamCb44Zic=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=AlM6PkkFCtHnMVVMSXFes10U94llQpl5jo1qnvjauWoEc/xd/Gi3pJJ8dpzMyOJkB
	 wTLYlybnW3hO+v9f8sIEOuaoRJoZRdh/cYVePR1YICKJyPGWCXopf8y9Wg0hVvIUhz
	 T7uvmjDQ9KQUkvyzZlJ2Q415HpZpyHJnmojbzHdTS3Hh/zvpUMoD1fIhbAKdQ4L2zd
	 q3qooO+8XJE9gowk3hWuMbzU99ZBXgqgW1ThEWyoHG+mmLa+XRPzi7kSYm7cNzZrD+
	 gj78gZrv2RsUo2wD/AUyFn/6p/hrrPsXf77+qZak86YY9DIlYAMVF7Tr4HUEnxBgin
	 MNvHxfndnkYew==
Date: Tue, 14 Jan 2025 16:01:40 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Milan Djokic <milandjokic1995@gmail.com>
cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com, 
    palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, 
    sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
    Slavisa.Petrovic@rt-rk.com, Milan.Djokic@rt-rk.com, 
    rafael.j.wysocki@intel.com, sunilvl@ventanamicro.com, 
    takakura@valinux.co.jp, linux-kernel@vger.kernel.org, 
    xen-devel@lists.xenproject.org, iommu@lists.linux.dev, 
    oleksii.kurochko@gmail.com
Subject: Re: [PATCH] riscv: Add initial Xen guest support for RISC-V
In-Reply-To: <e4a649a7fdfc8fcf5f48a0bc4e76e5d546078083.1736868605.git.Slavisa.Petrovic@rt-rk.com>
Message-ID: <alpine.DEB.2.22.394.2501141554170.2684657@ubuntu-linux-20-04-desktop>
References: <e4a649a7fdfc8fcf5f48a0bc4e76e5d546078083.1736868605.git.Slavisa.Petrovic@rt-rk.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

+Oleksii

On Tue, 14 Jan 2025, Milan Djokic wrote:
> From: Slavisa Petrovic <Slavisa.Petrovic@rt-rk.com>
> 
> This patch introduces initial support for running RISC-V as a Xen guest.
> It provides the necessary infrastructure and stubs for Xen-specific
> operations. Key changes include:
> 
> - Modifications to the RISC-V kernel to integrate Xen-specific hypercalls
>   and interfaces, with function implementations stubbed for future work.
> - Introduction of Xen-specific headers for RISC-V, including event
>   handling, hypervisor interaction, and page management. Functions are
>   defined but not yet implemented.
> - Stub implementations for memory management, grant tables, and context
>   switching in the Xen environment, allowing further development and
>   integration.
> 
> Signed-off-by: Milan Djokic <Milan.Djokic@rt-rk.com>
> Signed-off-by: Slavisa Petrovic <Slavisa.Petrovic@rt-rk.com>

Hi Milan, Slavisa,

Thank you very much for your contribution! Which Xen tree are you using
for development? I am asking because RISC-V support in Xen is still in
the process of being upstreamed, and [1] is the tree that consolidates
all patches currently on the to-be-upstreamed list.  

While the specific Xen tree you are using is not particularly important
at this stage, and using [1] is not a requirement, I am asking because
it is essential to align on the hypervisor ABI, especially regarding any
details that have not yet been upstreamed. Specifically, is there
anything in this patch series that relies on features not yet upstream
in Xen?  

[1] https://gitlab.com/xen-project/people/olkur/xen/-/tree/latest?ref_type=heads
