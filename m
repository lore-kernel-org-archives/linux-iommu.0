Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F74219EE;
	Tue, 16 Jun 2026 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603356; cv=none; b=m2T8aOy32XEkUcRUXDFbCS3ZYgLKdB/PbswqA17mV13zBPgl88cCP6F06N9FSBqyLQLgCOhL7vwzTDb8lLDwKznHu5NNnegTIewrAz0XA5rrw1xu36KOeUp6UlC7x+5ck2fM1uz9Eji7IJRtDMsdRw3tNcd8HIUuCWexo1sWBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603356; c=relaxed/simple;
	bh=jiLEocxNQBK6GjMpzXPf7ZOCUOSYAPAZ38ELX1lscIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3/IE1aF/tZT8fTnyRzh0oysFZ/8y/300SoONl2XTjetYoXHqwGg49Yf7HCm6H3vZWIB/cLvPMeZUOr81RA6FoYzRXHP74EAKcPbHIV6UbjYQhHKsySefpWHycxMRibFQ66vemFER31bAqh5L4woeyVczvYQve//BOmSDI2FhsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7Na0aVz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7Na0aVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781603355; x=1813139355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jiLEocxNQBK6GjMpzXPf7ZOCUOSYAPAZ38ELX1lscIw=;
  b=b7Na0aVzmxsst0qzih+eHSXVRsgRYvctY0YhCtdQTHzdleOQRY3GIjMr
   4QkHxR81JXICgnKf/yJ+VNiQ6plLWkIoB1HqABiT9gIUkYcFOWL+LdNeI
   8OQkMH8vggvn9ubeBKOiUmmXwtNhtIHbOK3Ho9Sd2iJ1Mg1q7M0biTAsd
   y8FQXM0D3QsLm4Zd3YqUJe9U2+WmzxwJZrjqWbGkYC8VTZaLGpti6s+rb
   uGkwsx97vY6isSiWnjYJSayEIKG/W6Nl/MPHEmVV/N3PZkINEGcLDzWRC
   rTUD/De7Kt2I8S9lVvHwfTGg0LOh/mrB1d44EJ/grvethZyJBcvTmBrWV
   Q==;
X-CSE-ConnectionGUID: TG9T6mIrSamKXDMc2x2+1g==
X-CSE-MsgGUID: Ah8K0FESSQOWMmdTzYF/8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86265560"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86265560"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 02:49:15 -0700
X-CSE-ConnectionGUID: PsDbiwgJQOK0qFPdNMiIBg==
X-CSE-MsgGUID: FmU0ORA5TbecfDzPUgOXRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="246844027"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 16 Jun 2026 02:49:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6626895; Tue, 16 Jun 2026 11:49:02 +0200 (CEST)
Date: Tue, 16 Jun 2026 11:49:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Lee Jones <lee@kernel.org>,
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
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	driver-core@lists.linux.dev, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 07/23] driver core: platform: provide
 platform_device_set_fwnode()
Message-ID: <ajEcDq0S067wMFaK@black.igk.intel.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-7-88c324a1b8d2@oss.qualcomm.com>
 <ah9OIVyrHEhcMHzN@ashevche-desk.local>
 <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jun 04, 2026 at 05:32:27AM -0700, Bartosz Golaszewski wrote:
> On Tue, 2 Jun 2026 23:41:53 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Thu, May 21, 2026 at 10:36:30AM +0200, Bartosz Golaszewski wrote:
> >> Provide a helper function encapsulating the logic of assigning firmware
> >> nodes to platform devices created with platform_device_alloc(). Make the
> >> kerneldoc state that this is the proper interface for assigning firmware
> >> nodes to dynamically allocated platform devices. This will allow us to
> >> switch to counting the references of the device's firmware nodes in the
> >> future, not only the OF nodes.
> >
> > But why different for of_node and fwnode to begin with?!
> 
> I'm not following. What are you suggesting?

After re-reading of this thread, I think I'm suggesting the same what you have
in plans to do in the future as you put it as "This will allow us to switch to
counting the references of the device's firmware nodes in the future, not only
the OF nodes."

// Offtopic
I haven't heard from you for more than a month on this:
https://lore.kernel.org/r/af18zdP5HF3_P9Vo@black.igk.intel.com
Anything should I do? Please, answer to that thread.

-- 
With Best Regards,
Andy Shevchenko


