From: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH 9/9] iommu/amd: Add allocated domain to global list earlier
Date: Mon, 15 Apr 2019 19:06:36 +0100
Message-ID: <CAPL0++4cvqD1gg=mDASrLRBv69ei75v-g3BWWW+Poz3_TUOkbQ@mail.gmail.com>
References: <20190411184741.27540-1-tmurphy@arista.com> <20190411184741.27540-10-tmurphy@arista.com>
 <20190415062316.GC18154@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415062316.GC18154@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>, linux-samsung-soc@vger.kernel.org, Dmitry Safonov <dima@arista.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

>This seems like a fix to the existing code and should probably go out first.

I'll send this patch out on it's own now.

On Mon, Apr 15, 2019 at 7:23 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 11, 2019 at 07:47:38PM +0100, Tom Murphy via iommu wrote:
> > dma_ops_domain_free() expects domain to be in a global list.
> > Arguably, could be called before protection_domain_init().
> >
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > Signed-off-by: Tom Murphy <tmurphy@arista.com>
>
> This seems like a fix to the existing code and should probably go
> out first.
