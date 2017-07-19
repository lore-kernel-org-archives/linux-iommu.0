From: Anup Patel <anup.patel@broadcom.com>
Subject: Re: [PATCH 1/5] iommu: Add capability IOMMU_CAP_BYPASS
Date: Wed, 19 Jul 2017 16:49:00 +0530
Message-ID: <CAALAos_o25mtphxcVE0rr9dE8YAm-os2C_HD9oDnt41ZMDP8pA@mail.gmail.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
 <1500456838-18405-2-git-send-email-anup.patel@broadcom.com> <675744d3-b070-1245-6ebc-579c4b5f4a75@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <675744d3-b070-1245-6ebc-579c4b5f4a75@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>, Scott Branden <sbranden@broadcom.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, kvm@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 19, 2017 at 4:28 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 19/07/17 10:33, Anup Patel wrote:
>> Some of the IOMMUs (such as ARM SMMU) are capable of bypassing
>> transactions for which no IOMMU domain is configured.
>>
>> This patch adds IOMMU_CAP_BYPASS which can be used by IOMMU
>> drivers to advertise transation bypass capability of an IOMMU.
>
> Whatever the intended semantics of this are, I can't help thinking it
> would be better served by allowing callers to explicitly allocate their
> own IOMMU_DOMAIN_IDENTITY domains. That would also be useful for the
> problem we have with legacy virtio devices behind real IOMMUs.

We want to use VFIO no-IOMMU mode for FlexRM device but
currently it does not allow on our SOC because IOMMU ops are
registered for platform bus.

Regards,
Anup
