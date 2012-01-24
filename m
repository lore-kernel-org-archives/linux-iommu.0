From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
Date: Tue, 24 Jan 2012 12:36:14 +0100
Message-ID: <20120124.133614.1646093482547685131.hdoyu@nvidia.com>
References: <20120123154310.GC6269@8bytes.org><20120124.115701.2179509760878976509.hdoyu@nvidia.com><20120124110444.GB19255@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120124110444.GB19255-5C7GfCeVMHo@public.gmane.org>
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

From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
Date: Tue, 24 Jan 2012 12:04:44 +0100
Message-ID: <20120124110444.GB19255-5C7GfCeVMHo@public.gmane.org>

> > > Hmm, this looks like there is a 1-1 mapping between hardware SMMU
> > > devices and domains. This is not consistent with IOMMU-API semantics
> > > where a domain can contain devices behind different SMMUs. Please fix
> > > that.
> > 
> > I'm a bit confused with the concept of "domain". I thought that
> > "domain" is equivalent to a "virtual address space". Usually a IOMMU
> > device provides a virtual address space for multiple client
> > devices. IOW, a IOMMU device provides a virtual address space, which
> > can be shared with multiple client devices.
> > 
> > Actually Tegra SMMU case, a single IOMMU device has 4 different
> > virtual address speace("smmu_as"). Each "smmu_as" has its own virtual
> > address space. "smmu_as[i]" has mutiple "smmu_client" devices.
> > 
> >   smmu_as[i] == domain[i]
> > 
> > I don't understand why "a domain can contain devices behind different
> > SMMUs" because those client devices belong to different virtual
> > address spaces, and they should belong to different "domains".
> > 
> > Could you please explain a bit more about "domain"?
> 
> A domain is, as you said, a virtual address space for IO devices. But
> the important point is, an arbitrary number of devices can be part of a
> domain. This also means that the devices can be behind different
> hardware SMMUs. In this case your driver needs to program the page-table
> pointer into more than one SMMU to give devices behind different SMMUs
> the same address space.

Thank you for explaining.

Does the above mean that a buffer can be shared with different devices
which belong to different IOMMU devices(virtual address spaces)?

For example, assuming the following:

- We have "struct iommu_domain *domain1".
- "domain1" has iommu device "iommu_dev1" and "iommu_dev2".
- "iommu_dev1" has "client_dev1" and "client_dev2".
- "iommu_dev2" has "client_dev3" and "client_dev4".

"iommu_map(domain1, iova, pa, ...)" will create the following mapping
___at once___:

- (iova)-(pa) mapping in iommu_dev1(iommmu_dev1's virtual address space)
- (iova)-(pa) mapping in iommu_dev2(iommmu_dev2's virtual address space)

Is the above correct?

It seems that the same (iova) is used for different virtual address
spaces. What kind of case is this beneficial most in?
