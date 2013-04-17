From: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
	register
Date: Wed, 17 Apr 2013 17:48:46 +0900
Message-ID: <516E61EE.5030607@jp.fujitsu.com>
References: <20130326144629.GB2727@8bytes.org>
	<51527D74.9080209@jp.fujitsu.com>
	<20130327103122.GK30540@8bytes.org> <51591EEE.60401@jp.fujitsu.com>
	<20130402140546.GA15687@8bytes.org>
	<515BD638.8070307@jp.fujitsu.com>
	<1364977479.28127.15.camel@i7.infradead.org>
	<20130405110616.GB6858@8bytes.org>
	<5164EEE6.8000707@jp.fujitsu.com> <516BC19D.4090303@jp.fujitsu.com>
	<20130415101829.GP6858@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130415101829.GP6858-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tindoh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

(2013/04/15 19:18), Joerg Roedel wrote:
> On Mon, Apr 15, 2013 at 06:00:13PM +0900, Takao Indoh wrote:
>> On DMAR initialization during kdump boot, do you guys agree to change
>> order like this?
>>
>> Current order:
>> (1) Disable translation
>> (2) PCI initialization
>> (3) Make pgtable and enable translation.
>>
>> Order I'm proposing:
>> (1) PCI initialization
>> (2) Disable translation
>> (3) Make pgtable and enable translation.
> 
> I think this should work. In fact, translation only needs to be disabled
> while the IOMMU hardware is reprogrammed to the new data structures the
> kdump kernel set up.

Ok, I agree.

> 
>> As Joerg said, if we need to consider the case that kdump kernel is
>> compiled without dma-remapping(CONFIG_INTEL_IOMMU is off?), I can update
>> my patch to handle such a case properly by adding ifdef
>> CONFIG_INTEL_IOMMU.
> 
> Thinking about it, this case is a bit more special. If the kdump kernel
> has no IOMMU driver at all there is also no code to disable it. So
> unless we want to force the kdump kernel to have the driver when the
> first kernel had it, I think we also want some quirk (depending on
> !CONFIG_INTEL_IOMMU) that disables translation at boot.
> 
> I know, its complicated :)

yeah complicated. hmm..., this isn't limited only to iommu case, there
are many problems which are caused by difference of config between first
kernel and second one. So, to make code simple, I think we don't need to
care such a exceptional case. I mean, I think it is a matter of user
and user has to compile second kernel with dma-remapping if user want to
use it in first kernel.

Thanks,
Takao Indoh
