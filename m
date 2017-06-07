From: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Wed, 7 Jun 2017 09:03:15 -0500
Message-ID: <32599b14-c138-3c89-6834-0335fec0b3f6@amd.com>
References: <20170605195203.11512.20579.stgit@tlendack-t1.amdoffice.net>
	<20170605195235.11512.52995.stgit@tlendack-t1.amdoffice.net>
	<20170606120516.GD30388@8bytes.org>
	<85356483-1d5e-251f-57e3-d9f761239100@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <85356483-1d5e-251f-57e3-d9f761239100-5C7GfCeVMHo@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 6/6/2017 8:36 AM, Tom Lendacky wrote:
> On 6/6/2017 7:05 AM, Joerg Roedel wrote:
>> Hey Tom,
> 
> Hi Joerg,
> 
>>
>> On Mon, Jun 05, 2017 at 02:52:35PM -0500, Tom Lendacky wrote:
>>> After reducing the amount of MMIO performed by the IOMMU during 
>>> operation,
>>> perf data shows that flushing the TLB for all protection domains during
>>> DMA unmapping is a performance issue. It is not necessary to flush the
>>> TLBs for all protection domains, only the protection domains associated
>>> with iova's on the flush queue.
>>>
>>> Create a separate queue that tracks the protection domains associated 
>>> with
>>> the iova's on the flush queue. This new queue optimizes the flushing of
>>> TLBs to the required protection domains.
>>>
>>> Reviewed-by: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
>>> Signed-off-by: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/iommu/amd_iommu.c |   56 
>>> ++++++++++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 50 insertions(+), 6 deletions(-)
>>
>> I also did a major rewrite of the AMD IOMMU queue handling and flushing
>> code last week. It is functionally complete and I am currently testing,
>> documenting it, and cleaning it up. I pushed the current state of it to
>>
>>     git://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git 
>> amd-iommu
>>
>> Its quite intrusive as it implements a per-domain flush-queue, and uses
>> a ring-buffer instead of a real queue. But you see the details in the
>> code.
>>
>> Can you please have a look and give it a test in your setup?
> 
> I'll try and look at this as soon as I can... I'm sharing the test
> setup and I might not be able to get access again for a day or two.
> 

I was able to run your patches in combination with the first two patches
that I submitted and the results look good.  Let me know if you'd like
me to resubmit the series minus the third patch.

Thanks,
Tom

> Thanks,
> Tom
> 
>>
>>
>> Thanks,
>>
>>     Joerg
>>
