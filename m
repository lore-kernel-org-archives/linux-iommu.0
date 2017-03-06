From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 03/30] PCI: Move ATS declarations outside of CONFIG_PCI
Date: Mon, 6 Mar 2017 11:29:28 +0000
Message-ID: <20170306112928.GB28804@e106794-lin.localdomain>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
	<20170227195441.5170-4-jean-philippe.brucker@arm.com>
	<20170303210926.GB31767@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170303210926.GB31767-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Bjorn,

On 03/03/17 21:09, Bjorn Helgaas wrote:
> On Mon, Feb 27, 2017 at 07:54:14PM +0000, Jean-Philippe Brucker wrote:
>> Currently ATS helpers like pci_enable_ats are only defined when CONFIG_PCI
>> is enabled. The ARM SMMU driver might get built with CONFIG_PCI disabled.
>> It would thus have to wrap any use of ATS helpers around #ifdef
>> CONFIG_PCI, which isn't ideal.
>>
>> A nicer solution is to always define these helpers. Since CONFIG_PCI_ATS
>> is only enabled in association with CONFIG_PCI, move defines outside of
>> CONFIG_PCI to prevent build failure when PCI is disabled.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> 
> I don't think there's any reason to make a pci_ats_init() stub when
> CONFIG_PCI is not enabled, because it's only called from the PCI core.
> But it does make some sense to keep them all together in one place.
> 
> I think you could also remove the #ifdef CONFIG_PCI_ATS in
> arm_smmu_enable_ats() ("[RFC PATCH 04/30] iommu/arm-smmu-v3: Add
> support for PCI ATS"), right?
> 
> If you remove the #ifdef, we'll call pci_enable_ats(), and it will
> fail if !pdev->ats_cap.

I wanted to display something when ATS is supported and enable fails.
But this method is ugly and device drivers can check whether ATS is
enabled, so I'll remove the #ifdef and the error message in patch 4.

> Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

Thanks!
Jean-Philippe
