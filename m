From: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/2] iommu/s390: Fix iommu-groups and add sysfs support
Date: Fri, 28 Apr 2017 14:46:34 +0200
Message-ID: <20170428144634.7950c8cf@thinkpad>
References: <1493306905-32334-1-git-send-email-joro@8bytes.org>
	<20170427201018.70c8be5a@thinkpad>
	<20170427210325.GE1332@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170427210325.GE1332-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

I guess we are a bit special on s390 (again), see below. Sebastian is more
familiar with the base s390 PCI code, he may correct me if I'm wrong.

On Thu, 27 Apr 2017 23:03:25 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> > Well, there is a separate zpci_dev for each pci_dev on s390,
> > and each of those has its own separate dma-table (thus not shared).  
> 
> Is that true for all functions of a PCIe card, so does every function of
> a device has its own zpci_dev structure and thus its own DMA-table?

Yes, clp_add_pci_device() is called for every function, which in turn calls
zpci_create_device() with a freshly allocated zdev. zpci_enable_device()
then sets up a new DMA address space for each function.

> My assumption came from the fact that the zpci_dev is read from
> pci_dev->sysdata, which is propagated there from the pci_bridge
> through the pci_root_bus structures.

The zdev gets there via zpci_create_device() -> zpci_scan_bus() ->
pci_scan_root_bus(), which is done for every single function.

Not sure if I understand this right, but it looks like we set up a new PCI
bus for each function.

> > Given this "separate zpci_dev for each pci_dev" situation, I don't
> > see what this update actually changes, compared to the previous code,
> > see also my comments to that patch.  
> 
> The add_device call-back is invoked for every function of a pci-device,
> because each function gets its own pci_dev structure. Also we usually
> group all functions of a PCI-device together into one iommu-group,
> because we don't trust that the device isolates its functions from each
> other.

OK, but similar to the add_device callback, zpci_create_device() is
also invoked for every function. So, allocating a new iommu-group in
zpci_create_device() will never lead to any group sharing.

I am however a bit confused now, about how we would have allowed group
sharing with the current s390 IOMMU code, or IOW in which scenario would
iommu_group_get() in the add_device callback find a shareable iommu-group?

In the attach_dev callback, we provide the option to "force" multiple
functions using the same iommu-domain / DMA address space, by de-registering
the per-function DMA address space and registering a common space. But
such functions would only be in the same iommu "domain" and not "group",
if I get this right.

So, I guess we may have an issue with not sharing iommu-groups when
it could make sense to do so. But your patch would not fix this, as
we still would allocate separate iommu-groups for all functions.

Regards,
Gerald
