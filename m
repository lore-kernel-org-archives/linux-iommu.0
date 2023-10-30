Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461019BA7;
	Mon, 30 Oct 2023 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAXxk0e6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C231DC433C7;
	Mon, 30 Oct 2023 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698689969;
	bh=5GtnFYV8Mb6DhUTgqlJ5wPItxp7J5N0wGspvp9t5BJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QAXxk0e6C+CdyqyyGVNKLToY1jBNTNz2EMkp0XlwXRXV13xXz7N50L6oYNp+JLrgL
	 aVfNgMmNOuXbHIuj6mHSXWQwet58Gq1bB6kub82ug2toudzl24AUPGkLlWiC0qzRRm
	 ewn4gAsTEbRfTVqS4OAg9elTkegiC6SwTknuxnhuekAX10hQmI9f+nGEIIPLEZmzqf
	 x/HYgDMQqk3Ph9QtoLNWKft8LDiaDFwQ4StLsaHJ7+1t9gF0feZu5QGLgy/xn1Qt4v
	 IyouIIcda5LPpi1GJnG2PKePclJkaDK5eLvfNn/kEBBhZGzVW4rhy/m8WiR4A6gSVY
	 nZ2ZpYZjvdFWA==
Date: Mon, 30 Oct 2023 13:19:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Eric Pilmore <epilmore@gigaio.com>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: IOVA address range
Message-ID: <20231030181622.GA1878727@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQPn8uAWqR+0Qpk+Ua8gria06xx99ge5MnCGi4MwPOZNaXBvw@mail.gmail.com>

[+cc folks from ./scripts/get_maintainer.pl -f drivers/iommu]

On Fri, Oct 27, 2023 at 12:17:17PM -0700, Eric Pilmore wrote:
> Need a little IOVA/IOMMU help.
> 
> Is it correct that the IOVA address range for a device goes from
> address 0x0 up to the dma-mask of the respective device?
> 
> Is it correct to assume that the base of the IOVA address space for a
> device will always be zero (0x0)? Is there any reason to think that
> this has changed in some newer iteration of the kernel, perhaps 5.10,
> and that the base could be non-zero?
> 
> I realize an IOVA itself can be non-zero. I'm trying to verify what
> the base address is of the IOVA space as a whole on a per device
> basis.
> 
> Thanks,
> Eric Pilmore
