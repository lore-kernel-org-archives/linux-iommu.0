From: Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v6 2/3] arm64: Add IOMMU dma_ops
Date: Wed, 7 Oct 2015 23:10:21 +0530
Message-ID: <CAAhSdy15U6wgZiAVFEhHc1qaBy4cj6jfMmqwJPrHcbxeTKbjag@mail.gmail.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
 <80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy@arm.com>
 <CAAhSdy2tpAfH+i=1axDkmRqZixsbVhd-_9VGvpyQ=5e06v=Kpg@mail.gmail.com>
 <56154A08.6060207@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56154A08.6060207@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: laurent.pinchart+renesas@ideasonboard.com, Anup Patel <anup.patel@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, joro@8bytes.org, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Daniel Kurtz <djkurtz@google.com>, yong.wu@mediatek.com, thunder.leizhen@huawei.com, yingjoe.chen@mediatek.com, treding@nvidia.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 7, 2015 at 10:06 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 07/10/15 10:03, Anup Patel wrote:
> [...]
>
>>> +static bool do_iommu_attach(struct device *dev, const struct iommu_ops
>>> *ops,
>>> +                          u64 dma_base, u64 size)
>>> +{
>>> +       struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>>> +
>>> +       /*
>>> +        * Best case: The device is either part of a group which was
>>> +        * already attached to a domain in a previous call, or it's
>>> +        * been put in a default DMA domain by the IOMMU core.
>>> +        */
>>> +       if (!domain) {
>>> +               /*
>>> +                * Urgh. The IOMMU core isn't going to do default domains
>>> +                * for non-PCI devices anyway, until it has some means of
>>> +                * abstracting the entirely implementation-specific
>>> +                * sideband data/SoC topology/unicorn dust that may or
>>> +                * may not differentiate upstream masters.
>>> +                * So until then, HORRIBLE HACKS!
>>> +                */
>>> +               domain = ops->domain_alloc(IOMMU_DOMAIN_DMA);
>>> +               if (!domain)
>>> +                       goto out_no_domain;
>>> +
>>> +               domain->ops = ops;
>>> +               domain->type = IOMMU_DOMAIN_DMA |
>>> __IOMMU_DOMAIN_FAKE_DEFAULT;
>>
>>
>> We require iommu_get_dma_cookie(domain) here. If we dont
>> allocate iommu cookie then iommu_dma_init_domain() will fail.
>
>
> The iova cookie is tightly coupled with the domain, so it really only makes
> sense for the IOMMU driver to deal with it as part of its
> domain_alloc/domain_free callbacks.
>
> Doing that here was one of the nastier 'compatibility' hacks which I've now
> taken out; trying to make things work without modifying existing IOMMU
> drivers was just too impractical. Drivers which want to play are now
> required to support the IOMMU_DOMAIN_DMA type appropriately, but it's still
> only a minimal change, as per the example diff for the ARM SMMU driver below
> (big pile of further patches necessary to make said driver compatible in
> other respects notwithstanding).

Many thanks for the info.

Actually, I was trying your dma-mapping patches with SMMU driver. I have got
SMMU driver somewhat working for IOMMU_DOMAIN_DMA. Your suggestion
will help me restrict my changes to SMMU driver only.

This patchset looks good to me.

Thanks,
Anup
