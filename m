From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/4] pci: Add PCI_BUS() and PCI_DEVID() interfaces to
 return bus number and device id
Date: Wed, 13 Feb 2013 13:03:15 +0100
Message-ID: <20130213120315.GE25591@8bytes.org>
References: <1360623614.2950.60.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1360623614.2950.60.camel@lorien2>
Sender: linux-pci-owner@vger.kernel.org
To: bhelgaas@google.com
Cc: Shuah Khan <shuah.khan@hp.com>, jiang.liu@huawei.com, shemminger@vyatta.com, paulmck@linux.vnet.ibm.com, linasvepstas@gmail.com, dhowells@redhat.com, davej@redhat.com, tglx@linutronix.de, mtk.manpages@gmail.com, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, wangyijing@huawei.com, LKML <linux-kernel@vger.kernel.org>, shuahkhan@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Bjorn,

On Mon, Feb 11, 2013 at 04:00:14PM -0700, Shuah Khan wrote:
> pci defines PCI_DEVFN(), PCI_SLOT(), and PCI_FUNC() interfaces, however,
> it doesn't have interfaces to return PCI bus and PCI device id. Drivers
> (AMD IOMMU, and AER) have module specific definitions for PCI_BUS() and
> AMD_IOMMU driver also has a module specific interface to calculate PCI
> device id from bus number and devfn.
> 
> This patch set adds PCI_BUS(), and PCI_DEVID() to pci.h, changes are to
> use PCI_BUS() from pci. Changes AMD_IOMMU driver to use PCI_BUS() and
> PCI_DEVID() from pci.

Not sure who is going to merge this, it touches PCI and IOMMU code.
Personally I don't care :-) If you want to take it via your tree feel
free to add my

Reviewed-by: Joerg Roedel <joro@8bytes.org>
Tested-by: Joerg Roedel <joro@8bytes.org>
Acked-by: Joerg Roedel <joro@8bytes.org>

Otherwise please Ack the PCI parts and I will add it to my tree then.


Thanks,

	Joerg
