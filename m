Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87A3C3F2D1
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 15:38:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECFC20870
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 15:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xw8uHB+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECFC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4B52F8682C;
	Wed,  4 Mar 2020 15:38:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sfuJ1OXn7qEu; Wed,  4 Mar 2020 15:38:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B57298680D;
	Wed,  4 Mar 2020 15:38:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1EA8C1AE2;
	Wed,  4 Mar 2020 15:38:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EC92C013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 15:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2A6C02052D
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 15:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YpGJiRpZcbxV for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 15:38:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id D8A2820488
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 15:38:29 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id j7so2918564wrp.13
 for <iommu@lists.linux-foundation.org>; Wed, 04 Mar 2020 07:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LgKNIbiOOYUUhf9VX9b+pYwCqt61P9QUYyLGCfaRQqc=;
 b=xw8uHB+1gNxz+4nuw+2nLyDwmL1QI5esVQO6EGJsBylGKEJSkntlHBqiPkEjo6I5so
 2j2NYcXAd8eVJR5NuQBvnBohvKncJiDbZj1YRtCntDcsklLInje+Nvh3wvu6cFWPFTTS
 CWckFMsVTrr5BiBsV/nqAMSc+QBQHT/7dMW1rdOjRzfzZcIFkiFXUUHtuTmHjXvS6y2W
 3EOPNRQRVYMoR5mWF82I5IEP576nXKWDhNiThT+JDtUY8BTwBkbwMsgIpwAGppFNz4qC
 5VoJpJuo69c3oRw5Vn1DUT3/o+NcGLYRIKIbO2iJu1RLprBCPQJ+OR08RXSDt3rv8wBR
 mkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LgKNIbiOOYUUhf9VX9b+pYwCqt61P9QUYyLGCfaRQqc=;
 b=V1NNjDEygj/1mPSbxXf4GSufH+IGVCHgudfeSpIUgy24Mj0wzwlujNtMaGK2c74nEu
 dYsyn/kCely0hCMOo5MN32CXM7MFlgcDJfDJUM4eQc7TOkbifRM/zNQkTNKclPvyOdgv
 wKyZBlj5n1jmCwORrrCotaKQvOilDi/ZVhwH44pIKZcf6SK5K2TIPNeuE+0DUVXecHfc
 gPscc1ujyXbJOt2WVKbUWNjSAa06wzKH3DZVHHjvLDTbotVjzy74LPHu6paqtkojIPnD
 Vehig9I2YNva69ZbTngYYiU+4TLtsanesoV9xoFIo4C+5zXJpMku3zOArg0M2SbC+lGK
 ZoxQ==
X-Gm-Message-State: ANhLgQ3XhmYnRl8iQML9meADuId2Mq/ruiVIdp6gcEccHQl5SY1G2qyb
 6WbYFyLuEw2sPKfYjH8+Df2TVQ==
X-Google-Smtp-Source: ADFU+vsqYupk4jr/XDRtdoMwn9PUODaP8+a/LVXxe3xIMUBcFgnIFdwKRkeedg2yIubmDqV6LuPYEQ==
X-Received: by 2002:adf:a512:: with SMTP id i18mr4675381wrb.61.1583336308173; 
 Wed, 04 Mar 2020 07:38:28 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id g129sm5695847wmg.12.2020.03.04.07.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 07:38:27 -0800 (PST)
Date: Wed, 4 Mar 2020 16:38:21 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200304153821.GE646000@myrica>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200304133707.GB4177@8bytes.org>
Cc: kevin.tian@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com,
 robin.murphy@arm.com
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

On Wed, Mar 04, 2020 at 02:37:08PM +0100, Joerg Roedel wrote:
> Hi Michael,
> 
> On Tue, Mar 03, 2020 at 11:09:41AM -0500, Michael S. Tsirkin wrote:
> > No. It's coded into the hardware. Which might even be practical
> > for bare-metal (e.g. on-board flash), but is very practical
> > when the device is part of a hypervisor.
> 
> If its that way on PPC, than fine for them. But since this is enablement
> for x86, it should follow the x86 platform best practices, and that
> means describing hardware through ACPI.

I agree with this. The problem is I don't know how to get a new ACPI table
or change an existing one. It needs to go through the UEFI forum in order
to be accepted, and I don't have any weight there. I've been trying to get
the tiny change into IORT for ages. I haven't been given any convincing
reason against it or offered any alternative, it's just stalled. The
topology description introduced here wasn't my first choice either but
unless someone can help finding another way into ACPI, I don't have a
better idea.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
