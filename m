From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/4] PCI / iommu / thunderbolt: IOMMU based DMA protection
Date: Tue, 13 Nov 2018 09:54:24 +0100
Message-ID: <20181113085424.GC25808@8bytes.org>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob jun Pan <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Lukas Wunner <lukas@wunner.de>, Christian Kellner <ckellner@redhat.com>, Mario.Limonciello@dell.com, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 07:06:24PM +0300, Mika Westerberg wrote:
> Lu Baolu (1):
>   iommu/vt-d: Force IOMMU on for platform opt in hint
> 
> Mika Westerberg (3):
>   PCI / ACPI: Identify external PCI devices
>   iommu/vt-d: Do not enable ATS for external devices
>   thunderbolt: Export IOMMU based DMA protection support to userspace

Looks good to me. Which tree should go this trough? In case its not the
IOMMU tree, for the iommu-parts:

	Acked-by: Joerg Roedel <jroedel@suse.de>
	Reviewed-by: Joerg Roedel <jroedel@suse.de>

Thanks,

	Joerg
