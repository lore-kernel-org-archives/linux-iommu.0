From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in
	prq_event_thread()
Date: Mon, 5 Nov 2018 07:08:52 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D5E057@SHSMSX104.ccr.corp.intel.com>
References: <20181105021858.16958-1-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439D5DF53@SHSMSX104.ccr.corp.intel.com>
	<f35802b2-124f-ff54-5be3-a1fb99b2b2c6@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f35802b2-124f-ff54-5be3-a1fb99b2b2c6-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Raj,
	Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Monday, November 5, 2018 1:45 PM
> To: Liu, Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>; David
> Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; Raj, Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Subject: Re: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in
> prq_event_thread()
> 
> Hi Yi,
> 
> On 11/5/18 1:21 PM, Liu, Yi L wrote:
> > Hi Baolu,
> >
> >> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> >> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Lu Baolu
> >> Sent: Monday, November 5, 2018 10:19 AM
> >> To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>; David Woodhouse
> >> <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> >> Cc: Raj, Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> >> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> >> Subject: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in
> >> prq_event_thread()
> >>
> >> When handling page request without pasid event, go to "no_pasid"
> >> branch instead of "bad_req". Otherwise, a NULL pointer deference will happen
> there.
> >>
> >> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >> Cc: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >> ---
> >>   drivers/iommu/intel-svm.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> >> index
> >> db301efe126d..887150907526 100644
> >> --- a/drivers/iommu/intel-svm.c
> >> +++ b/drivers/iommu/intel-svm.c
> >> @@ -595,7 +595,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
> >>   			pr_err("%s: Page request without PASID: %08llx %08llx\n",
> >>   			       iommu->name, ((unsigned long long *)req)[0],
> >>   			       ((unsigned long long *)req)[1]);
> >> -			goto bad_req;
> >> +			goto no_pasid;
> >>   		}
> >>
> >>   		if (!svm || svm->pasid != req->pasid) {
> >> --
> >
> > I'm afraid it is still necessary to goto "bad_req". The following code
> > behind "bad_req" will trigger fault_cb registered by in-kernel
> > drivers. It is reasonable that PRQ without PASID can be handled by
> > such callbacks. So I would suggest to keep the existing logic.
> 
> A page fault without a pasid is triggered by a DMA transfer without PASID. It doesn't
> relate to the SVM functionality hence there's no @svm or @sdev related to it. It's
> unnecessary to report it to the drivers as far as I can see.
 
Yeah, a PRQ without PASID has no corresponding svm or sdev structure. Regards to this
fact, it's acceptable for this fix. In long term, it might be helpful to refine the PRQ event
handler to cover PRQ without PASID. I guess Jacob's fault report framework may help.

+Jacob

Regards,
Yi Liu
