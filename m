From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
Date: Fri, 20 Apr 2018 16:42:51 -0700
Message-ID: <20180420164251.5245f822@jacob-builder>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180417131047.0a9c310f@w520.home>
	<AM4PR0802MB2369F739C91B630CA99B3D3BA3B40@AM4PR0802MB2369.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AM4PR0802MB2369F739C91B630CA99B3D3BA3B40-Gx+wUQKpQCVHkdfAM7dXeUdOKmgb957onBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 20 Apr 2018 19:25:34 +0100
Jean-Philippe Brucker <Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> On Tue, Apr 17, 2018 at 08:10:47PM +0100, Alex Williamson wrote:
> [...]
> > > +	/* Assign guest PASID table pointer and size order */
> > > +	ctx_lo = (pasidt_binfo->base_ptr & VTD_PAGE_MASK) |
> > > +		(pasidt_binfo->pasid_bits - MIN_NR_PASID_BITS);  
> > 
> > Where does this IOMMU API interface define that base_ptr is 4K
> > aligned or the format of the PASID table?  Are these all
> > standardized or do they vary by host IOMMU?  If they're standards,
> > maybe we could note that and the spec which defines them when we
> > declare base_ptr.  If they're IOMMU specific then I don't
> > understand how we'll match a user provided PASID table to the
> > requirements and format of the host IOMMU. Thanks,  
> 
> On SMMUv3 the minimum alignment for base_ptr is 64 bytes, so a guest
> under a vSMMU might pass a pointer that's not aligned on 4k.
> 
PASID table pointer for VT-d is 4K aligned. 
> Maybe this information could be part of the data passed to userspace
> about IOMMU table formats and features? They're not part of this
> series, but I think we wanted to communicate IOMMU-specific features
> via sysfs.
> 
Agreed, I believe Yi Liu is working on a sysfs interface such that QEMU
can match IOMMU model and features.
