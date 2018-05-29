From: Gary R Hook <ghook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] iommu/amd - Optimize PPR log handling
Date: Tue, 29 May 2018 12:28:54 -0500
Message-ID: <223930b9-3df9-813a-6676-68072e4e1bb6@amd.com>
References: <152668031618.108078.8188026193559324640.stgit@wsp141332wss.amd.com>
	<20180529145405.GN18595@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180529145405.GN18595-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/29/2018 09:54 AM, Joerg Roedel wrote:
> Hey Gary,
> 
> On Fri, May 18, 2018 at 04:51:56PM -0500, Gary R Hook wrote:
>> Improve the performance of the PPR log polling function (i.e. the
>> task of emptying the log) by minimizing MMIO operations and more
>> efficiently processing groups of log entries. Cache the head
>> pointer, as there's never a reason to read it. Ensure the head
>> pointer register is updated every so often, to inform the IOMMU
>> that space is available in the log.
>>
>> Finally, since a single pass may leave logged events unread, use
>> an outer loop to repeat until head has caught up to tail.
>>
>> Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
> 
> Do you have numbers for the performance improvement? How did you test
> this patch?

No, no numbers. We're still working out how best to test this, and 
suggestions/strategies are welcome.

The change is modeled after the function iommu_poll_events(), which is 
much cleaner. The GA log handling should be changed, as well (there are 
superfluous writes in the loop), but I figured, "one thing at a time". 
This is admittedly a minor optimization, but discussions with Tom 
Lendacky have led us down this path.

Your feedback is appreciated.

Gary
