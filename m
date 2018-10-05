From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
Date: Fri, 5 Oct 2018 10:55:32 +0530
Message-ID: <CAFp+6iERHTqwurj0y4PVkmVEdSZHqEVUqsgy-ry-ua7-_XAVRg@mail.gmail.com>
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
	<20180615165232.GE2202@arm.com>
	<CAFp+6iFm29ufb2Pr7Gb-2O_aN3GQLH4rcyWhbQGZ3QiwCC8vPg@mail.gmail.com>
	<20180627163749.GA8729@arm.com>
	<CAFp+6iFNhk7xZRHp0hNb2S7Cdn3muvsWqTEX-vjPGmxM8TNM9A@mail.gmail.com>
	<20180928131935.GE1577@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180928131935.GE1577@brain-police>
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
Cc: pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>,
	" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Fri, Sep 28, 2018 at 6:49 PM Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>
> Hi Vivek,
>
> On Thu, Sep 20, 2018 at 05:11:53PM +0530, Vivek Gautam wrote:
> > On Wed, Jun 27, 2018 at 10:07 PM Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > > On Tue, Jun 19, 2018 at 02:04:44PM +0530, Vivek Gautam wrote:
> > > > On Fri, Jun 15, 2018 at 10:22 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > > > > On Fri, Jun 15, 2018 at 04:23:29PM +0530, Vivek Gautam wrote:
> > > > >> Qualcomm SoCs have an additional level of cache called as
> > > > >> System cache or Last level cache[1]. This cache sits right
> > > > >> before the DDR, and is tightly coupled with the memory
> > > > >> controller.
> > > > >> The cache is available to all the clients present in the
> > > > >> SoC system. The clients request their slices from this system
> > > > >> cache, make it active, and can then start using it. For these
> > > > >> clients with smmu, to start using the system cache for
> > > > >> dma buffers and related page tables [2], few of the memory
> > > > >> attributes need to be set accordingly.
> > > > >> This change makes the related memory Outer-Shareable, and
> > > > >> updates the MAIR with necessary protection.
> > > > >>
> > > > >> The MAIR attribute requirements are:
> > > > >>     Inner Cacheablity = 0
> > > > >>     Outer Cacheablity = 1, Write-Back Write Allocate
> > > > >>     Outer Shareablity = 1
> > > > >
> > > > > Hmm, so is this cache coherent with the CPU or not?
> > > >
> > > > Thanks for reviewing.
> > > > Yes, this LLC is cache coherent with CPU, so we mark for Outer-cacheable.
> > > > The different masters such as GPU as able to allocated and activate a slice
> > > > in this Last Level Cache.
> > >
> > > What I mean is, for example, if the CPU writes some data using Normal, Inner
> > > Shareable, Inner/Outer Cacheable, Inner/Outer Write-back, Non-transient
> > > Read/Write-allocate and a device reads that data using your MAIR encoding
> > > above, is the device guaranteed to see the CPU writes after the CPU has
> > > executed a DSB instruction?
> >
> > No, these MAIR configurations don't guarantee that devices will have
> > coherent view
> > of what CPU writes. Not all devices can snoop into CPU caches (only IO-Coherent
> > devices can).
> > So a normal cached memory configuration in CPU MMU tables, and SMMU page tables
> > is valid only for few devices that are IO-coherent.
> >
> > Moreover, CPU can lookup in system cache, and so do all devices;
> > allocation will depend on h/w configurations and memory attributes.
> > So anything that CPU caches in system cache will be coherently visible
> > to devices.
> >
> > >
> > > I don't think so, because the ARM ARM would say that there's a mismatch on
> > > the Inner Cacheability attribute.
> > >
> > > > > Why don't normal
> > > > > non-cacheable mappings allocated in the LLC by default?
> > > >
> > > > Sorry, I couldn't fully understand your question here.
> > > > Few of the masters on qcom socs are not io-coherent, so for them
> > > > the IC has to be marked as 0.
> > >
> > > By IC you mean Inner Cacheability? In your MAIR encoding above, it is zero
> > > so I don't understand the problem. What goes wrong if non-coherent devices
> > > use your MAIR encoding for their DMA buffers?
> > >
> > > > But they are able to use the LLC with OC marked as 1.
> > >
> > > The issue here is that whatever attributes we put in the SMMU need to align
> > > with the attributes used by the CPU in order to avoid introducing mismatched
> > > aliases.
> >
> > Not really, right?
> > Devices can use Inner non-Cacheable, Outer-cacheable (IC=0, OC=1) to allocate
> > into the system cache (as these devices don't want to allocate in
> > their inner caches),
> > and the CPU will have a coherent view of these buffers/page-tables.
> > This should be
> > a normal cached non-IO-Coherent memory.
> >
> > But anything that CPU writes using Normal, Inner Shareable,
> > Inner/Outer Cacheable,
> > Inner/Outer Write-back, Non-transient Read/Write-allocate, may not be visible
> > to the device.
> >
> > Also added Jordan, and Pratik to this thread.
>
> Sorry, but I'm still completely confused.
>
> If you only end up with mismatched memory attributes in the non-coherent
> case, then why can't you just follow my suggestion to override the
> attributes for non-coherent mappings on your SoC?

As seen in downstream kernels there are few non-coherent devices which
would not want to allocate in system cache, and therefore would want
Inner/Outer non-cached memory.
So, we may want to either override the attributes per-device, or as
you suggested
we may want to introduce another memory type 'sys-cached' that can be
added with its separate infra.
Thanks.

[...]

Best regards
Vivek


--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
