From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3] arm64: SMMU-v2: Workaround for Cavium ThunderX
	erratum 28168
Date: Tue, 20 Dec 2016 11:56:31 +0000
Message-ID: <20161220115630.GD10132@arm.com>
References: <1482231993-27571-1-git-send-email-gakula@caviumnetworks.com>
	<bd950765-8c1f-14d5-2be8-efa76f2d6b6b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <bd950765-8c1f-14d5-2be8-efa76f2d6b6b-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, Sunil.Goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, suzuki.poulose-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, james.morse-5wv7dgnIgG8@public.gmane.org, Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 20, 2016 at 11:52:58AM +0000, Marc Zyngier wrote:
> On 20/12/16 11:06, Geetha sowjanya wrote:
> > From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> > +#ifdef CONFIG_CAVIUM_ERRATUM_28168
> > +/*
> > + * Cavium ThunderX erratum 28168
> > + *
> > + * Due to erratum #28168 PCI-inbound MSI-X store to the interrupt
> > + * controller are delivered to the interrupt controller before older
> > + * PCI-inbound memory stores are committed. Doing a sync on SMMU
> > + * will make sure all prior data transfers are completed before
> > + * invoking ISR.
> > + *
> > + */
> > +void dev_smmu_tlb_sync(struct device *dev)
> > +{
> > +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> > +	struct arm_smmu_device *smmu = fwspec_smmu(fwspec);
> > +
> > +	if (smmu)
> > +		__arm_smmu_tlb_sync(smmu);
> > +}
> > +#endif
> 
> I'll let Robin and Will comment on this, but it strikes be as rather odd
> that nothing will happen if the SMMU is in bypass or simply compiled
> out. So this workaround is at best incomplete.

Agreed. Unless the SMMU is the cause of the issue, relying on it to
implement the workaround is fragile and unnecessarily introduces a linkage
between SMMU driver internals and the interrupt handling code.

Not a fan.

Will
