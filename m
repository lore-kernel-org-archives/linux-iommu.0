From: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH 5/9] iommu/amd: Implement .flush_np_cache
Date: Mon, 15 Apr 2019 19:18:21 +0100
Message-ID: <CAPL0++49xZk=bfkBu4e0cS_NA3gs7_z0tiifZBL+Jp8d_6S1rg@mail.gmail.com>
References: <20190411184741.27540-1-tmurphy@arista.com> <20190411184741.27540-6-tmurphy@arista.com>
 <20190415063351.GD1377@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415063351.GD1377@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, joerg.roedel@amd.com
Cc: iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>, linux-samsung-soc@vger.kernel.org, Dmitry Safonov <dima@arista.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

This is a cut and paste from the current amd_iommu driver. I really
have no idea if it's a good idea or not. It looks like
joerg.roedel@amd.com might be the person to ask.

@Joerg Roedel should we keep this?

On Mon, Apr 15, 2019 at 7:33 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +static void amd_iommu_flush_np_cache(struct iommu_domain *domain,
> > +             unsigned long iova, size_t size)
> > +{
> > +     struct protection_domain *dom = to_pdomain(domain);
> > +
> > +     if (unlikely(amd_iommu_np_cache)) {
>
> Is this case really so unlikely that it needs a static branch prediction
> hint?
