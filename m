From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 06/23] ARM: dt: tegra114: iommu: Add "nvidia,swgroups"
Date: Mon, 01 Jul 2013 17:10:01 -0600
Message-ID: <51D20C49.2020802@wwwdotorg.org>
References: <1372238906-9346-7-git-send-email-hdoyu@nvidia.com><20130626105216.GL27083@manwe> <20130701.112446.119298599375396428.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130701.112446.119298599375396428.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 07/01/2013 02:24 AM, Hiroshi Doyu wrote:
> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 26 Jun 2013 12:52:17 +0200:
>> On Wed, Jun 26, 2013 at 12:28:09PM +0300, Hiroshi Doyu wrote:
>>> This is a bitmap that indicates which HardWare Accelerators(HWA) are
>>> supported on Tegra114 SoC.
...
>> It seems like an nvidia,tegra114-smmu.txt file is missing from the
>> Documentation/devicetree/bindings/iommu directory.
> 
> All difference between T30 and T114 is now provided from DT. They have
> all same entries but only those values are different.
> 
> Do we still need a copy of nvidia,tegra30-smmu.txt for t114 or is just
> tweaking nvidia,tegra30-smmu.txt for t114 enough?

If the two HW are identical (at least as far as bindings), the existing
nvidia,tegra30-smmu.txt should be enough. We probably should at least
update it to list the additional supported compatible value though,
especially if the driver interprets the two compatible values in a
different way (e.g. there are HW differences, but they don't affect the
binding definition).
