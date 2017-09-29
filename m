From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: bind pasid table API
Date: Fri, 29 Sep 2017 05:44:02 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190DEA654@SHSMSX101.ccr.corp.intel.com>
References: <20170918204516.2f6beffb@jacob-builder>
	<6ecc1afc-6302-cd22-6944-ef4c6ac09587@arm.com>
	<20170927134041.GN8398@8bytes.org>
	<e23f7d00-90f2-e5d4-6619-9fe9150a96b9@arm.com>
	<20170928171121.GA101520@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170928171121.GA101520@otc-nc-03>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Raj, Ashok
> Sent: Friday, September 29, 2017 1:11 AM
> 
> Hi Jean
> 
> On Thu, Sep 28, 2017 at 12:21:34PM +0100, Jean-Philippe Brucker wrote:
> > On 27/09/17 14:40, Joerg Roedel wrote:
> > > Hi,
> > >
> > > On Wed, Sep 20, 2017 at 01:09:47PM +0100, Jean-Philippe Brucker
> wrote:
> > >> For binding page tables instead of PASID tables (e.g. virtio-iommu), the
> > >> generic data would be:
> > >>
> > >> struct pgtable_info {
> > >> 	__u32	pasid;
> > >> 	__u64	ptr;
> > >> 	__u32	model;
> > >> 	__u8	model_data[];
> > >> };
> > >
> > > I had a look again and at the AMD side there is no way to build a
> shadow
> > > pasid-table when more than 9-bit pasids are used, because all pointers
> > > in that multi-level table are GPA and thus translated.
> >
> > It's the same problem on SMMUv3, all pointers in the multi-level PASID
> > tables are GPAs. Our solution was to grab chunks GPA space from the
> guest
> > when necessary.
> 
> If pasid table is gPA and built and managed by guest IOMMU driver in case
> of
> vIOMMU, or virtio-iommu. Is this complex interaction to reserve memory
> and
> setup required? wouldn't it be sufficient if we do this.
> 
> - Host advertises the capability in terms of what table format it it supports.
> - guest does all the memory allocation and management.
> - communicate to host via VFIO, gPA, format, size of table
> - host now programs context entries appropriately with proper nested
> mode
> 

I can see the motivation why Jean would like to go this way. As he 
explained below, it doesn't require factoring PASID codes (all formats
on all vendors) into a library in guest. Guest just provides PGD and
host IOMMU driver has all the logic to build PASID table in right form.

However I'm with Ashok here. I'm not sure whether host-side change
is really less invasive. New memreserve APIs need to be introduced
cross Qemu/VFIO/IOMMU driver. Also PASID logic in each host IOMMU
driver needs change to cope with whether the table is built for a native 
usage or guest usage. In the latter case, memreserve must be considered 
which is not like a typical way of page table mgmt. (especially regarding 
to a multi-level PASID table).

Thinking about anyway we need to factor page table code in the
guest side. It's not a big deal to further factor PASID code due to the
same reason. Of course there are additional format info to be 
communicated back-and-forth, but the framework should be same
for both page table and PASID purposes. Also such change is restricted
within IOMMU sub-system. :-)

Thanks
Kevin
