From: Joerg Roedel <joro@8bytes.org>
Subject: Re: iommu/rockchip: Fix bugs and enable on ARM64
Date: Fri, 15 Jul 2016 18:16:51 +0200
Message-ID: <20160715161651.GS12639@8bytes.org>
References: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
 <20160627125751.GN11432@8bytes.org>
 <577EFB86.1060502@rock-chips.com>
 <575f6cd7-6e03-e701-78ed-ea2fe9f7573c@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <575f6cd7-6e03-e701-78ed-ea2fe9f7573c@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <mbrugger@suse.com>
Cc: Mark yao <mark.yao@rock-chips.com>, Shunqian Zheng <zhengsq@rock-chips.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, heiko@sntech.de, linux-rockchip@lists.infradead.org, airlied@linux.ie, linux@armlinux.org.uk, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, tfiga@google.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, xxm@rock-chips.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 15, 2016 at 05:32:02PM +0200, Matthias Brugger wrote:
> >The drm rockchip patches are dependent on iommu/rockchip patches, can
> >you also apply these patches together? So that can avoid compile problem.
> >
> 
> While at it. I don't see patch 8 (iommu/Kconfig) in linux-next.
> I suppose you forgot to pick that one.

I picked it up first, but it causes compile errors, so I removed it for
now.


	Joerg
