Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05604C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 23:25:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819C560E74
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 23:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 819C560E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DA45608FB;
	Mon, 11 Oct 2021 23:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Fujl_I8df74; Mon, 11 Oct 2021 23:25:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A61B0608B1;
	Mon, 11 Oct 2021 23:25:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86960C000F;
	Mon, 11 Oct 2021 23:25:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFCE8C000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 23:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 935A280D36
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 23:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y53QzsniYS08 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 23:25:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B0B080D30
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 23:25:15 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id i24so77997230lfj.13
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 16:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=N3HcVRkt2qXB/rqH6SM+oiBx156PKAvxGuJmThzW5lg=;
 b=PylXWvUDbhk8vPjHREbuDTn0CSpLBOTJp37e+wxb3choCU3PWx+FhWZnd7uGiVdeMq
 EETtyJE3KDDOm4wOMQ9C8pb3WBxHioJyB/63lssZYEfgryU59vsnNloi2IP3bA9LI0DM
 NuKeKtNScgzSyAWJZSTphLEMocSCmDDgzqR/PAAUHZiWi1cMXDOpNBYudQCO1Xn62IBU
 nynPLSCooYja7RCL6kMlTtfl3uKpXh8XU1V9swZ1IlRO+Hm68rX4y9Ibo/fCCViRPPs6
 O8O6kB2vRf6W9XYQmHbqCAhE3HHrXOi9sb8I4ue7NnZjhZgEE//X4o0DW9CFbCTaWkDq
 16Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N3HcVRkt2qXB/rqH6SM+oiBx156PKAvxGuJmThzW5lg=;
 b=bIyLzyn0hsEMW1YjqWcjScCoOSfE3ytk0b3UOvxlYSPujEi5XgG0xwzOfAW7habXOZ
 QGU9BpkQR/Rjfvjuqqo71VFbMIgwB8o0vUashIQyWX5mMjfpgz7ks/I13Eo9v56QHvRS
 ekvlFT9pRxqzLDeelCW5s53Vjg2yCnxgSrl25VhB/zxbKGb7TFcC/l9YyEAPkGejqieQ
 s9BvWlc/TFyvpr/QGezTKpK20CDMkaDK7aXQyHZ98rAISlr40dMUvpKipNahaQPsNAcT
 HvA51jId5ZU+4W0M+i1BRNHmM6BgDyUqBIvz8aFI+CiTxSBQUvoXbYkqZHxl0hbr7jT3
 qqtw==
X-Gm-Message-State: AOAM531LwAFBfNiHXmmZ9Daf5S/rrYe7/eZ0VMofSr1pvCnUl0HS3bFU
 EKEDtzOIDi5qUXpqyaCN0RU=
X-Google-Smtp-Source: ABdhPJzkLmFoRH8hukY+9X+MqeNzriUds4GWxpYakbwi1lHd75mruGbLWv/FsdXhMmNaOKZMqsjg9Q==
X-Received: by 2002:a05:6512:b81:: with SMTP id
 b1mr30356228lfv.301.1633994713208; 
 Mon, 11 Oct 2021 16:25:13 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-181.dynamic.spd-mgts.ru.
 [94.29.10.181])
 by smtp.googlemail.com with ESMTPSA id d4sm985076ljl.98.2021.10.11.16.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Oct 2021 16:25:12 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] iommu/tegra-smmu: Support managed domains
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel
 <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <20210423163234.3651547-6-thierry.reding@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9b0f1fd2-887b-d685-f1b9-5848f392b8b8@gmail.com>
Date: Tue, 12 Oct 2021 02:25:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210423163234.3651547-6-thierry.reding@gmail.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

MjMuMDQuMjAyMSAxOTozMiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBGcm9tOiBOYXZu
ZWV0IEt1bWFyIDxuYXZuZWV0a0BudmlkaWEuY29tPgo+IAo+IEFsbG93IGNyZWF0aW5nIGlkZW50
aXR5IGFuZCBETUEgQVBJIGNvbXBhdGlibGUgSU9NTVUgZG9tYWlucy4gV2hlbgo+IGNyZWF0aW5n
IGEgRE1BIEFQSSBjb21wYXRpYmxlIGRvbWFpbiwgbWFrZSBzdXJlIHRvIGFsc28gY3JlYXRlIHRo
ZQo+IHJlcXVpcmVkIGNvb2tpZS4KCklPTU1VX0RPTUFJTl9ETUEgc2hvdWxkIGJlIGEgZGlzYXN0
ZXIuIEl0IHNob3VsZG4ndCB3b3JrIHdpdGhvdXQKcHJlcGFyaW5nIERSTSBhbmQgVkRFIGRyaXZl
cnMgYXQgZmlyc3QuIFdlIGRpc2N1c3NlZCB0aGlzIGJyaWVmbHkgaW4gdGhlCnBhc3QuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
