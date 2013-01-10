From: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu: moving initialization earlier
Date: Thu, 10 Jan 2013 16:16:27 -0700
Message-ID: <CAKocOOMAfkv_a71gKhGRwTM-pZsfd8qG7VVWn22Yuv6pkcdQLQ@mail.gmail.com>
References: <1357545112-17375-1-git-send-email-aik@ozlabs.ru>
	<20130110170941.GA2556@8bytes.org>
	<CAKocOOP=V=kZ=4661YSs4b+7GLcNqzVvvhb+ONBO=LiR3txvTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAKocOOP=V=kZ=4661YSs4b+7GLcNqzVvvhb+ONBO=LiR3txvTA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Thu, Jan 10, 2013 at 1:40 PM, Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Jan 10, 2013 at 10:09 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>> On Mon, Jan 07, 2013 at 06:51:52PM +1100, Alexey Kardashevskiy wrote:
>>> The iommu_init() initializes IOMMU internal structures and data
>>> required for the IOMMU API as iommu_group_alloc().
>>> It is registered as a subsys_initcall now.
>>>
>>> One of the IOMMU users is going to be a PCI subsystem on POWER.
>>> It discovers new IOMMU tables during the PCI scan so the logical
>>> place to call iommu_group_alloc() is the moment when a new group
>>> is discovered. However PCI scan is done from subsys_initcall hook
>>> as IOMMU does so PCI hook can be (and is) called before the IOMMU one.
>>>
>>> The patch moves IOMMU subsystem initialization one step earlier
>>> to make sure that IOMMU is initialized before PCI scan begins.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
>>
>> Applied, thanks.
>
> Joerg,
>
> Could you please consider this patch for stable releases.

The patch applies cleanly only on 3.6.y which is EOL. Guess I am out
of luck with this patch.

-- Shuah

-- Shuah
