From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 6/9] iommu/arm-smmu: to support probe deferral
Date: Thu, 9 Jul 2015 12:27:20 +0100
Message-ID: <20150709112243.GA20778@arm.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
	<1436239822-14132-7-git-send-email-thunder.leizhen@huawei.com>
	<559D21F0.3080202@arm.com> <559E5693.9060709@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <559E5693.9060709-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: leizhen <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 09, 2015 at 12:10:11PM +0100, leizhen wrote:
> On 2015/7/8 21:13, Robin Murphy wrote:
> > On 07/07/15 04:30, Zhen Lei wrote:
> >> For pci devices, only the root nodes have "iommus" property. So we
> >> should traverse all of its sub nodes in of_xlate.
> > 
> > I don't really follow this description; only the host controller is
> > described in DT - the devices behind it are probed dynamically and don't
> > have nodes to traverse.
> 
> The devices behind host controller may have nodes, but have no "iommus" property.

No, the PCI masters won't have nodes in the DT on arm/arm64 systems (it
makes hotplug difficult).

> I got this conclusion base on the original code as below:
> 
> 	struct pci_bus *bus = pdev->bus;
> 
> 	/* Walk up to the root bus */
> 	while (!pci_is_root_bus(bus))
> 		bus = bus->parent;

So this walks up the PCI topology, created by probing the bus, until we
get to the top-level bus...

> 	/* Follow the "iommus" phandle from the host controller */
> 	of_node = of_parse_phandle(bus->bridge->parent->of_node, "iommus", 0);
> 	if (!of_node)
> 		return NULL;

... then we find the host controller device, which *does* have a
device-tree node and use *that* to find out the IOMMU corresponding to
the PCI device.

Will
