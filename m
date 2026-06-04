Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2AB3E275F
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576352; cv=none; b=Agbo/cH8mWSNLOyEiADfD+Fj33k3eYbbvBNDfWwxNHAVfVvJfYA5o9QCVZ7K6z/hV+U3o6IZcXVvuuVVyHgyOJaGp+SO8Ucl+X2bnHz0krpSJo/3cWUFKqzbwbX4NN7ZadVEaSCf6yJ3k/lDmLMI9DhZnuNOl5ToX/UNOSerXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576352; c=relaxed/simple;
	bh=LnrtZB0iEg1z1vGOmrpOOK3Cssie/DMPDNqDCPjTdS8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGXfIju3R1Xjss/E1LawLvJqBFJOmHQn38Be/3kGQ37G51w4PASYDifZqxynGAfkY/YAKuyg60QZBealzOwrSBJ6KbhvXUa3+J7HyPRUxbW7lrZKQM260X6uxrUJEIfcLsry4TmZplhcmqQcBG+wfPLfT6nGQ4jUxsy9Z6vwtmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cqf3MXV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cqf3MXV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9021F008A2
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 12:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780576350;
	bh=LnrtZB0iEg1z1vGOmrpOOK3Cssie/DMPDNqDCPjTdS8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Cqf3MXV4TD52LTrKp0CEYIe9g985jGUSnNRQCoaqoWqlQrEUsixL6taFahNCfDLy3
	 +Z6as+OOsL9nqoix/FyXeZFm2nSqFAgKe0UdZ200LCLfCzZOsL9e5aeERkfHQuCGQt
	 lbsQ7bKitUjPcn+bHj0GDLNxKoY1a2sN6xy3To0Q9KFC5vgDE0UO/KlEqKmvCmGo2q
	 tQFH3C8Z7JCY1CQ0ki8z08Rb6/Be/+yEVtXg1G5zNpIwheU8ILhcBZYHgFoWppCuwE
	 gB2HgfLQ286akIY4m3Bo3GCPaJEmZyP191eGzCBLL04xi+/lRCrQ3eZvv7giv/r8Wv
	 S0m1gGv5CNe1w==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3967726bc47so6100421fa.1
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 05:32:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ825H0CXVYDaqFQ2xeOxCtwStJFVqOgcqYUs1F3mohxzU8DHuO1CmpAEmm1GVT8sMYpEPxtJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzCwroUoskOYJ7HUuJvE7E1v8ja40m4VwIPqZJPqnAHLMkPzBW
	yv+r0GO84ctesMFwInCfyOQYfVjzmIHwObOnRkv1qzhvrg2qa1p6O2/jai/rsuQISTx0+eO9MV6
	+kXnOtHBqci30HyiWWed/aTI22o5eB1SKq7eDnTRIFA==
X-Received: by 2002:a2e:bc24:0:b0:396:9cbb:673e with SMTP id
 38308e7fff4ca-396af48a101mr25033101fa.24.1780576348691; Thu, 04 Jun 2026
 05:32:28 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 05:32:27 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 05:32:27 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ah9OIVyrHEhcMHzN@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-7-88c324a1b8d2@oss.qualcomm.com> <ah9OIVyrHEhcMHzN@ashevche-desk.local>
Date: Thu, 4 Jun 2026 05:32:27 -0700
X-Gmail-Original-Message-ID: <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
X-Gm-Features: AVHnY4LlXi8ln45MTUjJfpd_YWjp19dT0a-H21-M7Hc7IKBiGWRxgS3l-OaDEEQ
Message-ID: <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
Subject: Re: [PATCH 07/23] driver core: platform: provide platform_device_set_fwnode()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, 
	Thierry Reding <thierry.reding@avionic-design.de>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 23:41:53 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Thu, May 21, 2026 at 10:36:30AM +0200, Bartosz Golaszewski wrote:
>> Provide a helper function encapsulating the logic of assigning firmware
>> nodes to platform devices created with platform_device_alloc(). Make the
>> kerneldoc state that this is the proper interface for assigning firmware
>> nodes to dynamically allocated platform devices. This will allow us to
>> switch to counting the references of the device's firmware nodes in the
>> future, not only the OF nodes.
>
> But why different for of_node and fwnode to begin with?!
>

I'm not following. What are you suggesting?

Bartosz
