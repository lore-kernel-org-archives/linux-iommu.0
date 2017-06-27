From: Linu Cherian <linuc.decode@gmail.com>
Subject: Re: [PATCH v2 5/8] iommu/io-pgtable-arm: Support lockless operation
Date: Tue, 27 Jun 2017 14:38:24 +0530
Message-ID: <20170627090824.GA2758@virtx40>
References: <cover.1498145008.git.robin.murphy@arm.com>
 <af61929e3984a31588cab08ed84a237602b5263e.1498145008.git.robin.murphy@arm.com>
 <20170623055326.GA2949@virtx40> <20170623085607.GC3718@virtx40>
 <7a8da378-19e2-2f35-877a-cc6ce389301a@arm.com>
 <20170623113405.GA5221@virtx40> <20170627051155.GA9525@virtx40>
 <20170627083912.GA5759@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170627083912.GA5759@arm.com>
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
Cc: salil.mehta@huawei.com, sunil.goutham@cavium.com, thunder.leizhen@huawei.com, joro@8bytes.org, john.garry@huawei.com, iommu@lists.linux-foundation.org, wangzhou1@hisilicon.com, ray.jui@broadcom.com, nwatters@codeaurora.org, Linu Cherian <linu.cherian@cavium.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Tue Jun 27, 2017 at 09:39:13AM +0100, Will Deacon wrote:
> On Tue, Jun 27, 2017 at 10:41:55AM +0530, Linu Cherian wrote:
> > On Fri Jun 23, 2017 at 05:04:05PM +0530, Linu Cherian wrote:
> > > On Fri Jun 23, 2017 at 11:35:25AM +0100, Robin Murphy wrote:
> > > > Note that on a coherent platform like ThunderX that's as good as just
> > > > deleting it, because you'll never execute the case below. However, on
> > > > reflection I think it can at least safely be downgraded to dma_wmb()
> > > > (i.e. DMB) rather than a full DSB - would you be able to test what
> > > > difference that makes?
> > > 
> > > The testing was done on Thunderx 1, which has a non coherent page table walk.
> > > Yes, downgrading to dma_wmb() helps. With this change, performance is back to v1.
> > > 
> > 
> > Should i send a patch for this ?
> 
> I already did it:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=for-joerg/arm-smmu/updates&id=77f3445866c39d8866b31d8d9fa47c7c20938e05
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Thanks Will.

-- 
Linu cherian
