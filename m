From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH/RFC] iommu/dma: Per-domain flag to control size-alignment
Date: Mon, 30 Jan 2017 12:07:00 +0000
Message-ID: <584852f8-fb0c-3f29-dfe4-ac9aef918228@arm.com>
References: <148549826507.23190.1460689571069015835.sendpatchset@little-apple>
	<464656f9-970e-1271-0d9e-b62a0673e1dd@arm.com>
	<HK2PR06MB05481A6F9E20CCAC13F9A336D84B0@HK2PR06MB0548.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <HK2PR06MB05481A6F9E20CCAC13F9A336D84B0-jAC1QCBx2F3DOGFS7+tQZW0DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 30/01/17 07:20, Yoshihiro Shimoda wrote:
> Hi Robin, Magnus,
> 
>> -----Original Message-----
>> From: Robin Murphy
>> Sent: Saturday, January 28, 2017 2:38 AM
>>
>> Hi Magnus,
>>
>> On 27/01/17 06:24, Magnus Damm wrote:
>>> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>>>
>>> Introduce the flag "no_size_align" to allow disabling size-alignment
>>> on a per-domain basis. This follows the suggestion by the comment
>>> in the code, however a per-device control may be preferred?
>>>
>>> Needed to make virtual space contiguous for certain devices.
>>
>> That sounds very suspicious - a single allocation is contiguous with
>> itself by definition, and anyone relying on multiple allocations being
>> contiguous with one another is doing it wrong, because there's no way we
>> could ever guarantee that (with this allocator, at any rate). I'd be
>> very reticent to touch this without a specific example of what problem
>> it solves.
> 
> Thank you for the comment! This patch was from my request.
> But, I completely misunderstood this "size-alignment" behavior.
> And, my concern was already resolved by the following patch at last April:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/iommu?id=809eac54cdd62c67afea1e17080e681dfa33dc09
> 
> So, no one needs this patch anymore.

Cool, thanks for the clarification :)

Robin.

> 
> Best regards,
> Yoshihiro Shimoda
> 
