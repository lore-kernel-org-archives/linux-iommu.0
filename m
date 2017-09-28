From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: bind pasid table API
Date: Thu, 28 Sep 2017 14:07:05 +0200
Message-ID: <20170928120705.GR8398@8bytes.org>
References: <20170918204516.2f6beffb@jacob-builder>
	<6ecc1afc-6302-cd22-6944-ef4c6ac09587@arm.com>
	<20170927134041.GN8398@8bytes.org>
	<20170927105155.0dddbc2d@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170927105155.0dddbc2d@jacob-builder>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 27, 2017 at 10:51:55AM -0700, Jacob Pan wrote:
> On Wed, 27 Sep 2017 15:40:41 +0200
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > 	enum pasid_table_model {
> > 		PASID_TABLE_INTEL,
> > 		PASID_TABLE_ARM,
> > 		PASID_TABLE_AMD,
> > 		/* ... */
> > 	};
> > 
> I guess one vendor could have multiple pasid table format. so perhaps
> the name could reflect the format as well?

Yes, that makes sense.

> > 	struct pasid_table_config {
> > 		__u64 base_ptr;
> > 		__u8 pasid_bits;
> > 		union {
> > 			struct {
> > 				/* Intel specific fields */
> > 			} intel;
> > 
> > 			struct {
> > 				/* ARM specific fields */
> > 			} arm;
> > 
> > 
> > 			struct {
> > 				/* AMD specific fields */
> > 			} amd;
> > 
> > 			/* ... */
> > 		};
> > 	};
> > 
> > How does that look?
> > 
> It should work for us for now but I am not sure how stable the vendor
> specific fields will be, this is UAPI. BTW, do you also intend to
> include the pasid_table_model # in pasid_table_config?

If its going to be UAPI then we probably also need a version and a
length/size field. But since individual formats do not change, their
sub-struct should be stable.

Regards,

	Joerg
