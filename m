From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] iommu/amd: fix sg->dma_address for sg->offset bigger
 than PAGE_SIZE
Date: Mon, 18 Mar 2019 11:17:03 +0100
Message-ID: <20190318101703.GA6100@8bytes.org>
References: <20190228121948.GD6072@redhat.com>
 <20190228134029.GC1594@8bytes.org>
 <20190304071037.GA2787@redhat.com>
 <CAKxU2N-k-9DCYBv6W3CohL963dr3AeY3VHyt8FrUuo=BfacDsw@mail.gmail.com>
 <20190311084319.GA3310@redhat.com>
 <20190311090314.GB3310@redhat.com>
 <e0630ae9d9bee73d8a1ce3499ea9f77900e9cdfa.camel@linux.intel.com>
 <20190312070832.GA2483@redhat.com>
 <67c062b183fbd5651a9aa990e677d31673ff7580.camel@linux.intel.com>
 <20190313090316.GA2663@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190313090316.GA2663@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>, Rosen Penev <rosenp@gmail.com>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, linux-wireless <linux-wireless@vger.kernel.org>, Samuel Sieb <samuel@sieb.net>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, jan.viktorin@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Stanislaw,

thanks a lot for looking into this and tracking it down!

On Wed, Mar 13, 2019 at 10:03:17AM +0100, Stanislaw Gruszka wrote:
> -		s->dma_address += address + s->offset;
> +		/* Add in the remaining piece of the scatter-gather offset that
> +		 * was masked out when we were determining the physical address
> +		 * via (sg_phys(s) & PAGE_MASK) earlier.
> +		 */
> +		s->dma_address += address + (s->offset & ~PAGE_MASK);
>  		s->dma_length   = s->length;

Applied the patch for v5.1 (with an added Fixes-tag and a minor coding
style change) and will send it upstream soon.

Thanks again,

       Joerg
