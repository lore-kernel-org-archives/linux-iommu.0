From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [RFC 0/9] IOMMU probe deferral support
Date: Fri, 13 May 2016 12:23:00 +0530
Message-ID: <000001d1ace4$1ac1e250$5045a6f0$@codeaurora.org>
References: <1461599894-1969-1-git-send-email-sricharan@codeaurora.org>
	<f192d4a0-9e13-4ae2-d3da-058e2e092634@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f192d4a0-9e13-4ae2-d3da-058e2e092634-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Marek Szyprowski' <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Marek Szyprowski
> Sent: Thursday, May 12, 2016 6:23 PM
> To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>; will.deacon-5wv7dgnIgG8@public.gmane.org;
> robin.murphy-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
> Subject: Re: [RFC 0/9] IOMMU probe deferral support
> 
> Hello,
> 
> 
> On 2016-04-25 17:58, Sricharan R wrote:
> > This is mostly a repost of the probe deferral series from Laurent
> > Pinchart [1]. Added a check to fix boot with ACPI.
> > Adapted arm-smmu driver to work with deferred probing and added a new
> > api for the below reason. This is based on the generic iommu binding
> > series from Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>.
> 
> Thanks for this patchset. I'm working on some serious rework in exynos
> power domains and clocks support code and it turned out that I need this
> feature to resolve probing order. It works fine on my internal tree, where
> some iommu controllers cannot get their clocks early enough.
> 
> Tested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
   Thanks for testing. So the issue that I was facing also was the same
where the iommu
   controllers cannot get clocks early. So waiting for some suggestions if
this is right/
   or there is another way for doing this probe deferral?

Regards,
 Sricharan
