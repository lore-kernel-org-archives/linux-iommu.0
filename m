From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] iommu/rockchip: Make use of 'struct iommu_device'
Date: Mon, 03 Apr 2017 11:56:59 +0200
Message-ID: <1785458.LaVlbOJ67B@diego>
References: <1490970624-19981-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490970624-19981-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Am Freitag, 31. März 2017, 16:30:24 CEST schrieb Joerg Roedel:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Register hardware IOMMUs seperatly with the iommu-core code
> and add a sysfs representation of the iommu topology.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

In general works, and I still keep a working iommu-based display :-)
I can also see my two vop iommus under /sys/class/iommu now.

Links in the devices subdirectory do not work though, see below:

> ---
>  drivers/iommu/rockchip-iommu.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 9afcbf7..36d0890 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1054,6 +1056,10 @@ static int rk_iommu_add_device(struct device *dev)
>  	if (ret)
>  		goto err_remove_device;
> 
> +	iommu = rk_iommu_from_dev(dev);
> +	if (iommu)
> +		iommu_device_link(&iommu->iommu, dev);
> +

It looks like the iommu association can very well run before the iommu
actually probes, via the bus_set_iommu and which happens on my veyron-pinky
device). Thus iommu is NULL, as platform_set_drvdata in probe hasn't run yet
and the link is never created.

[    0.034180] iommu: Adding device ff930000.vop to group 0
[    0.034198] rk_iommu_from_dev: found iommu ff930300.iommu for ff930000.vop with data at   (null)
[    0.034209] rk_iommu_add_device: rk_iommu_from_dev returned   (null) for ff930000.vop
[    0.034232] iommu: Adding device ff940000.vop to group 1
[    0.034247] rk_iommu_from_dev: found iommu ff940300.iommu for ff940000.vop with data at   (null)
[    0.034258] rk_iommu_add_device: rk_iommu_from_dev returned   (null) for ff940000.vop
[    0.034342] rk_iommu_probe: set_drvdata for ff930300.iommu at ee2c7a10
[    0.034411] rk_iommu_probe: set_drvdata for ff940300.iommu at ee2c7c10
[    7.326395] rk_iommu_from_dev: found iommu ff930300.iommu for ff930000.vop with data at ee2c7a10


Not sure what the proper solution is though.


Heiko
