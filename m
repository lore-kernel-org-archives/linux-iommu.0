From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] iommu: exynos: pointers are nto physical addresses
Date: Mon, 29 Feb 2016 10:54:49 +0100
Message-ID: <26472865.zD5Ep58Exn@wuerfel>
References: <1456735568-3886545-1-git-send-email-arnd@arndb.de> <56D41087.60506@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <56D41087.60506@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joerg Roedel <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Monday 29 February 2016 10:33:59 Marek Szyprowski wrote:
> > ---
> > I also see that some incorrect __raw_writel() calls have crept in
> > around the same time, which breaks running big-endian kernels when
> > this driver is loaded.
> >
> > Please fix and that that as well.
> 
> Okay, so in the driver code all __raw_writel should be replaced by
> writel(), right?

Yes, writel() is always the safe choice if you don't know what to
use. __raw_writel() should be considered an implementation detail
and not used in drivers at all. There is also writel_relaxed(),
which is faster than writel() because it leaves out all the
barriers (as __raw_writel does too), and you can sometimes use that
in the fast path if you can prove that no barriers are needed.

	Arnd
