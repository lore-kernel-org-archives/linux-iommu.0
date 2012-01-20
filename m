From: "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/5] IOMMU: Make IOMMU-API ready for GART-like hardware
Date: Fri, 20 Jan 2012 17:05:52 +0100
Message-ID: <20120120160552.GH2205@amd.com>
References: <1326983405-319-1-git-send-email-joerg.roedel@amd.com>
	<20120120.081403.2268989617582455160.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120120.081403.2268989617582455160.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org" <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Hiroshi.DOYU-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <Hiroshi.DOYU-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Fri, Jan 20, 2012 at 07:14:03AM +0100, Hiroshi Doyu wrote:
> From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 0/5] IOMMU: Make IOMMU-API ready for GART-like hardware
> Date: Thu, 19 Jan 2012 15:30:00 +0100
> Message-ID: <1326983405-319-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
> 
> > Hi,
> > 
> > this patch-set adds two new functions the the IOMMU-API:
> > 
> > 	* iommu_domain_set_attr()
> > 	* iommu_domain_get_attr()
> > 
> > These are generic functions to set and change attributes of a domain.
> > The plan is to have a set of generic attributes implemented by more than
> > one IOMMU driver as well as driver specific ones. As an example for the
> > first type this patch-set also implements the DOMAIN_ATTR_GEOMETRY
> > attribute. It can be used to query information about the address space
> > window that can be remapped by the iommu hardware. With this attribute
> > is is very easy to support IOMMUs like GART and friends.
> 
> For Tegra GART & SMMU, this info is passed from board files as
> resource data via "platform_get_resource(,IORESOURCE_MEM,)". I think
> that this could be the attachement patch in Tegra case. The attached
> patches are based on the following post.
> 
> https://lkml.org/lkml/2012/1/5/26
> https://lkml.org/lkml/2012/1/5/27

I will start merging new patches next week. These patches are on my
list. Once we have settled on a version of the patches in this thread I
also apply your posted addtion.


	Joerg



-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
