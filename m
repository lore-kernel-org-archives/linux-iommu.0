From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Feature Request: Ability to decode bus/dma address back into
	physical address
Date: Wed, 2 Aug 2017 12:43:43 -0400
Message-ID: <20170802164343.GA3105@gmail.com>
References: <20170801180415.GB3443@gmail.com>
	<483ecda0-2977-d2ea-794c-320e429d7645@amd.com>
	<20170801190259.GC3443@gmail.com>
	<42c5fe2b-f179-cb71-03d3-7ae991543edb@amd.com>
	<20170801195556.GD3443@gmail.com>
	<77e557d2-aa75-46c4-88a7-cca5448ea08e@amd.com>
	<20170801210105.GE3443@gmail.com>
	<2cd345ee-d5ad-1ad7-508a-86225e65621c@amd.com>
	<20170802044214.GA6285@gmail.com>
	<4a2b004b-ebc2-9331-84c4-4e6672dd7b97@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4a2b004b-ebc2-9331-84c4-4e6672dd7b97-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, "Deucher,
	Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 02, 2017 at 10:26:40AM +0200, Christian K=F6nig wrote:
> Hi Jerome,
> =

> sorry for being a bit late to the discussion and the top posting.
> =

> But I think you miss a very important point here, which makes the whole
> discussion on how to implement completely superfluous:
> =

> We already have a functionality to access the content of BOs in a process
> for debugging purpose which works similar as you described and just uses =
the
> BO housekeeping structures in the driver to access the pages and VRAM
> locations in question.
> =

> See here for the implementation:
> 1. drm/ttm: Implement vm_operations_struct.access v2
> (http://www.spinics.net/lists/dri-devel/msg147302.html)
> 2. drm/amdgpu: Implement ttm_bo_driver.access_memory callback v2
> (http://www.spinics.net/lists/dri-devel/msg147303.html)
> =

> Those patches allow you to just attach gdb to a process and access the
> content of every CPU mapped buffer, even when that buffer is in CPU
> invisible VRAM.
> =

> So the primary goal of that effort is *NOT* to make the BO content
> accessible to the debugger through the BO housekeeping, cause that's
> something we already have.
> =

> The goal here is to walk the different page tables and hardware mapping
> functionalities to access the data just in the same way the GPU would do =
to
> catch problems.
> =

> That works fine as long as IOMMU is disabled, but when it is enabled the
> additional mapping breaks our neck and we don't knew if the stuff the page
> table dumper is producing is correct or not.
> =

> So what we need is just a way to translate dma addresses back to struct
> pages to check their validity.
> =

> I've considered to just add this information to amdgpu_gem_info, but then=
 we
> get page->dma-address mapping instead dma-address->page as we want.
> =


So to summarize you are saying you do not trust the value you get from
pci_map_page() ?

If not then i stress again that you have all the informations you need
inside the amdgpu driver. You can take the same scheme i propose to
dump ttm.dma_address[] and compare against content of GPU page table.

J=E9r=F4me
