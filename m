Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC18C47083
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 20:19:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0709C613D8
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 20:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0709C613D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C06D040534;
	Wed,  2 Jun 2021 20:19:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UKXQ6s2shk2R; Wed,  2 Jun 2021 20:19:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60C0E40531;
	Wed,  2 Jun 2021 20:19:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A689C000E;
	Wed,  2 Jun 2021 20:19:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40CB7C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 20:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F6D94036F
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 20:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="JMBUiMOC";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="Zl4HdgRR"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c5TWAsTuu1Ns for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 20:19:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B82FC400DC
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 20:19:36 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id DBCFD5C0113;
 Wed,  2 Jun 2021 16:19:33 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Wed, 02 Jun 2021 16:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=01wA9S6MZOs7DE06HogddKBNYc8V
 E/C8ZpyOl0QzHAo=; b=JMBUiMOCVqIogGlSZiL/dnjV+EWeSRoOG29ec9pK/uX3
 7vTOeLT0V/JLXPmM/5G1iveLsrJXYsiTp4WBKYMBGp2nq3pZp9kWVSC1Yg6iEuUX
 xlJ+5lP5UNmRC59CK0fImmNjyHi8xHVRqqA1ouRHhBedReAau5oBDLtE6HJVKDPi
 BVajSYOoEUUjDw9N9fCY63QmQ2NtS/UBWdq5OphkmDfXynFzYVfCvmvlurKivP7r
 2F5agGqM2G2e9hU0ntqLg8X2457gUxG+ElV7X2FbRi4WuhCqCpJTWHbM1fZ02fnV
 IjqimwSCmAAgDMpmFHTyA4WFV6Md3xuKulCbkwrMmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=01wA9S
 6MZOs7DE06HogddKBNYc8VE/C8ZpyOl0QzHAo=; b=Zl4HdgRRd7VItVgDDou2zR
 ybof2PLdNR8fyogC4Z77sxp+Mzx930n2xQvF4BVGyEe0vEB2qCvoby7L7g4YdANA
 6EfSrANYxx1nQlsMLNvJrukHGGcI/cO8CBgXD4JjGDvvy5suwQ7E+UCbxi1iEv1a
 jyy6j1MSeO1yHQA9uw6gFTRArHBe0RgxS5ABg8PDXrR9tJYoYVZGnYKBX2GUi/hw
 8cuBv7UsPEkPuDxApJ1wZXTHwHLLRmpEtn+4+WrDonpsWPo8NczBCzf4KF6UGJXq
 nEUGw30K1cnla9bzMoQYsgMibpJirIt0qIdITUJHtWkqxq5jonWYqEqi7yQvicng
 ==
X-ME-Sender: <xms:1ee3YHSpEhsMXNysQrvnt0u74_aCeuziLorgXmXSv9yhhwuBM_lz9g>
 <xme:1ee3YIx6FmLWDzfYy9UR44CphG35xGp97K125_jBrVk5z8JKH3UeBmIplcQSXNP7f
 5MSai_uYTs9JO1jxiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeljedgudegkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnheptddujeettefggedttedvieeufffgudetgeejgffhfeduueevudffueet
 tdetfeefnecuffhomhgrihhnpehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgnecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehs
 vhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:1ee3YM1NHE54ttXXC5Af87-imj8Kz-mFnNUFwbIcWDInOW2bMtIl7w>
 <xmx:1ee3YHC60nNSrfxWhD5VQTLqUtxTimCQTnk3m8w3_r4_PzvFAaoYxA>
 <xmx:1ee3YAjGvd_l6g8ihEU3j-u4adC4QdoS7n3mzbX3sEyxM6_vtlJqkw>
 <xmx:1ee3YLVTDfnjEcY4MkDWlzt8KtUAtbkLPkfqI1K_JRUWdXvOdy-rPg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 4AB6051C0060; Wed,  2 Jun 2021 16:19:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <c72a45e4-c156-4a62-bfd7-9cf8a31ff499@www.fastmail.com>
In-Reply-To: <20200914072319.6091-1-srinath.mannam@broadcom.com>
References: <20200914072319.6091-1-srinath.mannam@broadcom.com>
Date: Wed, 02 Jun 2021 22:18:21 +0200
To: "Srinath Mannam" <srinath.mannam@broadcom.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Joerg Roedel" <joro@8bytes.org>,
 "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>, poza@codeaurora.org
Subject: Re: [PATCH v3] iommu/dma: Fix IOVA reserve dma ranges
Cc: iommu <iommu@lists.linux-foundation.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

I just ran into the exact same issue while working on the M1 DART IOMMU driver
and it was fixed by this commit. Thanks!

Would be great if this could be picked up.

Tested-by: Sven Peter <sven@svenpeter.dev>


Best,


Sven


On Mon, Sep 14, 2020, at 09:23, Srinath Mannam via iommu wrote:
> Fix IOVA reserve failure in the case when address of first memory region
> listed in dma-ranges is equal to 0x0.
> 
> Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible 
> DMA address")
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
> Changes from v2:
>    Modify error message with useful information based on Bjorn's 
> comments.
> 
> Changes from v1:
>    Removed unnecessary changes based on Robin's review comments.
> 
>  drivers/iommu/dma-iommu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 5141d49a046b..5b9791f35c5e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -217,9 +217,11 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>  			lo = iova_pfn(iovad, start);
>  			hi = iova_pfn(iovad, end);
>  			reserve_iova(iovad, lo, hi);
> -		} else {
> +		} else if (end < start) {
>  			/* dma_ranges list should be sorted */
> -			dev_err(&dev->dev, "Failed to reserve IOVA\n");
> +			dev_err(&dev->dev,
> +				"Failed to reserve IOVA [%#010llx-%#010llx]\n",
> +				start, end);
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
