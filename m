Return-Path: <SRS0=Tv0G=2I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EADC43603
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 16:08:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C272176D
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 16:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGdwPfRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C272176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3A50087B08;
	Wed, 18 Dec 2019 16:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9zKsMi43ZQFB; Wed, 18 Dec 2019 16:08:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A01D18766D;
	Wed, 18 Dec 2019 16:08:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EAABC1797;
	Wed, 18 Dec 2019 16:08:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DBE5C077D
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 16:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EFCAF204F2
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 16:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ac+YO4-T5KJq for <iommu@lists.linux-foundation.org>;
 Wed, 18 Dec 2019 16:08:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id D1B1820407
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 16:08:41 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id d73so2419664wmd.1
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=o5X12+OnlTrR6hQB7btD1TwyQhH770WeXItNc7qt5zA=;
 b=vGdwPfRl1Ha9VhwGDZb29pGKHmrCLBjEh/aU/lWfjiA+Es/jr7ZphzP4HzPPmjTJx+
 JSehVhXPNzXdOHN1KvgmcYfeFj+EOqqLkQfTn7w+aSzsmY9sA/Phabc6P4xORTt9/1CX
 ZeJvajjFb7Aa2pPQS2rmj8CC2WfmH3g8R6Icy6BCtWh0myJTrzSd94GfQGUovkp6jd2B
 rT+HoiZRDI9Poe0mNpRZQO9dQfwLmHSchdxzCs4OzzEO+QNZJtdaxkDjf9S6U0pGGXCC
 uBxrbddT9q0O1xSpIKLYhBMvxSFqGMIVi9YEcXDMHetlYODSFxx8S1+dGvzAMam0zV9q
 MZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o5X12+OnlTrR6hQB7btD1TwyQhH770WeXItNc7qt5zA=;
 b=jysjCachcqbZaT1MMx7Uv99oL0vau1oQTBoxrVtplaZfgQ45lSlsZXyG+ZJj4c85OS
 vUtDNSg/P835IfKmliL14yFh89O4GOMjfyZGnjeqG7FN0iyFJvv4n5icWdySwE/6wQeA
 1bDnpFHt2MiEaw9FOKTYbCEtmnLR9f0mLo1JScS6ClCAAWfn5mQHdQe2YKJ92kHANZEl
 6ya0yjWYLcO6iqsf5/LwwE+kj8mCyzAqbeUtcrsIIDbSwQ0Y/7E5Jau3a230NFEdjLan
 ORLZH4b+Gpt0eA+mvv6dl5N+gahNo0Dsc7lmmwo6A4AY+/ct/CV+vN7LBVazirZYctOx
 Unyg==
X-Gm-Message-State: APjAAAVKjdqe8cdl2nsnhmZPoTLkSKIe3w6gYGm6//TplDUC2hKhyLlG
 KbJyPdUp4q6rAyHIZSWPxo9KFA==
X-Google-Smtp-Source: APXvYqzGNVeQ/R7JR9UNdXnpKZSm9sCG7ntxjETJuNIvtVXZ9l8S+gdw6OnN9egWqIdDF5D4ZyEZUA==
X-Received: by 2002:a05:600c:22c8:: with SMTP id
 8mr3940980wmg.178.1576685320145; 
 Wed, 18 Dec 2019 08:08:40 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id c5sm2949884wmb.9.2019.12.18.08.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 08:08:39 -0800 (PST)
Date: Wed, 18 Dec 2019 17:08:34 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 08/13] iommu/arm-smmu-v3: Propate ssid_bits
Message-ID: <20191218160834.GG2371701@myrica>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-9-jean-philippe@linaro.org>
 <466bbc57-79d4-274c-67bc-4ed591da9968@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <466bbc57-79d4-274c-67bc-4ed591da9968@redhat.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, robin.murphy@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, guohanjun@huawei.com, bhelgaas@google.com,
 zhangfei.gao@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Tue, Dec 17, 2019 at 06:07:26PM +0100, Auger Eric wrote:
> Hi Jean,
> 
> On 12/9/19 7:05 PM, Jean-Philippe Brucker wrote:
> 
> s/Propate/Propagate in the commit title.
> > Now that we support substream IDs, initialize s1cdmax with the number of
> > SSID bits supported by a master and the SMMU.
> > 
> > Context descriptor tables are allocated once for the first master
> > attached to a domain. Therefore attaching multiple devices with
> > different SSID sizes is tricky, and we currently don't support it.
> > 
> > As a future improvement it would be nice to at least support attaching a
> > SSID-capable device to a domain that isn't using SSID, by reallocating
> > the SSID table.
> Isn't that use case relevant (I mean using both devices in a non SSID
> use case). For platform devices you can work this around with FW but for
> PCI devices?

Normally each device gets its own domain. Especially since PASID is a PCI
Express capability, I expect them to be properly isolated with ACS, each
with its own IOMMU group. So I don't think this is too relevant for the
moment, it would be a quirk for a broken system.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
