Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFE5C43334
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 20:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51D9B60BAB;
	Mon, 13 Jun 2022 20:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ax3AVH8_uSxp; Mon, 13 Jun 2022 20:38:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 34B1D60A94;
	Mon, 13 Jun 2022 20:38:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1404EC0032;
	Mon, 13 Jun 2022 20:38:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2595C002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 20:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CA9760BAB
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 20:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZhnkBbwzIcks for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:38:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A565660A94
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 20:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655152728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=miyd1T3+stkgi1mrJ4phi+uWQilLr1GqB1Dxvn0GUOs=;
 b=Ix9dlVCEJI3Jpvrben0tvI/Dvll9EPYrlU1L75ddeityuBZ8YME9SaxBKjw2lDFHQIXEs5
 /sYSKEWlpRJrNaHy6ZlghvUgF4EUAws2yspOBPDqIp4MnNZvy254BOMmUj1TcJqvT0jnap
 IxWjggGgfJm3og/j3kkTU08tUejyoC4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-o-i2xdhINySc2UEeBCC3og-1; Mon, 13 Jun 2022 16:38:45 -0400
X-MC-Unique: o-i2xdhINySc2UEeBCC3og-1
Received: by mail-pg1-f198.google.com with SMTP id
 37-20020a630a25000000b003fdcbe1ffc8so3887285pgk.11
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 13:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=miyd1T3+stkgi1mrJ4phi+uWQilLr1GqB1Dxvn0GUOs=;
 b=za9cxMgpugyikDDujbFpCPzV3VTDFvTgn70MzUIlG7zmAJqFWcUj191P/fAZr7hOUN
 QgpWcuaNZ9LDREjqTx+D4+Ox+A78As+cxMZrRUAliX4JFt36BNnLcMEu2wCe3qoS2AF3
 udFkbRaZ6aoSvHLdYcAMRB6gucGq3t5UkXH4TmxfAPpRKIQ8A17H80WoG4ZsXFVIpccf
 78odALv+fdwFPm4zehsYHr5E8ishYzElt5uif7dMlMTzXuHz5TSR8HuKn4y9U3eON7DR
 m+dRAH7jYibxoNiBgwKgFFAkits77Stvmm6jOpbFozy1JKgydg59j38fXWALz2QyQLGY
 HIKw==
X-Gm-Message-State: AJIora/HzaAgwQGMLRy67BsJWK7xiJlWQCAhnMy+K4/BXApWfHwNmgJu
 nc4SHhbblXn0liWRatkQY5PlyI9X6pfB0MyHdwWysleOrv/0ozm2ysuyCtd553W4WH4lgl+hxm9
 53j4uPkSPa3f13MxKV1ffLBjRyxDNcA==
X-Received: by 2002:a17:902:7604:b0:168:cca6:1b38 with SMTP id
 k4-20020a170902760400b00168cca61b38mr1113740pll.174.1655152724277; 
 Mon, 13 Jun 2022 13:38:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sXs1WFaIXkc6CwFKtbKlij7wvfOFwhTNHBGbcdQcBmY3+wFKnIyMn1hhRSLuPxBKdX7sAxag==
X-Received: by 2002:a17:902:7604:b0:168:cca6:1b38 with SMTP id
 k4-20020a170902760400b00168cca61b38mr1113720pll.174.1655152723983; 
 Mon, 13 Jun 2022 13:38:43 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id
 ja2-20020a170902efc200b0015e8d4eb2c0sm5526354plb.266.2022.06.13.13.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 13:38:43 -0700 (PDT)
Date: Mon, 13 Jun 2022 13:38:42 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <20220613203842.zyncvndwfauef2yh@cantor>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
MIME-Version: 1.0
In-Reply-To: <20220512151309.330068-1-steve.wahl@hpe.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Dimitri Sivanich <sivanich@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 Russ Anderson <russ.anderson@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, David Woodhouse <dwmw2@infradead.org>,
 Kyung Min Park <kyung.min.park@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> To support up to 64 sockets with 10 DMAR units each (640), make the
> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> set.
> 
> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> fails to boot properly.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
> 
> Note that we could not find a reason for connecting
> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> it seemed like the two would continue to match on earlier processors.
> There doesn't appear to be kernel code that assumes that the value of
> one is related to the other.
> 
> v2: Make this value a config option, rather than a fixed constant.  The default
> values should match previous configuration except in the MAXSMP case.  Keeping the
> value at a power of two was requested by Kevin Tian.
> 
>  drivers/iommu/intel/Kconfig | 6 ++++++
>  include/linux/dmar.h        | 6 +-----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 

Baolu do you have this queued up for v5.20? Also do you have a public repo where
you keep the vt-d changes before sending Joerg the patches for a release?

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
