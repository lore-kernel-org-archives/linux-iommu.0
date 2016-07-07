From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 6/9] iommu/of: Introduce iommu_fwspec
Date: Thu, 7 Jul 2016 17:51:16 +0100
Message-ID: <20160707165116.GA2685@red-moon>
References: <cover.1467123945.git.robin.murphy@arm.com>
	<227abd6fb43e4163d94673066b4b736d7efaa635.1467123945.git.robin.murphy@arm.com>
	<20160701105505.GH12735@arm.com> <57765C5E.8010400@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57765C5E.8010400-5wv7dgnIgG8@public.gmane.org>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 01, 2016 at 01:04:46PM +0100, Robin Murphy wrote:
> On 01/07/16 11:55, Will Deacon wrote:
> > On Tue, Jun 28, 2016 at 04:48:25PM +0100, Robin Murphy wrote:
> >> Introduce a common structure to hold the per-device firmware data that
> >> non-architectural IOMMU drivers generally need to keep track of.
> >> Initially this is DT-specific to complement the existing of_iommu
> >> support code, but will generalise further once other firmware methods
> >> (e.g. ACPI IORT) come along.
> >>
> >> Ultimately the aim is to promote the fwspec to a first-class member of
> >> struct device, and handle the init/free automatically in the firmware
> >> code. That way we can have API calls look for dev->fwspec->iommu_ops
> >> before falling back to dev->bus->iommu_ops, and thus gracefully handle
> >> those troublesome multi-IOMMU systems which we currently cannot. To
> >> start with, though, make use of the existing archdata field and delegate
> >> the init/free to drivers to allow an incremental conversion rather than
> >> the impractical pain of trying to attempt everything in one go.
> >>
> >> Suggested-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> >> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >> ---
> >>
> >> v3: New.
> >>
> >>  drivers/iommu/of_iommu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/of_iommu.h | 18 ++++++++++++++++++
> >>  2 files changed, 65 insertions(+)
> >>
> >> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> >> index 25406a8b9d4e..2b90c1f56ff2 100644
> >> --- a/drivers/iommu/of_iommu.c
> >> +++ b/drivers/iommu/of_iommu.c
> >> @@ -220,3 +220,50 @@ void __init of_iommu_init(void)
> >>  				of_node_full_name(np));
> >>  	}
> >>  }
> >> +
> >> +int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np)
> > 
> > These functions might want an of_* prefix to match the rest of the file,
> > or do you plan to re-use these later for ACPI?
> 
> Indeed, the naming is a deliberate concession to the future - I was
> trying to pre-empt the idea that the interface might be intended to grow
> into separate of_* and iort_* versions. I'm just using raw device_nodes
> for the moment as I don't think we'd reached a consensus on whether
> fwnode_handle or some other abstraction was the appropriate way to go.

Yes, for the time being you could just consider the whole thing
OF specific and in my series providing IORT support I will have to
find a place for this code to live, likely to be a new compilation
unit anyway (which means that the raw device_node will become
fwnode_handle types too in the process).

> >> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> >> index bd02b44902d0..5a4f516cfcfe 100644
> >> --- a/include/linux/of_iommu.h
> >> +++ b/include/linux/of_iommu.h
> >> @@ -15,6 +15,14 @@ extern void of_iommu_init(void);
> >>  extern const struct iommu_ops *of_iommu_configure(struct device *dev,
> >>  					struct device_node *master_np);
> >>  
> >> +struct iommu_fwspec {
> >> +	const struct iommu_ops	*iommu_ops;
> >> +	struct device_node	*iommu_np;
> >> +	void			*iommu_priv;
> >> +	unsigned int		num_ids;
> >> +	u32			ids[];
> >> +};
> >> +
> >>  #else
> >>  
> >>  static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
> >> @@ -31,8 +39,18 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
> >>  	return NULL;
> >>  }
> >>  
> >> +struct iommu_fwspec;
> >> +
> >>  #endif	/* CONFIG_OF_IOMMU */
> >>  
> >> +int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np);
> >> +void iommu_fwspec_free(struct device *dev);
> >> +int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
> >> +static inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
> >> +{
> >> +	return dev->archdata.iommu;
> >> +}
> > 
> > I'm a bit nervous about putting this inline in a header file, since not
> > all architectures unconditionally provide the iommu field in dev_archdata.
> 
> Ah yes, you're right, this shouldn't be defined without OF_IOMMU (or the
> IORT equivalent) anyway. Clearly the premature optimisation demons had
> begun whispering "A measly one-line accessor in a separate compilation
> unit? Won't somebody think of the chil^Wbranch predictors!?"

Well, moving this inline to of_iommu.c (as per v4) improves things a
bit, but it looks a bit incosistent to me anyway given that we would
*assume* archdata.iommu exists if CONFIG_OF_IOMMU, which should be
true (is it on eg powerpc ?) but it is still an assumption AFAIK.

An option could be to add the generic iommu_fwspec API but for
the time being decoupling it from struct device and leaving it
to IOMMU drivers to decide where the iommu_fwspec structure pointer
should be stored (ie on ARM systems dev->archdata.iommu).

Understood, you want to keep struct device part of the API so
that, when the iommu_fwspec will be integrated into struct device
we won't have to change the iommu_fwspec API, still, it does not
look right.

Other option would be adding this code to a separate compilation
unit that is compiled only on (ARM || ARM64), not sure what's the
most reasonable option here.

Lorenzo
