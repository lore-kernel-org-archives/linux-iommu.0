From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 03/12] intel-ipu3: Add DMA API implementation
Date: Wed, 26 Jul 2017 22:51:46 +0900
Message-ID: <CAAFQd5DD-x+SA9d406AcXSEvNmqmex2CFmdnbst7vzxssVXo3g@mail.gmail.com>
References: <1500433978-2350-1-git-send-email-yong.zhi@intel.com>
	<CAK8P3a0Muca-NB0+yuotTHEixhx8jG9Dytsd_wE9=SfNdGSGBg@mail.gmail.com>
	<20170720220904.icclurhemtkk7sx7@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170720220904.icclurhemtkk7sx7-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Yang, Hyungwoo" <hyungwoo.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hu, Jerry W" <jerry.w.hu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zheng,
	Jian Xu" <jian.xu.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Mani, Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yong Zhi <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 21, 2017 at 7:09 AM, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org> wrote:
> Hi Arnd,
>
> On Wed, Jul 19, 2017 at 09:24:41AM +0200, Arnd Bergmann wrote:
>> On Wed, Jul 19, 2017 at 5:12 AM, Yong Zhi <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> > From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> >
>> > This patch adds support for the IPU3 DMA mapping API.
>> >
>> > Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> > Signed-off-by: Yong Zhi <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>
>> This needs some explanation on why you decided to go down the
>> route of adding your own dma_map_ops. It's not obvious at all,
>> and and I'm still concerned that this complicates things more than
>> it helps.
>
> There are a few considerations here --- they could be documented in the
> patch commit message
>
> - The device has its own MMU. The default x86 DMA ops assume there isn't.
>
> - As this is an image signal processor device, the buffers are typically
>   large (often in the range of tens of MB) and they do not need to be
>   physically contiguous. The current implementation of e.g.
>   drivers/iommu/intel-iommu.c allocate memory using alloc_pages() which is
>   unfeasible for such single allocations. Neither CMA is needed.
>
>   Also other IOMMU implementations have their own DMA ops currently.
>
> I agree it'd be nice to unify these in the long run but I don't think this
> stands apart from the rest currently --- except that the MMU is only used
> by a single PCI device, the same which it is contained in.

On top of what Sakari said, it just perfectly matches what V4L2
videobuf2 framework expects. It does all the buffer mapping and
synchronization using DMA mapping and given the x86 DMA ops being
useless for this device, it makes everything that videobuf2 does using
them useless too.

Best regards,
Tomasz
