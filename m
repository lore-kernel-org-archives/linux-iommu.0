Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00A9C4346E
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 02:09:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0501B20888
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 02:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d3mPvSTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0501B20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AFEE48755A;
	Fri, 25 Sep 2020 02:09:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iztKRW314AnD; Fri, 25 Sep 2020 02:09:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CA34A87559;
	Fri, 25 Sep 2020 02:09:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A751FC0890;
	Fri, 25 Sep 2020 02:09:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B52AC0859
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 02:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 762428755A
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 02:09:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ACwBsYd2Xru9 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 02:09:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D551287559
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 02:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=J1HkhvmRiGdIYDPIe3gIfcnRgqplrWsR6CykG4Adksc=; b=d3mPvSTAi7fvnRqKXhBNzXRsaM
 ycQVuva54BLVbK8NHQsPGbesdSENi2vNdOYDP7qriVBwM7fPlJBdCB1WQwbvV9aqnC6X8CwfENqUI
 ieJlNmKP0M/Wj1c9l1Qe7yMbrE7FPagHqrAMjQKhpQFz41XyNFHGgZ7DPwya42caPAQW85dcd1R01
 plRtlL70tAFBhEZjXD9Mh71wSV1Go22qBW4qV2r3+GYuNY5ddi6AaNXXcyWu7i0KYygdtAStMni56
 FKh+7ev69YwgGHMkPqwI0rJpdgf8rbItRc8IdZWpiBx+Etv/c/VXkxTsOQVKPA420WiOXTQfXLdte
 UdgflFTw==;
Received: from [2601:1c0:6280:3f0::19c2]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLdAS-00033Q-49; Fri, 25 Sep 2020 02:09:00 +0000
Subject: Re: [PATCH 01/13] x86: Secure Launch Kconfig
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, 
 x86@kernel.org, iommu@lists.linux-foundation.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-2-git-send-email-ross.philipson@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <22ecb054-c340-cea7-7d80-28469fdcddc6@infradead.org>
Date: Thu, 24 Sep 2020 19:08:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1600959521-24158-2-git-send-email-ross.philipson@oracle.com>
Content-Language: en-US
Cc: dpsmith@apertussolutions.com, luto@amacapital.net, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, tglx@linutronix.de,
 trenchboot-devel@googlegroups.com
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

On 9/24/20 7:58 AM, Ross Philipson wrote:
> Initial bits to bring in Secure Launch functionality. Add Kconfig
> options for compiling in/out the Secure Launch code.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Hi,
from Documentation/process/coding-style.rst:

Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

> ---
>  arch/x86/Kconfig | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7101ac6..8957981 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1968,6 +1968,42 @@ config EFI_MIXED
>  
>  	   If unsure, say N.
>  
> +config SECURE_LAUNCH
> +	bool "Secure Launch support"
> +	default n
> +	depends on X86_64
> +	help
> +	   The Secure Launch feature allows a kernel to be loaded
> +	   directly through an Intel TXT measured launch. Intel TXT
> +	   establishes a Dynamic Root of Trust for Measurement (DRTM)
> +	   where the CPU measures the kernel image. This feature then
> +	   continues the measurement chain over kernel configuration
> +	   information and init images.
> +
> +choice
> +	prompt "Select Secure Launch Algorithm for TPM2"
> +	depends on SECURE_LAUNCH
> +
> +config SECURE_LAUNCH_SHA1
> +	bool "Secure Launch TPM1 SHA1"
> +	help
> +	   When using Secure Launch and TPM1 is present, use SHA1 hash
> +	   algorithm for measurements.
> +
> +config SECURE_LAUNCH_SHA256
> +	bool "Secure Launch TPM2 SHA256"
> +	help
> +	   When using Secure Launch and TPM2 is present, use SHA256 hash
> +	   algorithm for measurements.
> +
> +config SECURE_LAUNCH_SHA512
> +	bool "Secure Launch TPM2 SHA512"
> +	help
> +	   When using Secure Launch and TPM2 is present, use SHA512 hash
> +	   algorithm for measurements.
> +
> +endchoice
> +


thanks.
-- 
~Randy

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
