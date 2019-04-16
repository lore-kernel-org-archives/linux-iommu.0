From: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH 3/9] iommu/dma-iommu: Add iommu_dma_copy_reserved_iova,
 iommu_dma_apply_resv_region to the dma-iommu api
Date: Tue, 16 Apr 2019 14:22:38 +0100
Message-ID: <CAPL0++7Z=EMpYOvUn8yvcRqRT5iwJMD8zLhmFr4uFbH7W3WqXQ@mail.gmail.com>
References: <20190411184741.27540-1-tmurphy@arista.com> <20190411184741.27540-4-tmurphy@arista.com>
 <20190415063134.GB1377@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415063134.GB1377@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>, linux-samsung-soc@vger.kernel.org, Dmitry Safonov <dima@arista.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

I hoped this could be an exception, it's easier to grok without the
line break and isn't crazy long. Because you mentioned it I'll fix it.

On Mon, Apr 15, 2019 at 7:31 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 11, 2019 at 07:47:32PM +0100, Tom Murphy via iommu wrote:
> > +
> > +     WARN_ON_ONCE(iommu_dma_reserve_iova(domain, region->start, end) == NULL);
>
> Overly long line..
