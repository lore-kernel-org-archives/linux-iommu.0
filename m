From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 14/22] iommu: handle page response timeout
Date: Mon, 30 Apr 2018 11:58:10 +0100
Message-ID: <e98a1385-9e55-c021-4e89-7d07701f4b84@arm.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-15-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180423153622.GC38106@ostrya.localdomain>
	<20180425083711.222202e7@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180425083711.222202e7@jacob-builder>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 25/04/18 16:37, Jacob Pan wrote:
>> In the other cases (unsupported PRI or rogue guest) then disabling PRI
>> using a FAILURE status might be the right thing to do. However,
>> assuming the device follows the PCI spec it will stop sending page
>> requests once there are as many PPRs in flight as the allocated
>> credit.
>>
> Agreed, here I am not taking any actions. There may be need to drain
> in-fly requests.

Right, as long as we first ensure that no new fault is generated (by
using a Response Failure). Though in my opinion not taking action might
be the safest option :)

Another thought: currently the comment in iommu.h says
"@IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent faults
from this device if possible. This is "Response Failure" in PCI PRI."

I wonder if we should simply say "Drop all subsequent faults from the
device". Even if the PCI device doesn't properly implement PRI, the
IOMMU driver should set a "PRI disabled" bit in the device data that
prevents it from from reporting new faults and flooding the queue.
Anyway, it's a small detail that could go in a future patch series.

>> If there isn't any possibility of memory leak or abusing resources, I
>> don't think it's our problem that the guest is excessively slow at
>> handling page requests. Setting an upper bound to page request latency
>> might do more harm than good. Ensuring that devices respect the number
>> of allocated in-flight PPRs is more important in my opinion.
>>
> How about we have a really long timeout, e.g. 1 min similar to device
> invalidate response timeout in ATS spec., just for basic safety and
> diagnosis. Optionally, we could have quota in parallel.

I agree that for development a timeout is useful. It might be worth
adding it as an option to the IOMMU module instead of a define. Perhaps
a number of seconds, 10 being the default and 0 disabling the timeout?
Otherwise we would probably end up with a succession of patches
incrementing the timeout by arbitrary values, if people find it
inconvenient.

Thanks,
Jean
