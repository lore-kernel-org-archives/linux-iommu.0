From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 00/19] Unifying SMMU driver among Tegra SoCs
Date: Wed, 30 Oct 2013 10:44:57 -0600
Message-ID: <52713789.70308@wwwdotorg.org>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
	<20131030.183454.2089418674186724494.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131030.183454.2089418674186724494.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/30/2013 10:34 AM, Hiroshi Doyu wrote:
> Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote @ Fri, 18 Oct 2013 12:26:41 +0200:
> 
>> Hi,
>>
>> This series provides:
>>
>> (1) Unified SMMU driver among Tegra SoCs
>> (2) Multiple Address Space support(MASID) in IOMMU(SMMMU)
>> (3) Tegra IOMMU'able devices, most of platform devices are IOMMU'able.
>>
>> There's some discussion[1] about device population order, which could
>> solve the following patches.
>>
>>   patch 1: [HACK] of: dev_node has struct device pointer
>>   patch 2: [HACK] ARM: tegra: Populate AHB/IOMMU earlier than others
>>   patch 3: [HACK] amba: Move AHB to core_initcall
>>   patch 4: [HACK] iommu/tegra: smmu: Move IOMMU to core_initcall
> 
> Joerg, Stephen,
> 
> Would it be possible to merge this series without the above ordering patches?

What are the dependencies between the patches? Surely if those patches
were at the start of the series, the rest relies on them. Otherwise, why
was this all once series?

Anyway, I haven't had a chance to look at this yet, and it was sent too
late for 3.13. Hopefully we can work this out and apply it early for 3.14.
