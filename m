Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ABCC43334
	for <iommu@archiver.kernel.org>; Sun,  5 Jun 2022 22:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BBE0540DAE;
	Sun,  5 Jun 2022 22:45:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M-rBewPub6eK; Sun,  5 Jun 2022 22:45:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 931DF403C4;
	Sun,  5 Jun 2022 22:45:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EDA3C0032;
	Sun,  5 Jun 2022 22:45:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F9B9C002D
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 22:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CD96403C4
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 22:45:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w2O9QTonjcrm for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jun 2022 22:45:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2704640391
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 22:45:38 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id u8so9267517qvj.2
 for <iommu@lists.linux-foundation.org>; Sun, 05 Jun 2022 15:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uDzznG00WmBRTYCBcArlD1mf1zVfk2p9nd9xHJn3CVw=;
 b=xmgsynhepekKHbQfwOXjBPCaJ3gng8tc3dSW+alY6AFlc9UAIbo2ctOFmifuMPJkO/
 bss7zOw3eTAL6Av8c+yuHotDA5QmmC/Px82Lccb3mobU0/hS52OEupJFdVYRK5ZakwC1
 nEj2qVw8Nu/ydel2in1RQceT3+URaugUl318KlrzLX+dayex7lTZ3/OizhVE0hLsMiHq
 YqvrhO7v5Y/i30Pe4ln4Z4pBTaa7aYQ5ZapKI06IXmfUH6gnzxGMHND8nvTZbpbPBT0E
 Ov7OHjununs2vsVgLwPBXLKWjtrOM0qZOqzFDWlWHfZGNbNJzX8JMkBnrS2Fgp97qLCT
 EVJw==
X-Gm-Message-State: AOAM532YxSHhP6vZyyZH5ghPaH96dcVys075UU4jS5VPJzO0S80m4Bit
 E9+7lRtvH0IXPhlRfp+QTA==
X-Google-Smtp-Source: ABdhPJwmsDYIVR7qLkG6UWB/x8H/AgliTU6o4B+wWC9F21jxx0e09sjuNDCoG74Zm/3g90Nz9x+0LQ==
X-Received: by 2002:ad4:5447:0:b0:461:d7a7:f0ec with SMTP id
 h7-20020ad45447000000b00461d7a7f0ecmr70549704qvt.21.1654469136911; 
 Sun, 05 Jun 2022 15:45:36 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
 by smtp.gmail.com with ESMTPSA id
 v128-20020a37dc86000000b0069fc13ce244sm10341437qki.117.2022.06.05.15.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jun 2022 15:45:36 -0700 (PDT)
Received: (nullmailer pid 3667844 invoked by uid 1000);
 Sun, 05 Jun 2022 22:45:33 -0000
Date: Sun, 5 Jun 2022 17:45:33 -0500
From: Rob Herring <robh@kernel.org>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [PATCH V4 5/8] dt-bindings: Add xen,grant-dma IOMMU description
 for xen-grant DMA ops
Message-ID: <20220605224533.GA3667788-robh@kernel.org>
References: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
 <1654197833-25362-6-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1654197833-25362-6-git-send-email-olekstysh@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, devicetree@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 xen-devel@lists.xenproject.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On Thu, 02 Jun 2022 22:23:50 +0300, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> The main purpose of this binding is to communicate Xen specific
> information using generic IOMMU device tree bindings (which is
> a good fit here) rather than introducing a custom property.
> 
> Introduce Xen specific IOMMU for the virtualized device (e.g. virtio)
> to be used by Xen grant DMA-mapping layer in the subsequent commit.
> 
> The reference to Xen specific IOMMU node using "iommus" property
> indicates that Xen grant mappings need to be enabled for the device,
> and it specifies the ID of the domain where the corresponding backend
> resides. The domid (domain ID) is used as an argument to the Xen grant
> mapping APIs.
> 
> This is needed for the option to restrict memory access using Xen grant
> mappings to work which primary goal is to enable using virtio devices
> in Xen guests.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
> Changes RFC -> V1:
>    - update commit subject/description and text in description
>    - move to devicetree/bindings/arm/
> 
> Changes V1 -> V2:
>    - update text in description
>    - change the maintainer of the binding
>    - fix validation issue
>    - reference xen,dev-domid.yaml schema from virtio/mmio.yaml
> 
> Change V2 -> V3:
>    - Stefano already gave his Reviewed-by, I dropped it due to the changes (significant)
>    - use generic IOMMU device tree bindings instead of custom property
>      "xen,dev-domid"
>    - change commit subject and description, was
>      "dt-bindings: Add xen,dev-domid property description for xen-grant DMA ops"
> 
> Changes V3 -> V4:
>    - add Stefano's R-b
>    - remove underscore in iommu node name
>    - remove consumer example virtio@3000
>    - update text for two descriptions
> ---
>  .../devicetree/bindings/iommu/xen,grant-dma.yaml   | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
