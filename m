From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/4] PCI: get DMA configuration from parent device
Date: Thu, 08 Jan 2015 23:27:14 +0100
Message-ID: <2785994.gTZ9chGdKf@wuerfel>
References: <1420656594-8908-1-git-send-email-m-karicheri2@ti.com> <54ADBB89.8070503@ti.com> <1934001.D0JfDRp1gF@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1934001.D0JfDRp1gF@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: bhelgaas@google.com, linux-arm-kernel@lists.infradead.org, joro@8bytes.org, grant.likely@linaro.org, robh+dt@kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com, linux@arm.linux.org.uk
List-Id: iommu@lists.linux-foundation.org

On Thursday 08 January 2015 09:56:39 Arnd Bergmann wrote:
> There is another interesting case, which is a USB host controller or
> something similar behind a PCI bus. These are quite common and also
> need to be handled in some form. Let's do just PCI first for now, but
> be aware that this will come next. Should we assume that the ID that
> is required for a device is either known from the device node, or
> that it comes from a PCI device? That means for the USB case, we will
> likely need to have some custom logic. There seems to be an implicit
> assumption all over the kernel that all devices have the same IOMMU
> instance, but we can't really rely on that here.
> 

Update: I've checked the USB implementation and we are lucky because
these interactions are all done by the USB host controller, and a
USB device is not itself DMA capable. We don't have to do anything
for USB.

	Arnd
