Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B241D37C97
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A27161FB;
	Mon,  9 Oct 2023 09:46:46 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29A853F762;
	Mon,  9 Oct 2023 09:46:04 -0700 (PDT)
Message-ID: <74e81490-1765-4f13-9fee-04b58696bbde@arm.com>
Date: Mon, 9 Oct 2023 17:45:59 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/6] dma-direct: add depdenencies to
 CONFIG_DMA_GLOBAL_POOL
To: Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
 Jim Quinlan <james.quinlan@broadcom.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 arm-soc <soc@kernel.org>
References: <20231009074121.219686-1-hch@lst.de>
 <20231009074121.219686-2-hch@lst.de>
 <CAMuHMdWiYDQ5J7R7hPaVAYgXqJvpjdksoF6X-zHrJ_80Ly4XfQ@mail.gmail.com>
 <20231009091625.GB22463@lst.de>
 <CAMuHMdUZNewD-QC8J7MWSBP197Vc169meOjjK6=b7M11kVjUzg@mail.gmail.com>
 <20231009094330.GA24836@lst.de>
 <CAMuHMdV2FXdUHtjYW8JyXGBgHhR8De0vp3Ee77e6G8Vbs3gG8Q@mail.gmail.com>
 <1cd44af1-10ac-465a-8d20-e0aa268e036f@arm.com>
 <CAMuHMdXNX7+VLnSYhj=M9dTSTWLJqjS_WaT0ceMRUYoa5_MSeA@mail.gmail.com>
 <20231009124805.GA7042@lst.de>
Content-Language: en-GB
In-Reply-To: <20231009124805.GA7042@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/10/2023 1:48 pm, Christoph Hellwig wrote:
> On Mon, Oct 09, 2023 at 01:10:26PM +0200, Geert Uytterhoeven wrote:
>> RISCV_DMA_NONCOHERENT does not select DMA_GLOBAL_POOL,
>> ARCH_R9A07G043 selects DMA_GLOBAL_POOL.
>> RISCV_DMA_NONCOHERENT does select DMA_DIRECT_REMAP if MMU.

Bleh, guess I should have known better than to trust my Monday morning 
memory without double-checking the code :)

> Yeah, and we'll basically need to split RISCV_DMA_NONCOHERENT into
> an option for each type of non-coherent support.  This is why we
> should never have added support for any of the non-standard versions,
> as it's turning into a giant mess.

Indeed the main point I was trying to get at is for ARCH_R9A07G043 (or 
rather possibly ERRATA_ANDES_CMO) to not select RISCV_DMA_NONCOHERENT in 
its current form, since that ending up selecting DMA_DIRECT_REMAP on a 
platform which can't support it is the thing that's most obviously wrong.

Thanks,
Robin.
