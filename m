From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v8 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Tue, 12 Jun 2018 13:37:43 -0500
Message-ID: <bd3d0561-3326-1468-a7c0-cee601c275a6@amd.com>
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
	<152761820371.2654.4551405686504157036.stgit@sosgrh1.amd.com>
	<20180529183917.GA10618@kroah.com>
	<f0780139-5322-a028-0091-3255e0596eff@amd.com>
	<20180605170624.GB10834@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180605170624.GB10834-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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

On 06/05/2018 12:06 PM, Greg KH wrote:
> On Tue, Jun 05, 2018 at 11:58:13AM -0500, Gary R Hook wrote:
>> On 05/29/2018 01:39 PM, Greg KH wrote:
>>> On Tue, May 29, 2018 at 01:23:23PM -0500, Gary R Hook wrote:
>>>> Implement a skeleton framework for debugfs support in the
>>>> AMD IOMMU. Add a hidden boolean to Kconfig that is defined
>>>> for the AMD IOMMU when general IOMMY DebugFS support is
>>>> enabled.
>>>>
>>>> Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
>>>> ---
>>>>    drivers/iommu/Kconfig             |    4 ++++
>>>>    drivers/iommu/Makefile            |    1 +
>>>>    drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
>>>>    drivers/iommu/amd_iommu_init.c    |    6 ++++--
>>>>    drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>>>>    drivers/iommu/amd_iommu_types.h   |    5 +++++
>>>>    6 files changed, 59 insertions(+), 2 deletions(-)
>>>>    create mode 100644 drivers/iommu/amd_iommu_debugfs.c
>>>>
>>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>> index f9af25ac409f..ec223f6f4ad4 100644
>>>> --- a/drivers/iommu/Kconfig
>>>> +++ b/drivers/iommu/Kconfig
>>>> @@ -137,6 +137,10 @@ config AMD_IOMMU
>>>>    	  your BIOS for an option to enable it or if you have an IVRS ACPI
>>>>    	  table.
>>>> +config AMD_IOMMU_DEBUGFS
>>>> +	def_bool y
>>>
>>> Why default y?  Can you not boot a box without this?  If not, it should
>>> not be Y.
>>
>> Again, apologies for not seeing this sooner.
>>
>> Yes, the system can boot without this. The idea of a hidden option was
>> surfaced by Robin, and after my first approach was shot down, I tried this.
>>
>> Logic: If the over-arching IOMMU debugfs option is enabled, then
>> AMD_IOMMU_DEBUGFS gets defined, and AMD IOMMU code gets included.
>>
>> This issue was discussed a few weeks ago. No single approach appears to
>> satisfy everyone. I like this because it depends upon one switch: Do you
>> want DebugFS support enabled in the IOMMU driver, period? Vendor-specific
>> code can then choose to implement support or not, and a builder doesn't have
>> to worry about enabling/disabling multiple Kconfig options.
>>
>> At least, that was my line of reasoning.
>>
>> I'm not married to any approach, and I don't find clever use of Kconfig
>> options too terribly challenging. And I'm not defending, I'm just
>> explaining.
> 
> The issue is, no one sets Kconfig options except a very tiny subset of
> kernel developers.  Distros allways enable everything, as they have to
> do that.
> 
> If you are creating something here that is so dangerous that you spam
> the kernel log with big warning messages, you should not be making it
> easy to enable, let alone be enabled by default :)

Okay, I get that. Totally understand.

> Just make it an option, have it rely on the kernel debugging option, and
> say "DO NOT ENABLE THIS UNLESS YOU REALLY REALLY REALLY KNOW WHAT YOU
> ARE DOING!"

Nah, Randy voted for separate options per device, on top of the IOMMU 
option. So I'll go with that. With loud messages, of course.
