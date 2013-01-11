From: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu: moving initialization earlier
Date: Fri, 11 Jan 2013 09:56:20 -0700
Message-ID: <CAKocOOOzzpN_ZdN9owv5tb-28qtvXc9KvF7WuyZdxYrAYxnNTw@mail.gmail.com>
References: <1357545112-17375-1-git-send-email-aik@ozlabs.ru>
	<20130110170941.GA2556@8bytes.org>
	<CAKocOOP=V=kZ=4661YSs4b+7GLcNqzVvvhb+ONBO=LiR3txvTA@mail.gmail.com>
	<20130111145059.GJ25591@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130111145059.GJ25591-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 11, 2013 at 7:50 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Jan 10, 2013 at 01:40:17PM -0700, Shuah Khan wrote:
>> I am currently debugging IO_PAGE_FAULTS on 3.6.11 (happens on all
>> pre-3.7 releases). I root-caused the reason 3.7 works is because in
>> 3.7 amd iommu driver moving up the early iommu initialization from
>> irq_remap_ops with the irq remapping feature.
>
> Have you investigated the reason for those IO_PAGE_FAULTS? I guess they
> come from the USB controlers and happen between the time the IOMMU is
> enabled and the USB controlers are taken over by the Linux kernel from
> the BIOS.
>
> But I don't see why this patch can have any impact on the IO_PAGE_FAULTS
> you are seeing.

USB is one of them and SATA is another. I know with my back-port to
split dma ops initialization and this patch Alexey sent, the problem
goes away on 3.6.11 and I don't see the problem on 3.7. Same system,
and two different boots. I will investigate do more investigation into
the nature of these faults I am seeing and get back to you.

Thanks,
-- Shuah
