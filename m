From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/3] SOCFPGA Stratix10 SMMU Support
Date: Fri, 13 Jul 2018 18:05:53 +0100
Message-ID: <01919396-a3a5-6978-0aec-c2a747cb0475@arm.com>
References: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thor.thayer@linux.intel.com, dinguyen@kernel.org, robh+dt@kernel.org, joro@8bytes.org, mark.rutland@arm.com
Cc: catalin.marinas@arm.com, iommu@lists.linux-foundation.org, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Thor,

On 13/07/18 17:27, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> This patch series adds SMMU support to the SOCFPGA Stratix10 family
> of parts. The addition of a clock parameter was required to ungate
> the SMMU clock.

Please see the latest version of Vivek's runtime PM series[1] - there's 
already been an awful lot of discussion over how to handle clocks, since 
they're not part of the SMMU architecture and different implementations 
can have very different requirements (and even different configurations 
of the same implementation may vary, e.g. MMU-500 could technically have 
up to 33 separate clocks).

Thanks,
Robin.

[1] 
https://www.mail-archive.com/freedreno@lists.freedesktop.org/msg02422.html

> Thor Thayer (3):
>    Docs: dt: arm-smmu: Add optional clock parameter
>    iommu/arm-smmu: Add optional SMMU clock
>    arm64: dts: stratix10: Add SMMU Node
> 
>   .../devicetree/bindings/iommu/arm,smmu.txt         | 16 ++++++++
>   arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 44 ++++++++++++++++++++++
>   drivers/iommu/arm-smmu.c                           | 17 +++++++++
>   3 files changed, 77 insertions(+)
> 
