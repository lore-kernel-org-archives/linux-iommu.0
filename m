From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-direct: Fix return value of dma_direct_supported
Date: Thu, 13 Dec 2018 20:58:31 +0100
Message-ID: <20181213195831.GA15478@lst.de>
References: <20181003234746.3586.42014.stgit@localhost.localdomain> <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com> <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com> <ebe0d4aa-5f37-cc40-4a80-cfe499d5b8e4@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ebe0d4aa-5f37-cc40-4a80-cfe499d5b8e4@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, "alexander.h.duyck@linux.intel.com" <alexander.h.duyck@linux.intel.com>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Greg KH <gregkh@linuxfoundation.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 13, 2018 at 07:45:57PM +0000, Lendacky, Thomas wrote:
> So I think this needs to be __phys_to_dma() here. I only recently got a
> system that had a device where the driver only supported 32-bit DMA and
> found that when SME is active this returns 0 and causes the driver to fail
> to initialize. This is because the SME encryption bit (bit 47) is part of
> the check when using phys_to_dma(). During actual DMA when SME is active,
> bounce buffers will be used for anything that can't meet the 48-bit
> requirement. But for this test, using __phys_to_dma() should give the
> desired results, right?
> 
> If you agree with this, I'll submit a patch to make the change. I missed
> this in 4.19, so I'll need to submit something to stable, too. The only
> issue there is the 4.20 fix won't apply cleanly to 4.19.

Yes, please send a patch.  Please make sure it includes a code comment
that explains why the __-prefixed version is used.
