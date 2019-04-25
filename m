From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
Date: Thu, 25 Apr 2019 16:01:56 -0700
Message-ID: <20190425160156.4f5decaa@jacob-builder>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-10-git-send-email-jacob.jun.pan@linux.intel.com>
	<143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
	<A2975661238FB949B60364EF0F2C257439E840F5@SHSMSX104.ccr.corp.intel.com>
	<c847182b-6e5c-5344-a162-29e273a489fb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c847182b-6e5c-5344-a162-29e273a489fb-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andriy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 25 Apr 2019 09:40:31 +0200
Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi Liu,
> 
> On 4/25/19 9:12 AM, Liu, Yi L wrote:
> > Hi Eric,
> >   
> >> From: Auger Eric [mailto:eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> >> Sent: Thursday, April 25, 2019 1:28 AM
> >> To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>;
> >> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Subject: Re: [PATCH v2 09/19]
> >> iommu/vt-d: Enlightened PASID allocation
> >>
> >> Hi Jacob,
> >>
> >> On 4/24/19 1:31 AM, Jacob Pan wrote:  
> >>> From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >>>
> >>> If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
> >>> IOMMU driver should rely on the emulation software to allocate
> >>> and free PASID IDs.  
> >> Do we make the decision depending on the CM or depending on the
> >> VCCAP_REG?
> >>
> >> VCCAP_REG description says:
> >>
> >> If Set, software must use Virtual Command Register interface to
> >> allocate and free PASIDs.  
> > 
> > The answer is it depends on the ECAP.VCS and then the PASID
> > allocation bit in VCCAP_REG. But VCS bit implies the iommu is a
> > software implementation (vIOMMU) of vt-d architecture. Pls refer to
> > the descriptions of "Virtual Command Support" in vt-d 3.0 spec.
> > 
> > "Hardware implementations of this architecture report a value of 0
> > in this field. Software implementations (emulation) of this
> > architecture may report VCS=1."  
> 
> OK I understand. But strictly speaking a vIOMMU may not implement CM.
> But that's nitpicking ;-)
> 
CAP.CM (caching mode) and ECAP.VCS(virtual command support) are
separate. I think we are mixing the two here since both are sufficient
condition to indicate whether we are running in a guest.
> Thanks
> 
> Eric
> > 
> > Thanks,
> > Yi Liu
> >   

[Jacob Pan]
