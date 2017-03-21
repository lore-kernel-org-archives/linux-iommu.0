From: Mason <slash.tmp@free.fr>
Subject: Re: [RFC PATCH v0.001] PCI: Add support for tango PCIe controller
Date: Tue, 21 Mar 2017 11:15:16 +0100
Message-ID: <f13c385d-dcc9-dacd-2b2c-ca098228f4f4@free.fr>
References: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>, linux-pci <linux-pci@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Phuong Nguyen <phuong_nguyen@sigmadesigns.com>, Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

[ Adding iommu ML ]

On 17/03/2017 17:11, Mason wrote:

> + * QUIRK #5
> + * Only transfers within the BAR are forwarded to the host.
> + * By default, the DMA framework expects that
> + * PCI address 0x8000_0000 -> CPU address 0x8000_0000
> + * which is where DRAM0 is mapped.

I have an additional question on this topic.

In a typical system, PCI bus masters are able to access all of RAM,
unless there is some kind of IOMMU, right?

I suppose one may consider the above limitation ("Only transfers
within the BAR are forwarded to the host") as some form of weird
IOMMU? (There is, in fact, some remapping logic in the controller
setup which I haven't discussed so far.)

Since this SoC is used for TV, the media cartels mandate some way
to limit where PCI bus masters can peek/poke in RAM.

Regards.
