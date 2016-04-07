From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Fix stream-match conflict with
	IOMMU_DOMAIN_DMA
Date: Thu, 7 Apr 2016 15:46:02 +0100
Message-ID: <20160407144601.GJ5657@arm.com>
References: <1459527597-10740-1-git-send-email-will.deacon@arm.com>
	<5702368D.6060706@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5702368D.6060706-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

On Mon, Apr 04, 2016 at 11:40:29AM +0200, Eric Auger wrote:
> On 04/01/2016 06:19 PM, Will Deacon wrote:
> > Commit cbf8277ef456 ("iommu/arm-smmu: Treat IOMMU_DOMAIN_DMA as bypass
> > for now") ignores requests to attach a device to the default domain
> > since, without IOMMU-basked DMA ops available everywhere, the default
> > domain will just lead to unexpected transaction faults being reported.
> > 
> > Unfortunately, the way this was implemented on SMMUv2 causes a
> > regression with VFIO PCI device passthrough under KVM on AMD Seattle.
> > On this system, the host controller device is associated with both a
> > pci_dev *and* a platform_device, and can therefore end up with duplicate
> > SMR entries, resulting in a stream-match conflict at runtime.
> > 
> > This patch amends the original fix so that attaching to IOMMU_DOMAIN_DMA
> > is rejected even before configuring the SMRs. This restores the old
> > behaviour for now, but we'll need to look at handing host controllers
> > specially when we come to supporting the default domain fully.
> 
> This works fine for me, before and after PCIe assignment. However before
> giving my T-b I would like to investigate another regression I observe
> wrt SRIOV assignment. Assigning the 1st VF works fine. However assigning
> a second VF does not work anymore (it used to in the past). I get
> -ENOSPC from arm_smmu_master_configure_smrs

Did you get anywhere debugging this?

Will
