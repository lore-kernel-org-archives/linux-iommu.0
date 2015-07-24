From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 1/3] Docs: dt: add generic MSI bindings
Date: Fri, 24 Jul 2015 08:04:22 +0100
Message-ID: <20150724080422.48cb64e2@why.wild-wind.fr.eu.org>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
	<1437670365-20704-2-git-send-email-mark.rutland@arm.com>
	<55B131C3.8050009@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B131C3.8050009@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "treding@nvidia.com" <treding@nvidia.com>, "majun258@huawei.com" <majun258@huawei.com>, "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, "tirumalesh.chalamarla@caviumnetworks.com" <tirumalesh.chalamarla@caviumnetworks.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, 23 Jul 2015 19:26:11 +0100
David Daney <ddaney@caviumnetworks.com> wrote:

> On 07/23/2015 09:52 AM, Mark Rutland wrote:
> [...]
> > +MSI clients
> > +===========
> > +
> > +MSI clients are devices which generate MSIs. For each MSI they wish to
> > +generate, the doorbell and payload may be configured, though sideband
> > +information may not be configurable.
> > +
> > +Required properties:
> > +--------------------
> > +
> > +- msi-parent: A list of phandle + msi-specifier pairs, one for each MSI
> > +  controller which the device is capable of using.
> > +
> 
> We say here that "msi-parent" consists of pairs ...
> 
> > +  This property is unordered, and MSIs may be allocated from any combination of
> > +  MSI controllers listed in the msi-parent property.
> > +
> > +  If a device has restrictions on the allocation of MSIs, these restrictions
> > +  must be described with additional properties.
> > +
> > +  When #msi-cells is non-zero, busses with an msi-parent will require
> > +  additional properties to describe the relationship between devices on the bus
> > +  and the set of MSIs they can potentially generate.
> > +
> > +
> > +Example
> > +=======
> > +
> > +/ {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	msi_a: msi-controller@a {
> > +		reg = <0xa 0xf00>;
> > +		compatible = "vendor-a,some-controller";
> > +		msi-controller;
> > +		/* No sideband data, so #msi-cells omitted */
> > +	};
> > +
> > +	msi_b: msi-controller@b {
> > +		reg = <0xb 0xf00>;
> > +		compatible = "vendor-b,another-controller";
> > +		msi-controller;
> > +		/* Each device has some unique ID */
> > +		#msi-cells = <1>;
> > +	};
> > +
> > +	msi_c: msi-controller@c {
> > +		reg = <0xb 0xf00>;
> > +		compatible = "vendor-b,another-controller";
> > +		msi-controller;
> > +		/* Each device has some unique ID */
> > +		#msi-cells = <1>;
> > +	};
> > +
> > +	dev@0 {
> > +		reg = <0x0 0xf00>;
> > +		compatible = "vendor-c,some-device";
> > +
> > +		/* Can only generate MSIs to msi_a */
> > +		msi-parent = <&msi_a>;
> 
> 
> My device-tree syntax foo is a little rusty, but doesn't "msi-parent" 
> need a pair of elements?  This has only the phandle.

This is a pair in the sense of (phandle, msi-specifier).

msi_a doesn't have a #msi-cells, so its msi-specifier is of size 0. In
that case, the pair is (phandle, empty-set).

You could also have something like:

	msi_d: msi-controller@d {
		#msi-cells = <2>;
	};

	dev@f {
		msi-parent = <&msi_d 0x1 0x2>;
	};

and msi-parent in this case would still be a pair, with an
msi-specifier of size 2.

Hope this helps,

	M.
-- 
Without deviation from the norm, progress is not possible.
