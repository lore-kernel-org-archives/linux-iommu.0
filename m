From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/4] iommu/vt-d: Force IOMMU on for platform opt in hint
Date: Mon, 12 Nov 2018 11:09:00 -0700
Message-ID: <20181112110900.16cfee48@t450s.home>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
        <20181112160628.86620-3-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112160628.86620-3-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com, Michael Jamet <michael.jamet@intel.com>, Christian Kellner <ckellner@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Yehezkel Bernat <YehezkelShB@gmail.com>, Anthony Wong <anthony.wong@canonical.com>, Andreas Noever <andreas.noever@gmail.com>, Lukas Wunner <lukas@wunner.de>, Jacob jun Pan <jacob.jun.pan@intel.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 12 Nov 2018 19:06:26 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Intel VT-d spec added a new DMA_CTRL_PLATFORM_OPT_IN_FLAG flag
> in DMAR ACPI table for BIOS to report compliance about platform
> initiated DMA restricted to RMRR ranges when transferring control
> to the OS. The OS treats this as a hint that the IOMMU should be
> enabled to prevent DMA attacks from possible malicious devices.

Does this in any way suggest that there are additional recommended uses
cases from Intel for RMRRs?  My concern here is the incompatibility we
have with RMRRs and device assignment as we currently cannot assign
devices where the IOVA address space is encumbered by RMRR
requirements.  Unfortunately RMRRs do not indicate any sort or
lifespan, so firmware enabling an RMRR simply to support some boot-time
DMA encumbers the device with that RMRR for the life of that boot,
unless we have VT-d code that decides it knows better.  Thanks,

Alex
