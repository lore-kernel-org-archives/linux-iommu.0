From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Subject: Re: AMD-Vi: Decrease time of enabling lazy IO/TLB flushing
Date: Fri, 20 Jul 2018 14:34:50 +0200
Message-ID: <20180720123450.GD18541@8bytes.org>
References: <f7edc791-7e30-6fce-02ff-a5d2b52d2a69@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f7edc791-7e30-6fce-02ff-a5d2b52d2a69@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel+linux-iommu@molgen.mpg.de>
Cc: iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 17, 2018 at 06:07:07PM +0200, Paul Menzel wrote:
> On a MSI B350M MORTAR with AMD Ryzen 3 2200g (Raven) with Linux 4.18-rc5+
> and Debian Sid/unstable `pci_iommu_init` takes 40 ms according to
> `initcall_debug`.

40ms is a lot indeed, but IOMMU initialization is also a complex process
which includes scanning ACPI tables, allocating memory, flushing
hardware caches (which probably accounts for a fair amount of the time
needed).

Would be good if someone can come up with patches to improve the
situation here, as I don't know when I will find the time to look into
that.


Thanks,

	Joerg
