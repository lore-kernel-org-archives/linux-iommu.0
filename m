From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: bind pasid table API
Date: Fri, 29 Sep 2017 17:23:44 +0200
Message-ID: <20170929152344.GT8398@8bytes.org>
References: <20170918204516.2f6beffb@jacob-builder>
	<6ecc1afc-6302-cd22-6944-ef4c6ac09587@arm.com>
	<20170927134041.GN8398@8bytes.org>
	<20170927105155.0dddbc2d@jacob-builder>
	<20170928120705.GR8398@8bytes.org>
	<20170928143657.01ed2fa7@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170928143657.01ed2fa7@jacob-builder>
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

On Thu, Sep 28, 2017 at 02:36:57PM -0700, Jacob Pan wrote:
> just to confirm, we have two separate APIs for bind_pasid_table_ptr and
> bind_page_table. For the former, we need to passdown the following info
> from qemu/vfio. For now
> struct pasid_table_config {
> 	__u32 version;
> #define PASID_TABLE_CONFIG_VERSION_1 (1)
> 	__u32 bytes;
> 	__u64 base_ptr;
> 	__u8 pasid_bits;
> 	enum pasid_table_model model;
> 	union {
> 		struct {
> 			/* Intel specific fields */
> 		} intel;
> 
> 		struct {
> 			/* ARM specific fields */
> 		} arm;
> 
> 		struct {
> 			/* AMD specific fields */
> 		} amd;
> 
> 		/* ... */
> 	};
> };

Yes, this looks good to me.


Regards,

	Joerg
