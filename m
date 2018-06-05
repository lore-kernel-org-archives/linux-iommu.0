From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v8 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Tue, 5 Jun 2018 11:58:13 -0500
Message-ID: <f0780139-5322-a028-0091-3255e0596eff@amd.com>
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
	<152761820371.2654.4551405686504157036.stgit@sosgrh1.amd.com>
	<20180529183917.GA10618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180529183917.GA10618-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/29/2018 01:39 PM, Greg KH wrote:
> On Tue, May 29, 2018 at 01:23:23PM -0500, Gary R Hook wrote:
>> Implement a skeleton framework for debugfs support in the
>> AMD IOMMU. Add a hidden boolean to Kconfig that is defined
>> for the AMD IOMMU when general IOMMY DebugFS support is
>> enabled.
>>
>> Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/iommu/Kconfig             |    4 ++++
>>   drivers/iommu/Makefile            |    1 +
>>   drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
>>   drivers/iommu/amd_iommu_init.c    |    6 ++++--
>>   drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>>   drivers/iommu/amd_iommu_types.h   |    5 +++++
>>   6 files changed, 59 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/iommu/amd_iommu_debugfs.c
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index f9af25ac409f..ec223f6f4ad4 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -137,6 +137,10 @@ config AMD_IOMMU
>>   	  your BIOS for an option to enable it or if you have an IVRS ACPI
>>   	  table.
>>   
>> +config AMD_IOMMU_DEBUGFS
>> +	def_bool y
> 
> Why default y?  Can you not boot a box without this?  If not, it should
> not be Y.

Again, apologies for not seeing this sooner.

Yes, the system can boot without this. The idea of a hidden option was 
surfaced by Robin, and after my first approach was shot down, I tried this.

Logic: If the over-arching IOMMU debugfs option is enabled, then 
AMD_IOMMU_DEBUGFS gets defined, and AMD IOMMU code gets included.

This issue was discussed a few weeks ago. No single approach appears to 
satisfy everyone. I like this because it depends upon one switch: Do you 
want DebugFS support enabled in the IOMMU driver, period? 
Vendor-specific code can then choose to implement support or not, and a 
builder doesn't have to worry about enabling/disabling multiple Kconfig 
options.

At least, that was my line of reasoning.

I'm not married to any approach, and I don't find clever use of Kconfig 
options too terribly challenging. And I'm not defending, I'm just 
explaining.



> 
>> +	depends on AMD_IOMMU && IOMMU_DEBUGFS
>> +
>>   config AMD_IOMMU_V2
>>   	tristate "AMD IOMMU Version 2 driver"
>>   	depends on AMD_IOMMU
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 74cfbc392862..47fd6ea9de2d 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>>   obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>>   obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>>   obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
>> +obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
>>   obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>>   obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>> diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
>> new file mode 100644
>> index 000000000000..6dff98552969
>> --- /dev/null
>> +++ b/drivers/iommu/amd_iommu_debugfs.c
>> @@ -0,0 +1,39 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD IOMMU driver
>> + *
>> + * Copyright (C) 2018 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
>> + */
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/iommu.h>
>> +#include <linux/pci.h>
>> +#include "amd_iommu_proto.h"
>> +#include "amd_iommu_types.h"
>> +
>> +static struct dentry *amd_iommu_debugfs;
>> +static DEFINE_MUTEX(amd_iommu_debugfs_lock);
>> +
>> +#define	MAX_NAME_LEN	20
>> +
>> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
>> +{
>> +	char name[MAX_NAME_LEN + 1];
>> +
>> +	mutex_lock(&amd_iommu_debugfs_lock);
>> +	if (!amd_iommu_debugfs)
>> +		amd_iommu_debugfs = iommu_debugfs_new_driver_dir("amd");
>> +	mutex_unlock(&amd_iommu_debugfs_lock);
>> +
>> +	if (amd_iommu_debugfs) {
> 
> Do not test this.

Okay, noted. I'll stop worrying about this.

> 
>> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
>> +		iommu->debugfs = debugfs_create_dir(name,
>> +						    amd_iommu_debugfs);
>> +		if (!iommu->debugfs) {
> 
> No, you don't care about the return value of any debugfs call.  Just
> save the directory and move on.  If it's not correct, find, nothing is
> wrong, just keep going.

Roger.

Thank you,
Gary
