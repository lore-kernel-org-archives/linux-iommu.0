From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 00/16] ACPI IORT ARM SMMU support
Date: Thu, 27 Oct 2016 12:24:48 +0200
Message-ID: <CAJZ5v0i=ZZDwnAU_=cAW5NR5M7EAOVPmpdqfMhf_jGmeZoHLVQ@mail.gmail.com>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
	<20161026110459.GA15276@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161026110459.GA15276@red-moon>
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

On Wed, Oct 26, 2016 at 1:04 PM, Lorenzo Pieralisi
<lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org> wrote:
> Rafael, Joerg (and anyone else CC'ed),
>
> On Tue, Oct 18, 2016 at 05:03:58PM +0100, Lorenzo Pieralisi wrote:
>> This patch series is v6 of a previous posting:
>>
>> https://lkml.org/lkml/2016/9/9/418
>>
>> v5 -> v6
>>       - Rebased against v4.9-rc1
>>       - Changed FWNODE_IOMMU to FWNODE_ACPI_STATIC
>>       - Moved platform devices creation into IORT code
>>       - Updated fwnode handling
>>       - Added default dma masks initialization
>
> Any comments on v6 ? Patches touching generic ACPI code
> are {1, 2, 7}, patch 4 updates the IOMMU of_iommu_{set/get}_ops()
> API to make it work on ACPI systems too, by replacing the
> device_node with a fwnode_handle pointer as look-up token;
> the remainder of patches are ARM specific and creates the
> infrastructure to probe ARM SMMU devices through ACPI,
> ARM IORT table in particular. Given the generic bits changes
> above I would not leave it to late -rc to reach an agreement
> please, thank you.

I'll do my best to look at these in the next few days, but please also
note what I wrote before:

http://marc.info/?l=linux-acpi&m=147744344531599&w=2

Thanks,
Rafael
