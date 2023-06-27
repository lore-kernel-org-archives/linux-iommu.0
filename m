Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7ED7490
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 10:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5F7C433C9;
	Tue, 27 Jun 2023 10:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1687861466;
	bh=F1Hg7UsWABbNZA5AQvDBMQsjEQe6h9OaplyEUWz37bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2NwjqsUMcDX/nRTxfVAJKchvBq0J8/jCjoiPE/BVWSq5g708DSLg16ic9OHGuGIA
	 yuU5bxvGd6YG+SSKFuayAVa/x5wvWepMKMdGGFdgfHwAvR+pb341M0KuWKavjeak5J
	 sma7fq1Z3LAEcoV/YQiR7MTXGlucUZab2xSmpk5M=
Date: Tue, 27 Jun 2023 12:24:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kees Cook <keescook@chromium.org>,
	Saravana Kannan <saravanak@google.com>,
	"moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
	"moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>,
	"open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, petr@tesarici.cz
Subject: Re: [PATCH v3 1/7] swiotlb: make io_tlb_default_mem local to
 swiotlb.c
Message-ID: <2023062745-routing-palace-d0b4@gregkh>
References: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
 <a1ef6eeab8b64fac817b9734da4a056f05a68d01.1687859323.git.petr.tesarik.ext@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ef6eeab8b64fac817b9734da4a056f05a68d01.1687859323.git.petr.tesarik.ext@huawei.com>

On Tue, Jun 27, 2023 at 11:54:23AM +0200, Petr Tesarik wrote:
> +/**
> + * is_swiotlb_active() - check if the software IO TLB is initialized
> + * @dev:	Device to check, or %NULL for the default IO TLB.
> + */
>  bool is_swiotlb_active(struct device *dev)
>  {
> -	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +	struct io_tlb_mem *mem = dev
> +		? dev->dma_io_tlb_mem
> +		: &io_tlb_default_mem;

That's impossible to read and maintain over time, sorry.

Please use real "if () else" lines, so that it can be maintained over
time.

thanks,

greg k-h
