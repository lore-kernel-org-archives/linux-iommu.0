From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document of Exynos System MMU
Date: Sun, 27 Apr 2014 20:23:06 +0200
Message-ID: <4447051.OnJtcFSqFV@wuerfel>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com> <1398584283-22846-12-git-send-email-shaik.ameer@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1398584283-22846-12-git-send-email-shaik.ameer@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Shaik Ameer Basha <shaik.ameer@samsung.com>, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kgene.kim@samsung.com, prathyush.k@samsung.com, grundler@chromium.org, joro@8bytes.org, supash.ramaswamy@linaro.org, tomasz.figa@gmail.com, joshi@samsung.com, sachin.kamat@linaro.org, s.nawrocki@samsung.com, Varun.Sethi@freescale.com, a.motakis@virtualopensystems.com, pullip.cho@samsung.com, t.figa@samsung.com, rahul.sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

On Sunday 27 April 2014 13:07:43 Shaik Ameer Basha wrote:
> +- mmu-masters: A phandle to device nodes representing the master for which
> +               the System MMU can provide a translation. Any additional values
> +              after the phandle will be ignored because a System MMU never
> +              have two or more masters. "#stream-id-cells" specified in the
> +              master's node will be also ignored.
> +              If more than one phandle is specified, only the first phandle
> +              will be treated.

This seems completely backwards: Why would you list the masters for an IOMMU
in the IOMMU node?

The master should have a standard property pointing to the IOMMU instead.

We don't have a generic binding for IOMMUs yet it seems, but the time is
overdue to make one.

Consider this NAKed until there is a generic binding for IOMMUs that all
relevant developers have agreed to.

	Arnd
