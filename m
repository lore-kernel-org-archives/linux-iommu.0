From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv4 1/7] ARM: tegra: Create a DT header defining SWGROUP ID
Date: Fri, 15 Nov 2013 12:29:26 +0200
Message-ID: <20131115122926.9166a6693bb9378a7f2c1526@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
	<1384158718-4756-2-git-send-email-hdoyu@nvidia.com>
	<5282B036.9090604@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5282B036.9090604-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 12 Nov 2013 23:48:22 +0100
Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:

> On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> > Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
> > binding. "swgroup" is a group of H/W clients which a Tegra SoC
> > supports. This unique ID can be used to calculate MC_SMMU_<swgroup
> > name>_ASID_0 register offset and MC_<swgroup name>_HOTRESET_*_0
> > register bit. This will allow the same header to be used by both
> > device tree files, and drivers implementing this binding, which
> > guarantees that the two stay in sync. This also makes device trees
> > more readable by using names instead of magic numbers. For HOTRESET
> > bit shifting we need another conversion table, which will come later.
> 
> > diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h
> 
> > +#define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */
> > +
> > +#define TEGRA_SWGROUP_MAX	64
> > +
> > +#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
> 
> If I put the following into a DT and compile it:
> 
> #define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */
> #define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
> / {
> 	test-prop = <(TEGRA_SWGROUP_BIT(PPCS2))>;
> };
> 
> I get:
> 
> Error: arch/arm/boot/dts/tegra20.dtsi:11.28-29 integer value out of
> range 0000000000000020 (32 bits)
> FATAL ERROR: Syntax error parsing input tree
> 
> Is TEGRA_SWGROUP_BIT() not meant to be used in DT files? If it is, the
> definition is broken. If it is not, it should be defined in the driver
> not the header, since DT files have no use for it.

I'd like to use the macro in DT but what I want is 2 cells from 64 bit.
For the above example, I want the following 2 cell to be generated but I
haven't found any ways yet.

#define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */
#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
/ {
 	test-prop = <0x00000000 0x00000001>;
};
