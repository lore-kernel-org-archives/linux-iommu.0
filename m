Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89633D6B
	for <iommu@lists.linux.dev>; Mon, 24 Oct 2022 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=smrlip5a13obHQefsrQCDEQn5FVgi9wQ3jfaysBd41A=; b=NsKy3KADUVtTLDLcow8PjYW4Wo
	u6xSIAOYezInwqNo4+VT4wXNh9YuZGynjlYH9HyRLsxjXAu7kOE3YYpM5vo2KK5Pd+utDaLWiQbYC
	HRXXEhnWxE4UH/sbLmRBRQr0Xt9ABDoMTGEbbr4YxdTsO1AI5D+O2/MoLsnrLCzvQ/823wQayvkRq
	FhklZ7JXqNnbcsXc9bH5iJMN03RBwLg5kZ7KeA8EJBlppNQ3vcpgBt2Jj3NjIoakO14Nx+KJKtJ9m
	GrXYA5oVoFe3jLO7ovLun05d0vuXmlnCFUL7TNGWThrId8XaRc6F1+Ve1ZxMF/YkvUsUQ3HPSO1r2
	lA9+dfiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omzUq-0026gk-I2; Mon, 24 Oct 2022 15:36:12 +0000
Date: Mon, 24 Oct 2022 08:36:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Michael Kelley <mikelley@microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
	sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	luto@kernel.org, peterz@infradead.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
	bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	thomas.lendacky@amd.com, brijesh.singh@amd.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	Tianyu.Lan@microsoft.com, kirill.shutemov@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
	isaku.yamahata@intel.com, dan.j.williams@intel.com,
	jane.chu@oracle.com, seanjc@google.com, tony.luck@intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 06/12] swiotlb: Remove bounce buffer remapping for Hyper-V
Message-ID: <Y1aw7L5IdpjFpQvw@infradead.org>
References: <1666288635-72591-1-git-send-email-mikelley@microsoft.com>
 <1666288635-72591-7-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666288635-72591-7-git-send-email-mikelley@microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 20, 2022 at 10:57:09AM -0700, Michael Kelley wrote:
> With changes to how Hyper-V guest VMs flip memory between private
> (encrypted) and shared (decrypted), creating a second kernel virtual
> mapping for shared memory is no longer necessary. Everything needed
> for the transition to shared is handled by set_memory_decrypted().
> 
> As such, remove swiotlb_unencrypted_base and the associated
> code.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

I'm more than glad that we can kill this code:

Acked-by: Christoph Hellwig <hch@lst.de>
