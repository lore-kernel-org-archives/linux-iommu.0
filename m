Return-Path: <SRS0=gCe8=2L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FA9C2D0D2
	for <iommu@archiver.kernel.org>; Sat, 21 Dec 2019 23:46:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E4B206C3
	for <iommu@archiver.kernel.org>; Sat, 21 Dec 2019 23:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2F08+kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E4B206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C56698619E;
	Sat, 21 Dec 2019 23:46:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EJtJDrzn96-N; Sat, 21 Dec 2019 23:46:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 53EC685F5E;
	Sat, 21 Dec 2019 23:46:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A0ABC1D7F;
	Sat, 21 Dec 2019 23:46:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 968CAC077D;
 Sat, 21 Dec 2019 23:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 92ACD85DD1;
 Sat, 21 Dec 2019 23:46:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FuGeAU-2OxgM; Sat, 21 Dec 2019 23:46:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com
 [209.85.219.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BE15785F5E;
 Sat, 21 Dec 2019 23:46:41 +0000 (UTC)
Received: by mail-qv1-f65.google.com with SMTP id l14so5045923qvu.12;
 Sat, 21 Dec 2019 15:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DZy1sByRbPp81Fc4unsIfUDkM1speXohHbJEFLa+79Y=;
 b=K2F08+kbBOHpEb5GI2snEkwsgZNjaPXWMKDftdpnSDrNjdoFsaU7mJy1E8X+UN6pTF
 CqMGQGTCVzkASTJTbCKGzwmcE+xGW9X9DoBShnHYBHrUjwA2y0thgfSaIDeXsAsxh80K
 Lzsw/9ErY21ZUOic82HoE2snRWWJy1wLWDPwW7IWmh5yvrdgv4rUVX4xVE004OheL+PI
 /8AUmTvOKwGIU5Ku/sIm9m5U0rOim/SPjYy3gzVxef0QWGwTj1JJt9SDEH83TWoChVOq
 wLkEyhYrjgWcWjYym7iQAuL3qcxgGsX3JQNmgv7pU5p9IHVMooy6My1cg5SbonFnCmxX
 Fqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=DZy1sByRbPp81Fc4unsIfUDkM1speXohHbJEFLa+79Y=;
 b=ctCPI8wPxUlB75TqvCRzc8SupBLKRI8jM5M4x5+p8EDOdz6iID9/1za0g8xBz08g5Q
 ihshq05VZnAYzlpglL85B7pcT1jxQk3RieJzivlLkZdXq1gDTPPoerNh+s5dY7zXvOpA
 vfeVvM/628XJOm5hrM1f3/LInw1fhGF57Cenl6mXLdwxR7lIFSitH/IAbWxHLKLV0Srh
 SMSJRtKwlEFd7JOn2bLQkZe0gYQQmz0Ow5R9lc/c66pyTux+3IPp6cUgb186TgcKIsLG
 CbVdiUXF6Du3tVs+Fu5Dsg573OVFjluJ7hlNlNbEF1uCToyeB6wGVX1BqwNrofI3CyIe
 VKfA==
X-Gm-Message-State: APjAAAXhZTKflrfVJuEkJ1MqyXZOBU8Xdqglk/SmBepLkFzVlj4iSrXw
 ZumQ/uP1yoPcwaXiMxcBEVQ=
X-Google-Smtp-Source: APXvYqxZv5pvU+COa+Z57bqd7TVlj3AKMVnWrlNSwtaonBLRwl6oAVA7CbZzWjXYXul1zP2Wc7+ZAQ==
X-Received: by 2002:a05:6214:14b3:: with SMTP id
 bo19mr18216129qvb.93.1576972000657; 
 Sat, 21 Dec 2019 15:46:40 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
 by smtp.gmail.com with ESMTPSA id b7sm4323472qkh.106.2019.12.21.15.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Dec 2019 15:46:40 -0800 (PST)
From: Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date: Sat, 21 Dec 2019 18:46:37 -0500
To: Tom Murphy <murphyt7@tcd.ie>
Subject: Re: [PATCH 1/8] iommu/vt-d: clean up 32bit si_domain assignment
Message-ID: <20191221234635.GA99623@rani.riverdale.lan>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <20191221150402.13868-2-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191221150402.13868-2-murphyt7@tcd.ie>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 iommu@lists.linux-foundation.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
 Andy Gross <agross@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

On Sat, Dec 21, 2019 at 03:03:53PM +0000, Tom Murphy wrote:
> In the intel iommu driver devices which only support 32bit DMA can't be
> direct mapped. The implementation of this is weird. Currently we assign
> it a direct mapped domain and then remove the domain later and replace
> it with a domain of type IOMMU_DOMAIN_IDENTITY. We should just assign it
> a domain of type IOMMU_DOMAIN_IDENTITY from the begging rather than
> needlessly swapping domains.
> 
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> ---
>  drivers/iommu/intel-iommu.c | 88 +++++++++++++------------------------
>  1 file changed, 31 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 0c8d81f56a30..c1ea66467918 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5640,7 +5609,12 @@ static int intel_iommu_add_device(struct device *dev)
>  	domain = iommu_get_domain_for_dev(dev);
>  	dmar_domain = to_dmar_domain(domain);
>  	if (domain->type == IOMMU_DOMAIN_DMA) {
> -		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
> +		/*
> +		 * We check dma_mask >= dma_get_required_mask(dev) because
> +		 * 32 bit DMA falls back to non-identity mapping.
> +		 */
> +		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY &&
> +				dma_mask >= dma_get_required_mask(dev)) {
>  			ret = iommu_request_dm_for_dev(dev);
>  			if (ret) {
>  				dmar_remove_one_dev_info(dev);
> -- 
> 2.20.1
> 

Should this be dma_direct_get_required_mask? dma_get_required_mask may
return DMA_BIT_MASK(32) -- it callbacks into intel_get_required_mask,
but I'm not sure what iommu_no_mapping(dev) will do at this point?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
