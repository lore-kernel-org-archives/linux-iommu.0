Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3BEA5C
	for <iommu@lists.linux.dev>; Tue, 23 Aug 2022 08:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1C7C433C1;
	Tue, 23 Aug 2022 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661242301;
	bh=ZMn1wFd6P28w1tT+WxK1KNO2SOwhs16BL7x3iFsoQk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDj/GuXIV02S+bEtqiVRh31cKYd2KRgbJqbI2xHK6Fro22GKICkJQdRCI8GZU5Yfx
	 +rmwVh+EtTHjIwfJusfxk7xNyZuPuL6MsqLrGEJdEp1S8/w8vCwIa9qOTvH+2Rtrxu
	 1D43pHTzhqyy5+yIGJ90kDGPDg7xi5rdCMfKF+ofRaOdkVnWY1+nRM9SXUa60GWU92
	 btNflJCasnz8Qle5FBlqRVobbWdlpcxaisk/zTZJ/FkllgpaKdiMBNFf9Gudrbp8Gx
	 2KO5FbQwF9aPGpJx1j+EUBRmne2pJ1HPPFOmdRa2MPZLFZSv78iKk5vkdHlT3AbzvH
	 b50Q+R7MKCj/A==
Date: Tue, 23 Aug 2022 09:11:32 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peng Fan <peng.fan@nxp.com>, Luca Weiss <luca.weiss@fairphone.com>,
	Doug Anderson <dianders@chromium.org>,
	Colin Foster <colin.foster@in-advantage.com>,
	Tony Lindgren <tony@atomide.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Revert "iommu/of: Delete usage of
 driver_deferred_probe_check_state()"
Message-ID: <YwSLtPBeOotDSUa8@myrica>
References: <20220819221616.2107893-1-saravanak@google.com>
 <20220819221616.2107893-5-saravanak@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819221616.2107893-5-saravanak@google.com>

On Fri, Aug 19, 2022 at 03:16:14PM -0700, Saravana Kannan wrote:
> This reverts commit b09796d528bbf06e3e10a4a8f78038719da7ebc6.
> 
> An issue was reported[1] on the original commit. I'll need to address that
> before I can delete the use of driver_deferred_probe_check_state().  So,
> bring it back for now.
> 
> [1] - https://lore.kernel.org/lkml/4799738.LvFx2qVVIh@steina-w/

https://lore.kernel.org/lkml/Yv+dpeIPvde7oDHi@myrica/

> 
> Fixes: b09796d528bb ("iommu/of: Delete usage of driver_deferred_probe_check_state()")
> Reported-by: Jean-Philippe Brucker <jpb@kernel.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Tested-by: Jean-Philippe Brucker <jpb@kernel.org>

> ---
>  drivers/iommu/of_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 41f4eb005219..5696314ae69e 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -40,7 +40,7 @@ static int of_iommu_xlate(struct device *dev,
>  	 * a proper probe-ordering dependency mechanism in future.
>  	 */
>  	if (!ops)
> -		return -ENODEV;
> +		return driver_deferred_probe_check_state(dev);
>  
>  	if (!try_module_get(ops->owner))
>  		return -ENODEV;
> -- 
> 2.37.1.595.g718a3a8f04-goog
> 
