From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Date: Thu, 29 Mar 2018 10:52:15 -0500
Message-ID: <d9657df2-3742-6949-52ca-23d4ca186a7e@amd.com>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
	<20180213140303.42mbzfxpypljy37l@8bytes.org>
	<20180213214002.GA27066@otc-nc-03>
	<20180213145332.35c73eda@jacob-builder>
	<20180215095337.fccoozdclfnbepi4@8bytes.org>
	<20180215083811.3ec86e49@jacob-builder>
	<20180315131854.s6xmltsvsysublcw@8bytes.org>
	<20180319093714.3afe698b@jacob-builder>
	<20180329084824.fvy7cg2wban4by4n@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180329084824.fvy7cg2wban4by4n-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj,
	Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 03/29/2018 03:48 AM, Joerg Roedel wrote:
> [ Adding Gary from AMD to Cc ]
> 
> On Mon, Mar 19, 2018 at 09:37:14AM -0700, Jacob Pan wrote:
>> On Thu, 15 Mar 2018 14:18:54 +0100
>> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>>
>>> On Thu, Feb 15, 2018 at 08:38:11AM -0800, Jacob Pan wrote:
>>>> Just wondering if your concern is on the implementation or the
>>>> debugfs idea in general. Perhaps have some common IOMMU debugfs?
>>>
>>> My concern mainly is that we add interfaces which reveal
>>> potentially security relevant information
>> I don;t think security is any worse than existing kernel page table in
>> debugfs. i.e. /sys/kernel/debug/page_tables
>> This is a debug feature.
> 
> Okay, so here is the way to go: Please introduce a basic debugfs
> facility to the core iommu code. It should basically only create a
> 'iommu/' directory in debugfs where drivers can create their own
> sub-directories. This must be enabled by a new kconfig option
> (CONFIG_IOMMU_DEBUGFS) and the kernel should print a big fat warning at
> boot when it is enabled. This hopefully prevents anyone from enabling it
> for production kernels.

I'm halfway through this. Where would you like to place the invocation 
of the initialization function?

There's an iommu_init() in iommu.c, But it's a core_initcall, which 
doesn't seem like a good spot. Not knowing enough about bring-up here, 
Would adding another __init function be suitable?

Gary
