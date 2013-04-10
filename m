From: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
	register
Date: Wed, 10 Apr 2013 13:47:34 +0900
Message-ID: <5164EEE6.8000707@jp.fujitsu.com>
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
	<20130326144629.GB2727@8bytes.org>
	<51527D74.9080209@jp.fujitsu.com>
	<20130327103122.GK30540@8bytes.org> <51591EEE.60401@jp.fujitsu.com>
	<20130402140546.GA15687@8bytes.org>
	<515BD638.8070307@jp.fujitsu.com>
	<1364977479.28127.15.camel@i7.infradead.org>
	<20130405110616.GB6858@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130405110616.GB6858-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tindoh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

(2013/04/05 20:06), Joerg Roedel wrote:
> On Wed, Apr 03, 2013 at 09:24:39AM +0100, David Woodhouse wrote:
>> On Wed, 2013-04-03 at 16:11 +0900, Takao Indoh wrote:
>>> Yeah, you are right. I forgot such a case.
>>
>> If you disable translation and there's some device still doing DMA, it's
>> going to scribble over random areas of memory. You really want to have
>> translation enabled and all the page tables *cleared*, during kexec. I
>> think it's fair to insist that the secondary kernel should use the IOMMU
>> if the first one did.
> 
> Do we really need to insist on that? The IOMMU initialization on x86
> happens after the kernel scanned and enumerated the PCI bus. While doing
> this the kernel (at least it should) disables all devices it finds. So
> when the IOMMU init code runs we should be safe from any in-flight DMA
> and can either disable translation or re-initialize it for the kdump
> kernel. Until then translation needs to stay enabled of course, so that
> the old page-tables are still used and in-flight DMA doesn't corrupt
> any data.

So we should do in this order, right?
(1) PCI initialization. Stop all ongoing DMA here.
(2) Disable translation if already enable.
(3) Make pgtable and enable translation.

Thanks,
Takao Indoh
