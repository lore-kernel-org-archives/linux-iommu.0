Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E91C4332F
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 01:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56A6A84306;
	Thu, 24 Mar 2022 01:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7uu3dSumSLZu; Thu, 24 Mar 2022 01:10:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 324E284259;
	Thu, 24 Mar 2022 01:10:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E78AEC001A;
	Thu, 24 Mar 2022 01:10:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B824C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 01:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6689084294
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 01:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a2VyX8xEiy3a for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 01:10:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A80A384259
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 01:10:05 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id p25so2489776qkj.10
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 18:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yB8Xhdcr1UmQH8x5bcI6sm+S/MTI1xulItthpHA07WI=;
 b=McdUogDwPYB9swFBm2FXkncFErKcszgRCGc2+vf+t4VBJPShVyXnSPpMv3YcxJWDED
 F3EzvLFhmqSIaYRhQoJJKcNqwxUThjiXAKoIAvLd0tBsCL0kSGVwJ2Vjr/7rmxOlfA0m
 t7ej0shvb++RaMQy2JZQFzk6Z/O4vPZx0NOFae+Ai9tcKD8LD7cTqpmOh/1rR2rysvnS
 w5Up28ZSSUKpvJc/qbuGM4gfYJFYhHzODtN/JwPJuXLc9XItIibJzge48Wgl+zp1cxHs
 J+cnD/Zp0tv7toQzqHnlImRzvh3I7XAkemv1mb7g0IBjUhCCeCx8kEek4LKyZvIhjzB7
 OHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yB8Xhdcr1UmQH8x5bcI6sm+S/MTI1xulItthpHA07WI=;
 b=qPxWrJpRnSu1iP+1uFAxEg6xWgF/kdZ3dK6/+dvdMl1RNVjt/+wSHTWLzNuRZrmO4c
 gCD0urGbQz5NqKWfPGAksAX+o0JjEqYwWjC33jSVhCEyIHpG9lcpz0YwtX0jBqswozQe
 bTd+sU4sAHF+Jbf+tNMglMekySPNRl3w5yWA0KK23+PGF7C74HM6LQ9JC8xkelUmYTZQ
 e5FF4hPdAe4nVOROdeEjY9LL2UqI7sTZV/+nj8xHDl5QYlbNsJJ0H1sImB3y0WRdvjt2
 s+RJ9XK8umXMOBNFAt5qGKw7bVZ4AgH4HVAAqu1P2NTuPK5zsvD0T8Eq9QNCynT8plO9
 I5NQ==
X-Gm-Message-State: AOAM532z6I7JcMHaRmx8g2EQOCZouofP6qhat+I6exlv0n4dxG7Jc8Cm
 swhzll7ZRSUZCJ3tuWXifgM=
X-Google-Smtp-Source: ABdhPJyOkEF06bgFmKyQhBb+A0wmpygZlW/7H7ia7YahrrMcQBz4D9XJ0EDr8NY3ZI4WwKEs5GrHkA==
X-Received: by 2002:a05:620a:294e:b0:67e:704d:7c55 with SMTP id
 n14-20020a05620a294e00b0067e704d7c55mr1865658qkp.118.1648084204497; 
 Wed, 23 Mar 2022 18:10:04 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com.
 [66.111.4.227]) by smtp.gmail.com with ESMTPSA id
 o15-20020ae9f50f000000b0067d27e196f1sm729885qkg.133.2022.03.23.18.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 18:10:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailauth.nyi.internal (Postfix) with ESMTP id BFA8127C0054;
 Wed, 23 Mar 2022 21:10:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 23 Mar 2022 21:10:02 -0400
X-ME-Sender: <xms:6cQ7Yv14XCzJ365b4Jqxuq1yNfSLClI1w5uiWCXa0ixK2_r6dHbuwQ>
 <xme:6cQ7YuHtRC-vWlBHjbbLS1yQGN6jcE69QnWjlVhZv6rAJYgTlzz_A7huNMPtrj7ZZ
 rxR0VJT-63j7Xvn5w>
X-ME-Received: <xmr:6cQ7Yv7G3W5Hg3KFn9xzZqcA1ilzEHjjc2or0DEwd9BvoHwhE6b534ps5NYx3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegkedgfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
 ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
 htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
 geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
 hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
 qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
 hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:6cQ7Yk1aQXDv7c6Kky7fz7Ax1u6QICsQXHEPa5BNv3LSMZAOfhAK5w>
 <xmx:6cQ7YiFlNMRafLKMQALAlK-PDKP1FMuf0MMyyVROfchzWrwxQhyB0A>
 <xmx:6cQ7Yl9RffYNrNvz3ypcwkw5KOId3nS45xF1wl7DTs4klKDcIFLPlw>
 <xmx:6sQ7YiIIKzTS6Q0leKUkgVjkgN_eoduPzGJriRDFY3p7HYT21Wv-dw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Mar 2022 21:10:01 -0400 (EDT)
Date: Thu, 24 Mar 2022 09:09:16 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v2 2/2] PCI: hv: Propagate coherence from VMbus device to
 PCI device
Message-ID: <YjvEvFFuKJiV/NU+@boqun-archlinux>
References: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
 <1648067472-13000-3-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1648067472-13000-3-git-send-email-mikelley@microsoft.com>
Cc: robh@kernel.org, wei.liu@kernel.org, sthemmin@microsoft.com,
 linux-acpi@vger.kernel.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 haiyangz@microsoft.com, decui@microsoft.com, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, iommu@lists.linux-foundation.org,
 linux-hyperv@vger.kernel.org, kw@linux.com, kys@microsoft.com,
 robin.murphy@arm.com, hch@lst.de, lenb@kernel.org
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

On Wed, Mar 23, 2022 at 01:31:12PM -0700, Michael Kelley wrote:
> PCI pass-thru devices in a Hyper-V VM are represented as a VMBus
> device and as a PCI device.  The coherence of the VMbus device is
> set based on the VMbus node in ACPI, but the PCI device has no
> ACPI node and defaults to not hardware coherent.  This results
> in extra software coherence management overhead on ARM64 when
> devices are hardware coherent.
> 
> Fix this by setting up the PCI host bus so that normal
> PCI mechanisms will propagate the coherence of the VMbus
> device to the PCI device. There's no effect on x86/x64 where
> devices are always hardware coherent.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  drivers/pci/controller/pci-hyperv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ae0bc2f..88b3b56 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3404,6 +3404,15 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hbus->bridge->domain_nr = dom;
>  #ifdef CONFIG_X86
>  	hbus->sysdata.domain = dom;
> +#elif defined(CONFIG_ARM64)
> +	/*
> +	 * Set the PCI bus parent to be the corresponding VMbus
> +	 * device. Then the VMbus device will be assigned as the
> +	 * ACPI companion in pcibios_root_bridge_prepare() and
> +	 * pci_dma_configure() will propagate device coherence
> +	 * information to devices created on the bus.
> +	 */
> +	hbus->sysdata.parent = hdev->device.parent;
>  #endif
>  
>  	hbus->hdev = hdev;
> -- 
> 1.8.3.1
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
