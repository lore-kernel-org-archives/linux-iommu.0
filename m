From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 14/19] iommu/tegra: smmu: Get "nvidia,memory-clients"
	from DT
Date: Fri, 1 Nov 2013 10:03:25 +0200
Message-ID: <20131101100325.caab70438d44cba042fba904@nvidia.com>
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
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 31 Oct 2013 20:39:41 +0100
Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:

> On Thu, Oct 31, 2013 at 07:25:25PM +0000, Stephen Warren wrote:
> > On 10/31/2013 01:16 PM, Stephen Warren wrote:
> > > Hmm. That's interesting. I see that the ARM SMMU has a list of the
> > > clients it affects, whereas this Tegra series puts information into each
> > > client device about the SMMU(s) that affect it. Is it better to flip the
> > > Tegra binding around to match the style of the ARM SMMU?
> > 
> > One question here: How do you ensure that the SMMU driver probe()s
> > before probe() runs for devices affected by the SMMU?
> 
> I think we get away with this by virtue of nobody actually creating IOMMU
> mappings from within drivers, so the ordering is already handled. However, I

Could you explain the above a bit more?

Currently I have a problem that IOMMU(tegra smmu) needs to be
instanciated earlier than other IOMMU'able devices since IOMMU needs
to configure devices IOMMU'ed at their instanciation time.

Now I'm considering to use iommu_bus_notifier or inserting a hook in
dd.c:really_probe() in order to defer a device instanciation til
IOMMU's instanciated.
