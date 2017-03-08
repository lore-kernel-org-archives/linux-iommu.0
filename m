From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Wed, 8 Mar 2017 10:26:50 -0500
Message-ID: <c0f74140-f1f6-7c52-295a-5d4722017664@codeaurora.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170227195441.5170-5-jean-philippe.brucker@arm.com>
Sender: kvm-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Harv Abdulhamid <harba@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@qti.qualcomm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Nate Watterson <nwatters@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 2/27/2017 2:54 PM, Jean-Philippe Brucker wrote:
> +	ats_enabled = !arm_smmu_enable_ats(master);
> +

You should make ats_supported field in IORT table part of the decision
process for when to enable ATS.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
