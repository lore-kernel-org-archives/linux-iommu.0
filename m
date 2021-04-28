Return-Path: <SRS0=OzJ+=JZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73464C433ED
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 05:44:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A0A61418
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 05:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A0A61418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A36B140E6E;
	Wed, 28 Apr 2021 05:44:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ayTAfWqPOA3p; Wed, 28 Apr 2021 05:44:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 886DC403F5;
	Wed, 28 Apr 2021 05:44:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CF04C0022;
	Wed, 28 Apr 2021 05:44:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F86AC0001
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 05:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A7A3406B3
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 05:44:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i5Kxg7nMjff6 for <iommu@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 05:44:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA5F2403F5
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 05:44:20 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id d15so19614701ljo.12
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 22:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1k7FKuylro/MdHin/s1GOW9Q+rY4jUOQaUICOuYPze4=;
 b=cr1aEr2reV8+TrtPnP9Mnhg4n8ByFHpjf9dDcRkPwXhXtZdSWbJzDiax12pxODYJOg
 uyCYmBEueEg9jMtueYcf9bPsQajAst/8aLx2DSEYzaxCtwyDnkgb7t5KOAqHwJy4bQT3
 gFh+lBrp9wqW0aw3SDvRrRzEH/GPk0Oqtt7Hdhv1TDZ85RfHLO/BKrbica1ZRaVmoIrj
 fvw6kvo31LJa+FeT4OLm0//w8Ya3Uxxbgi1q4h0RYTn1VNlW7bnYsrSwA0C0PM0EKeyr
 j79Wm1q7orQo0B1ocb9GSZ4LzE3JFU8xQ8YgQ3vG7zGAmO1Np8JjOzoa84QBo9X9V4AX
 S41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1k7FKuylro/MdHin/s1GOW9Q+rY4jUOQaUICOuYPze4=;
 b=YUPy4DOMAmF7jz6DcPxc99OYlX6FkTCm+5Sq5dYnuSbOpa2xcLKGyHvRfiUHRpbck6
 r/nA9lH7mwYfeEIBQJXIPGfku4yHAQAfn1Ei40aH/oOvZKfx+V71mf7pmWFwWgdciDtq
 aVWMzYA/tZAQ5f/vpte0wVxBmkJ+G+Dp4JLWvo0rcaCpSK/ssk+hG9ACC5V41LEq2TD7
 yOdqb4QE1epYKVmhQdDciPRfx8zkJf6lGjOkUXUNX01npY3GDyRn8+xEscdUGmtXcZxR
 bNg2r/L+LO5hUci1ZJv/53HeOomeYLDeWCwv3JxGd37pZL6oVEeqdwFbZ2OZsJtxnYNe
 DvIA==
X-Gm-Message-State: AOAM531j2e++FDnPYxQOqTCtnge079iGZcUtpq9mdqIKDMlAfdIlu93e
 sCElvlaYGeloVmqA23xgvKQ=
X-Google-Smtp-Source: ABdhPJw6Ubpe6Dhe9FfCHgPaKhtZGS31CN0HVNX7YHMMh+X+ehbOWRUAG3ylFlAZBoR7AUi9nS6QBw==
X-Received: by 2002:a2e:1519:: with SMTP id s25mr19542043ljd.277.1619588658721; 
 Tue, 27 Apr 2021 22:44:18 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-102.dynamic.spd-mgts.ru.
 [109.252.193.102])
 by smtp.googlemail.com with ESMTPSA id 2sm914499ljf.61.2021.04.27.22.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Apr 2021 22:44:18 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] iommu: Support identity mappings of
 reserved-memory regions
To: Krishna Reddy <vdumpa@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <869ec3a2-26df-2ce8-bd21-b681d6ef3985@gmail.com>
 <BY5PR12MB3764DFDEA8125650799DC76CB3419@BY5PR12MB3764.namprd12.prod.outlook.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bbcf6dbe-367b-38b2-91bf-9d5f4cd2c57c@gmail.com>
Date: Wed, 28 Apr 2021 08:44:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB3764DFDEA8125650799DC76CB3419@BY5PR12MB3764.namprd12.prod.outlook.com>
Content-Language: en-US
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
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

MjcuMDQuMjAyMSAyMTozMCwgS3Jpc2huYSBSZWRkeSDQv9C40YjQtdGCOgo+PiBJcyBpdCBhbHdh
eXMgc2FmZSB0byBlbmFibGUgU01NVSBBU0lEIGluIGEgbWlkZGxlIG9mIGEgRE1BIHJlcXVlc3Qg
bWFkZSBieSBhCj4+IG1lbW9yeSBjbGllbnQ/Cj4gCj4gRnJvbSBNQyBwb2ludCBvZiB2aWV3LCBJ
dCBpcyBzYWZlIHRvIGVuYWJsZSBhbmQgaGFzIGJlZW4gdGhpcyB3YXkgZnJvbSBtYW55IHllYXJz
IGluIGRvd25zdHJlYW0gY29kZSBmb3IgZGlzcGxheSBlbmdpbmUuCj4gSXQgZG9lc24ndCBpbXBh
Y3QgdGhlIHRyYW5zYWN0aW9ucyB0aGF0IGhhdmUgYWxyZWFkeSBieXBhc3NlZCBTTU1VIGJlZm9y
ZSBlbmFibGluZyBTTU1VIEFTSUQuIAo+IFRyYW5zYWN0aW9ucyB0aGF0IGFyZSB5ZXQgdG8gcGFz
cyBTTU1VIHN0YWdlIHdvdWxkIGdvIHRocm91Z2ggU01NVSBvbmNlIFNNTVUgQVNJRCBpcyBlbmFi
bGVkIGFuZCB2aXNpYmxlLgoKSGVsbG8sCgpUaGFuayB5b3UgZm9yIHRoZSBhbnN3ZXIuIENvdWxk
IHlvdSBwbGVhc2UgZ2l2ZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0OgoKMSkgQXJlIHlvdSBvbiBz
b2Z0d2FyZSBvciBoYXJkd2FyZSB0ZWFtLCBvciBib3RoPwoKMikgSXMgU01NVSBhIHRoaXJkIHBh
cnR5IElQIG9yIGRldmVsb3BlZCBpbi1ob3VzZT8KCjMpIERvIHlvdSBoYXZlIGEgZGlyZWN0IGFj
Y2VzcyB0byBIREwgc291cmNlcz8gQXJlIHlvdSAxMDAlIHN1cmUgdGhhdApoYXJkd2FyZSBkb2Vz
IHdoYXQgeW91IHNheT8KCjQpIFdoYXQgaGFwcGVucyB3aGVuIENQVSB3cml0ZXMgdG8gQVNJRCBy
ZWdpc3Rlcj8gRG9lcyBTTU1VIHN0YXRlCm1hY2hpbmUgbGF0Y2ggQVNJRCBzdGF0dXMgKG1ha2lu
ZyBpdCB2aXNpYmxlKSBvbmx5IGF0IGEgc2luZ2xlICJzYWZlIiBwb2ludD8KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
