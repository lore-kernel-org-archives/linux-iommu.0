From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v8 5/7] iommu/arm-smmu-v3: Add support for non-strict mode
Date: Fri, 28 Sep 2018 14:55:32 +0100
Message-ID: <20180928135532.GA1581@brain-police>
References: <cover.1537458163.git.robin.murphy@arm.com>
 <b98f8f695178c9c9ac6e081680090d5ac97e8d7c.1537458163.git.robin.murphy@arm.com>
 <20180928121900.GB1577@brain-police>
 <1d2b57f7-be4e-39c5-4981-7f8e2f601b6a@arm.com>
 <20180928124704.GC1577@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180928124704.GC1577@brain-police>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 28, 2018 at 01:47:04PM +0100, Will Deacon wrote:
> On Fri, Sep 28, 2018 at 01:26:00PM +0100, Robin Murphy wrote:
> > On 28/09/18 13:19, Will Deacon wrote:
> > > On Thu, Sep 20, 2018 at 05:10:25PM +0100, Robin Murphy wrote:
> > > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > > > index f10c852479fc..db402e8b068b 100644
> > > > --- a/drivers/iommu/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm-smmu-v3.c
> > > > @@ -612,6 +612,7 @@ struct arm_smmu_domain {
> > > >   	struct mutex			init_mutex; /* Protects smmu pointer */
> > > >   	struct io_pgtable_ops		*pgtbl_ops;
> > > > +	bool				non_strict;
> > > >   	enum arm_smmu_domain_stage	stage;
> > > >   	union {
> > > > @@ -1407,6 +1408,12 @@ static void arm_smmu_tlb_inv_context(void *cookie)
> > > >   		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> > > >   	}
> > > > +	/*
> > > > +	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
> > > > +	 * PTEs previously cleared by unmaps on the current CPU not yet visible
> > > > +	 * to the SMMU. We are relying on the DSB implicit in queue_inc_prod()
> > > > +	 * to guarantee those are observed before the TLBI. Do be careful, 007.
> > > > +	 */
> > > 
> > > Good, so you can ignore my comment on the previous patch :)
> > 
> > Well, I suppose that comment in io-pgtable *could* have explicitly noted
> > that same-CPU order is dealt with elsewhere - feel free to fix it up if you
> > think it would be a helpful reminder for the future.
> 
> I think I'll move it into the documentation for the new attribute, so that
> any driver authors wanting to enable lazy invalidation know that they need
> to provide this guarantee in their full TLB invalidation callback.

Hmm, so I started doing this but then realised we already required this
behaviour for tlb_add_flush() afaict. That would mean that mainline
currently has a bug for arm-smmu.c, because we use the _relaxed I/O
accessors in there and there's no DSB after clearing the PTE on unmap().

Am I missing something?

Will
