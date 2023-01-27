Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84810F2
	for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 08:58:31 +0000 (UTC)
Received: from unknown (HELO localhost.localdomain)([114.249.61.130])
	by sina.com (172.16.97.35) with ESMTP
	id 63D390C600034FB0; Fri, 27 Jan 2023 16:52:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 68793615073583
From: Hillf Danton <hdanton@sina.com>
To: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	hpa@zytor.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: Re: [RFC] mm: Allow ZONE_DMA32 to be disabled via kernel command line
Date: Fri, 27 Jan 2023 16:55:53 +0800
Message-Id: <20230127085553.5120-1-hdanton@sina.com>
In-Reply-To: <20230127021348.GA3754@hu-cgoldswo-sd.qualcomm.com>
References: <20230126164352.17562-1-quic_c_gdjako@quicinc.com> <555fca66-81b6-3406-eac1-140c00669477@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Jan 2023 18:20:26 -0800 Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> On Thu, Jan 26, 2023 at 07:15:26PM +0000, Robin Murphy wrote:
> > On 2023-01-26 16:43, Georgi Djakov wrote:
> > >From: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> > >
> > >It's useful to have an option to disable the ZONE_DMA32 during boot as
> > >CONFIG_ZONE_DMA32 is by default enabled (on multiplatform kernels for
> > >example). There are platforms that do not use this zone and in some high
> > >memory pressure scenarios this would help on easing kswapd (to leave file
> > >backed memory intact / unreclaimed). When the ZONE_DMA32 is enabled on
> > >these platforms - kswapd is woken up more easily and drains the file cache
> > >which leads to some performance issues.
> > >
> > >Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> > >[georgi: updated commit text]
> > >Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> > >---
> > >The main question here is whether we can have a kernel command line
> > >option to disable CONFIG_ZONE_DMA32 during boot (at least on arm64).
> > >I can imagine this being useful also for Linux distros.
> > 
> > FWIW I'd say that "disabled" and "left empty then awkwardly tiptoed around
> > in a few places" are very different notions...
> > 
> > However, I'm just going to take a step back and read the commit message a
> > few more times... Given what it claims, I can't help but ask why wouldn't we
> > want a parameter to control kswapd's behaviour and address that issue
> > directly, rather than a massive hammer that breaks everyone allocating
> > explicitly or implicitly with __GFP_DMA32 (especially on systems where it
> > doesn't normally matter because all memory is below 4GB anyway), just to
> > achieve one rather niche side-effect?
> > 
> > Thanks,
> > Robin.
> 
> Hi Robin,
> 
> The commit text doesn't spell out the scenario we want to avoid, so I
> will do that for clarity. We use a kernel binary compiled for us, and
> by default has CONFIG_ZONE_DMA32 (and it can't be disabled for now as
> another party needs it). Our higher-end SoCs are usually used with
> 8-12 GB of DDR, so using a 12 GB device as an example, we would have 8
> GB of ZONE_NORMAL memory and 4 GB of ZONE_MOVABLE memory with the
> feature, and 4 GB of ZONE_DMA32, 4 GB of ZONE_NORMAL and 4 GB of
> ZONE_MOVABLE otherwise.
> 
> Without the feature enabled, consider a GFP_KERNEL allocation that
> causes a low watermark beach in ZONE_NORMAL, such that such that
> ZONE_DMA32 is almost full. This will cause kswapd to start reclaiming
> memory, despite the fact that that we might have gigabytes of free
> memory in ZONE_DMA32 that can be used by anyone (since GFP_MOVABLE and
> GFP_NORMAL can fall back to using ZONE_DMA32).

If kswapd is busy reclaiming pages even given gigabytes of free memory
in the DMA32 zone then it is a CPU hog.

Feel free to check pgdat_balanced() and prepare_kswapd_sleep().
> 
> So, fleshing out your suggestion to make it concrete for our case, we
> would want to stop kswapd from doing reclaim on ZONE_NORMAL watermark
> breaches when ZONE_DMA32 is present (since anything targeting
> ZONE_NORMAL can fall back to ZONE_DMA32).
> 
> Thanks,
> 
> Chris.
> 
