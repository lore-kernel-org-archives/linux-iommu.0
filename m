Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE428E8;
	Mon,  7 Nov 2022 09:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B630AC433C1;
	Mon,  7 Nov 2022 09:22:36 +0000 (UTC)
Date: Mon, 7 Nov 2022 09:22:33 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: kernel test robot <lkp@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 04/13] mm/slab: Allow kmalloc() minimum alignment
 fallback to dma_get_cache_alignment()
Message-ID: <Y2jOWXz0rdM/+jfx@arm.com>
References: <20221106220143.2129263-5-catalin.marinas@arm.com>
 <202211070812.BhGKB0Hd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211070812.BhGKB0Hd-lkp@intel.com>

On Mon, Nov 07, 2022 at 08:50:31AM +0800, kernel test robot wrote:
> url:    https://github.com/intel-lab-lkp/linux/commits/Catalin-Marinas/mm-dma-arm64-Reduce-ARCH_KMALLOC_MINALIGN-to-8/20221107-060303
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20221106220143.2129263-5-catalin.marinas%40arm.com
> patch subject: [PATCH v3 04/13] mm/slab: Allow kmalloc() minimum alignment fallback to dma_get_cache_alignment()
> config: parisc-randconfig-r003-20221106
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/309bc52a1ed9665a1b9d32bcf094918ceb6af519
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Catalin-Marinas/mm-dma-arm64-Reduce-ARCH_KMALLOC_MINALIGN-to-8/20221107-060303
>         git checkout 309bc52a1ed9665a1b9d32bcf094918ceb6af519
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    mm/slab_common.c: In function '__kmalloc_minalign':
> >> mm/slab_common.c:866:52: error: 'io_tlb_default_mem' undeclared (first use in this function)
>      866 |             cache_align < ARCH_KMALLOC_MINALIGN || io_tlb_default_mem.nslabs)
>          |                                                    ^~~~~~~~~~~~~~~~~~
>    mm/slab_common.c:866:52: note: each undeclared identifier is reported only once for each function it appears in

Thanks for this. It looks like I didn't test the series with
CONFIG_SWIOTLB disabled.

-- 
Catalin
