From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
Date: Tue, 24 Jan 2012 13:07:40 +0100
Message-ID: <20120124.140740.446867797082060957.hdoyu@nvidia.com>
References: <20120124110444.GB19255@amd.com><20120124.133614.1646093482547685131.hdoyu@nvidia.com><20120124115723.GC19255@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120124115723.GC19255-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-mm-sig-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
Date: Tue, 24 Jan 2012 12:57:23 +0100
Message-ID: <20120124115723.GC19255-5C7GfCeVMHo@public.gmane.org>

> On Tue, Jan 24, 2012 at 12:36:14PM +0100, Hiroshi Doyu wrote:
> > > A domain is, as you said, a virtual address space for IO devices. But
> > > the important point is, an arbitrary number of devices can be part of a
> > > domain. This also means that the devices can be behind different
> > > hardware SMMUs. In this case your driver needs to program the page-table
> > > pointer into more than one SMMU to give devices behind different SMMUs
> > > the same address space.
> > 
> > Thank you for explaining.
> > 
> > Does the above mean that a buffer can be shared with different devices
> > which belong to different IOMMU devices(virtual address spaces)?
> > 
> > For example, assuming the following:
> > 
> > - We have "struct iommu_domain *domain1".
> > - "domain1" has iommu device "iommu_dev1" and "iommu_dev2".
> > - "iommu_dev1" has "client_dev1" and "client_dev2".
> > - "iommu_dev2" has "client_dev3" and "client_dev4".
> > 
> > "iommu_map(domain1, iova, pa, ...)" will create the following mapping
> > ___at once___:
> > 
> > - (iova)-(pa) mapping in iommu_dev1(iommmu_dev1's virtual address space)
> > - (iova)-(pa) mapping in iommu_dev2(iommmu_dev2's virtual address space)
> > 
> > Is the above correct?
> 
> Yes, this is correct.
> 
> > It seems that the same (iova) is used for different virtual address
> > spaces. What kind of case is this beneficial most in?
> 
> It is actually the _same_ virtual address space which is used by
> iommu_dev1 and iommu_dev2. Think of it like multiple threads of a single
> process. They also share the address space.

I see. The above makes more sense.

> This is a requirement of the iommu-api which is beneficial for
> virtualization and simplifies the usage of the api in general. The user
> does not need to care which devices can be assigned to which domain
> because of underlying hardware constraints. The goal of the iommu-api is
> to hide such contraints.

Now it's clear to me. I'll send the update patch soon.
Thank you for explaining all of this.

> 
> 
> 	Joerg
> 
> -- 
> AMD Operating System Research Center
> 
> Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
> General Managers: Alberto Bozzo
> Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
> 
