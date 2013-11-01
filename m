From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 10/19] iommu/tegra: smmu: Get "nvidia,swgroups" from DT
Date: Fri, 01 Nov 2013 10:54:37 -0600
Message-ID: <5273DCCD.2050901@wwwdotorg.org>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com><1382092020-13170-11-git-send-email-hdoyu@nvidia.com><5271893C.6000507@wwwdotorg.org>
	<20131031.101717.1419377840657413108.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131031.101717.1419377840657413108.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/31/2013 02:17 AM, Hiroshi Doyu wrote:
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 30 Oct 2013 23:33:32 +0100:
...
> Right.
> "memory client ID" is used to find out MC_SMMU_<swgroup>_ASID_0
> register. This register is used to associate <swgroup> to address
> space(AS). <swgroup> == H/W. <swgroup> can be attached to any AS.
> 
>> Is "swgroup" simply another name for "memory client ID"? If so, it'd
>> be good to use just one term consistently.
> 
> I used the name "memory client ID" because this ID can be used to find
> out HOTRESET bit in MC_CLIENT_HOTRESET_*_0 registers in addition to
> find the MC_SMMU_<swgroup>_ASID_0 offset. But maybe it's easy to use
> the consistent name as "swgroup". If laster HOTRESET wants automatic
> calculation they could borrow/redefine the same ID list, just
> replacing the prefix. What do you think?
> 
>> Assuming "swgroup" is "memory client ID",
> 
> Yes

I took a look at the TRM, and it does look like there's a distinction
between client IDs and swgroups. The basic idea is that each swgroup
encompasses n (n >= 1) memory client IDs. So, we do have to use both terms.

See for example the tables in section 20.11.1.12 and 20.11.1.15 of
Tegra4 (Tegra114) TRM v01 that describe (some?) client ID -> swgroup
mappings. Section 20.3.4 states that whenever a translation error
occurs, both the module ID (I assume swgroup) and client ID will be
recorded, although the interrupt registers don't appear to be
documented, so I can't check this:-(

However, the bits in the HOTRESET register appear mostly align with
swgroup IDs rather client IDs, so I think some of your explanation above
is innaccurate.

I do want to point out that the HOTRESET bits don't 100% match the
swgroup IDs though, so the driver needs to be careful, and perhaps
contain some kind of mapping table between the two numbering spaces. In
particular, on Tegra114, swgroups and ASID registers appear in order
PPCS, <gap>, SATA, whereas there's no gap between the HOTRESET bits for
PPCS and SATA, assuming the TRM is correct.
