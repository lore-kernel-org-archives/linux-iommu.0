Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0F2FA47;
	Thu, 20 Jul 2023 18:53:49 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id E721A3202ADA;
	Thu, 20 Jul 2023 14:53:47 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Thu, 20 Jul 2023 14:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1689879227; x=
	1689965627; bh=UsCIH3GnKiEckT+NRUJpbKBJyrIYS4v+Hkal0eCfojk=; b=D
	hxeJRYr/bgQagplL/v//yrho2U0iMTVVTYTfDxkLDfCFOXYWPVpP1doHILYwdFHR
	P0rg3a+FUY4xED0exa+KcC9tCvsA3u8OV8grScAbWuFiEgdT46EVbmhI64E8aHR2
	2Lx+z9UD1JRvLbJFh/5IvNyu7cKoTb9/jV4uaS9QJGOPm+AAt2lR/Ymd2O4fPLeG
	ri1cWAXHldntSeRiMlsN6Ffz3ncXJ19+ktZmSRevxUtzbPBzzvzwo31bS8eMTWtM
	Kj8PEFISc7bPPoAbvk8hqtPyGpHRehfH1xGwyym8F+Wky/WdGtbM3jdneipcmcva
	y3FOdqOfTGKmgupZbvhNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689879227; x=1689965627; bh=UsCIH3GnKiEck
	T+NRUJpbKBJyrIYS4v+Hkal0eCfojk=; b=nj81Hxud2v8K5nBoY8G1EP0ihpFMZ
	panHSt5GnbkotKZGVaTt/ph3eauYR2Jn9H43kDNEZpOn4yU/3VBeU7Djk0bt1/2k
	Bn6Mlcwo2OfTcZVr4+a2ZniJxunf3BnGAksl4d/wZPryNU9YbXiOUZ2WBAO27KjK
	1ZTAFEG6e3wLmWMlDEykzg7uhB1t7W1hlommUlU/bysAsAoxMCIxMsk0EXK+X1RA
	L484WxmpGwlplr0nwJ/IYqjkSHSTkFhoRmITkHt9OkkZMSy000iX9p9/vRrkIcWg
	ttmerg7/PUxbVoTfADo/oETqnoUFTzQ1+kJtt90gETNseWKXzAyg8f+nQ==
X-ME-Sender: <xms:uoK5ZFf3U6rlFFy0Gtxrw6KQ65ICGPkkzYEuOA3kc4fqVvuio_F77w>
    <xme:uoK5ZDOWIrQ3qYshq6bs4m6k811w-8WjsmMpqOb1F0gUxz6quX1YuQ7icrl7tBacz
    ZYDlMQZo5DbaeCvInA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:uoK5ZOgdEG4IMtWMAmABzHlOeqhnubPZGc0g7_6wS2D3PQjLzdO5HA>
    <xmx:uoK5ZO-Xfl7XRmNp0RSrlftPL21smEC4xXiOINnUleZdtZyi80_23Q>
    <xmx:uoK5ZBsv_4YevPpkEBB0kmwZvmHnK6_rPDbh9--uRLoh6kmvWXIixw>
    <xmx:u4K5ZC8TeiOzwSuuwiKUj4VAakfICD5UbH7zo5KFpSuIUiIJGrEz3w>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 979D8A60077; Thu, 20 Jul 2023 14:53:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Message-Id: <f176c331-f8cf-4a44-8ada-7d9c958b17ca@app.fastmail.com>
In-Reply-To: <20230719222033.117513-1-minhuadotchen@gmail.com>
References: <20230719222033.117513-1-minhuadotchen@gmail.com>
Date: Thu, 20 Jul 2023 20:53:26 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Min-Hua Chen" <minhuadotchen@gmail.com>,
 "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/apple-dart: mark apple_dart_pm_ops static
Content-Type: text/plain

On Thu, Jul 20, 2023, at 00:20, Min-Hua Chen wrote:
> This patch fixes the following sprse warning:

typo: sparse

>
> drivers/iommu/apple-dart.c:1279:1: sparse: warning: symbol 
> 'apple_dart_pm_ops' was not declared. Should it be static?
>
> No functional change intended.
>
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---

Acked-by: Sven Peter <sven@svenpeter.dev>

Thanks,


Sven

>  drivers/iommu/apple-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 8af64b57f048..2082081402d3 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -1276,7 +1276,7 @@ static __maybe_unused int 
> apple_dart_resume(struct device *dev)
>  	return 0;
>  }
> 
> -DEFINE_SIMPLE_DEV_PM_OPS(apple_dart_pm_ops, apple_dart_suspend, 
> apple_dart_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(apple_dart_pm_ops, apple_dart_suspend, 
> apple_dart_resume);
> 
>  static const struct of_device_id apple_dart_of_match[] = {
>  	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
> -- 
> 2.34.1
