From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC PATCH v2 00/15] ACPI IORT ARM SMMU v3 support
Date: Tue, 21 Jun 2016 18:37:17 +0800
Message-ID: <b00f33ad-be24-21a9-b03b-611756bbc8e9@linaro.org>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, iommu@lists.linux-foundation.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Tomasz Nowicki <tn@semihalf.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo,

On 2016/6/7 21:30, Lorenzo Pieralisi wrote:
> This RFC patch series is v2 of a previous posting:
>
> https://lkml.org/lkml/2016/4/14/702
>
> v1 -> v2:
> 	- Rebased on top of dependencies series [1][2][3](v4.7-rc1)
> 	- Removed IOMMU fwnode generalization
> 	- Implemented ARM SMMU v3 ACPI probing instead of ARM SMMU v2
> 	  owing to patch series dependencies [1]
> 	- Moved platform device creation logic to IORT code to
> 	  generalize its usage for ARM SMMU v1-v2-v3 components
> 	- Removed reliance on ACPI early device probing
> 	- Created IORT specific iommu_xlate() translation hook leaving
> 	  OF code unchanged according to v1 reviews
>
> The ACPI IORT table provides information that allows instantiating
> ARM SMMU devices and carrying out id mappings between components on
> ARM based systems (devices, IOMMUs, interrupt controllers).
>
> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
>
> Building on basic IORT support, available through [2]:
>
> this patchset enables ARM SMMU v3 support on ACPI systems.

I'm trying to test your patches on D03 (SMMUv3 based) but ...

[...]
> [1] R.Murphy "Generic DT bindings for PCI and ARM SMMU v3"
>     http://marc.info/?l=linux-arm-kernel&m=146497432413816&w=2

...This patch set is still in discussion and seems not work
for non-PCI devices.

>
> [2] T.Nowicki "Introduce ACPI world to ITS irqchip" v5
>     http://marc.info/?l=linux-acpi&m=146469369703684&w=2

Tomasz sent out the v7 and included patches in your series.

I think a updated version before the test makes sense, what
do you think? Let me know your thoughts.

Thanks
Hanjun
