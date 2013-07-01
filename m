From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 19/23] iommu/tegra: smmu: Unfied driver for Tegra SoCs
Date: Mon, 01 Jul 2013 17:11:31 -0600
Message-ID: <51D20CA3.1040105@wwwdotorg.org>
References: <1372238906-9346-20-git-send-email-hdoyu@nvidia.com><20130626110747.GP27083@manwe> <20130701.113259.1041478084393668638.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130701.113259.1041478084393668638.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 07/01/2013 02:32 AM, Hiroshi Doyu wrote:
> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 26 Jun 2013 13:07:47 +0200:
>> On Wed, Jun 26, 2013 at 12:28:22PM +0300, Hiroshi Doyu wrote:
>>> Support multiple generation of Tegra SoCs with this unified
>>> SMMU driver. Necessary info is expected to be passed from DT.

>>> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

>>> - * IOMMU API for SMMU in Tegra30
>>> + * IOMMU API for SMMU in Tegra SoC
>>
>> Maybe "Tegra30 and later SoCs" given that Tegra20 has no compatible
>> IOMMU?
>>
>>> -MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra30");
>>> +MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra SoC");
>>
>> Same here.
> 
> Currently most of Tegra SoC has SMMU, and which doesn't have can be
> identified from DT. IMHO, we don't have to be so strict on this
> decritpions. Otherwise, we would need to list up which one (doesn't)
> has whenever a new one comes?

I would just say "Tegra30" here. The fact that other SoCs use the same
HW block (or one compatible with it) doesn't really warrant changing
those comments.
