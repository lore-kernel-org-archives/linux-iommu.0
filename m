From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [Patch V2 1/4] iommu/vt-d: replace *hdr with hdr[0] in struct
	dmar_drhd_unit
Date: Sun, 20 Mar 2016 16:42:29 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603201631280.3978@nanos>
References: <1458482251-7939-1-git-send-email-richard.weiyang@gmail.com>
	<1458482251-7939-2-git-send-email-richard.weiyang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1458482251-7939-2-git-send-email-richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sun, 20 Mar 2016, Wei Yang wrote:

> hdr in struct dmar_drhd_unit is used to point the DMAR hardware unit copied
> at the end of struct dmar_drhd_unit. One zero-sized array may be more
> elegant for this purpose.

You forget to tell why. 
 
> This patch replace *hdr with hdr[0] in struct dmar_drhd_unit.
> 
> Besides this, this patch includes other two changes:
> 1. remove unnecessary type cast in dmar_table_detect()

Again. Why is it not necessary?

> 2. type cast from acpi_dmar_header to acpi_dmar_hardware_unit directly

Don't even think about doing that. container_of() is there for a reason.

Your change works today, because the embedded structure is the first one in
the containing structure. If the containing structure gets reordered later,
the whole thing will explode in hard to debug ways.

Even if such a reordering is unlikely in that ACPI case, we just don't do
that. It's bad and sloppy coding style. The generated code is the same.

Thanks,

	tglx
