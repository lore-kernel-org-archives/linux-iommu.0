From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] iommu/exynos: Replace non-existing big-endian Kconfig option
Date: Mon, 17 Jul 2017 17:42:26 +0200
Message-ID: <CAJKOXPcQuCE4N=MuJPu_4AEcx7pgd-8VyRxese7D_nBQE9o7Cg@mail.gmail.com>
References: <1500270422-4805-1-git-send-email-krzk@kernel.org> <201707172340.xpsuGzYj%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201707172340.xpsuGzYj%fengguang.wu@intel.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>
Cc: kbuild-all@01.org, kbuild test robot <lkp@intel.com>, Kukjin Kim <kgene@kernel.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 17, 2017 at 5:25 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Krzysztof,
>
> [auto build test WARNING on iommu/next]
> [also build test WARNING on v4.13-rc1 next-20170717]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/iommu-exynos-Replace-non-existing-big-endian-Kconfig-option/20170717-141202
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
>
> All warnings (new ones prefixed by >>):
>
>>> drivers//iommu/exynos-iommu.c:58:2: warning: #warning "revisit driver if we can enable big-endian ptes" [-Wcpp]
>     #warning "revisit driver if we can enable big-endian ptes"
>      ^~~~~~~

FYI,
Everything is fine, this is an expected warning which I am bringing
back to life.

Best regards,
Krzysztof
