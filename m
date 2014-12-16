From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] iommu/exynos: Fix arm64 allmodconfig build
Date: Tue, 16 Dec 2014 21:40:48 +0100
Message-ID: <2060329.N1WYSODiQy@wuerfel>
References: <1418658882-14809-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1418658882-14809-1-git-send-email-broonie@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>, Will Deacon <will.deacon@arm.com>, Krzysztof =?utf-8?B?S296xYJvd3NraQ==?= <k.kozlowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Olof Johansson <olof@lixom.net>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Monday 15 December 2014 15:54:42 Mark Brown wrote:
> The Exynos IOMMU driver uses the ARM specific dmac_flush_range() and
> outer_flush_range() functions. This breaks the build on arm64 allmodconfig
> in -next since support has been merged for some Exynos ARMv8 SoCs. Add a
> dependency on ARM to keep things building until either the driver has the
> ARM dependencies removed or the ARMv8 architecture code implements these
> ARM specific APIs.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> 
> Resending to the arm-soc people since the addition of the Exynos
> platform for ARMv8 went via them, Krzysztof also sent a fix for this
> earlier but it there's been no response.
> 

Applied to fixes branch, thansk!

	Arnd
