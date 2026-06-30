Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248F40FD99
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825741; cv=none; b=dxs3ZF7mSAkcmDA6AzYzIiX88WAm7SjsVtpy5qr/mFzHDMmKjOVP7fj+TfSRbqPeD1vW8toBXquzNtGiiHFOkHW9h+hsROzS7a2eviDj0B2zCPbOOb4ko1c/7RbFUi3COXoGIupib2vMepk2+2aWIfY++OvQA2uq9mibeBMQDsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825741; c=relaxed/simple;
	bh=Yu5mqQ8nw8gfVDomx+A+E2dr0aoWMwEfUHHcXE5j1Sc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOVw3s3ThjxTu6bW+DwtTIHLgftEHxs2S5gl1VvUU6B5jJQ+a9GKd7ryOAWNvGQVCJAYXXkYqgXuh+BYJgkV4IXyvRqBoo47jSMcG9NWSbWIpyJjoA3MPK9UqolitHGgdATn7qI7N5UXApq81xlFHBe4dM7jf6OZCPJxj8oDBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwMqGpzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwMqGpzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58921F0155B
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782825739;
	bh=siJF0S+CSX6SKMbF6lhMt/C1v2E/StqLW87OFuT5mug=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=AwMqGpzZSvDnV5vSM2z0wkwmPZcuy6Z0HxhXFqaldHKlF6D4sOyHQK4L/B0fF/itF
	 Z9C2BVuksw1mr1+6ch02R+Zz8gUAI5fDmwZjU0wGMt2h6Gvq8cC5ZOCtMOofX5R+yU
	 1Hy/oyLq2B0fQTEZyfgl3xfrexpVhETu+CQgBxy7/99a3XMItUDuxVCBl4oiSjn1eD
	 o38KeGOoUlFVb5zZeSXv+WtlmGXFDo9Wxn8ecfVThX04SgSmZnYMsm+XWmLmYZpjIC
	 zdm9J6iEsk3ibRX/F7HoLCPZU+tHrUTrb8Qp73PbRYfYDyWDS2X2Ru7diIgwCebdnz
	 9GKoHZxfVlf+A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aebf9a509eso501121e87.3
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 06:22:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpS7NBmprC5BoE3InaUH8oPocwO4BCN1HZ0yM2C5iHimQcaXsGliSIGTkwNAIRFeBYpG775EA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIbmgk9vBh/eiDKQaFHN4Mw6PBIbwK+krxkLWziLeJzAR3ifax
	TL9uzUPdOjce4CtSifTHf35RG0uNL4/mwai9mRCQ7fBYLoyDc8ODq1QNRSLPmIiY75/sjNlU/4R
	+SXqHZmUup0oLXmNN3q4NVa21irtLkSiUSQx7rfUM1A==
X-Received: by 2002:a05:6512:8041:b0:5ad:4f1c:8e50 with SMTP id
 2adb3069b0e04-5aebdba2f7fmr745427e87.37.1782825738263; Tue, 30 Jun 2026
 06:22:18 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 09:22:16 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 09:22:16 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <263f58b418a27a2339fc2478f93234e0208b0ad9.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
	 <20260629-pdev-fwnode-ref-v2-2-8abe2513f96e@oss.qualcomm.com> <263f58b418a27a2339fc2478f93234e0208b0ad9.camel@mailbox.org>
Date: Tue, 30 Jun 2026 09:22:16 -0400
X-Gmail-Original-Message-ID: <CAMRc=MdQURjypSn+QjSDJfEiOMC8bbEZmZLgjpt=EquAM1Q1pw@mail.gmail.com>
X-Gm-Features: AVVi8CeQXBZd5M2B6MhLUb095jshYyZGAJu3z11iktq0q6r491Qj_z_hr6U3W70
Message-ID: <CAMRc=MdQURjypSn+QjSDJfEiOMC8bbEZmZLgjpt=EquAM1Q1pw@mail.gmail.com>
Subject: Re: [PATCH v2 02/19] driver core: platform: provide platform_device_set_of_node()
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@avionic-design.de>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
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
	Krzysztof Kozlowski <krzk@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jun 2026 13:37:54 +0200, Manuel Ebner <manuelebner@mailbox.org> said:
> On Mon, 2026-06-29 at 11:12 +0200, Bartosz Golaszewski wrote:
>> [...]
>>
>> +/**
>> + * platform_device_set_of_node - assign an OF node to device
>> + * @pdev: platform device to add the node for
>> + * @np: new device node
>> + *
>> + * Assign an OF node to this platform device. Internally keep track of the
>> + * reference count. Devices created with platform_device_alloc() must use this
>> + * function instead of assigning the node manually.
>
> Doesn't it make sense to add a remark to the kernel doc of platform_device_alloc()?
>
> Thanks
>  Manuel
>
>>  [...]
>

Sure, will do in the next iteration.

Bart
