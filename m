From: Mark yao <mark.yao@rock-chips.com>
Subject: Re: iommu/rockchip: Fix bugs and enable on ARM64
Date: Fri, 8 Jul 2016 09:01:58 +0800
Message-ID: <577EFB86.1060502@rock-chips.com>
References: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
 <20160627125751.GN11432@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160627125751.GN11432@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Shunqian Zheng <zhengsq@rock-chips.com>
Cc: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, airlied@linux.ie, tfiga@google.com, xxm@rock-chips.com, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 2016=E5=B9=B406=E6=9C=8827=E6=97=A5 20:57, Joerg Roedel wrote:
> On Fri, Jun 24, 2016 at 10:13:25AM +0800, Shunqian Zheng wrote:
>>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 100 +++++++------
>>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   3 +
>>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 221 ++++++++++++++++=
++++++++++--
>>   drivers/gpu/drm/rockchip/rockchip_drm_gem.h |   9 ++
>>   drivers/iommu/Kconfig                       |   2 +-
>>   drivers/iommu/rockchip-iommu.c              | 181 ++++++++++++++++=
+------
>>   6 files changed, 413 insertions(+), 103 deletions(-)
> Applied the IOMMU patches, thanks.
>
>
> 	Joerg
>
>
>
>

Hi Joerg

The drm rockchip patches are dependent on iommu/rockchip patches, can=20
you also apply these patches together? So that can avoid compile proble=
m.

Thanks.

--=20
=EF=BC=ADark Yao
