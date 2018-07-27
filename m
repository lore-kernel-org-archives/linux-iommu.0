From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Subject: Re: MSI B350M MORTAR: `AMD-Vi: Unable to write to IOMMU perf
 counter.` and `pci 0000:00:00.2: can't derive routing for PCI INT A`
Date: Fri, 27 Jul 2018 12:27:10 +0200
Message-ID: <20180727102710.GA6738@8bytes.org>
References: <605ca165-0071-eb7f-4c0d-b1e76ddd0e05@molgen.mpg.de>
 <20180720123153.GC18541@8bytes.org>
 <d2c5ee4a-e72b-672e-ae30-7b3cd5a43c63@molgen.mpg.de>
 <20180727082754.hk44xktdydduu3qo@8bytes.org>
 <92922faa-164d-002b-9a5e-1865a57f1bdb@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <92922faa-164d-002b-9a5e-1865a57f1bdb@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel+linux-iommu@molgen.mpg.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 27, 2018 at 11:18:56AM +0200, Paul Menzel wrote:
> On the AMD site [1] I see the three family 0x17 documents below.
> 
> 1.  Open-Source Register Reference for AMD Family 17h Processors (PUB)
> 2.  Processor Programming Reference (PPR) for AMD Family 17h Models 00h-0Fh Processors (PUB)
> 3.  Software Optimization Guide for AMD Family 17h Processors (PUB)
> 
> What documented is required? The BKDG?

IIRC the PPR is the new BKDG, but the public version does not seem to
contain any references about how the IOMMU needs to be set up by
firmware.


Thanks,

	Joerg
