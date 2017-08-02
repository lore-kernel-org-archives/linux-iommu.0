From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Feature Request: Ability to decode bus/dma address back into
	physical address
Date: Wed, 2 Aug 2017 14:36:41 -0400
Message-ID: <20170802183641.GA4035@gmail.com>
References: <20170801210105.GE3443@gmail.com>
	<2cd345ee-d5ad-1ad7-508a-86225e65621c@amd.com>
	<20170802044214.GA6285@gmail.com>
	<4a2b004b-ebc2-9331-84c4-4e6672dd7b97@amd.com>
	<20170802164343.GA3105@gmail.com>
	<5ecbb5c2-fe4e-fd84-43b5-67ae06c5a032@amd.com>
	<20170802171303.GB3105@gmail.com>
	<d4a6ad38-522c-2928-2ef1-1f7cd2267c4e@amd.com>
	<20170802173311.GC3105@gmail.com>
	<4f00e033-7a08-e54f-4b64-2813d5f25b5b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4f00e033-7a08-e54f-4b64-2813d5f25b5b-5C7GfCeVMHo@public.gmane.org>
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

On Wed, Aug 02, 2017 at 08:18:02PM +0200, Christian K=F6nig wrote:
> Am 02.08.2017 um 19:33 schrieb Jerome Glisse:
> > On Wed, Aug 02, 2017 at 07:23:58PM +0200, Christian K=F6nig wrote:
> > > Am 02.08.2017 um 19:13 schrieb Jerome Glisse:
> > > > On Wed, Aug 02, 2017 at 07:05:11PM +0200, Christian K=F6nig wrote:
> > > > > Am 02.08.2017 um 18:43 schrieb Jerome Glisse:
> > > > > > On Wed, Aug 02, 2017 at 10:26:40AM +0200, Christian K=F6nig wro=
te:
> > > > > > > [SNIP]
> > > > > > So to summarize you are saying you do not trust the value you g=
et from
> > > > > > pci_map_page() ?
> > > > > Well, what we don't trust is that we actually get this value corr=
ectly into
> > > > > our page tables.
> > > > > =

> > > > > > If not then i stress again that you have all the informations y=
ou need
> > > > > > inside the amdgpu driver. You can take the same scheme i propos=
e to
> > > > > > dump ttm.dma_address[] and compare against content of GPU page =
table.
> > > > > Yes, exactly. But then again we have the mapping page to dma-addr=
ess
> > > > > (because that is what drivers usually need), but what we need for=
 debugging
> > > > > is a map with the info dma-address to page.
> > > > Why would you need the reverse ? You have a GPU virtual address do =
the following:
> > > > GPU vaddr -> GPU page table entrie -> bus address
> > > > GPU vaddr -> bo_va_mapping -> bo_va -> bo -> page -> dma/bus address
> > > First of all the VM housekeeping structures keep the state as it is s=
upposed
> > > to be on the next command submission and so the top of the pipeline, =
but the
> > > state of the page tables represent to bottom of the pipeline.
> > > =

> > > Second you can't access the BO from it's virtual address, the BO mapp=
ing is
> > > protected by the BO reservation lock. So when I want to lockup the BO=
 I
> > > would need to lock the BO first - chicken and egg problem. That is of=
 course
> > > solvable, but not something I would really like to do for a debugging
> > > feature.
> > Tom said that the GPU is stop and thus there is nothing happening to th=
e vm
> > nor any of the bo right ? So there is no need to protect anything. If y=
ou
> > still allow thing to change vm (map/unmap bo ...) how do you expect to =
debug ?
> =

> Well the GPU is stuck (or manually stopped), but keep in mind that this i=
s a
> very deep pipeline we are talking about here.
> =

> So even if there isn't any processing happening in the hardware any more
> there can still state changes queued up waiting for processing (or even n=
ew
> one added).
> =


I am familiar with how it all works. Vm are protected by fences so a
vm that is in use will be protected from bind/unbind if GPU is stop only
and update to virtual address space of that vm might also be block if
they were to happen through some GPU ring and not from CPU.

To me it looks like you want to know if GPU is accessing what was meant
to be access and i believe what i have outline allow that. Compare current
GPU page table entry with valid mapping.

Thus i do not see any value in trying to get bus -> page, especialy that
once you get the page you can't know to which bo it belongs without going
over all ttm tt objects and even then it might be an already "freed" page
from ttm point of view.

J=E9r=F4me
