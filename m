From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH v7 00/16] ACPI IORT ARM SMMU support
Date: Wed, 16 Nov 2016 14:28:02 +0100
Message-ID: <cd630404-3e75-f49f-9027-f2a79293aa7d@semihalf.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, iommu@lists.linux-foundation.org
Cc: Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>, Jon Masters <jcm@redhat.com>, Eric Auger <eric.auger@redhat.com>, Sinan Kaya <okaya@codeaurora.org>, Nate Watterson <nwatters@codeaurora.org>, Prem Mallappa <prem.mallappa@broadcom.com>, Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 09.11.2016 15:19, Lorenzo Pieralisi wrote:
> This patch series is v7 of a previous posting:
>
> https://lkml.org/lkml/2016/10/18/506
>

[...]

>
> The ACPI IORT table provides information that allows instantiating
> ARM SMMU devices and carrying out id mappings between components on
> ARM based systems (devices, IOMMUs, interrupt controllers).
>
> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
>
> Building on basic IORT support, this patchset enables ARM SMMUs support
> on ACPI systems.
>
> Most of the code is aimed at building the required generic ACPI
> infrastructure to create and enable IOMMU components and to bring
> the IOMMU infrastructure for ACPI on par with DT, which is going to
> make future ARM SMMU components easier to integrate.
>

[...]

>
> This patchset is provided for review/testing purposes here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/iort-smmu-v7
>
> Tested on Juno and FVP models for ARM SMMU v1 and v3 probing path.
>

For all series:
Reviewed-by: Tomasz Nowicki <tn@semihalf.com>

Thanks,
Tomasz
