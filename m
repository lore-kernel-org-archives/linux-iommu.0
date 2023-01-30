Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C06AA3;
	Mon, 30 Jan 2023 18:17:12 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 19B1B3200754;
	Mon, 30 Jan 2023 13:17:11 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Mon, 30 Jan 2023 13:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1675102630; x=1675189030; bh=Mz
	vXpXVQ21A6NwgnOt1kJcDGD5oCZ5wPe9HTihkI7YA=; b=lpMju/Li70QJB6+w5u
	ye7IultwKy8iSRFP1/zQEFi7oHr5Es/lvcQXbo8o8AMv5BaVMiZk9uQBBCBxD3Lt
	MS2lb3TR0G8LQlBMcR5LfhWP4dIJSjk/2N/I7xhwbc+mjT06lHqp6/ITGx1jG4+S
	N6/M0GrW/Bw+jcYH2CQKCD7NrnLwC/LfepknlKbgtP6YGGTFUpU5myiDbtDdbxV6
	OXmDOAUXnMzBk9NFHBiheQh1hAtDfb6ga82lT/ISfa0j575Q4XSPR//dRGatt1T7
	Kwuf3cvdzoNAcW8kQjV98Ej9UC8rVJfLoUTLonlJozwevr9ikdzCFa9Z4faduG3X
	cu2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1675102630; x=1675189030; bh=MzvXpXVQ21A6NwgnOt1kJcDGD5oC
	Z5wPe9HTihkI7YA=; b=C4FUfKGRYLcxbSI8bIh9PPbQV4mZrT278z+BnJKeLXQJ
	zIl59/SlaoyVOhrBimeexZ9nQTxMPbH4p+0TLmxqQgZ/naVeFud2zriPROLXd1wW
	Yi5U82ab4m9Drp2/+Lnwk5wnGk31z/TtdCn1REAocHZgZChUQ2FxCKTZMVeSiaA0
	GGiyg4OeuO9k8DS60DRCBdC/R0kYs8h8fX/TyFmWhDo9B4Qix2cIZPW7T9YE/r63
	tIGQWI5jeVJ12j9xWJ1L3u1D0mJiV//Tw/tISOo2KxYM9F6AHWEGvPNouROwIVyP
	VAMk663Zo8irSAkz+Fnnv32KQncGS9KEldMdydO5Ow==
X-ME-Sender: <xms:pQnYY5VYQwh-FJvukvTPbeinj7dtEtlUF3d5x2bPgD3JAGl8eJG5bA>
    <xme:pQnYY5mxlC1f7H7TDMzUIznu-HLUHlVk93FOoL-3Dz0ov_HxoZsecHpOiyc-GdUWS
    p_5G8QubZEE03hpsZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    vhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtf
    frrghtthgvrhhnpeeggeekkedtjeevieetffdvudfggfegueduhedvgfdtvddugfejtdeu
    uddvveeuveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghr
    rdguvghv
X-ME-Proxy: <xmx:pQnYY1ZsS15QYSphu99sQdf-6ervy0dD-wbdf14tD9bAQaC6HeKhBw>
    <xmx:pQnYY8XQnaHAXNWiInznzvJ8wQaId3i5McXQ7PH3wYNDBjz8EN7UsA>
    <xmx:pQnYYzmmoiHW3zMVa4Aot8oSGIP2EYhJkkc09Tqop4YKWdUT2H7DGw>
    <xmx:pgnYY14Wpha4mfyex5uLvqEqfkFLKV3UkrVEsWWUmL87XgwXVqh7pw>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 88FE5A6007C; Mon, 30 Jan 2023 13:17:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-106-gfe3ab13a96-fm-20230124.001-gfe3ab13a
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Message-Id: <33081a24-2d23-4e28-8e4d-1db74191ca23@app.fastmail.com>
In-Reply-To: <20230130165350.58533-1-ecurtin@redhat.com>
References: <20230130165350.58533-1-ecurtin@redhat.com>
Date: Mon, 30 Jan 2023 19:16:49 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Eric Curtin" <ecurtin@redhat.com>, asahi@lists.linux.dev
Cc: "Dan Carpenter" <error27@gmail.com>, "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>,
 "moderated list:ARM/APPLE MACHINE SUPPORT" <linux-arm-kernel@lists.infradead.org>,
 "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
 "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu: dart: DART_T8110_ERROR range should be 0 to 5
Content-Type: text/plain

Hi,


On Mon, Jan 30, 2023, at 17:53, Eric Curtin wrote:
> This was detected by smatch as one "else if" statement could never be
> reached. Confirmed bit order by comparing with python implementation [1].
>
> drivers/iommu/apple-dart.c:991 apple_dart_t8110_irq()
> warn: duplicate check 'error_code == ((((1))) << (3))'
>   (previous on line 989)
>
> Link: https://github.com/AsahiLinux/m1n1/commit/96b2d584feec1e3f7bfa [1]
>
> Fixes: d8bcc870d99d ("iommu: dart: Add t8110 DART support")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Eric Curtin <ecurtin@redhat.com>
> ---
>  drivers/iommu/apple-dart.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index efe877842f72..3adacf4094d7 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -112,15 +112,15 @@
> 
>  #define DART_T8110_ERROR_MASK 0x104
> 
> -#define DART_T8110_ERROR_READ_FAULT BIT(4)
> -#define DART_T8110_ERROR_WRITE_FAULT BIT(3)
> +#define DART_T8110_ERROR_READ_FAULT BIT(5)
> +#define DART_T8110_ERROR_WRITE_FAULT BIT(4)

this looks good!

>  #define DART_T8110_ERROR_NO_PTE BIT(3)
>  #define DART_T8110_ERROR_NO_PMD BIT(2)
>  #define DART_T8110_ERROR_NO_PGD BIT(1)
>  #define DART_T8110_ERROR_NO_TTBR BIT(0)
> 
>  #define DART_T8110_ERROR_ADDR_LO 0x170
> -#define DART_T8110_ERROR_ADDR_HI 0x174
> +#define DART_T8110_ERROR_ADDR_HI 0x175

this doesn't. 0x174 already is the correct offset.


Thanks,


Sven

