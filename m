Return-Path: <SRS0=OkKq=ZR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C278DC432C0
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 17:53:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7F82086A
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 17:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ucHw3iIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7F82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9285D8797A;
	Mon, 25 Nov 2019 17:53:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z6EJpcYX2Wu1; Mon, 25 Nov 2019 17:53:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6AE7A879CC;
	Mon, 25 Nov 2019 17:53:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59458C1DDB;
	Mon, 25 Nov 2019 17:53:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16E93C0878
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 17:53:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 038A420551
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 17:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V1wtXizUqtWV for <iommu@lists.linux-foundation.org>;
 Mon, 25 Nov 2019 17:53:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id F19F02000A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 17:53:20 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id z19so249109wmk.3
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 09:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=w762PFi0VU3n3eQDHHvKOAEXrmJ/fz15F0VMqWwRKbE=;
 b=ucHw3iITUddgxmI0WaTeJ03oRUG5uF8HifGtGA0su/1oL8KAd8AZXtYGuQKcpbum8e
 d6QnTIGwff7BVf7S6toPsGifytN5SktOO+ePb6YqXPtb6gYo3YNY4PxId/vuZoubQL3B
 HZEwCDCJkQy+orvI6z5xFNqQfTmQLH9SdLq2Q9e4wsRNaJ0SGNOa+RCVpbB12Hl8Og9f
 CXY6WHbjQ2/65OtfFrYy/fCeDjmmeVA24mCcyFcYoKY1qa9FXUzoMG82gzImz8jhXo5w
 bHyegwRNLGNDIEyqqMjAAXkzFtDrFlkTpk8MwFyhHzyAPZmSpbf+F2CL2BoPmWn8fWWF
 u01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=w762PFi0VU3n3eQDHHvKOAEXrmJ/fz15F0VMqWwRKbE=;
 b=OReZkk93lYbwIXRtzrGDiQa1bC8kvIG2KprX+lCUiQ+rxRj8TZno2RDZAWA0Yu8/4U
 vyqVbdvn7EEySKteueYQ5/tANx2A+gKlZZ1yMb9ukCanlj/Z5LPhoIP6AUE35hCAHDf+
 0lmZ30MxTMkW9sIUPl6bGkK4DuH3nVdOz6MDr3B7lFHLr5efXvsPhz6qwaZfTb41adyU
 1j9xl5453gpFSvlgyKVLAJ43FV2eFrQOaZQZVf33M1yxjX1Q/DfPwwJ2+wEX8hUdm8sn
 f3CBsFfFwWYtUL9Hp4s5IXUNlT0mq8W3B90OVTQfQYxKxT6K/YRrfq52W66/obf/gLm/
 ZP4w==
X-Gm-Message-State: APjAAAXc6Ive5hAlxZA9QVfzAV2NeASmkwd/NwDV1LEMv8hE/8YGIPby
 NpWwdhlm4XtmNK/k9FElaxCcdQ==
X-Google-Smtp-Source: APXvYqzAZYIvQKGmfaQYD5lQJqrthSCPdfwYB+f4khqntbOAs2pzi4zET6f0XPBxuKoaB6N7z3djFQ==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr98865wml.100.1574704399261;
 Mon, 25 Nov 2019 09:53:19 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
 by smtp.gmail.com with ESMTPSA id p1sm26490wmc.38.2019.11.25.09.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 09:53:18 -0800 (PST)
Date: Mon, 25 Nov 2019 18:53:16 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 00/13] virtio-iommu on non-devicetree platforms
Message-ID: <20191125175316.GC945122@lophozonia>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
 <20191122075438-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191122075438-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, sudeep.holla@arm.com,
 rjw@rjwysocki.net, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, guohanjun@huawei.com,
 bhelgaas@google.com, jasowang@redhat.com, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

On Fri, Nov 22, 2019 at 08:00:46AM -0500, Michael S. Tsirkin wrote:
> > (2) In addition, there are some concerns about having virtio depend on
> >     ACPI or DT. Some hypervisors (Firecracker, QEMU microvm, kvmtool x86
> >     [1])
> 
> power?

In kvmtool it boot with device tree. It also doesn't need virtio-iommu I
think, since it has its own paravirtualized interface.

> > don't currently implement those methods.
> > 
> >     It was suggested to embed the topology description into the device.
> >     It can work, as demonstrated at the end of this RFC, with the
> >     following limitations:
> > 
> >     - The topology description must be read before any endpoint managed
> >       by the IOMMU is probed, and even before the virtio module is
> >       loaded. This RFC uses a PCI quirk to manually parse the virtio
> >       configuration. It assumes that all endpoints managed by the IOMMU
> >       are under this same PCI host.
> > 
> >     - I don't have a solution for the virtio-mmio transport at the
> >       moment, because I haven't had time to modify a host to test it. I
> >       think it could either use a notifier on the platform bus, or
> >       better, a new 'iommu' command-line argument to the virtio-mmio
> >       driver.
> 
> 	A notifier seems easier for users. What are the disadvantages of
> 	that?

For each device we have to check if it's virtio-mmio, then map the MMIO
resource and check the device type. Having a dedicated command-line
argument would be more efficient.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
