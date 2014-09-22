From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 04/13 v2] iommu/arm-smmu: Convert to iommu_capable() API
	function function
Date: Mon, 22 Sep 2014 17:36:28 +0200
Message-ID: <20140922153628.GA10438@suse.de>
References: <1409914384-21191-1-git-send-email-joro@8bytes.org>
	<1409914384-21191-5-git-send-email-joro@8bytes.org>
	<20140908165136.GW26030@arm.com> <20140917085312.GE2533@suse.de>
	<20140919164220.GI20773@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140919164220.GI20773-5wv7dgnIgG8@public.gmane.org>
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
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Fri, Sep 19, 2014 at 05:42:20PM +0100, Will Deacon wrote:
> However, I thought about this a bit more and the coherency isn't necessarily
> a global property of the SMMU. In reality, it is dependent on the IOTLBs in
> use by the domain, so it's not going to be possible to report true here in
> many cases.
> 
> That means we'd need a way to say `this device is dma coherent when its
> downstream IOMMU is enabled with IOMMU_CACHE mappings'. For the moment,
> people will probably just add `dma-coherent' to the endpoint and dma-mapping
> will request IOMMU_CACHE mappings regardless of the features advertised by
> the IOMMU. In that case, it might make more sense to return `true' here as
> we can always generated cacheable transactions from the SMMU. The
> dma-coherent property on the device would then indicate whether those
> transactions will snoop the CPU caches.

Okay, when the SMMU can always generate cachable transactions it is
surely fine to return true here. I'll change that before I add the
patches to my tree.


	Joerg
