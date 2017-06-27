From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 5/8] iommu/io-pgtable-arm: Support lockless operation
Date: Tue, 27 Jun 2017 09:39:13 +0100
Message-ID: <20170627083912.GA5759@arm.com>
References: <cover.1498145008.git.robin.murphy@arm.com>
	<af61929e3984a31588cab08ed84a237602b5263e.1498145008.git.robin.murphy@arm.com>
	<20170623055326.GA2949@virtx40> <20170623085607.GC3718@virtx40>
	<7a8da378-19e2-2f35-877a-cc6ce389301a@arm.com>
	<20170623113405.GA5221@virtx40> <20170627051155.GA9525@virtx40>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170627051155.GA9525@virtx40>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 27, 2017 at 10:41:55AM +0530, Linu Cherian wrote:
> On Fri Jun 23, 2017 at 05:04:05PM +0530, Linu Cherian wrote:
> > On Fri Jun 23, 2017 at 11:35:25AM +0100, Robin Murphy wrote:
> > > Note that on a coherent platform like ThunderX that's as good as just
> > > deleting it, because you'll never execute the case below. However, on
> > > reflection I think it can at least safely be downgraded to dma_wmb()
> > > (i.e. DMB) rather than a full DSB - would you be able to test what
> > > difference that makes?
> > 
> > The testing was done on Thunderx 1, which has a non coherent page table walk.
> > Yes, downgrading to dma_wmb() helps. With this change, performance is back to v1.
> > 
> 
> Should i send a patch for this ?

I already did it:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=for-joerg/arm-smmu/updates&id=77f3445866c39d8866b31d8d9fa47c7c20938e05

Will
