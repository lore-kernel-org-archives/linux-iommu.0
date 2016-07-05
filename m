From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Remove unnecassary qi clflushes
Date: Tue, 5 Jul 2016 18:57:09 +0200
Message-ID: <f75fc793-d955-3c9d-832c-d4a494f0854e@redhat.com>
References: <1466773994-242872-1-git-send-email-namit@vmware.com>
	<20160627113014.GL11432@8bytes.org>
	<C78095BC-3BED-48DE-90CE-601DE40AA613@gmail.com>
	<926A8CFB-D22D-4DC6-9EE0-D912451365BB@gmail.com>
	<ac3ff8d4-e47b-e4d8-40ed-02811732526a@redhat.com>
	<5F48A3E6-99EE-4DC5-BF38-4F0338E9E8D0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5F48A3E6-99EE-4DC5-BF38-4F0338E9E8D0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nadav Amit <namit-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 05/07/2016 18:50, Nadav Amit wrote:
> Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
>>
>>
>> On 05/07/2016 18:27, Nadav Amit wrote:
>>>> Although such hardware is old, there are some hypervisors that do not set
>>>> the ecap.coherency of emulated IOMMUs. Yes, it is unwise, but there is no
>>>> reason to further punish these hypervisors.
>>
>> QEMU will need the kernel to respect ecap.coherency in order to support
>> nested VFIO, for example.
> 
> To clarify - the kernel respects the coherency, but performs more clflushes
> than necessary. It has no functional impact, but induces performance
> degradation (which I  did not measure, but is likely to be several hundreds
> of cycles per flush).

Oh, then QEMU indeed doesn't care about flushing the invalidation queue.

Paolo
