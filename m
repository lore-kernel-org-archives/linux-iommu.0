Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB50C11D92
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 22:30:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95EE24696
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 22:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95EE24696
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A9E4A20534;
	Wed, 19 Feb 2020 22:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kHDa4DPs-RQ4; Wed, 19 Feb 2020 22:25:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9451C203DF;
	Wed, 19 Feb 2020 22:25:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85D67C1D80;
	Wed, 19 Feb 2020 22:25:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55DEDC013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 22:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 355CB82EE5
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 22:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QoLfatcC5CaM for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 22:24:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8E64A82441
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 22:24:57 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id q81so25542586oig.0
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 14:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bw/arhxO0zD6uxPv9B55JT/z9CSekm6k6Bmp/kVtLV0=;
 b=QdewZrxfZ9CIzAhJKZ3JE4LZCckrOLZhhWs/QX3qVfV+WPTvSVEemT3oGriPNHUzHX
 o+RQCGM9rAxB56wCU6TcW5TD0lyY21sjByppUH278zUbtCqybATlpQtr3onvKOMZPFo4
 oRq1E2a1EKYbHZwMCTsIB1vL1aToZKbedZ7N9RYUlED6ECB35i5h4kmVd9exukKe78vG
 qx3CfnYdFqP3A24Su+2IGoJXZi+9JM0jWTL5vC3s0t/8vjJbR5G1m7cWXtk6vfZoW4nh
 b9q7z6gLLprXrBSSj6GTEW78WcSAcXRFZzDCbouFKd0a0AOftcrTq5GWQ+iK8G2OZ+o+
 3BYg==
X-Gm-Message-State: APjAAAVPrCEjIXgkxuqsygxIjiuuMKi20elcv0MMQpQYOIFYcA1cy9Wy
 cm+V97JY5mQjzRa4kIBPtA==
X-Google-Smtp-Source: APXvYqzZzuIwDzmzfqhTKUe49az+Etwqyco/nG1nDw+t4D7VEkxMrWlgNAsahLPneOunxOSWnXEiHQ==
X-Received: by 2002:aca:d903:: with SMTP id q3mr6124909oig.12.1582151096719;
 Wed, 19 Feb 2020 14:24:56 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l80sm428436oib.37.2020.02.19.14.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 14:24:56 -0800 (PST)
Received: (nullmailer pid 16262 invoked by uid 1000);
 Wed, 19 Feb 2020 22:24:54 -0000
Date: Wed, 19 Feb 2020 16:24:54 -0600
From: Rob Herring <robh@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 01/11] dt-bindings: PCI: generic: Add ats-supported
 property
Message-ID: <20200219222454.GA16221@bogus>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
 <20200213165049.508908-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200213165049.508908-2-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 liviu.dudau@arm.com, guohanjun@huawei.com, will@kernel.org, corbet@lwn.net,
 frowand.list@gmail.com, linux-acpi@vger.kernel.org, lenb@kernel.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 amurray@thegoodpenguin.co.uk
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

On Thu, 13 Feb 2020 17:50:39 +0100, Jean-Philippe Brucker wrote:
> Add a way for firmware to tell the OS that ATS is supported by the PCI
> root complex. An endpoint with ATS enabled may send Translation Requests
> and Translated Memory Requests, which look just like Normal Memory
> Requests with a non-zero AT field. So a root controller that ignores the
> AT field may simply forward the request to the IOMMU as a Normal Memory
> Request, which could end badly. In any case, the endpoint will be
> unusable.
> 
> The ats-supported property allows the OS to only enable ATS in endpoints
> if the root controller can handle ATS requests. Only add the property to
> pcie-host-ecam-generic for the moment. For non-generic root controllers,
> availability of ATS can be inferred from the compatible string.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
