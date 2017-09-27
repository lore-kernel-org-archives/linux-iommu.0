From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: bind pasid table API
Date: Wed, 27 Sep 2017 15:40:41 +0200
Message-ID: <20170927134041.GN8398@8bytes.org>
References: <20170918204516.2f6beffb@jacob-builder>
	<6ecc1afc-6302-cd22-6944-ef4c6ac09587@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6ecc1afc-6302-cd22-6944-ef4c6ac09587-5wv7dgnIgG8@public.gmane.org>
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

Hi,

On Wed, Sep 20, 2017 at 01:09:47PM +0100, Jean-Philippe Brucker wrote:
> For binding page tables instead of PASID tables (e.g. virtio-iommu), the
> generic data would be:
> 
> struct pgtable_info {
> 	__u32	pasid;
> 	__u64	ptr;
> 	__u32	model;
> 	__u8	model_data[];
> };

I had a look again and at the AMD side there is no way to build a shadow
pasid-table when more than 9-bit pasids are used, because all pointers
in that multi-level table are GPA and thus translated.

So how about allowing the virtio-iommu to build pasid-tables in
different formats? We can easily collect the existing code for that in
the Intel and AMD drivers into a library that could be used by the
virtio-iommu driver too. Then the virtio-iommu can create the correct
table for the host-iommu and we don't have to rely on shadowing.

For binding whole pasid tables, reading through the thread, it looks
like we can't get away with generic attributes that would fit everyone.
For AMD and Intel it would suffice to have a base-ptr and the
number of pasids-bits the table can map.

The Intel driver can then calculate the size of the table and the AMD
driver can compute the GLX value;

In case we need the model-specific info, I'd like to have them
explicitly stated in the struct:

	enum pasid_table_model {
		PASID_TABLE_INTEL,
		PASID_TABLE_ARM,
		PASID_TABLE_AMD,
		/* ... */
	};

	struct pasid_table_config {
		__u64 base_ptr;
		__u8 pasid_bits;
		union {
			struct {
				/* Intel specific fields */
			} intel;

			struct {
				/* ARM specific fields */
			} arm;


			struct {
				/* AMD specific fields */
			} amd;

			/* ... */
		};
	};

How does that look?

Regards,

	Joerg
