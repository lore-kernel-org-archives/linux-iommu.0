From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Set GBPA to abort all transactions
Date: Thu, 12 Apr 2018 11:55:30 +0100
Message-ID: <20180412105530.GC20539@arm.com>
References: <1522247980-31892-1-git-send-email-timur@codeaurora.org>
	<3350f0eb84c8c621cf43aa06ed117cfb@www.loen.fr>
	<3772fb2d-01b7-4820-6d13-a0263654dabc@codeaurora.org>
	<438a6180-fca8-d3a1-985f-e595529911f3@arm.com>
	<7756f245-6c63-92d4-d101-4040a45b660b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7756f245-6c63-92d4-d101-4040a45b660b-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Goel, Sameer" <sgoel-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 12, 2018 at 11:17:24AM +0100, Robin Murphy wrote:
> On 11/04/18 17:54, Marc Zyngier wrote:
> >On 11/04/18 16:58, Goel, Sameer wrote:
> >>On 3/28/2018 9:00 AM, Marc Zyngier wrote:
> >>>A tangential question: can we reliably detect that the SMMU already
> >>>has valid mappings, which would indicate that we're in a pretty bad
> >>>shape already by the time we set that bit? For all we know, memory
> >>>could have been corrupted long before we hit this point, and this
> >>>patch barely narrows the window of opportunity.
> >>
> >>:) Yes that is correct. This only covers the kdump scenario. Trying
> >>to get some reliability when booting up the crash kernel. The system
> >>is already in a bad state. I don't think that this will happen in a
> >>normal scenario. But please point me to the GICv3 change and I'll
> >>have a look.
> >
> >See this:
> >https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/tree/drivers/irqchip/irq-gic-v3-its.c?h=irq/irqchip-4.17&id=6eb486b66a3094cdcd68dc39c9df3a29d6a51dd5#n3407
> 
> The nearest equivalent to that is probably the top-level SMMUEN check that
> we already have (see the diff context above). To go beyond that you'd have
> to chase the old stream table pointer and scan the whole thing looking for
> valid contexts, then potentially walk page tables within those contexts to
> check for live translations if you really wanted to be sure. That would be a
> hell of a lot of work to do in the boot path.

Yeah, please don't waste time writing a patch to do that! ;)

Will
