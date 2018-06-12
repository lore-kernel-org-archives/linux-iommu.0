From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v8 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Tue, 12 Jun 2018 13:40:14 -0500
Message-ID: <da1b355b-d40f-222c-5daf-c91a6ca41eda@amd.com>
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
	<152761820371.2654.4551405686504157036.stgit@sosgrh1.amd.com>
	<20180529183917.GA10618@kroah.com>
	<9713a0b2-1450-7783-712f-ba27f8a09b2b@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9713a0b2-1450-7783-712f-ba27f8a09b2b-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
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
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/04/2018 08:23 PM, Randy Dunlap wrote:
> On 05/29/2018 11:39 AM, Greg KH wrote:
>> On Tue, May 29, 2018 at 01:23:23PM -0500, Gary R Hook wrote:
>>> Implement a skeleton framework for debugfs support in the
>>> AMD IOMMU. Add a hidden boolean to Kconfig that is defined
>>> for the AMD IOMMU when general IOMMY DebugFS support is
>>> enabled.
>>>
>>> Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/iommu/Kconfig             |    4 ++++
>>>   drivers/iommu/Makefile            |    1 +
>>>   drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
>>>   drivers/iommu/amd_iommu_init.c    |    6 ++++--
>>>   drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>>>   drivers/iommu/amd_iommu_types.h   |    5 +++++
>>>   6 files changed, 59 insertions(+), 2 deletions(-)
>>>   create mode 100644 drivers/iommu/amd_iommu_debugfs.c
>>>
>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>> index f9af25ac409f..ec223f6f4ad4 100644
>>> --- a/drivers/iommu/Kconfig
>>> +++ b/drivers/iommu/Kconfig
>>> @@ -137,6 +137,10 @@ config AMD_IOMMU
>>>   	  your BIOS for an option to enable it or if you have an IVRS ACPI
>>>   	  table.
>>>   
>>> +config AMD_IOMMU_DEBUGFS
>>> +	def_bool y
>>
>> Why default y?  Can you not boot a box without this?  If not, it should
>> not be Y.
>>
>>> +	depends on AMD_IOMMU && IOMMU_DEBUGFS
>>> +
>>>   config AMD_IOMMU_V2
>>>   	tristate "AMD IOMMU Version 2 driver"
>>>   	depends on AMD_IOMMU
> 
> Gary,
> 
> By far, most driver-debugfs additions are optional and include a user Kconfig prompt
> so that user's can choose whether to enable it or not.
> 
> I suggest that the way forward is to fix Greg's debugfs_() api comments
> and to add a prompt string to AMD_IOMMU_DEBUGFS.

Roger. I think we have that all worked out. Will send another version soon.

Thanks.
