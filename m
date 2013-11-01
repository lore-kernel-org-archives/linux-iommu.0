From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 14/19] iommu/tegra: smmu: Get "nvidia,memory-clients"
	from DT
Date: Fri, 01 Nov 2013 10:08:52 -0600
Message-ID: <5273D214.90106@wwwdotorg.org>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
	<1382092020-13170-15-git-send-email-hdoyu@nvidia.com>
	<52718BB4.4090007@wwwdotorg.org>
	<20131031.101808.1830527808656695540.hdoyu@nvidia.com>
	<20131031174028.GF3037@kartoffel> <5272AC82.6080205@wwwdotorg.org>
	<5272AEA5.7020200@wwwdotorg.org>
	<20131031193941.GB31516@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131031193941.GB31516-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/31/2013 01:39 PM, Will Deacon wrote:
> On Thu, Oct 31, 2013 at 07:25:25PM +0000, Stephen Warren wrote:
>> On 10/31/2013 01:16 PM, Stephen Warren wrote:
>>> Hmm. That's interesting. I see that the ARM SMMU has a list of the
>>> clients it affects, whereas this Tegra series puts information into each
>>> client device about the SMMU(s) that affect it. Is it better to flip the
>>> Tegra binding around to match the style of the ARM SMMU?
>>
>> One question here: How do you ensure that the SMMU driver probe()s
>> before probe() runs for devices affected by the SMMU?
> 
> I think we get away with this by virtue of nobody actually creating IOMMU
> mappings from within drivers,

Where are the mapping set up? What prevents that action from happening
before the IOMMU is set up and the various devices have their DMA ops
hooked through the IOMMU? It's fairly clear how deferred probe of client
devices could achieve that, but I'm quite unsure how some what other
mechanism would ensure that.

> so the ordering is already handled. However, I
> also have a patch queued to move the SMMU initialisation to a
> subsys_initcall. I'm not particularly fond of that, but it seems to be the
> done thing (even for other architectures).

We've been trying very hard not to rely on initcall ordering to solve
issues like this, simply it doesn't scale to complex use-cases, and
different HW/drivers/... might have conflicting requirements that aren't
possible to solve by tweaking initcall levels. It seems much more
preferable to use something that's guaranteed to work and adapt to any
situation, such as deferred probe.
