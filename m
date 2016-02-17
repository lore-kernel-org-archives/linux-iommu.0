From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: call detach also for default_domain before
	attaching to new one
Date: Wed, 17 Feb 2016 15:42:54 +0100
Message-ID: <56C486EE.5020504@samsung.com>
References: <1455633632-16873-1-git-send-email-m.szyprowski@samsung.com>
	<1455633632-16873-2-git-send-email-m.szyprowski@samsung.com>
	<20160216155922.GV18805@8bytes.org> <56C422AE.9000108@samsung.com>
	<20160217111450.GA18805@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20160217111450.GA18805-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 2016-02-17 12:14, Joerg Roedel wrote:
> On Wed, Feb 17, 2016 at 08:35:10AM +0100, Marek Szyprowski wrote:
>> Huh, I wasn't aware of this change in the iommu drivers api. For some
>> drivers attach/detach callbacks does something more than just programming
>> page table base register, like for example in case of exynos iommu it is
>> enabling runtime power management and clocks. The code is really
>> much simpler
>> if those calls are balanced, but if the goal is to allow multiple
>> unballanced
>> attach calls, I will try to fix this in our driver.
>>
>> Maybe it should be documented somewhere, that attach calls can be
>> unbalanced?
> Well, when your driver uses default-domains, the detach_dev call-back is
> not used anymore. The attach_dev call-back is supposed to just overwrite
> any existing binding that may exist for the device. So the calls are not
> unbalanced, the detach_dev calls just don't happen anymore.

 From driver perspective the default_domains don't really differ from the
'other' domains. They are just allocated from the IOMMU core and used by
the IOMMU/DMA-mapping glue code. That's what I got from reading the code.

There should be also a way to detach the driver even from the default domain
to implement the arch_tear_down_dma_ops function.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
