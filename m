From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Mon, 22 Oct 2018 10:48:34 -0600
Message-ID: <20181022164834.GH26762@jcrouse-lnx.qualcomm.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181019181158.2395-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 19, 2018 at 07:11:52PM +0100, Jean-Philippe Brucker wrote:

> (2) Allocate a domain and attach it to the device.
> 
>       dom = iommu_domain_alloc()
>       iommu_attach_device(dom, dev)
> 
>     I still have concerns about this part, which are highlighted by the
>     messy changes of patch 1. I think it would make more sense to
>     introduce new attach/detach_dev_aux() functions instead of reusing
>     attach/detach_dev()
> 
>     Can we reconsider this and avoid unnecessary complications in IOMMU
>     core and drivers? Does the VFIO code greatly benefit from using the
>     same attach() function? It could as well use a different one for
>     devices in AUXD mode, which the mediating driver could tell by
>     adding a flag in mdev_set_iommu_device(), for example.
> 
>     And I don't think other users of AUXD would benefit from using the
>     same attach() function, since they will know whether they want to be
>     using main or auxiliary domain when doing attach().

I second this. For the arm-smmu-v2 multiple-pagetable model we would either need
new API functions or do something along the lines of 

dom = iommu_domain_alloc()
iommu_set_attr(dom, DOMAIN_ATTR_I_WANT_TO_BE_AUX)
iommu_attach_device(dom,dev)

Either that or do some some dummy device magic that I haven't started to work
out in my head. Having aux specific functions just for this step would make the
arm-smmu-v2 version work out much cleaner.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
