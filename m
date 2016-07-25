From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH v3 05/13] drivers: iommu: make iommu_fwspec OF agnostic
Date: Mon, 25 Jul 2016 10:21:10 -0500
Message-ID: <CAL_JsqKc4aJ1xiJAS6HRKeVO8mrZWpBF0uugvmCgNuUamJF=Eg@mail.gmail.com>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1469013815-24380-6-git-send-email-lorenzo.pieralisi@arm.com>
	<1499f802-5f98-b0c0-d3aa-dabcac81e84e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1499f802-5f98-b0c0-d3aa-dabcac81e84e-5wv7dgnIgG8@public.gmane.org>
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
Cc: Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 25, 2016 at 10:09 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Lorenzo,
>
> On 20/07/16 12:23, Lorenzo Pieralisi wrote:
>> The iommu_fwspec structure, used to hold per device iommu configuration
>> data is not OF specific and therefore can be moved to a generic
>> and OF independent compilation unit.
>>
>> In particular, the iommu_fwspec handling hinges on the device_node
>> pointer to identify the IOMMU device associated with the iommu_fwspec
>> structure, that is easily converted to a more generic fwnode_handle
>> pointer that can cater for OF and non-OF (ie ACPI) systems.
>>
>> Create the files and related Kconfig entry to decouple iommu_fwspec
>> structure from the OF iommu kernel layer.
>>
>> Given that the current iommu_fwspec implementation relies on
>> the arch specific struct device.archdata.iommu field in its
>> implementation, by making the code standalone and independent
>> of the OF layer this patch makes sure that the iommu_fwspec
>> kernel code can be selected only on arches implementing the
>> struct device.archdata.iommu field by adding an explicit
>> arch dependency in its config entry.
>>
>> Current drivers using the iommu_fwspec for streamid translation
>> are converted to the new iommu_fwspec API by simply converting
>> the device_node to its fwnode_handle pointer.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
>> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> Cc: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
>> ---
>>  drivers/iommu/Kconfig        |   4 ++
>>  drivers/iommu/Makefile       |   1 +
>>  drivers/iommu/arm-smmu-v3.c  |  13 +++--
>>  drivers/iommu/iommu-fwspec.c | 114 +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/iommu/of_iommu.c     |  52 --------------------
>>  include/linux/iommu-fwspec.h |  60 +++++++++++++++++++++++
>>  include/linux/of_iommu.h     |  24 +++------
>>  7 files changed, 196 insertions(+), 72 deletions(-)
>>  create mode 100644 drivers/iommu/iommu-fwspec.c
>>  create mode 100644 include/linux/iommu-fwspec.h
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index d1c66af..2b26bfb 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -67,6 +67,10 @@ config OF_IOMMU
>>         def_bool y
>>         depends on OF && IOMMU_API
>>
>> +config IOMMU_FWSPEC
>> +       def_bool y
>> +       depends on ARM64 && IOMMU_API
>
> I think that could be at least (ARM || ARM64).

Why any arch dependency?

Seems like OF_IOMMU (and ACPI?) should select this.

Rob
