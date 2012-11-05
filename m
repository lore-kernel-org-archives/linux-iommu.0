From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 0/4] iommu/fsl: Freescale PAMU driver and IOMMU API implementation.
Date: Mon, 5 Nov 2012 16:05:40 -0600
Message-ID: <50983834.30403@freescale.com>
References: <1352114361-25192-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352114361-25192-1-git-send-email-Varun.Sethi@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: joerg.roedel@amd.com, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, scottwood@freescale.com
List-Id: iommu@lists.linux-foundation.org

Varun Sethi wrote:
> This patchset provides the Freescale PAMU (Peripheral Access Management Unit) driver
> and the corresponding IOMMU API implementation. PAMU is the IOMMU present on Freescale
> QorIQ platforms. PAMU can authorize memory access, remap the memory address, and remap 
> the I/O transaction type.

You forgot to send post these patches to
linuxppc-release@linux.freescale.net.  May I suggest the following

git-send-email ... --bcc linuxppc-release@linux.freescale.net ...

whenever you post a patch upstream?

> This set consists of the following patches:
> 1. Addition of new field in the device (powerpc) archdata structure for storing iommu domain information
>    pointer. This pointer is stored when the device is attached to a particular iommu domain.
> 2. Add PAMU bypass enable register to the ccsr_guts structure.

I don't see patch 2/4 posted anywhere.

-- 
Timur Tabi
Linux kernel developer at Freescale
