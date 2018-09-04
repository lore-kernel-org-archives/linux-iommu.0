From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 09/19] memory: tegra: Adapt to Tegra20 device-tree binding changes
Date: Tue, 4 Sep 2018 11:56:22 +0300
Message-ID: <201809041156.22715.digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com> <20180818155430.5586-10-digetx@gmail.com> <1536008759.25080.2.camel@toradex.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536008759.25080.2.camel@toradex.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tuesday 04 September 2018 00:06:01 Marcel Ziswiler wrote:
> On Sat, 2018-08-18 at 18:54 +0300, Dmitry Osipenko wrote:
> > The tegra20-mc DT binding has been changed, GART has been squashed
> > into Memory Controller and now the clock property is mandatory for
> > Tegra20. Adapt driver the to DT changes.
>
> Minor nitpick concerning the commit message:
>
> Adapt driver to the DT changes.

Yes, thank you.
