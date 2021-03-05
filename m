Return-Path: <SRS0=uIbQ=ID=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1BBC433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 08:24:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C00565014
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 08:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C00565014
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4F2D143150;
	Fri,  5 Mar 2021 08:24:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AllaQvvu-QOU; Fri,  5 Mar 2021 08:24:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61BEE431E8;
	Fri,  5 Mar 2021 08:24:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37E0FC000B;
	Fri,  5 Mar 2021 08:24:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5F77C0001
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 08:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 904526ECE9
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 08:24:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=yandex-team.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RwZRWqbYXXjF for <iommu@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:24:13 +0000 (UTC)
X-Greylist: delayed 00:07:02 by SQLgrey-1.8.0
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::183])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D35836E8F5
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 08:24:12 +0000 (UTC)
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net
 (vla1-fdfb804fb3f3.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 31CED2E15BA;
 Fri,  5 Mar 2021 11:17:06 +0300 (MSK)
Received: from vla5-d6d5ce7a4718.qloud-c.yandex.net
 (vla5-d6d5ce7a4718.qloud-c.yandex.net [2a02:6b8:c18:341e:0:640:d6d5:ce7a])
 by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 nBUJYgG9mP-H504YqKo; Fri, 05 Mar 2021 11:17:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; 
 t=1614932226; bh=ikw0NZHqJgFqyaFCRWbjp7lWwmWwPcvXaMhsrOZJ7u0=;
 h=In-Reply-To:References:Date:Message-ID:From:To:Subject:Cc;
 b=g7V+jCO9XOBzYLR0mvS0cct1Ktx8BVoGBuc0crJqmqQtZ4FTPm7DaScDEfSMgT8zC
 9OBp5iIVfCwU3yC9+GCFlc8ENlzofOeeHIxJSCKzb8+eMLqsBYFZF78ULUu8xknjIN
 p41IsEpZgZKuUmcENCnWG0PXH8qBhm8SK/J6Ymw8=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8217::1:2])
 by vla5-d6d5ce7a4718.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 Q79TVul5mw-H5n0O6mP; Fri, 05 Mar 2021 11:17:05 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Subject: Re: [PATCH] iommu/amd: Fix sleeping in atomic in
 increase_address_space()
To: Joerg Roedel <joro@8bytes.org>
References: <20210217143004.19165-1-arbn@yandex-team.com>
 <20210217181002.GC4304@willie-the-truck> <20210304121941.GB26414@8bytes.org>
From: Andrey Ryabinin <arbn@yandex-team.com>
Message-ID: <298d9f1e-39b7-ee1c-86f6-9f9780356942@yandex-team.com>
Date: Fri, 5 Mar 2021 11:18:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304121941.GB26414@8bytes.org>
Content-Language: en-US
Cc: valesini@yandex-team.ru, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, iommu@lists.linux-foundation.org,
 Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>
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



On 3/4/21 3:19 PM, Joerg Roedel wrote:
> On Wed, Feb 17, 2021 at 06:10:02PM +0000, Will Deacon wrote:
>>>  drivers/iommu/amd/iommu.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> Acked-by: Will Deacon <will@kernel.org>
> 
> Applied for v5.12, thanks.
> 
> There were some conflicts which I resolved, can you please check the
> result, Andrey? The updated patch is attached.
> 

Thanks, looks good to me.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
