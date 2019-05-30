Return-Path: <SRS0=ZfVm=T6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3887BC28CC2
	for <iommu@archiver.kernel.org>; Thu, 30 May 2019 17:45:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9E525EAB
	for <iommu@archiver.kernel.org>; Thu, 30 May 2019 17:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9E525EAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D8CC7242C;
	Thu, 30 May 2019 17:45:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7A3CC1D16
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 17:45:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
	[209.85.160.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EF171893
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 17:45:37 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id a15so5905034qtn.7
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 10:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=UgEoJIEOWgKSmNpnwJapd7xKMVBGEnMvpNqFuwdcHSY=;
	b=nMZ7TvmbQn4gQSMwGTzjNLft8KgCo3M4KQjof15eJw08H0DR/VwLoaqn2r2Jf/zOqn
	9HWzP24FzK7VsxvWAnd1/hbYCH5X4GmELVnj5bJV6mAiIKi0LzU67rEccKw4QGy3VQj6
	P5jLAShuMYOuaZ0K/SimOtXkalLiM29gErBJdarJUct+Job7OwC1fc0cpKaFsgWptJlc
	0WYyaaNc2fpnuFJ3fpdfFUkJc9VbH5MoFGjO67Uy+bif0xXL5jHF+raW1v4aUYHXnztO
	BWljyZKO3oL4OrMJThcSfPTHzUcC+ftrZwBWDE1IRVpb9hZnXBcCytb8QJIVHD9OS/bi
	qxgA==
X-Gm-Message-State: APjAAAUOO64ykOXuRRGwa454QY1i90gUuBxZVLOizMPIG4vyNd4uPPTi
	dnT3oYdVry1f3Pz5ZlpMIkmvTw==
X-Google-Smtp-Source: APXvYqy9DfCkbHWFwnoJIZhnJEIk9jBDmoJOESod/F/vQr9Iv7gjOGLceZ55BmbRJubgQEOI/tivJw==
X-Received: by 2002:aed:3b5a:: with SMTP id q26mr4641355qte.158.1559238337003; 
	Thu, 30 May 2019 10:45:37 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id r186sm691141qkb.9.2019.05.30.10.45.34
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 10:45:35 -0700 (PDT)
Date: Thu, 30 May 2019 13:45:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v8 2/7] dt-bindings: virtio: Add virtio-pci-iommu node
Message-ID: <20190530133523-mutt-send-email-mst@kernel.org>
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
	<20190530170929.19366-3-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190530170929.19366-3-jean-philippe.brucker@arm.com>
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
	tnowicki@caviumnetworks.com, frowand.list@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, robh+dt@kernel.org,
	kvmarm@lists.cs.columbia.edu, bhelgaas@google.com,
	robin.murphy@arm.com, jasowang@redhat.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, May 30, 2019 at 06:09:24PM +0100, Jean-Philippe Brucker wrote:
> Some systems implement virtio-iommu as a PCI endpoint. The operating
> system needs to discover the relationship between IOMMU and masters long
> before the PCI endpoint gets probed. Add a PCI child node to describe the
> virtio-iommu device.
> 
> The virtio-pci-iommu is conceptually split between a PCI programming
> interface and a translation component on the parent bus. The latter
> doesn't have a node in the device tree. The virtio-pci-iommu node
> describes both, by linking the PCI endpoint to "iommus" property of DMA
> master nodes and to "iommu-map" properties of bus nodes.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

So this is just an example right?
We are not defining any new properties or anything like that.

I think down the road for non dt platforms we want to put this
info in the config space of the device. I do not think ACPI
is the best option for this since not all systems have it.
But that can wait.

> ---
>  .../devicetree/bindings/virtio/iommu.txt      | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
> 
> diff --git a/Documentation/devicetree/bindings/virtio/iommu.txt b/Documentation/devicetree/bindings/virtio/iommu.txt
> new file mode 100644
> index 000000000000..2407fea0651c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/iommu.txt
> @@ -0,0 +1,66 @@
> +* virtio IOMMU PCI device
> +
> +When virtio-iommu uses the PCI transport, its programming interface is
> +discovered dynamically by the PCI probing infrastructure. However the
> +device tree statically describes the relation between IOMMU and DMA
> +masters. Therefore, the PCI root complex that hosts the virtio-iommu
> +contains a child node representing the IOMMU device explicitly.
> +
> +Required properties:
> +
> +- compatible:	Should be "virtio,pci-iommu"
> +- reg:		PCI address of the IOMMU. As defined in the PCI Bus
> +		Binding reference [1], the reg property is a five-cell
> +		address encoded as (phys.hi phys.mid phys.lo size.hi
> +		size.lo). phys.hi should contain the device's BDF as
> +		0b00000000 bbbbbbbb dddddfff 00000000. The other cells
> +		should be zero.
> +- #iommu-cells:	Each platform DMA master managed by the IOMMU is assigned
> +		an endpoint ID, described by the "iommus" property [2].
> +		For virtio-iommu, #iommu-cells must be 1.
> +
> +Notes:
> +
> +- DMA from the IOMMU device isn't managed by another IOMMU. Therefore the
> +  virtio-iommu node doesn't have an "iommus" property, and is omitted from
> +  the iommu-map property of the root complex.
> +
> +Example:
> +
> +pcie@10000000 {
> +	compatible = "pci-host-ecam-generic";
> +	...
> +
> +	/* The IOMMU programming interface uses slot 00:01.0 */
> +	iommu0: iommu@0008 {
> +		compatible = "virtio,pci-iommu";
> +		reg = <0x00000800 0 0 0 0>;
> +		#iommu-cells = <1>;
> +	};
> +
> +	/*
> +	 * The IOMMU manages all functions in this PCI domain except
> +	 * itself. Omit BDF 00:01.0.
> +	 */
> +	iommu-map = <0x0 &iommu0 0x0 0x8>
> +		    <0x9 &iommu0 0x9 0xfff7>;
> +};
> +
> +pcie@20000000 {
> +	compatible = "pci-host-ecam-generic";
> +	...
> +	/*
> +	 * The IOMMU also manages all functions from this domain,
> +	 * with endpoint IDs 0x10000 - 0x1ffff
> +	 */
> +	iommu-map = <0x0 &iommu0 0x10000 0x10000>;
> +};
> +
> +ethernet@fe001000 {
> +	...
> +	/* The IOMMU manages this platform device with endpoint ID 0x20000 */
> +	iommus = <&iommu0 0x20000>;
> +};
> +
> +[1] Documentation/devicetree/bindings/pci/pci.txt
> +[2] Documentation/devicetree/bindings/iommu/iommu.txt
> -- 
> 2.21.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
