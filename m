From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Mon, 14 May 2018 15:00:50 -0500
Message-ID: <5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
	<152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
	<ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ba2bb6f7-77ea-4431-af0f-d20c19820d5d-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
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
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/14/2018 12:50 PM, Randy Dunlap wrote:
> On 05/14/2018 10:20 AM, Gary R Hook wrote:
>> Implement a skeleton framework for debugfs support in the
>> AMD IOMMU.
>>
>> Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/iommu/Makefile            |    5 +++++
>>   drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
>>   drivers/iommu/amd_iommu_init.c    |    6 ++++--
>>   drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>>   drivers/iommu/amd_iommu_types.h   |    3 +++
>>   5 files changed, 57 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/iommu/amd_iommu_debugfs.c
>>
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 74cfbc392862..dd980f7dd8b6 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -30,3 +30,8 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>>   obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>>   obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>>   obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
>> +
>> +# This ensures that only the required files are compiled
>> +ifeq ($(CONFIG_IOMMU_DEBUGFS), y)
> 
> Most Makefiles don't use a space before the 'y', but since you tested it,
> I guess either way works.

Pretty sure whitespace isn't used as a delimiter in this construct. I 
could be mistaken. But yes, it's perfectly serviceable.

> But why do this in the Makefile at all?  Why not just add another Kconfig
> symbol and simplify the Makefile?
> 
>> +obj-$(CONFIG_AMD_IOMMU) += amd_iommu_debugfs.o
>> +endif


This was brought up a few weeks ago in, I believe, version 3 of this 
patch. That question was discussed (because that's what I did the first 
time out), and _someone_ _else_ asked about why I didn't just do it the 
way I've done it here.

Everyone has a preference.

I chose to simplify the choices and avoid multiple symbols, instead 
opting for two switches: choose your device, and decide on Debug FS 
enablement for it. IMO Very simple.

I can't fathom a scenario where this wouldn't work. Is there one?
