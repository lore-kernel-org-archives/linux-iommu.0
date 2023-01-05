Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EF7EA5;
	Thu,  5 Jan 2023 09:45:53 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id C8CAA3200A01;
	Thu,  5 Jan 2023 04:45:51 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Thu, 05 Jan 2023 04:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1672911951; x=1672998351; bh=51
	c0Ws4aE5zuhiM20BTPanynGNXeOuqkek9xxgYiHCQ=; b=UfFaFz9CVYAtKPPoaf
	/dw9VFTAYq4Nc2ofPjWkN+xpYtuwA8K2b65XYmPfdpv1UGkdMx4yxhW6nui6BE2D
	K4n2T/X9FWJO0G40gEMl7ysoA/86IUM8zByodQ2f58Z31CsARndka+mGpB98hk+u
	rCRPAfPJ+YHoH9XzaGyb5W0tdJhrPmOIW/EMZ4EDpEhuOahvbkb02TXI6iIPBP3U
	pDmiLboFvbSxMgdujGTCWRFLdENfHmkASdj4mln5XCgZO10sPEiuIp28P7UI3ALv
	wljAyH7Q5zYMBcwsLRYu6VzELWxwNnSzvrLgkSOoiB3ZnxR96ghGw3MukpsCBbHU
	/qEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1672911951; x=1672998351; bh=51c0Ws4aE5zuhiM20BTPanynGNXe
	Ouqkek9xxgYiHCQ=; b=qjQ+7c0EUdq9qlKGbTx5H+g6AHVyXjVrw+/ksGuW8pe9
	JWbzVxfSMu4YWQpDfwnB3iod0cYZ8iWPe/aTyjO3Yjp2Oro51T7U9SfO63ak1tui
	fUYD6yLe0Rr29xKZZJoSS5ZHuZBEGTWTf0Lev7w0w99VVDT2yc9B1WDcBwnSiKWV
	bxaqOWRPu2yEMv3qrBSDU2Ef8Np9GwvNle8sYSX0SGhqayFkCB6di5DshTINQm1Z
	V6bpLPybCVEUtMa8+dOJAcIPnqwJXJ23ujDEKlbn26nHLJj5BbtCo/xz/YSsztOv
	gAU/vDqZlHrKs2UGviwyM65UH82gindlI+tjHLjsig==
X-ME-Sender: <xms:Tpy2Y7TIiFieamIoccbfuxR-0mRf8GIxks2VA9izr0Yq-bYdwD1DVg>
    <xme:Tpy2Y8xIdfxrB0_Ao0rqVCVeDXX0F8qi1VKIFgOkM0BDYYjx8CHOXaNxQ1lkKAp6K
    18LhqQI4hDkNEipAmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeekgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpedvkeehfeffudehtefftddtgefhjeehgffggffhueegiefhheeihfdvvdel
    hfdtveenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgurghrthekuddutddrphihne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghn
    sehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:Tpy2Yw2fx9ilqALzM2-4-l-b50SvpEqBtmQl5GkHok0_sZ87RmTeEQ>
    <xmx:Tpy2Y7DSw9AVejI2WelEQM0kmtJ79iz2_m8Tz5Td79nOpJIx_ZQPSw>
    <xmx:Tpy2Y0iZLumdlnfvhgeZ_0S6-fWJN7mKJw0g2zjPBYvr4X9xIMtTbA>
    <xmx:T5y2Y5YNDpdUA1QOwdi85QAxxDHch6A38DPRqXM7Yr6AsNaZC_UmcQ>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3E249A6007C; Thu,  5 Jan 2023 04:45:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Message-Id: <bfee5a64-bb7c-43ee-a2ca-7e13421508f4@app.fastmail.com>
In-Reply-To: <fd66fa48-8810-5b8b-c330-8456bdb9de9e@marcan.st>
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-8-marcan@marcan.st>
 <bebc741d-bcbe-4449-9379-be70fd65b0f0@app.fastmail.com>
 <fd66fa48-8810-5b8b-c330-8456bdb9de9e@marcan.st>
Date: Thu, 05 Jan 2023 10:45:29 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Hector Martin" <marcan@marcan.st>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>
Cc: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, "Janne Grunau" <j@jannau.net>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, iommu@lists.linux.dev, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iommu: dart: Add t8110 DART support
Content-Type: text/plain

Hi,

On Thu, Jan 5, 2023, at 06:19, Hector Martin wrote:
> On 2023/01/04 22:50, Sven Peter wrote:
>> Do you have any more details on this registers? For the 8103 DART
>> we called it _CONFIG but I assume for the t8110 DART it can
>> actually lock different parts of the HW instead of just a global lock?
>
> This is based on R's reverse engineering here:
>
> https://github.com/AsahiLinux/m1n1/blob/main/proxyclient/m1n1/hw/dart8110.py#L87
>
> I don't think they ever fully nailed down exactly what the lock bit
> behavior is, though.

Fair enough, I was mostly curious if it was actually _PROTECT and not just
_CONFIG with different bit assignments. Sounds like it does mostly set up
protections though.


Sven
