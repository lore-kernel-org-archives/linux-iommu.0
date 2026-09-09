Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9037CD3A
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938717; cv=none; b=VUUufXQuZzJ6yOFdwho4p9+/KDjEYoiMFuOZbdF2I9CedRJMNnbu6KeGOk+pn4/aLFDqKGYjeWkhlH77+aASI8NC/Ipqg6kDp/ZvkpvEs2bY7+5tKinJIK87WBi/+Mv0F6seX4M/7rh6omeNKwUOGFlH8/e/FXQBjVPAI17n19o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938717; c=relaxed/simple;
	bh=qTb9E1d6q0cOegdRckpD/n7IWePthnjswJ+OhIAzLMs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Sou3KZP29Shv2TyTv4buWvfOhbySlRt4Kix667IE5EMxmmYzUPsEyHZWYyXGUU1km/s00jRUdgShUlLaUyfgiGyDwpUvUGWkbbBRqGsGus0XR/9VoabYY8ETu9n1/6T81gcWShVQRhGhbkrsWu+zAJIhM71irLxwc1kq87fQSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Vtmn40ur; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bxS9OajF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Vtmn40ur";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bxS9OajF"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 1C8731D000BF;
	Wed,  9 Sep 2026 03:25:13 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 03:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788938712;
	 x=1789025112; bh=8yBIz96Sge8xLsyvKzIU/Mju4WGlgoGBjmOnxJXAorM=; b=
	Vtmn40urMu5Pd51CdbHxNvwZeBjhqYTEnXoZ2WA5W+U/TwEenxGyCvTsI7GrbdrC
	Gu87LvqSCva5PHTfUpITMsfrnmOYC2PFiA2gLcBtnSfFISpJ6S45Z0g7Py1QVjoE
	Rmo82vidUV9Jdfv5Ng+tHYoJFuGVMQoMPIPDjH2/Qi2pqfSztdDsKWvVpKHBFZWL
	Ckx1Q8wMAsLcgR4lOckRb2UpDdF6FO6SRm3rD1Dw/Xv5NMkyBcMYCGK8pVa0bbaX
	/7KnK8eqKhUNBJVaOefN9SxfqpIAkLGVnbyyb4i+iQ1QnwQIrgKU1nlcHxvhcHzk
	H7qAdAD7WuElB+cxIRUEsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788938712; x=
	1789025112; bh=8yBIz96Sge8xLsyvKzIU/Mju4WGlgoGBjmOnxJXAorM=; b=b
	xS9OajFrUTiBXxsF3Yok7vO+LzepUBM1heHTG5rXLAzWMfu4ZPkxkJLkXtMQmVX6
	YEdpjznDCxHHc8dR6OxFyQAYgruJFU42WS/xAlOeNr9YCJWkTKpfCAban5PXJcGJ
	WW+XictTyB577PW41Dmbsas2L9+w8uIMkf0GoIoMS42jfvt7AYuNbmrGx9yUSFci
	7rpced4j5BEVrlX8055lVBxMrzqNd2LGEwj3e4Edp5mILGAX0HThcMHRbobPlzCq
	KBYy98MGHq7cajMaRbkF43/yYCUgMUXuG1t7Jszr2B+n04uKPN5V3hTFfEqp3QYn
	cJnNG6s+dZ7ckCdEyU78Q==
X-ME-Sender: <xms:1Amhahmn2-PICZGo-IcbDDqsjyZ_-9T3uQL9Sv9QP1n4uU9HZul-jQ>
    <xme:1AmhanpvQfFcXK3Zp-q6uN8qPr3mKd6G1PhQxC_KLq8aMp0pqBtZltI4rn7AQT0EE
    jL4sTFSVE6R315Y_994p5i40I21ZBb9OxskmXGdkv5n4l1z2Q_84GNS>
X-ME-Proxy-Cause: dmFkZTGtkK4eRTPbNq9kxrVdvLkFgfnmkz7Xk/TDqbWVPMamecVVhZJMCvxjCz+mhHjn8w
    bEAIBRkask7XU8RAMAjchTBr50Ev0jxgBpxEfTFAdlgDJexCPwrtx90CKNyzOHLofrFSmM
    XJT4WKeF17DY6Wx70aHu9ZJhFnH7pY7bp4rS7TWk5L0kfyVq5Rb7gC0F7ew8qyYWWbUsrZ
    9FrSJKCS5ZO95z0xxgZAgnpa+csZCANG/EiBTsMCkTAkxxv34ZcLjMJ7rdvLWc1anve9Fm
    gB10i697Hx2LIbOmChDt3xF8l6LRi5jRoncs7UZ/fow+K2sPaPtJtOa4owaOvLshXqTlNG
    wmHW3ZX0K2BAIz+8jhojT4c8XUib9X0E6WVS6SP9vtOao0cxWtYB1Z+R0CsXH+j8Y7EIey
    3oqIaeDEbFxBYN44BYD0o1h2HnBNHpB59osObPRICG03RpCJYm+lFy/VkmZYJxQcBSSnvN
    ldgHRttO/T7BETW9+FLK5t0isMymedluuVHRAWUbg+TXDm0X1xnRYihAd6q4CxXuDq40zX
    GqeEGojBNaDDMHR9ebl/2wNc20cEW2xtw5W6ofmYglK1ni0ozImvSPgQ19BEmsGtzjgJvs
    9koy3B9Kh74ueD8S+JvjaDxTEO/bIE1VvvB/RNj45uuIy1ljgdN3aBf2qirg
X-ME-Proxy: <xmx:1QmhaiB99jAKTlaXvIBv5AKHXA_Qinhjju6T-q3nNOHAprPpbuix-Q>
    <xmx:1Qmhahe8anSG_aL2BCP7XUoIj6D51_40ofETC7ywImwQlHWr-f3guw>
    <xmx:1Qmhap3vIk_uK_wXhsFQ14eL9S-EZcwxSUazWn8Y2_JPR6NFf0ATcw>
    <xmx:1QmhagjKhDFFWHMRymAKP58jbqO0ZiD7SXDCQuPyCOAs1odD8TdbtA>
    <xmx:2AmhandJy17muZ2myo2uVyJYTvP9PdesPqnNpg1S2_S7qUGSe1e52isW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1C00E32A007E; Wed,  9 Sep 2026 03:25:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AMXrPpDe2nhJ
Date: Wed, 09 Sep 2026 09:24:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Karl Mehltretter" <kmehltretter@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>
Cc: "Nicolas Pitre" <npitre@baylibre.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Robin Murphy" <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <ff220a24-edae-4b75-9873-1a58f5948a01@app.fastmail.com>
In-Reply-To: <20260909064443.90544-1-kmehltretter@gmail.com>
References: <20260909064443.90544-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] ARM: dma-mapping: split cache maintenance at highmem boundary
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 9, 2026, at 08:44, Karl Mehltretter wrote:
> dma_cache_maint_page() processes highmem pages one at a time, but passes
> the complete remaining range to a cache operation when the current page
> is lowmem. If a physically contiguous range starts in lowmem and crosses
> into highmem, the operation continues beyond high_memory through virtual
> addresses which do not map the highmem pages.
>
> On a Raspberry Pi 400 running an ARM32 LPAE kernel, an 8 KiB scatterlist
> entry crossing this boundary caused a deterministic data abort at f0000000
> in v7_dma_clean_range().
>
> Limit the crossing lowmem iteration to the end of its page. Subsequent
> iterations advance page by page until the existing highmem path takes
> over. Keep the bulk operation for ranges contained in lowmem.
>
> Fixes: 43377453af83 ("[ARM] introduce dma_cache_maint_page()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Hi Karl,

I can see how the fix addresses the problem, but I don't yet see
how you can arrive in this situation. What type of memory allocation
can produce a physically contiguous page range from multiple
zones?

      Arnd
