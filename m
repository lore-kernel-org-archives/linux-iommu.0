From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Subject: Re: [PATCH 0/3] IOVA allocation improvements for iommu-dma
Date: Thu, 16 Mar 2017 18:48:57 +0530
Message-ID: <CA+sq2CfGgYXVEfckC=4VoFaQOuEhn4_vdfH0ZmUjpV_jyCkEHw@mail.gmail.com>
References: <cover.1489581865.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1489581865.git.robin.murphy@arm.com>
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
Cc: Will Deacon <will.deacon@arm.com>, joro@8bytes.org, damm+renesas@opensource.se, iommu@lists.linux-foundation.org, nwatters@codeaurora.org, sgoutham@caviumnetworks.com, yoshihiro.shimoda.uh@renesas.com, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 15, 2017 at 7:03 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi all,
>
> Here's the first bit of lock contention removal to chew on - feedback
> welcome! Note that for the current users of the io-pgtable framework,
> this is most likely to simply push more contention onto the io-pgtable
> lock, so may not show a great improvement alone. Will and I both have
> rough proof-of-concept implementations of lock-free io-pgtable code
> which we need to sit down and agree on at some point, hopefullt fairly
> soon.

Thanks for working on this.
As you said, it's indeed pushing lock contention down to pgtable lock from
iova rbtree lock but now morethan lock I see issue is with yielding CPU while
waiting for tlb_sync. Below are some numbers.

I have tweaked '__arm_smmu_tlb_sync' in SMMUv2 driver i.e basically removed
cpu_relax() and udelay() to make it a busy loop.

Before: 1.1 Gbps
With your patches: 1.45Gbps
With your patches + busy loop in tlb_sync: 7Gbps

If we reduce pgtable contention a bit
With your patches + busy loop in tlb_sync + Iperf threads reduced to 8
from 16: ~9Gbps

So looks like along with pgtable lock, some optimization can be done
to tlb_sync code as well.

Thanks,
Sunil.
