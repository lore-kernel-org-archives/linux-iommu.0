Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F61DF99C
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761529826; cv=none; b=DyI2dFe6ll8YqKzVSWNnYZWRV61ef3P/xuK2I1rx5mpDhhPaoiOdUlJcQraYe3U/OQAa54scjG+7ZjVqahkfRFKklfJLeROZbe9W21ztDrfKXfxMJV8s+0BJDT14gb3xogFZA4LVs58ODvMRCwkg0fc5cZiHG5WTMEjSogW71iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761529826; c=relaxed/simple;
	bh=T3pkaI/GJuOsGFoVg5/R4SNriMbvV6bNB454qQaWZQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQAtezO5/4R5PaFcURhdb+93yXLU+udan6DUbahneHDgX/tNmJex+Mke+1RBYEhRPCdTQtpFYVYGW3k9xfSjG6MMT3IG2qPcZH8u8Y5hYyWMc4lpOmj2P73Rc39u6BD9t3mIJRCkwzeaPMTfrHZTzOfKeXirCwGEodO4oyF1bIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGh8KZyF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGh8KZyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761529824; x=1793065824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T3pkaI/GJuOsGFoVg5/R4SNriMbvV6bNB454qQaWZQ8=;
  b=eGh8KZyF3XNe+RFOMymhBNZHWav5SMty52zqCNFPzFdn2ZV+OGYudH7d
   aVNjV3NJVoUQbVH95r3G6+Q1X3lW/+9Kb+giK8mRJ3dddGCEOV4OJ260/
   vWwQQpAEoTo7CroR9wXzCesXplvVMjSrNG0/QtK44S1o+cOtwuR3H1q3t
   WbtTkwDWNfN3XknfqMD0/JJK1hFbIEQs2zcGrm6QHxwj6KcO033ErKLKI
   9SnZnQZSD9cnvOnvutvdHfdyEtyR/M9ubO7Jt8VZ+09/b2F3nD3OC2J2r
   W36HpQn+bLym7ZsduQ7P7vWOJgVvWqy0uKrWmPCyYTARJjFB2HTGPSaHF
   A==;
X-CSE-ConnectionGUID: uZ2I4kw7SJGkJHzZ8mrGwQ==
X-CSE-MsgGUID: QzImxWOQSZis2ctFD5H4Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63702038"
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="63702038"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 18:50:23 -0700
X-CSE-ConnectionGUID: RqD3PVgcSpO3hdFc8HdBsw==
X-CSE-MsgGUID: bAZX7S5kQLGkCNKy4yStdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="188967609"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2025 18:50:09 -0700
Date: Mon, 27 Oct 2025 09:36:28 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Guenter Roeck <linux@roeck-us.net>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Georgi Djakov <djakov@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove extra blank lines
Message-ID: <aP7MnJ8mIlZhT//S@yilunxu-OptiPlex-7050>
References: <20251023143957.2899600-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023143957.2899600-1-robh@kernel.org>

On Thu, Oct 23, 2025 at 09:37:56AM -0500, Rob Herring (Arm) wrote:
> Generally at most 1 blank line is the standard style for DT schema
> files. Remove the few cases with more than 1 so that the yamllint check
> for this can be enabled.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

[...]

>  Documentation/devicetree/bindings/fpga/fpga-region.yaml      | 5 -----

Acked-by: Xu Yilun <yilun.xu@intel.com>
