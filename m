From: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH 0/3] Add support for privileged mappings
Date: Thu, 7 Jul 2016 14:58:21 -0600
Message-ID: <20160707205820.GA752@jcrouse-lnx.qualcomm.com>
References: <20160706235136.27854-1-mitchelh@codeaurora.org>
 <20160707170026.GG20682@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160707170026.GG20682@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Patrick Daly <pdaly@codeaurora.org>, Mitchel Humpherys <mitchelh@codeaurora.org>, Jeremy Gebben <jgebben@codeaurora.org>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, Pratik Patel <pratikp@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 07, 2016 at 06:00:26PM +0100, Will Deacon wrote:
> On Wed, Jul 06, 2016 at 04:51:33PM -0700, Mitchel Humpherys wrote:
> > The following patch to the ARM SMMU driver:
> > 
> >     commit d346180e70b91b3d5a1ae7e5603e65593d4622bc
> >     Author: Robin Murphy <robin.murphy@arm.com>
> >     Date:   Tue Jan 26 18:06:34 2016 +0000
> >     
> >         iommu/arm-smmu: Treat all device transactions as unprivileged
> > 
> > started forcing all SMMU transactions to come through as "unprivileged".
> > The rationale given was that:
> > 
> >   (1) There is no way in the IOMMU API to even request privileged mappings.
> > 
> >   (2) It's difficult to implement a DMA mapper that correctly models the
> >       ARM VMSAv8 behavior of unprivileged-writeable =>
> >       privileged-execute-never.
> > 
> > This series attempts to rectify (1) by introducing an IOMMU API for
> > privileged mappings (and implementing it in io-pgtable-arm).  It seems like
> > (2) can be safely ignored for now under the assumption that any users of
> > the IOMMU_PRIV flag will be using the low-level IOMMU APIs directly, rather
> > than going through the DMA APIs.
> > 
> > Robin, Will, what do you think?  Jordan and Jeremy can provide more info on
> > the use case if needed, but the high level is that it's a security feature
> > to prevent attacks such as [1].
> 
> So I think the problem that the offending patch tried to fix is that
> the PL330 DMA controller (drivers/dma/pl330.c) uses dma_alloc_coherent
> to allocate its microcode buffer, but the so-called "manager" thread
> that fetches the microcode does so with privileged accesses and
> consequently fails.
 
Not surprisingly the GPU works almost exactly the same way. The microcode does a
privileged access of certain buffers. The difference is that we use the IOMMU
API directly instead of going through the DMA api. Obviously the GPU can work
as is with the unprivileged transaction patch but it does leave largish
blocks of memory open to possible attacks as Mitch pointed out.

> Whilst this series is a step in the right direction for fixing that, I
> don't think you can claim that only low-level users need this, given that
> we have in-tree code which would break without it. Perhaps you just need
> to extend things slightly more to expose this to the DMA API as well (or,
> alternatively, hack the PL330 driver some how).

I agree that hacking the DMA api would be the best long term solution but there
be dragons there. Perhaps a workable compromise might be to white-list
privileged aware devices via the device tree.

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
