From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] MIPS: Fix `dma_alloc_coherent' returning a non-coherent
 allocation
Date: Mon, 5 Nov 2018 18:10:38 +0000
Message-ID: <20181105181037.m2hxoosf7z2bz7lu@pburton-laptop>
References: <20180914095808.22202-1-hch@lst.de>
 <20180914095808.22202-5-hch@lst.de>
 <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org>
 <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org>
 <20181031203206.GA28337@lst.de>
 <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org>
 <20181101051359.GA4164@lst.de>
 <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org>
Content-Language: en-US
Content-ID: <A5FB772CC972D748A869B1B81057D179@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Christoph Hellwig <hch@lst.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Maciej,

On Thu, Nov 01, 2018 at 07:54:24AM +0000, Maciej W. Rozycki wrote:
> Fix a MIPS `dma_alloc_coherent' regression from commit bc3ec75de545=20
> ("dma-mapping: merge direct and noncoherent ops") that causes a cached=20
> allocation to be returned on noncoherent cache systems.
>=20
> This is due to an inverted check now used in the MIPS implementation of=20
> `arch_dma_alloc' on the result from `dma_direct_alloc_pages' before=20
> doing the cached-to-uncached mapping of the allocation address obtained. =
=20
> The mapping has to be done for a non-NULL rather than NULL result,=20
> because a NULL result means the allocation has failed.
>=20
> Invert the check for correct operation then.
>=20
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> Fixes: bc3ec75de545 ("dma-mapping: merge direct and noncoherent ops")
> Cc: stable@vger.kernel.org # 4.19+
> ---
>  arch/mips/mm/dma-noncoherent.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, nice catch! Applied to mips-fixes.

Paul
