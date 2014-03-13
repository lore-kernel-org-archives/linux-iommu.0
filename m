From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC][PATCH] iommu/arm: Add hotplugged devices support for
	arm-smmu.
Date: Thu, 13 Mar 2014 09:16:31 +0000
Message-ID: <1e8588637f314eb191d3fb72a2413598@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1394305540-16352-1-git-send-email-Varun.Sethi@freescale.com>
	<20140312162323.GH9691@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140312162323.GH9691-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Will Deacon
> Sent: Wednesday, March 12, 2014 9:53 PM
> To: Sethi Varun-B16395
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Subject: Re: [RFC][PATCH] iommu/arm: Add hotplugged devices support for
> arm-smmu.
> 
> Hi Varun,
> 
> On Sat, Mar 08, 2014 at 07:05:40PM +0000, Varun Sethi wrote:
> > Currently the ARM SMMU driver only considers the bus master devices in
> > the device tree. The master device and stream ID information is
> > maintained per SMMU. Currently there is no mechanism for representing
> > this information in case of PCI or hot plugged devices.
> >
> > This RFC patch proposes a mechanism for representing this information
> > for hot plugged/PCI devices.
> >
> > Patch doesn't contain the add_device callback modification for hot plug
> devices.
> > This would be bus specific and would be responsible for populating the
> > hot plug devices masters list for the SMMU.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c |   93
> ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 90 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
> > 1d9ab39..6c10df4 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -327,6 +327,9 @@ struct arm_smmu_master {
> >  	 * SMMU chain.
> >  	 */
> >  	struct rb_node			node;
> > +	/* Following fields correspond to the hot plug masters */
> > +	struct list_head			hotplug_masters_node;
> > +	struct device			*dev;
> 
> I'd much rather have one list for all masters. Distinguishing between
> masters and `hotplug masters' is unnecessary.
> 
> > +static int is_device_hotplug(struct device *dev) {
> > +	return (dev->bus != &platform_bus_type) &&
> > +		 (dev->bus != &amba_bustype);
> > +}
> 
> I'm not fond of this. Why not rework what we currently have so that it
> can work for other (hotpluggable) buses?
> 
Ok, I will modify the code to use a list of masters per smmu.

-Varun
