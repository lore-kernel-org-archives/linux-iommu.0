From: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu/amd: Do not flush when device is busy
Date: Mon, 7 May 2018 14:38:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1805071430530.2795@hypnos.tec.linutronix.de>
References: <20180504162233.11283-1-bigeasy@linutronix.de>
	<20180504162233.11283-4-bigeasy@linutronix.de>
	<0e5269ee-093f-9bb2-0a18-ee0e56fcf8f7@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0e5269ee-093f-9bb2-0a18-ee0e56fcf8f7-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 4 May 2018, Gary R Hook wrote:

> On 05/04/2018 11:22 AM, Sebastian Andrzej Siewior wrote:
> > From: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> > 
> > When device is already attached to a domain, there is no need to execute
> > the domain_flush_tlb_pde(). Therefore move the check if the domain is set
> > into attach_device().
> > 
> > Signed-off-by: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> > ---
> >   drivers/iommu/amd_iommu.c | 32 ++++++++++----------------------
> >   1 file changed, 10 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index f66a5d0b7c62..a801678ae1b4 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -1878,8 +1878,11 @@ static void clear_dte_entry(u16 devid)
> >   	amd_iommu_apply_erratum_63(devid);
> >   }
> >   -static void do_attach(struct iommu_dev_data *dev_data,
> > -		      struct protection_domain *domain)
> > +/*
> > + * This function does assigns the device visible for the hardware
> > + */
> 
> <grammar cop>
> 
> The prior version of this comment appears 3 times in the file, and is
> grammatically problematic every time. Can we simplify it to say
> 
>  * This function makes the device visible in the domain
> 
> Or some such? I.e. tidy up the two remaining comments?
> 
> </grammar cop>
> 

Will fix it in a separate patch - but I only found 2 places where the
prior version of this comment appears.

Anna-Maria
