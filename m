From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v2 03/16] iommu: introduce iommu invalidate API function
Date: Thu, 12 Oct 2017 09:50:30 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439AF6AFB@SHSMSX104.ccr.corp.intel.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<20171010133542.juag7cwbivlb56sl@8bytes.org>
	<20171010150953.4095a045@jacob-builder>
	<A2975661238FB949B60364EF0F2C257439AF5F37@SHSMSX104.ccr.corp.intel.com>
	<20171011095126.GD30803@8bytes.org>
	<A2975661238FB949B60364EF0F2C257439AF61F5@SHSMSX104.ccr.corp.intel.com>
	<20171011121534.GG30803@8bytes.org>
	<3cdbce19-9264-b2d0-745b-8d32d5b8cfe7@arm.com>
	<541498d5-0478-0b9a-6c01-12f7dc30ebf3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <541498d5-0478-0b9a-6c01-12f7dc30ebf3-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Bob Liu <liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu,
	Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki,
	Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Bob Liu [mailto:liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org]
> Sent: Thursday, October 12, 2017 5:39 PM
> To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>; Joerg Roedel
> <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>; Liu, Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Lan, Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; Greg
> Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>; Wysocki, Rafael J
> <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Subject: Re: [PATCH v2 03/16] iommu: introduce iommu invalidate API function
> 
> On 2017/10/11 20:48, Jean-Philippe Brucker wrote:
> > On 11/10/17 13:15, Joerg Roedel wrote:
> >> On Wed, Oct 11, 2017 at 11:54:52AM +0000, Liu, Yi L wrote:
> >>> I didn't quite get 'iovm' mean. Can you explain a bit about the idea?
> >>
> >> It's short for IO Virtual Memory, basically a replacement term for 'svm'
> >> that is not ambiguous (afaik) and not specific to Intel.
> >
> > I wonder if SVM originated in OpenCL first, rather than intel? That's
> > why I'm using it, but it is ambiguous. I'm not sure IOVM is precise
> > enough though, since the name could as well be used without shared
> > tables, for classical map/unmap and IOVAs. Kevin Tian suggested SVA
> > "Shared Virtual Addressing" last time, which is a little more clear
> > than SVM and isn't used elsewhere in the kernel either.
> >
> 
> The process "vaddr" can be the same as "IOVA" by using the classical map/unmap
> way.
> This is also a kind of share virtual memory/address(except have to pin physical
> memory).
> How to distinguish these two different implementation of "share virtual
> memory/address"?
> 
[Liu, Yi L] Not sure if I get your idea well. Process "vaddr" is owned by process and
maintained by mmu, while "IOVA" is maintained by iommu. So they are different in the
way they are maintained. Since process "vaddr" is maintained by mmu and then used by
iommu, so we call it shared virtual memory/address. This is how "shared" term comes.
I didn't quite get " two different implementation of "share virtual memory/address"".
Maybe you can explain further more.

Regards,
Yi L
