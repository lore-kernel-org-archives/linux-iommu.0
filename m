Return-Path: <SRS0=sT52=MQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA4C4320A
	for <iommu@archiver.kernel.org>; Sat, 24 Jul 2021 00:29:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CA960F41
	for <iommu@archiver.kernel.org>; Sat, 24 Jul 2021 00:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43CA960F41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C6AF6063A;
	Sat, 24 Jul 2021 00:29:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K1aTGcbHo87n; Sat, 24 Jul 2021 00:29:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F09CA605E6;
	Sat, 24 Jul 2021 00:29:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9145C001A;
	Sat, 24 Jul 2021 00:29:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 569BAC000E
 for <iommu@lists.linux-foundation.org>; Sat, 24 Jul 2021 00:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5185B4147E
 for <iommu@lists.linux-foundation.org>; Sat, 24 Jul 2021 00:29:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hwqGI6-YUPz9 for <iommu@lists.linux-foundation.org>;
 Sat, 24 Jul 2021 00:29:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7839A406B9
 for <iommu@lists.linux-foundation.org>; Sat, 24 Jul 2021 00:29:20 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id o13so3076428qkk.9
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qf6d8SRXv1lvTGNIT1Gr1+kbBtlMdmpvy2P7MIdCQCU=;
 b=NotMNJPtiWda/Z83VeqYVn1Tvo3zIyWM28lAJ03A1MtE75FbinSxcoodvtEZK3DPNo
 thZDa0pspMfmbugGk8QbOAzLK5xYC098P7RQXfaT8595umyyC7tlO501YAl9n0AnHW/y
 t2LUf5tWOx3Uq6uxM6qSKVAUu2gPKkFBNtqDDBZfOJiGTbai3n1UZy8rNkGMaX7b9Bwj
 STvudW9XdjlS3CzdLSXed+f0BwOCz1UB64k9V5R/uYF5wH4js11neBvELOCJDMjJuV3w
 IozLJRmet/NK+9joSIgOIvKw83lvXXsmWlJkCUbWDGOFHY4kK1oMqk7+ussjt6rKCVo+
 sZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=qf6d8SRXv1lvTGNIT1Gr1+kbBtlMdmpvy2P7MIdCQCU=;
 b=tcsmjGdvsE1IRsTvkUndHbJnz2OW/wpZoPQoBxxz/vOyj3VbXWxb7NUBhopP0l2Ixo
 Frjzm/xWWCZtcaWs2fUvtzyyZOJ2fP0iTBv+2w4/+eV4D8rm8u2lj0HOM7P1MVu2Ew1h
 t4JGS57BTSoe5C72glPTqK05ZFEC8cBky1xa6VHP6sevZIolQNMgeM3Tc7bXiM7/Woan
 r4VFPNMIuOer8WAfKb2neoiar+WSWyP1x7Sn8IyG4Ozq+qsluFXbLfdTnPPqgyd9l05K
 2zXnLj7fve3YsBvLF5GpatqGMYU/JeeuAnFhixPNEvfQYV5mGUoPe5azuvWRJ5bOIb0g
 v5BQ==
X-Gm-Message-State: AOAM5304WRrRrqi3++cqTFoCabmaZ/xPgU1UUyE2w67t0kYBevbsary+
 +kw9LsAxoR5tzDt6LIQUIDQ=
X-Google-Smtp-Source: ABdhPJyMLqR3nayBDmkd63sKrmioXTMGScqttjDSlSqS/KFNaC/c42XefEHO1dentzlT5yAG7r/yVA==
X-Received: by 2002:a05:620a:2fb:: with SMTP id
 a27mr7121715qko.279.1627086559400; 
 Fri, 23 Jul 2021 17:29:19 -0700 (PDT)
Received: from fedora ([130.44.160.152])
 by smtp.gmail.com with ESMTPSA id x23sm1041976qkf.36.2021.07.23.17.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 17:29:19 -0700 (PDT)
Date: Fri, 23 Jul 2021 20:29:16 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 0/4] Fix restricted DMA vs swiotlb_exit()
Message-ID: <YPte3K+4PPjGAQt/@fedora>
References: <20210720133826.9075-1-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210720133826.9075-1-will@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 iommu@lists.linux-foundation.org, Claire Chang <tientzu@chromium.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
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

On Tue, Jul 20, 2021 at 02:38:22PM +0100, Will Deacon wrote:
> Hi again, folks,
> 
> This is version two of the patch series I posted yesterday:
> 
>   https://lore.kernel.org/r/20210719123054.6844-1-will@kernel.org
> 
> The only changes since v1 are:
> 
>   * Squash patches 2 and 3, amending the commit message accordingly
>   * Add Reviewed-by and Tested-by tags from Christoph and Claire (thanks!)
> 
> I'd usually leave it a bit longer between postings, but since this fixes
> issues with patches in -next I thought I'd spin a new version immediately.

Thank you!

I put them in devel/for-linus-5.15 and linux-next.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
