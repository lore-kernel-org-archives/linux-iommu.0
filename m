Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50054C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 18:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D218640BF8;
	Fri, 17 Dec 2021 18:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GDpXJK6c8wYL; Fri, 17 Dec 2021 18:02:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A7315400CE;
	Fri, 17 Dec 2021 18:02:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A729C002F;
	Fri, 17 Dec 2021 18:02:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E91C6C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 18:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2ACF61139
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 18:02:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aQmMeR5KS641 for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 18:02:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A040461130
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 18:02:07 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id s1so5617892wrg.1
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 10:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oMu9apPBaIi5tnaaEn/7B+TGrd8QQOY69E+E1XVDBJI=;
 b=u8obK9JhZNYC3wIL8Po91CTQWuwxOBnIcJbv5lRvxq5bHRd0SauyN2ssBCCt9bKHnH
 hgojwD60Sedmm3a+k7NyFEhyKp95kPKbOSt0riIt+QdhnT3hJevxGCb/3+/AxtmMwR9e
 Uf2dgIzA3qStPcUqyLxvyxbGH+buoxZbkfFBesFiQ1wetFLxY3b4DxxFYY1OPUMGontn
 5USB/hXB6fJof8Dqad752EP2Ye1cloZuj8+3QBRwEeN7Q5MxpeatwxT5mJC6WsuqkcxM
 BCyoFmZ3Gz8LtgRvknJa/t2ghDqAIDWP/huzJWEqnJvSnWHKVwxeYTEZpOr09yh3CGtv
 Zlww==
X-Gm-Message-State: AOAM5328RiZ5FEKsj1fkU96UVmQwYE6iq3DlabJ02GC/ocVMUILnOkk1
 4ADFZ9/vYCmZ5ZPJkIKeQgE=
X-Google-Smtp-Source: ABdhPJxZW9VkgRs6Fqo+bYWZVKfD8ydQU1cDhNtoIVkXQmcCzITHgxDeT8/9Q5qOUz6j3QSv/dbrVg==
X-Received: by 2002:a5d:58f2:: with SMTP id f18mr3409586wrd.98.1639764125887; 
 Fri, 17 Dec 2021 10:02:05 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id d2sm7663606wmb.31.2021.12.17.10.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Dec 2021 10:02:05 -0800 (PST)
Date: Fri, 17 Dec 2021 18:02:03 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V7 0/5] x86/Hyper-V: Add Hyper-V Isolation VM
 support(Second part)
Message-ID: <20211217180203.sb4av3a7ezqmtvu6@liuwe-devbox-debian-v2>
References: <20211213071407.314309-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213071407.314309-1-ltykernel@gmail.com>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, hch@lst.de, linux-arch@vger.kernel.org, hch@infradead.org,
 wei.liu@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, michael.h.kelley@microsoft.com,
 mingo@redhat.com, kuba@kernel.org, jejb@linux.ibm.com, parri.andrea@gmail.com,
 thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com, arnd@arndb.de,
 konrad.wilk@oracle.com, haiyangz@microsoft.com, bp@alien8.de,
 tglx@linutronix.de, martin.petersen@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net
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

On Mon, Dec 13, 2021 at 02:14:01AM -0500, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
[...]
> 
> Tianyu Lan (5):
>   swiotlb: Add swiotlb bounce buffer remap function for HV IVM
>   x86/hyper-v: Add hyperv Isolation VM check in the cc_platform_has()
>   hyper-v: Enable swiotlb bounce buffer for Isolation VM
>   scsi: storvsc: Add Isolation VM support for storvsc driver
>   net: netvsc: Add Isolation VM support for netvsc driver
> 

Applied to hyperv-next. Thanks.

Wei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
