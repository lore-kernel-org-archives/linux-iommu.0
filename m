From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 4/4 v6] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Sat, 1 Dec 2012 22:58:20 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B7081BD418@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1354360921-20850-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354360921-20850-1-git-send-email-Varun.Sethi@freescale.com>
Content-Language: en-US
Content-ID: <C385E571606E13408CDD50BFC0F66BDB@mgd.freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sethi Varun-B16395 <B16395@freescale.com>
Cc: "joerg.roedel@amd.com" <joerg.roedel@amd.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tabi Timur-B04825 <B04825@freescale.com>, Wood Scott-B07421 <B07421@freescale.com>
List-Id: iommu@lists.linux-foundation.org

Varun Sethi wrote:
> Following is a brief description of the PAMU hardware:
> PAMU determines what action to take and whether to authorize the action on
> the basis of the memory address, a Logical IO Device Number (LIODN), and
> PAACT table (logically) indexed by LIODN and address. Hardware devices which
> need to access memory must provide an LIODN in addition to the memory address.
>
> Peripheral Access Authorization and Control Tables (PAACTs) are the primary
> data structures used by PAMU. A PAACT is a table of peripheral access
> authorization and control entries (PAACE).Each PAACE defines the range of
> I/O bus address space that is accessible by the LIOD and the associated access
> capabilities.
>
> There are two types of PAACTs: primary PAACT (PPAACT) and secondary PAACT
> (SPAACT).A given physical I/O device may be able to act as one or more
> independent logical I/O devices (LIODs). Each such logical I/O device is
> assigned an identifier called logical I/O device number (LIODN). A LIODN is
> allocated a contiguous portion of the I/O bus address space called the DSA window
> for performing DSA operations. The DSA window may optionally be divided into
> multiple sub-windows, each of which may be used to map to a region in system
> storage space. The first sub-window is referred to as the primary sub-window
> and the remaining are called secondary sub-windows.
>
> This patch provides the PAMU driver (fsl_pamu.c) and the corresponding IOMMU
> API implementation (fsl_pamu_domain.c). The PAMU hardware driver (fsl_pamu.c)
> has been derived from the work done by Ashish Kalra and Timur Tabi
> (timur@freescale.com).
>
> Signed-off-by: Timur Tabi<timur@freescale.com>
> Signed-off-by: Varun Sethi<Varun.Sethi@freescale.com>
> ---

Acked-by: Timur Tabi <timur@freescale.com>


-- 
Timur Tabi
Linux kernel developer at Freescale
