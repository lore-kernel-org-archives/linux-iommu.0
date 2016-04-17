From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: Re: [PATCH v2 7/7] iommu: introduce per-cpu caching to iova allocation
Date: Sun, 17 Apr 2016 21:05:33 +0300
Message-ID: <CAHMfzJk6fd_CZ3N0vLKUGQS3SXpka05dhjt56R3kPGi3f4Q5vw@mail.gmail.com>
References: <cover.1460548546.git.mad@cs.technion.ac.il>
	<b208a304d83088aae7ecac10a3062dc57c0a2f79.1460548546.git.mad@cs.technion.ac.il>
	<CAN+hb0W=+tuQp3cm_VKoU=LKiVQDPMtGrZGq=59rcaWsy2S-+A@mail.gmail.com>
	<CAHMfzJmjZWeUpmTVb-Z7NMJUp0N84ZK4zwUWdAKHv4sd4TXPMg@mail.gmail.com>
	<CAN+hb0WOaokFYc6C+mR6rdj4WwmMUSzDHDZngfUvy-5cEve_-g@mail.gmail.com>
	<20160414213326.GA474260@devbig084.prn1.facebook.com>
	<CAN+hb0WRDYCpY8xoUvvGu4SSD83F9VTMW=9W=xfjYtJV-dijmQ@mail.gmail.com>
	<20160415175520.GA2644484@devbig084.prn1.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160415175520.GA2644484-tb7CFzD8y5b7E6g3fPdp/g2O0Ztt9esIQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Cc: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Godfrey van der Linden <gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 15, 2016 at 8:55 PM, Shaohua Li <shli-b10kYP2dOMg@public.gmane.org> wrote:

> Fair enough, it makes sense to ignore the DAC overhead. My point is the
> cache case should respect the limit, since devices might not be able to
> handle DMA64. Even without IOMMU, we use GFP_DMA32 or swiotlb to
> guarantee DMA address is in range.

Absolutely, the cache should respect the limit.  That'll be fixed in
the next version; sorry I forgot to do it in this revision.

> For the 'force DMA32' logic in
> intel-iommu, it's in the code in day one, but I can't remember the
> reason. My guess is it's to workaround driver/device bugs. I'd suggest
> just deleting the logic and let cache only handle DMA64.

Having looked at this further, DMA64 limits get cut down to the max
address the IOMMU supports (in intel_alloc_iova()).  In principle,
DMA32 (or close to it) might end up as the limit even for DMA64.  So
it seems cleaner to just flush the rcache if we can't allocate; that
takes care of everything.
