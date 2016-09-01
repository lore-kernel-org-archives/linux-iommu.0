From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 00/19] Generic DT bindings for PCI IOMMUs and ARM SMMU
Date: Thu, 1 Sep 2016 20:05:19 +0100
Message-ID: <20160901190518.GZ6721@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 23, 2016 at 08:05:11PM +0100, Robin Murphy wrote:
> At long last I've finished the big SMMUv2 rework, so here's everything
> all together for a v5. As a quick breakdown:
> 
> Patches 1-3 are the core PCI part, all acked and ready to go. No code
> changes from v4.
> 
> Patch 4 is merely bugfixed from v4 for simplicity, as I've not yet
> managed to take as close a look at Lorenzo's follow-on work as I'd like.
> 
> Patches 5-7 (SMMUv3) are mostly unchanged beyond a slight tweak to #5.
> 
> Patches 8-17 are the all-new SMMUv2 rework.
> 
> Patch 18 goes along with the fix already in 4.8-rc3 to help avoid 64-bit
> DMA masks going wrong now that DMA ops will be enabled.
> 
> Finally, patch 19 addresses the previous problem of having to choose
> between DMA ops or working MSIs. This is currently at the end as
> moving it before #17 would require a further interim SMMUv2 patch, and
> a 19-patch series is already quite enough...

So this is all looking pretty good to me, modulo the handful of comments
to address. The arm-smmu.c changes are pretty tough to review, given the
necessary amount of refactoring to get where you want to get, but the
end result looks good and the series does bisect.

Thanks,

Will
