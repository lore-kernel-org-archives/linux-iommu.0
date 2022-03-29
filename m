Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90A6C433EF
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 09:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73A5B417C1;
	Tue, 29 Mar 2022 09:56:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5SOepA6DVaiL; Tue, 29 Mar 2022 09:56:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C92F40362;
	Tue, 29 Mar 2022 09:56:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6FB4C002C;
	Tue, 29 Mar 2022 09:56:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FC79C0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 06:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E4F1605A3
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 06:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gbf6v9NMFoaS for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 06:38:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8A88605A0
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 06:38:35 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id h19so14037570pfv.1
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 23:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=cih9eRaSIxbxmILbyn2YR4alicmKyfBJFHiUkf3CDZk=;
 b=mcH+8nMY6FAMeK9TDj5Og3uT7XJOfTq2a+8r/uAmhySpfieb2bx+P3UjRNU/mGrHss
 43KZkCTLh7Iovpi3+enSGNqZwJHmTniXBUGyOU+7swz9qxfCS950DYfTj+5jmQcLBMHM
 gG1Ju6nCyOUlLfeWpTUJ7iH2xc0wzlAd+0tsptRGA46pgcMONpp3iPYO19WbfEMHPX3u
 T25XLls5oIG6KtLY5EN0obzi24MtfEqgx+dJFIg/SO2m+bs4NmxpFFq2hwUvRGIa5lrN
 WRNDkmNFpgt05anwQfbcVHsbWBMJv5U3TjNuGDm0Dj2VEcapcdknVuaaiJRaRAWMxzGV
 dCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=cih9eRaSIxbxmILbyn2YR4alicmKyfBJFHiUkf3CDZk=;
 b=qX4hGq/12XAU8yneEHFAE77I8xLzZ+BimSyRZ+nWGd4+rbGMm2qzZ2qvJQKReXauW5
 QUT11xZM26DWLXbsa5d9HJ8HqPOf6tEOBUgOGc9nai5miUAWfLa3llieBW9wVxQ1vS7j
 CipWEZfmcuskI2S/4Hd0sgnl4KNICM1juMc+MS3BLd3kr4TDZ4vZbzo6G0BN0LKSEF83
 DoXfkJMlm/E1Tx+BnTk/g6XX4APYpQUtuLYooPw7IDrlb3WC04t4BUt6I9uPzhdHfljg
 nqS9ocZ9HRV10iyGk0n2i477uJHT1nblt6N9afnA4DZZ552pI0qIe8UC5s+VS2Ut7yZC
 cLnw==
X-Gm-Message-State: AOAM533QR+dMVuU2xosLteuQ4nN5ajz+3tcyQBchWRLTmzMFQY2+pNeX
 Rdn9ALVLLqPAL83QN1lTyvs=
X-Google-Smtp-Source: ABdhPJwW8ERIPKusBttDrjsrixouKMZeP5JnAJ4YeR9XngS5sp2SqudKSmkChfNpARzLmo8eQFWzSA==
X-Received: by 2002:a63:214c:0:b0:381:1a27:fe1 with SMTP id
 s12-20020a63214c000000b003811a270fe1mr918595pgm.328.1648535915132; 
 Mon, 28 Mar 2022 23:38:35 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-80.three.co.id.
 [180.214.232.80]) by smtp.gmail.com with ESMTPSA id
 96-20020a17090a09e900b001c6dc775159sm1504349pjo.46.2022.03.28.23.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Mar 2022 23:38:34 -0700 (PDT)
Message-ID: <57f74780-6520-f2a4-8551-74c4b0986ac6@gmail.com>
Date: Tue, 29 Mar 2022 13:38:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 2/2] Documentation: x86: Clarify Intel IOMMU
 documentation
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net, hpa@zytor.com, x86@kernel.org,
 dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
 tglx@linutronix.de, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 will@kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 vasant.hegde@amd.com
References: <20220328172829.718235-1-alexander.deucher@amd.com>
 <20220328172829.718235-3-alexander.deucher@amd.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220328172829.718235-3-alexander.deucher@amd.com>
X-Mailman-Approved-At: Tue, 29 Mar 2022 09:56:43 +0000
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 29/03/22 00.28, Alex Deucher wrote:
> Based on feedback from Robin on the initial AMD IOMMU
> documentation, fix up the Intel documentation to
> clarify IOMMU vs device and modern DMA API.
> 

Maybe we can squash into [1/2]?

-- 
An old man doll... just what I always wanted! - Clara
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
