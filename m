From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFCv2 PATCH 00/36] Process management for IOMMU + SVM for SMMUv3
Date: Mon, 5 Feb 2018 11:15:13 -0700
Message-ID: <20180205181513.GB878@jcrouse-lnx.qualcomm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
	<0c6778d8-741f-0db7-fe3c-df88a75ebbb2@huawei.com>
	<0fecd29e-eaf7-9503-b087-7bfbc251da88@arm.com>
	<c6b7fb4b-4f2b-0d81-8bb5-8fa6b62aca3a@huawei.com>
	<8a1e090d-22e8-0295-a53f-bc3b5b7d7971@arm.com>
	<20171012152803.GA3027@jcrouse-lnx.qualcomm.com>
	<8539601d-ef7a-8dd0-2fc7-51240c292678@arm.com>
	<20171025202015.GA6159@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171025202015.GA6159-9PYrDHPZ2Orvke4nUoYGnHL1okKdlPRT@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Bob Liu <liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 25, 2017 at 02:20:15PM -0600, Jordan Crouse wrote:
> On Mon, Oct 23, 2017 at 02:00:07PM +0100, Jean-Philippe Brucker wrote:
> > Hi Jordan,
> > 
> > [Lots of IOMMU people have been dropped from Cc, I've tried to add them back]
> > 
> > On 12/10/17 16:28, Jordan Crouse wrote:
> > > On Thu, Oct 12, 2017 at 01:55:32PM +0100, Jean-Philippe Brucker wrote:
> > >> On 12/10/17 13:05, Yisheng Xie wrote:
> > >> [...]
> > >>>>>> * An iommu_process can be bound to multiple domains, and a domain can have
> > >>>>>>   multiple iommu_process.
> > >>>>> when bind a task to device, can we create a single domain for it? I am thinking
> > >>>>> about process management without shared PT(for some device only support PASID
> > >>>>> without pri ability), it seems hard to expand if a domain have multiple iommu_process?
> > >>>>> Do you have any idea about this?
> > >>>>
> > >>>> A device always has to be in a domain, as far as I know. Not supporting
> > >>>> PRI forces you to pin down all user mappings (or just the ones you use for
> > >>>> DMA) but you should sill be able to share PT. Now if you don't support
> > >>>> shared PT either, but only PASID, then you'll have to use io-pgtable and a
> > >>>> new map/unmap API on an iommu_process. I don't understand your concern
> > >>>> though, how would the link between process and domains prevent this use-case?
> > >>>>
> > >>> So you mean that if an iommu_process bind to multiple devices it should create
> > >>> multiple io-pgtables? or just share the same io-pgtable?
> > >>
> > >> I don't know to be honest, I haven't thought much about the io-pgtable
> > >> case, I'm all about sharing the mm :)
> > >>
> > >> It really depends on what the user (GPU driver I assume) wants. I think
> > >> that if you're not sharing an mm with the device, then you're trying to
> > >> hide parts of the process to the device, so you'd also want the
> > >> flexibility of having different io-pgtables between devices. Different
> > >> devices accessing isolated parts of the process requires separate io-pgtables.
> > > 
> > > In our specific Snapdragon use case the GPU is the only entity that cares about
> > > process specific io-pgtables.  Everything else (display, video, camera) is happy
> > > using a global io-ptgable.  The reasoning is that the GPU is programmable from
> > > user space and can be easily used to copy data whereas the other use cases have
> > > mostly fixed functions.
> > > 
> > > Even if different devices did want to have a process specific io-pgtable I doubt
> > > we would share them.  Every device uses the IOMMU differently and the magic
> > > needed to share a io-pgtable between (for example) a GPU and a DSP would be
> > > prohibitively complicated.
> > > 
> > > Jordan
> > 
> > 
> > 
> > More context here:
> > https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg20368.html
> > 
> > So to summarize the Snapdragon case, if I understand correctly you need
> > two additional features:
> > 
> > (1) A way to create process address spaces, that are not bound to an mm
> > but to a separate io-pgtable. And a way to map/unmap these contexts.
> 
> Correct.
> 
> > (2) A way to obtain the PGD in order to program it into the GPU. And also
> > the ASID I suppose? What about TCR and MAIR?
> >
> PGD and ASID.  Not the TCR and MAIR, at least not in the current iteration.
> 
> > For (1), I can see some value in isolating process contexts with
> > io-pgtable without going all the way and sharing the mm. The IOVA=VA
> > use-case feels a bit weak. But it does provide better isolation than
> > dma_map/unmap, if the GPU is in charge of PASIDs then two processes that
> > execute code on the GPU cannot access each others' DMA buffers. Maybe
> > other users will want that feature (but they really should be using bind_mm!).
> 
> That is exactly the use case.  A real-world attach vector in the mobile GPU
> world is a malicious app that knows that knows that if have a banking app
> active and copies the surfaces or at the very least scribbles over everything
> and is very rude.
> 
> > In next version I'm going to replace iommu_process_bind by something like
> > iommu_sva_bind_mm, which reduces the scope of the API I'm introducing and
> > doesn't fit your case anymore. What you need is a shortcut into the PASID
> > allocator, a way to allocate a private PASID with io-pgtables instead of
> > one backed by an mm. Something like:
> > 
> > iommu_sva_alloc_pasid(domain, dev) -> pasid
> > iommu_sva_map(pasid, iova, size, flags)
> > iommu_sva_unmap(pasid, iova, size)
> > iommu_sva_free_pasid(domain, pasid)
> 
> Yep, that matches up with my thinking.
> 
> > Then for (2) the GPU is tightly integrated into the SMMU and can switch
> > contexts. I might be wrong but I don't see this case becoming standard as
> > new implementations move to PASIDs, we shouldn't spend too much time
> > making it generic.
> 
> Agreed. This is rather specific use case.
> 
> > But to make it fit into the PASID API, how about the following.
> 
> 
> > We provide a backdoor to the GPU driver, allowing it to register PASID ops
> > into SMMUv2 driver:
> > 
> > struct smmuv2_pasid_ops {
> > 	int (*install_pasid)(struct iommu_domain, int pasid, ttbr, asid
> > 			     and whatnot);
> > 	void (*remove_pasid)(struct iommu_domain, int pasid);
> > }
> > 
> > On PASID-capable IOMMUs, iommu_sva_alloc_pasid would install a context
> > descriptor into the PASID tables (owned by the IOMMU), pointing to the
> > io-pgtable. As SMMUv2 doesn't support PASID, iommu_sva_alloc_pasid
> > wouldn't actually install a context descriptor but instead call back into
> > the GPU driver with install_pasid. The GPU can then do its thing, call
> > sva_map/unmap, and switch contexts.
> > 
> > The good thing is that (1) and (2) are separate, so you get the same
> > callbacks if you're using iommu_sva_bind_mm instead of the private pasid
> > thing.
> 
> This sounds ideal. It seems to scratch all the right itches that we have. 
> 
> Thanks for thinking about this use case. I appreciate your time.
 
Hi Jean-Philippe -

Just a gentle nudge to see if there is any progress on this front. I know the
last 6 months have been busy with other far more serious panics but I wanted to
offer any help I could provide including testing on various qcom targets.

Regards,
Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
