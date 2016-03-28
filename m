From: Radha Mohan <mohun106@gmail.com>
Subject: Re: [PATCH V4] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
Date: Mon, 28 Mar 2016 11:57:54 -0700
Message-ID: <CAC8NTUUXoW4mV7aFD90mbSpVaai=o6fxM+PLSUzu82qOjEJn2Q@mail.gmail.com>
References: <1457128569-13878-1-git-send-email-tchalamarla@caviumnetworks.com>
 <44D97D2C-5114-4FCD-AE3E-9404391FD449@caviumnetworks.com>
 <20160324175127.GA29365@arm.com>
 <4F6594C9-35E6-415B-B022-D78827C659C0@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F6594C9-35E6-415B-B022-D78827C659C0@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla@caviumnetworks.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Akula,
 Geethasowjanya" <Geethasowjanya.Akula@caviumnetworks.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 24, 2016 at 11:29 AM, Chalamarla, Tirumalesh
<Tirumalesh.Chalamarla@caviumnetworks.com> wrote:
> Thanks.
>
>
>
>
> On 3/24/16, 10:51 AM, "Will Deacon" <will.deacon@arm.com> wrote:
>
>>On Thu, Mar 24, 2016 at 05:36:39PM +0000, Chalamarla, Tirumalesh wrote:
>>> Do you want me to resend it with path version number change?
>>
>>Shouldn't be any need. I've queued this locally, and will push out when
>>I update my repo after the merge window.
>>

Minor change that affects the kernel compilation.
I think it makes sense to resubmit the patch.

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6ed7c3e..4aca5c1 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1834,8 +1834,8 @@ static int arm_smmu_device_dt_probe(struct
platform_device *pdev)
         * asid/vmid space.
         */
        if (of_device_is_compatible(dev->of_node, "cavium,smmu-v2")) {
-               smmu->cavium_id_base = atomic_read(cavium_smmu_context_count);
-               atomic_add(smmu->num_context_banks, cavium_smmu_context_count);
+               smmu->cavium_id_base = atomic_read(&cavium_smmu_context_count);
+               atomic_add(smmu->num_context_banks, &cavium_smmu_context_count);
        }

        list_add(&smmu->list, &arm_smmu_devices);

>>Will
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
