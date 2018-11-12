From: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH 2/4] iommu/vt-d: Force IOMMU on for platform opt in hint
Date: Mon, 12 Nov 2018 11:51:21 -0800
Message-ID: <20181112195121.GC5367@araj-mobl1.jf.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-3-mika.westerberg@linux.intel.com>
 <20181112110900.16cfee48@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112110900.16cfee48@t450s.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, iommu@lists.linux-foundation.org, Mario.Limonciello@dell.com, Michael Jamet <michael.jamet@intel.com>, Christian Kellner <ckellner@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Yehezkel Bernat <YehezkelShB@gmail.com>, Anthony Wong <anthony.wong@canonical.com>, Andreas Noever <andreas.noever@gmail.com>, Lukas Wunner <lukas@wunner.de>, Jacob jun Pan <jacob.jun.pan@intel.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 11:09:00AM -0700, Alex Williamson wrote:
> On Mon, 12 Nov 2018 19:06:26 +0300
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > Intel VT-d spec added a new DMA_CTRL_PLATFORM_OPT_IN_FLAG flag
> > in DMAR ACPI table for BIOS to report compliance about platform
> > initiated DMA restricted to RMRR ranges when transferring control
> > to the OS. The OS treats this as a hint that the IOMMU should be
> > enabled to prevent DMA attacks from possible malicious devices.
> 
> Does this in any way suggest that there are additional recommended uses
> cases from Intel for RMRRs?  My concern here is the incompatibility we
> have with RMRRs and device assignment as we currently cannot assign
> devices where the IOVA address space is encumbered by RMRR
> requirements.  Unfortunately RMRRs do not indicate any sort or
> lifespan, so firmware enabling an RMRR simply to support some boot-time
> DMA encumbers the device with that RMRR for the life of that boot,
> unless we have VT-d code that decides it knows better.  Thanks,

IMO any new platform that requires RMRR should be a bug. It was designed 
originally for some legacy keyboard emulation etc.

The best behavior is to continue to not allow devices with RMRR be direct assigned.

Technically ignoring RMRR's and continuing to assign those devices is risky.
The problem is IF BIOS/SMM initiates some IO in the RMRR range and it happens to be
mapped by the direct assigned GPA its going to be ugly failure.
