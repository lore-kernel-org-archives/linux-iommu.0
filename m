From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/vt-d: Don't reject NTB devices due to scope
 mismatch
Date: Wed, 15 Jun 2016 15:24:50 +0200
Message-ID: <20160615132450.GK26566@8bytes.org>
References: <1464914770-32107-1-git-send-email-roland@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464914770-32107-1-git-send-email-roland@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland Dreier <roland@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, David Woodhouse <David.Woodhouse@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 02, 2016 at 05:46:10PM -0700, Roland Dreier wrote:
> From: Roland Dreier <roland@purestorage.com>
> 
> On a system with an Intel PCIe port configured as an NTB device, iommu
> initialization fails with
> 
>     DMAR: Device scope type does not match for 0000:80:03.0
> 
> This is because the DMAR table reports this device as having scope 2
> (ACPI_DMAR_SCOPE_TYPE_BRIDGE):
> 
>     [0A0h 0160   1]      Device Scope Entry Type : 02
>     [0A1h 0161   1]                 Entry Length : 08
>     [0A2h 0162   2]                     Reserved : 0000
>     [0A4h 0164   1]               Enumeration ID : 00
>     [0A5h 0165   1]               PCI Bus Number : 80
> 
>     [0A6h 0166   2]                     PCI Path : 03,00
> 
> but the device has a type 0 PCI header:
> 
>     80:03.0 Bridge [0680]: Intel Corporation Device [8086:2f0d] (rev 02)
>     00: 86 80 0d 2f 00 00 10 00 02 00 80 06 10 00 80 00
>     10: 0c 00 c0 00 c0 38 00 00 0c 00 00 00 80 38 00 00
>     20: 00 00 00 c8 00 00 10 c8 00 00 00 00 86 80 00 00
>     30: 00 00 00 00 60 00 00 00 00 00 00 00 ff 01 00 00
> 
> VT-d works perfectly on this system, so there's no reason to bail out
> on initialization due to this apparent scope mismatch.  Use the class
> 0x0680 ("Other bridge device") as a heuristic for allowing DMAR
> initialization for non-bridge PCI devices listed with scope bridge.
> 
> Signed-off-by: Roland Dreier <roland@purestorage.com>
> ---
>  drivers/iommu/dmar.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Applied, thanks.
