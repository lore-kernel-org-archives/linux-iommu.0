From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Subject: Re: MSI B350M MORTAR: `AMD-Vi: Unable to write to IOMMU perf
 counter.` and `pci 0000:00:00.2: can't derive routing for PCI INT A`
Date: Fri, 20 Jul 2018 14:31:53 +0200
Message-ID: <20180720123153.GC18541@8bytes.org>
References: <605ca165-0071-eb7f-4c0d-b1e76ddd0e05@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <605ca165-0071-eb7f-4c0d-b1e76ddd0e05@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel+linux-iommu@molgen.mpg.de>
Cc: iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Paul,

On Tue, Jul 17, 2018 at 06:02:07PM +0200, Paul Menzel wrote:
> $ dmesg
> […]
> [    0.145696] calling  pci_iommu_init+0x0/0x3f @ 1
> [    0.145719] AMD-Vi: Unable to write to IOMMU perf counter.

This is likely a firmware issue. Either the IVRS ACPI table is incorrect
or the BIOS did not enable the performance counter feature in the IOMMU
hardware. Are you running on the latest BIOS?


	Joerg
