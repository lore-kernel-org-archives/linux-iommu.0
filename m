From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: call detach also for default_domain before
	attaching to new one
Date: Wed, 17 Feb 2016 08:35:10 +0100
Message-ID: <56C422AE.9000108@samsung.com>
References: <1455633632-16873-1-git-send-email-m.szyprowski@samsung.com>
	<1455633632-16873-2-git-send-email-m.szyprowski@samsung.com>
	<20160216155922.GV18805@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20160216155922.GV18805-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2016-02-16 16:59, Joerg Roedel wrote:
> On Tue, Feb 16, 2016 at 03:40:31PM +0100, Marek Szyprowski wrote:
>> This patch ensures that devices attached to the default_domain will be
>> first detached from it before attaching to new domain. To avoid forward
>> declaration, __iommu_attach_group() function has been moved to new place
>> in the source code.
> Actually it was intentional to not invoke the detach_device call-back in
> the attach_device path.
>
> The reason is that detaching first and than attaching again leaves the
> device without a domain for a short period of time, until it is attached
> to the new domain.
>
> The attach_device call-back is supposed to handle this situation and
> just silently overwrite any other domain->device binding it finds for
> the device.
>
> This allows to do re-attachment with less iommu flushes and to get rid
> of the detach_device call-back at some point.

Huh, I wasn't aware of this change in the iommu drivers api. For some
drivers attach/detach callbacks does something more than just programming
page table base register, like for example in case of exynos iommu it is
enabling runtime power management and clocks. The code is really much 
simpler
if those calls are balanced, but if the goal is to allow multiple 
unballanced
attach calls, I will try to fix this in our driver.

Maybe it should be documented somewhere, that attach calls can be 
unbalanced?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
