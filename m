From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: bind pasid table API
Date: Thu, 28 Sep 2017 10:11:21 -0700
Message-ID: <20170928171121.GA101520@otc-nc-03>
References: <20170918204516.2f6beffb@jacob-builder>
	<6ecc1afc-6302-cd22-6944-ef4c6ac09587@arm.com>
	<20170927134041.GN8398@8bytes.org>
	<e23f7d00-90f2-e5d4-6619-9fe9150a96b9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e23f7d00-90f2-e5d4-6619-9fe9150a96b9-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jean

On Thu, Sep 28, 2017 at 12:21:34PM +0100, Jean-Philippe Brucker wrote:
> On 27/09/17 14:40, Joerg Roedel wrote:
> > Hi,
> > 
> > On Wed, Sep 20, 2017 at 01:09:47PM +0100, Jean-Philippe Brucker wrote:
> >> For binding page tables instead of PASID tables (e.g. virtio-iommu), the
> >> generic data would be:
> >>
> >> struct pgtable_info {
> >> 	__u32	pasid;
> >> 	__u64	ptr;
> >> 	__u32	model;
> >> 	__u8	model_data[];
> >> };
> > 
> > I had a look again and at the AMD side there is no way to build a shadow
> > pasid-table when more than 9-bit pasids are used, because all pointers
> > in that multi-level table are GPA and thus translated.
> 
> It's the same problem on SMMUv3, all pointers in the multi-level PASID
> tables are GPAs. Our solution was to grab chunks GPA space from the guest
> when necessary.

If pasid table is gPA and built and managed by guest IOMMU driver in case of
vIOMMU, or virtio-iommu. Is this complex interaction to reserve memory and
setup required? wouldn't it be sufficient if we do this.

- Host advertises the capability in terms of what table format it it supports.
- guest does all the memory allocation and management.
- communicate to host via VFIO, gPA, format, size of table
- host now programs context entries appropriately with proper nested mode



> 
> The host would maintain the PASID tables just like with native SVM. The
> difference is that they are stored in guest memory. In more details, it
> would go like this:
> 
> (1) host tells the guest the size of a memreserve (greatest size between
>     all levels) and what pgtable format the host iommu supports.
> (2) guest sends a memreserve request, giving up some of its GPA space for
>     the host. There already are physical pages allocated for it since the
>     GPA->PA mappings were created by the host with VFIO_MAP_DMA before
>     booting the guest.
> (3) guest sends a add_table request, asking to bind a pgd to a PASID
> (4) the host installs the first-level PASID table. Instead of allocating
>     it with kzalloc, it uses vmap on the existing memreserve pages.
> (5) The host doesn't have any memreserve left for the second level so it
>     returns an error code for add_table, asking the guest for more
>     memreserve.
> (5) guest sends another memreserve request
> (6) guest sends the add_table request again, which succeeds
> (7) host installs the second-level PASID table
> (8) When the guest removes the page tables, it can ask to reclaim the
>     memreserve
> 
> I know it's not particularly graceful, but it isn't too difficult to
> implement and there are a few reasons that make us prefer page table
> binding over PASID table binding for virtio-iommu:
> 
> * It also enables nested mode for IOMMUs that don't support PASIDs (but do
>   support two translation stages), like the SMMUv2. They would require an
>   add_table mechanism anyway.
> 
> * For a little more effort on the host side (handling memreserve pool), it
>   removes a great deal of work in guests. We wouldn't have to factor all
>   PASID code into a library in guests (currently battling with SMMUv3
>   support for PASID, and struggling to move a little bit of PASID code
>   into the core, I'd prefer this to be last resort...)
> 
>   The host driver already has code to manipulate PASID table entries in
>   the right place, so hopefully it'd be less work doing it in the host.
> 
> * Even if we decide to bind PASID tables we'll still have to tell the
>   guest what page table format it can use, since in SMMUv3 we have a lot
>   of fields and knobs in the PASID descriptor itself, it's not just a PGD
>   pointer :/
> 
>   So the probe step is necessary. Supporting PASID tables adds an
>   additional level of complexity to the device specification
> 
> So I'd like to try this solution first, since it seems less invasive, more
> flexible and a lot of the code would be necessary for both solutions. Both
> are difficult to specify and implement, though, so it's hard to say which
> is best for the moment. It shouldn't be too hard to fall back to PASID
> table binding if page table binding proves too cumbersome.
> 
> Thanks,
> Jean
