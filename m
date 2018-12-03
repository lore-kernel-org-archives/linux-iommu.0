From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v5 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Date: Mon, 3 Dec 2018 17:23:40 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D838B9@SHSMSX104.ccr.corp.intel.com>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
	<20181128035449.10226-3-baolu.lu@linux.intel.com>
	<20181203134411.lejlkbnagxml54ro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181203134411.lejlkbnagxml54ro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Monday, December 3, 2018 5:44 AM
> To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Subject: Re: [PATCH v5 02/12] iommu/vt-d: Manage scalalble mode PASID tables
> 
> Hi Baolu,
> 
> On Wed, Nov 28, 2018 at 11:54:39AM +0800, Lu Baolu wrote:
> > @@ -2482,12 +2482,13 @@ static struct dmar_domain
> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
> >  	if (dev)
> >  		dev->archdata.iommu = info;
> >
> > -	if (dev && dev_is_pci(dev) && info->pasid_supported) {
> > +	/* PASID table is mandatory for a PCI device in scalable mode. */
> > +	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
> 
> This will also allocate a PASID table if the device does not support
> PASIDs, right? Will the table not be used in that case or will the
> device just use the fallback PASID? Isn't it better in that case to have
> no PASID table?

We need to allocate the PASID table in scalable mode, the reason is as below:
In VT-d scalable mode, all address translation is done in PASID-granularity.
For requests-with-PASID, the address translation would be subjected to the
PASID entry specified by the PASID value in the DMA request. However, for
requests-without-PASID, there is no PASID in the DMA request. To fulfil
the translation logic, we've introduced RID2PASID field in sm-context-entry
in VT-d 3.o spec. So that such DMA requests would be subjected to the pasid
entry specified by the PASID value in the RID2PASID field of sm-context-entry.

So for a device without PASID support, we need to at least to have a PASID
entry so that its DMA request (without pasid) can be translated. Thus a PASID
table is needed for such devices.

> 
> > @@ -143,18 +143,20 @@ int intel_pasid_alloc_table(struct device *dev)
> >  		return -ENOMEM;
> >  	INIT_LIST_HEAD(&pasid_table->dev);
> >
> > -	size = sizeof(struct pasid_entry);
> > -	count = min_t(int, pci_max_pasids(to_pci_dev(dev)), intel_pasid_max_id);
> > -	order = get_order(size * count);
> > +	if (info->pasid_supported)
> > +		max_pasid = min_t(int, pci_max_pasids(to_pci_dev(dev)),
> > +				  intel_pasid_max_id);
> > +
> > +	size = max_pasid >> (PASID_PDE_SHIFT - 3);
> > +	order = size ? get_order(size) : 0;
> >  	pages = alloc_pages_node(info->iommu->node,
> > -				 GFP_ATOMIC | __GFP_ZERO,
> > -				 order);
> > +				 GFP_ATOMIC | __GFP_ZERO, order);
> 
> This is a simple data structure allocation path, does it need
> GFP_ATOMIC?

will leave it to Baolu.

> 
> 	Joerg

Thanks,
Yi Liu
