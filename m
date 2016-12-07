From: Shanker Donthineni <shankerd@codeaurora.org>
Subject: Re: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
 reserved regions
Date: Wed, 7 Dec 2016 12:52:57 -0600
Message-ID: <165d4f72-ef74-2db8-166a-1f90208315c8@codeaurora.org>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
 <6c9012fd-070b-6218-48e7-69b37f2559dd@redhat.com>
 <20161130103713.GB2724@arm.com>
 <1899e46c-7b06-01d6-6cff-eb0985a4f11d@redhat.com>
Reply-To: shankerd@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1899e46c-7b06-01d6-6cff-eb0985a4f11d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>, Will Deacon <will.deacon@arm.com>
Cc: drjones@redhat.com, alex.williamson@redhat.com, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, joro@8bytes.org, punit.agrawal@arm.com, linux-kernel@vger.kernel.org, diana.craciun@nxp.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, christoffer.dall@linaro.org, tglx@linutronix.de, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

Is there any reason why you are not supporting SMMUv3 driver? Qualcomm 
hardware doesn't not support SMMUv2 hardware, please add support for 
SMMUv3 in next patch set. I've ported ' RFC,v3,09/10] iommu/arm-smmu: 
Implement reserved region get/put callbacks' to SMMUv3 driver and tested 
device-pass-through feature on Qualcomm server platform without any issue.

Tested-by: Shanker Donthineni <shankerd@codeaurora.org>

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
