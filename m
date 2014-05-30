From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Fri, 30 May 2014 21:54:37 +0200
Message-ID: <4462924.8iRbdkOPp7@wuerfel>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com> <4545972.cM7IP1qTXQ@wuerfel> <87tx87rrp2.fsf@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <87tx87rrp2.fsf@nvidia.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Rob Herring <robherring2@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Cho KyongHo <pullip.cho@samsung.com>, Grant Grundler <grundler@chromium.org>, Dave Martin <Dave.Martin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Stephen Warren <swarren@wwwdotorg.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Friday 30 May 2014 22:29:13 Hiroshi Doyu wrote:
> 
> IIUC the original problem, "a master with 8 streamIDs" means something
> like below, where some devices have multiple IDs but some have a
> single. A sinle #address-cells cannot afford those 2 masters at once.
> 
>        iommu {
>                /* the specifier represents the ID of the master */
>                #address-cells = <1>;
>                #size-cells = <0>;
>        };
> 
>         master@a {
>                 ...
>                 iommus = <&smmu 1 2 3>; # 3 IDs
>         };
> 
>         master@b {
>                 ...
>                 iommus = <&smmu 4>;     # 1 ID
>         };

This would not be the usual format really. It should instead be

		iommus = <&smmu 1>, <&smmu 2>, <&smmu 3>;

which can be tedious to type.

> Tegra,SMMU has a similar problem and we have used a fixed size bitmap(64
> bit) to afford 64 stream IDs so that a single device can hold multiple
> IDs. If we apply the same bitmap to the above exmaple:
> 
>        iommu {
>                /* the specifier represents the ID of the master */
>                #address-cells = <1>;
>                #size-cells = <0>;
>        };
> 
>         master@a {
>                 ...
>                 iommus = <&smmu (BIT(1) | BIT(2) | BIT(3))>; # IDs 1 2 3
>         };
> 
>         master@b {
>                 ...
>                 iommus = <&smmu BIT(4)>;     # ID 4
>         };
> 
> The disadvantage of this is that this limits the max number of streamIDs
> to support. If # of streamID is increased later more than 64, this
> format cannot cover any more. You have to predict the max # of streamIDs
> in advance if steamID is statically assigned.
> 

Well, the iommu specific binding could allow a variable #address-cells.
That way, you just need to know the number of stream IDs for that instance
of the iommu.

	Arnd
