From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/9] iommu/arm-smmu: Check for num_context_irqs > 0 to
	avoid divide by zero exception
Date: Fri, 27 Sep 2013 11:48:02 +0100
Message-ID: <20130927104802.GF9057@mudshark.cambridge.arm.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
	<1380234982-1677-5-git-send-email-andreas.herrmann@calxeda.com>
	<20130927084154.GB8319@mudshark.cambridge.arm.com>
	<20130927090348.GF3315@alberich>
	<20130927102307.GE9057@mudshark.cambridge.arm.com>
	<20130927103949.GM3315@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130927103949.GM3315@alberich>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 27, 2013 at 11:39:49AM +0100, Andreas Herrmann wrote:
> On Fri, Sep 27, 2013 at 06:23:07AM -0400, Will Deacon wrote:
> > What do you think?
> 
> Yes, that should suffice.
> 
> I know it's clear for us but what about a short comment to emphasize
> that we expect to find at least one context irq?
> 
> -       if (num_irqs < smmu->num_global_irqs) {
> +       /* expect num_global_irqs plus at least one context irq */
> +       if (num_irqs <= smmu->num_global_irqs) {
> 
> which can be translated to
> 
> -       if (num_irqs < smmu->num_global_irqs) {
> +       if (!smmu->num_context_irqs) {

Even better! Do you want to send a patch, or shall I just create one myself?

Will
