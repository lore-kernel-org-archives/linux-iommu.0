Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2D9C433F5
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 19:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7371140ADE;
	Fri, 22 Apr 2022 19:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RnpsbkM_ZnsI; Fri, 22 Apr 2022 19:41:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5508D40360;
	Fri, 22 Apr 2022 19:41:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 240ADC0032;
	Fri, 22 Apr 2022 19:41:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A078EC002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 19:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EB0840ADE
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 19:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f7Y01cfSTYGd for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 19:41:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id A726740360
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 19:41:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7F041063;
 Fri, 22 Apr 2022 12:41:16 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 822023F73B;
 Fri, 22 Apr 2022 12:41:13 -0700 (PDT)
Message-ID: <a9e09125-c61b-4a2a-f87e-1ba8147f659f@arm.com>
Date: Fri, 22 Apr 2022 20:41:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4] Documentation: x86: rework IOMMU documentation
Content-Language: en-GB
To: Alex Deucher <alexander.deucher@amd.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net, hpa@zytor.com, x86@kernel.org,
 dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
 tglx@linutronix.de, joro@8bytes.org, Suravee.Suthikulpanit@amd.com,
 will@kernel.org, iommu@lists.linux-foundation.org, Vasant.Hegde@amd.com
References: <20220422175423.44491-1-alexander.deucher@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220422175423.44491-1-alexander.deucher@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-04-22 18:54, Alex Deucher wrote:
[...]
> +Intel Specific Notes
> +--------------------
> +
> +Graphics Problems?
> +^^^^^^^^^^^^^^^^^^
> +
> +If you encounter issues with graphics devices, you can try adding
> +option intel_iommu=igfx_off to turn off the integrated graphics engine.
> +If this fixes anything, please ensure you file a bug reporting the problem.
> +
> +Some exceptions to IOVA
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
> +The same is true for peer to peer transactions. Hence we reserve the
> +address from PCI MMIO ranges so they are not allocated for IOVA addresses.

Note that this should be true for both drivers.

> +
> +AMD Specific Notes
> +------------------
> +
> +Graphics Problems?
> +^^^^^^^^^^^^^^^^^^
> +
> +If you encounter issues with integrated graphics devices, you can try adding
> +option iommu=pt to the kernel command line use a 1:1 mapping for the IOMMU.  If
> +this fixes anything, please ensure you file a bug reporting the problem.

And indeed this is a generic option. I reckon we could simply merge 
these two sections together, with the first paragraph being something like:

If you encounter issues with integrated graphics devices, you can try 
adding the option "iommu.passthrough=1", or the equivalent "iommu=pt", 
to the kernel command line to use a 1:1 mapping for the IOMMU in 
general.  On Intel you can also try "intel_iommu=igfx_off" to turn off 
translation specifically for the integrated graphics engine only.  If 
this fixes anything, please ensure you file a bug reporting the problem.

> +
> +Fault reporting
> +---------------
> +When errors are reported, the IOMMU signals via an interrupt. The fault
> +reason and device that caused it is printed on the console.
> +
> +
> +Kernel Log Samples
> +------------------
> +
> +Intel Boot Messages
> +^^^^^^^^^^^^^^^^^^^
> +
> +Something like this gets printed indicating presence of DMAR tables
> +in ACPI.
> +
> +::
> +
> +	ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @ 0x000000007f5b5ef0
> +
> +When DMAR is being processed and initialized by ACPI, prints DMAR locations
> +and any RMRR's processed
> +
> +::
> +
> +	ACPI DMAR:Host address width 36
> +	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
> +	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
> +	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
> +	ACPI DMAR:RMRR base: 0x00000000000ed000 end: 0x00000000000effff
> +	ACPI DMAR:RMRR base: 0x000000007f600000 end: 0x000000007fffffff
> +
> +When DMAR is enabled for use, you will notice
> +
> +::
> +
> +	PCI-DMA: Using DMAR IOMMU
> +
> +Intel Fault reporting
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> +	DMAR:[fault reason 05] PTE Write access is not set
> +	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> +	DMAR:[fault reason 05] PTE Write access is not set
> +
> +AMD Boot Messages
> +^^^^^^^^^^^^^^^^^
> +
> +Something like this gets printed indicating presence of the IOMMU.
> +
> +::
> +
> +	iommu: Default domain type: Translated
> +	iommu: DMA domain TLB invalidation policy: lazy mode

Similarly, that's common IOMMU API reporting which will be seen on all 
architectures (let alone IOMMU drivers). Maybe some of the messages from 
print_iommu_info() might be better AMD-specific examples?

Cheers,
Robin.

> +
> +AMD Fault reporting
> +^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007 address=0xffffc02000 flags=0x0000]
> +	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007 address=0xffffc02000 flags=0x0000]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
