Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1B4C433EF
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 22:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87AFC8299E;
	Tue,  4 Jan 2022 22:49:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2e6p2safw6un; Tue,  4 Jan 2022 22:49:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D58168297F;
	Tue,  4 Jan 2022 22:49:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A47E9C0030;
	Tue,  4 Jan 2022 22:49:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DFE5C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 22:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5949341528
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 22:49:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=shutemov-name.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d-DcyXIWQCz9 for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 22:49:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6CAA41522
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 22:49:22 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id i31so84860833lfv.10
 for <iommu@lists.linux-foundation.org>; Tue, 04 Jan 2022 14:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=iu6pMgsaiAu44E+2OXJWQ0LJVevpiS5oRRWe/pysqBs=;
 b=lYRkx/+cuh7fv6gFC6FZB+pxRB+YisfbUoXrFyvBr4yIhC9fW+BraFPouyhsd4X8mn
 CkkWsGFFTGPtq1tigglf9baLeESwQq5mLCt5ZgElDAgRb0hDXP5qrn9icNejg4radl3L
 b4Qx8TzN+tJSunkWUmUGZSUtdVAtBLKjKDBDZ6YtyqiM3LjRCiSZtsve6mJN6emucVHK
 x5ZtTlMytFCD15YvB8h9H0YgwHqqtxzMwXAkSQpdg9wZpFIi/HoFADawGCJOctpjsIvw
 /ivXtOV8iuof/Sv/Z8fHNTm9PdFK9FRkNl01pUrwzynOi1jzGdWX1DaLDqAccFhG+txd
 9+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=iu6pMgsaiAu44E+2OXJWQ0LJVevpiS5oRRWe/pysqBs=;
 b=u1H0FUrGmL4Gt0vejdMnkYa0iRV2IcwYHaKMLxVxwayC+2D37knvx18Dja7Oaf10Ky
 PxyV61L/VQcovCKCjG9CkBTo9UIS13truVsr5CfuNmlmf81FVjRA2pSlGtmGES8tBsE1
 +sKVXPbiRCXccQVabU857dE8jrE58kB6xH+UUdTX8RrZ/oiUICNi1pZTKcMpF/0mJrBg
 mJKpqW18tX8Uk3bQyJedJ4ecUDdYGBJlhn3J/9woVYNj1sPhgP08EyrSvF1r7rgj2qGO
 s82/QwmNEX5azY6tAIklvxZuJeJLK36jOMzbo99mTZ6PIvQzFsvNmLmrMkT7ZZS1rfzx
 FK8Q==
X-Gm-Message-State: AOAM532ZuTarYOjx7alDxEfxhL1WjFmbQGY3H7bxalclmn6W/Effc56S
 W6tbdKAHb9yyAtqJBwrjHUETTw==
X-Google-Smtp-Source: ABdhPJxNzz6eiviVRUkYCabpmzVVNcaszW0dNAAgv2rl2L9rdtElP7upE7G/Hnvpj0aJRdc9v4oV7Q==
X-Received: by 2002:a05:6512:31ce:: with SMTP id
 j14mr33412579lfe.95.1641336560819; 
 Tue, 04 Jan 2022 14:49:20 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id bq10sm1637433lfb.199.2022.01.04.14.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jan 2022 14:49:20 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
 id 1C429103147; Wed,  5 Jan 2022 01:49:39 +0300 (+03)
Date: Wed, 5 Jan 2022 01:49:39 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Memory clearing in swiotlb_update_mem_attributes()
Message-ID: <20220104224939.yhpceiuzqqhb72ql@box.shutemov.name>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org
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

Hi Tom,

For larger TDX VM, memset() after set_memory_decrypted() in
swiotlb_update_mem_attributes() takes substantial portion of boot time.

It makes me wounder why do we need it there? Malicious VMM can mess with
decrypted/shared buffer at any point and for normal use it will be
populated with real data anyway.

Can we drop it?

-- 
 Kirill A. Shutemov
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
