Return-Path: <SRS0=M8Ie=6R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D84C28CBC
	for <iommu@archiver.kernel.org>; Sun,  3 May 2020 19:20:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2336A206E9
	for <iommu@archiver.kernel.org>; Sun,  3 May 2020 19:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Hgghv2QJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2336A206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EB6E087849;
	Sun,  3 May 2020 19:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hE2A0otN6VaM; Sun,  3 May 2020 19:20:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D567E8770B;
	Sun,  3 May 2020 19:20:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC449C0176;
	Sun,  3 May 2020 19:20:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34897C0175
 for <iommu@lists.linux-foundation.org>; Sun,  3 May 2020 19:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0D01D2042D
 for <iommu@lists.linux-foundation.org>; Sun,  3 May 2020 19:20:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kIqufV7maNPS for <iommu@lists.linux-foundation.org>;
 Sun,  3 May 2020 19:20:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 808732034C
 for <iommu@lists.linux-foundation.org>; Sun,  3 May 2020 19:20:17 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id s30so12319880qth.2
 for <iommu@lists.linux-foundation.org>; Sun, 03 May 2020 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=QjQNTEl64oFXby2DcLfNG1WpAuKAiDgue7kNNdacJts=;
 b=Hgghv2QJ8bnac2HvY//5dPe+3V01b//VZCjt/zPRvjM7sm9jIt80ZBdVClOxnSjU7b
 ilPS4ugIYt9vvS3ClL6ewC4aYHioCOtQci7kozyJPcCscPNunCZ1xZGpaPUwCxyh68UB
 /W6ac3C32vabUS5BIBVUqp30Vbe+cmgOuFcl2d6uM6HzgCoM2WgAwnPmstT9c8WjC1a6
 FxSRnJkjQcEzCHZQER1maDAD1hqApgStExaPBxzTFvp+LcXmQPxxabiQ7pxrAqrDqVKy
 6eUsHobeZdKy6+X4fwTVOj8KYu8CGTQ/VnKnZVEf+WneJ6MX1uJT3/t+Jjm0FWo1l4mO
 VqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=QjQNTEl64oFXby2DcLfNG1WpAuKAiDgue7kNNdacJts=;
 b=dgBuy0FNjh9aT/uqjBQvosOGOPXX2rYoaRkXlaLM9o7XILwN2JnNQ215Bj2Ihm9m+u
 R5u8Zq6zfWf01BNSrVwzTAJL4UKKeXTMbfbqYVsNEEKssKFGFBi+r63zjB6mgDhSWVux
 TYYqI7LrRmAAkB2TBgzSuI6XBGZY1Q/9inZnuMP2k9nB7aLRdGWN8W1NJJJk3GOItiCo
 KnapDbN3X3A3zwIV0+o4v188QV/HDMMA2rOdsZKHMTPwJ/6n+jQrsGcVXUZCZsPg+hdn
 vOWZKWHg7OfvjUjTtwMK69UVpPXJlT2V6zWUnAxBR5H9T3R7KrLs0wtl6kc6X/psLiE/
 aynA==
X-Gm-Message-State: AGi0PuYV1QaMzu0opAMB49Wre0S1vHmHjuPe4Eew0V6TOcCPoFWJEPwc
 +ubCkmLXh1cUPUEzz11y1H5BMsIwo3X7Uw==
X-Google-Smtp-Source: APiQypJibEKO4v/ek1bD86VUTy9GbWtdTI0sl6Lx3Eq8OG4JLinle7zFyUbyOwqebbSWTG5eTbuyuQ==
X-Received: by 2002:a37:6dc4:: with SMTP id
 i187mr13342595qkc.358.1588533136798; 
 Sun, 03 May 2020 12:12:16 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id t15sm9023400qtc.64.2020.05.03.12.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 May 2020 12:12:16 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Date: Sun, 3 May 2020 15:12:15 -0400
Message-Id: <E18E118B-A79A-40A8-89D4-4B81C24FB486@lca.pw>
References: <20200503183927.GA18353@8bytes.org>
In-Reply-To: <20200503183927.GA18353@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
X-Mailer: iPhone Mail (17D50)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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



> On May 3, 2020, at 2:39 PM, Joerg Roedel <joro@8bytes.org> wrote:
> 
> Can I add your Tested-by when I
> send them to the mailing list tomorrow?

Sure. Feel free to add,

Tested-by: Qian Cai <cai@lca.pw>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
