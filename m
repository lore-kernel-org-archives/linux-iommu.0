From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 16/37] iommu: Add generic PASID table library
Date: Wed, 28 Feb 2018 16:22:13 +0000
Message-ID: <0779f165-d750-f375-41cb-90663ead9300@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-17-jean-philippe.brucker@arm.com>
	<20180227105121.7c6e1110@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180227105121.7c6e1110@jacob-builder>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, rjw@rjwyso
List-Id: iommu@lists.linux-foundation.org

On 27/02/18 18:51, Jacob Pan wrote:
[...]
>> +struct iommu_pasid_table_ops *
>> +iommu_alloc_pasid_ops(enum iommu_pasid_table_fmt fmt,
>> +		      struct iommu_pasid_table_cfg *cfg, void
>> *cookie) +{
> I guess you don't need to pass in cookie here.

The cookie is stored in the table driver and passed back to the IOMMU
driver when invalidating a PASID table entry

>> +	struct iommu_pasid_table *table;
>> +	const struct iommu_pasid_init_fns *fns;
>> +
>> +	if (fmt >= PASID_TABLE_NUM_FMTS)
>> +		return NULL;
>> +
>> +	fns = pasid_table_init_fns[fmt];
>> +	if (!fns)
>> +		return NULL;
>> +
>> +	table = fns->alloc(cfg, cookie);
>> +	if (!table)
>> +		return NULL;
>> +
>> +	table->fmt = fmt;
>> +	table->cookie = cookie;
>> +	table->cfg = *cfg;
>> +
> the ops is already IOMMU model specific, why do you need to pass cfg
> back?

The table driver needs some config information at runtime. Callbacks such
as iommu_pasid_table_ops::alloc_shared_entry() receive the
iommu_pasid_table_ops instance as argument. They can then get the
iommu_pasid_table structure with container_of() and retrieve the config
stored in table->cfg.

>> +	return &table->ops;
> If there is no common code that uses these ops, I don't see the benefit
> of having these APIs. Or the plan is to consolidate even further such
> that referene to pasid table can be attached at per iommu_domain etc,
> but that would be model specific choice.

I don't plan to consolidate further. This API is for multiple IOMMU
drivers with different transports implementing the same PASID table
formats. For example my vSVA implementation uses this API in virtio-iommu
for assigning PASID tables to the guest (All fairly experimental at this
point. I initially intended to assign just the page directories, but
passing the whole PASID table seemed more popular.)

In the future there might be other vendor IOMMUs implementing the same
PASID table formats, just like there are currently 6 IOMMU drivers using
the page-table code implemented by the io-pgtable.c lib (which I copied in
this patch).

Thanks,
Jean
