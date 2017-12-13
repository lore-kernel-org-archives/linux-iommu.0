From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 2/6] iommu/vt-d: Add Intel IOMMU debugfs to show
	context internals
Date: Wed, 13 Dec 2017 10:28:45 +0800
Message-ID: <5A30905D.9000303@linux.intel.com>
References: <1512531807-24268-1-git-send-email-sohil.mehta@intel.com>
	<1512531807-24268-3-git-send-email-sohil.mehta@intel.com>
	<5A27A74C.9070201@linux.intel.com>
	<1512678006.120652.17.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1512678006.120652.17.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Mehta, Sohil" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Yu, Fenghua" <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Shevchenko,
	Andriy" <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Shankar,
	Ravi V" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Kammela,
	Gayatri" <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

Sorry for late reply.

On 12/08/2017 04:19 AM, Mehta, Sohil wrote:
> On Wed, 2017-12-06 at 16:16 +0800, Lu Baolu wrote:
>> Hi,
>>
>> On 12/06/2017 11:43 AM, Sohil Mehta wrote:
>>> From: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>>
>>>  
>>> +	seq_printf(m, "%s Context table entries for Bus: %d\n",
>>> +		   ext ? "Lower" : "", bus);
>>> +	seq_printf(m, "[entry]\tDID :B :D .F\tLow\t\tHigh\n");
>> WARNING: Prefer seq_puts to seq_printf
>> #119: FILE: drivers/iommu/intel-iommu-debug.c:59:
>> +    seq_printf(m, "[entry]\tDID :B :D .F\tLow\t\tHigh\n");
>>
>> (caught by checkpatch.pl)
>>
> Hi Lu,
>
> We'll fix this and the other checkpatch.pl warnings.
>
>
>>> +
>>> +static void root_tbl_entry_show(struct seq_file *m, void *unused,
>> Why do you define the "unused" parameter which will never been used?
>> The same questions to other show functions.
>>
> Some functions in our code that are registered with seq_file needed to
> have an unused parameter since seq_file.h defines the show function as:
> 	int (*show) (struct seq_file *m, void *v);
>
> But a lot of other functions including the one you pointed don't need
> to have the unused parameter. We'll remove it from those.
>
>
>>> +void __init intel_iommu_debugfs_init(void)
>>> +{
>>> +	struct dentry *iommu_debug_root;
>>> +
>>> +	iommu_debug_root = debugfs_create_dir("intel_iommu",
>>> NULL);
>>> +
>>> +	if (!iommu_debug_root) {
>>> +		pr_err("can't create debugfs dir\n");
>> I don't think we need a pr_err() here. System works well even
>> debugfs_create_dir() returns NULL.
>>
>> This is same to all pr_err() in this file.
>>
> Would the recommendation be to use pr_warn instead of pr_err or should
> we entirely skip the message altogether?

Greg ever educated me about the use of debugfs_ functions in
this thread.

https://spinics.net/lists/linux-usb/msg159384.html

At least we should avoid the warning/error messages here.

Best regards,
Lu Baolu
