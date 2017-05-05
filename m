From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 3/7] ACPICA: IORT: Add Cavium ThunderX2 SMMUv3 model
 definition.
Date: Fri, 5 May 2017 15:58:00 +0100
Message-ID: <20170505145800.GG14111@arm.com>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
 <1493986091-30521-4-git-send-email-gakula@caviumnetworks.com>
 <330d0438-f9ed-ef65-8ffd-d556d149b4e1@linaro.org>
 <6b04ab17-449f-74e0-72f4-b5a9bc0639d8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6b04ab17-449f-74e0-72f4-b5a9bc0639d8@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Geetha sowjanya <gakula@caviumnetworks.com>, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, Geetha Sowjanya <geethasowjanya.akula@cavium.com>, jcm@redhat.com, linu.cherian@cavium.com, linux-kernel@vger.kernel.org, geethasowjanya.akula@gmail.com, linux-acpi@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, Charles.Garcia-Tobin@arm.com
List-Id: iommu@lists.linux-foundation.org

On Fri, May 05, 2017 at 07:56:17AM -0700, David Daney wrote:
> On 05/05/2017 06:53 AM, Hanjun Guo wrote:
> >On 2017/5/5 20:08, Geetha sowjanya wrote:
> >>From: Linu Cherian <linu.cherian@cavium.com>
> >>
> >>Add SMMUv3 model definition for ThunderX2.
> >>
> >>Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> >>Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> >>---
> >> include/acpi/actbl2.h | 2 ++
> >> 1 file changed, 2 insertions(+)
> >>
> >>diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> >>index faa9f2c..76a6f5d 100644
> >>--- a/include/acpi/actbl2.h
> >>+++ b/include/acpi/actbl2.h
> >>@@ -779,6 +779,8 @@ struct acpi_iort_smmu {
> >> #define ACPI_IORT_SMMU_CORELINK_MMU400  0x00000002    /* ARM Corelink
> >>MMU-400 */
> >> #define ACPI_IORT_SMMU_CORELINK_MMU500  0x00000003    /* ARM Corelink
> >>MMU-500 */
> >>
> >>+#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX 0x00000002 /* Cavium ThunderX2
> >>SMMUv3 */
> >
> >There are some other model numbers in the unreleased spec,
> >I think we need to wait for the updated IORT spec to
> >be released.
> >
> 
> ... or if we are fairly confident that the identifier will not need to
> change, we can merge this as is and establish a de facto specification that
> the Real IORT specification will then be forced to follow.
> 
> Is there anything other than bureaucratic inertia holding up the real
> specification?

My understanding is that IORT is going to be published imminently (i.e.
before the next kernel release), so it makes sense to wait rather than fork
the spec.

Will
