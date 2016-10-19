From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v5 05/07] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
Date: Thu, 20 Oct 2016 08:45:18 +0900
Message-ID: <CANqRtoTcqF=vq6iGkpdF3DA++auOND0JFNOk6SctC077=mRA7A@mail.gmail.com>
References: <20160920134355.25470.93701.sendpatchset@little-apple>
 <20160920134446.25470.22322.sendpatchset@little-apple> <20160922144506.GK3541@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160922144506.GK3541@8bytes.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Thu, Sep 22, 2016 at 11:45 PM, Joerg Roedel <joro@8bytes.org> wrote:
> On Tue, Sep 20, 2016 at 10:44:46PM +0900, Magnus Damm wrote:
>> +#ifdef CONFIG_IOMMU_DMA
>> +
>> +static struct iommu_domain *ipmmu_domain_alloc_dma(unsigned type)
>> +{
>> +     struct iommu_domain *io_domain;
>> +
>> +     if (type != IOMMU_DOMAIN_DMA)
>> +             return NULL;
>> +
>> +     io_domain = __ipmmu_domain_alloc(type);
>> +     if (io_domain)
>> +             iommu_get_dma_cookie(io_domain);
>> +
>> +     return io_domain;
>> +}
>> +
>> +static void ipmmu_domain_free_dma(struct iommu_domain *io_domain)
>> +{
>> +     iommu_put_dma_cookie(io_domain);
>> +     ipmmu_domain_free(io_domain);
>> +}
>
>> [...]
>
>> +static const struct iommu_ops ipmmu_ops = {
>> +     .domain_alloc = ipmmu_domain_alloc_dma,
>> +     .domain_free = ipmmu_domain_free_dma,
>
> Okay, so when CONFIG_IOMMU_DMA is enabled, you only support allocation
> of DMA domains, not UNMANAGED domains anymore. Is there a reason for
> that?

Just historical reason migrating from UNMANAGED only to DMA only.

> You can reduce the #ifdef'ed coded by supporting both types of domains
> and call into allocation-subfunctions for DMA and UNMANAGED domains. The
> #ifdef could then only let the dma-allocation function return NULL.
>
> This would be much more compatible to what other IOMMU drivers do and
> will allow VFIO usage in the future.

Thanks for your suggestion. I've now updated the code in V6, hopefully
it would match your expectation better.

Cheers,

/ magnus
