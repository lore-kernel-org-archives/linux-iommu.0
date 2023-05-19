Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E36108
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 09:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C14C433D2;
	Fri, 19 May 2023 09:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1684489295;
	bh=bfRXzfA+4eDvf/14Qin4xBd4heYAioZH7PAmRqxL6x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4nJRQZNTfnA7/kRNR4BocxOvF58liyl1zaNPUVgL80JYjS1AEZsiN4bP/uiGX8j5
	 vqOZHDdJZYRJglCT/terxaaI6kWjeGq6dmK+7Q1rR4mNCADj9ghFhJMx9RT/PzrNV8
	 MqoTkQ96R3hQLrgxFOfHlLtycpozlRYltrX9/1/I=
Date: Fri, 19 May 2023 10:41:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 05/15] drivers/base: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <2023051916-drastic-imply-5cbe@gregkh>
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
 <20230518173403.1150549-6-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518173403.1150549-6-catalin.marinas@arm.com>

On Thu, May 18, 2023 at 06:33:53PM +0100, Catalin Marinas wrote:
> ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
> alignment.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
