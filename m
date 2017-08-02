From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Feature Request: Ability to decode bus/dma address back into
	physical address
Date: Wed, 2 Aug 2017 13:33:11 -0400
Message-ID: <20170802173311.GC3105@gmail.com>
References: <20170801195556.GD3443@gmail.com>
	<77e557d2-aa75-46c4-88a7-cca5448ea08e@amd.com>
	<20170801210105.GE3443@gmail.com>
	<2cd345ee-d5ad-1ad7-508a-86225e65621c@amd.com>
	<20170802044214.GA6285@gmail.com>
	<4a2b004b-ebc2-9331-84c4-4e6672dd7b97@amd.com>
	<20170802164343.GA3105@gmail.com>
	<5ecbb5c2-fe4e-fd84-43b5-67ae06c5a032@amd.com>
	<20170802171303.GB3105@gmail.com>
	<d4a6ad38-522c-2928-2ef1-1f7cd2267c4e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d4a6ad38-522c-2928-2ef1-1f7cd2267c4e-5C7GfCeVMHo@public.gmane.org>
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

On Wed, Aug 02, 2017 at 07:23:58PM +0200, Christian K=F6nig wrote:
> Am 02.08.2017 um 19:13 schrieb Jerome Glisse:
> > On Wed, Aug 02, 2017 at 07:05:11PM +0200, Christian K=F6nig wrote:
> > > Am 02.08.2017 um 18:43 schrieb Jerome Glisse:
> > > > On Wed, Aug 02, 2017 at 10:26:40AM +0200, Christian K=F6nig wrote:
> > > > > [SNIP]
> > > > So to summarize you are saying you do not trust the value you get f=
rom
> > > > pci_map_page() ?
> > > Well, what we don't trust is that we actually get this value correctl=
y into
> > > our page tables.
> > > =

> > > > If not then i stress again that you have all the informations you n=
eed
> > > > inside the amdgpu driver. You can take the same scheme i propose to
> > > > dump ttm.dma_address[] and compare against content of GPU page tabl=
e.
> > > Yes, exactly. But then again we have the mapping page to dma-address
> > > (because that is what drivers usually need), but what we need for deb=
ugging
> > > is a map with the info dma-address to page.
> > Why would you need the reverse ? You have a GPU virtual address do the =
following:
> > GPU vaddr -> GPU page table entrie -> bus address
> > GPU vaddr -> bo_va_mapping -> bo_va -> bo -> page -> dma/bus address
> =

> First of all the VM housekeeping structures keep the state as it is suppo=
sed
> to be on the next command submission and so the top of the pipeline, but =
the
> state of the page tables represent to bottom of the pipeline.
> =

> Second you can't access the BO from it's virtual address, the BO mapping =
is
> protected by the BO reservation lock. So when I want to lockup the BO I
> would need to lock the BO first - chicken and egg problem. That is of cou=
rse
> solvable, but not something I would really like to do for a debugging
> feature.

Tom said that the GPU is stop and thus there is nothing happening to the vm
nor any of the bo right ? So there is no need to protect anything. If you
still allow thing to change vm (map/unmap bo ...) how do you expect to debu=
g ?

J=E9r=F4me
