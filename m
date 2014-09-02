From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 0/7] Introduce automatic DMA configuration for IOMMU
	masters
Date: Tue, 02 Sep 2014 10:48:02 +0200
Message-ID: <54058442.2070204@samsung.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<540562F9.2030508@samsung.com> <20140902083138.GA25379@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20140902083138.GA25379-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 2014-09-02 10:31, Will Deacon wrote:
> On Tue, Sep 02, 2014 at 07:26:01AM +0100, Marek Szyprowski wrote:
>> On 2014-08-29 17:54, Will Deacon wrote:
>>> This patch series is an RFC to implement IOMMU master configuration into
>>> of_dma_configure. I haven't yet ported any IOMMU drivers to it, so it
>>> remains untested, but I wanted to get some early feedback to ensure that
>>> this doesn't end up going in the wrong direction.
>>>
>>> The idea comes out of my understanding following discussions with Arnd
>>> and David at Kernel Summit / LinuxCon in Chicago. Essentially:
>>>
>>>     - Allow IOMMUs to be probed early and set up per-instance data on their
>>>       of_node
>>>
>>>     - Add a new callback to the iommu_ops structure for adding a device
>>>       with a set of opaque IDs (e.g. Stream IDs or Requester IDs)
>>>
>>>     - Add an of_iommu_configure function, called from of_dma_configure,
>>>       which registers the master IDs with the correspond IOMMU before
>>>       probing the master itself
>>>
>>>     - Where applicable, create an IOMMU domain per device and swizzle the
>>>       DMA ops for that device to use the IOMMU variants.
>>>
>>> I haven't bothered doing anything clever with the DMA masks yet, so I
>>> wouldn't be surprised if we end up chewing through tonnes of memory
>>> allocating IOMMU domains that are far too big at the moment. Again, this
>>> is just an RFC and I'd welcome comments on the general direction of the
>>> series.
>> Thanks for your patches, I wasn't aware the fact that you are working on
>> this. When do you plan to send a second version? I would like to rebase
>> my Exynos IOMMU patches (https://lkml.org/lkml/2014/8/5/183) on top of
>> your work, but I wonder if I should select this version as a base or wait
>> a bit for an update.
> I'll try and get something out today/tomorrow depending on how easily the
> review comments fall out. It would be really great if you get an IOMMU
> working with this (I was going to look at the ARM SMMU once this stops
> moving)

Great, I will wait then for v2.

>   -- I have concerns that allocating one domain per master might be
> too much, but it's hard to tell without an IOMMU driver ported over.

One domain per master is IMHO a sane default configuration. The only default
alternative I see is to have only one domain (related with dma-mapping
subsystem) and bind all devices to it. However I really don't see any
disadvantage of having separate domain per each master and such 
configuration
gives devices better separation.

However we also need to figure out how to let drivers to make their own
configuration, like it is required by Exynos DRM subsystem, which consist
of several devices, each having its own IOMMU controller, but for
convenience those drivers assume that they all have been bound to the same,
single domain.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
