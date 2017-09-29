From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: bind pasid table API
Date: Fri, 29 Sep 2017 17:30:22 +0200
Message-ID: <20170929153022.GU8398@8bytes.org>
References: <20170918204516.2f6beffb@jacob-builder>
	<6ecc1afc-6302-cd22-6944-ef4c6ac09587@arm.com>
	<20170927134041.GN8398@8bytes.org>
	<e23f7d00-90f2-e5d4-6619-9fe9150a96b9@arm.com>
	<20170928171121.GA101520@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170928171121.GA101520@otc-nc-03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 28, 2017 at 10:11:21AM -0700, Raj, Ashok wrote:
> Hi Jean
> 
> On Thu, Sep 28, 2017 at 12:21:34PM +0100, Jean-Philippe Brucker wrote:
> > It's the same problem on SMMUv3, all pointers in the multi-level PASID
> > tables are GPAs. Our solution was to grab chunks GPA space from the guest
> > when necessary.
> 
> If pasid table is gPA and built and managed by guest IOMMU driver in case of
> vIOMMU, or virtio-iommu. Is this complex interaction to reserve memory and
> setup required? wouldn't it be sufficient if we do this.
> 
> - Host advertises the capability in terms of what table format it it supports.
> - guest does all the memory allocation and management.
> - communicate to host via VFIO, gPA, format, size of table
> - host now programs context entries appropriately with proper nested mode

Yes, I think this is simpler than introducing a new memreserve API. The
code to build the pasid-tables is mostly there already, it just needs
some refactoring to make it usable for viommu.

The memreserve approach also implicates that the host can not trust the
pasid tables it builds and need to re-verify them on every change
because it is still accessible by the guest. We could write-protect the
table or unmap it from the guest, but it would still be accessible by
DMA. I think its tricky to get this right.


Regards,

	Joerg
