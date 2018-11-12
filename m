From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 0/4] PCI / iommu / thunderbolt: IOMMU based DMA protection
Date: Mon, 12 Nov 2018 19:12:14 +0100
Message-ID: <20181112181214.xaahc5wni4vuwl6h@wunner.de>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob jun Pan <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Christian Kellner <ckellner@redhat.com>, Mario.Limonciello@dell.com, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 07:06:24PM +0300, Mika Westerberg wrote:
> Recent systems shipping with Windows 10 version 1803 or newer may be
> utilizing IOMMU to prevent DMA attacks via Thunderbolt ports. This is
> different from the previous security level based scheme because the
> connected device cannot access system memory outside of the regions
> allocated for it by the driver.
> 
> When enabled the BIOS makes sure no device can do DMA outside of RMRR
> (Reserved Memory Region Record) regions. This means that during OS boot,
> before it enables IOMMU, none of the connected devices can bypass DMA
> protection for instance by overwriting the data structures used by the
> IOMMU. The BIOS communicates support for this to the OS by setting a new
> bit in ACPI DMAR table [1].
> 
> Because these systems utilize an IOMMU to block possible DMA attacks,
> typically (but not always) the Thunderbolt security level is set to "none"
> which means that all PCIe devices are immediately usable. This also means
> that Linux needs to follow Windows 10 and enable IOMMU automatically when
> running on such system otherwise connected devices can read/write system
> memory pretty much without any restrictions.

What if the system is booted from a Thunderbolt-attached disk?
Won't this suddenly break with these patches?  That would seem like a
pretty significant regression.  What if the only GPU in the system is
Thunderbolt-attached?  Is it possible to recognize such scenarios and
automatically exempt affected devices from IOMMU blocking?

Thanks,

Lukas
