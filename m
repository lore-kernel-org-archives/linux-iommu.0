From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
Date: Wed, 26 Sep 2018 14:50:15 +0100
Message-ID: <1f53c6f1-4e7a-1451-1abc-a7bca4a2359d@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
	<20180920170046.20154-4-jean-philippe.brucker@arm.com>
	<09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
	<20180925132627.vbdotr23o7lqrmnd@8bytes.org>
	<b33a1911-e100-586b-b8df-eb04312ecffd@linux.intel.com>
	<754d495d-d016-f42f-5682-ba4a75a618e0@arm.com>
	<20180926124527.GD18287@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180926124527.GD18287-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 26/09/2018 13:45, Joerg Roedel wrote:
> On Wed, Sep 26, 2018 at 11:20:34AM +0100, Jean-Philippe Brucker wrote:
>> Yes, at the moment it's difficult to guess what device drivers will
>> want, but I can imagine some driver offering SVA to userspace, while
>> keeping a few PASIDs for themselves to map kernel memory. Or create mdev
>> devices for virtualization while also allowing bare-metal SVA. So I
>> think we should aim at enabling these use-cases in parallel, even if it
>> doesn't necessarily need to be possible right now.
> 
> Yeah okay, but allowing these use-cases in parallel basically disallows
> giving any guest control over a device's pasid-table, no?
All of these use-cases require the host to manage the PASID tables, so
while any one of them is enabled, we can't give a guest control over the
PASID tables. But allowing these use-cases in parallel doesn't change that.

There is an ambiguity: I understand "(3) SVA in VM guest" as SVA for a
device-assignable interface assigned to a guest, using vfio-mdev and the
new Intel vt-d architecture (right?). That case does require the host to
allocate and manage PASIDs (because the PCI device is shared between
multiple VMs).

For the "classic" vfio-pci case, "SVA in guest" still means giving the
guest control over the whole PASID table.

Thanks,
Jean
