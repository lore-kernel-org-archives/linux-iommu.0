From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv5 3/9] ARM: tegra: create a DT header defining SWGROUP ID
Date: Tue, 19 Nov 2013 14:36:54 -0700
Message-ID: <528BD9F6.3080008@wwwdotorg.org>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com>
	<1384853593-32202-4-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1384853593-32202-4-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/19/2013 02:33 AM, Hiroshi Doyu wrote:
> Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
> binding. "swgroup" is a group of H/W clients which a Tegra SoC
> supports. This unique ID can be used to calculate MC_SMMU_<swgroup
> name>_ASID_0 register offset and MC_<swgroup name>_HOTRESET_*_0
> register bit. This will allow the same header to be used by both
> device tree files, and drivers implementing this binding, which
> guarantees that the two stay in sync. This also makes device trees
> more readable by using names instead of magic numbers. For HOTRESET
> bit shifting we need another conversion table, which will come later.

> diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h

> +#define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */
> +
> +#define TWO_U32_OF_U64(x)	((x) & ~0UL) ((x) >> 32)
> +#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
> +#define TEGRA_SWGROUP_CELLS(x)	TWO_U32_OF_U64(TEGRA_SWGROUP_BIT(x))

This still doesn't actually compile in dtc:

$ cat > tmp.dts <<ENDOFHERE
/dts-v1/;

#define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */

#define TWO_U32_OF_U64(x)	((x) & ~0UL) ((x) >> 32)
#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
#define TEGRA_SWGROUP_CELLS(x)	TWO_U32_OF_U64(TEGRA_SWGROUP_BIT(x))

/ {
    prop = <TEGRA_SWGROUP_CELLS(PPCS2)>;
};
ENDOFHERE

$ gcc -nostdinc -undef -D__DTS__ -E -x assembler-with-cpp -o tmp.dts.i \
	tmp.dts

$ ./scripts/dtc/dtc -O dts -o tmp-compiled.dts -I dts tmp.dts.i
Error: tmp.dts:10.35-36 integer value out of range 0000000000000020 \
	(32 bits)
FATAL ERROR: Syntax error parsing input tree

The reason is that "& ~0UL" expands to "& 0xffffffffffffffff" since dtc
doesn't know about the size difference between UL and ULL. You need to
change that to "& 0xffffffff" and it works, at least in dtc.

Please test!
