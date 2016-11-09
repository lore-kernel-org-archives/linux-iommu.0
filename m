From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 01/16] drivers: acpi: add FWNODE_ACPI_STATIC fwnode type
Date: Thu, 10 Nov 2016 00:37:04 +0100
Message-ID: <CAJZ5v0iRwh3T8U6JeDgWSMX4hbuvo21KGh7MV__=DCVMMefsTQ@mail.gmail.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
	<20161109141948.19244-2-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161109141948.19244-2-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 9, 2016 at 3:19 PM, Lorenzo Pieralisi
<lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org> wrote:
> On systems booting with a device tree, every struct device is associated
> with a struct device_node, that provides its DT firmware representation.
> The device node can be used in generic kernel contexts (eg IRQ
> translation, IOMMU streamid mapping), to retrieve the properties
> associated with the device and carry out kernel operations accordingly.
> Owing to the 1:1 relationship between the device and its device_node,
> the device_node can also be used as a look-up token for the device (eg
> looking up a device through its device_node), to retrieve the device in
> kernel paths where the device_node is available.
>
> On systems booting with ACPI, the same abstraction provided by
> the device_node is required to provide look-up functionality.
>
> The struct acpi_device, that represents firmware objects in the
> ACPI namespace already includes a struct fwnode_handle of
> type FWNODE_ACPI as their member; the same abstraction is missing
> though for devices that are instantiated out of static ACPI tables
> entries (eg ARM SMMU devices).
>
> Add a new fwnode_handle type to associate devices created out
> of static ACPI table entries to the respective firmware components
> and create a simple ACPI core layer interface to dynamically allocate
> and free the corresponding firmware nodes so that kernel subsystems
> can use it to instantiate the nodes and associate them with the
> respective devices.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> Reviewed-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Tested-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Tested-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Thanks!
