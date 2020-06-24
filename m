Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B85C433DF
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 16:10:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2072206F7
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 16:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="J6RzRtRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2072206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E4088769F;
	Wed, 24 Jun 2020 16:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id htXYl3cPRVRB; Wed, 24 Jun 2020 16:10:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC2EA86ED5;
	Wed, 24 Jun 2020 16:10:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4F8DC0888;
	Wed, 24 Jun 2020 16:10:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A62F3C016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 16:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A1D21862CA
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 16:10:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ss_8vH7wM245 for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 16:10:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F0C90862EC
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1593015003; x=1624551003;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=qFnBrPT1jUzbI8oKo8NKNNU5h4jjQt159UGgsLlGCcE=;
 b=J6RzRtRgq6op4TMdpaBG7EWB6OZdx+BImOJSgkDPWS8RoRdCORLDMf2t
 9SQ5GwQPG4gyVjE/gw65dPYDKtT7aEjsFYrZhD6koMGDy3qtdyK/2JJ7t
 O+FSKmuTtNqXsVoreWBPlSRlKeeRmHvKujfjY/DNe10OBoBhgz/3MxTzP Q=;
IronPort-SDR: 7mIZ6IMP+dxbjSzNU8TTrDVGz6rQpuHUkE9NLRTIL8RHQojCqCUpr0ArwDz86adK8Cr++kUhnY
 xfLUdNG+5JRg==
X-IronPort-AV: E=Sophos;i="5.75,275,1589241600"; d="scan'208";a="39579842"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP;
 24 Jun 2020 16:10:02 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS
 id E6277A18EB; Wed, 24 Jun 2020 16:10:00 +0000 (UTC)
Received: from EX13D29UWA001.ant.amazon.com (10.43.160.187) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 24 Jun 2020 16:10:00 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D29UWA001.ant.amazon.com (10.43.160.187) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 24 Jun 2020 16:10:00 +0000
Received: from uc7682112f22859.ant.amazon.com (10.1.213.23) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 24 Jun 2020 16:09:58 +0000
Subject: Re: [PATCH 0/3] iommu/amd: I/O VA address limits
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
References: <20200605145655.13639-1-sebott@amazon.de>
Message-ID: <274156d3-11bb-18d7-2dac-3a2484c2cc9d@amazon.de>
Date: Wed, 24 Jun 2020 18:09:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605145655.13639-1-sebott@amazon.de>
Content-Language: en-US
Cc: Benjamin Serebrin <serebrin@amazon.com>, Filippo Sironi <sironi@amazon.de>
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
From: Sebastian Ott via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sebastian Ott <sebott@amazon.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hello Joerg,

On 2020-06-05 16:56, Sebastian Ott wrote:
> The IVRS ACPI table specifies maximum address sizes for I/O virtual
> addresses that can be handled by the IOMMUs in the system. Parse that
> data from the IVRS header to provide aperture information for DMA
> mappings and users of the iommu API.
>
> Sebastian Ott (3):
>    iommu/amd: Parse supported address sizes from IVRS
>    iommu/amd: Restrict aperture for domains to conform with IVRS
>    iommu/amd: Actually enforce geometry aperture
>
>   drivers/iommu/amd_iommu.c       | 16 +++++++++++-----
>   drivers/iommu/amd_iommu_init.c  | 26 ++++++++++++++++++++++++++
>   drivers/iommu/amd_iommu_types.h |  3 +++
>   3 files changed, 40 insertions(+), 5 deletions(-)
>
Would you consider taking these patches for the next release?

Regards,
Sebastian




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
