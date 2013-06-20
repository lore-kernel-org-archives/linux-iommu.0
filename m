From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 0/3] How to pass IOMMU map attr via DMA API?
Date: Thu, 20 Jun 2013 11:59:29 +0200
Message-ID: <20130620.125929.2250094502232662356.hdoyu@nvidia.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com><20130620093152.GE2842@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130620093152.GE2842-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote @ Thu, 20 Jun 2013 11:31:52 +0200:

> > Hiroshi Doyu (3):
> >   common: DMA-mapping: add DMA_ATTR_READ_ONLY attribute
> >   ARM: dma-mapping: Pass DMA attrs as IOMMU prot
> >   iommu/tegra: smmu: Support read-only mapping
> 
> These patches don't seem to have made it to the linux-arm-kernel list
> (either in my inbox or the list archive). Could you try and resend them please?

I'm sorry but linux-arm-kernel list someitmes requires me moderators
approval. I don't know why. I'll find a way to work around.

Here are links for the original post:

http://lists.linuxfoundation.org/pipermail/iommu/2013-June/005860.html
http://lists.linuxfoundation.org/pipermail/iommu/2013-June/005861.html
http://lists.linuxfoundation.org/pipermail/iommu/2013-June/005862.html
http://lists.linuxfoundation.org/pipermail/iommu/2013-June/005863.html

> Also: how do they interact with my patch here?:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175124.html

This conversion looks reasonable enough, but some platform may need
more attrs to pass IOMMU like OMAP.

  #define IOMMU_FLAG	(IOVMF_ENDIAN_LITTLE | IOVMF_ELSZ_8)

How can we deal with those cases?
