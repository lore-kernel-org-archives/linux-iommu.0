From: Will Deacon <will.deacon@arm.com>
Subject: Re: IOMMU DMA-mapping API for arm64 ?
Date: Thu, 6 Feb 2014 10:07:34 +0000
Message-ID: <20140206100734.GB26035@mudshark.cambridge.arm.com>
References: <CAD15agaA9c1+0svk_d97ZEcaOg6x_PGcbKVHM9dWAZ_t1T8FXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAD15agaA9c1+0svk_d97ZEcaOg6x_PGcbKVHM9dWAZ_t1T8FXw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ritesh Harjani <ritesh.harjani@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <Catalin.Marinas@arm.com>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "hdoyu@nvidia.com" <hdoyu@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 06, 2014 at 05:05:45AM +0000, Ritesh Harjani wrote:
> Hi everyone,
> 
> I tried looking for IOMMU support in ARM64 but what I was able to see is
> only swiotlb is currently supported.
> 
> Based on my understanding for IOMMU support, we need DMA-MAPPING API to
> have IOMMU ops field, similar to what is present in arm32.  I could see
> the iommu field added in dev_archdata in below mentioned patch
> (arch/arm64/include/asm/device.h), but there is no ops field in
> arch/arm64/mm/dma-mapping.c ?

Correct, there needs to be a way to plumb dma-mapping into the IOMMU layer.

> I also saw one mail discussion between you guys on what is the best place
> for adding iommu support in ARM64, but couldn't see any followed up
> patches for the same.
> 
> Please tell us the current status/updates on the same. Your feedback will
> be greatly appreciated.

There are a few related topics here:

  (1) Moving a bunch of the boilerplate IOMMU code into a common place
      (iommu-helper.c or similar). This is because we don't want to blindly
      duplicate common code across architectures.

  (2) Standardising at least part of a system topology description in
      device-tree, so that we can deal with different combinations of
      {coherent,nocoherent} device {with,without} a series of IOMMUs.

Once both of those are sorted, the actual plumbing should be fairly
straightforward.

Will
