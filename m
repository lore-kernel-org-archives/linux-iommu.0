From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] swiotlb: Fix inversed DMA_ATTR_NO_WARN test
Date: Fri, 25 May 2018 10:41:20 +0200
Message-ID: <20180525084120.GA19063@lst.de>
References: <20180501132411.2311-1-michel@daenzer.net>
	<786ca83f-45c4-264b-2aef-d84fb18d3d28@gmail.com>
	<CAKMK7uH2+v3_UUqXdCjz_8=H4VRt1zB+dgE99PuuPqd+XM2=-w@mail.gmail.com>
	<20180502124151.GA22857@lst.de>
	<1066dfa2-2f78-815d-c65a-9d09eb35458c@daenzer.net>
	<20180502162145.GA26787@lst.de>
	<ba310210-6f3c-f4e6-29e5-5ae6e791ebeb@daenzer.net>
	<1cbc4e10-96e6-c222-fb1a-fd7847be5755@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1cbc4e10-96e6-c222-fb1a-fd7847be5755-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, May 22, 2018 at 03:13:58PM +0200, Christian K=F6nig wrote:
> Am 02.05.2018 um 18:59 schrieb Michel D=E4nzer:
>> On 2018-05-02 06:21 PM, Christoph Hellwig wrote:
>>> On Wed, May 02, 2018 at 04:31:09PM +0200, Michel D=E4nzer wrote:
>>>>> No.  __GFP_NOWARN (and gfp_t flags in general) are the wrong interface
>>>>> for dma allocations and just cause problems.  I actually plan to
>>>>> get rid of the gfp_t argument in dma_alloc_attrs sooner, and only
>>>>> allow either GFP_KERNEL or GFP_DMA passed in dma_alloc_coherent.
>>>> How about GFP_TRANSHUGE_LIGHT? TTM uses that to opportunistically
>>>> allocate huge pages (GFP_TRANSHUGE can result in unacceptably long
>>>> delays with memory pressure).
>>> Well, that is exactly what I don't want drivers to do - same for
>>> __GFP_COMP in some drm code.  This very much assumes the page allocator
>>> is used to back dma allocations, which very often it actually isn't, and
>>> any use of magic gfp flags creates a tight coupling of consumers with a
>>> specific implementation.
>>>
>>> In general I can't think of a good reason not to actually use
>>> GFP_TRANSHUGE_LIGHT by default in the dma allocator unless
>>> DMA_ATTR_ALLOC_SINGLE_PAGES is set.  Can you prepare a patch for that?
>> I'm afraid I'll have to leave that to somebody else.
>
> Coming back to this topic once more, sorry for the delay but busy as usua=
l =

> :)
>
> What exactly do you mean with "dma allocator" here? The TTM allocator usi=
ng =

> the dma_alloc_coherent calls? Or the swiotlb implementation of the calls?

dma allocatr in this case: backends for dma_alloc_coherent/
dma_alloc_attrs.  Most importantly dma_direct_alloc.

But while we're at it I can't actually see any GFP_TRANSHUGE_LIGHT
usage in TTM, just plain old GFP_TRANSHUGE.
