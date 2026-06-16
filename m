Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6840E8C1;
	Tue, 16 Jun 2026 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602882; cv=none; b=a6IF4rS1pgKoOtpoeMy8/3M/kFumsKgLN6zoXioeKhGOSV0Ay7dRtqqhZOa+8ZV5fVnlL1xdt2Y3Z5h20ysT2ijNH10wJ79PAW/+xYWzXZ+LkCUhZc7O6KAlJUerg/vWU0qb3W3ku4nXZhL0qZHXkHM68n+K/ApnR1JxUFKfUbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602882; c=relaxed/simple;
	bh=6rB2N++QnF7JTGORtVke61SAOuu1kszVTJ+rWarYgM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGCPk4XwLTi6Ao9fhonxjtVTkQaAxxM1chdO65ZRODVeI29b025wgI6bPyDg64BcpTFKj3fVtpOX4U43bpM4dR0D9C/nWtxM2aQT9qmGkIfihEYXsSXF8NW3rpTGzZZytecvP8OVxMxffDiaYOkzHV6SY0nmGbDMLtGYkm2hIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAPLlaYa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAPLlaYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781602881; x=1813138881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6rB2N++QnF7JTGORtVke61SAOuu1kszVTJ+rWarYgM8=;
  b=eAPLlaYaaU80e0Mt9fmlQwwRZ5Gku+D2oUcf+KJXTAqWfqwH4GLyoQIG
   7KhOdiynaaDxuz+8dSqDbb4b7UNtEYZ9ZnxDkNPbjKOpvwtUyUwOBrD6J
   CDkNr8Q6rgZRa3CXRRvoKqOIItZ3Gd+gvjXETyniJTC6hanIPxxCLfP7C
   Rsh51Xkutr8CO7jrfO/OiRyteDldW+M06xeUduSPg1nO1YeOYrthJKqe6
   WDE2W6KZMm59N3GiytqMlY2TRBTODhAQMAe4o1X93NnAjWXuC26c1uPXX
   XdjzNa1Ja1iNdyVFYM0BE7Rndkdumanb7pybjUnTPxocES5UFnUexUD77
   g==;
X-CSE-ConnectionGUID: O+YiRHYnTiCl9HZWvTN1Sw==
X-CSE-MsgGUID: qEsjMQevRYOcDKXBR62+Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="69908019"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="69908019"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 02:41:20 -0700
X-CSE-ConnectionGUID: AnrLxaW9TzuUK3u43KSRLQ==
X-CSE-MsgGUID: M1WMwv/PSYC4Tunnc2YqKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="251644879"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 16 Jun 2026 02:41:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id AD51695; Tue, 16 Jun 2026 11:41:08 +0200 (CEST)
Date: Tue, 16 Jun 2026 11:41:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Lee Jones <lee@kernel.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Peter Chen <peter.chen@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	driver-core@lists.linux.dev, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 08/23] driver core: platform: provide
 platform_device_set_of_node_from_dev()
Message-ID: <ajEaNFhntZTS-w3e@black.igk.intel.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com>
 <ah9O15bMlAYgSlHx@ashevche-desk.local>
 <aiK-EXwp_xhcbty9@hovoldconsulting.com>
 <aiLi0KZskrCyEYO5@ashevche-desk.local>
 <aiZpJkQBXg2pcczy@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiZpJkQBXg2pcczy@hovoldconsulting.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 08, 2026 at 09:03:02AM +0200, Johan Hovold wrote:
> On Fri, Jun 05, 2026 at 05:53:04PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 05, 2026 at 02:16:17PM +0200, Johan Hovold wrote:
> > > On Wed, Jun 03, 2026 at 12:44:55AM +0300, Andy Shevchenko wrote:
> > > > On Thu, May 21, 2026 at 10:36:31AM +0200, Bartosz Golaszewski wrote:
> > > > > Provide a platform-specific variant of device_set_of_node_from_dev(). In
> > > > > addition to bumping the reference count of the OF node being assigned,
> > > > > it also assigns the fwnode of the platform device.
> > > > 
> > > > Can we rather investigate the way how to make that of node reuse thingy
> > > > (which is used solely by pin control) differently and then drop this confusing
> > > > device_set_of_node_from_dev() call altogether?
> > > 
> > > No, that call is needed. See commit 4e75e1d7dac9 ("driver core: add
> > > helper to reuse a device-tree node") for details.
> > 
> > Bart fixes the problem with the platform driver. At the result this will be
> > the only device_set_node() + 'reused = true'.  As for 'reused' flag, the need
> > is only for pinmux/pin control stuff.
> 
> And any other resource which may (eventually) be claimed by driver core
> or bus code.
> 
> > The question here is if there is a better
> > way to make that 'reused' be done automatically without need of setting some
> > flag explicitly.
> 
> That's not really relevant to the series at hand.

It's not, but it's relevant in a long-term for understanding how we can get
this done in a better way.

> If this is something we want to merge then you need to continue setting
> the flag in order not to cause regressions.

Yes, that's how it's now.

-- 
With Best Regards,
Andy Shevchenko


