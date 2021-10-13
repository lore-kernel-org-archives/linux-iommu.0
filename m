Return-Path: <SRS0=x0pP=PB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52A8C433F5
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 07:58:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C2A60EE9
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 07:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91C2A60EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5DB1A40476;
	Wed, 13 Oct 2021 07:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nEGmm3VyR4zJ; Wed, 13 Oct 2021 07:58:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0570E402C1;
	Wed, 13 Oct 2021 07:58:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D012BC0011;
	Wed, 13 Oct 2021 07:58:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB5E6C000D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 07:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DC6F60773
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 07:58:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZTlsrPTSIDpn for <iommu@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 07:58:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D572B60678
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 07:58:09 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39F3F60D42;
 Wed, 13 Oct 2021 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634111889;
 bh=D9FlrqNI1J8wIJfmRvfYUVMCVcEi1UrNOTrLK4bJETg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NRxFvKTadup6yfexYdKOPpR6RpmuDeoimcFkuQVLeQj8TNVWR0AcnbfvronX8cNWi
 01d2u5PxqTqB17CCZl7xE/iehLLdR/8y+KHn6iJo859xj6SjhcMbFhpVFeatFlfzDK
 uTuflds0qAo1B2X54WQDuZv/nc9/2wpQA5Kw4+7lX2JSpJRTeE3yXGlKAjs01ACCuI
 CWdkToqqJn8vjO0LIIA1hvMTuWQg8Q4wxRNeNJvbYvYCQYzqgQtVcJ9Bi5n7jXw9zs
 ssstPmLZeND++RljfGI19UP/OVJDhBQG9LBSX4pKBR4XL5F40fpNOSejDf81d38TE6
 YXA2jrvIl7Uaw==
Date: Wed, 13 Oct 2021 08:58:03 +0100
From: Will Deacon <will@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] iommu/arm: fix ARM_SMMU_QCOM compilation
Message-ID: <20211013075803.GB6701@willie-the-truck>
References: <20211012151841.2639732-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211012151841.2639732-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Alex Elder <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, John Stultz <john.stultz@linaro.org>,
 Kalle Valo <kvalo@codeaurora.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Oct 12, 2021 at 05:18:00PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> My previous bugfix ended up making things worse for the QCOM IOMMU
> driver when it forgot to add the Kconfig symbol that is getting used to
> control the compilation of the SMMU implementation specific code
> for Qualcomm.
> 
> Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reported-by: John Stultz <john.stultz@linaro.org>
> Link: https://lore.kernel.org/lkml/20211010023350.978638-1-dmitry.baryshkov@linaro.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> In case we want fix it this way after all, here is the patch
> I made. Either this one or Dmitry patch from the link above
> is required for v5.15
> ---
>  drivers/iommu/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c5c71b7ab7e8..3eb68fa1b8cc 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -355,6 +355,14 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
>  	  'arm-smmu.disable_bypass' will continue to override this
>  	  config.
>  
> +config ARM_SMMU_QCOM
> +	def_tristate y
> +	depends on ARM_SMMU && ARCH_QCOM
> +	select QCOM_SCM
> +	help
> +	  When running on a Qualcomm platform that has the custom variant
> +	  of the ARM SMMU, this needs to be built into the SMMU driver.
> +

FWIW, I prefer this solution over changing the driver code, so:

Acked-by: Will Deacon <will@kernel.org>

I assume you'll be getting this fixed for 5.15?

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
