From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 15/16] iommu: introduce page response function
Date: Mon, 4 Dec 2017 13:37:15 -0800
Message-ID: <20171204133715.50c45136@jacob-builder>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-16-git-send-email-jacob.jun.pan@linux.intel.com>
	<93661c1c-2d3b-295f-0b9d-52e50ea9e1d0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <93661c1c-2d3b-295f-0b9d-52e50ea9e1d0-5wv7dgnIgG8@public.gmane.org>
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
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 24 Nov 2017 12:03:50 +0000
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> On 17/11/17 18:55, Jacob Pan wrote:
> > When nested translation is turned on and guest owns the
> > first level page tables, device page request can be forwared
> > to the guest for handling faults. As the page response returns
> > by the guest, IOMMU driver on the host need to process the
> > response which informs the device and completes the page request
> > transaction.
> > 
> > This patch introduces generic API function for page response
> > passing from the guest or other in-kernel users. The definitions of
> > the generic data is based on PCI ATS specification not limited to
> > any vendor.>
> > Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/iommu/iommu.c | 14 ++++++++++++++
> >  include/linux/iommu.h | 42
> > ++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 56
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 97b7990..7aefb40 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1416,6 +1416,20 @@ int iommu_sva_invalidate(struct iommu_domain
> > *domain, }
> >  EXPORT_SYMBOL_GPL(iommu_sva_invalidate);
> >  
> > +int iommu_page_response(struct iommu_domain *domain, struct device
> > *dev,
> > +			struct page_response_msg *msg)  
> 
> I think it's simpler, both for IOMMU and device drivers, to pass the
> exact structure received in the fault handler back to the IOMMU
> driver, along with a separate response status. So maybe
> 
> int iommu_page_response(struct iommu_domain *domain, struct device
> *dev, struct iommu_fault_event *event, u32 response)
> 
> And then you'd just need to define the IOMMU_PAGE_RESPONSE_* values.
> 
Apologize for the late response,

I think the simpler interface works for in-kernel driver use case very
well. But in case of VFIO, the callback function does not turn around
send back page response. The page response comes from guest and qemu,
where they don;t keep track of the the prq event data.
> Thanks,
> Jean

[Jacob Pan]
